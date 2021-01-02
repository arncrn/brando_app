class RightClick {
  constructor() {
    this.itemId;
    this.optionBlock;
    this.setOptionBlock = this.setOptionBlock.bind(this);
    this.setContextBehavior = this.setContextBehavior.bind(this);
    this.insertItemIntoPage = this.insertItemIntoPage.bind(this);
    this.removeItemFromPage = this.removeItemFromPage.bind(this);
  }

  isContextMenu(node) {
    if (node.classList.contains("right-click-options")) {
      return true;
    } else if (node.parentElement === null) {
      return false;
    } else {
      return this.isContextMenu(node.parentElement);
    }
  }

  isItemBlock(node) {
    if (node.classList.contains('item-block')) {
      return true;
    } else if (node.parentElement === null) {
      return false;
    } else {
      return this.isItemBlock(node.parentElement);
    }
  }

  findItemId(node) {
    if (node.dataset.itemId) {
      this.itemId = node.dataset.itemId;
      return;
    }
    return this.findItemId(node.parentNode);
  }

  setOptionBlock() {
    this.optionBlock = document.getElementById(`right-click-option-${this.itemId}`)
  }

  removeContextMenu() {
    this.optionBlock.style.display = 'none';
    document.removeEventListener('click', this.setContextBehavior);
    this.itemId = null;
    this.optionBlock = null;
  }

  removeItemFromPage() {
    let currentElement = document.querySelector(`[data-item-id="${this.itemId}"]`);
    this.removeContextMenu();
    currentElement.remove();
  }

  insertItemIntoPage(responseHTML) {
    let currentElement = document.querySelector(`[data-item-id="${this.itemId}"]`);
    let div = document.createElement('div');
    div.innerHTML = responseHTML;
    let newElement = div.firstChild;
    currentElement.insertAdjacentElement('afterend', newElement);
  }

  duplicateItem() {
    let XHR = new XMLHttpRequest();
    XHR.open('POST', `/duplicateitem/${this.itemId}`);
    XHR.addEventListener('load', event => {
      let request = event.target;
      this.insertItemIntoPage(request.response);
    });
    XHR.addEventListener('error', err => {
      console.log(err);
    })
    XHR.send();
  }

  deleteItem() {
    let XHR = new XMLHttpRequest();
    XHR.open('POST', `/deleteitem/${this.itemId}`);
    XHR.addEventListener('load', event => {
      let request = event.target;
      console.log(request.response);
      this.removeItemFromPage();
    });
    XHR.addEventListener('error', err => {
      console.log(err);
    })
    XHR.send();
    console.log('delete!', this.itemId);
  }

  setContextBehavior(event) {
    if (!this.isContextMenu(event.target, this.itemId)) {
      this.removeContextMenu();
    } else if (event.target.classList.contains('duplicate')) {
      this.duplicateItem();
    } else if (event.target.classList.contains('delete')) {
      this.deleteItem();
    } else {
      return;
    }
  }
}

let rightClick = new RightClick();

document.addEventListener('contextmenu', (event) => {
  if (rightClick.isItemBlock(event.target)) {
    event.preventDefault();
    if (rightClick.itemId) {
      rightClick.removeContextMenu();
    }
    rightClick.findItemId(event.target);
    rightClick.setOptionBlock();
    rightClick.optionBlock.style.display = 'block';

    document.addEventListener('click', rightClick.setContextBehavior);
  }
})