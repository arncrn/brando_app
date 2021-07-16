const e = React.createElement;
const {useState, useEffect} = React;

const Print = () => {
  const [items, setItems] = useState([]);
  const [sumOfItems, setSumOfItems] = useState(0);
  const [shippingCost, setShippingCost] = useState(0);
  const [revenue, setRevenue] = useState(0);
  const [profit, setProfit] = useState(0);

  useEffect(async () => {
    // const pkgId = document.querySelector('[data-pkg-id]').dataset.pkgId;
    const orderId = document.querySelector('[data-order-id]').dataset.orderId;

    let response = await (await fetch(`/orders/orderitems/${orderId}`)).json();
    setItems(response.items);
    setSumOfItems(response.sumOfItems);
    setShippingCost(response.shippingCost);
    setProfit(response.profit);
    setRevenue(response.revenue);
  }, [])

  const formatText = (extraInfo) => {
    if (extraInfo === null) {
      return;
    }
    return extraInfo.split("\r\n").map((text, idx) => {
      return (<p key={idx}>{text}</p>);
    });
  }

  const formatPrice = (item) => {
    return `Price: ${item.purchase_price}
    Tax: ${item.tax_amount}
    Total: ${item.total_price}`;
  }

  return (
    <main>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Brand</th>
            <th>Type</th>
            <th>Size</th>
            <th>Colors</th>
            <th>Tag Number</th>
            <th>Purchase Price</th>
            <th>Shipping Cost</th>
            <th>Sold For</th>
            <th>Profit</th>
            <th>Extra Details</th>
          </tr>
        </thead>
        <tbody>
          {items.map((item, idx) => {
            return (
              <tr key={item.id}>
                <th>{idx + 1}</th>
                <td>{item.brand}</td>
                <td>{item.type}</td>
                <td>{item.size}</td>
                <td>{item.colors}</td>
                <td>{item.tag_number}</td>
                <td>${formatPrice(item)}</td>
                <th>${item.shipping_cost}</th>
                <th>${item.pending ? 'PENDING' : item.sold_price}</th>
                <th>${item.profit}</th>
                <td>{formatText(item.extra_info)}</td>
              </tr>
            );
          })}
          <tr>
            <th>Total:</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><strong>${sumOfItems}</strong></td>
            <td><strong>${shippingCost}</strong></td>
            <td><strong>${revenue}</strong></td>
            <td><strong>${profit}</strong></td>
          </tr>
        </tbody>
        <tfoot></tfoot>
      </table>
    </main>
  )
}

const domContainer = document.querySelector('#print');
ReactDOM.render(e(Print), domContainer);