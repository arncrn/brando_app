document.addEventListener('DOMContentLoaded', () => {
  const filter = document.getElementById("package-filter");
  filter.addEventListener('input', (event) => {
    let pkgs = document.querySelectorAll('[data-pkg-id]');
    pkgs.forEach(pkg => {
      let pkgName = pkg.querySelector('.package-target').textContent.toLowerCase();
      if (filter.value.trim().length === 0) {
        pkg.style.display = "table-row";
      } else if (filter.value.trim().length > 0 && pkgName.toLowerCase().includes(filter.value.toLowerCase())) {
        pkg.style.display = "table-row";
      } else {
        pkg.style.display = 'none';
      }
    })
  })
});