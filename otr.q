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
