const { dbQuery } = require('../lib/db-query');

const getAll = async () => {
  let text = 'SELECT * FROM packages ORDER BY id DESC';
  let response = await dbQuery(text);
  return response.rows;
};

const getForAlla = async () => {
  const text =
    "SELECT * FROM packages WHERE package_name ILIKE '%alla%' ORDER BY id DESC";
  let response = await dbQuery(text);
  return response.rows;
};

const findById = async (id) => {
  const PACKAGE = 'SELECT * FROM packages WHERE id = $1';
  let result = await dbQuery(PACKAGE, id);
  return result.rowCount > 0 && result.rows[0];
};

const create = async (dataObj) => {
  const NEW_PACKAGE = `INSERT INTO packages (price, date_sent, tracking_number, package_name)
  VALUES ($1, $2, $3, $4)`;
  let result = await dbQuery(
    NEW_PACKAGE,
    dataObj.price,
    dataObj.date_sent,
    dataObj.tracking_number,
    dataObj.package_name
  );
  return result.rowCount > 0;
};

const update = async (dataObj) => {
  const UPDATE_PACKAGE = `UPDATE packages SET price = $1, date_sent = $2, tracking_number = $3, package_name = $4
  WHERE id = $5`;
  let result = await dbQuery(
    UPDATE_PACKAGE,
    dataObj.price,
    dataObj.date_sent,
    dataObj.tracking_number,
    dataObj.package_name,
    dataObj.id
  );
  return result.rowCount > 0;
};
const destroy = async (id) => {
  const REMOVE_PACKAGE_FROM_CLOTHING = `UPDATE clothing SET package_id = NULL
  WHERE package_id = $1`;
  const DELETE_PACKAGE = 'DELETE FROM packages WHERE id = $1';
  await dbQuery(REMOVE_PACKAGE_FROM_CLOTHING, id);
  let result = await dbQuery(DELETE_PACKAGE, id);

  return result.rowCount > 0;
};

module.exports = {
  getAll,
  getForAlla,
  findById,
  create,
  update,
  destroy,
};
