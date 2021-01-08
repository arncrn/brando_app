const REQUIRED_VALUES = ['size', 'brand', 'type', 'colors', 'tag_number', 'gender', 'location', 'purchase_price'];

class CreateItem {
  constructor() {
    this.previewBox;
    this.form;
    this.imageInput;
    this.newItemContainer;
  }

  getElements() {
    this.previewBox = document.querySelector('#preview');
    this.form = document.querySelector('form');
    this.imageInput = document.querySelector('#picture-uploader');
    this.newItemContainer = document.querySelector('#item-container');
  }

  removeImagePreview() {
    while(this.previewBox.firstChild) {
      this.previewBox.removeChild(this.previewBox.firstChild); // might need to bind?
    }
  }

  displayImagePreview(file) {
    this.removeImagePreview();
    if (!file || !file.type.startsWith('image/')) return;
  
    const img = document.createElement("img");
    img.file = file;
    this.previewBox.appendChild(img); // Assuming that "preview" is the div output where the content will be displayed.
  
    const reader = new FileReader();
    reader.onload = (function(aImg) { return function(e) { aImg.src = e.target.result; }; })(img);
    reader.readAsDataURL(file);
  }

  insertItemIntoPage(responseHTML) {
    let newElement = this.convertHtmlStringToDomElement(responseHTML);
    newElement.classList.add('glowing');
    this.newItemContainer.appendChild(newElement);
    setTimeout(() => {
      document.querySelector('.glowing').classList.remove('glowing');
    }, 3000);
  }

  convertHtmlStringToDomElement(htmlString) {
    let div = document.createElement('div');
    div.innerHTML = htmlString;
    return div.firstChild;
  }

}


document.addEventListener('DOMContentLoaded', () => {

  let itemCreator = new CreateItem()
  itemCreator.getElements();

  itemCreator.imageInput.addEventListener('change', event => {
    itemCreator.displayImagePreview(event.currentTarget.files[0]);
  })

  itemCreator.form.addEventListener('submit', (event) => {
    event.preventDefault();
    let form = itemCreator.form;
    
    for (let i = 0; i < form.elements.length; i += 1) {
      let element = form.elements[i];
      if (REQUIRED_VALUES.includes(element.name)) {
        if (!element.value) {
          alert(`Missing ${element.name}`);
          return;
        } 
      }
    }
   
    let formData = new FormData(form);

    let XHR = new XMLHttpRequest();
    XHR.open('POST', '/newitem');

    XHR.addEventListener('load', (event) => {
      let response = event.target.response;
      itemCreator.insertItemIntoPage(response);
    })

    XHR.addEventListener('error', (err) => {
      console.log(err);
    })

    XHR.send(formData);
  })
})