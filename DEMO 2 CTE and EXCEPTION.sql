/* Note there are 9 Employees in TSQL's Employees table
    and 19972 records in AdventureWorks2014 */

/* Let's examine both for a common person 
	- Don Funk is in both DB tables */
/* 2 records here */
SELECT [BusinessEntityID]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
  FROM [AdventureWorks2014].[Person].[Person]
  WHERE firstname = 'don' AND lastname = 'funk';

/* 1 record here */
SELECT [FirstName]
      ,[LastName]
  FROM TSQL2012.[HR].[Employees]
  WHERE firstname = 'don' AND lastname = 'funk';

----------------------------------------------------------
/* DISTINCT: In TSQL and not in AdventureWorks - 5 records */
SELECT [lastname]
    ,[firstname]
  FROM TSQL2012.[HR].[Employees]
EXCEPT
SELECT [LastName]
	,[FirstName]
  FROM [AdventureWorks2014].[Person].[Person];

/* find distinct with NOT IN - 5 records */
SELECT firstname
	, lastname
	FROM TSQL2012.[HR].[Employees] AS e
	WHERE firstname + lastname NOT IN (
			SELECT firstname + lastname 
				FROM [AdventureWorks2014].[Person].[Person]);

/* Complete Distinct list of BOTH tables using UNION */
SELECT [lastname]
    ,[firstname]
  FROM TSQL2012.[HR].[Employees]
UNION
SELECT [LastName]
	,[FirstName]
  FROM [AdventureWorks2014].[Person].[Person];
  
----------------------------------------------------------
/* DUPLICATES in TSQL and in and adventureWorks - 4 records */
SELECT [lastname]
    ,[firstname]
  FROM TSQL2012.[HR].[Employees]
INTERSECT
SELECT [LastName]
	,[FirstName]
  FROM [AdventureWorks2014].[Person].[Person];

/* Find the duplicates with an INNER JOIN and DISTINCT - 4 records */
SELECT DISTINCT e.[FirstName]
      ,e.[LastName]
  FROM TSQL2012.[HR].[Employees] AS e
	INNER JOIN [AdventureWorks2014].[Person].[Person] AS p 
		ON p.FirstName = e.firstname 
			AND p.LastName = e.lastname;

/* find duplicates with IN - 4 records */
SELECT firstname
	, lastname
	FROM TSQL2012_Jones.[HR].[Employees] AS e
	WHERE firstname + lastname IN (
			SELECT firstname + lastname 
				FROM [AdventureWorks2014].[Person].[Person]);

/* find duplicates with GROUP BY and HAVING (same table) 
  how could we do 2 or more tables? */
SELECT firstname, lastname, COUNT(*) AS recCount
	FROM [AdventureWorks2014].[Person].[Person]
	GROUP BY firstname, lastname
	HAVING COUNT(*) > 1;

 /* ----------------------------------------------------------------------
 find the 3 most recently modified people per lastName grouping
   uses function ROW_NUMBER and PARTITION argument and OVER clause. 
   Then, use the scalar function added into the 
   adventureWorks DB: ufnLeadingZeros to pad the rowNumber with 0s */
 WITH cte AS
  ( SELECT BusinessEntityID
		,lastname
		,FirstName
		,modifiedDate,
        ROW_NUMBER() OVER (PARTITION BY lastname
                           ORDER BY lastname, modifiedDate ) AS rowNumber
    FROM [AdventureWorks2014].[Person].[Person]
  )
SELECT BusinessEntityID, lastname, FirstName, modifiedDate
	, dbo.ufnLeadingZeros(rowNumber)
FROM (SELECT BusinessEntityID
		,lastname
		,FirstName
		,modifiedDate,
        ROW_NUMBER() OVER (PARTITION BY lastname
                           ORDER BY lastname, modifiedDate ) AS rowNumber
    FROM [AdventureWorks2014].[Person].[Person]
WHERE rowNumber <= 3
ORDER BY LastName, modifiedDate, rowNumber;

