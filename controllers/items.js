// @ts-check
// remove upload

const itemRouter = require('express').Router();
const Clothing = require('../models/items');
const Receipts = require('../models/receipts');
const Orders = require('../models/orders');
const Packages = require('../models/packages');
const Customers = require('../models/customers');
const filter = require('../lib/filter');
const upload = require('../lib/useMulter');
const requiresAuthentication = require("../utils/middleware.js").requiresAuthentication;
const buildFilterString = require('../lib/build-filter-string.js');
const capitalize = require('../lib/capitalize.js');
const setTaxPercent = require('../lib/set-tax-percent');
const calculateTaxAmount = require('../lib/calculate-tax-amount');
// const sendMessageToQueue = require('../lib/send-message-to-queue');

const UAH_CONVERSION = 28;

const helpers = {
  isInStock: (bool) => bool === true,
  sellPending: (bool) => bool === true,
  greaterThanZero: (soldPrice) => Number(soldPrice) > 0,
  isArray: (element) => Array.isArray(element),
  joinArray: (element) => element.join(', '),
  isForMen: (gender) => gender === 'men',
  isWithJenia: (location) => location === 'jenia',
  isInUkraine: (location) => location && location.toLowerCase() === 'ukraine',
  isWithAlla: (location) => location === 'alla',
  isTraveling: (location) => location === 'traveling'
}

const removeSpaces = (string) => {
  return string.split(' ').join('-').toLowerCase();
}


const calculateTotalPrice = (item) => {
  setTaxPercent(item);
  let taxAmount = calculateTaxAmount(item);
  // let taxAmount = +item.purchase_price * (item.tax / 100);
  return (+item.purchase_price + taxAmount).toFixed(2);
}

const returnUpdatedItem = async (res, itemId) => {
  let item = await Clothing.findById(itemId);
  item.total_price = calculateTotalPrice(item);
  res.render('partials/item-structure', {
    layout: false,
    item: item,
    helpers
  });
}

const modifyProperties = (dataObj) => {
  for (prop in dataObj) {
    if (['purchase_price', 'shipping_cost', 'sold_price'].includes(prop)) {
      let regex = /[^0-9.]/g;
      dataObj[prop] = dataObj[prop].replace(regex, '');
    } 

    if (dataObj[prop] === '') {
      dataObj[prop] = null;
    } else if (prop !== "extra_info" && prop !== 'gender' && prop !== 'location' && prop !== 'picture') {
      dataObj[prop] = capitalize(dataObj[prop]);
    } else if (prop == "size") {
      dataObj[prop] = dataObj[prop].toUpperCase();
    }
  }
}


itemRouter.post('/imagetest', (req, res) => {
  res.render('tester');
})


itemRouter.post('/newitem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  try {
    let dataObj = req.body;
    // let originalName = dataObj.pictureName;
    let tagNumber = dataObj.tag_number;
    // let file = req.file;

    if (tagNumber.includes('?')) {
      tagNumber = String(Math.floor(Math.random() * 1000));
    }

    dataObj.picture = `${removeSpaces(dataObj.brand)}-${removeSpaces(dataObj.type)}-${tagNumber.toLowerCase()}.png`

    modifyProperties(dataObj);

    // if (originalName) {
    //   let queueData = {
    //     originalName: originalName,
    //     newName: dataObj.picture
    //   }

      // sendMessageToQueue(queueData);
    // }

    let itemId = await Clothing.create(dataObj);

    if (itemId) {
      let item = await Clothing.findById(itemId);
      item.total_price = calculateTotalPrice(item);

      res.render('partials/item-structure', {
        layout: 'item-structure-wrapper',
        id: itemId,
        item: item,
        helpers
      });
    }

  } catch (err) {
    console.log(err)
    res.status(404).end();
  }
})

