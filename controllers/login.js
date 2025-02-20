const jwt = require('jsonwebtoken');
const loginRouter = require('express').Router();
const Login = require('../models/login');
const config = require('../lib/config');
const { looseAuthCheck } = require('../utils/middleware');

loginRouter.get('/', looseAuthCheck, (req, res) => {
  if (req.user) {
    res.redirect('/clothing');
  } else {
    res.redirect('/login');
  }
});

loginRouter.get('/login', looseAuthCheck, (req, res) => {
  if (req.user) {
    res.redirect('/clothing');
  } else {
    res.render('layouts/login', {
      layout: null,
    });
  }
});

loginRouter.post('/login', async (req, res) => {
  try {
    let username = req.body.username.toLowerCase();
    let password = req.body.password;
    let { user, success } = await Login.authenticate(username, password);

    if (success) {
      const secretKey = config.SECRET;
      const token = jwt.sign(
        { userID: user.id, userName: user.username },
        secretKey,
        {
          expiresIn: '30d',
        }
      );

      res.cookie('auth-key', token, {
        httpOnly: true, // prevents access from javasript (more secure)
        secure: config.NODE_ENV === 'production',
        maxAge: 1000 * 60 * 60 * 24 * 30, // milliseconds, seconds, minutes, hours, days --- 30 days
      });

      return res.json({ success: true, redirect: '/clothing' });
    } else {
      res.render('layouts/login', { layout: null });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({ success: false, message: 'Server error' });
  }
});

module.exports = loginRouter;
