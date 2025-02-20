const jwt = require('jsonwebtoken');
const config = require('../lib/config');

const secretKey = config.SECRET;

// General application authentication
function requiresAuthentication(req, res, next) {
  const token = req.cookies && req.cookies['auth-key'];

  if (!token) {
    return res.redirect('/login');
  }

  try {
    req.user = jwt.verify(token, secretKey);
    if (req.user.userName === 'alla') {
      res.redirect('/packages/view');
    }
    next();
  } catch (error) {
    console.error(error);
    res.clearCookie('auth-key');
    return res.redirect('/login');
  }
}

// Login page redirection
function looseAuthCheck(req, res, next) {
  const token = req.cookies && req.cookies['auth-key'];

  try {
    if (token) {
      req.user = jwt.verify(token, secretKey);
    }
    next();
  } catch (error) {
    console.error(error);
    res.clearCookie('auth-key');
    return res.redirect('/login');
  }
}

// Package page authentication
function packageAuthentication(req, res, next) {
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
  looseAuthCheck,
  packageAuthentication,
};
