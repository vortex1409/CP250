/* From the Sales.Store, 
	list all stores with the word "bike" 
	in the Name. Return all columns. */

SELECT [BusinessEntityID]
      ,[Name]
      ,[SalesPersonID]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [Sales].[Store]
  WHERE Name LIKE '%bike%'
  order by Name

/* Using the Sales.Store table, 
	see how many stores each salesPersonID is covering
	that have "bike" in their name.
	Which columns does it make sense to list? */

SELECT [SalesPersonID]
      ,COUNT(*) AS no_of_Stores
  FROM [Sales].[Store]
  WHERE Name LIKE '%bike%'
  GROUP BY [SalesPersonID]
  order by [SalesPersonID];

/* From [Production].[ProductInventory], List the columns;
	[LocationID]
      ,[Shelf]
      ,[Bin]
      ,[Quantity]
	 for products on Shelf 'R' 
	 that have a Quantity less than 200.
	 Order the list by the Bin column */
SELECT [LocationID]
      ,[Shelf]
      ,[Bin]
      ,[Quantity]
  FROM [Production].[ProductInventory]
  WHERE Shelf = 'R' 
	AND Quantity < 200
  ORDER BY Bin

/* List all order header records for orderDate July 1, 2011.
	Order the list by salesOrderId.
	Going to need the following table and columns:
		[Sales].[SalesOrderHeader]
			(the header of the sales record)
		- [SalesOrderID]
		- [OrderDate]
		- [SubTotal]
		- [TaxAmt]
		- [Freight]
		- [TotalDue] */

-- How many rows where returned?

SELECT [SalesOrderId]
		,[OrderDate]
		,[SubTotal]
		,[TaxAmt]
		,[Freight]
		,[TotalDue]
	FROM [Sales].[SalesOrderHeader]
	WHERE OrderDate = '2011-7-1'
	ORDER BY SalesOrderID;

/* List all order header records for orderDate July 1, 2011 
	where the customer gave a reason why they made the purchase.
	(only the ones that have a sales reason). 
	Order the list by salesOrderId.
	Include the description of the sales reason.
	Going to need the following tables:
		[Sales].[SalesOrderHeader]
			(the header of the sales record)
		- [SalesOrderID]
		- [OrderDate]
		- [SubTotal]
		- [TaxAmt]
		- [Freight]
		- [TotalDue]
	  
		[Sales].[SalesOrderHeaderSalesReason] 
			(details what reason each sale had for the purchase, multiples possible!)
		- don't need any columns returned from this table
		... just linking through

		[Sales].[SalesReason]
			(description of the sales reason is in "name") 
		- Sr.[Name] */

-- How many rows where returned?
-- INNER JOIN says only return matching records

SELECT hdr.[SalesOrderID]
		  ,[OrderDate]
		  ,[SubTotal]
		  ,[TaxAmt]
		  ,[Freight]
		  ,[TotalDue]
		  ,Sr.[Name]
	  FROM [Sales].[SalesOrderHeader] as hdr 
		INNER JOIN [Sales].[SalesOrderHeaderSalesReason] as hdrSr 
			ON hdr.SalesOrderID = hdrSr.[SalesOrderID]
		INNER JOIN [Sales].[SalesReason] AS Sr
			ON hdrSr.SalesReasonID = Sr.SalesReasonID
	  WHERE OrderDate = '2011-7-1'
	  ORDER BY SalesOrderID;

  /* As above, this time return all SalesOrderHeader records
  even if the customer did not give a purchase reason */
  
  -- How many rows where returned?
  -- what do they look like? (what's in "Name")
  -- LEFT JOIN says give records where they match or not

  SELECT hdr.SalesOrderID
		  ,[OrderDate]
		  ,[SubTotal]
		  ,[TaxAmt]
		  ,[Freight]
		  ,[TotalDue]
		  ,Sr.[Name]
	  FROM [Sales].[SalesOrderHeader] as hdr 
		LEFT JOIN [Sales].[SalesOrderHeaderSalesReason] as hdrSr 
			ON hdr.SalesOrderID = hdrSr.[SalesOrderID]
		LEFT JOIN [Sales].[SalesReason] AS Sr
			ON hdrSr.SalesReasonID = Sr.SalesReasonID
	  WHERE OrderDate = '2011-7-1'
	  ORDER BY SalesOrderID;

 /* Show the count of how many sales orders on 2011-07-1 
        did not have a sales reason given */
-- Use a LEFT JOIN again but we only need to go to the "bridging" table to know
--      what's not linking up... just link to [SalesOrderHeaderSalesReason] 
--      and check for records with a NULL SalesReasonID (no link!)

  SELECT COUNT(*) AS 'No Sales Reason Given'
	  FROM [Sales].[SalesOrderHeader] as hdr 
		LEFT JOIN [Sales].[SalesOrderHeaderSalesReason] as hdrSr 
			ON hdr.SalesOrderID = hdrSr.[SalesOrderID]
	  WHERE OrderDate = '2011-7-1' 
		AND hdrSr.SalesReasonID IS NULL;

 /* List some basic data needed for a sales receipt.
	See list of tables and columns below.
	Limit the list to only SalesOrderId 43900 
	and order by product.Name
	
	Going to need the following tables:
		[Sales].[SalesOrderHeader]
			(the header of the sales record)
		- [SalesOrderID]
		- [OrderDate]
		- [SubTotal]
		- [TaxAmt]
		- [Freight]
		- [TotalDue]

		[Sales].[SalesOrderDetail]
		- [SalesOrderDetailID]
		- [CarrierTrackingNumber]
		- [OrderQty]
		- [UnitPrice]
		- [UnitPriceDiscount]
		- [LineTotal]

		[Production].[Product]
		- [Name]
		- [ProductNumber]
	*/

-- INNER JOIN would show the exact matches, that's what an invoice is made up of right?
--   Does it make sense that there might be records in a "LEFT JOIN" scenario? 
--   No, what was attached to the invoice is what is to be shown.
--   In fact we don't even what to filter by say [DiscontinuedDate]  or [SellEndDate]
--   because the product was already attached to the invoice - the customer paid for it!
--   Some earlier process should have blocked the discontinued items from being sold.

SELECT hdr.[SalesOrderID]
		,hdr.[OrderDate]
		,hdr.[SubTotal]
		,hdr.[TaxAmt]
		,hdr.[Freight]
		,hdr.[TotalDue]
		,det.[SalesOrderDetailID]
		,det.[CarrierTrackingNumber]
		,det.[OrderQty]
		,det.[UnitPrice]
		,det.[UnitPriceDiscount]
		,det.[LineTotal]
		,p.[Name]
		,p.[ProductNumber]
	FROM [Sales].[SalesOrderHeader] as hdr
	   INNER JOIN [Sales].[SalesOrderDetail] as det 
	      ON det.SalesOrderID = hdr.SalesOrderID
	   INNER JOIN [Production].[Product] as p 
   	      ON p.productID = det.productID
	WHERE hdr.SalesOrderID = 43900
	ORDER BY p.Name;