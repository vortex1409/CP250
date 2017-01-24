-- *******************************************
-- ADVENTURE WORKS QUERIES - MICHAEL DORFMAN
-- *******************************************
USE [mdorfman_aw];

/* Question 1 */
SELECT * FROM [Person].[Person] WHERE FirstName = 'Tom';

/* Question 2 */
SELECT COUNT (*) FROM [HumanResources].[Employee] WHERE organizationlevel = 2;

/* Question 3 */
SELECT [AddressID],[AddressLine1],[AddressLine2],[City],[StateProvinceID],[PostalCode],[SpatialLocation],[rowguid],[ModifiedDate] FROM [Person].[Address] WHERE city = 'Gold Bar';

/* Question 4 */
SELECT jobtitle,COUNT (*) FROM [HumanResources].[Employee] GROUP BY jobtitle ORDER BY JobTitle;
 
 /* Question 5 */
 SELECT gender, COUNT(*) FROM  [HumanResources].[Employee] GROUP BY gender;

 /* Question 6 */
SELECT jobtitle ,gender ,COUNT(*) FROM [HumanResources].[Employee]=  WHERE jobtitle LIKE '%manager%'= GROUP BY jobtitle, gender ORDER BY JobTitle;

/* Question 7 */
SELECT * FROM [HumanResources].[Employee] WHERE DAY(BirthDate) = 1;

/* Question 8 */
SELECT [BusinessEntityID],[PhoneNumber],[PhoneNumberTypeID],[ModifiedDate]FROM [Person].[PersonPhone]WHERE PhoneNumber LIKE '212%'ORDER BY PhoneNumberTypeID,PhoneNumber;
	
/* Question 9 */
SELECT [CountryRegionCode],[Name] FROM [Person].[StateProvince] WHERE CountryRegionCode = 'CA' OR [IsOnlyStateProvinceFlag] = 1 OR (CountryRegionCode = 'US' AND [StateProvinceCode] LIKE 'M%') ORDER BY CountryRegionCode, Name;

 /* Question 10 */
 SELECT [AccountNumber],[Name],[PurchasingWebServiceURL]FROM [Purchasing].[Vendor]WHERE preferredvendorstatus = 1 AND  PurchasingWebServiceURL IS NOT NULL AND ActiveFlag = 1;
