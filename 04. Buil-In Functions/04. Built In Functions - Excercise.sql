/* Part I – Queries for SoftUni Database */

/* Problem 1.Find Names of All Employees by First Name */
USE SoftUni

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LIKE 'Sa%'

/* Problem 2.  Find Names of All employees by Last Name  */
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%'

/* Problem 3.Find First Names of All Employees */
SELECT * FROM Employees

SELECT FirstName,HireDate 
FROM Employees
WHERE DepartmentID IN(3, 10) 

/* Problem 4.Find All Employees Except Engineers */
SELECT FirstName,LastName 
FROM Employees
WHERE NOT (JobTitle  LIKE '%Engineer%')

/* Problem 5.Find Towns with Name Length */
SELECT [Name] FROM Towns
WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
ORDER BY [Name] ASC

/* Problem 6. Find Towns Starting With */
SELECT TownID,[Name] FROM Towns
WHERE	 [Name] LIKE 'M%' OR 
	   	 [Name] LIKE 'K%' OR 
		 [NAME] LIKE 'B%' OR
		 [Name] LIKE 'E%'
ORDER BY [Name] ASC


/* Problem 7. Find Towns Not Starting With */
SELECT TownID,[Name] 
FROM      Towns
WHERE	  [Name] LIKE '[^RBD]%'
ORDER BY  [Name] ASC

/* Problem 8.Create View Employees Hired After 2000 Year */
CREATE VIEW v_HiredAfter2000 AS
SELECT  CONCAT(FirstName, LastName) AS [Hired After 2000] 
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000

/* Problem 9.Length of Last Name */
SELECT FirstName, LastName 
FROM Employees
WHERE LEN(LastName) = 5

/* Part II – Queries for Geography Database  */

/* Problem 10.Countries Holding ‘A’ 3 or More Times */
USE [Geography]

SELECT CountryName,IsoCode 
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode ASC

/* Problem 11. Mix of Peak and River Names */
SELECT PeakName, RiverName, LOWER( CONCAT(PeakName, SUBSTRING(RiverName, 2, LEN(RiverName)-1))) AS [Mix]
FROM   Peaks,Rivers
WHERE  RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix

/* Part III – Queries for Diablo Database */

/* Problem 12.Games from 2011 and 2012 year */
USE Diablo

SELECT [Name], FORMAT([Start], 'yyy-MM-dd') AS[Start] 
FROM Games
WHERE DATEPART(YEAR,[Start]) = 2011 OR DATEPART(YEAR,[Start]) = 2012 
ORDER BY [Start],[Name]

/* Problem 13. User Email Providers */

SELECT Username,SUBSTRING(Email,CHARINDEX('@',Email,1),LEN(Email)) AS[Email Provider]
FROM Users

/* Problem 14. Get Users with IPAdress Like Pattern */
SELECT Username,IpAddress 
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username ASC

/* Problem 15. Show All Games with Duration and Part of the Day */
USE Orders

SELECT ProductName, OrderDate, 
DATEADD(DAY, 3, OrderDate) AS[PayDue],
DATEADD(MONTH, 1, OrderDate) AS [DeliverDue]
FROM Orders

/* Problem 17. People Table */

CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	BIrthday DATETIME NOT NULL
)

INSERT INTO People([Name], Birthday) VALUES
('Victor','2000/12/07 00:00:00.000'),
('Steven','1992/09/10 00:00:00.000'),
('Stephen','1910/09/19 00:00:00.000'),
('John','2010/01/06 00:00:00.000')

SELECT [Name],
CAST(YEAR(GETDATE())-DATEPART(YEAR, BIrthday) AS INT) AS [Age in Years],
CAST(ABS(MONTH(GETDATE()) - DATEPART(MONTH,Birthday)) AS INT) AS [Age in Months],
CAST(ABS(DAY(GETDATE()) - DATEPART(DAY,Birthday)) AS INT) AS [Age In Days],
CAST(DATEPART(MINUTE,GETDATE()) - DATEPART(MINUTE,Birthday) AS BIGINT) AS [Age in Minutes] 
FROM People








