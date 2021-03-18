document.addEventListener('DOMContentLoaded', () => {
  let customer;
  let uahUsdConversion;


  let customerSelect = document.getElementById('sell-options-select');
  customer = window.localStorage.getItem('customer');
  if (!customer) {
    window.localStorage.setItem('customer', customerSelect.value);
    customer = customerSelect.value;
  }

  customerSelect.value = customer;

  customerSelect.addEventListener('change', (e) => {
    window.localStorage.setItem('customer', e.target.value);
    customer = e.target.value;
  })

  let uahConversionInput = document.getElementById('uah-usd').querySelector('input');
  uahUsdConversion = window.localStorage.getItem('uahUsdConverion');
  if (!uahUsdConversion) {
    window.localStorage.setItem('uahUsdConverion', uahConversionInput.value);
    uahUsdConversion = uahConversionInput.value || 28;
  }

  uahConversionInput.value = uahUsdConversion;

  uahConversionInput.addEventListener('input', (e) => {
    window.localStorage.setItem('uahUsdConverion', e.target.value);
    uahUsdConversion = e.target.value;
  })



  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('sell-to-alla')) {
      const ALLA_ORDER_ID = 9;
      let order = {id: ALLA_ORDER_ID};
      let regex = /[^0-9.]/g;
      let itemId = e.target.parentNode.parentNode.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);
      let purchasePrice = itemToReplace.querySelector('.purchase-price').textContent.replace(regex, '');
      let soldPrice = (Number(purchasePrice) + (Number(purchasePrice * .25))).toFixed(2);
      
      fetch(`/sellitem/${itemId}`, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({soldPrice: soldPrice, customer: "Alla", order}),
      })
        .then(response => response.text())
        .then(data => {
          itemToReplace.innerHTML = data;
        });
      
    }
    if (e.target.classList.contains('custom-sell')) {
      let parentDiv = e.target.parentNode.parentNode;
      let sellingPrice = parentDiv.querySelector('input').value;
      let itemId = parentDiv.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);

      fetch(`/sellitem/${itemId}`, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({soldPrice: sellingPrice, customer}),
      })
        .then(response => response.text())
        .then(data => {
          itemToReplace.innerHTML = data;
        });
    }
  })
})



