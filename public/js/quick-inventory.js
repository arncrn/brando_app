document.addEventListener('DOMContentLoaded', () => {
    
  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('quick-inventory-button')) {
      let itemId = e.target.parentNode.parentNode.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);
      let location = e.target.textContent.toLowerCase();
      let inStock = true;
      if (location === 'none') inStock = false;
      
      fetch(`/updateinventory/${itemId}`, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({location, inStock}),
      })
      .then(response => {
        return response.text()
      })
      .then(data => {
        if (data) itemToReplace.innerHTML = data;
      })
    }
  })
})