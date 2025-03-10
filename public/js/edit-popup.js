// addPhoto is set globally by public/js/save-image.js (aka bundled-save-image.js)

const NEEDED_VALUES = [
  'size',
  'brand',
  'type',
  'colors',
  'tag_number',
  'gender',
  'location',
  'purchase_price',
];
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
    this.imageName;
  }

  removeImagePreview() {
    while (this.previewBox.firstChild) {
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
    [...navs].forEach((nav) => nav.classList.remove('active'));
  }

  displayTab() {
    this.hideAllTabs();
    switch (this.currentTab) {
      case 'main-tab':
        this.basicDetails.style.display = 'flex';
        break;
      case 'image-tab':
        this.imageDisplay.style.display = 'flex';
        break;
      case 'price-tab':
        this.priceDetails.style.display = 'flex';
        break;
      case 'package-tab':
        this.packageDetails.style.display = 'flex';
        break;
      case 'order-tab':
        this.orderDetails.style.display = 'flex';
        break;
      case 'extra-info-tab':
        this.extraInfo.style.display = 'flex';
        break;
    }
  }

  openModal(responseData) {
    this.modalContainer.innerHTML = responseData;
    this.trimStrangeWhiteSpaceFromExtraInfo();
    this.modalContainer.addEventListener('click', this.removeModal);
  }

  trimStrangeWhiteSpaceFromExtraInfo() {
    let textArea = this.modalContainer.querySelector('textarea');
    textArea.value = textArea.value
      .split(/\n/)
      .map((string) => string.trim())
      .join('\n');
  }

  removeModal(event) {
    if (
      !this._isModalForm(event.target) ||
      event.target.id === 'cancel' ||
      event === 'close'
    ) {
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
    this.basicDetails = this.modalContainer.querySelector(
      '#item-basic-details'
    );
    this.imageDisplay = this.modalContainer.querySelector('#image-display');
    this.priceDetails = this.modalContainer.querySelector(
      '#item-price-details'
    );
    this.packageDetails = this.modalContainer.querySelector(
      '#item-package-details'
    );
    this.orderDetails = this.modalContainer.querySelector(
      '#item-order-details'
    );
    this.extraInfo = this.modalContainer.querySelector('#item-extra-info');

    this.soldPriceUSD = this.modalContainer.querySelector('#sold-price-usd');
    this.soldPriceUAH = this.modalContainer.querySelector('#sold-price-uah');

    this.form = this.modalContainer.querySelector('form');
    this.previewBox = this.modalContainer.querySelector('#preview');
    this.imageInput = this.modalContainer.querySelector('#picture-uploader');
    this.newItemContainer =
      this.modalContainer.querySelector('#item-container');
    this.imageName = document.querySelector('#clothing-picture');
  }

  hideAllTabs() {
    this.basicDetails.style.display = 'none';
    this.imageDisplay.style.display = 'none';
    this.priceDetails.style.display = 'none';
    this.packageDetails.style.display = 'none';
    this.orderDetails.style.display = 'none';
    this.extraInfo.style.display = 'none';
  }

  displayFlashMessage() {
    let flashMessage = document.querySelector('#flash-message');
    flashMessage.style.display = 'flex';
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
    xhr.withCredentials = true;
    xhr.addEventListener('load', (event) => {
      //working
      let response = event.target.response;
      popupDisplay.openModal(response);
      popupDisplay.getPageDetails();

      popupDisplay.modalContainer.addEventListener('click', (event) => {
        if (event.target.classList.contains('modal-nav')) {
          popupDisplay.removeActiveTabs();
          popupDisplay.changeTab(event.target);
        }
      });

      popupDisplay.imageInput.addEventListener('change', (event) => {
        popupDisplay.displayImagePreview(event.currentTarget.files[0]);
      });

      popupDisplay.soldPriceUSD.addEventListener('input', (event) => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUAH.value = (+soldPrice * UAH_CONVERSION).toFixed(
          2
        );
      });

      popupDisplay.soldPriceUAH.addEventListener('input', (event) => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUSD.value = (+soldPrice / UAH_CONVERSION).toFixed(
          2
        );
      });

      popupDisplay.form.addEventListener('submit', async (event) => {
        const removeSpaces = (string) => {
          return string.split(' ').join('-').toLowerCase();
        };

        event.preventDefault();
        let form = popupDisplay.form;
        let formObj = {};
        let brand = '';
        let tagNumber = '';
        let type = '';
        let colors = '';
        let shouldUpdateImage = false;
        for (let i = 0; i < form.elements.length; i += 1) {
          let element = form.elements[i];
          if (element.name === 'brand') brand = removeSpaces(element.value);
          if (element.name === 'tag_number')
            tagNumber = removeSpaces(element.value);
          if (element.name === 'type') type = removeSpaces(element.value);
          if (element.name === 'colors') colors = removeSpaces(element.value);
          formObj[element.name] = element.value;
          if (NEEDED_VALUES.includes(element.name)) {
            if (!element.value) {
              alert(`Missing ${element.name}`);
              return;
            }
          }
        }

        let file = popupDisplay.imageInput.files[0];
        if (file) {
          // ! add color to image name?
          let imageName = `${brand}-${type}-${colors}-${tagNumber}.png`;
          shouldUpdateImage = true;
          try {
            await addPhoto('unprocessed', imageName);
          } catch (error) {
            console.log('the image did not upload:', error);
            alert('the image did not upload:', error);
          }
        }

        let itemId = formObj.id;
        let formData = new FormData(form);

        let postUrl = shouldUpdateImage
          ? '/clothing/edititem'
          : '/clothing/editpartial';

        let XHR = new XMLHttpRequest();
        XHR.open('POST', postUrl);
        XHR.withCredentials = true; // Ensure cookies are included
        XHR.addEventListener('load', (event) => {
          let request = event.target;
          if (request.status === 200) {
            let itemToReplace = document.querySelector(
              `[data-item-id="${itemId}"]`
            );
            itemToReplace.innerHTML = request.response;
            if (popupDisplay.newImageUrl) {
              itemToReplace.querySelector('img').src = popupDisplay.newImageUrl;
            }
            popupDisplay.forceCloseModal();
            popupDisplay.displayFlashMessage();
          }
        });

        XHR.addEventListener('error', (event) => {
          console.log(event);
        });

        XHR.send(formData);
      });
    });

    xhr.addEventListener('error', (error) => {
      console.log(error);
    });

    xhr.send();
  }
});

function showImage(file) {
  document.getElementById('preview').src = URL.createObjectURL(file);
}
