const express = require('express');
const app = express();
const exphbs = require('express-handlebars');
const port = 3000;

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');


app.use(express.static("public"));

app.get('/', (req, res) => {
  res.redirect('/clothing');
});

app.get("/clothing", (req, res) => {
  res.render('home');
}); 

app.get("/clothing/view", (req, res) => {
  res.render('gender-select');
});

app.get("/view/:gender", (req, res, next) => {
  let gender = req.params.gender;
  res.render('detail-select');
});


app.get("/clothing/add", (req, res) => {
  res.render('picture');
})


app.listen(port, () => {
  console.log(`App running on port ${port}`);
});






// Function for getting breadcrumbs of the page
// function getBreadcrumbs(req, res, next) {
//   const urls = req.originalUrl.split('/');
//   urls.shift();
//   req.breadcrumbs = urls.map((url, i) => {
//     return {s
//       breadcrumbName: (url === '' ? 'Home' : url.charAt(0).toUpperCase() + url.slice(1)),
//       breadcrumbUrl: `/${urls.slice(0, i + 1).join('/')}`,
//     };
//   });
//   next();
// }