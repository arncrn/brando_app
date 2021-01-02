document.addEventListener('DOMContentLoaded', () => {
  let filter = document.getElementById('tag-filter');
  filter.addEventListener('input', event => {
    let items = document.querySelectorAll('[data-item-id]');
    items.forEach(item => {
      let tag = item.querySelector('.tag-number').textContent;
      if (filter.value.trim().length > 0 && tag.toLowerCase().includes(filter.value.toLowerCase())) {
        item.style.display = 'flex';
      } else if (filter.value.trim().length === 0) {
        item.style.display = 'flex';
      } else {
        item.style.display = 'none';
      }
    });
  });
})