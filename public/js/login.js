document.addEventListener('DOMContentLoaded', () => {
  let form = document.querySelector('form');

  form.addEventListener('submit', (event) => {
    event.preventDefault();
    let XHR = new XMLHttpRequest();

    XHR.open('POST', '/login');
    XHR.setRequestHeader('content-type', 'application/json');
    XHR.addEventListener('load', (event) => {
      const response = JSON.parse(event.target.responseText);
      if (event.target.status === 200 && response.success) {
        window.location.href = response.redirect; // Manually navigate
      } else {
        alert('invalid username/password');
      }
    });

    XHR.send(
      JSON.stringify({
        username: form.username.value,
        password: form.password.value,
      })
    );
  });
});
