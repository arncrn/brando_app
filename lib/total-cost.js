function getTotalCost(item, receiptList=[]) {
  let tax;
  let purchasePrice = +item.purchase_price || 0;

  let receiptId = item.receipt_id;

  if (receiptId) {
    let receipt = receiptList.find(receipt => +receipt.id === +receiptId);
    tax = purchasePrice * (receipt.tax / 100);
  } else {
    tax = purchasePrice * (8 / 100);
  }

  return (tax + purchasePrice).toFixed(2);
}

module.exports = getTotalCost;