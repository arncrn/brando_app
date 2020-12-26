module.exports = function buildFilterString(queryObj) {
  if (Object.keys(queryObj).length === 0) return '';

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
        filterString += ` ${property} IN (${values.map(addParens).join(', ')})`;
      }
    } else {
      filterString += ` ${property} IN ('${values}')`;
    }
  });

  return filterString;
}