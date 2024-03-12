const e = React.createElement;
const {useState, useEffect} = React;

const formatText = (extraInfo) => {
  if (extraInfo === null) {
    return;
  }
  return extraInfo.split("\r\n").map((text, idx) => {
    return (<p key={idx}>{text}</p>);
  });
}

const Print = () => {
  const [items, setItems] = useState([]);
  const [sumOfItems, setSumOfItems] = useState(0);
  const [totalShipping, setTotalShipping] = useState(0);
  const [totalSelling, setTotalSelling] = useState(0);
  const [totalProfit, setTotalProfit] = useState(0);
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
    setTotalSelling(response.totalSelling);
    setTotalProfit(response.totalProfit);
  }, []);
  
  let pricePerItem = 0;
  if (items.length > 0) {
    pricePerItem = (Number(pkg.price) / Number(items.length)).toFixed(2);
  }

  const updateSoldToValue = (itemId, linkValue, soldPrice) => {
    let updatedItems = items.map(item => {
      if (item.id === itemId) {
        return {...item, sold_to: linkValue, sold_price: soldPrice}
      }
      return item;
    })
    setItems(updatedItems);
  };
  
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
            <th>Selling Price</th>
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
                updateSoldToValue={updateSoldToValue}
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
            <td><strong>${totalSelling}</strong></td>
          </tr>
          <tr>
            <th>Total Profit:</th>
            <td colspan="100%">{totalProfit}</td>
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

const SoldPrice = ({price, setPrice, editEnabled}) => {
  const changeInputValue = ({target}) => {
    setPrice(target.value);
  }

  return (
    editEnabled ?
    <td><input type="text" value={price} onChange={changeInputValue}/></td> :
    <td>{price ? `$${price}` : ""}</td>
  )
}

const ExtraInfoText = ({setExtraInfo, extraInfo, editEnabled}) => {
  const changeInputValue = ({target}) => {
    setExtraInfo(target.value);
  }

  return (
    editEnabled ?
    <td><input type="text" value={extraInfo} onChange={changeInputValue}/></td> :
    <td>{formatText(extraInfo)}</td> 
  );
}

const SoldLink = ({visibleEditButton, itemId, handleSave, linkValue, setLinkValue, editEnabled, setEditEnabled}) => {
  const changeInputValue = ({target}) => {
    setLinkValue(target.value);
  }

  const linkDisplay = () => {
    return (
      editEnabled ?
      <td><input type="text" value={linkValue} onChange={changeInputValue}/></td> :
      <td><a href={linkValue || "#"} target="_blank">{linkValue || ""}</a></td>
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
            handleSave={() => handleSave(itemId)}
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

const TableRow = ({item, idx, allowImages, visibleEditButton, packageName, updateSoldToValue}) => {
  const [arrived, setArrived] = useState(item.arrived);
  const [editEnabled, setEditEnabled] = useState(false);
  const [linkValue, setLinkValue] = useState(item.sold_to || "");
  const [price, setPrice] = useState(item.sold_price || "");
  const [extraInfo, setExtraInfo] = useState(item.extra_info || "");

  const sold = item.sold_price > 0;
  
  const formatPrice = (item) => {
    return `Price: ${item.purchase_price}
    Tax: ${item.tax_amount}
    Total: ${item.total_price}`;
  }

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

  const handleSave = (itemId) => {
    fetch(`/clothing/updatesoldlink/${itemId}`, {
      method: "POST",
        headers: {
          'Content-Type': 'application/json',
        },
      body: JSON.stringify({soldTo: linkValue}),
    })
    .then(saveSoldPrice(itemId))
    .then(saveExtraInfo(itemId))
    .then(() => {
      updateSoldToValue(itemId, linkValue, price);
      setEditEnabled(false);
    });
  }

  const saveExtraInfo = (itemId) => {
    fetch(`/clothing/editExtraInfo/${itemId}`, {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({extraInfo: extraInfo}),
    });
  }

  const saveSoldPrice = (itemId) => {
    const customer = window.localStorage.getItem('customer');
    let person;
    let sellingMonth;

    if (price === undefined) {
      return;
    }

    if (isAllaPackage()) {
      person = 'alla';
      sellingMonth = 'Nastia-Alla' + ' ' + customer; 
    } else {
      person = 'nastia';
      sellingMonth = customer;
    }

    const uahUsdConversion = window.localStorage.getItem('uahUsdConverion') || 39;
    const convertedPrice = String(price / uahUsdConversion);

    fetch(`/clothing/sellitem/${itemId}`, {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({soldPrice: convertedPrice, customer: sellingMonth, person: person}),
    })
      .then(response => response.text());
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
      <SoldPrice
        setPrice={setPrice}
        price={price}
        editEnabled={editEnabled}
      />
      <ExtraInfoText 
        editEnabled={editEnabled}
        extraInfo={extraInfo}
        setExtraInfo={setExtraInfo}
      />
      {
        allowImages &&
        <ClothingImage 
          picture={item.picture} 
          updateArrived={updateArrived}
          id={item.id}
        />
      }
      <SoldLink 
        visibleEditButton={visibleEditButton}
        itemId={item.id}
        handleSave={handleSave}
        linkValue={linkValue}
        setLinkValue={setLinkValue}
        editEnabled={editEnabled}
        setEditEnabled={setEditEnabled}
      />
    </tr>
  )
}
    
const domContainer = document.querySelector('#print');
ReactDOM.render(e(Print), domContainer);

// ALTER TABLE clothing ADD COLUMN arrived boolean DEFAULT false;
// ALTER TABLE clothing ADD COLUMN marked boolean DEFAULT false;