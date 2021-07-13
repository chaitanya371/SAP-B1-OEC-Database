/* query for product tree / bill of material */

Select
T0.Code, 
T1.ItemName,
T0.ToWH,
T0.PlAvgSize as 'Planned Avg Production Size',
T2.Code,
T2.ChildNum, 
(Select Case When T2.Code NOT Like 'RE%%' then T3.ItemName else T6.ResName end) as 'Component Description',
T2.Quantity,
T2.Warehouse,
(Select case when T2.IssueMthd = 'B' then 'Backflush' else 'Manual' end) as 'Issue Method',
(Select case when T3.ManBtchNum = 'N' then 'No' else 'Yes' end) as 'Manage Batch No.',
T2.AddQuantit,
T1.InvntryUom,
T0.Qauntity,
T4.CreateDate,
MAX(T4.UpdateDate) AS 'Updated Date' 
From OITT T0  

Inner Join OITM T1 ON T0.Code = T1.ItemCode
Inner Join ITT1 T2 ON T0.Code = T2.Father
Left Outer Join OITM T3 ON T2.Code = T3.ItemCode
Left Outer Join OITM T5 ON T0.Code = T5.ItemCode
Left Outer Join AITT T4 ON T0.Code = T4.Code
Left Outer Join ORSC T6 on T2.Code = T6.VisResCode

Where
T1.ValidFor = 'Y'

Group By
T0.Code, 
T1.ItemName,
T0.ToWH,
T0.PlAvgSize, 
T2.Code, 
T3.ItemName,
T2.Quantity,
T2.Warehouse,
T2.IssueMthd,
T3.ManBtchNum, 
T2.AddQuantit,
T1.InvntryUom,
T4.CreateDate,
T0.Qauntity,
T6.ResName,
T2.ChildNum



/* smaller query for bill of material */

Select 
T0.Code,
T1.ItemName,
T0.ToWH,
T0.PlAvgSize,
T2.Code,
T3.ItemName,
T2.Quantity,
T2.Warehouse,
(select case when T2.IssueMthd = 'B' then 'Backflash' else 'Manual' end) as 'Issue Method',
(select case when T3.PrcrmntMtd = 'B' then 'BUY' else 'MAKE' end) as 'Procurement Method',
T3.MinOrdrQty,
isnull (T2.AddQuantit,1) as 'Add Quantity'
From OITT T0

Inner Join OITM T1 on T1.ItemCode = T0.Code
Inner Join ITT1 T2 on T2.Father = T0.Code
Inner Join OITM T3 on T3.ItemCode = T2.Code
