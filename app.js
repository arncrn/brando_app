const config = require("./lib/config");
const express = require('express');
const exphbs = require('express-handlebars');
const multer = require('multer');
const session = require("express-session");
const store = require("connect-loki");
const pgPersistence = require('./lib/pg-persistence.js');
const buildFilterString = require('./lib/build-filter-string.js');
const formatDate = require('./lib/format-date.js')
const capitalize = require('./lib/capitalize.js');
const dataApp = new pgPersistence();
const port = config.PORT;
const host = config.HOST;

const aws = require('aws-sdk');
const AWS_BUCKET = config.AWS_BUCKET;
aws.config.region = 'us-west-1'

const app = express();
const LokiStore = store(session);

const path = require("path");
const { url } = require("inspector");

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
  secret: config.SECRET,
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


//====================================Log in===================================

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


//====================================receipts===================================

app.get("/receipts", requiresAuthentication, (req, res) => {
  res.render('receipt-home');
})

app.get("/receipts/view", requiresAuthentication, async (req, res) => {
  let receipts = await dataApp.getReceipts();
  let items = await dataApp.getAllItems();

  receipts.forEach(receipt => {
    itemsInReceipt = items.filter(item => item.receipt_id === receipt.id)
    receipt.number_of_items = itemsInReceipt.length;
    receipt.total_price = itemsInReceipt.reduce((sum, item) => {
      return sum + (((+receipt.tax / 100) * +item.purchase_price) + +item.purchase_price)
    }, 0).toFixed(2);

    if (receipt.purchase_date) {
      receipt.purchase_date = receipt.purchase_date.toDateString();
    }
  })

  res.render("receipts", {
    receipts,
  })
})


app.get("/receipts/view/:receiptId", requiresAuthentication, async (req, res) => {
  const receiptId = req.params.receiptId;
  const receipt = await dataApp.findReceiptById(receiptId);
  
  let items = (await dataApp.getReceiptItems(receiptId)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, {total_price: totalPrice});
  });
  res.render('clothing', {
    items: items,
    filters: [receiptId, receipt.store],
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

})

app.get("/receipts/add", requiresAuthentication, (req, res) => {
  res.render("create-receipt");
})

app.post("/receipts/add", upload.none(), requiresAuthentication, async (req, res) => {
  const receiptData = req.body;
  for (key in receiptData) {
    receiptData[key] = receiptData[key] || null;
  }

  const createdReceipt = await dataApp.createReceipt(receiptData);

  if (createdReceipt) {
    res.redirect("/receipts/view");
  } else {
    res.render("create-receipt");
  }
})

app.get("/receipts/edit/:receiptId", requiresAuthentication, async (req, res) => {
  let receiptId = req.params.receiptId;
  let receipt = await dataApp.findReceiptById(receiptId);
  if (receipt.purchase_date) {
    receipt.purchase_date = formatDate(receipt.purchase_date.toLocaleDateString());
  }

  res.render("partials/receipt-row", {
    layout: false,
    receipt: receipt
  });
})

app.post("/receipts/edit/:receiptId", requiresAuthentication, async(req, res) => {
  let receiptId = req.params.receiptId;
  console.log(req.body);
  let successfulUpdate = await dataApp.updateReceipt(req.body);
  if (successfulUpdate) {
    let receipt = await dataApp.findReceiptById(receiptId);
    let itemsOnReceipt = await dataApp.getReceiptItems(receiptId);

    receipt.total_price = itemsOnReceipt.reduce((sum, item) => {
      return sum + (((+receipt.tax / 100) * +item.purchase_price) + +item.purchase_price)
    }, 0).toFixed(2);
    
    receipt.number_of_items = itemsOnReceipt.length;

    if (receipt.purchase_date) {
      receipt.purchase_date = receipt.purchase_date.toDateString();
    }

    res.render(`partials/edited-receipt-row`, {
      layout: false,
      receipt: receipt,
    })
  }
})

//====================================packages===================================

app.get("/packages", requiresAuthentication, (req, res) => {
  res.render('package-home');
})

app.get("/packages/view", requiresAuthentication, async (req, res) => {
  let pkgs = await dataApp.getPackages();
  let items = await dataApp.getAllItems();
  let pricePerItemCollection = [];
  let totalShippingCost = 0;

  pkgs.forEach(pkg => {
    itemsInPackage = items.filter(item => item.package_id === pkg.id)

    if (Number(pkg.price) && itemsInPackage.length > 0) {
      let pricePerItem = (+pkg.price / itemsInPackage.length)
      pkg.price_per_item = pricePerItem.toFixed(2)
      pricePerItemCollection.push(pricePerItem);
    } else {
      pkg.price_per_item = (0).toFixed(2);
    }

    if (Number(pkg.price) > 0) {
      totalShippingCost += Number(pkg.price);
    }
    
    pkg.item_count = itemsInPackage.length;
    if (pkg.date_sent) {
      pkg.date_sent = pkg.date_sent.toDateString();
    }
  })

  averagePricePerItem = (pricePerItemCollection.reduce((sum, price) => {
    return sum + price;
  }, 0)) / pricePerItemCollection.length;

  res.render("packages", {
    pkgs,
    totalShippingCost: totalShippingCost.toFixed(2),
    averagePricePerItem: averagePricePerItem.toFixed(2)
  })
})

