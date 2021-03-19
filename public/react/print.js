const e = React.createElement;
const {useState, useEffect} = React;

const Print = () => {
  const [items, setItems] = useState([]);
  const [sumOfItems, setSumOfItems] = useState(0);
  const [pkg, setPkg] = useState({});

  useEffect(async () => {
    const pkgId = document.querySelector('[data-pkg-id]').dataset.pkgId;
    let response = await (await fetch(`/api/packageitems/${pkgId}`)).json();
    let pkgResponse = await (await fetch(`/singlepackage/${pkgId}`)).json();
    setPkg(pkgResponse);
    setItems(response.items);
    setSumOfItems(response.sumOfItems);
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
  
  let pricePerItem = 0;
  if (items.length > 0) {
    pricePerItem = (Number(pkg.price) / Number(items.length)).toFixed(2);
  }

  console.log(pricePerItem);
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
                <td>${Number(item.shipping_cost) || pricePerItem}</td>
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
          </tr>
        </tbody>
        <tfoot></tfoot>
      </table>
    </main>
  )
}

const domContainer = document.querySelector('#print');
ReactDOM.render(e(Print), domContainer);