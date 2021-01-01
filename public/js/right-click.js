document.addEventListener('contextmenu', (event) => {
  if (isItemBlock(event.target)) {
    event.preventDefault();
    let itemId = findItemId(event.target);
  }
})

function isItemBlock(node) {
  if (node.classList.contains('item-block')) {
    return true;
  } else if (node.parentElement === null) {
    return false;
  } else {
    return isItemBlock(node.parentElement);
  }
}