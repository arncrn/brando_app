class PopupDisplay {
  constructor() {
    this.modalContainer = document.getElementById('modal-container');
    this.currentTab = 'main-tab';
    this.removeModal = this.removeModal.bind(this);
    this.basicDetails;
    this.imageDisplay;
    this.priceDetails;
    this.packageDetails;
    this.orderDetails;
    this.extraInfo;
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
    if (!this._isModalForm(event.target) || event.target.id === 'cancel') {
      event.preventDefault();
      let modalContainer = document.getElementById('modal-container');
      modalContainer.innerHTML = null;
      modalContainer.removeEventListener('click', this.removeModal);
    }
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
  }

  hideAllTabs() {
    this.basicDetails.style.display = 'none';
    this.imageDisplay.style.display = 'none';
    this.priceDetails.style.display = 'none';
    this.packageDetails.style.display = 'none';
    this.orderDetails.style.display = 'none';
    this.extraInfo.style.display = 'none';
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
    })

    xhr.addEventListener('error', error => {
      console.log(error);
    });

    xhr.send();

    popupDisplay.modalContainer.addEventListener('click', event => {
      if (event.target.classList.contains('modal-nav')) {
        popupDisplay.removeActiveTabs();
        popupDisplay.changeTab(event.target);
      }
    })
  }
});