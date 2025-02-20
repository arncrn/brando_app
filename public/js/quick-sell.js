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
  });

  let uahConversionInput = document
    .getElementById('uah-usd')
    .querySelector('input');
  uahUsdConversion = window.localStorage.getItem('uahUsdConverion');
  if (!uahUsdConversion) {
    window.localStorage.setItem('uahUsdConverion', uahConversionInput.value);
    uahUsdConversion = uahConversionInput.value || 28;
  }

  uahConversionInput.value = uahUsdConversion;

  uahConversionInput.addEventListener('input', (e) => {
    window.localStorage.setItem('uahUsdConverion', e.target.value);
    uahUsdConversion = e.target.value;
  });

  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('not-sold')) {
      let itemId = e.target.parentNode.parentNode.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);
      fetch(`/clothing/unsellitem/${itemId}`, {
        method: 'POST',
        credentials: include,
      })
        .then((response) => response.text())
        .then((data) => {
          itemToReplace.innerHTML = data;
        });
    }

    if (e.target.classList.contains('custom-sell')) {
      let person = e.target.id;
      let sellingMonth = customer;

      if (person === 'alla') {
        sellingMonth = 'Nastia-Alla' + ' ' + customer;
      }

      if (person === 'irina') {
        sellingMonth = `Nastia-Irina ${customer}`;
      }

      let parentDiv = e.target.parentNode.parentNode;
      let sellingPrice = parentDiv.querySelector('input').value;
      let itemId = parentDiv.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);
      fetch(`/clothing/sellitem/${itemId}`, {
        method: 'POST',
        credentials: include,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          soldPrice: sellingPrice,
          customer: sellingMonth,
          person: person,
        }),
      })
        .then((response) => response.text())
        .then((data) => {
          itemToReplace.innerHTML = data;
        });
    }
  });
});
