const orderRouter = require('express').Router();
const Orders = require('../models/orders');
const Clothing = require('../models/items');
const Customers = require('../models/customers');
const Packages = require('../models/packages');
const upload = require('../lib/useMulter');
const requiresAuthentication = require("../utils/middleware.js").requiresAuthentication;
const formatDate = require('../lib/format-date.js')
const setTaxPercent = require('../lib/set-tax-percent');
const calculateTaxAmount = require('../lib/calculate-tax-amount');

orderRouter.get("/", requiresAuthentication, (req, res) => {
  res.render('order-home');
})

orderRouter.get("/view", requiresAuthentication, async (req, res) => {
  let orders = await Orders.getAll();
  let items = await Clothing.getAll();
  let pkgs = await Packages.getAll();
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
      setTaxPercent(item);
      let taxAmount = calculateTaxAmount(item);
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

orderRouter.get("/print/:orderId", requiresAuthentication, async (req, res) => {
  const orderId = req.params.orderId;
  const order = await Orders.findById(orderId);
  const customer = await Customers.findById(order.customer_id);
  const orderItems = await Clothing.findInOrder(orderId);
  const items = await Clothing.getAll();
  let pkgs = await Packages.getAll();
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
    setTaxPercent(item);
    let taxAmount = calculateTaxAmount(item);
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

orderRouter.get("/view/:orderId", requiresAuthentication, async (req, res) => {
  const orderId = req.params.orderId;
  const order = await Orders.findById(orderId);

  let items = (await Orders.getOrderItems(orderId)).map(item => {
    setTaxPercent(item);
    let taxAmount = calculateTaxAmount(item);
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

orderRouter.get("/add", requiresAuthentication, (req, res) => {
  res.render("create-order");
})

orderRouter.post("/add", upload.none(), requiresAuthentication, async (req, res) => {
  const orderData = req.body;
  for (key in orderData) {
    orderData[key] = orderData[key] || null;
  }

  const createdOrder = await Orders.create(orderData);

  if (createdOrder) {
    res.redirect("/orders/view");
  } else {
    res.render("create-order");
  }
})

orderRouter.get("/edit/:orderId", requiresAuthentication, async (req, res) => {
  let orderId = req.params.orderId;
  let order = await Orders.findById(orderId);
  if (order.date_sent) {
    order.date_sent = formatDate(order.date_sent.toLocaleDateString());
  }

  res.render("partials/order-row", {
    layout: false,
    order: order
  });
})

orderRouter.post("/edit/:orderId", requiresAuthentication, async (req, res) => {
  let orderId = req.params.orderId;
  let successfulUpdate = await Orders.update(req.body);

  if (successfulUpdate) {
    let order = await Orders.findById(orderId);
    order.tax_total = 0;
    order.shipping_total = 0;
    order.base_cost = 0;
    order.sold_total = 0;
    order.cogs = 0;
    order.total_profit = 0;
    let itemsInOrder = await Clothing.findInOrder(orderId);

    let items = await Clothing.getAll();
    let pkgs = await Packages.getAll();
    let pkgPrices = {};


    pkgs.forEach(pkg => {
      itemsInPackage = items.filter(item => item.package_id === pkg.id)

      if (Number(pkg.price) && itemsInPackage.length > 0) {
        let pricePerItem = (+pkg.price / itemsInPackage.length)
        pkgPrices[pkg.id] = pricePerItem.toFixed(2);
      }
    })

    itemsInOrder.forEach(item => {
      setTaxPercent(item);
      let taxAmount = calculateTaxAmount(item);
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


orderRouter.get('/orderitems/:orderId', async (req, res) => {
  const orderId = req.params.orderId;
  const order = await Orders.findById(orderId);
  const orderItems = await Clothing.findInOrder(orderId);
  const items = await Clothing.getAll();
  let pkgs = await Packages.getAll();
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
    setTaxPercent(item);
    let taxAmount = calculateTaxAmount(item);
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

module.exports = orderRouter;