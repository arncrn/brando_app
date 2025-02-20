// addPhoto is set globally by public/js/save-image.js (aka bundled-save-image.js)

const REQUIRED_VALUES = [
  'size',
  'brand',
  'type',
  'colors',
  'tag_number',
  'gender',
  'location',
  'purchase_price',
];

class CreateItem {
  constructor() {
    this.previewBox;
    this.form;
    this.imageInput;
    this.newItemContainer;
  }

  // generateRandomName(extension) {
  //   return "image" + Math.floor(Math.random() * 100000) + `.${extension}`;
  // }

  getElements() {
    this.previewBox = document.querySelector('#preview');
    this.form = document.querySelector('form');
    this.imageInput = document.querySelector('#picture-uploader');
    // this.imageName = document.querySelector('#clothing-picture');
    this.newItemContainer = document.querySelector('#item-container');
  }

  removeImagePreview() {
    while (this.previewBox.firstChild) {
      this.previewBox.removeChild(this.previewBox.firstChild); // might need to bind?
    }
  }

  displayImagePreview(file) {
    this.removeImagePreview();
    if (!file || !file.type.startsWith('image/')) return;
    // let extension = file.name.split('.')[1];
    // this.imageName.value = this.generateRandomName(extension);
    // addPhoto("unprocessed", this.imageName.value);
    showImage(file);
  }

  insertItemIntoPage(responseHTML) {
    let newElement = this.convertHtmlStringToDomElement(responseHTML);
    newElement.classList.add('glowing');
    this.form.classList.add('glowing');
    this.newItemContainer.insertAdjacentElement('afterbegin', newElement);
    if (this.previewBox.src) {
      this.newItemContainer.querySelector('img').src = this.previewBox.src;
    }
    setTimeout(() => {
      let glowingItems = document.querySelectorAll('.glowing');
      [...glowingItems].forEach((item) => item.classList.remove('glowing'));
    }, 3000);
  }

  convertHtmlStringToDomElement(htmlString) {
    let div = document.createElement('div');
    div.innerHTML = htmlString;
    return div.firstChild;
  }
}

document.addEventListener('DOMContentLoaded', () => {
  let itemCreator = new CreateItem();
  itemCreator.getElements();

  itemCreator.imageInput.addEventListener('change', (event) => {
    itemCreator.displayImagePreview(event.currentTarget.files[0]);
  });

  itemCreator.form.addEventListener('submit', (event) => {
    event.preventDefault();
    const removeSpaces = (string) => {
      return string.split(' ').join('-').toLowerCase();
    };
    let form = itemCreator.form;

    let brand = '';
    let tagNumber = '';
    let type = '';
    let colors = '';
    for (let i = 0; i < form.elements.length; i += 1) {
      let element = form.elements[i];
      if (element.name === 'brand') brand = removeSpaces(element.value);
      if (element.name === 'tag_number')
        tagNumber = removeSpaces(element.value);
      if (element.name === 'type') type = removeSpaces(element.value);
      if (element.name === 'colors') colors = removeSpaces(element.value);
      if (REQUIRED_VALUES.includes(element.name)) {
        if (!element.value) {
          alert(`Missing ${element.name}`);
          return;
        }
      }
    }

    let file = itemCreator.imageInput.files[0];
    if (file) {
      // ! add color to image name?
      // let imageName = `${brand}-${type}-${tagNumber}.png`;
      let imageName = `${brand}-${type}-${colors}-${tagNumber}.png`;
      addPhoto('unprocessed', imageName);
    }

    let formData = new FormData(form);

    let XHR = new XMLHttpRequest();
    XHR.open('POST', '/clothing/newitem');
    XHR.withCredentials = true; // Ensure cookies are included

    XHR.addEventListener('load', (event) => {
      let response = event.target.response;
      itemCreator.insertItemIntoPage(response);
    });

    XHR.addEventListener('error', (err) => {
      console.log(err);
    });

    XHR.send(formData);
  });
});

function showImage(file) {
  document.getElementById('preview').src = URL.createObjectURL(file);
}
