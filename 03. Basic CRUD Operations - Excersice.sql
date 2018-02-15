/* Part I – Queries for SoftUni Database */
USE SoftUni

/* 2.Find All Information About Departments */
SELECT * FROM Departments

/* 3.Find all Department Names */
SELECT Name 
FROM Departments

/* 4.Find Salary of Each Employee */
SELECT * FROM Employees

SELECT FirstName, LastName, Salary 
FROM Employees

/* 5.Find Full Name of Each Employee */
SELECT FirstName, MiddleName, LastName 
FROM Employees

/* 6.Find Email Address of Each Employee */
SELECT FirstName + '.'+ LastName +'@softuni.bg' AS [Full Email Address] 
FROM Employees

/* 7.Find All Different Employee’s Salaries */
SELECT DISTINCT Salary 
FROM Employees
ORDER BY Salary ASC

/* 8.Find all Information About Employees */
SELECT * FROM Employees 
WHERE JobTitle = 'Sales Representative'

/* 9.Find Names of All Employees by Salary in Range */
SELECT FirstName, LastName, JobTitle 
FROM Employees 
WHERE Salary BETWEEN 20000 AND 30000

SELECT DISTINCT JobTItle FROM Employees

/* 10. Find Names of All Employees  */
SELECT FirstName +' '+ MiddleName + ' '+ LastName AS [Full Name]  
FROM Employees
WHERE Salary IN (25000, 140000, 12500, 23600)

/* 11. Find All Employees Without Manager */
SELECT * FROM Employees
WHERE ManagerID is NULL

/* Find All Employees with Salary More Than 50000 */
SELECT * FROM Employees
WHERE Salary > 50000

/* 13. Find 5 Best Paid Employees. */
SELECT TOP(5)* FROM Employees
ORDER BY Salary DESC

/* 14.Find All Employees Except Marketing */
SELECT * FROM Employees
WHERE NOT(DepartmentID = 4)

/* 15.Sort Employees Table */
SELECT * FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC

/* 16. Create View Employees with Salaries */
CREATE VIEW v_EmployeeSalaries AS
SELECT FirstName, LastName, Salary 
FROM Employees


GO
/* 17.Create View Employees with Job Titles */
CREATE VIEW v_EmployeeNameJobTitle AS
SELECT CONCAT(FirstName ,' ', MiddleName + ' ', LastName) AS [Full Name] 
FROM Employees

SELECT * FROM v_EmployeeNameJobTitle

/* Distinct Job Titles */
SELECT DISTINCT JobTitle 
FROM Employees

/* 19.Find First 10 Started Projects */
SELECT * FROM Projects
ORDER BY StartDate ASC, [Name]

/* 20. Last 7 Hired Employees */
SELECT TOP(7) FirstName, LastName, HireDate 
FROM Employees
ORDER BY HireDate DESC

/* 21.Increase Salaries */
UPDATE Employees
SET Salary *=  1.12
WHERE DepartmentID IN (1, 2, 4, 11)












