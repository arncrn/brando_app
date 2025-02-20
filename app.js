const express = require('express');
const exphbs = require('express-handlebars');
const cors = require('cors');
const cookieParser = require('cookie-parser'); // Required for `req.cookies`

const loginRouter = require('./controllers/login');
const receiptRouter = require('./controllers/receipts');
const packageRouter = require('./controllers/packages');
const orderRouter = require('./controllers/orders');
const customerRouter = require('./controllers/customers');
const itemRouter = require('./controllers/items');

const app = express();
const http = require('http').Server(app);

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');

app.use(cookieParser());
app.use(cors({ credentials: true }));

app.use(express.static('public'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('', loginRouter);
app.use('/receipts', receiptRouter);
app.use('/packages', packageRouter);
app.use('/orders', orderRouter);
app.use('/customers', customerRouter);
app.use('/clothing', itemRouter);

module.exports = http;
