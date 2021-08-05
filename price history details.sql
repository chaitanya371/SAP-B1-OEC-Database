/* query for price history details */

	Select 
	T0.itemcode, 
	T2.ItemName, 
	T7.listname, 
	T0.Price AS 'Current Price', 
	T1.Price AS 'Previous Price', 
	T2.UpdateDate

	From OITM T2
	Inner Join ITM1 T0 on T0.Itemcode = T2.itemcode
	Inner join AIT1 T1 on T0.ItemCode = T1.ItemCode and T0.PriceList = T1.pricelist
	Inner join OPLN T7 on T0.PriceList = T7.ListNum

	Where
	T0.Price not in ( T1.price )
	--AND T1.LogInstanc IN (Select Top 1 t9.LogInstanc from AIT1 T9 where t9.ItemCode = T1.ItemCode and T1.PriceList = T9.PriceList order by T9.LogInstanc desc)
	AND T0.PriceList IN (1,2,3,4)
	--AND T2.UpdateDate >= '[%0]' AND T2.UpdateDate <= '[%1]' AND ( T0.ItemCode LIKE 'RC%%' OR T0.ItemCode LIKE 'MC%%' OR T0.ItemCode LIKE 'PF%%')

	Group By
	T0.itemcode,
	T0.pricelist,
	T7.ListName,
	T2.UpdateDate,
	T0.Price,
	T1.Price,
	T2.ItemName

	Order By
	T0.itemcode, 
	T0.PriceList
