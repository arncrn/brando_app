document.addEventListener('DOMContentLoaded', () => {
  let filter = document.getElementById('extra-info-filter');
  let pendingFilter = document.getElementById('pending-filter');


  //working
  pendingFilter.addEventListener('change', (e) => {
    let items = document.querySelectorAll('[data-item-id]');
    if (pendingFilter.checked === true) {
      pendingFilter.checked = true;
      items.forEach(item => {
        let pendingSign = item.querySelector('.pending');
        if (pendingSign)  {
          item.style.display = 'flex';
        } else {
          item.style.display = 'none';
        }
      })
    } else {
      pendingFilter.checked = false;
      items.forEach(item => {
        item.style.display = 'flex';
      })
    }
  })

  filter.addEventListener('input', event => {
    let items = document.querySelectorAll('[data-item-id]');
    items.forEach(item => {
      let extraInfo = item.querySelector('.card-body').textContent;
      if (filter.value.trim().length > 0 && extraInfo.toLowerCase().includes(filter.value.toLowerCase())) {
        item.style.display = 'flex';
      } else if (filter.value.trim().length === 0) {
        item.style.display = 'flex';
      } else {
        item.style.display = 'none';
      }
    });
  });
})