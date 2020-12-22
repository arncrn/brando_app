const { dbQuery } = require("./db-query");
const getTotalCost = require("./total-cost");

const FIND_ITEM_TEXT = `SELECT c.id, c.size, c.brand, c.type, c.colors, c.receipt_id,
c.tag_number, c.purchase_price, c.sold_price, c.package_id, c.order_id, c.extra_info, 
c.seen, c.gender, c.style, c.picture, c.material , c.location
FROM clothing AS c`;

module.exports = class SessionPersistence {
  async totalCost() {
    let items = this.getAllItems();
    let packages = this.getPackages();
    let receipts = this.getReceipts();

    let data = await Promise.all([items, packages, receipts]);
    return function(item) {
      return getTotalCost(item, data[0], data[1], data[2]);
    }
  }

  async getPackages() {
    let text = "SELECT * FROM packages ORDER BY id ASC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getReceipts() {
    let text = "SELECT * FROM receipts ORDER BY id ASC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getCustomers() {
    let text = "SELECT * FROM customers ORDER BY id ASC";
    let response = await dbQuery(text);
    return response.rows;
  }

  async getOrders() {
    let text = "SELECT * FROM orders ORDER BY id ASC";
    let response = await dbQuery(text);
    return response.rows;
  }

  // toggle whether an item is physically seen or not
  async toggleSeen(itemId) {
    let item = await this.findItemById(itemId);
    const TOGGLE_TEXT = "UPDATE clothing SET seen = $1 WHERE id = $2";

    let result = await dbQuery(TOGGLE_TEXT, !item.seen, itemId);
    return result.rowCount > 0;
  }

  async findItemById(id) {
    const ITEM = FIND_ITEM_TEXT + " WHERE c.id = $1";

    let result = await dbQuery(ITEM, id);
    return result.rows[0];
  }
  async findCustomerById(id) {
    const CUSTOMER = `SELECT * FROM customers WHERE id = $1`;
    let result = await dbQuery(CUSTOMER, id);

    return result.rows[0];
  }
  async findOrderById(id) {
    const ORDER = "SELECT * FROM orders WHERE id = $1";
    let result = await dbQuery(ORDER, id);
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
    // question!!! what is `.sort()` sorting by?
    let sold = items.filter(item => item.sold_price > 0).sort();
    let unsold = items.filter(item => !item.sold_price > 0).sort();

    return [].concat(unsold, sold);
  }

  async getSortedOrders() {
    let orders = await this.getOrders();

    let complete = orders.filter(order => order.status === 'complete');
    let returned = orders.filter(order => order.status === 'returned');
    let active = orders.filter(order => order.status === 'active');
    return [].concat(active, complete, returned);
  }

  async getAllItems() {
    const ALL_ITEMS = FIND_ITEM_TEXT;

    let result = await dbQuery(ALL_ITEMS);
    return this.sortItems(result.rows);
  }

  getFilteredItems(id, type) {
    // let items = this._itemList.items.filter(item => +item[`${type}`] === +id);
    // return this.sortItems(items);
  }

  async getOrderItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " HAVING c.order_id = $1";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
    // return this.getFilteredItems(id, 'order')
  }
  async getPackageItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE c.package_id = $1";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
  }
  async getReceiptItems(id) {
    const ITEMS = FIND_ITEM_TEXT + " WHERE c.receipt_id = $1";

    let result = await dbQuery(ITEMS, id);

    return result.rows;
  }

  async createItem(dataObj) {
    let result;
    let size = dataObj.size;
    let brand = dataObj.brand;
    let type = dataObj.type;
    let tagNumber = dataObj.tag_number;
    let purchasePrice = dataObj.purchase_price;
    let receiptId = dataObj.receipt_id;
    let soldPrice = dataObj.sold_price;
    let packageId = dataObj.package_id;
    let orderId = dataObj.order_id;
    let extra_info = dataObj.extra_info;
    let colors = dataObj.colors;

    const CREATE_ITEM = `INSERT INTO clothing
    (size, brand, type, tag_number, purchase_price, receipt_id, sold_price, package_id, order_id, extra_info, colors)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`;

    try {
      result = await dbQuery(CREATE_ITEM, size, brand, type, tagNumber, purchasePrice, receiptId, soldPrice, packageId, orderId, extra_info, colors);
    } catch (error) {
      console.log(error);
      return false;
    }

    return result.rowCount > 0;
  }

  async createCustomer(dataObj) {
    const NEW_CUSTOMER = `INSERT INTO customers (name, email, phone, address, extra_info)
  VALUES ($1, $2, $3, $4, $5)`;
    let result = await dbQuery(NEW_CUSTOMER, dataObj.name, dataObj.email, dataObj.phone, dataObj.address, dataObj.extraInfo);
    return result.rowCount > 0;
  }
  async createOrder(dataObj) {
    const NEW_ORDER = `INSERT INTO orders (date_sent, customer_id, status)
    VALUES ($1, $2, $3)`;
    let result = await dbQuery(NEW_ORDER, dataObj.dateSent, dataObj.customerId, dataObj.status);
    return result.rowCount > 0;
  }
  async createPackage(dataObj) {
    const NEW_PACKAGE = `INSERT INTO packages (price, date_sent, date_arrived, package_name)
    VALUES ($1, $2, $3, $4)`;
    let result = await dbQuery(NEW_PACKAGE, dataObj.price, dataObj.dateSent, dataObj.dateArrived, dataObj.packageName);
    return result.rowCount > 0;
  }
  async createReceipt(dataObj) {
    const NEW_RECEIPT = `INSERT INTO receipts (store, tax, purchase_date)
    VALUES ($1, $2, $3)`;
    let result = await dbQuery(NEW_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchaseDate);
    return result.rowCount > 0;
  }

  async updateItem(dataObj, item) {
    let queries = [];
    let id = item.id;

    for (let prop in dataObj) {
      if (dataObj[prop] !== item[prop]) {
        switch (prop) {
          case 'size':
            queries.push(await this.updateItemSize(id, dataObj[prop]));
            break;
          case 'brand':
            queries.push(await this.updateItemBrand(id, dataObj[prop])); // fix
            break;
          case 'type':
            queries.push(await this.updateItemType(id, dataObj[prop])); // fix
            break;
          case 'colors':
            queries.push(await this.updateItemColors(id, dataObj[prop])); // fix
            break;
          case 'receipt_id':
            queries.push(await this.updateItemReceipt(id, dataObj[prop]));
            break;
          case 'tag_number':
            queries.push(await this.updateItemTagNumber(id, dataObj[prop]));
            break;
          case 'purchase_price':
            queries.push(await this.updateItemPurchasePrice(id, dataObj[prop]));
            break;
          case 'sold_price':
            queries.push(await this.updateItemSoldPrice(id, dataObj[prop]));
            break;
          case 'package_id':
            queries.push(await this.updateItemPackage(id, dataObj[prop]));
            break;
          case 'order_id':
            queries.push(await this.updateItemOrder(id, dataObj[prop]));
            break;
          case 'extra_info':
            queries.push(await this.updateItemExtraInfo(id, dataObj[prop]));
            break;
        }
      }
    }

    let queryResults = await Promise.all(queries);
    // console.log(queryResults);
    return queryResults.every(result => result);
  }

  async updateItemSize(id, size) {
    const UPDATE_SIZE = "UPDATE clothing SET size = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_SIZE, size, id);

    return result.rowCount > 0;
  }
  async updateItemBrand(id, brand) {
    // let brandId = await this.findBrandId(brand);
    const UPDATE_BRAND = "UPDATE clothing SET brand_id = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_BRAND, brand, id);

    return result.rowCount > 0;
  }
  async updateItemType(id, type) {
    // let typeId = await this.findTypeId(type);
    const UPDATE_TYPE = "UPDATE clothing SET type_id = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_TYPE, type, id);

    return result.rowCount > 0;
  }
  async updateItemColors(id, colorString) {
    const UPDATE_COLORS = "UPDATE clothing SET colors = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_COLORS, colorString, id);
    return result.rowCount > 0;
  }
  async updateItemReceipt(id, receiptId) {
    const UPDATE_RECEIPT = "UPDATE clothing SET receipt_id = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_RECEIPT, receiptId, id);
    return result.rowCount > 0;
  }
  async updateItemTagNumber(id, tagNumber) {
    const UPDATE_TAG = "UPDATE clothing SET tag_number = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_TAG, tagNumber, id);
    return result.rowCount > 0;
  }
  async updateItemPurchasePrice(id, purchasePrice) {
    const UPDATE_P_PRICE = "UPDATE clothing SET purchase_price = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_P_PRICE, purchasePrice, id);
    return result.rowCount > 0;
  }
  async updateItemSoldPrice(id, soldPrice) {
    const UPDATE_S_PRICE = "UPDATE clothing SET sold_price = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_S_PRICE, soldPrice, id);
    return result.rowCount > 0;
  }
  async updateItemPackage(id, packageId) {
    const UPDATE_PACKAGE = "UPDATE clothing SET package_id = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_PACKAGE, packageId, id);
    return result.rowCount > 0;
  }
  async updateItemOrder(id, orderId) {
    const UPDATE_ORDER = "UPDATE clothing SET order_id = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_ORDER, orderId, id);
    return result.rowCount > 0;
  }
  async updateItemExtraInfo(id, extraInfo) {
    const UPDATE_EXTRA_INFO = "UPDATE clothing SET extra_info = $1 WHERE id = $2";
    let result = await dbQuery(UPDATE_EXTRA_INFO, extraInfo, id);
    return result.rowCount > 0;
  }

  async deleteItem(id) {
    const DELETE_ITEM = "DELETE FROM clothing WHERE id = $1";
    let deleteResult = await dbQuery(DELETE_ITEM, id);

    return deleteResult.rowCount > 0;
  }


  async updateCustomer(dataObj) {
    const UPDATE_CUSTOMER = `UPDATE customers
    SET name = $1, email = $2, address = $3, phone = $4, extra_info = $5
    WHERE id = $6`;

    let result = await dbQuery(UPDATE_CUSTOMER, dataObj.name, dataObj.email, dataObj.address, dataObj.phone, dataObj.extraInfo, dataObj.id);

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
    let result = await dbQuery(UPDATE_ORDER, dataObj.dateSent, dataObj.customerId, dataObj.status, dataObj.id);
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
    const UPDATE_PACKAGE = `UPDATE packages SET price = $1, date_sent = $2, date_arrived = $3, package_name = $4
    WHERE id = $5`;
    let result = await dbQuery(UPDATE_PACKAGE, dataObj.price, dataObj.dateSent, dataObj.dateArrived, dataObj.packageName, dataObj.id);
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
    let result = await dbQuery(UPDATE_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchaseDate, dataObj.id);
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
};