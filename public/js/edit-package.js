document.addEventListener("DOMContentLoaded", () => {
  const table = document.querySelector('table');

  table.addEventListener("click", (event) => {
    const target = event.target;
    let row = target.parentNode.parentNode;
    if (!row) return;

    const pkgId = row.id;
    const originialInnerHTML = row.innerHTML;
  
    if (target.classList.contains("edit-pkg")) {
      const request = new XMLHttpRequest();
      request.open('GET', `/packages/edit/${pkgId}`);
  
      request.addEventListener('load', event => {
        const response = event.target.response
        row.innerHTML = response;
  
        row.addEventListener('click', (event) => {
          const button = event.target;
          if (button.classList.contains("cancel")) {
            row.innerHTML = originialInnerHTML;
          } else if (button.classList.contains("save")) {
            let inputs = row.querySelectorAll('input');
            let updateData = {id: pkgId};
            inputs.forEach(input => updateData[input.name] = input.value || null);

            const postRequest = new XMLHttpRequest()
            postRequest.open("POST", `/packages/edit/${pkgId}`);
            postRequest.setRequestHeader("Content-Type", "application/json");
            postRequest.addEventListener('load', event => {
              row.innerHTML = event.target.response;
            })
            postRequest.send(JSON.stringify(updateData))
          } 
        })
      })
  
      request.send()
    } 

    if (target.classList.contains("update")) {
      const target = event.target;
      const row = target.parentNode.parentNode;
      if (!row) return;

      const pkgId = row.id;
      const pricePerItem = row.querySelector('.priceperitem')
                              .textContent
                              .substring(1);

      const postRequest = new XMLHttpRequest();
      postRequest.open("POST", `/packages/items/${pkgId}/shippingcost`);
      postRequest.setRequestHeader("Content-Type", "application/json");
      postRequest.addEventListener('load', event => {
        row.innerHTML = originialInnerHTML;
      })
      postRequest.send(JSON.stringify({pricePerItem}));
    }
  })
})
