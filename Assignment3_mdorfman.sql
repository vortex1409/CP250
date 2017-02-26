-- Assignment 3 - Michael Dorfman
-- ==============================

-- Database Change
-- ==============================
use mdorfman_aw
-- ==============================

-- Question 1
-- ==============================
select
	BusinessEntityID, 
	Title,
	FirstName,
	MiddleName,
	LastName,
	Suffix,
	JobTitle,
	City,
	StateProvinceName,
	CountryRegionName,
	SalesYTD,
	SalesLastYear
from 
	Sales.vSalesPerson
where 
	SalesYTD < 2000000 
	or 
	SalesLastYear > 2000000
-- ==============================
	
-- Question 2
-- ==============================
select
	Title, 
	FirstName, 
	MiddleName,
	LastName,
	Suffix,
	Name,
	OrderDate,
	Finance_Account_Number,
	SubTotal,
	TaxAmt,
	Freight,
	TotalDue
from 
	vwCustomerOrderSummary
where
	YEAR(OrderDate) = 2013
	and
	TotalDue >= 10000
order by
	LastName,
	FirstName,
	SalesOrderNumber
-- ==============================

-- Question 3
-- ==============================
select 
	Person.Person.Title,
	Person.Person.FirstName,
	Person.Person.MiddleName,
	Person.Person.LastName,
	Person.Person.Suffix,
	Person.PersonPhone.PhoneNumber,
	Person.PhoneNumberType.Name
from
	Person.Person 
		INNER JOIN Person.PersonPhone 
			ON Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID 
		INNER JOIN Person.PhoneNumberType 
			ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID
where 
	Person.Title = 'Mr.' 
	AND 
	Person.PhoneNumberType.Name = 'Work'
order by 
	LastName, 
	FirstName, 
	MiddleName
-- ==============================

-- Database Change
-- ==============================
use TSQL2012
-- ==============================

-- Question 4
-- ==============================
select 
	contactname as 'Contact Name'
from 
	Production.Suppliers
intersect
select 
	LastName + ', '+FirstName AS 'Contact Name'
from 
	mdorfman_aw.Person.Person
-- ==============================

-- Database Change
-- ==============================
use mdorfman_aw
-- ==============================

-- Question 5
-- ==============================
select
	ProductID
from
	Production.WorkOrder
where
	YEAR(StartDate) = 2011
	and
	MONTH(StartDate) =  9

except

select
	ProductID
from
	Production.WorkOrder
where
	YEAR(StartDate) = 2011
	and
	MONTH(StartDate) = 10
	and
	OrderQty > 50
order by
	ProductID
-- ==============================
