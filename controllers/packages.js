const packageRouter = require('express').Router();
const Packages = require('../models/packages');
const Clothing = require('../models/items');
const upload = require('../lib/useMulter');
const requiresAuthentication = require("../utils/middleware.js").requiresAuthentication;
const formatDate = require('../lib/format-date.js')
const setTaxPercent = require('../lib/set-tax-percent');
const calculateTaxAmount = require('../lib/calculate-tax-amount');

packageRouter.get("/", requiresAuthentication, (req, res) => {
  res.render('package-home');
})

packageRouter.get("/singlepackage/:pkgId", requiresAuthentication, async (req, res) => {
  let pkgId = req.params.pkgId;
  let pkg = await Packages.findById(pkgId);

  res.send(pkg);
})

packageRouter.get("/view", requiresAuthentication, async (req, res) => {
  let pkgs = await Packages.getAll();
  let items = await Clothing.getAll();
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

packageRouter.get("/view/:pkgId", requiresAuthentication, async (req, res) => {
  const pkgId = req.params.pkgId;
  const pkg = await Packages.findById(pkgId);

  let items = (await Clothing.findInPackage(pkgId)).map(item => {
    setTaxPercent(item);
    let taxAmount = calculateTaxAmount(item);
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

packageRouter.get("/add", requiresAuthentication, (req, res) => {
  res.render("create-package")
})

packageRouter.post("/add", upload.none(), requiresAuthentication, async (req, res) => {
  const packageData = req.body;
  for (key in packageData) {
    packageData[key] = packageData[key] || null;
  }

  const createdPackage = await Packages.create(packageData);

  if (createdPackage) {
    res.redirect("/packages/view");
  } else {
    res.render("create-package");
  }
})

packageRouter.get("/edit/:pkgId", requiresAuthentication, async (req, res) => {
  let pkgId = req.params.pkgId;
  let pkg = await Packages.findById(pkgId);
  if (pkg.date_sent) {
    pkg.date_sent = formatDate(pkg.date_sent.toLocaleDateString());
  }

  res.render("partials/package-row", {
    layout: false,
    pkg: pkg
  });
})

packageRouter.post("/edit/:pkgId", requiresAuthentication, async (req, res) => {
  let pkgId = req.params.pkgId;
  let successfulUpdate = await Packages.update(req.body);
  if (successfulUpdate) {
    let pkg = await Packages.findById(pkgId);
    let itemsInPackage = await Clothing.findInPackage(pkgId);

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

packageRouter.get("/print/:pkgId", async (req, res) => {
  const pkgId = req.params.pkgId;
  const pkg = await Packages.findById(pkgId);
  const items = await Clothing.findInPackage(pkgId);

  const pricePerItem = pkg.price && items.length > 0
    ? (+pkg.price / items.length).toFixed(2)
    : 0;

  res.render("print-package", {
    layout: false,
    pkg,
    pricePerItem,
  })
})

packageRouter.get('/packageitems/:pkgId', async (req, res) => {
  const pkgId = req.params.pkgId;
  const pkg = await Packages.findById(pkgId);
  const items = await Clothing.findInPackage(pkgId);

  let sumOfItems = 0;
  let totalShipping = 0;
  let pricePerItem = (Number(pkg.price) / items.length).toFixed(2);

  items.forEach(item => {
    setTaxPercent(item);
    let taxAmount = calculateTaxAmount(item);
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
packageRouter.post('/items/:pkgId/shippingcost', async (req, res) => {
  const pkgId = req.params.pkgId;
  const pricePerItem = req.body.pricePerItem;
  await Clothing.updateGroupShippingCost(pkgId, pricePerItem);
  res.sendStatus(200).end();
})


module.exports = packageRouter;