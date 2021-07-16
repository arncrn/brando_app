const loginRouter = require('express').Router();
const Login = require('../models/login');

loginRouter.get('/', (req, res) => {
  if (res.locals.signedIn) {
    res.redirect('/clothing');
  } else {
    res.redirect('/login')
  }
});

loginRouter.get('/login', (req, res) => {
  if (res.locals.signedIn) {
    res.redirect('/clothing');
  } else {
    res.render('layouts/login', {
      layout: null,
    })
  }
})

loginRouter.post('/login', async (req, res) => {
  let username = req.body.username.toLowerCase();
  let password = req.body.password;
  let loggedInSuccess = await Login.authenticate(username, password);

  if (loggedInSuccess) {
    // req.session.username = username;
    await Login.loginUser(username, req.sessionID);
    req.session.signedIn = true;
    res.redirect('/clothing');
  } else {
    res.render('layouts/login', { layout: null });
  }
})

module.exports = loginRouter;