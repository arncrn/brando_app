const Login = require('../models/login');

const requiresAuthentication = async (req, res, next) => {
  if (!res.locals.signedIn) {
    let loginStatus = await Login.checkLoginStatus(req.sessionID);
    if (loginStatus) {
      req.session.signedIn = true;
      res.locals.signedIn = true;
      next();
    } else {
      console.log("Unauthorized");
      res.status(401).send("Unauthorized")
    }
  } else {
    next();
  }
}

module.exports = {
  requiresAuthentication,
}