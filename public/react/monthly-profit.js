const e = React.createElement;
const { useState, useEffect } = React;

const MonthlyProfit = () => {
  const [nastyaInfo, setNastyaInfo] = useState([]);
  const [jeniaInfo, setJeniaInfo] = useState([]);
  const [combinedInfo, setCombinedInfo] = useState([]);

  useEffect(async () => {
    const response = await (
      await fetch('/orders/monthly-profits/data', {
        credentials: 'include',
      })
    ).json();
    const nastyaProfit = extractNastyaData(response);
    const jeniaProfit = extractJeniaData(response);

    setNastyaInfo(nastyaProfit);
    setJeniaInfo(jeniaProfit);

    const combined = combineExtractedData(nastyaProfit, jeniaProfit);
    setCombinedInfo(combined);
  }, []);

  const isInTheFuture = (month, year) => {
    const currentDate = new Date();
    const dataDate = new Date(`${month} ${year}`);
    return dataDate > currentDate;
  };

  const combineExtractedData = (nastya, jenia) => {
    let combined = [];

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
        jenia: jeniaRecord.total_profit,
      });
    });

    return combined;
  };

  const extractNastyaData = (groupData) => {
    return groupData
      .filter((data) => {
        return data.name.split(' ').length === 2;
      })
      .map((filtered) => {
        const [month, year] = filtered.name.split(' ');
        return {
          ...filtered,
          name: 'Nastya',
          month,
          year,
        };
      });
  };

  const extractJeniaData = (groupData) => {
    return groupData
      .filter((data) => {
        return data.name.match(/(jenia)/i);
      })
      .map((filtered) => {
        const [name, month, year] = filtered.name.split(' ');
        return {
          ...filtered,
          name,
          month,
          year,
        };
      });
  };

  const calculateTotalProfit = (personInfo) => {
    const total = personInfo.reduce((sum, info) => {
      return sum + Number(info.total_profit);
    }, 0);

    return formatCurrency(total);
  };

  const formatCurrency = (amount) => {
    const formatter = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    });

    return formatter.format(amount);
  };

  return (
    <main>
      <table className='table'>
        <thead>
          <tr>
            <th>Month</th>
            <th colSpan='1'>Nastya</th>
            <th colSpan='1'>Jenia</th>
            <th colSpan='1'>Alla</th>
            <th colSpan='1'>Nastya/Alla</th>
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
                <td style={{ color: 'green', textAlign: 'right' }}>
                  {formatCurrency(info.nastya)}
                </td>
                <td style={{ color: 'green', textAlign: 'right' }}>
                  {formatCurrency(info.jenia)}
                </td>
                <td style={{ color: 'green', textAlign: 'right' }}>0</td>
                <td style={{ color: 'green', textAlign: 'right' }}>0</td>
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
  );
};

const domContainer = document.querySelector('#monthly-profit');
ReactDOM.render(e(MonthlyProfit), domContainer);
