const { dbQuery } = require('../lib/db-query');
const bcrypt = require('bcrypt');

const authenticate = async (username, password) => {
  const FIND_HASHED_PASSWORD = 'SELECT * FROM users' + ' WHERE username = $1';
  let result = await dbQuery(FIND_HASHED_PASSWORD, username);
  if (result.rowCount === 0) return false;

  const user = result.rows[0];
  const success = await bcrypt.compare(password, result.rows[0].password);
  return { user, success };
};

module.exports = {
  authenticate,
};
