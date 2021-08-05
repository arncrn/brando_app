const NEEDED_VALUES = ['size', 'brand', 'type', 'colors', 'tag_number', 'gender', 'location', 'purchase_price'];
const UAH_CONVERSION = 28;

class PopupDisplay {
  constructor() {
    this.modalContainer = document.getElementById('modal-container');
    this.currentTab = 'main-tab';
    this.removeModal = this.removeModal.bind(this);
    this.forceCloseModal = this.forceCloseModal.bind(this);
    this.displayFlashMessage = this.displayFlashMessage.bind(this);
    this.basicDetails;
    this.imageDisplay;
    this.priceDetails;
    this.packageDetails;
    this.orderDetails;
    this.extraInfo;
    this.soldPriceUSD;
    this.soldPriceUAH;
    this.form;

    this.newImageUrl = '';

    this.previewBox; 
    this.form; 
    this.imageInput;
    this.newItemContainer;
  }

  removeImagePreview() {
    while(this.previewBox.firstChild) {
      this.previewBox.removeChild(this.previewBox.firstChild); // might need to bind?
    }
  }

  displayImagePreview(file) {
    this.removeImagePreview();
    if (!file || !file.type.startsWith('image/')) return;
    // getSignedRequest(file);
    this.newImageUrl = URL.createObjectURL(file);
    showImage(file);
  }

  changeTab(tab) {
    this.currentTab = tab.id;
    tab.classList.add('active');
    this.displayTab();
  }

  removeActiveTabs() {
    let navs = this.modalContainer.querySelectorAll('.modal-nav');
    [...navs].forEach(nav => nav.classList.remove('active'));
  }

  displayTab() {
    this.hideAllTabs();
    switch (this.currentTab) {
      case 'main-tab': this.basicDetails.style.display = 'flex'; break;
      case 'image-tab': this.imageDisplay.style.display = 'flex'; break;
      case 'price-tab': this.priceDetails.style.display = 'flex'; break;
      case 'package-tab': this.packageDetails.style.display = 'flex'; break;
      case 'order-tab': this.orderDetails.style.display = 'flex'; break;
      case 'extra-info-tab': this.extraInfo.style.display = 'flex'; break;
    }
  }

  openModal(responseData) {
    this.modalContainer.innerHTML = responseData;
    this.trimStrangeWhiteSpaceFromExtraInfo();
    this.modalContainer.addEventListener('click', this.removeModal);
  }

  trimStrangeWhiteSpaceFromExtraInfo() {
    let textArea = this.modalContainer.querySelector('textarea');
    textArea.value = textArea.value.split(/\n/).map(string => string.trim()).join('\n');
  }

  removeModal(event) {
    if (!this._isModalForm(event.target) || event.target.id === 'cancel' || event === 'close') {
      event.preventDefault();
      // let modalContainer = document.getElementById('modal-container');
      this.modalContainer.innerHTML = null;
      this.modalContainer.removeEventListener('click', this.removeModal);
    }
  }

  forceCloseModal() {
    this.modalContainer.innerHTML = null;
    this.modalContainer.removeEventListener('click', this.removeModal);
  }

  findItemId(node) {
    if (node.dataset.itemId) {
      return node.dataset.itemId;
    }
    return this.findItemId(node.parentNode);
  }

  getPageDetails() {
    this.basicDetails = this.modalContainer.querySelector('#item-basic-details');
    this.imageDisplay = this.modalContainer.querySelector('#image-display');
    this.priceDetails = this.modalContainer.querySelector('#item-price-details');
    this.packageDetails = this.modalContainer.querySelector('#item-package-details');
    this.orderDetails = this.modalContainer.querySelector('#item-order-details');
    this.extraInfo = this.modalContainer.querySelector('#item-extra-info');

    this.soldPriceUSD = this.modalContainer.querySelector('#sold-price-usd');
    this.soldPriceUAH = this.modalContainer.querySelector('#sold-price-uah');

    this.form = this.modalContainer.querySelector('form');
    this.previewBox = this.modalContainer.querySelector('#preview');
    this.imageInput = this.modalContainer.querySelector('#picture-uploader');
    this.newItemContainer = this.modalContainer.querySelector('#item-container');
  }

  hideAllTabs() {
    this.basicDetails.style.display = 'none';
    this.imageDisplay.style.display = 'none';
    this.priceDetails.style.display = 'none';
    this.packageDetails.style.display = 'none';
    this.orderDetails.style.display = 'none';
    this.extraInfo.style.display = 'none';
  }

  // submitForm(formData) {
  //   let XHR = new XMLHttpRequest();
  //   XHR.open('POST', `/edititem/${formData.id}`);
  //   XHR.setRequestHeader('Content-Type', 'application/json');
  //   XHR.addEventListener('load', event => {
  //     let request = event.target;
  //     if (request.status === 200) {
  //       let itemToReplace = document.querySelector(`[data-item-id="${formData.id}"]`);
  //       itemToReplace.innerHTML = request.response;
  //       this.forceCloseModal();
  //       this.displayFlashMessage();
  //     }
  //   })

