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
    this.modalContainer.addEventListener('click', this.removeModal);
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
    this.basicDetails = document.getElementById('item-basic-details');
    this.imageDisplay = document.getElementById('image-display');
    this.priceDetails = document.getElementById('item-price-details');
    this.packageDetails = document.getElementById('item-package-details');
    this.orderDetails = document.getElementById('item-order-details');
    this.extraInfo = document.getElementById('item-extra-info');

    this.soldPriceUSD = document.getElementById('sold-price-usd');
    this.soldPriceUAH = document.getElementById('sold-price-uah');

    this.form = document.querySelector('form');
  }

  hideAllTabs() {
    this.basicDetails.style.display = 'none';
    this.imageDisplay.style.display = 'none';
    this.priceDetails.style.display = 'none';
    this.packageDetails.style.display = 'none';
    this.orderDetails.style.display = 'none';
    this.extraInfo.style.display = 'none';
  }

  submitForm(formData) {
    let XHR = new XMLHttpRequest();
    XHR.open('POST', `/edititem/${formData.id}`);
    XHR.setRequestHeader('Content-Type', 'application/json');
    XHR.addEventListener('load', event => {
      let request = event.target;
      if (request.status === 200) {
        let itemToReplace = document.querySelector(`[data-item-id="${formData.id}"]`);
        itemToReplace.innerHTML = request.response;
        this.forceCloseModal();
        this.displayFlashMessage();
      }
    })

    XHR.addEventListener('error', event => {
      console.log(event);
    })

    XHR.send(JSON.stringify(formData));
  }

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

    xhr.open('GET', `/item/${itemId}`);
    xhr.addEventListener('load', event => {
      let response = event.target.response;
      popupDisplay.openModal(response);
      popupDisplay.getPageDetails();

      popupDisplay.modalContainer.addEventListener('click', event => {
        if (event.target.classList.contains('modal-nav')) {
          popupDisplay.removeActiveTabs();
          popupDisplay.changeTab(event.target);
        }
      })

      popupDisplay.soldPriceUSD.addEventListener('input', event => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUAH.value = (+soldPrice * 28.6).toFixed(2);
      });

      popupDisplay.soldPriceUAH.addEventListener('input', event => {
        let regex = /[^0-9.]/g;
        let soldPrice = event.target.value.replace(regex, '');
        popupDisplay.soldPriceUSD.value = (+soldPrice / 28.6).toFixed(2);
      })

      popupDisplay.form.addEventListener('submit', event => {
        event.preventDefault();
        let formData = {};
        [...popupDisplay.form.elements].forEach(element => {
          if (element.name) {
            if (['purchase_price', 'shipping_cost', 'sold_price'].includes(element.name)) {
              let regex = /[^0-9.]/g;
              formData[element.name] = element.value.replace(regex, '');
            } else {
              formData[element.name] = element.value;
            }
          }
        })

        popupDisplay.submitForm(formData);
      })

    });

    xhr.addEventListener('error', error => {
      console.log(error);
    });

    xhr.send();
  }
});