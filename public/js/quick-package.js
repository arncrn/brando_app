document.addEventListener('DOMContentLoaded', () => {
  let timeout;
  let regex = /[^0-9.]/g;
  let pkgInput = document.getElementById('package-number').nextElementSibling;
  let displayedPackageName = document.getElementById(
    'generated-package-name'
  ).nextElementSibling;

  let pkg = window.localStorage.getItem('pkg') || {};
  if (typeof pkg === 'string') {
    pkg = JSON.parse(pkg);
  }

  pkgInput.value = pkg.id || '';
  displayedPackageName.value = pkg.name || '';

  pkgInput.addEventListener('input', (e) => {
    if (timeout) {
      clearTimeout(timeout);
    }
    timeout = setTimeout(() => {
      let pkgId = pkgInput.value.replace(regex, '') || 0;
      fetch(`/packages/singlepackage/${pkgId}`, {
        credentials: include,
      })
        .then((response) => response.json())
        .then((pkgData) => {
          if (pkgData) {
            pkg = { id: pkgData.id, name: pkgData.package_name };
            window.localStorage.setItem('pkg', JSON.stringify(pkg));
            displayedPackageName.value = pkg.name;
          } else {
            window.localStorage.setItem('pkg', JSON.stringify({}));
            displayedPackageName.value = '';
          }
        });
    }, 1000);
  });

  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('quick-package-button')) {
      let itemId = e.target.parentNode.parentNode.id.split('-')[2];
      let itemToReplace = document.querySelector(`[data-item-id="${itemId}"]`);

      fetch(`/clothing/addtopackage/${itemId}`, {
        method: 'POST',
        credentials: include,
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ pkgId: pkg.id, pkgName: pkg.name }),
      })
        .then((response) => {
          if (response.status === 204) {
            alert("That package doesn't exist");
            return false;
          } else {
            return response.text();
          }
        })
        .then((data) => {
          if (data) itemToReplace.innerHTML = data;
        });
    }
  });
});
