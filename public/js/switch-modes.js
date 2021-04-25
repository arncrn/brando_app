const displayInsertBoxes = (chosenWrapper, {currencyConversion, sellOptions, quickPackage}) => {
  switch(chosenWrapper) {
    case 'default-wrapper':
      currencyConversion.style.display = 'none';
      sellOptions.style.display = 'none';
      quickPackage.style.display = 'none';
      break;
    case 'sell-wrapper': 
      currencyConversion.style.display = 'block';
      sellOptions.style.display = 'block';
      quickPackage.style.display = 'none';
      break;
    case 'package-wrapper': 
      currencyConversion.style.display = 'none';
      sellOptions.style.display = 'none';
      quickPackage.style.display = 'block';
      break;
    case 'inventory-wrapper':
      currencyConversion.style.display = 'none';
      sellOptions.style.display = 'none';
      quickPackage.style.display = 'none';
      break;
  }
}

document.addEventListener('DOMContentLoaded', () => {
  let optionDivs = {
    currencyConversion: document.getElementById('uah-usd'),
    sellOptions: document.getElementById('sell-options'),
    quickPackage: document.getElementById('quick-package')
  }
  

  let currentWrapper = window.localStorage.getItem('wrapper');
  if (!currentWrapper) {
    let wrapped = document.querySelector(':checked').id;
    localStorage.setItem('wrapper', wrapped);
  }

  document.querySelector(`#${currentWrapper}`).checked = true;

  let chosenWrapper = document.querySelector(':checked').id;
  let wrapped = [...document.querySelectorAll(`.${chosenWrapper}`)];

  wrapped.forEach(item => {
    item.style.display = 'block';
  })

  displayInsertBoxes(chosenWrapper, optionDivs);


  let wrappers = document.querySelectorAll('input[type=radio]');
  [...wrappers].forEach(wrapper => {
    wrapper.addEventListener('change', (event) => {
      let chosen = event.target;
      let chosenWrapper = chosen.id;
      chosen.checked = true;
      localStorage.setItem('wrapper', chosenWrapper);

      wrapped.forEach(item => {
        item.style.display = 'none';
      })

      wrapped = [...document.querySelectorAll(`.${chosenWrapper}`)];

      wrapped.forEach(item => {
        item.style.display = 'block';
      })

      displayInsertBoxes(chosenWrapper, optionDivs);
    })
  })
})