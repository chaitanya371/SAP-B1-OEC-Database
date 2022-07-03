/* query for sales order for OEC database */

Select 
T0.DocDate, 
T0.DocNum, 
(select case when T0.DocStatus = 'O' then 'Open' else 'Close' end) as 'DocStatus', 
T0.CardCode, 
T0.CardName, 
T0.NumAtCard, 
T1.ItemCode, 
T1.Dscription, 
T1.ShipDate, 
T1.Quantity, 
T1.OpenQty, 
T1.PriceBefDi, 
T1.Currency, 
T1.TaxCode, 
T1.OpenQty * T1.PriceBefDi as 'Open Order Value' 
From ORDR T0 

Inner Join RDR1 T1 on T1.DocDate = T0.DocDate 

Where T1.OpenQty * T1.PriceBefDi > 0 
--and T1.ShipDate between '2016-09-14' and '2016-09-21' 
--and T0.DocStatus = 'O' 

Order By T0.CardName 



/* query for sales order with card details and line total */

Select 
T0.CardCode,
T0.CardName,
sum(T1.LineTotal) as 'Line Total'
From ORDR T0

Inner Join RDR1 T1 on T1.DocEntry = T0.DocEntry

Group By 
T0.CardCode,
T0.CardName






