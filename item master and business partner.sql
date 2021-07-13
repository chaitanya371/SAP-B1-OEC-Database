/* query for linking item master and business partner and displaying the fields */

Select 
T0.ItemCode,
T0.ItemName,
isnull(T0.CardCode,0) as 'CardCode',
T0.DocEntry as 'Document Entry',
(select case when T0.PrchseItem = 'Y' then 'Yes' else 'No' end) as 'Purchase Item',
(select case when T0.SellItem = 'Y' then 'Yes' else 'No' end) as 'Sell Item',
(select case when T0.PrcrmntMtd = 'M' then 'Make' else 'Buy' end) as 'Procurement Method',
T1.CardName,
T1.Address,
T1.ZipCode,
T1.MailAddres,
T1.Phone1 as 'Contact Number',
T1.CntctPrsn as 'Contact Person',
sum(T1.Balance) as 'Balance',
T1.E_Mai	l
From OITM T0
Left Join OCRD T1 on T1.CardCode = T0.CardCode
Group By
T0.ItemCode,
T0.ItemName,
T0.CardCode,
T0.DocEntry,
T0.PrchseItem,
T0.SellItem, 
T0.PrcrmntMtd,
T1.CardName,
T1.Address,
T1.ZipCode,
T1.MailAddres,
T1.Phone1,
T1.CntctPrsn,
T1.E_Mail
Order By T0.DocEntry
