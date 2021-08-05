/* query for product vendor delivery */

	Select 
	T0.DocNum AS 'PO No.', 
	T0.DocDate AS 'PO Date',
	T0.DocStatus AS 'PO Status', 
	T0.CardCode, 
	T0.CardName, 
	T1.ItemCode, 
	T1.Dscription,
	T1.LineNum AS 'Line Num',
	T1.LineStatus AS 'Line Status', 
	T1.Quantity AS 'PO Qty', 
	T1.UomCode, 
	T1.ShipDate AS 'Del Date',
	Max(T3.DocNum) AS 'GRN No.', 
	Max(T3.DocDate) AS 'GRN Date',
	Sum(T2.Quantity) - ISNULL(SUM(T4.Quantity),0) as 'GRN Qty.',
	(Select Case when (Max(T3.DocDate) <= T1.ShipDate) and ((Sum(T2.Quantity) - ISNULL(SUM(T4.Quantity),0) ) >= T1.Quantity) then 1 else 0 end) as 'Achieved Lines'

	From OPOR T0
	Inner Join POR1 T1 on T1.DocEntry = T0.DocEntry
	Left Join PDN1 T2 on T2.BaseRef = T0.DocNum AND T2.BaseEntry = T1.DocEntry and T2.BaseLine = T1.LineNum and T2.ItemCode = T1.ItemCode
	Left Join OPDN T3 on T3.DocEntry = T2.DocEntry 
	Left Join RPD1 T4 on T4.BaseEntry = T2.DocEntry AND T4.BaseLine = T2.LineNum AND T4.ItemCode = T2.ItemCode

	--Where (T1.[ShipDate] >= '[%0]' AND T1.[ShipDate] <= '[%1]') 

	Group By
	T0.DocNum,
	T0.DocDate, 
	T0.CardCode, 
	T0.CardName,
	T1.ItemCode, 
	T1.Dscription, 
	T1.LineNum, 
	T1.LineStatus,
	T1.Quantity, 
	T1.UomCode, 
	T1.ShipDate,
	T0.DocStatus

	Order By
	T0.CardName,
	T1.ItemCode,
	T1.ShipDate
