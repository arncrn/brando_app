const { dbQuery } = require("./db-query");
const bcrypt = require('bcrypt');
// set the sequence for the table id to be the next value after tha current max value
// SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('packages', 'id'), MAX(id)) FROM packages;

module.exports = class SessionPersistence {
  

  
  
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
