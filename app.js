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
const processImage = require('./lib/process-image.js');
const { ConfigurationOptions } = require("aws-sdk");
const dataApp = new pgPersistence();
const port = config.PORT;
const host = config.HOST;

const UAH_CONVERSION = 28;

// const aws = require('aws-sdk');
// const AWS_BUCKET = config.AWS_BUCKET;
// aws.config.region = 'us-west-1'

const app = express();
const LokiStore = store(session);

// const path = require("path");

// let storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, path.join(__dirname + '/public/images/clothing'));
//   },
//   filename: function (req, file, cb) {
//     if (file) {
//       cb(null, file.originalname);
//     }
//   }
// })

const storage = multer.memoryStorage();

const upload = multer({
  storage: storage,
});

const returnUpdatedItem = async (res, itemId) => {
  let item = await dataApp.findItemById(itemId);
  let taxPercent = item.tax || 8;
  let taxAmount = +item.purchase_price * (taxPercent / 100);
  let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
  Object.assign(item, { total_price: totalPrice });
  res.render('partials/item-structure', {
    layout: false,
    item: item,
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
        return gender == 'men';
      }
    }
  });
}

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
    res.render('layouts/login', { layout: null });
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
    return Object.assign(item, { total_price: totalPrice });
  });
  res.render('clothing', {
    items: items,
    filters: [receiptId, receipt.store],
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
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

app.post("/receipts/edit/:receiptId", requiresAuthentication, async (req, res) => {
  let receiptId = req.params.receiptId;

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

app.get("/singlepackage/:pkgId", requiresAuthentication, async (req, res) => {
  let pkgId = req.params.pkgId;
  let pkg = await dataApp.findPackageById(pkgId);

  res.send(pkg);
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
    return Object.assign(item, { total_price: totalPrice });
  });
  res.render('clothing', {
    items: items,
    filters: [pkg.package_name],
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
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

app.post("/packages/edit/:pkgId", requiresAuthentication, async (req, res) => {
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
  const pkg = await dataApp.findPackageById(pkgId);
  const items = await dataApp.getPackageItems(pkgId);
  // const receipts = await dataApp.getReceipts();
  let sumOfItems = 0;
  let totalShipping = 0;
  let pricePerItem = (Number(pkg.price) / items.length).toFixed(2);

  items.forEach(item => {
    item.tax = +item.tax || 8;
    let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
    let totalPrice = taxAmount + Number(item.purchase_price);
    item.total_price = totalPrice.toFixed(2);
    item.tax_amount = taxAmount.toFixed(2);
    item.shipping_cost = item.shipping_cost || pricePerItem;
    totalShipping += Number(item.shipping_cost);
    sumOfItems += totalPrice;
  })

  res.json({
    items: items,
    sumOfItems: sumOfItems.toFixed(2),
    totalShipping: totalShipping.toFixed(2)
  })
})



//====================================orders===================================

app.get("/orders", requiresAuthentication, (req, res) => {
  res.render('order-home');
})

app.get("/orders/view", requiresAuthentication, async (req, res) => {
  let orders = await dataApp.getOrders();
  let items = await dataApp.getAllItems();
  let pkgs = await dataApp.getPackages();
  let pkgPrices = {};
  let totalCogs = 0;
  let totalRevenue = 0;
  let totalProfit = 0;

  // orders.sort((a, b) => {
  //   if (a.name > b.name) return 1;
  //   if (a.name < b.name) return -1;
  //   return 0;
  // })

  pkgs.forEach(pkg => {
    itemsInPackage = items.filter(item => item.package_id === pkg.id)

    if (Number(pkg.price) && itemsInPackage.length > 0) {
      let pricePerItem = (+pkg.price / itemsInPackage.length)
      pkgPrices[pkg.id] = pricePerItem.toFixed(2);
    }
  })

  orders.forEach(order => {
    if (order.date_sent) order.date_sent = formatDate(order.date_sent.toLocaleDateString())
    order.tax_total = 0;
    order.shipping_total = 0;
    order.base_cost = 0;
    order.sold_total = 0;
    order.cogs = 0;
    order.total_profit = 0;

    itemsInOrder = items.filter(item => item.order_id === order.id);
    order.item_count = itemsInOrder.length;
    itemsInOrder.forEach(item => {
      item.tax = +item.tax || 8;
      let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
      let shippingCost = Number(item.shipping_cost) || (Number(pkgPrices[item.package_id]) || 0);
      let cogs = (taxAmount + shippingCost + Number(item.purchase_price));
      let profit = (Number(item.sold_price) - cogs)

      order.tax_total += taxAmount;
      order.shipping_total += shippingCost;
      order.base_cost += Number(item.purchase_price);
      order.sold_total += Number(item.sold_price) || 0;
      order.cogs += cogs;
      order.total_profit += profit;

      totalCogs += cogs;
      totalRevenue += Number(item.sold_price) || 0;
      totalProfit += profit;
    })

    order.tax_total = order.tax_total.toFixed(2);
    order.shipping_total = order.shipping_total.toFixed(2);
    order.base_cost = order.base_cost.toFixed(2);
    order.sold_total = order.sold_total.toFixed(2);
    order.cogs = order.cogs.toFixed(2);
    order.total_profit = order.total_profit.toFixed(2);
  })


  res.render("orders", {
    orders,
    totalRevenue: totalRevenue.toFixed(2),
    totalCogs: totalCogs.toFixed(2),
    totalProfit: totalProfit.toFixed(2),
  })
})

app.get("/orders/print/:orderId", requiresAuthentication, async (req, res) => {
  const orderId = req.params.orderId;
  const order = await dataApp.findOrderById(orderId);
  const customer = await dataApp.findCustomerById(order.customer_id);
  const orderItems = await dataApp.getOrderItems(orderId);
  const items = await dataApp.getAllItems();
  let pkgs = await dataApp.getPackages();
  let pkgPrices = {};

  order.name = customer.name
  order.revenue = 0;
  order.cogs = 0;
  order.profit = 0;


  pkgs.forEach(pkg => {
    itemsInPackage = items.filter(item => item.package_id === pkg.id)

    if (Number(pkg.price) && itemsInPackage.length > 0) {
      let pricePerItem = (+pkg.price / itemsInPackage.length)
      pkgPrices[pkg.id] = pricePerItem.toFixed(2);
    }
  })

  orderItems.forEach(item => {
    item.tax = +item.tax || 8;
    let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
    let shippingCost = Number(item.shipping_cost) || (Number(pkgPrices[item.package_id]) || 0);
    let cogs = (taxAmount + shippingCost + Number(item.purchase_price));
    order.cogs += cogs;
    order.profit += (Number(item.sold_price) - cogs);
    order.revenue += Number(item.sold_price);
  });

  order.cogs = order.cogs.toFixed(2);
  order.profit = order.profit.toFixed(2);
  order.revenue = order.revenue.toFixed(2);

  res.render("print-order", {
    layout: false,
    order
  })
})

app.get("/orders/view/:orderId", requiresAuthentication, async (req, res) => {
  const orderId = req.params.orderId;
  const order = await dataApp.findOrderById(orderId);

  let items = (await dataApp.getOrderItems(orderId)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, { total_price: totalPrice });
  });
  res.render('clothing', {
    items: items,
    filters: [order.customer_id, order.name],
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
        return gender == 'men';
      }
    }
  });

})

app.get("/orders/add", requiresAuthentication, (req, res) => {
  res.render("create-order");
})

app.post("/orders/add", upload.none(), requiresAuthentication, async (req, res) => {
  const orderData = req.body;
  for (key in orderData) {
    orderData[key] = orderData[key] || null;
  }

  const createdOrder = await dataApp.createOrder(orderData);

  if (createdOrder) {
    res.redirect("/orders/view");
  } else {
    res.render("create-order");
  }
})

app.get("/orders/edit/:orderId", requiresAuthentication, async (req, res) => {
  let orderId = req.params.orderId;
  let order = await dataApp.findOrderById(orderId);
  if (order.date_sent) {
    order.date_sent = formatDate(order.date_sent.toLocaleDateString());
  }

  res.render("partials/order-row", {
    layout: false,
    order: order
  });
})

app.post("/orders/edit/:orderId", requiresAuthentication, async (req, res) => {
  let orderId = req.params.orderId;
  let successfulUpdate = await dataApp.updateOrder(req.body);

  if (successfulUpdate) {
    let order = await dataApp.findOrderById(orderId);
    order.tax_total = 0;
    order.shipping_total = 0;
    order.base_cost = 0;
    order.sold_total = 0;
    order.cogs = 0;
    order.total_profit = 0;
    let itemsInOrder = await dataApp.getOrderItems(orderId);

    let items = await dataApp.getAllItems();
    let pkgs = await dataApp.getPackages();
    let pkgPrices = {};


    pkgs.forEach(pkg => {
      itemsInPackage = items.filter(item => item.package_id === pkg.id)

      if (Number(pkg.price) && itemsInPackage.length > 0) {
        let pricePerItem = (+pkg.price / itemsInPackage.length)
        pkgPrices[pkg.id] = pricePerItem.toFixed(2);
      }
    })

    itemsInOrder.forEach(item => {
      item.tax = +item.tax || 8;
      let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
      let shippingCost = Number(pkgPrices[item.package_id]) || 0
      let cogs = (taxAmount + shippingCost + Number(item.purchase_price));
      let profit = (Number(item.sold_price) - cogs)

      order.tax_total += taxAmount;
      order.shipping_total += shippingCost;
      order.base_cost += Number(item.purchase_price);
      order.sold_total += Number(item.sold_price) || 0;
      order.cogs += cogs;
      order.total_profit += profit;
    })

    order.item_count = itemsInOrder.length;

    if (order.date_sent) {
      order.date_sent = order.date_sent.toDateString();
    }

    order.tax_total = order.tax_total.toFixed(2);
    order.shipping_total = order.shipping_total.toFixed(2);
    order.base_cost = order.base_cost.toFixed(2);
    order.sold_total = order.sold_total.toFixed(2);
    order.cogs = order.cogs.toFixed(2);
    order.total_profit = order.total_profit.toFixed(2);

    res.render(`partials/edited-order-row`, {
      layout: false,
      order: order,
    })
  }
})


app.get('/api/orderitems/:orderId', async (req, res) => {
  const orderId = req.params.orderId;
  const order = await dataApp.findOrderById(orderId);
  const orderItems = await dataApp.getOrderItems(orderId);
  const items = await dataApp.getAllItems();
  let pkgs = await dataApp.getPackages();
  let pkgPrices = {};

  pkgs.forEach(pkg => {
    itemsInPackage = items.filter(item => item.package_id === pkg.id)

    if (Number(pkg.price) && itemsInPackage.length > 0) {
      let pricePerItem = (+pkg.price / itemsInPackage.length)
      pkgPrices[pkg.id] = pricePerItem.toFixed(2);
    }
  })

  let sumOfItems = 0;
  let shippingCost = 0;
  let revenue = 0;
  let profit = 0;

  orderItems.forEach(item => {
    item.tax = +item.tax || 8;
    let taxAmount = (Number(item.tax) / 100) * Number(item.purchase_price);
    let totalPrice = taxAmount + Number(item.purchase_price);
    item.total_price = totalPrice.toFixed(2);
    item.tax_amount = taxAmount.toFixed(2);
    item.shipping_cost = Number(item.shipping_cost) || (Number(pkgPrices[item.package_id]) || 0);
    item.profit = (Number(item.sold_price) - totalPrice - Number(item.shipping_cost)).toFixed(2);
    sumOfItems += totalPrice;
    revenue += Number(item.sold_price);
    profit += Number(item.profit);
    shippingCost += item.shipping_cost;
  })

  res.json({
    items: orderItems,
    sumOfItems: sumOfItems.toFixed(2),
    shippingCost: shippingCost.toFixed(2),
    revenue: revenue.toFixed(2),
    profit: profit.toFixed(2),
  })
})



//====================================customers===================================

app.get("/customers", requiresAuthentication, (req, res) => {
  res.render('customer-home');
})

app.get("/customers/view", requiresAuthentication, async (req, res) => {
  let customers = await dataApp.getCustomers();
  res.render("customers", {
    customers,
  })
})

app.get("/customers/add", requiresAuthentication, (req, res) => {
  res.render("create-customer");
})

app.post("/customers/add", upload.none(), requiresAuthentication, async (req, res) => {
  const customerData = req.body;
  for (key in customerData) {
    customerData[key] = customerData[key] || null;
  }

  const createdcustomer = await dataApp.createCustomer(customerData);

  if (createdcustomer) {
    res.redirect("/customers/view");
  } else {
    res.render("create-customer");
  }
})

app.get("/customers/edit/:customerId", requiresAuthentication, async (req, res) => {
  let customerId = req.params.customerId;
  let customer = await dataApp.findCustomerById(customerId);

  res.render("partials/customer-row", {
    layout: false,
    customer: customer
  });
})

app.post("/customers/edit/:customerId", requiresAuthentication, async (req, res) => {
  let customerId = req.params.customerId;
  let successfulUpdate = await dataApp.updateCustomer(req.body);

  if (successfulUpdate) {
    let customer = await dataApp.findCustomerById(customerId);


    res.render(`partials/edited-customer-row`, {
      layout: false,
      customer: customer,
    })
  }
})



//====================================items===================================

// for uploading images to amazon'a aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
// app.get(`/sign-s3`, (req, res) => {
//   const s3 = new aws.S3();
//   const fileName = req.query['file-name'];
//   const fileType = req.query['file-type'];
//   const s3Params = {
//     Bucket: AWS_BUCKET,
//     Key: fileName,
//     Expires: 60,
//     ContentType: fileType,
//     ACL: 'public-read'
//   };

//   s3.getSignedUrl('putObject', s3Params, (err, data) => {
//     if (err) {
//       console.log(err);
//       return res.end();
//     }
//     const returnData = {
//       signedRequest: data,
//       url: `https://${AWS_BUCKET}.s3.amazonaws.com/${fileName}`
//     }
//     res.send(JSON.stringify(returnData));
//   })
// })

app.post('/newitem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  try {
    let dataObj = req.body;
    if (req.file) {
      let file = req.file;
      dataObj.picture = await processImage(file, dataObj.tag_number, dataObj.type, dataObj.brand);
    }

    for (prop in dataObj) {
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
      Object.assign(item, { total_price: totalPrice });

      res.render('partials/item-structure', {
        layout: 'item-structure-wrapper',
        id: itemId,
        item: item,
        helpers: {
          isInStock: function (bool) {
            return bool === true;
          },
          sellPending: function (bool) {
            return bool;
          },
          greaterThanZero: function (soldPrice) {
            return +soldPrice > 0;
          },
          isArray: function (element) {
            return Array.isArray(element);
          },
          joinArray: function (element) {
            return element.join(', ');
          },
          isForMen: function (gender) {
            return gender == 'men';
          }
        }
      });
    }

  } catch (err) {
    console.log(err)
    res.status(404).end();
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

  item.sold_price_uah = ((+item.sold_price || 0) * UAH_CONVERSION).toFixed(2);
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
      isWithJenia: function (location) {
        return location === 'jenia';
      },
      isInUkraine: function (location) {
        if (!location) return false;
        return location.toLowerCase() === 'ukraine';
      },
    }
  })
});

