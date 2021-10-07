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
const http = require('http').Server(app);
const io = require('socket.io')(http);
const LokiStore = store(session);

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');


app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

let globalSignedIn = false;

let sessionMiddleware = session({
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
})
app.use(sessionMiddleware);

io.use((socket, next) => {
  sessionMiddleware(socket.request, socket.request.res, next);
})

io.on('connection', (socket) => {
  socket.emit('loginCheck');
  socket.on('loginResponse', (response) => {
    socket.request.session.signedIn = response;
    globalSignedIn = response;
    socket.request.session.save();
  })
})



app.use((req, res, next) => {
  const signedIn = req.session.signedIn || globalSignedIn;
  if (signedIn === 'true' || signedIn === true) {
    res.locals.signedIn = true;
  } else {
    res.locals.signedIn = false;
  }

  next();
})

app.use('', loginRouter);
app.use('/receipts', receiptRouter);
app.use('/packages', packageRouter);
app.use('/orders', orderRouter);
app.use("/customers", customerRouter);
app.use("/clothing", itemRouter);

module.exports = http;