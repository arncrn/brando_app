function getTotalCost(item, itemList=[], packageList=[], receiptList=[]) {
  let pricePerItem = 0;
  let tax;
  let purchasePrice = +item.purchase_price || 0;

  let receiptId = item.receipt_id;
  let packageId = item.package_id;
  if (packageId) {
    let pkg = packageList.find(pkg => +pkg.id === +packageId);
    let count = itemList.filter(item => +item.package_id === +packageId).length;
    pricePerItem = +pkg.price / count;
  }

  if (receiptId) {
    let receipt = receiptList.find(receipt => +receipt.id === +receiptId);
    tax = purchasePrice * (receipt.tax / 100);
  } else {
    tax = purchasePrice * (8 / 100);
  }

  return (pricePerItem + tax + purchasePrice).toFixed(2);
}

module.exports = getTotalCost;