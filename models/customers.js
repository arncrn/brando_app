const { dbQuery } = require("../lib/db-query");

const getAll = async () => {
  let text = "SELECT * FROM customers ORDER BY id ASC";
  let response = await dbQuery(text);
  return response.rows;
}

const findById = async (id) => {
  const CUSTOMER = `SELECT * FROM customers WHERE id = $1`;
  let result = await dbQuery(CUSTOMER, id);

  return result.rows[0];
}
const findByName = async (name) => {
  const CUSTOMER = 'SELECT * FROM customers WHERE name = $1';
  let result = await dbQuery(CUSTOMER, name);

  return result.rows[0];
}

// const findOrderByCustomerName = async (customerName) => {  // multiple places?
//   let customer = await this.findCustomerByName(customerName);
//   const ORDER = "SELECT * FROM orders WHERE customer_id = $1";
//   let result = await dbQuery(ORDER, customer.id);
//   return result.rows[0];
// }



const create = async (dataObj) => {
  const NEW_CUSTOMER = `INSERT INTO customers (name, email, phone, address, extra_info)
VALUES ($1, $2, $3, $4, $5)`;
  let result = await dbQuery(NEW_CUSTOMER, dataObj.name, dataObj.email, dataObj.phone, dataObj.address, dataObj.extra_info);
  return result.rowCount > 0;
}



const update = async (dataObj) => {
  const UPDATE_CUSTOMER = `UPDATE customers
  SET name = $1, email = $2, address = $3, phone = $4, extra_info = $5
  WHERE id = $6`;

  let result = await dbQuery(UPDATE_CUSTOMER, dataObj.name, dataObj.email, dataObj.address, dataObj.phone, dataObj.extra_info, dataObj.id);

  return result.rowCount > 0;
}

const destroy = async (id) => {
  const REMOVE_CUSTOMER_FROM_ORDERS = `UPDATE orders
  SET customer_id = NULL WHERE customer_id = $1`;
  const DELETE_CUSTOMER = "DELETE FROM customers WHERE id = $1";

  let orderResult = await dbQuery(REMOVE_CUSTOMER_FROM_ORDERS, id);
  let customerResult = await dbQuery(DELETE_CUSTOMER, id);

  return customerResult.rowCount > 0;
}

module.exports = {
  getAll,
  findById,
  findByName,
  create,
  update,
  destroy
};