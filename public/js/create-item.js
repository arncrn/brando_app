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
    getSignedRequest(file);
  }

  insertItemIntoPage(responseHTML) {
    let newElement = this.convertHtmlStringToDomElement(responseHTML);
    newElement.classList.add('glowing');
    this.form.classList.add('glowing');
    this.newItemContainer.appendChild(newElement);
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

// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
function getSignedRequest(file) {
  const xhr = new XMLHttpRequest();
  xhr.open('GET', `/sign-s3?file-name=${file.name}&file-type=${file.type}`);
  xhr.onreadystatechange = () => {
    if(xhr.readyState === 4){
      if(xhr.status === 200){
        const response = JSON.parse(xhr.response);
        uploadFile(file, response.signedRequest, response.url);
      }
      else{
        alert('Could not get signed URL.');
      }
    }
  };
  xhr.send();
}

// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
function uploadFile(file, signedRequest, url){
  const xhr = new XMLHttpRequest();
  xhr.open('PUT', signedRequest);
  xhr.onreadystatechange = () => {
    if(xhr.readyState === 4){
      if(xhr.status === 200){
        document.getElementById('preview').src = url;
        // let previewBox = document.getElementById('preview');
        document.getElementById('clothing-picture').value = url;
      }
      else{
        alert('Could not upload file.');
      }
    }
  };
  xhr.send(file);
}