app.post('/addtopackage/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let pkgId = req.body.pkgId;
  if (!pkgId) return res.sendStatus(204);

  let updatedItem = await dataApp.updateItemPackage(itemId, pkgId);
  let updatedLocation = await dataApp.updateItemLocation(itemId, 'ukraine');

  if (updatedItem && updatedLocation) {
    returnUpdatedItem(res, itemId);
  } else {
    res.sendStatus(204);
  }
})

app.post('/sellitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let soldPrice = req.body.soldPrice || '0';
  let pending = soldPrice.endsWith('?');

  if (pending) {
    soldPrice = soldPrice.slice(0, -1);
  }

  let customer = req.body.customer;
  let order = req.body.order;

  if (!order) {
    order = await dataApp.findOrderByCustomerName(customer);
  }

  await dataApp.updateItemSoldPrice(itemId, soldPrice);
  await dataApp.updateItemPending(itemId, pending);
  await dataApp.updateItemOrder(itemId, order.id);
  await dataApp.updateItemLocation(itemId, 'ukraine');
  await dataApp.updateItemInStock(itemId, false);
  returnUpdatedItem(res, itemId);
})

app.post('/updateinventory/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let location = req.body.location === 'none' ? 'usa' : req.body.location;
  let inStock = req.body.inStock;

  await dataApp.updateItemLocation(itemId, location);
  await dataApp.updateItemInStock(itemId, inStock);
  returnUpdatedItem(res, itemId);
})

