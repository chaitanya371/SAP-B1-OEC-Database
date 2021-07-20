/* query for item master with invoice on sales and purchase line total */

	Select 
	T0.ItemCode, 
	T0.ItemName, 
	(select case when T0.PrcrmntMtd = 'B' then 'Buy' else 'Make' end) as 'Procurement Method', 
	isnull(sum(T1.LineTotal), 0) as 'Purchase Line Total', 
	isnull(sum(T2.LineTotal), 0) as 'Sales Line Total',
	isnull(sum(T3.LineTotal), 0) as 'Invoice Line Total' 
	From OITM T0
	left join POR1 T1 on T1.ItemCode = T0.ItemCode
	left join RDR1 T2 on T2.ItemCode = T0.ItemCode
	left join INV1 T3 on T3.ItemCode = T0.ItemCode
	Group by 
	T0.ItemCode, 
	T0.ItemName, 
	T0.PrcrmntMtd 



/* query for item master with invoice constraints */

	Select 
	T0.ItemCode, 
	T0.ItemName, 
	T0.CardCode, 
	(select case when T1.InvntSttus = 'O' then 'Open' else 'Closed' end) as 'Warehouse Status',
	(select case when T0.PrcrmntMtd = 'B' then 'Buy' else 'Make' end) as 'Procurement Method',
	isnull(max(T1.Commission),0) as 'Commission Percentage',
	T0.AvgPrice,
	isnull(sum(T1.Quantity),0) as 'Quantity'
	From OITM T0
	Left Join INV1 T1 on T1.ItemCode = T0.ItemCode 
	Where T1.Commission >= 0 
	Group By 
	T0.ItemCode, 
	T0.ItemName, 
	T0.CardCode, 
	T1.InvntSttus,
	T0.PrcrmntMtd,
	T0.AvgPrice



/* query for item master with price for each item */

	Select 
	T0.ItemCode, 
	T0.sum(Price) as 'Price', 
	T0.PriceList
	From ITM1 T0
	Where T0.Price > 0
	Group By T0.ItemCode, T0.PriceList
	Order By T0.ItemCode

