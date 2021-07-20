/* query for delivery and a/r invoice for each item */

	Select 
	T0.ItemCode,
	T0.Dscription as 'Item Description',
	sum(T0.Quantity) as 'Quantity', 
	T0.ShipDate, 
	max(T0.Price) as 'Price',
	--T1.LineNum,
	(select case when T2.InvntSttus = 'O' then 'Open' else 'Closed' end) as 'Warehouse Status',
	(select case when T2.DocType = 'I' then 'Item' else 'Service' end) as 'Document Type'
	From INV1 T0
	Left Join DLN1 T1 on T1.DocEntry = T0.BaseEntry 
	Left Join ODLN T2 on T2.DocEntry = T1.DocEntry
	Where T2.DocType = 'I'
	Group By 
	T0.ItemCode,
	T0.Dscription,
	--T0.Quantity, 
	T0.ShipDate, 
	--T0.Price,
	T1.LineNum,
	T2.InvntSttus,
	T2.DocType



/* query for union all for delivery and a/r invoice */

	Select 
	'Delivery' as 'Doc Type',
	T0.DocDate,
	T0.DocNum,
	T0.CardCode,
	T0.CardName,
	T1.ItemCode,
	T1.Dscription,
	T1.Quantity,
	T1.ShipDate,
	T1.Price,
	T1.PriceBefDi
	From ODLN T0
	Inner Join DLN1 T1 on T1.DocEntry = T0.DocEntry
	Where T1.ShipDate = '2021-01-01'
	Union All 
	Select 
	'Invoice', 
	T0.DocDate, 
	T0.DocNum, 
	T0.CardCode,
	T0.CardName,
	T1.ItemCode,
	T1.Dscription,
	T1.Quantity,
	T1.ShipDate,
	T1.Price,
	T1.PriceBefDi
	From OINV T0
	Inner Join INV1 T1 on T1.DocEntry = T0.DocEntry
	Where T1.ShipDate = '2021-01-01'
