module.exports = (item) => {
  item.tax = item.tax === undefined || !item.receipt_id ? 8 : item.tax;
}