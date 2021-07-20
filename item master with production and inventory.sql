/* query for item master with production to stock */

	Select 
	T0.ItemCode,
	T0.ItemName,
	(select CASE when T0.PrcrmntMtd = 'B' then 'Buy' else 'Make' end) as 'Procurement Method',
	(select CASE when T1.Status = 'L' then 'Closed' else 
		CASE when T1.Status = 'C' then 'Cancelled' else
		CASE when T1.Status = 'P' then 'Planned' else
		CASE when T1.Status = 'R' then 'Released' end end end end) as 'Production Order Status',
	T1.PlannedQty,
	T1.CmpltQty,
	T1.RjctQty,
	T1.PostDate,
	T1.DueDate,
	T1.Warehouse
	--T2.Quantity,
	--T3.Quantity
	From OITM T0
	Left Join OWOR T1 on T1.ItemCode = T0.ItemCode 
	--Left Join IGE1 T2 on T2.ItemCode = T0.ItemCode
	--Left Join IGN1 T3 on T3.ItemCode = T0.ItemCode
	Where T1.RjctQty >= 0
	Order By T1.Warehouse



/* query for item master with production order and inventory */

	Select  
	T0.ItemCode,
	T0.ItemName, 
	isnull(sum(T1.Quantity),0) as 'Sales Order Quantity', 
	isnull(sum(T1.LineTotal),0) as 'Total Value',
	isnull(sum(T2.PlannedQty),0) as 'Open Production Order', 
	isnull(sum(T2.CmpltQty),0) as 'Completed Order', 
	sum(T3.OnHand) as 'Inventory',
	T0.CardCode
	From OITM T0 
	Left Join RDR1 T1 on T1.ItemCode = T0.ItemCode 
	Left Join OWOR T2 on T2.ItemCode = T0.ItemCode 
	Left Join OITW T3 on T3.ItemCode = T0.ItemCode 
	Group by 
	T0.ItemCode, 
	T0.ItemName,
	T0.CardCode 
	Having (isnull(sum(T1.Quantity),0) + isnull(sum(T2.PlannedQty),0) + isnull(sum(T2.CmpltQty),0) + sum(T3.OnHand)) = 0 



/* query for item master with warehouse */

	Select 
	T0.ItemCode,
	T0.ItemName,
	T1.WhsCode,
	T1.Consig,
	T1.AvgPrice,
	T1.StockValue,
	T1.MinStock,
	T1.MaxStock
	From OITM T0
	Inner join OITW T1 on T1.ItemCode = T0.ItemCode
	Where T1.StockValue > 0
	order by T1.AvgPrice desc

