document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('convert-value')) {
      let uahConversion = window.localStorage.getItem('uahUsdConverion') || 28;
      let regex = /[^0-9.]/g;

      let uahInput;
      let usdInput;

      if (e.target.name === 'uah-price') {
        uahInput = e.target;
        usdInput = uahInput.previousElementSibling.previousElementSibling;
      } else {
        usdInput = e.target;
        uahInput = usdInput.nextElementSibling.nextElementSibling;
      }

      uahInput.addEventListener('input', (e) => {
        let soldPrice = e.target.value.replace(regex, '');
        usdInput.value = (+soldPrice / uahConversion).toFixed(2);
      })

      usdInput.addEventListener('input', (e) => {
        let soldPrice = e.target.value.replace(regex, '');
        uahInput.value = (+soldPrice * uahConversion).toFixed(2);
      })
    }
  })
})