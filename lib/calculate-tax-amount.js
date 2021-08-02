module.exports = (item) => {
  // return +item.purchase_price * (item.tax / 100);

  return +((item.tax / 100) * +item.purchase_price).toFixed(2);
};