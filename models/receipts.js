const { dbQuery } = require("../lib/db-query");

const getAll = async () => {
  let text = "SELECT * FROM receipts ORDER BY id DESC";
  let response = await dbQuery(text);
  return response.rows;
}

const findById = async (id) => {
  const RECEIPT = "SELECT * FROM receipts WHERE id = $1";
  let result = await dbQuery(RECEIPT, id);

  return result.rows[0];
}

const create = async (dataObj) => {
  const NEW_RECEIPT = `INSERT INTO receipts (store, tax, purchase_date)
  VALUES ($1, $2, $3)`;
  let result = await dbQuery(NEW_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchase_date);
  return result.rowCount > 0;
}

const update = async (dataObj) => {
  const UPDATE_RECEIPT = `UPDATE receipts
  SET store = $1, tax = $2, purchase_date = $3
  WHERE id = $4`;
  let result = await dbQuery(UPDATE_RECEIPT, dataObj.store, dataObj.tax, dataObj.purchase_date, dataObj.id);
  return result.rowCount > 0;
}

const destroy = async (id) => {
  const REMOVE_RECEIPT_FROM_CLOTHING = "UPDATE clothing SET receipt_id = NULL WHERE receipt_id = $1";
  const REMOVE_RECEIPT = "DELETE FROM receipts WHERE id = $1";

  await dbQuery(REMOVE_RECEIPT_FROM_CLOTHING, id);
  let result = await dbQuery(REMOVE_RECEIPT, id);

  return result.rowCount > 0;
}

module.exports = {
  getAll,
  findById,
  create,
  update,
  destroy
}