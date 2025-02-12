const { dbQuery } = require('../lib/db-query');

const getAll = async () => {
  let text = `SELECT orders.*, customers.name 
  FROM orders 
  JOIN customers ON orders.customer_id = customers.id
  ORDER BY orders.id DESC`;
  let response = await dbQuery(text);
  return response.rows;
};

const findById = async (id) => {
  const ORDER = `SELECT orders.*, customers.name 
  FROM orders 
  JOIN customers ON orders.customer_id = customers.id
  WHERE orders.id = $1`;

  let result = await dbQuery(ORDER, id);
  return result.rows[0];
};

const _findCustomerByName = async (name) => {
  // make subquery with findOrderByCustomerName
  const CUSTOMER = 'SELECT id FROM customers WHERE name = $1';
  let result = await dbQuery(CUSTOMER, name);

  return result.rows[0];
};

const findByCustomerName = async (customerName) => {
  // make subquery with findCustomerByName
  let customer = await _findCustomerByName(customerName);
  const ORDER = 'SELECT * FROM orders WHERE customer_id = $1';
  let result = await dbQuery(ORDER, customer.id);
  return result.rows[0];
};

const getSorted = async () => {
  let orders = await this.getOrders();

  let complete = orders.filter((order) => order.status === 'complete');
  let returned = orders.filter((order) => order.status === 'returned');
  let active = orders.filter((order) => order.status === 'active');
  return [].concat(active, complete, returned);
};

const create = async (dataObj) => {
  const NEW_ORDER = `INSERT INTO orders (date_sent, customer_id, status)
  VALUES ($1, $2, $3)`;
  let result = await dbQuery(
    NEW_ORDER,
    dataObj.date_sent,
    dataObj.customer_id,
    dataObj.status
  );
  return result.rowCount > 0;
};

const update = async (dataObj) => {
  const UPDATE_ORDER = `UPDATE orders SET date_sent = $1, customer_id = $2, status = $3
  WHERE id = $4`;
  let result = await dbQuery(
    UPDATE_ORDER,
    dataObj.date_sent,
    dataObj.customer_id,
    dataObj.status,
    dataObj.id
  );
  return result.rowCount > 0;
};

const destroy = async (id) => {
  const REMOVE_ORDER_FROM_CLOTHING =
    'UPDATE clothing SET order_id = NULL WHERE order_id = $1';
  const DELETE_ORDER = 'DELETE FROM orders WHERE id = $1';
  await dbQuery(REMOVE_ORDER_FROM_CLOTHING, id);
  let result = await dbQuery(DELETE_ORDER, id);
  return result.rowCount > 0;
};

module.exports = {
  getAll,
  findById,
  findByCustomerName,
  getSorted,
  create,
  update,
  destroy,
};
