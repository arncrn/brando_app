class FilterSelect {
  constructor() {
    this.brandLabel = document.getElementById('brand-label');
    this.typeLabel = document.getElementById('type-label');
    this.colorsLabel = document.getElementById('colors-label');
    this.sizeLabel = document.getElementById('size-label');
    this.locationLabel = document.getElementById('location-label');

    this.brandFilter = document.getElementById('brand-filter');
    this.typeFilter = document.getElementById('type-filter')
    this.colorsFilter = document.getElementById('colors-filter')
    this.sizeFilter = document.getElementById('size-filter')
    this.locationFilter = document.getElementById('location-filter')

    this.brandSearch = document.getElementById('brand-search');
    this.typeSearch = document.getElementById('type-search');
    this.colorSearch = document.getElementById('color-search');
    this.sizeSearch = document.getElementById('size-search');

    this.clearBrandButton = document.getElementById('clear-brand');
    this.clearTypeButton = document.getElementById('clear-type');
    this.clearColorButton = document.getElementById('clear-color');
    this.clearSizeButton = document.getElementById('clear-size');

    this.displayBrandFilter = this.displayBrandFilter.bind(this);
    this.displayTypeFilter = this.displayTypeFilter.bind(this);
    this.displayColorsFilter = this.displayColorsFilter.bind(this);
    this.displaySizeFilter = this.displaySizeFilter.bind(this);
    this.displayLocationFilter = this.displayLocationFilter.bind(this);

    this.findBrands = this.findBrands.bind(this);
    this.findColors = this.findColors.bind(this);
    this.findTypes = this.findTypes.bind(this);
    this.findSizes = this.findSizes.bind(this);

    this.clearBrandInput = this.clearBrandInput.bind(this);
    this.clearColorInput = this.clearColorInput.bind(this);
    this.clearSizeInput = this.clearSizeInput.bind(this);
    this.clearTypeInput = this.clearTypeInput.bind(this);
  }

  displayBrandFilter(event) {
    this._showAllLabels();
    this.brandLabel.style.display = 'none';
    this.brandFilter.style.display = 'flex';
  }

  displayTypeFilter(event) {
    this._showAllLabels();
    this.typeLabel.style.display = 'none';
    this.typeFilter.style.display = 'flex';
  }

  displayColorsFilter(event) {
    this._showAllLabels();
    this.colorsLabel.style.display = 'none';
    this.colorsFilter.style.display = 'flex';
  }

  displaySizeFilter(event) {
    this._showAllLabels();
    this.sizeLabel.style.display = 'none';
    this.sizeFilter.style.display = 'flex';
  }

  displayLocationFilter(event) {
    this._showAllLabels();
    this.locationLabel.style.display = 'none';
    this.locationFilter.style.display = 'flex';
  }

  addEventListeners() {
    this.brandLabel.addEventListener('click', this.displayBrandFilter);
    this.typeLabel.addEventListener('click', this.displayTypeFilter);
    this.colorsLabel.addEventListener('click', this.displayColorsFilter);
    this.sizeLabel.addEventListener('click', this.displaySizeFilter);
    this.locationLabel.addEventListener('click', this.displayLocationFilter);

    this.brandSearch.addEventListener('input', this.findBrands);
    this.typeSearch.addEventListener('input', this.findTypes);
    this.colorSearch.addEventListener('input', this.findColors);
    this.sizeSearch.addEventListener('input', this.findSizes);

    this.clearBrandButton.addEventListener('click', this.clearBrandInput);
    this.clearTypeButton.addEventListener('click', this.clearTypeInput);
    this.clearColorButton.addEventListener('click', this.clearColorInput);
    this.clearSizeButton.addEventListener('click', this.clearSizeInput);
  }

  clearBrandInput(event) {
    event.preventDefault();
    this.brandSearch.value = '';
    this.setLabelBackgroundColors('brand');
  }

  clearTypeInput(event) {
    event.preventDefault();
    this.typeSearch.value = '';
    this.setLabelBackgroundColors('type');
  }

  clearColorInput(event) {
    event.preventDefault();
    this.colorSearch.value = '';
    this.setLabelBackgroundColors('color');
  }

  clearSizeInput(event) {
    event.preventDefault();
    this.sizeSearch.value = '';
    this.setLabelBackgroundColors('size');
  }

  setLabelBackgroundColors(filterName) {
    let filter;
    let inputBox;
    switch(filterName) {
      case 'brand': filter = this.brandFilter; inputBox = this.brandSearch; break;
      case 'type': filter = this.typeFilter; inputBox = this.typeSearch; break;
      case 'color': filter = this.colorsFilter; inputBox = this.colorSearch; break;
      case 'size': filter = this.sizeFilter; inputBox = this.sizeSearch; break;
    }

    let targets = filter.querySelectorAll(`.${filterName}-label`);
    targets.forEach(target => {
      if (inputBox.value.length > 0 && target.textContent.toLowerCase().includes(inputBox.value.toLowerCase())) {
        target.style.backgroundColor = 'yellow';
      } else {
        target.style.backgroundColor = null;
      }
    })
  }

  findBrands(event) {
    this.setLabelBackgroundColors('brand');
  }

  findTypes(event) {
    this.setLabelBackgroundColors('type');
  }

  findColors(event) {
    this.setLabelBackgroundColors('color');
  }

  findSizes(event) {
    this.setLabelBackgroundColors('size');
  }

  _showAllLabels() {
    this._hideAllFilters();
    this.brandLabel.style.display = "flex";
    this.typeLabel.style.display = 'flex';
    this.colorsLabel.style.display = 'flex';
    this.sizeLabel.style.display = 'flex';
    this.locationLabel.style.display = 'flex';
  }

  _hideAllFilters() {
    this.brandFilter.style.display = 'none';
    this.typeFilter.style.display = 'none';
    this.colorsFilter.style.display = 'none';
    this.sizeFilter.style.display = 'none';
    this.locationFilter.style.display = 'none';
  };
}

document.addEventListener('DOMContentLoaded', () => {
  new FilterSelect().addEventListeners();
})