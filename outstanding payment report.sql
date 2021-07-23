/* query for customer outstanding payment report */


	SELECT 
	T0.DocDate AS 'Invoice Date',
	T0.DocNum AS 'Invoice No.', 
	T0.DocDueDate,
	T0.CardCode, 
	T0.CardName,
	T0.NumAtCard, 
	/*CASE WHEN MAX(T1.ITEMCODE) LIKE 'RC%%' OR MAX(T1.ItemCode) LIKE 'MC%%' THEN
	'Item Invoice' else 'Other Invoices' end AS 'Invoice Type',*/
	T0.DocTotal AS 'Document Total INR',
	T0.DocTotalFC, 
	T0.DocCur,
	T0.PaidToDate 'Paid to Date INR', 
	T0.PaidFC,
	(T0.DocTotal- T0.PaidToDate) AS 'Balance INR',
	(T0.DocTotalFC - T0.PaidFC) AS 'Balance FC'

	FROM OINV T0 
	inner join INV1 T1 ON T0.DOCENTRY = T1.DOCENTRY

	WHERE 
	T0.DocStatus ='O' 
	--and T0.DocDueDate >= '[%0]' and T0.DocDueDate <= '[%1]' 

	GROUP BY
	T0.DocDate, T0.DocNum, T0.DocDueDate,
	T0.CardCode, T0.CardName,
	T0.NumAtCard, 
	T0.DocTotal,
	T0.DocTotalFC, 
	T0.DocCur,
	T0.PaidToDate,
	T0.PaidFC,
	(T0.DocTotal- T0.PaidToDate),
	(T0.DocTotalFC - T0.PaidFC)

	ORDER BY
	T0.DocDueDate
	


