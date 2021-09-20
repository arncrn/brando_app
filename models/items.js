const { dbQuery } = require("../lib/db-query");

const FIND_ITEM_TEXT = `SELECT clothing.id, size, brand, type, colors, receipt_id,
tag_number, purchase_price, sold_price, package_id, order_id, extra_info, 
seen, gender, style, picture, material, clothing.location, date_sold, clothing.date_created,
clothing.shipping_cost, in_stock, pending, receipts.tax, receipts.store, packages.package_name
FROM clothing 
LEFT JOIN receipts ON receipt_id = receipts.id
LEFT JOIN packages ON package_id = packages.id`; 


const _sortItems = (items) => {
  return items.sort((a, b) => {
    if (a.tag_number > b.tag_number) return 1;
    if (a.tag_number < b.tag_number) return -1;
    return 0;
  });
}

// toggle whether an item is physically seen or not
const toggleSeen = async (itemId) => {
  let item = await findById(itemId);
  const TOGGLE_TEXT = "UPDATE clothing SET seen = $1 WHERE clothing.id = $2";

  let result = await dbQuery(TOGGLE_TEXT, !item.seen, itemId);
  return result.rowCount > 0;
}

const findById = async (id) => {
  const ITEM = FIND_ITEM_TEXT + " WHERE clothing.id = $1";

  let result = await dbQuery(ITEM, id);
  return result.rows[0];
}
const findByTag = async (tagNumber) => {
  const ITEMS = FIND_ITEM_TEXT + " WHERE tag_number ILIKE $1";
  let result = await dbQuery(ITEMS, `%${tagNumber}%`);
  return result.rows;
}

const getAll = async () => {
  const ALL_ITEMS = FIND_ITEM_TEXT + ' ORDER BY tag_number';

  let result = await dbQuery(ALL_ITEMS);
  return _sortItems(result.rows);
}

const getInStock = async () => {
  const IN_STOCK_ITEMS = FIND_ITEM_TEXT + ' WHERE in_stock = true';
  let result = await dbQuery(IN_STOCK_ITEMS);
  return _sortItems(result.rows);
}

const getPending = async () => {
  const PENDING_ITEMS = FIND_ITEM_TEXT + ' WHERE pending = true';
  let result = await dbQuery(PENDING_ITEMS);
  return _sortItems(result.rows);
}

const getAllWomens = async () => {
  const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women'";
  let result = await dbQuery(WOMENS_CLOTHING);
  return _sortItems(result.rows);
}

const getInStockWomens = async () => {
  const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women' AND in_stock = true";
  let result = await dbQuery(WOMENS_CLOTHING);
  return _sortItems(result.rows);
}

const getPendingWomens = async () => {
  const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women' AND pending = true";
  let result = await dbQuery(WOMENS_CLOTHING);
  return _sortItems(result.rows);
}

const getAllMens = async () => {
  const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men'";
  let result = await dbQuery(MENS_CLOTHING);
  return _sortItems(result.rows);
}

const getInStockMens = async () => {
  const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men' AND in_stock = true";
  let result = await dbQuery(MENS_CLOTHING);
  return _sortItems(result.rows);
}

const getPendingMens = async () => {
  const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men' AND pending = true";
  let result = await dbQuery(MENS_CLOTHING);
  return _sortItems(result.rows);
}

const getFiltered = async (filterString) => {
  let filterItemsText = FIND_ITEM_TEXT + ` ${filterString}`;
  let result = await dbQuery(filterItemsText);

  return _sortItems(result.rows);
}

const findInOrder = async (id) => {
  const ITEMS = FIND_ITEM_TEXT + " WHERE order_id = $1 ORDER BY tag_number";

  let result = await dbQuery(ITEMS, id);

  return result.rows;
}
const findInPackage = async (id) => {
  const ITEMS = FIND_ITEM_TEXT + " WHERE package_id = $1 ORDER BY tag_number";

  let result = await dbQuery(ITEMS, id);

  return result.rows;
}
const findInReceipt = async (id) => {
  const ITEMS = FIND_ITEM_TEXT + " WHERE receipt_id = $1 ORDER BY tag_number";

  let result = await dbQuery(ITEMS, id);

  return result.rows;
}

