const express = require('express');
const exphbs = require('express-handlebars');
const multer = require('multer');
const session = require("express-session");
const store = require("connect-loki");
const pgPersistence = require('./lib/pg-persistence.js');
const buildFilterString = require('./lib/build-filter-string.js');
const capitalize = require('./lib/capitalize.js');
const dataApp = new pgPersistence();
const port = 5000;

const app = express();
const LokiStore = store(session);

const path = require("path");

let storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname + '/public/images/clothing'));
  },
  filename: function (req, file, cb) {
    if (file) {
      cb(null, file.originalname);
    } 
  }
})

const upload = multer({
  storage: storage,
});

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');


app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(session({
  cookie: {
    httpOnly: true,
    maxAge: 31 * 24 * 60 * 60 * 1000,
    path: "/",
    secure: false,
  },
  name: "brandomania-session-id",
  resave: false,
  saveUninitialized: true,
  secret: "not very secret",
  store: new LokiStore({}),
}));

app.use((req, res, next) => {
  res.locals.signedIn = req.session.signedIn;
  next();
})

const requiresAuthentication = (req, res, next) => {
  if (!res.locals.signedIn) {
    console.log("Unauthorized");
    res.status(401).send("Unauthorized")
  } else {
    next();
  }
}

app.get('/', (req, res) => {
  if (res.locals.signedIn) {
    res.redirect('/clothing');
  } else {
    res.redirect('/login')
  }
});

app.get('/login', (req, res) => {
  if (res.locals.signedIn) {
    res.redirect('/clothing');
  } else {
    res.render('layouts/login', {
      layout: null,
    })
  }
})

app.post('/login', async (req, res) => {
  let username = req.body.username.toLowerCase();
  let password = req.body.password;
  let loggedInSuccess = await dataApp.authenticate(username, password);

  if (loggedInSuccess) {
    // req.session.username = username;
    req.session.signedIn = true;
    res.redirect('/clothing');
  } else {
    res.render('layouts/login', {layout: null});
  }
})

app.post('/newitem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  let dataObj = req.body;
  if (req.file) {
    let file = req.file;
    dataObj.picture = file.originalname;
  }

  for(prop in dataObj) {
    if (dataObj[prop] === '') {
      dataObj[prop] = null;
    } else if (prop !== "extra_info" && prop !== 'gender' && prop !== 'location' && prop !== 'picture') {
      dataObj[prop] = capitalize(dataObj[prop]);
    }
  }

  let itemId = await dataApp.createItem(dataObj);

  if (itemId) {
    let item = await dataApp.findItemById(itemId);
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    Object.assign(item, {total_price: totalPrice});

    res.render('partials/item-structure', {
      layout: 'item-structure-wrapper',
      id: itemId,
      item: item,
      helpers: {
        greaterThanZero: function (soldPrice) {
          return +soldPrice > 0;
        },
        isArray: function(element) {
          return Array.isArray(element);
        },
        joinArray: function(element) {
          return element.join(', ');
        },
        isForMen: function(gender) {
          return gender == 'men';
        }
      }
    });
  }
})

app.get('/item/:itemId', requiresAuthentication, async (req, res) => {
  let id = req.params.itemId;
  let item = await dataApp.findItemById(id);
  let brands = await dataApp.getBrands();
  let types = await dataApp.getTypes();
  let receipt = await dataApp.findReceiptById(item.receipt_id) || {};
  let package = await dataApp.findPackageById(item.package_id) || {};
  let order = await dataApp.findOrderById(item.order_id) || {};
  let customer = await dataApp.findCustomerById(order.customer_id) || {};
  let packageItems = await dataApp.getPackageItems(item.package_id);
  let shippingCost = ((+package.price / packageItems.length) || 0).toFixed(2);

  item.tax_percent = +receipt.tax || 8;
  item.tax_amount = +((item.tax_percent / 100) * +item.purchase_price).toFixed(2);
  item.total_price = (+item.purchase_price + item.tax_amount).toFixed(2);
  item.purchase_date = receipt.purchase_date ? 
                       new Date(receipt.purchase_date).toLocaleDateString() : 
                       new Date(item.date_created).toLocaleDateString();
  if (!(+item.shipping_cost)) {
    item.shipping_cost = shippingCost;
  }

  item.sold_price_uah = ((+item.sold_price || 0) * 28.6).toFixed(2);
  item.location = item.location || package.location;
  item.package_name = package.package_name;
  item.customer_name = customer.name;
  res.render('item-popup', {
    layout: false,
    item: item,
    brands: brands,
    types: types,
    itemId: id,
    helpers: {
      isForMen: function (gender) {
        return gender === 'men';
      },
      isTraveling: function(location) {
        return location === 'traveling'
      }, 
      isInUkraine: function(location) {
        if (!location) return false;
        return location.toLowerCase() === 'ukraine';
      },
    }
  })
});

