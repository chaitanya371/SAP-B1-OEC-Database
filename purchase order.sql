/* query for purchase order for OEC database */

Select 
T0.CardCode,
T0.CardName,
(select case when T0.DocStatus = 'C' then 'Closed' else 'Open' end) as 'DocStatus',
T0.NumAtCard,
T0.DocDate,
T1.ItemCode,
T1.Dscription,
T1.Quantity,
T1.ShipDate,
T1.OpenQty,
T1.PriceBefDi,
T1.Currency,
T1.LineTotal,
T1.OpenQty * T1.PriceBefDi as 'Open Order Value'
From OPOR T0

Inner Join POR1 T1 on T1.DocDate = T0.DocDate

Where T1.OpenQty * T1.PriceBefDi > 0



/* query for purchase order with card details and line total */


Select 
T0.CardCode,
T0.CardName,
sum(T1.LineTotal) as 'Line Total'
From OPOR T0

Inner Join POR1 T1 on T1.DocEntry = T0.DocEntry

Group by 
T0.CardCode,
T0.CardName