app.get("/packages/view/:pkgId", requiresAuthentication, async (req, res) => {
  const pkgId = req.params.pkgId;
  const pkg = await dataApp.findPackageById(pkgId);
  
  let items = (await dataApp.getPackageItems(pkgId)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, {total_price: totalPrice});
  });
  res.render('clothing', {
    items: items,
    filters: [pkg.package_name],
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

})

app.get("/packages/add", requiresAuthentication, (req, res) => {
  res.render("create-package")
})

app.post("/packages/add", upload.none(), requiresAuthentication, async (req, res) => {
  const packageData = req.body;
  for (key in packageData) {
    packageData[key] = packageData[key] || null;
  }

  const createdPackage = await dataApp.createPackage(packageData);

  if (createdPackage) {
    res.redirect("/packages/view");
  } else {
    res.render("create-package");
  }
})

app.get("/packages/edit/:pkgId", requiresAuthentication, async (req, res) => {
  let pkgId = req.params.pkgId;
  let pkg = await dataApp.findPackageById(pkgId);
  if (pkg.date_sent) {
    pkg.date_sent = formatDate(pkg.date_sent.toLocaleDateString());
  }

  res.render("partials/package-row", {
    layout: false,
    pkg: pkg
  });
})

app.post("/packages/edit/:pkgId", requiresAuthentication, async(req, res) => {
  let pkgId = req.params.pkgId;
  let successfulUpdate = await dataApp.updatePackage(req.body);
  if (successfulUpdate) {
    let pkg = await dataApp.findPackageById(pkgId);
    let itemsInPackage = await dataApp.getPackageItems(pkgId);

    pkg.price_per_item = pkg.price && itemsInPackage.length > 0
      ? (+pkg.price / itemsInPackage.length).toFixed(2)
      : 0;
    
    pkg.item_count = itemsInPackage.length;

    if (pkg.date_sent) {
      pkg.date_sent = pkg.date_sent.toDateString();
    }

    res.render(`partials/edited-package-row`, {
      layout: false,
      pkg: pkg,
    })
  }
})

app.get("/packages/print/:pkgId", requiresAuthentication, async (req, res) => {
  const pkgId = req.params.pkgId;
  const pkg = await dataApp.findPackageById(pkgId);
  const items = await dataApp.getPackageItems(pkgId);

  const pricePerItem = pkg.price && items.length > 0
      ? (+pkg.price / items.length).toFixed(2)
      : 0;

  res.render("print-package", {
    layout: false,
    pkg,
    pricePerItem,
  })
})

app.get('/api/packageitems/:pkgId', async (req, res) => {
  const pkgId = req.params.pkgId;
  const items = await dataApp.getPackageItems(pkgId);
  // const receipts = await dataApp.getReceipts();
  let sumOfItems = 0;

  items.forEach(item => {
    item.tax = +item.tax || 8;
    let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
    let totalPrice = taxAmount + Number(item.purchase_price);
    item.total_price = totalPrice.toFixed(2);
    item.tax_amount = taxAmount.toFixed(2);
    sumOfItems += totalPrice;
  })

  res.json({
    items: items,
    sumOfItems: sumOfItems.toFixed(2),
  })
})




//====================================items===================================

// for uploading images to amazon'a aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
//working
app.get(`/sign-s3`, (req, res) => {
  console.log(req.query)
  const s3 = new aws.S3();
  const fileName = req.query['file-name'];
  const fileType = req.query['file-type'];
  const s3Params = {
    Bucket: AWS_BUCKET,
    Key: fileName,
    Expires: 60,
    ContentType: fileType,
    ACL: 'public-read'
  };

  s3.getSignedUrl('putObject', s3Params, (err, data) => {
    if (err) {
      console.log(err);
      return res.end();
    }
    const returnData = {
      signedRequest: data,
      url: `https://${AWS_BUCKET}.s3.amazonaws.com/${fileName}`
    }
    res.send(JSON.stringify(returnData));
    // res.end();
  })
})

app.post('/newitem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  let dataObj = req.body;
  // if (req.file) {
  //   let file = req.file;
  //   dataObj.picture = file.originalname;
  // }
  if (dataObj.picture) {
    console.log("before:", dataObj.picture)
    let urlParts = dataObj.picture.split("/");
    let formattedImgName = urlParst[url.length - 1];
    console.log("after:", formattedImgName);
    dataObj.picture = formattedImgName;
  }
  

  for(prop in dataObj) {
    if (dataObj[prop] === '') {
      dataObj[prop] = null;
    } else if (prop !== "extra_info" && prop !== 'gender' && prop !== 'location' && prop !== 'picture') {
      dataObj[prop] = capitalize(dataObj[prop]);
    } else if (prop == "size") {
      dataObj[prop] = dataObj[prop].toUpperCase();
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
  console.log(config.HOST);
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