-- Practice questions, Start easy (no joins), then get harder - joins!
-- ANSWER file has comments about how & why to do joins specific ways.

USE AdventureWorks2014

/* From the Sales.Store, 
	list all stores with the word "bike" 
	in the Name. Return all columns. */

---------------------------------------------------

/* Using the Sales.Store table, 
	see how many stores each salesPersonID is covering
	that have "bike" in their name.
	Which columns does it make sense to list? */

---------------------------------------------------

/* From [Production].[ProductInventory], List the columns;
	[LocationID]
      ,[Shelf]
      ,[Bin]
      ,[Quantity]
	 for products on Shelf 'R' 
	 that have a Quantity less than 200.
	 Order the list by the Bin column */

---------------------------------------------------

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

---------------------------------------------------

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
			(details what reason each sale had for the purchaes, multiples possible!)
		- don't need any columns returned from this table
		... just linking through

		[Sales].[SalesReason]
			(description of the sales reason is in "name") 
		- Sr.[Name] */

-- How many rows where returned?

---------------------------------------------------

  /* As above, this time return all SalesOrderHeader records
  even if the customer did not give a purchase reason */
  
  -- How many rows where returned?
  -- what do they look like? (what's in "Name")

---------------------------------------------------

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

---------------------------------------------------