  //   XHR.addEventListener('error', event => {
  //     console.log(event);
  //   })

  //   XHR.send(JSON.stringify(formData));
  // }

  displayFlashMessage() {
    let flashMessage = document.querySelector('#flash-message');
    flashMessage.style.display="flex";
    setTimeout(() => {
      flashMessage.style.display = 'none';
    }, 3000);
  }

  _isModalForm(node) {
    if (node.id === 'clickable-area') {
      return true;
    } else if (node.parentNode === null) {
      return false;
    } else {
      return this._isModalForm(node.parentNode);
    }
  }
}

let popupDisplay = new PopupDisplay();


document.addEventListener('click', (event) => {
  if (event.target.classList.contains('edit')) {
    let itemId = popupDisplay.findItemId(event.target);
    let xhr = new XMLHttpRequest();

    xhr.open('GET', `/clothing/item/${itemId}`);
    xhr.addEventListener('load', event => {
      //working
      let response = event.target.response;
      popupDisplay.openModal(response);
      popupDisplay.getPageDetails();

      popupDisplay.modalContainer.addEventListener('click', event => {
        if (event.target.classList.contains('modal-nav')) {
          popupDisplay.removeActiveTabs();
          popupDisplay.changeTab(event.target);
        }
      })

      popupDisplay.imageInput.addEventListener('change', event => {
        popupDisplay.displayImagePreview(event.currentTarget.files[0]);
      })

      popupDisplay.soldPriceUSD.addEventListener('input', event => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUAH.value = (+soldPrice * UAH_CONVERSION).toFixed(2);
      });

      popupDisplay.soldPriceUAH.addEventListener('input', event => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUSD.value = (+soldPrice / UAH_CONVERSION).toFixed(2);
      })

      popupDisplay.form.addEventListener('submit', event => {
        event.preventDefault();
        let form = popupDisplay.form;
        let formObj = {}
        for (let i = 0; i < form.elements.length; i += 1) {
          let element = form.elements[i];
          formObj[element.name] = element.value;
          if (NEEDED_VALUES.includes(element.name)) {
            if (!element.value) {
              alert(`Missing ${element.name}`);
              return;
            } 
          }
        }

        let itemId = formObj.id;
        let formData = new FormData(form);

        let XHR = new XMLHttpRequest();
        XHR.open('POST', `/clothing/edititem`);
        XHR.addEventListener('load', event => {
          let request = event.target;
          if (request.status === 200) {
            let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);
            itemToReplace.innerHTML = request.response;
            if (popupDisplay.newImageUrl) {
              itemToReplace.querySelector('img').src = popupDisplay.newImageUrl;
            }
            popupDisplay.forceCloseModal();
            popupDisplay.displayFlashMessage();
          }
        })

        XHR.addEventListener('error', event => {
          console.log(event);
        })

        XHR.send(formData);
        
        // let formData = {};
        // [...popupDisplay.form.elements].forEach(element => {
        //   if (element.name) {
        //     if (['purchase_price', 'shipping_cost', 'sold_price'].includes(element.name)) {
        //       let regex = /[^0-9.]/g;
        //       formData[element.name] = element.value.replace(regex, '');
        //     } else {
        //       formData[element.name] = element.value;
        //     }
        //   }
        // })

        // console.log(formData);

        // popupDisplay.submitForm(formData);
      })

    });

    xhr.addEventListener('error', error => {
      console.log(error);
    });

    xhr.send();
  }
});


// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
// function getSignedRequest(file) {
//   const xhr = new XMLHttpRequest();
//   xhr.open('GET', `/sign-s3?file-name=${file.name}&file-type=${file.type}`);
//   xhr.onreadystatechange = () => {
//     if(xhr.readyState === 4){
//       if(xhr.status === 200){
//         const response = JSON.parse(xhr.response);
//         uploadFile(file, response.signedRequest, response.url);
//       }
//       else{
//         alert('Could not get signed URL.');
//       }
//     }
//   };
//   xhr.send();
// }

// for uploading images to amazon's aws s3
// https://devcenter.heroku.com/articles/s3-upload-node
// function uploadFile(file, signedRequest, url){
//   const xhr = new XMLHttpRequest();
//   xhr.open('PUT', signedRequest);
//   xhr.onreadystatechange = () => {
//     if(xhr.readyState === 4){
//       if(xhr.status === 200){
//         document.getElementById('preview').src = url;
//         // let previewBox = document.getElementById('preview');
//         document.getElementById("edit-clothing-picture").value = url;
//       }
//       else{
//         alert('Could not upload file.');
//       }
//     }
//   };
//   xhr.send(file);
// }

function showImage(file) {
  document.getElementById('preview').src = URL.createObjectURL(file);
}