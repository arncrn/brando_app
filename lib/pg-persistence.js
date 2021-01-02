const { dbQuery } = require("./db-query");

const FIND_ITEM_TEXT = `SELECT clothing.id, size, brand, type, colors, receipt_id,
tag_number, purchase_price, sold_price, package_id, order_id, extra_info, 
seen, gender, style, picture, material, clothing.location, date_sold, clothing.date_created,
receipts.tax, packages.package_name
FROM clothing 
LEFT JOIN receipts ON receipt_id = receipts.id
LEFT JOIN packages ON package_id = packages.id`; 

module.exports = class SessionPersistence {
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
    const TOGGLE_TEXT = "UPDATE clothing SET seen = $1 WHERE clothing.id = $2";

    let result = await dbQuery(TOGGLE_TEXT, !item.seen, itemId);
    return result.rowCount > 0;
  }

  async findItemById(id) {
    const ITEM = FIND_ITEM_TEXT + " WHERE clothing.id = $1";

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

    // let sold = items.filter(item => item.sold_price > 0).sort();
    // let unsold = items.filter(item => !item.sold_price > 0).sort();

    // return [].concat(unsold, sold);
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

  async getWomensClothing() {
    const WOMENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'women'";
    let result = await dbQuery(WOMENS_CLOTHING);
    return this.sortItems(result.rows);
  }

  async getMensClothing() {
    const MENS_CLOTHING = FIND_ITEM_TEXT + " WHERE gender = 'men'";
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

  async updateItem(itemId, dataObj) {
    const UPDATE_ITEM = `UPDATE clothing SET tag_number = $1, gender = $2, size = $3, brand = $4, 
    colors = $5, type = $6, receipt_id = $7, purchase_price = $8, shipping_cost = $9, sold_price = $10,
    location = $11, package_id = $12, order_id = $13, material = $14, 
    style = $15, extra_info = $16, date_sold = $17
    WHERE id = $18`;

    let result = await dbQuery(UPDATE_ITEM, dataObj.tag_number, dataObj.gender, dataObj.size, 
      dataObj.brand, dataObj.colors, dataObj.type, dataObj.receipt_id, dataObj.purchase_price,
      dataObj.shipping_cost, dataObj.sold_price, dataObj.location, dataObj.package_id, dataObj.order_id,
      dataObj.material, dataObj.style, dataObj.extra_info, dataObj.date_sold, itemId);

    return result.rowCount > 0;
  }

  async duplicateItem(itemId) {
    const DUPLICATE_ITEM = `INSERT INTO clothing (size, brand, type, colors, tag_number, purchase_price, extra_info, 
    gender, picture, style, material)
    SELECT size, brand, type, colors, tag_number, purchase_price, extra_info, gender, picture, style, material
    FROM clothing WHERE id = $1 RETURNING id`;

    let result = await dbQuery(DUPLICATE_ITEM, itemId);

    return result.rows[0].id;
  }

  // async updateItem(dataObj, item) {
  //   let queries = [];
  //   let id = item.id;

  //   for (let prop in dataObj) {
  //     if (dataObj[prop] !== item[prop]) {
  //       switch (prop) {
  //         case 'size':
  //           queries.push(await this.updateItemSize(id, dataObj[prop]));
  //           break;
  //         case 'brand':
  //           queries.push(await this.updateItemBrand(id, dataObj[prop])); // fix
  //           break;
  //         case 'type':
  //           queries.push(await this.updateItemType(id, dataObj[prop])); // fix
  //           break;
  //         case 'colors':
  //           queries.push(await this.updateItemColors(id, dataObj[prop])); // fix
  //           break;
  //         case 'receipt_id':
  //           queries.push(await this.updateItemReceipt(id, dataObj[prop]));
  //           break;
  //         case 'tag_number':
  //           queries.push(await this.updateItemTagNumber(id, dataObj[prop]));
  //           break;
  //         case 'purchase_price':
  //           queries.push(await this.updateItemPurchasePrice(id, dataObj[prop]));
  //           break;
  //         case 'sold_price':
  //           queries.push(await this.updateItemSoldPrice(id, dataObj[prop]));
  //           break;
  //         case 'package_id':
  //           queries.push(await this.updateItemPackage(id, dataObj[prop]));
  //           break;
  //         case 'order_id':
  //           queries.push(await this.updateItemOrder(id, dataObj[prop]));
  //           break;
  //         case 'extra_info':
  //           queries.push(await this.updateItemExtraInfo(id, dataObj[prop]));
  //           break;
  //       }
  //     }
  //   }

  //   let queryResults = await Promise.all(queries);
  //   // console.log(queryResults);
  //   return queryResults.every(result => result);
  // }

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
    const UPDATE_S_PRICE = "UPDATE clothing SET sold_price = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_S_PRICE, soldPrice, id);
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
  async updateItemExtraInfo(id, extraInfo) {
    const UPDATE_EXTRA_INFO = "UPDATE clothing SET extra_info = $1 WHERE clothing.id = $2";
    let result = await dbQuery(UPDATE_EXTRA_INFO, extraInfo, id);
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
    // let locationObj = {};
    // let filtered = [];
  
    // items.forEach(item => {
    //   let location = item.location;
    //   if (!locationObj[location]) {
    //     locationObj[location] = location;
    //     filtered.push(item);
    //   }
    // })

    let filtered = [{location: 'usa'}, {location: 'ukraine'}, {location: 'traveling'}];

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

