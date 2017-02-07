--       ASSIGNMENT 1 - MICHAEL DORFMAN
-- *******************************************
USE [mdorfman_aw];

-- Questions 1
-- Counts all the columns where the SafetyStockLevel is 500
select COUNT(*) as FlatWash from Production.Product where SafetyStockLevel = 500;

-- Questions 2
-- Lists all the people with the PersonType of "IN"
select PersonType, Title, FirstName, LastName from Person.Person where PersonType in ('IN');

-- Question 3 
--Lists all the AddressID's between 12 and 32
select * from Person.Address where AddressID Between 12 and 32;

-- Question 4
-- Lists all the rows where the city is like "Ottawa"
select * from Person.Address where city like 'Ottawa';

-- Question 5 
-- Lists all the Manufacturing Departments groups by several columns
-- and orders by DepartmentID
select DepartmentID, Name, GroupName from HumanResources.Department where GroupName = 'Manufacturing' group by DepartmentID, Name, GroupName order by DepartmentID

-- Question 6
-- Displays the rows with the max StandardCost between 500 and 1000
select ProductID, Name, ProductNumber, MAX(StandardCost) from Production.Product group by ProductID, Name, ProductNumber having MAX(StandardCost)between 500 and 1000 order by ProductID

-- Question 7
-- Uses a case statement to sort PersonType's into different numbered
-- categories
select BusinessEntityID, Title, PersonType from Person.Person order by case when PersonType = 'SC' then 1 when PersonType = 'EM' then 2 when PersonType = 'GC' then 3 else 4 END

-- Bonus Questions
-- Uses the COALESCE Statement to show/hide null values
select WorkOrderID, ScrapReasonID, COALESCE(WorkOrderID, ScrapReasonID) as VCHAR from Production.WorkOrder
