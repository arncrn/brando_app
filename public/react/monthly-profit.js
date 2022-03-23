const e = React.createElement;
const { useState, useEffect } = React;

const MonthlyProfit = () => {
  // const [items, setItems] = useState([]);
  // const [sumOfItems, setSumOfItems] = useState(0);
  // const [shippingCost, setShippingCost] = useState(0);
  // const [revenue, setRevenue] = useState(0);
  const [profit, setProfit] = useState(0);
  const [allaInfo, setAllaInfo] = useState([]);
  const [nastyaInfo, setNastyaInfo] = useState([]);
  const [jeniaInfo, setJeniaInfo] = useState([]);
  const [combinedInfo, setCombinedInfo] = useState([]);
  // const [combinedInfo, setCombinedInfo] = useState([]);

  useEffect(async () => {
    // const pkgId = document.querySelector('[data-pkg-id]').dataset.pkgId;
    // const orderId = document.querySelector('[data-order-id]').dataset.orderId;

    const response = await (await fetch("/orders/monthly-profits/data")).json();
    const nastyaProfit = extractNastyaData(response);
    const jeniaProfit = extractJeniaData(response);


    
    // console.log(jeniaProfit);
    // const allaProfit = extractAllaData(response);
    // setAllaInfo(allaProfit);
    setNastyaInfo(nastyaProfit);
    setJeniaInfo(jeniaProfit);
    // set

    const combined = combineExtractedData(nastyaProfit, jeniaProfit);
    setCombinedInfo(combined);


    // console.log(allaProfit);
    // console.log(response);

    // let response = await (await fetch(`/orders/orderitems/${orderId}`)).json();
    // setItems(response.items);
    // setSumOfItems(response.sumOfItems);
    // setShippingCost(response.shippingCost);
    // setProfit(response.profit);
    // setRevenue(response.revenue);
  }, []);

  const isInTheFuture = (month, year) => {
    const currentDate = new Date();
    const dataDate =  new Date(`${month} ${year}`);
    return dataDate > currentDate;
  }

  const combineExtractedData = (nastya, jenia) => {
    let combined = [];
    // let 

    nastya.forEach((record, idx) => {
      const month = record.month;
      const year = record.year;
      if (isInTheFuture(month, year)) {
        return;
      }

      const jeniaRecord = jenia[idx];
      combined.push({
        date: `${month} ${year}`,
        nastya: record.total_profit,
        jenia: jeniaRecord.total_profit
      });
      // combined[`${month} ${year}`] = {
      //   nastia: record.total_profit,
      //   jenia: jeniaRecord.total_profit
      // }
    });

    return combined;
  }

  const extractNastyaData = (groupData) => {
    return groupData
      .filter(data => {
        return data.name.split(' ').length === 2;
      }).map(filtered => {
        const [month, year] = filtered.name.split(' ');
        return {
          ...filtered,
          name: 'Nastya',
          month,
          year
        }
      })
  }

  const extractJeniaData = (groupData) => {
    return groupData.filter(data => {
      return data.name.match(/(jenia)/i);
    })
    .map(filtered => {
      const [name, month, year] = filtered.name.split(" ");
      return {
        ...filtered,
        name,
        month, 
        year,
      }
    })
  }

  const calculateTotalProfit = (personInfo) => {
    const total = personInfo.reduce((sum, info) => {
      return sum + Number(info.total_profit);
    }, 0);

    return formatCurrency(total);
  }

  const extractAllaData = (groupData) => {
    // get everything that is for alla
    //  which has a month + year
    return groupData
      .filter(data => {
        return data.name.match(/alla/i) && data.name.length > 5;
      })
      .map(filtered => {
        // extract the name, month, year
        const [name, month, year] = filtered.name.split(" ");

        return {
          ...filtered,
          name,
          month,
          year
        };
      });

    // data.name, data.month, data.total_profit
  };

  // const formatText = (extraInfo) => {
  //   if (extraInfo === null) {
  //     return;
  //   }
  //   return extraInfo.split("\r\n").map((text, idx) => {
  //     return <p key={idx}>{text}</p>;
  //   });
  // };

  const formatCurrency = (amount) => {
    const formatter = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    });

    return formatter.format(amount);
  }

  const formatPrice = (item) => {
    return `Price: ${item.purchase_price}
    Tax: ${item.tax_amount}
    Total: ${item.total_price}`;
  };

  // {items.map((item, idx) => {
  //   return (
  //     <tr key={item.id}>
  //       <th>{idx + 1}</th>
  //       <td>{item.brand}</td>
  //       <td>{item.type}</td>
  //       <td>{item.size}</td>
  //       <td>{item.colors}</td>
  //       <td>{item.tag_number}</td>
  //       <td>${formatPrice(item)}</td>
  //       <th>${item.shipping_cost}</th>
  //       <th>${item.pending ? 'PENDING' : item.sold_price}</th>
  //       <th>${item.profit}</th>
  //       <td>{formatText(item.extra_info)}</td>
  //       {allowImages &&
  //       <td>
  //         {item.picture && <img height="150px" src={`https://d2hcaqfu7kwyzt.cloudfront.net/${item.picture}`} />}
  //       </td>}
  //     </tr>
  //   );
  // })}

  return (
    // <div>Hello World</div>
    <main>
      <table className="table">
        <thead>
          <tr>
            <th>Month</th>
            <th colSpan="1">Nastya</th>
            <th colSpan="1">Jenia</th>
            <th colSpan="1">Alla</th>
            <th colSpan="1">Nastya/Alla</th>
          </tr>
          <tr>
            <th></th>
            <th>Profit</th>
            <th>Profit</th>
            <th>Profit</th>
            <th>Profit</th>
          </tr>
        </thead>
        <tbody>
          {combinedInfo.map((info) => {
            return (
              <tr>
                <td>{info.date}</td>
                <td style={{ color: "green", textAlign: 'right' }}>{formatCurrency(info.nastya)}</td>
                <td style={{ color: "green", textAlign: 'right'}}>{formatCurrency(info.jenia)}</td>
                <td style={{ color: "green", textAlign: 'right' }}>0</td>
                <td style={{ color: "green", textAlign: 'right' }}>0</td>
              </tr>
            );
          })}
        </tbody>
        <tfoot>
          <tr>
            <td>Total</td>
            <td>{calculateTotalProfit(nastyaInfo)}</td>
            <td>{calculateTotalProfit(jeniaInfo)}</td>
            <td></td>
            <td></td>
          </tr>
        </tfoot>
      </table>
    </main>
    // <main>
    //   <button onClick={() => setAllowImages(!allowImages)}>Toggle Images</button>
    //   <table>
    //     <thead>
    //       <tr>
    //         <th>#</th>
    //         <th>Brand</th>
    //         <th>Type</th>
    //         <th>Size</th>
    //         <th>Colors</th>
    //         <th>Tag Number</th>
    //         <th>Purchase Price</th>
    //         <th>Shipping Cost</th>
    //         <th>Sold For</th>
    //         <th>Profit</th>
    //         <th>Extra Details</th>
    //         {allowImages && <th>Image</th>}
    //       </tr>
    //     </thead>
    //     <tbody>
    //       {items.map((item, idx) => {
    //         return (
    //           <tr key={item.id}>
    //             <th>{idx + 1}</th>
    //             <td>{item.brand}</td>
    //             <td>{item.type}</td>
    //             <td>{item.size}</td>
    //             <td>{item.colors}</td>
    //             <td>{item.tag_number}</td>
    //             <td>${formatPrice(item)}</td>
    //             <th>${item.shipping_cost}</th>
    //             <th>${item.pending ? 'PENDING' : item.sold_price}</th>
    //             <th>${item.profit}</th>
    //             <td>{formatText(item.extra_info)}</td>
    //             {allowImages &&
    //             <td>
    //               {item.picture && <img height="150px" src={`https://d2hcaqfu7kwyzt.cloudfront.net/${item.picture}`} />}
    //             </td>}
    //           </tr>
    //         );
    //       })}
    //       <tr>
    //         <th>Total:</th>
    //         <td></td>
    //         <td></td>
    //         <td></td>
    //         <td></td>
    //         <td></td>
    //         <td><strong>${sumOfItems}</strong></td>
    //         <td><strong>${shippingCost}</strong></td>
    //         <td><strong>${revenue}</strong></td>
    //         <td><strong>${profit}</strong></td>
    //       </tr>
    //     </tbody>
    //     <tfoot></tfoot>
    //   </table>
    // </main>
  );
};

const domContainer = document.querySelector("#monthly-profit");
ReactDOM.render(e(MonthlyProfit), domContainer);
