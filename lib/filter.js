const brands = (items=[]) => { 
  let filtered = [];
  let brandObj = {};

  items.forEach(item => {
    let brand = item.brand;
    if (!brandObj[brand]) {
      brandObj[brand] = brand;
      filtered.push(item);
    }
  })

  return _sortBrandsAlphabetically(filtered);
};

const types = (items=[]) => { 
  let typeObj = {};
  let filtered = [];

  items.forEach(item => {
    let type = item.type;
    if (!typeObj[type]) {
      typeObj[type] = type;
      filtered.push(item);
    }
  })

  return _sortTypesAlphabetically(filtered);
};

const colors = (items=[]) => { 
  let colorObj = {};
  let filtered = [];

  items.forEach(item => {
    let colors = item.colors.split(', ');
    colors.forEach(color => {
      if (!colorObj[color]) {
        colorObj[color] = color;
        filtered.push({colors: color});
      }
    });
  })
  
  return _sortColorsAlphabetically(filtered);
}

const sizes = (items=[]) => { 
  let sizeObj = {};
  let filtered = [];

  items.forEach(item => {
    let size = item.size;
    if (!sizeObj[size]) {
      sizeObj[size] = size;
      filtered.push(item);
    }
  })

  return _sortSizesAlphabetically(filtered);
};

const locations = (items) => { 
  let filtered = [{location: 'usa'}, {location: 'ukraine'}, {location: 'jenia'}];

  return _sortLocationsAlphabetically(filtered);
};

const _sortBrandsAlphabetically = (items) => {
  return items.sort((a, b) => {
    if (a.brand > b.brand) return 1;
    if (a.brand < b.brand) return -1;
    return 0;
  });
}

const _sortTypesAlphabetically = (items) => {
  return items.sort((a, b) => {
    if (a.type > b.type) return 1;
    if (a.type < b.type) return -1;
    return 0;
  });
}

const _sortColorsAlphabetically = (items) => {
  return items.sort((a, b) => {
    if (a.colors > b.colors) return 1;
    if (a.colors < b.colors) return -1;
    return 0;
  })
}

const _sortSizesAlphabetically =(items) => {
  return items.sort((a, b) => {
    if (a.size > b.size) return -1;
    if (a.size < b.size) return 1;
    return 0;
  })
}

const _sortLocationsAlphabetically = (items) => {
  return items.sort((a, b) => {
    if (a.location > b.location) return 1;
    if (a.location < b.location) return -1;
    return 0;
  })
}

module.exports = {
  brands,
  types,
  colors,
  sizes,
  locations,
};