document.addEventListener("DOMContentLoaded", () => {
  const table = document.querySelector('table');

  table.addEventListener("click", (event) => {
    const target = event.target;
    let row = target.parentNode.parentNode;
    if (!row) return;

    const orderId = row.id;
    const originialInnerHTML = row.innerHTML;
  
    if (target.classList.contains("edit-order")) {
      const request = new XMLHttpRequest();
      request.open('GET', `/orders/edit/${orderId}`);
  
      request.addEventListener('load', event => {
        const response = event.target.response
        row.innerHTML = response;
  
        row.addEventListener('click', (event) => {
          const button = event.target;
          if (button.classList.contains("cancel")) {
            row.innerHTML = originialInnerHTML;
          } else if (button.classList.contains("save")) {
            let inputs = row.querySelectorAll('.input');
            let updateData = {id: orderId};
            inputs.forEach(input => updateData[input.name] = input.value || null);

            const postRequest = new XMLHttpRequest()
            postRequest.open("POST", `/orders/edit/${orderId}`);
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
  })

})

