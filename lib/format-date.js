module.exports = dateString => {
  let [month, day, year] = dateString.split('/')
  if (+month < 10) {
   month = '0' + month;
  }
  if (+day < 10) {
   day = '0' + day;
  }
 
  return `${year}-${month}-${day}`;
 }