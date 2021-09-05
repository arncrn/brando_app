// addPhoto is set globally by public/js/save-image.js (aka bundled-save-image.js)

const REQUIRED_VALUES = ['size', 'brand', 'type', 'colors', 'tag_number', 'gender', 'location', 'purchase_price'];

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
    while(this.previewBox.firstChild) {
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
      [...glowingItems].forEach(item => item.classList.remove("glowing"));
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
    const removeSpaces = (string) => {
      return string.split(' ').join('-').toLowerCase();
    }
    let form = itemCreator.form;

    let brand = '';
    let tagNumber = '';
    let type = '';
    for (let i = 0; i < form.elements.length; i += 1) {
      let element = form.elements[i];
      if (element.name === 'brand') brand = removeSpaces(element.value);
      if (element.name === 'tag_number') tagNumber = removeSpaces(element.value);
      if (element.name === 'type') type = removeSpaces(element.value);
      if (REQUIRED_VALUES.includes(element.name)) {
        if (!element.value) {
          alert(`Missing ${element.name}`);
          return;
        } 
      }
    }

    let file = itemCreator.imageInput.files[0];
    if (file) {
      let imageName = `${brand}-${type}-${tagNumber}.png`;
      addPhoto("unprocessed", imageName);
    }
   
    let formData = new FormData(form);

    let XHR = new XMLHttpRequest();
    XHR.open('POST', '/clothing/newitem');

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

// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
// function getSignedRequest(file) {
  // const xhr = new XMLHttpRequest();
  // xhr.open('GET', `/sign-s3?file-name=${file.name}&file-type=${file.type}`);
  // xhr.onreadystatechange = () => {
  //   if(xhr.readyState === 4){
  //     if(xhr.status === 200){
  //       const response = JSON.parse(xhr.response);
  //       uploadFile(file, response.signedRequest, response.url);
  //     }
  //     else{
  //       alert('Could not get signed URL.');
  //     }
  //   }
  // };
  // xhr.send();
// }

// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
// function uploadFile(file, signedRequest, url){
  // const xhr = new XMLHttpRequest();
  // xhr.open('PUT', signedRequest);
  // xhr.onreadystatechange = () => {
  //   if(xhr.readyState === 4){
  //     if(xhr.status === 200){
        // document.getElementById('preview').src = url;
        // let previewBox = document.getElementById('preview');
        // document.getElementById('clothing-picture').value = url;
  //     }
  //     else{
  //       alert('Could not upload file.');
  //     }
  //   }
  // };
  // xhr.send(file);
// }

function showImage(file) {
  document.getElementById('preview').src = URL.createObjectURL(file);
}