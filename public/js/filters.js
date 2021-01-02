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


    this.displayBrandFilter = this.displayBrandFilter.bind(this);
    this.displayTypeFilter = this.displayTypeFilter.bind(this);
    this.displayColorsFilter = this.displayColorsFilter.bind(this);
    this.displaySizeFilter = this.displaySizeFilter.bind(this);
    this.displayLocationFilter = this.displayLocationFilter.bind(this);

    this.findBrands = this.findBrands.bind(this);
    this.findColors = this.findColors.bind(this);
    this.findTypes = this.findTypes.bind(this);
    this.findSizes = this.findSizes.bind(this);
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
  }

  findBrands(event) {
    let brands = this.brandFilter.querySelectorAll('.brand-label');

    brands.forEach(brand => {
      if (event.currentTarget.value.length > 0 && brand.textContent.toLowerCase().includes(event.currentTarget.value.toLowerCase())) {
        brand.style.backgroundColor = 'yellow';
      } else {
        brand.style.backgroundColor = null;
      }
    });
  }

  findTypes(event) {
    let types = this.typeFilter.querySelectorAll('.type-label');

    types.forEach(type => {
      if (event.currentTarget.value.length > 0 && type.textContent.toLowerCase().includes(event.currentTarget.value.toLowerCase())) {
        type.style.backgroundColor = 'yellow';
      } else {
        type.style.backgroundColor = null;
      }
    });
  }

  findColors(event) {
    let colors = this.colorsFilter.querySelectorAll('.color-label');

    colors.forEach(color => {
      if (event.currentTarget.value.length > 0 && color.textContent.toLowerCase().includes(event.currentTarget.value.toLowerCase())) {
        color.style.backgroundColor = 'yellow';
      } else {
        color.style.backgroundColor = null;
      }
    });
  }

  findSizes(event) {
    let sizes = this.sizeFilter.querySelectorAll('.size-label');

    sizes.forEach(size => {
      if (event.currentTarget.value.length > 0 && size.textContent.toLowerCase().includes(event.currentTarget.value.toLowerCase())) {
        size.style.backgroundColor = 'yellow';
      } else {
        size.style.backgroundColor = null;
      }
    });
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