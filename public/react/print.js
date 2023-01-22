const e = React.createElement;
const {useState, useEffect} = React;

const Print = () => {
  const [items, setItems] = useState([]);
  const [sumOfItems, setSumOfItems] = useState(0);
  const [totalShipping, setTotalShipping] = useState(0);
  const [pkg, setPkg] = useState({});
  const [allowImages, setAllowImages] = useState(false);
  const [visibleEditButton, setVisibleEditButton] = useState(false);
  
  useEffect(async () => {
    const pkgId = document.querySelector('[data-pkg-id]').dataset.pkgId;
    let response = await (await fetch(`/packages/packageitems/${pkgId}`)).json();
    let pkgResponse = await (await fetch(`/packages/singlepackage/${pkgId}`)).json();
    setPkg(pkgResponse);
    setItems(response.items);
    setSumOfItems(response.sumOfItems);
    setTotalShipping(response.totalShipping);
  }, []);
  
  let pricePerItem = 0;
  if (items.length > 0) {
    pricePerItem = (Number(pkg.price) / Number(items.length)).toFixed(2);
  }

  
  return ( 
    <main>
      <button onClick={() => setAllowImages(!allowImages)}>Toggle Images</button>
      <button onClick={() => setVisibleEditButton(!visibleEditButton)}>Set Customers</button>
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
            {allowImages && <th>Image</th>}
            <th>Customer</th>
          </tr>
        </thead>
        <tbody>
          {items.map((item, idx) => {
            return (
              <TableRow 
                key={item.id}
                item={item} 
                idx={idx} 
                allowImages={allowImages} 
                visibleEditButton={visibleEditButton}
                setItems={setItems}
                packageName={pkg.package_name}
              />
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
            <td><strong>${totalShipping}</strong></td>
          </tr>
        </tbody>
        <tfoot></tfoot>
      </table>
    </main>
  )
}

const EditButton = ({editEnabled, setEditEnabled, handleSave}) => {
  return (
    !editEnabled ?
      <td><button onClick={() => setEditEnabled(true)}>Edit Link</button></td> :
      <React.Fragment>
        <td><button onClick={handleSave}>Save</button></td>
        <td><button onClick={() => setEditEnabled(false)}>Cancel</button></td>
      </React.Fragment>
  )
}


const SoldLink = ({soldTo, visibleEditButton, itemId, updateSoldToValue}) => {
  const [editEnabled, setEditEnabled] = useState(false);
  const [linkValue, setLinkValue] = useState(soldTo || "");

  const changeInputValue = ({target}) => {
    setLinkValue(target.value);
  }

  const handleSave = () => {
    fetch(`/clothing/updatesoldlink/${itemId}`, {
      method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
      body: JSON.stringify({soldTo: linkValue}),
    }).then(() => {
      updateSoldToValue(itemId, linkValue);
      setEditEnabled(false);
    })
  }

  const linkDisplay = () => {
    return (
      editEnabled ?
      <td><input type="text" value={linkValue} onChange={changeInputValue}/></td> :
      <td><a href={soldTo || "#"} target="_blank">{soldTo || ""}</a></td>
    )
  }
  
  return (
      <React.Fragment>
        {linkDisplay()}
        {
          visibleEditButton &&
          <EditButton 
            editEnabled={editEnabled}
            setEditEnabled={setEditEnabled}
            handleSave={handleSave}
          />
        }
      </React.Fragment>
    )
}

const ClothingImage = ({picture, id, updateArrived}) => {
  return (
    <td onClick={() => updateArrived(id)}>
      {picture && <img height="150px" src={`https://d2hcaqfu7kwyzt.cloudfront.net/${picture}`} />}
    </td>
  )
}

const TableRow = ({item, idx, allowImages, visibleEditButton, setItems, packageName}) => {
  const [arrived, setArrived] = useState(item.arrived);
  const sold = item.sold_price > 0;

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
  
  const updateSoldToValue = (itemId, linkValue) => {
    let updatedItems = items.map(item => {
      if (item.id === itemId) {
        return {...item, sold_to: linkValue}
      }
      return item;
    })
    setItems(updatedItems);
  };

  const updateArrived = (id) => {
    fetch(`/clothing/updatearrived/${id}`, {
      method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
      body: JSON.stringify({itemId: id, arrived: !arrived}),
    }).then(() => {
      setArrived(!arrived);
    })
  }

  const isAllaPackage = () => {
    return packageName.match(/alla/i);
  }

  const setBackgroundColor = () => {
    let bgColor = null;

   if (sold) {
      bgColor = 'red';
    } else if (arrived) {
      bgColor = 'cyan';
    }

    return {backgroundColor: bgColor};
  }

  return (
    <tr style={setBackgroundColor()}>
      <th>{idx + 1}</th>
      <td>{item.brand}</td>
      <td>{item.type}</td>
      <td>{item.size}</td>
      <td>{item.colors}</td>
      <td>{item.tag_number}</td>
      <td>${formatPrice(item)}</td>
      <td>${item.shipping_cost}</td>
      <td>{formatText(item.extra_info)}</td>
      {
        allowImages &&
        <ClothingImage 
          picture={item.picture} 
          updateArrived={updateArrived}
          id={item.id}
        />
      }
      <SoldLink 
        soldTo={item.sold_to} 
        visibleEditButton={visibleEditButton}
        itemId={item.id}
        updateSoldToValue={updateSoldToValue}
      />
    </tr>
  )
}
    
const domContainer = document.querySelector('#print');
ReactDOM.render(e(Print), domContainer);

// ALTER TABLE clothing ADD COLUMN arrived boolean DEFAULT false;