const create = async (dataObj) => {
  let result;
  let size = dataObj.size;
  let brand = dataObj.brand;
  let type = dataObj.type;
  let colors = dataObj.colors;
  let receiptId = dataObj.receipt_id;
  let tagNumber = dataObj.tag_number;
  let purchasePrice = dataObj.purchase_price;
  let soldPrice = dataObj.sold_price;
  let packageId = dataObj.package_id;
  let orderId = dataObj.order_id;
  let extra_info = dataObj.extra_info;
  let gender = dataObj.gender;
  let picture = dataObj.picture || null;
  let style = dataObj.style;
  let material = dataObj.material;
  let location = dataObj.location;
  let dateSold = dataObj.date_sold;
  let shippingCost = dataObj.shipping_cost
  

  const CREATE_ITEM = `INSERT INTO clothing
  (size, brand, type, tag_number, purchase_price, receipt_id, sold_price, package_id, order_id, 
    extra_info, colors, gender, picture, style, material, location, date_sold, shipping_cost, in_stock)
  VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)
  RETURNING id`;

  try {
    result = await dbQuery(CREATE_ITEM, size, brand, type, tagNumber, purchasePrice, receiptId, soldPrice, packageId, orderId, 
      extra_info, colors, gender, picture, style, material, location, dateSold, shippingCost, true);
  } catch (error) {
    console.log(error);
    return false;
  }

  return result.rows[0].id;
}

const update = async (itemId, dataObj) => {
  const UPDATE_ITEM = `UPDATE clothing SET tag_number = $1, gender = $2, size = $3, brand = $4, 
  colors = $5, type = $6, receipt_id = $7, purchase_price = $8, shipping_cost = $9, sold_price = $10,
  location = $11, package_id = $12, order_id = $13, material = $14, 
  style = $15, extra_info = $16, date_sold = $17, picture = $18
  WHERE id = $19`;

  let result = await dbQuery(UPDATE_ITEM, dataObj.tag_number, dataObj.gender, dataObj.size, 
    dataObj.brand, dataObj.colors, dataObj.type, dataObj.receipt_id, dataObj.purchase_price,
    dataObj.shipping_cost, dataObj.sold_price, dataObj.location, dataObj.package_id, dataObj.order_id,
    dataObj.material, dataObj.style, dataObj.extra_info, dataObj.date_sold, dataObj.picture, itemId);

  return result.rowCount > 0;
}

const duplicate = async (itemId) => {
  const DUPLICATE_ITEM = `INSERT INTO clothing (size, brand, type, colors, tag_number, purchase_price, extra_info, 
  gender, picture, style, material, in_stock)
  SELECT size, brand, type, colors, tag_number, purchase_price, extra_info, gender, picture, style, material, in_stock
  FROM clothing WHERE id = $1 RETURNING id`;

  let result = await dbQuery(DUPLICATE_ITEM, itemId);
  let id = result.rows[0].id;
  await updateInStock(id, true);

  return id;
}