app.post('/unsellitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  await dataApp.updateItemSoldPrice(itemId, 0);
  await dataApp.removeItemFromOrder(itemId);
  await dataApp.updateItemInStock(itemId, true);
  await dataApp.updateItemPending(itemId, false);
  returnUpdatedItem(res, itemId);
})

app.post('/edititem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  let dataObj = req.body;
  let itemId = dataObj.id;

  if (dataObj.picture) {
    let urlParts = dataObj.picture.split("/");
    let formattedImgName = urlParts[urlParts.length - 1];
    dataObj.picture = formattedImgName;
  }

  for (prop in dataObj) {
    if (['purchase_price', 'shipping_cost', 'sold_price'].includes(prop)) {
      let regex = /[^0-9.]/g;
      dataObj[prop] = dataObj[prop].replace(regex, '');
    }
  }

  for (prop in dataObj) {
    if (dataObj[prop] === '') {
      dataObj[prop] = null;
    } else if (prop !== "extra_info" && prop !== 'gender' && prop !== 'location' && prop !== 'picture') {
      dataObj[prop] = capitalize(dataObj[prop]);
    }
  }


  let successfulDatabaseUpdate = await dataApp.updateItem(itemId, dataObj);

  if (successfulDatabaseUpdate) {
    returnUpdatedItem(res, itemId);
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
    Object.assign(item, { total_price: totalPrice });
    res.render('partials/item-structure', {
      layout: 'item-structure-wrapper',
      id: item.id,
      item: item,
      helpers: {
        isInStock: function (bool) {
          return bool;
        },
        sellPending: function (bool) {
          return bool;
        },
        greaterThanZero: function (soldPrice) {
          return +soldPrice > 0;
        },
        isArray: function (element) {
          return Array.isArray(element);
        },
        joinArray: function (element) {
          return element.join(', ');
        },
        isForMen: function (gender) {
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
    return Object.assign(item, { total_price: totalPrice });
  });
  res.render('clothing', {
    items: items,
    filters: req.query,
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
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
  res.render('inventory-select');
});

app.get("/clothing/view/:inventory", requiresAuthentication, (req, res) => {
  let inventory = req.params.inventory;
  res.render('gender-select', {
    inventory
  })
});

app.get("/clothing/view/:inventory/:gender", requiresAuthentication, async (req, res) => {
  let inventory = req.params.inventory;
  let gender = req.params.gender;
  let items;

  if (gender === 'women') {
    if (inventory === 'instock') {
      items = await dataApp.getInStockWomensClothing();
    } else if (inventory === 'pending') {
      items = await dataApp.getPendingWomensClothing();
    } else {
      items = await dataApp.getAllWomensClothing();
    }
  } else if (gender === 'men') {
    if (inventory === 'instock') {
      items = await dataApp.getInStockMensClothing();
    } else if (inventory === 'pending') {
      items = await dataApp.getPendingMensClothing();
    } else {
      items = await dataApp.getAllMensClothing();
    }
  } else {
    if (inventory === 'instock') {
      items = await dataApp.getInStockItems();
    } else if (inventory === 'pending') {
      items = await dataApp.getPendingItems();
    } else {
      items = await dataApp.getAllItems();
    }
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
    gender: gender,
    inventory: inventory,
  });
});

app.get("/clothing/view/:inventory/:gender/filtered", requiresAuthentication, async (req, res) => {
  let queryObj = req.query;
  let gender = req.params.gender;
  let inventory = req.params.inventory;

  let filterString = buildFilterString(queryObj, gender, inventory);
  console.log(filterString);
  let items = (await dataApp.getFilteredItems(filterString)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, { total_price: totalPrice });
  });
  res.render('clothing', {
    items: items,
    filters: queryObj,
    helpers: {
      isInStock: function (bool) {
        return bool === true;
      },
      sellPending: function (bool) {
        return bool;
      },
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      },
      isArray: function (element) {
        return Array.isArray(element);
      },
      joinArray: function (element) {
        return element.join(', ');
      },
      isForMen: function (gender) {
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