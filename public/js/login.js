document.addEventListener('DOMContentLoaded', () => {
  let form = document.querySelector('form')
  form.addEventListener('submit', (event) => {
    event.preventDefault()
    let XHR = new XMLHttpRequest();
    let formData = new FormData(form)
    // console.log(formData.values());
    // console.log(formData);
    XHR.open('POST', '/login')
    XHR.setRequestHeader('content-type', 'application/json')
    XHR.addEventListener('load', (event) => {
      console.log(event.target.status);
    })

    XHR.send(JSON.stringify({
      username: form.username.value, 
      password: form.password.value
    }));
  })

})