// const Login = require('../models/login');

const requiresAuthentication = async (req, res, next) => {
  if (res.locals.signedIn) {
      next();
  } else {
    console.log("Unauthorized");
    res.status(401).send("Unauthorized")
  } 
}

module.exports = {
  requiresAuthentication,
}