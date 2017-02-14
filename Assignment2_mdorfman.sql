--       Assignment 2 - MICHAEL DORFMAN
-- *******************************************

USE TSQL2012

/*
Question 1
selects customer id and company name from Sales Customers and
orders by company name but offsets the select so that only the first 5 rows are fetched
*/

select custid as 'Customer ID', companyname as 'Company Name' 
from Sales.Customers
order by companyname 
offset 5 rows
fetch next 5 rows only

/*
Question 2
Selects categoryname and description from Production Categories
and filters the results where ee is somewhere in the row entry
*/

select categoryname as 'Category Name',
description as 'Description' 
from Production.Categories
where description like '%ee%'

/*
Question 3
Selects employee ID and their shipment dates (required and shipped)
and see's if it is ontime or not

In the class you didn't give a clear reason why
the required date and shipped date > < sign was backwards
Logically the lab has an error
*/

select empid as 'Employee ID', orderdate as 'Order Date', requireddate as 'Required By', shippeddate as 'Shipped By', 
	case 
		when requireddate >= shippeddate then 'Yes' else 'No'
	  --when requireddate <= shippeddate then 'Yes' else 'No'
	end as 'onTime'
from Sales.Orders
where shippeddate between '2007-08-01' and '2007-08-31'
order by orderdate

/*
Question 4
Selects employee ID
and required and shipped dates and 
shows which employee shipped ontime shipments and
how many late shipments

In the class you didn't give a clear reason why
the required date and shipped date > < sign was backwards
Logically the lab has an error
*/

select empid as 'Employee ID',
	case
		when requireddate >= shippeddate then 'Yes'
		--when requireddate <= shippeddate then 'Yes'
		else 'No'
	end as 'On Time',
COUNT(empid) as '# Shipped'
from Sales.Orders
where shippeddate between '2007-08-01' and '2007-08-31'
group by empid,
	case
		when requireddate >= shippeddate then 'Yes'
		--when requireddate <= shippeddate then 'Yes'
		else 'No'
	end
order by empid
