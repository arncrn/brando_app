document.addEventListener('DOMContentLoaded', () => {
  function configureTextData(textData) {
    return textData.split(': ')[1].trim();
  }

  function filterClothing() {
    items.forEach(item => {
      let brand = configureTextData(item.querySelector('.item-brand').textContent);
      let size = configureTextData(item.querySelector('.item-size').textContent);
      let color = configureTextData(item.querySelector('.item-color').textContent);
      let type = configureTextData(item.querySelector('.item-type').textContent);
      let tag = configureTextData(item.querySelector('.item-tag').textContent);

      if ((viewable.brand === "Brand: All" || viewable.brand === brand) &&
         (viewable.size === "Size: All" || viewable.size === size)      &&
         (viewable.color === "All" || color.includes(viewable.color))    &&
         (viewable.type === "Type: All" || viewable.type === type)      &&
         (viewable.tag === "" || tag.includes(viewable.tag))) {
        item.style.display = 'inline-block';
      } else {
        item.style.display = 'none';
      }
    });
  }

  let viewable = {
    brand: 'Brand: All',
    size: 'Size: All',
    color: 'All',
    type: 'Type: All',
    tag: '',
  };

  let items = document.querySelectorAll('.inventory');

  let brandSelector = document.getElementById('brand');
  let sizeSelector = document.getElementById('size');
  let colorSelector = document.getElementById('color');
  let typeSelector = document.getElementById('type');
  let tagText = document.getElementById('tagnum');
  let resetButton = document.querySelector("input[type='reset']");

  let images = document.querySelectorAll('img');

  images.forEach(img => {
    img.addEventListener('click', (e) => {
      let itemId = e.target.parentNode.parentNode.id;
      let xhr = new XMLHttpRequest();
      xhr.open("POST", `/clothing/${itemId}/toggleseen`);
      xhr.addEventListener('load', () => {
        img.parentNode.classList.toggle('seen');
      })
      xhr.send();
    })
  });

  brandSelector.addEventListener('input', (e) => {
    let brand = e.target.value;
    viewable.brand = brand;
    filterClothing();
  });

  sizeSelector.addEventListener('input', (e) => {
    let size = e.target.value;
    viewable.size = size;
    filterClothing();
  });

  colorSelector.addEventListener('input', (e) => {
    let color = e.target.value;
    viewable.color = color;
    filterClothing();
  });

  typeSelector.addEventListener('input', (e) => {
    let type = e.target.value;
    viewable.type = type;
    filterClothing();
  });

  tagText.addEventListener('input', (e) => {
    let tag = e.target.value;
    viewable.tag = tag;
    filterClothing();
  });

  resetButton.addEventListener('click', (e) => {
    viewable.brand = 'Brand: All';
    viewable.size = 'Size: All';
    viewable.color = 'All';
    viewable.type = 'Type: All';
    viewable.tag = '';
    filterClothing();
  });
});
