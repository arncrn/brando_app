const jwt = require('jsonwebtoken');
const config = require('../lib/config');

const secretKey = config.SECRET;

function requiresAuthentication(req, res, next) {
  const token = req.cookies && req.cookies['auth-key'];

  if (!token) {
    return res.redirect('/login');
  }

  try {
    req.user = jwt.verify(token, secretKey);
    next();
  } catch (error) {
    console.error(error);
    res.clearCookie('auth-key');
    return res.redirect('/login');
  }
}

module.exports = {
  requiresAuthentication,
};
