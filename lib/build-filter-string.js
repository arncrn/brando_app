module.exports = function buildFilterString(queryObj, gender) {
  if (gender === 'all') {
    gender = '';
  }

  if (Object.keys(queryObj).length === 0) {
    if (!gender) return '';
    if (gender === 'instock') return 'WHERE in_stock = true';
    return `WHERE gender = '${gender}'`;
  }

  function addParens(string) {
    return `'${string}'`;
  }

  function addPercents(string) {
    return `'%${string}%'`;
  }

  let filterString = 'WHERE';

  Object.keys(queryObj).forEach((property, idx) => {
    let values = queryObj[property];

    if (idx !== 0) {
      filterString += ' AND'
    }
    if (Array.isArray(values)) {
      if (property === 'colors') {
        filterString += ` (colors ILIKE ${values.map(addPercents).join(' AND colors ILIKE ')})`;
      } else {
        filterString += ` clothing.${property} IN (${values.map(addParens).join(', ')})`;
      }
    } else if (property === 'colors') {
      filterString += ` clothing.${property} ILIKE (${addPercents(values)})`;
    } else {
      filterString += ` clothing.${property} IN ('${values}')`;
    }
  });

  if (gender) {
    if (gender === 'instock') {
      filterString += ' AND in_stock = true';
    } else {
      filterString += ` AND gender = '${gender}'`;
    }
  }
  console.log(filterString);
  return filterString;
}