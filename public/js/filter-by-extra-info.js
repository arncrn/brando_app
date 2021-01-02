document.addEventListener('DOMContentLoaded', () => {
  let filter = document.getElementById('extra-info-filter');
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