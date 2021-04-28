const { dbQuery } = require("./db-query");
const bcrypt = require('bcrypt');

const FIND_ITEM_TEXT = `SELECT clothing.id, size, brand, type, colors, receipt_id,
tag_number, purchase_price, sold_price, package_id, order_id, extra_info, 
seen, gender, style, picture, material, clothing.location, date_sold, clothing.date_created,
clothing.shipping_cost, in_stock, pending, receipts.tax, receipts.store, packages.package_name
FROM clothing 
LEFT JOIN receipts ON receipt_id = receipts.id
LEFT JOIN packages ON package_id = packages.id`; 

module.exports = class SessionPersistence {
  async authenticate(username, password) {
    const FIND_HASHED_PASSWORD = "SELECT password FROM users" +
                                 " WHERE username = $1";
    let result = await dbQuery(FIND_HASHED_PASSWORD, username);
    if (result.rowCount === 0) return false;

    return bcrypt.compare(password, result.rows[0].password);
  }

  async getPackages() {
    let text = "SELECT * FROM packages ORDER BY id DESC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getReceipts() {
    let text = "SELECT * FROM receipts ORDER BY id DESC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getCustomers() {
    let text = "SELECT * FROM customers ORDER BY id ASC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getOrders() {
    let text = `SELECT orders.*, customers.name 
    FROM orders 
    JOIN customers ON orders.customer_id = customers.id
    ORDER BY orders.id DESC`;
    let response = await dbQuery(text);
    return response.rows;
  }

  // async getItemsInOrders() {
  //   const ITEMS = FIND_ITEM_TEXT + " WHERE clothing.order_id IS NOT NULL";
  //   let response = await dbQuery(ITEMS);
  //   return response.rows;
  // }

  // toggle whether an item is physically seen or not
  async toggleSeen(itemId) {
    let item = await this.findItemById(itemId);
    const TOGGLE_TEXT = "UPDATE clothing SET seen = $1 WHERE clothing.id = $2";

    let result = await dbQuery(TOGGLE_TEXT, !item.seen, itemId);
    return result.rowCount > 0;
  }

  async findItemById(id) {
    const ITEM = FIND_ITEM_TEXT + " WHERE clothing.id = $1";

    let result = await dbQuery(ITEM, id);
    return result.rows[0];
  }
  async findItemsByTag(tagNumber) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE tag_number ILIKE $1";
    let result = await dbQuery(ITEMS, `%${tagNumber}%`);
    return result.rows;
  }
  async findCustomerById(id) {
    const CUSTOMER = `SELECT * FROM customers WHERE id = $1`;
    let result = await dbQuery(CUSTOMER, id);

    return result.rows[0];
  }
  async findCustomerByName(name) {
    const CUSTOMER = 'SELECT * FROM customers WHERE name = $1';
    let result = await dbQuery(CUSTOMER, name);

    return result.rows[0];
  }
  async findOrderById(id) {
    const ORDER = `SELECT orders.*, customers.name 
    FROM orders 
    JOIN customers ON orders.customer_id = customers.id
    WHERE orders.id = $1`;
  
    let result = await dbQuery(ORDER, id);
    return result.rows[0];
  }
  async findOrderByCustomerName(customerName) {
    let customer = await this.findCustomerByName(customerName);
    const ORDER = "SELECT * FROM orders WHERE customer_id = $1";
    let result = await dbQuery(ORDER, customer.id);
    return result.rows[0];
  }

  async findPackageById(id) {
    const PACKAGE = "SELECT * FROM packages WHERE id = $1";
    let result = await dbQuery(PACKAGE, id);
    return (result.rowCount > 0 && result.rows[0]);
  }
  async findReceiptById(id) {
    const RECEIPT = "SELECT * FROM receipts WHERE id = $1";
    let result = await dbQuery(RECEIPT, id);

    return result.rows[0];
  }

  sortItems(items) {
    return items.sort((a, b) => {
      if (a.tag_number > b.tag_number) return 1;
      if (a.tag_number < b.tag_number) return -1;
      return 0;
    });
  }

  async getSortedOrders() {
    let orders = await this.getOrders();

    let complete = orders.filter(order => order.status === 'complete');
    let returned = orders.filter(order => order.status === 'returned');
    let active = orders.filter(order => order.status === 'active');
    return [].concat(active, complete, returned);
  }

  async getAllItems() {
    const ALL_ITEMS = FIND_ITEM_TEXT + ' ORDER BY tag_number';

    let result = await dbQuery(ALL_ITEMS);
    return this.sortItems(result.rows);
  }

  async getInStockItems() {
    const IN_STOCK_ITEMS = FIND_ITEM_TEXT + ' WHERE in_stock = true';
    let result = await dbQuery(IN_STOCK_ITEMS);
    return this.sortItems(result.rows);
  }

  async getAllWomensClothing() {
    const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women'";
    let result = await dbQuery(WOMENS_CLOTHING);
    return this.sortItems(result.rows);
  }

  async getInStockWomensClothing() {
    const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women' AND in_stock = true";
    let result = await dbQuery(WOMENS_CLOTHING);
    return this.sortItems(result.rows);
  }

  async getAllMensClothing() {
    const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men'";
    let result = await dbQuery(MENS_CLOTHING);
    return this.sortItems(result.rows);
  }

  async getInStockMensClothing() {
    const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men' AND in_stock = true";
    let result = await dbQuery(MENS_CLOTHING);
    return this.sortItems(result.rows);
  }

  async getFilteredItems(filterString) {
    let filterItemsText = FIND_ITEM_TEXT + ` ${filterString}`;
    let result = await dbQuery(filterItemsText);

    return this.sortItems(result.rows);
  }

  async getOrderItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE order_id = $1 ORDER BY tag_number";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
  }
  async getPackageItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE package_id = $1 ORDER BY tag_number";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
  }
  async getReceiptItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE receipt_id = $1 ORDER BY tag_number";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
  }

  async createItem(dataObj) {
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

  async createCustomer(dataObj) {
    const NEW_CUSTOMER = `INSERT INTO customers (name, email, phone, address, extra_info)
  VALUES ($1, $2, $3, $4, $5)`;
    let result = await dbQuery(NEW_CUSTOMER, dataObj.name, dataObj.email, dataObj.phone, dataObj.address, dataObj.extra_info);
    return result.rowCount > 0;
  }
  async createOrder(dataObj) {
    const NEW_ORDER = `INSERT INTO orders (date_sent, customer_id, status)
    VALUES ($1, $2, $3)`;
    let result = await dbQuery(NEW_ORDER, dataObj.date_sent, dataObj.customer_id, dataObj.status);
    return result.rowCount > 0;
  }
  async createPackage(dataObj) {
    const NEW_PACKAGE = `INSERT INTO packages (price, date_sent, tracking_number, package_name)
    VALUES ($1, $2, $3, $4)`;
    let result = await dbQuery(NEW_PACKAGE, dataObj.price, dataObj.date_sent, dataObj.tracking_number, dataObj.package_name);
    return result.rowCount > 0;
  }
  async createReceipt(dataObj) {
    const NEW_RECEIPT = `INSERT INTO receipts (store, tax, purchase_date)
    VALUES ($1, $2, $3)`;
    let result = await dbQuery(NEW_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchase_date);
    return result.rowCount > 0;
  }

  async updateItem(itemId, dataObj) {
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

  async duplicateItem(itemId) {
    const DUPLICATE_ITEM = `INSERT INTO clothing (size, brand, type, colors, tag_number, purchase_price, extra_info, 
    gender, picture, style, material, in_stock)
    SELECT size, brand, type, colors, tag_number, purchase_price, extra_info, gender, picture, style, material, in_stock
    FROM clothing WHERE id = $1 RETURNING id`;

    let result = await dbQuery(DUPLICATE_ITEM, itemId);

    return result.rows[0].id;
  }

  async updateItemSize(id, size) {
    const UPDATE_SIZE = "UPDATE clothing SET size = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_SIZE, size, id);

    return result.rowCount > 0;
  }
  async updateItemBrand(id, brand) {
    // let brandId = await this.findBrandId(brand);
    const UPDATE_BRAND = "UPDATE clothing SET brand_id = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_BRAND, brand, id);

    return result.rowCount > 0;
  }
  async updateItemType(id, type) {
    // let typeId = await this.findTypeId(type);
    const UPDATE_TYPE = "UPDATE clothing SET type_id = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_TYPE, type, id);

    return result.rowCount > 0;
  }
  async updateItemColors(id, colorString) {
    const UPDATE_COLORS = "UPDATE clothing SET colors = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_COLORS, colorString, id);
    return result.rowCount > 0;
  }
  async updateItemReceipt(id, receiptId) {
    const UPDATE_RECEIPT = "UPDATE clothing SET receipt_id = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_RECEIPT, receiptId, id);
    return result.rowCount > 0;
  }
  async updateItemTagNumber(id, tagNumber) {
    const UPDATE_TAG = "UPDATE clothing SET tag_number = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_TAG, tagNumber, id);
    return result.rowCount > 0;
  }
  async updateItemPurchasePrice(id, purchasePrice) {
    const UPDATE_P_PRICE = "UPDATE clothing SET purchase_price = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_P_PRICE, purchasePrice, id);
    return result.rowCount > 0;
  }
  async updateItemSoldPrice(id, soldPrice) {
    const UPDATE_SOLD_PRICE = "UPDATE clothing SET sold_price = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_SOLD_PRICE, soldPrice, id);
    return result.rowCount > 0;
  }
  async updateItemPackage(id, packageId) {
    const UPDATE_PACKAGE = "UPDATE clothing SET package_id = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_PACKAGE, packageId, id);
    return result.rowCount > 0;
  }
  async updateItemOrder(id, orderId) {
    const UPDATE_ORDER = "UPDATE clothing SET order_id = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_ORDER, orderId, id);
    return result.rowCount > 0;
  }
  async removeItemFromOrder(id) {
    const UPDATE_ORDER = "UPDATE clothing SET order_id = NULL WHERE clothing.id = $1";
    let result = await dbQuery(UPDATE_ORDER, id);
    return result.rowCount > 0;
  }
  async updateItemExtraInfo(id, extraInfo) {
    const UPDATE_EXTRA_INFO = "UPDATE clothing SET extra_info = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_EXTRA_INFO, extraInfo, id);
    return result.rowCount > 0;
  }
  async updateItemLocation(id, location) {
    const UPDATE_LOCATION = "UPDATE clothing SET location = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_LOCATION, location, id);
    return result.rowCount > 0;
  }
  async updateItemInStock(id, boolean) {
    const UPDATE_IN_STOCK = "UPDATE clothing SET in_stock = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_IN_STOCK, boolean, id);
    return result.rowCount > 0;
  }
  async updateItemPending(id, boolean) {
    const UPDATE_ITEM_PENDING = "UPDATE clothing SET pending = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_ITEM_PENDING, boolean, id);
    return result.rowCount > 0;
  }

  async deleteItem(id) {
    const DELETE_ITEM = "DELETE FROM clothing WHERE clothing.id = $1";
    let deleteResult = await dbQuery(DELETE_ITEM, id);

    return deleteResult.rowCount > 0;
  }


  async updateCustomer(dataObj) {
    const UPDATE_CUSTOMER = `UPDATE customers
    SET name = $1, email = $2, address = $3, phone = $4, extra_info = $5
    WHERE id = $6`;

    let result = await dbQuery(UPDATE_CUSTOMER, dataObj.name, dataObj.email, dataObj.address, dataObj.phone, dataObj.extra_info, dataObj.id);

    return result.rowCount > 0;
  }

  async deleteCustomer(id) {
    const REMOVE_CUSTOMER_FROM_ORDERS = `UPDATE orders
    SET customer_id = NULL WHERE customer_id = $1`;
    const DELETE_CUSTOMER = "DELETE FROM customers WHERE id = $1";

    let orderResult = await dbQuery(REMOVE_CUSTOMER_FROM_ORDERS, id);
    let customerResult = await dbQuery(DELETE_CUSTOMER, id);

    return customerResult.rowCount > 0;
  }

  async updateOrder(dataObj) {
    const UPDATE_ORDER = `UPDATE orders SET date_sent = $1, customer_id = $2, status = $3
    WHERE id = $4`;
    let result = await dbQuery(UPDATE_ORDER, dataObj.date_sent, dataObj.customer_id, dataObj.status, dataObj.id);
    return result.rowCount > 0;
  }

  async deleteOrder(id) {
    const REMOVE_ORDER_FROM_CLOTHING = "UPDATE clothing SET order_id = NULL WHERE order_id = $1";
    const DELETE_ORDER = "DELETE FROM orders WHERE id = $1";
    await dbQuery(REMOVE_ORDER_FROM_CLOTHING, id);
    let result = await dbQuery(DELETE_ORDER, id);
    return result.rowCount > 0;
  }
  async updatePackage(dataObj) {
    const UPDATE_PACKAGE = `UPDATE packages SET price = $1, date_sent = $2, tracking_number = $3, package_name = $4
    WHERE id = $5`;
    let result = await dbQuery(UPDATE_PACKAGE, dataObj.price, dataObj.date_sent, dataObj.tracking_number, dataObj.package_name, dataObj.id);
    return result.rowCount > 0;
  }
  async deletePackage(id) {
    const REMOVE_PACKAGE_FROM_CLOTHING = `UPDATE clothing SET package_id = NULL
    WHERE package_id = $1`;
    const DELETE_PACKAGE = "DELETE FROM packages WHERE id = $1";
    await dbQuery(REMOVE_PACKAGE_FROM_CLOTHING, id);
    let result = await dbQuery(DELETE_PACKAGE, id);

    return result.rowCount > 0;
  }
  async updateReceipt(dataObj) {
    const UPDATE_RECEIPT = `UPDATE receipts
    SET store = $1, tax = $2, purchase_date = $3
    WHERE id = $4`;
    let result = await dbQuery(UPDATE_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchase_date, dataObj.id);
    return result.rowCount > 0;
  }

  async deleteReceipt(id) {
    const REMOVE_RECEIPT_FROM_CLOTHING = "UPDATE clothing SET receipt_id = NULL WHERE receipt_id = $1";
    const REMOVE_RECEIPT = "DELETE FROM receipts WHERE id = $1";

    await dbQuery(REMOVE_RECEIPT_FROM_CLOTHING, id);
    let result = await dbQuery(REMOVE_RECEIPT, id);

    return result.rowCount > 0;
  }

  async getColors() {
    let colorObj = {};
    let items = await this.getAllItems();
    items.forEach(item => {
      let colors = item.colors.split(', ');
      colors.forEach(color => {
        if (!colorObj[color]) {
          colorObj[color] = color;
        }
      });
    })
    
    return Object.keys(colorObj);
  }

  async getBrands() {
    let brandObj = {};
    let items = await this.getAllItems();
    items.forEach(item => {
      let brand = item.brand;
      if (!brandObj[brand]) {
        brandObj[brand] = brand;
      }
    })

    return Object.keys(brandObj);
  }

  async getTypes() {
    let typeObj = {};
    let items = await this.getAllItems();
    items.forEach(item => {
      let type = item.type;
      if (!typeObj[type]) {
        typeObj[type] = type;
      }
    })

    return Object.keys(typeObj);
  }

  filterForBrands(items=[]) {
    let brandObj = {};
    let filtered = [];
  
    items.forEach(item => {
      let brand = item.brand;
      if (!brandObj[brand]) {
        brandObj[brand] = brand;
        filtered.push(item);
      }
    })
  
    return this._sortBrandsAlphabetically(filtered);
  };
  
  filterForTypes(items=[]) {
    let typeObj = {};
    let filtered = [];
  
    items.forEach(item => {
      let type = item.type;
      if (!typeObj[type]) {
        typeObj[type] = type;
        filtered.push(item);
      }
    })

    return this._sortTypesAlphabetically(filtered);
  };

  filterForColors(items=[]) {
    let colorObj = {};
    let filtered = [];

    items.forEach(item => {
      let colors = item.colors.split(', ');
      colors.forEach(color => {
        if (!colorObj[color]) {
          colorObj[color] = color;
          filtered.push({colors: color});
        }
      });
    })
    
    return this._sortColorsAlphabetically(filtered);
  }

  filterForSizes(items=[]) {
    let sizeObj = {};
    let filtered = [];
  
    items.forEach(item => {
      let size = item.size;
      if (!sizeObj[size]) {
        sizeObj[size] = size;
        filtered.push(item);
      }
    })

    return this._sortSizesAlphabetically(filtered);
  };

  filterForLocations(items) {
    let filtered = [{location: 'usa'}, {location: 'ukraine'}, {location: 'jenia'}];

    return this._sortLocationsAlphabetically(filtered);
  };

  async _addTotalCost(item) {

    
  }

  _sortBrandsAlphabetically(items) {
    return items.sort((a, b) => {
      if (a.brand > b.brand) return 1;
      if (a.brand < b.brand) return -1;
      return 0;
    });
  }

  _sortTypesAlphabetically(items) {
    return items.sort((a, b) => {
      if (a.type > b.type) return 1;
      if (a.type < b.type) return -1;
      return 0;
    });
  }

  _sortColorsAlphabetically(items) {
    return items.sort((a, b) => {
      if (a.colors > b.colors) return 1;
      if (a.colors < b.colors) return -1;
      return 0;
    })
  }

  _sortSizesAlphabetically(items) {
    return items.sort((a, b) => {
      if (a.size > b.size) return -1;
      if (a.size < b.size) return 1;
      return 0;
    })
  }

  _sortLocationsAlphabetically(items) {
    return items.sort((a, b) => {
      if (a.location > b.location) return 1;
      if (a.location < b.location) return -1;
      return 0;
    })
  }
  
};



 // how to check the values of items with tax and + 25% (for selling to Alla)

// SELECT id, tag_number, ROUND((.25 * (purchase_price + (purchase_price * COALESCE(tax, 8) / 100.0))) + (purchase_price + (purchase_price * COALESCE(tax, 8) / 100.0)), 2) AS sold_price
// FROM (SELECT clothing.id, tag_number, purchase_price, receipts.tax, package_id
// FROM clothing 
// LEFT JOIN receipts ON receipt_id = receipts.id
// WHERE order_id = 8
// ORDER BY tag_number ASC) AS foo;


// UPDATE clothing
// SET order_id = 9 WHERE package_id = 31;
