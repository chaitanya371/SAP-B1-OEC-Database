	/* query for item master with sales order */
  
  Select
	T0.ItemCode,
	T0.ItemName,
	T0.CardCode,
	(select CASE when T0.PrcrmntMtd = 'B' then 'Buy' else 'Make' end) as 'Procurement Method',
	--T1.DocEntry,
	T1.Dscription,
	T1.ShipDate,
	sum(T1.price) as 'Price',
	T1.Currency,
	sum(T1.LineTotal) as 'Line Total',
	T2.CardName,
	(select case when T2.DocStatus = 'O' then 'Open' else 'Closed' end) as 'Document Status'
	From OITM T0
  
	Left Join RDR1 T1 on T1.ItemCode = T0.ItemCode
	Left Join ORDR T2 on T2.DocEntry = T1.DocEntry
  
	Where 
	T1.Dscription IS NOT NULL
	OR T1.ShipDate IS NOT NULL
	OR T1.Price IS NOT NULL 
	OR T1.Currency IS NOT NULL 
	OR T1.LineTotal IS NOT NULL 
	OR T2.CardName IS NOT NULL 
  
	Group By 
	T0.ItemCode,
	T0.ItemName,
	T0.CardCode,
	T0.PrcrmntMtd,
	T1.DocEntry,
	T1.Dscription,
	T1.ShipDate,
	T1.Currency,
	T2.CardName,
	T2.DocStatus
  
	Order By
	T0.ItemCode