itemRouter.get('/item/:itemId', requiresAuthentication, async (req, res) => {
  let id = req.params.itemId;
  let item = await Clothing.findById(id);
  let brands = await Clothing.getBrands(); // need to cache
  let types = await Clothing.getTypes(); // need to cache
  let receipt = await Receipts.findById(item.receipt_id) || {}; // not needed?
  let pkg = await Packages.findById(item.package_id) || {}; // not needed?
  let order = await Orders.findById(item.order_id) || {}; // need to simplify
  let customer = await Customers.findById(order.customer_id) || {}; // need to simplify
  let packageItems = await Clothing.findInPackage(item.package_id); // will be handled in package delivery
  let shippingCost = ((+pkg.price / packageItems.length) || 0).toFixed(2); // will be on the item after package delivery
  
  setTaxPercent(item);
  item.tax_amount = calculateTaxAmount(item); 
  item.total_price = calculateTotalPrice(item);
  item.purchase_date = receipt.purchase_date ?
    new Date(receipt.purchase_date).toLocaleDateString() :
    new Date(item.date_created).toLocaleDateString();
  if (!(+item.shipping_cost)) {
    item.shipping_cost = shippingCost; // to be handled at package delivery
  }

  item.sold_price_uah = ((+item.sold_price || 0) * UAH_CONVERSION).toFixed(2); // to be pushed to a data store
  item.location = item.location || pkg.location; // exists on all items?
  item.package_name = pkg.package_name; // handle in a join?
  item.customer_name = customer.name; // handle in a join?
  res.render('item-popup', {
    layout: false,
    item: item,
    brands: brands,
    types: types,
    itemId: id,
    helpers
  })
});

itemRouter.post('/addtopackage/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let pkgId = req.body.pkgId;
  if (!pkgId) return res.sendStatus(204);

  let updatedItem = await Clothing.updatePackage(itemId, pkgId);
  let updatedLocation = await Clothing.updateLocation(itemId, 'ukraine');

  if (updatedItem && updatedLocation) {
    returnUpdatedItem(res, itemId);
  } else {
    res.sendStatus(204);
  }
})

itemRouter.post('/sellitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let soldPrice = req.body.soldPrice || '0';
  let pending = soldPrice.endsWith('?');

  if (pending) {
    soldPrice = soldPrice.slice(0, -1);
  }

  let customer = req.body.customer;
  let order = req.body.order;

  if (!order) {
    order = await Orders.findByCustomerName(customer);
  }

  await Clothing.updateSoldPrice(itemId, soldPrice);
  await Clothing.updatePending(itemId, pending);
  await Clothing.updateOrder(itemId, order.id);
  await Clothing.updateLocation(itemId, 'ukraine');
  await Clothing.updateInStock(itemId, false);
  returnUpdatedItem(res, itemId);
})

itemRouter.post('/updateinventory/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let location = req.body.location === 'none' ? 'usa' : req.body.location;
  let inStock = req.body.inStock;

  await Clothing.updateLocation(itemId, location);
  await Clothing.updateInStock(itemId, inStock);
  returnUpdatedItem(res, itemId);
})

itemRouter.post('/unsellitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  await Clothing.updateSoldPrice(itemId, 0);
  await Clothing.removeFromOrder(itemId);
  await Clothing.updateInStock(itemId, true);
  await Clothing.updatePending(itemId, false);
  returnUpdatedItem(res, itemId);
})

itemRouter.post('/edititem', requiresAuthentication, upload.single('brandomania-picture'), async (req, res) => {
  try {
    // working
    let dataObj = req.body;
    // let originalName = dataObj.pictureName;
    // console.log(originalName);
    let itemId = dataObj.id;

    dataObj.picture = `${removeSpaces(dataObj.brand)}-${removeSpaces(dataObj.type)}-${dataObj.tag_number.toLowerCase()}.png`;

    modifyProperties(dataObj);

    let successfulDatabaseUpdate = await Clothing.update(itemId, dataObj);
    // if (originalName) {
    //   let queueData = {
    //     originalName: originalName,
    //     newName: dataObj.picture
    //   }

    //   sendMessageToQueue(queueData);
    // }

    if (successfulDatabaseUpdate) {
      returnUpdatedItem(res, itemId);
    }
  } catch (error) {
    console.log(error);
  }
});