const updateSize = async (id, size) => {
  const UPDATE_SIZE = "UPDATE clothing SET size = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_SIZE, size, id);

  return result.rowCount > 0;
}
const updateBrand = async (id, brand) => {
  // let brandId = await findBrandId(brand);
  const UPDATE_BRAND = "UPDATE clothing SET brand_id = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_BRAND, brand, id);

  return result.rowCount > 0;
}
const updateType = async (id, type) => {
  // let typeId = await findTypeId(type);
  const UPDATE_TYPE = "UPDATE clothing SET type_id = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_TYPE, type, id);

  return result.rowCount > 0;
}
const updateColors = async (id, colorString) => {
  const UPDATE_COLORS = "UPDATE clothing SET colors = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_COLORS, colorString, id);
  return result.rowCount > 0;
}
const updateReceipt = async (id, receiptId) => {
  const UPDATE_RECEIPT = "UPDATE clothing SET receipt_id = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_RECEIPT, receiptId, id);
  return result.rowCount > 0;
}
const updateTagNumber = async (id, tagNumber) => {
  const UPDATE_TAG = "UPDATE clothing SET tag_number = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_TAG, tagNumber, id);
  return result.rowCount > 0;
}
const updatePurchasePrice = async (id, purchasePrice) => {
  const UPDATE_P_PRICE = "UPDATE clothing SET purchase_price = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_P_PRICE, purchasePrice, id);
  return result.rowCount > 0;
}
const updateSoldPrice = async (id, soldPrice) => {
  const UPDATE_SOLD_PRICE = "UPDATE clothing SET sold_price = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_SOLD_PRICE, soldPrice, id);
  return result.rowCount > 0;
}
const updatePackage = async (id, packageId) => {
  const UPDATE_PACKAGE = "UPDATE clothing SET package_id = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_PACKAGE, packageId, id);
  return result.rowCount > 0;
}
const updateOrder = async (id, orderId) => {
  const UPDATE_ORDER = "UPDATE clothing SET order_id = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_ORDER, orderId, id);
  return result.rowCount > 0;
}
const removeFromOrder = async (id) => {
  const UPDATE_ORDER = "UPDATE clothing SET order_id = NULL WHERE clothing.id = $1";
  let result = await dbQuery(UPDATE_ORDER, id);
  return result.rowCount > 0;
}
const updateExtraInfo = async (id, extraInfo) => {
  const UPDATE_EXTRA_INFO = "UPDATE clothing SET extra_info = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_EXTRA_INFO, extraInfo, id);
  return result.rowCount > 0;
}
const updateLocation = async (id, location) => {
  const UPDATE_LOCATION = "UPDATE clothing SET location = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_LOCATION, location, id);
  return result.rowCount > 0;
}
const updateInStock = async (id, boolean) => {
  const UPDATE_IN_STOCK = "UPDATE clothing SET in_stock = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_IN_STOCK, boolean, id);
  return result.rowCount > 0;
}
const updatePending = async (id, boolean) => {
  const UPDATE_ITEM_PENDING = "UPDATE clothing SET pending = $1 WHERE clothing.id = $2";
  let result = await dbQuery(UPDATE_ITEM_PENDING, boolean, id);
  return result.rowCount > 0;
}
const updateGroupShippingCost = async (pkgId, shippingCost) => {
  //working
  const UPDATE_SHIPPING_COST = "UPDATE clothing SET shipping_cost = $1 WHERE package_id = $2 AND (shipping_cost <= 0 OR shipping_cost IS NULL)";
  let result = await dbQuery(UPDATE_SHIPPING_COST, shippingCost, pkgId);
  return result.rowCount;
}

const destroy = async (id) => {
  const DELETE_ITEM = "DELETE FROM clothing WHERE clothing.id = $1";
  let deleteResult = await dbQuery(DELETE_ITEM, id);

  return deleteResult.rowCount > 0;
}

// const getColors = async () => {
//   let colorObj = {};
//   let items = await getAll();
//   items.forEach(item => {
//     let colors = item.colors.split(', ');
//     colors.forEach(color => {
//       if (!colorObj[color]) {
//         colorObj[color] = color;
//       }
//     });
//   })
  
//   return Object.keys(colorObj);
// }

const getBrands = async () => {
  let brandObj = {};
  let items = await getAll();
  items.forEach(item => {
    let brand = item.brand;
    if (!brandObj[brand]) {
      brandObj[brand] = brand;
    }
  })

  return Object.keys(brandObj);
}

const getTypes = async () => {
  let typeObj = {};
  let items = await getAll();
  items.forEach(item => {
    let type = item.type;
    if (!typeObj[type]) {
      typeObj[type] = type;
    }
  })

  return Object.keys(typeObj);
}

const getColors = async () => {
  let colorObj = {};
  let items = await getAll();
  items.forEach(item => {
    let colors = item.colors.split(', ');
    colors.forEach(color => {
      if (!colorObj[color]) {
        colorObj[color] = color;
      }
    })
  })

  return Object.keys(colorObj);
}

module.exports = {
  toggleSeen,
  findById,
  findByTag,
  getAll,
  getInStock,
  getPending,
  getAllWomens,
  getInStockWomens,
  getPendingWomens,
  getPendingMens, 
  getAllMens,
  getInStockMens,
  getFiltered,
  findInOrder,
  findInPackage,
  findInReceipt,
  create,
  update,
  duplicate,
  updateSize,
  updateBrand,
  updateType,
  updateColors,
  updateReceipt,
  updateTagNumber,
  updatePurchasePrice,
  updateSoldPrice,
  updatePackage,
  updateOrder,
  removeFromOrder,
  updateExtraInfo,
  updateLocation,
  updateInStock,
  updatePending,
  updateGroupShippingCost,
  destroy,
  getColors,
  getBrands,
  getTypes,
}