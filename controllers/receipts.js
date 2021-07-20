const receiptRouter = require('express').Router();
const Receipts = require('../models/receipts');
const Clothing = require('../models/items');
const upload = require('../lib/useMulter');
const requiresAuthentication = require("../utils/middleware.js").requiresAuthentication;
const formatDate = require('../lib/format-date.js')

receiptRouter.get("/", requiresAuthentication, (req, res) => {
  res.render('receipt-home');
})

receiptRouter.get("/view", requiresAuthentication, async (req, res) => {
  let receipts = await Receipts.getAll();
  let items = await Clothing.getAll();

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


receiptRouter.get("/view/:receiptId", requiresAuthentication, async (req, res) => {
  const receiptId = req.params.receiptId;
  const receipt = await Receipts.findById(receiptId);

  let items = (await Clothing.findInReceipt(receiptId)).map(item => {
    let taxPercent = undefined || !item.receipt_id ? 8 : item.tax;
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

receiptRouter.get("/add", requiresAuthentication, (req, res) => {
  res.render("create-receipt");
})

receiptRouter.post("/add", upload.none(), requiresAuthentication, async (req, res) => {
  const receiptData = req.body;
  for (key in receiptData) {
    receiptData[key] = receiptData[key] || null;
  }

  const createdReceipt = await Receipts.create(receiptData);

  if (createdReceipt) {
    res.redirect("/receipts/view");
  } else {
    res.render("create-receipt");
  }
})

receiptRouter.get("/edit/:receiptId", requiresAuthentication, async (req, res) => {
  let receiptId = req.params.receiptId;
  let receipt = await Receipts.findById(receiptId);
  if (receipt.purchase_date) {
    receipt.purchase_date = formatDate(receipt.purchase_date.toLocaleDateString());
  }

  res.render("partials/receipt-row", {
    layout: false,
    receipt: receipt
  });
})

receiptRouter.post("/edit/:receiptId", requiresAuthentication, async (req, res) => {
  let receiptId = req.params.receiptId;

  let successfulUpdate = await Receipts.update(req.body);
  if (successfulUpdate) {
    let receipt = await Receipts.findById(receiptId);
    let itemsOnReceipt = await Clothing.findInReceipt(receiptId);

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


module.exports = receiptRouter;