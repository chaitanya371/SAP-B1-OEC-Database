/* query for item master with purchase and sales quantity */

Select 
T0.ItemCode, 
T0.ItemName, 
isnull(sum(T1.Quantity), 0) as 'P Quantity', 
isnull(sum(T2.Quantity), 0) as 'S Quantity', 
isnull(sum(T1.Quantity), 0) + isnull(sum(T2.Quantity), 0) as 'Sum', 
T3.CardName 
From OITM T0 
Left Join POR1 T1 on T1.ItemCode = T0.ItemCode 
Left Join RDR1 T2 on T2.ItemCode = T0.ItemCode 
Left Join OCRD T3 on T3.CardCode = T0.CardCode 
Group by 
T0.ItemCode, 
T0.ItemName,
T3.CardName
Having (isnull(sum(T1.Quantity), 0) + isnull(sum(T2.Quantity), 0) > 0)
Union all
Select 
Null,
Null,
sum(isnull(sum(T1.Quantity), 0)),
sum(isnull(sum(T2.Quantity), 0)),
Null,
Null
From OITM T0 
Left Join POR1 T1 on T1.ItemCode = T0.ItemCode 
Left Join OCRD T3 on T3.CardCode = T0.CardCode 
Left Join RDR1 T2 on T2.ItemCode = T0.ItemCode 
Group by 
T0.ItemCode, 
T0.ItemName,
T3.CardName
Having (isnull(sum(T1.Quantity), 0) + isnull(sum(T2.Quantity), 0) > 0)
