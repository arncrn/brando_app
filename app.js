const express = require('express');
const app = express();
let path = require('path');
const exphbs = require('express-handlebars');
const pgPersistence = require('./lib/pg-persistence.js');
const buildFilterString = require('./lib/build-filter-string.js');
const { types } = require('pg');
const dataApp = new pgPersistence();
const port = 3000;

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');


app.use(express.static("public"));

app.get('/', (req, res) => {
  res.redirect('/clothing');
});

app.get('/item/:itemId', async (req, res) => {
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
  if (!+item.shipping_cost) {
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
      isInUSA: function(location) {
        return location === 'usa'
      }, 
      isInUkraine: function(location) {
        return location === 'ukraine'
      }
    }
  })
});

app.post('/edititem/:itemId', (req, res) => {
  console.log(req);
  res.send('good job');
})

app.get("/clothing", (req, res) => {
  res.render('home');
}); 

app.get("/clothing/view", (req, res) => {
  res.render('gender-select');
});

app.get("/view/:gender", async (req, res, next) => {
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

app.get("/view/:gender/filtered", async (req, res) => {
  let queryObj = req.query;
  let filterString = buildFilterString(queryObj);
  let items = (await dataApp.getFilteredItems(filterString)).map(item => {
    let taxPercent = item.tax || 8;
    let taxAmount = +item.purchase_price * (taxPercent / 100);
    let totalPrice = (+item.purchase_price + taxAmount).toFixed(2);
    return Object.assign(item, {total_price: totalPrice});
  });
  res.render('clothing', {
    items: items,
    helpers: {
      greaterThanZero: function (soldPrice) {
        return +soldPrice > 0;
      }
    }
  });
});

app.get("/clothing/add", (req, res) => {
  res.render('picture');
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