itemRouter.post('/updatesoldlink/:itemId', requiresAuthentication, async (req, res) => {
  const itemId = req.params.itemId;
  const soldTo = req.body.soldTo;
  await Clothing.editSoldTo(itemId, soldTo);
  res.sendStatus(200).end();
})

itemRouter.post('/updatearrived/:itemId', requiresAuthentication, async (req, res) => {
  const itemId = req.params.itemId;
  const arrived = req.body.arrived;
  await Clothing.editArrived(itemId, arrived);
  res.sendStatus(200).end();
})

itemRouter.post('/duplicateitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let duplicateId = await Clothing.duplicate(itemId);

  if (duplicateId) {
    let item = await Clothing.findById(duplicateId);
    item.total_price = calculateTotalPrice(item);
    res.render('partials/item-structure', {
      layout: 'item-structure-wrapper',
      id: item.id,
      item: item,
      helpers
    });
  } else {
    res.status(404);
  }
});


itemRouter.get('/findtag', requiresAuthentication, async (req, res) => {
  let tagNumber = req.query.tagNumber;
  let items = await Clothing.findByTag(tagNumber);

  items = items.map(item => {
    item.total_price = calculateTotalPrice(item);
    return item;
  });
  res.render('clothing', {
    items: items,
    filters: req.query,
    helpers
  });
});

itemRouter.post('/deleteitem/:itemId', requiresAuthentication, async (req, res) => {
  let itemId = req.params.itemId;
  let deleted = await Clothing.destroy(itemId);
  if (deleted) {
    res.status(200).send('OK');
  } else {
    res.status(404).send('Could not delete');
  }
})

itemRouter.get("/", requiresAuthentication, (req, res) => {
  res.render('home');
});

itemRouter.get("/view", requiresAuthentication, (req, res) => {
  res.render('inventory-select');
});

itemRouter.get("/view/:inventory", requiresAuthentication, (req, res) => {
  let inventory = req.params.inventory;
  res.render('gender-select', {
    inventory
  })
});

itemRouter.get("/view/:inventory/:gender", requiresAuthentication, async (req, res) => {
  let inventory = req.params.inventory;
  let gender = req.params.gender;
  let items;

  if (gender === 'women') {
    if (inventory === 'instock') {
      items = await Clothing.getInStockWomens();
    } else if (inventory === 'pending') {
      items = await Clothing.getPendingWomens();
    } else {
      items = await Clothing.getAllWomens();
    }
  } else if (gender === 'men') {
    if (inventory === 'instock') {
      items = await Clothing.getInStockMens();
    } else if (inventory === 'pending') {
      items = await Clothing.getPendingMens();
    } else {
      items = await Clothing.getAllMens();
    }
  } else {
    if (inventory === 'instock') {
      items = await Clothing.getInStock();
    } else if (inventory === 'pending') {
      items = await Clothing.getPending();
    } else {
      items = await Clothing.getAll();
    }
  }

  let brandItems = filter.brands(items)
  let typeItems = filter.types(items);
  let colorsItems = filter.colors(items);
  let sizeItems = filter.sizes(items);
  let locationItems = filter.locations(items);

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

itemRouter.get("/view/:inventory/:gender/filtered", requiresAuthentication, async (req, res) => {
  let queryObj = req.query;
  let gender = req.params.gender;
  let inventory = req.params.inventory;

  let filterString = buildFilterString(queryObj, gender, inventory);
  // console.log(filterString);
  let items = (await Clothing.getFiltered(filterString)).map(item => {
    item.total_price = calculateTotalPrice(item);
    return item;
  });
  res.render('clothing', {
    items: items,
    filters: queryObj,
    helpers
  });
});

itemRouter.get("/add", requiresAuthentication, async (req, res) => {
  let brands = await Clothing.getBrands();
  let types = await Clothing.getTypes();
  let colors = await Clothing.getColors();
  res.render('create-item', {
    brands,
    types,
    colors
  });
})

module.exports = itemRouter;