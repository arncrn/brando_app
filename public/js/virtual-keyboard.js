const Keyboard = window.SimpleKeyboard.default;
const defaultTheme = "hg-theme-default";

const keyboard = new Keyboard({
    theme: defaultTheme,
    onChange: input => onChange(input),
    onKeyPress: button => onKeyPress(button)
});

let selectedInput;

const allInput = [];
const inputFields = document.querySelectorAll('input[type=text]');
const brandField = document.querySelector('input[name=brand]');
const typeField = document.querySelector('input[name=type]');

inputFields.forEach(field => allInput.push(field));
allInput.push(brandField);
allInput.push(typeField);

allInput.forEach(input => {
    input.addEventListener("focus", onInputFocus);
    // Optional: Use if you want to track input changes
    // made without simple-keyboard
    input.addEventListener("input", onInputChange);
})

function onInputFocus(event) {
    const inputName = event.target.name;
    selectedInput = `input[name=${inputName}]`;
    showKeyboard()

    keyboard.setOptions({
        inputName: event.target.name
    });
}

function onInputChange(event) {
  keyboard.setInput(event.target.value, event.target.name);
}

function onChange(input) {
  document.querySelector(selectedInput).value = input;
}

function onKeyPress(button) {
  /**
   * Shift functionality
   */
  if (button === "{lock}" || button === "{shift}") handleShiftButton();
}

function handleShiftButton() {
  let currentLayout = keyboard.options.layoutName;
  let shiftToggle = currentLayout === "default" ? "shift" : "default";

  keyboard.setOptions({
    layoutName: shiftToggle
  });
}

function showKeyboard() {
    keyboard.setOptions({
        theme: `${defaultTheme} show-keyboard`
    });
}
  
function hideKeyboard() {
    keyboard.setOptions({
        theme: defaultTheme
    });
}

document.addEventListener("click", (event) => {
    console.log(event.target.value)
    if (
        keyboard.options.theme.includes("show-keyboard") &&
        !event.target.className.includes("simple-keyboard") &&
        !event.target.className.includes("hg-button") &&
        event.target.value === undefined
    ) {
        hideKeyboard();
        return;
    }

    if (
      /**
       * Hide the keyboard when you're not clicking it or when clicking an input
       * If you have installed a "click outside" library, please use that instead.
       */
      keyboard.options.theme.includes("show-keyboard") &&
      !event.target.className.includes("simple-keyboard") &&
      !event.target.className.includes("hg-button") &&
      !event.target.type.includes("text")
    ) {
      hideKeyboard();
    }
  });