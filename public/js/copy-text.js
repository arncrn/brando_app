document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('click', (event) => {
    if (event.target.classList.contains("copy-button")) {
      copy(event.target.nextElementSibling);
    }
  })
})

const clip = function(textContainer) {
  let range = document.createRange();
  range.selectNodeContents(textContainer);
  let selection = window.getSelection();
  selection.removeAllRanges();
  selection.addRange(range);
};

function copy(parentElement) {
  var copyText = parentElement.querySelector(".card-text");
  clip(copyText);
  document.execCommand("copy");
  // console.log("copied")
}
