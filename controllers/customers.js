const customerRouter = require('express').Router();
const Customers = require('../models/customers');
const upload = require('../lib/useMulter');
const requiresAuthentication = require("../utils/middleware.js").requiresAuthentication;

customerRouter.get("/", requiresAuthentication, (req, res) => {
  res.render('customer-home');
})

customerRouter.get("/view", requiresAuthentication, async (req, res) => {
  let customers = await Customers.getAll();
  res.render("customers", {
    customers,
  })
})

customerRouter.get("/add", requiresAuthentication, (req, res) => {
  res.render("create-customer");
})

customerRouter.post("/add", upload.none(), requiresAuthentication, async (req, res) => {
  const customerData = req.body;
  for (key in customerData) {
    customerData[key] = customerData[key] || null;
  }

  const createdcustomer = await Customers.create(customerData);

  if (createdcustomer) {
    res.redirect("/customers/view");
  } else {
    res.render("create-customer");
  }
})

customerRouter.get("/edit/:customerId", requiresAuthentication, async (req, res) => {
  let customerId = req.params.customerId;
  let customer = await Customers.findById(customerId);

  res.render("partials/customer-row", {
    layout: false,
    customer: customer
  });
})

customerRouter.post("/edit/:customerId", requiresAuthentication, async (req, res) => {
  let customerId = req.params.customerId;
  let successfulUpdate = await Customers.update(req.body);

  if (successfulUpdate) {
    let customer = await Customers.findById(customerId);


    res.render(`partials/edited-customer-row`, {
      layout: false,
      customer: customer,
    })
  }
})

module.exports = customerRouter;