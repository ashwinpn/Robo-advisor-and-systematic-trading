# Robo-advisor-and-systematic-trading
Basis, execution, and evaluation of execution strategies used in financial markets, and exploring the use of AI in driving decision making.

In preparation for the Robo advisors and systematic trading course [taught by Prof. Vasant Dhar] at the NYU Stern School of Business.

## Dependencies
Run 
```bash
pip install -r requirements.txt
```

## Portfolio Optimization
- Creating a portfolio with 3 assets from a list of 6 assets [Use of standard tickers used on the NYSE for representing assets].
```python
from roboadvisor.optimizer import PortfolioOptimizer

assets=['TSLA','SPY','GDX','AAPL','FXI','GLD']
optimal_portfolio=PortfolioOptimizer(assets, portfolio_size=5,max_pos=1.0, min_pos=0.0)
```

## Detetcting High Frequency Traders
A kdb+ system can capture and
analyse live data to efficiently track these traders using a handful of common metrics. The metrics serve
two purposes. Firstly, the goal is to identify potential high frequency traders. The aim is then to
determine whether any of the identified traders are negatively impacting the market.

- Order to trade ratio (OTR)

   The order to trade ratio metric calculates the total number of order
  messages divided by the number of trades at a broker, client or account level. It identifies
  traders that are amending or cancelling orders at a far higher rate than they are trading. High
  frequency traders are usually identified to have a ratio greater than 15.
  The goal of the
metric can be tweaked and focused by examining the max OTR in 10-minute buckets or scanning
for bursts in OTR throughout the trading day.

```q
// - Realtime order to trade ratio q code. Calculation based on the last x minutes of the market

OrderToTradeRatio:{[x]
update OrderToTrade:OrderCount%TradeCount from
lj[
select OrderCount:count i by brokerID from dxOrder where
time>.z.P-“u”$x;
(select TradeCount:count i by brokerID:buyBrokerID from
dxTrade where time>.z.P-“u”$x) +
(select TradeCount:count i by brokerID:sellBrokerID from
dxTrade where time>.z.P-“u”$x)
]

// - Select the trade count by broker on the buy and sell side from dxTrade and add the keyed tables together.
// - Count the number of orders from the dxOrder table and left join (lj) the trade count table to create a table comprised of brokerID, OrderCount and TradeCount
```
