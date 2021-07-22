/* query for production order - issue vs receipt */

	Select 
	T0.DocNum, 
	T0.ItemCode, 
	T2.ItemName, 
	T1.ItemCode as 'Child Item',
	T1.ItemName as 'Child Item Name',
	T1.PlannedQty,
	T1.IssuedQty,
	T0.CmpltQty,
	(T1.IssuedQty - T0.CmpltQty) as 'Difference'

	From OWOR T0 
	Inner Join WOR1 T1 on T1.DocEntry = T0.DocEntry 
	Left Join OITM T2 on T2.ItemCode = T0.ItemCode 

	Where 
	--T0.Status = 'R' 
	--and (T1.ItemCode like 'A%%' or T1.ItemCode like 'B%%')
	(T1.IssuedQty - T0.CmpltQty) > 0