app.post('/edititem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  //working
  let dataObj = req.body;
  let itemId = dataObj.id;
  if (req.file) {
    console.log(req.file);
    let file = req.file;
    dataObj.picture = file.originalname;
  }

  for (prop in dataObj) {
    if (['purchase_price', 'shipping_cost', 'sold_price'].includes(prop)) {
      let regex = /[^0-9.]/g;
      dataObj[prop] = dataObj[prop].replace(regex, '');
    }
  }

  for(prop in dataObj) {
    if (dataObj[prop] === '') {
      dataObj[prop] = null;
    } else if (prop !== "extra_info" && prop !== 'gender' && prop !== 'location' && prop !== 'picture') {
      dataObj[prop] = capitalize(dataObj[prop]);
    }
  }

  let successfulDatabaseUpdate = await dataApp.updateItem(itemId, dataObj);

  if (successfulDatabaseUpdate) {
    let item = await dataApp.findItemById(itemId);
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    Object.assign(item, {total_price: totalPrice});
    res.render('partials/item-structure', {
      layout: false,
      item: item,
      helpers: {
        greaterThanZero: function (soldPrice) {
          return +soldPrice > 0;
        },
        isArray: function(element) {
          return Array.isArray(element);
        },
        joinArray: function(element) {
          return element.join(', ');
        },
        isForMen: function(gender) {
          return gender == 'men';
        }
      }
    });
  }
})

app.post('/duplicateitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let duplicateId = await dataApp.duplicateItem(itemId);

  if (duplicateId) {
    let item = await dataApp.findItemById(duplicateId);
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    Object.assign(item, {total_price: totalPrice});
    res.render('partials/item-structure', {
      layout: 'item-structure-wrapper',
      id: item.id,
      item: item,
      helpers: {
        greaterThanZero: function (soldPrice) {
          return +soldPrice > 0;
        },
        isArray: function(element) {
          return Array.isArray(element);
        },
        joinArray: function(element) {
          return element.join(', ');
        },
        isForMen: function(gender) {
          return gender == 'men';
        }
      }
    });
  } else {
    res.status(404);
  }
})

app.get('/findtag', requiresAuthentication, async (req, res) => {
  let tagNumber = req.query.tagNumber;
  let items = await dataApp.findItemsByTag(tagNumber);

  items = items.map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, {total_price: totalPrice});
  });
  res.render('clothing', {
    items: items,
    filters: req.query,
    helpers: {
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function(element) {
        return Array.isArray(element);
      },
      joinArray: function(element) {
        return element.join(', ');
      },
      isForMen: function(gender) {
        return gender == 'men';
      }
    }
  });
});

app.post('/deleteitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let deleted = await dataApp.deleteItem(itemId);
  if (deleted) {
    res.status(200).send('OK');
  } else {
    res.status(404).send('Could not delete');
  }
})

app.get("/clothing", requiresAuthentication, (req, res) => {
  res.render('home');
}); 

app.get("/clothing/view", requiresAuthentication, (req, res) => {
  res.render('gender-select');
});

app.get("/view/:gender", requiresAuthentication, async (req, res, next) => {
  let gender = req.params.gender;
  let items;

  switch (gender) {
    case 'women': items = await dataApp.getWomensClothing();
      break;
    case 'men': items = await dataApp.getMensClothing();
      break;
    case 'all': items = await dataApp.getAllItems();
      break;
  }

  let brandItems = dataApp.filterForBrands(items)
  let typeItems = dataApp.filterForTypes(items);
  let colorsItems = dataApp.filterForColors(items);
  let sizeItems = dataApp.filterForSizes(items);
  let locationItems = dataApp.filterForLocations(items);

  res.render('detail-select', {
    brandItems: brandItems,
    typeItems: typeItems,
    colorsItems: colorsItems,
    sizeItems: sizeItems,
    locationItems: locationItems,
    gender: gender
  });
});

app.get("/view/:gender/filtered", requiresAuthentication, async (req, res) => {
  let queryObj = req.query;
  let gender = req.params.gender;

  app.locals.queryParams = queryObj;
  let filterString = buildFilterString(queryObj, gender);
  console.log('line 305', filterString);
  let items = (await dataApp.getFilteredItems(filterString)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, {total_price: totalPrice});
  });
  res.render('clothing', {
    items: items,
    filters: queryObj,
    helpers: {
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function(element) {
        return Array.isArray(element);
      },
      joinArray: function(element) {
        return element.join(', ');
      },
      isForMen: function(gender) {
        return gender == 'men';
      }
    }
  });
});

app.get("/clothing/add", requiresAuthentication, async (req, res) => {
  let brands = await dataApp.getBrands();
  let types = await dataApp.getTypes();
  res.render('create-item', {
    brands,
    types
  });
})


app.listen(port, () => {
  console.log(`App running on port ${port}`);
});






// Function for getting breadcrumbs of the page
// function getBreadcrumbs(req, res, next) {
//   const urls = req.originalUrl.split('/');
//   urls.shift();
//   req.breadcrumbs = urls.map((url, i) => {
//     return {s
//       breadcrumbName: (url === '' ? 'Home' : url.charAt(0).toUpperCase() + url.slice(1)),
//       breadcrumbUrl: `/${urls.slice(0, i + 1).join('/')}`,
//     };
//   });
//   next();
// }