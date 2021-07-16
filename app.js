const config = require("./lib/config");
const express = require('express');
const exphbs = require('express-handlebars');
const session = require("express-session");
const store = require("connect-loki");

const loginRouter = require("./controllers/login");
const receiptRouter = require("./controllers/receipts");
const packageRouter = require("./controllers/packages");
const orderRouter = require("./controllers/orders");
const customerRouter = require("./controllers/customers");
const itemRouter = require("./controllers/items");

const app = express();
const LokiStore = store(session);

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');


app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(session({
  cookie: {
    httpOnly: true,
    maxAge: 31 * 24 * 60 * 60 * 1000,
    path: "/",
    secure: false,
  },
  name: "brandomania-session-id",
  resave: false,
  saveUninitialized: true,
  secret: config.SECRET,
  store: new LokiStore({}),
}));

app.use((req, res, next) => {
  res.locals.signedIn = req.session.signedIn;

  next();
})

app.use('', loginRouter);
app.use('/receipts', receiptRouter);
app.use('/packages', packageRouter);
app.use('/orders', orderRouter);
app.use("/customers", customerRouter);
app.use("/clothing", itemRouter);

module.exports = app;