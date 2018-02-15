/* Problem 1.Records’ Count */
USE Gringotts

SELECT		COUNT(Id) AS[Count] 
FROM		WizzardDeposits 

/* Problem 2.Longest Magic Wand */
SELECT * FROM WizzardDeposits

SELECT		MAX(MagicWandSize) AS[Longest Wand] 
FROM		WizzardDeposits

/* Problem 3.Longest Magic Wand per Deposit Groups */
 SELECT		DepositGroup, 
			MAX(MagicWandSize) AS [Longest Wand]
 FROM		WizzardDeposits
 GROUP BY	 DepositGroup 

 /* Problem 4.* Smallest Deposit Group per Magic Wand Size */

 SELECT TOP(2) DepositGroup FROM WizzardDeposits
 GROUP BY	 DepositGroup 
 ORDER BY	AVG(MagicWandSize) 

 /* Problem 5.Deposits Sum */
 SELECT		DepositGroup, 
			SUM(DepositAmount) AS [TotalSum]
FROM		WizzardDeposits
WHERE		(MagicWandCreator = 'Ollivander family')
GROUP BY	DepositGroup

 /* Problem 7.Deposits Filter */
SELECT		DepositGroup, 
			SUM(DepositAmount) AS [TotalSum] 
FROM		WizzardDeposits
WHERE		(MagicWandCreator = 'Ollivander family')
GROUP BY	DepositGroup
HAVING		SUM(DepositAmount) < 150000
ORDER BY	SUM(DepositAmount) DESC

 /* Problem 8. Deposit Charge */
 SELECT	  DepositGroup, 
	      MagicWandCreator,
	      MIN(DepositCharge) AS[MinDepositCHarge]
 FROM	  WizzardDeposits
 GROUP BY DepositGroup, MagicWandCreator
 ORDER BY MagicWandCreator, DepositGroup

 /* Problem 9.Age Groups */
SELECT
	CASE 
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age > 61 THEN '[61+]'
	END AS AgeGroup,
	COUNT(*) AS WizardCount
	FROM WizzardDeposits
GROUP BY
CASE
	WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age > 61 THEN '[61+]'
END
	



/* Problem 9.First Letter */
SELECT LEFT(FirstName,1) AS [FirstLetter] 
FROM  WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstLetter

/* Problem 10.Average Interest  */
SELECT * FROM WizzardDeposits

SELECT DepositGroup ,IsDepositExpired, AVG(DepositInterest) AS[AverageInterest] 
FROM  WizzardDeposits
WHERE DATEPART(YEAR, DepositStartDate) >= 1985 AND DATEPART(MONTH, DepositStartDate) >= 01
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

/* Problem 11.* Rich Wizard, Poor Wizard */
SELECT Id, FirstName, Id+1 
FROM   WizzardDeposits 

/* Problem 12.Departments Total Salaries */
USE SoftUni

SELECT DepartmentID, SUM(Salary) AS[TotalSalary] 
FROM   Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

/* Problem 13.Employees Minimum Salaries */

SELECT DepartmentID , MIN(Salary) [MinimumSalary] 
FROM  Employees
WHERE DATEPART(YEAR, HireDate) >= 2000 AND DATEPART(MONTH, HireDate) >= 01
GROUP BY DepartmentID
HAVING DepartmentID IN(2, 5, 7)

/* Problem 14.Employees Average Salaries */
SELECT DepartmentID,ManagerID ,Salary 
INTO  EmployeeAvgSalaries
FROM  Employees
WHERE Salary >= 30000

DELETE FROM EmployeeAvgSalaries 
WHERE ManagerID = 42

UPDATE EmployeeAvgSalaries
SET    Salary += 5000
WHERE  DepartmentID = 1


SELECT DepartmentId, AVG(Salary) AS [AverageSalary]
FROM   EmployeeAvgSalaries
GROUP BY DepartmentID

/* Problem 15.Employees Maximum Salaries */
SELECT DepartmentID, MAX(Salary) 
FROM   Employees
GROUP BY DepartmentID
HAVING NOT MAX(Salary) BETWEEN 30000 AND 70000

/* Problem 16.Employees Count Salaries */
SELECT COUNT(Salary) AS [Count]
FROM  Employees
WHERE ManagerID IS NULL





















 
