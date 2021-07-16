const { dbQuery } = require("../lib/db-query");

const authenticate = async (username, password) => {
  const FIND_HASHED_PASSWORD = "SELECT password FROM users" +
                               " WHERE username = $1";
  let result = await dbQuery(FIND_HASHED_PASSWORD, username);
  if (result.rowCount === 0) return false;

  return bcrypt.compare(password, result.rows[0].password);
}

const loginUser = async (username, sessionID) => {
  const LOGIN_USER = `UPDATE users 
    SET signed_in = true, session_id = ARRAY_APPEND(session_id, $2)
    WHERE username = $1`;
  let result = await dbQuery(LOGIN_USER, username, sessionID);

  return result.rowCount > 0;
}

const checkLoginStatus = async (sessionID) => {
  // "@>" checks if one array contains the values that are in another array
  const CHECK_STATUS = "SELECT signed_in FROM users WHERE session_id @> ARRAY[$1]";
  let result = await dbQuery(CHECK_STATUS, sessionID);
  if (result.rowCount === 0) return false;
  return result.rows[0].signed_in;
}

module.exports = {
  authenticate,
  loginUser,
  checkLoginStatus
};