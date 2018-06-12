/* Exercises: Functions and Procedures */
/* Part I – Queries for SoftUni Database */
/* Problem 1.Employees with Salary Above 35000 */
USE SoftUni
GO


CREATE PROC usp_GetEmployeesSalaryOver35000
AS
  SELECT FirstName AS [FirstName],
		 LastName  AS [LastName]
	FROM Employees 
   WHERE Salary >= 35000
	
EXEC usp_GetEmployeesSalaryOver35000
GO

/* Problem 2.Employees with Salary Above Number */

CREATE PROC usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4) = 48100)
AS
  SELECT FirstName AS [FirstName],
          LastName AS [LastName] 
    FROM Employees
   WHERE Salary >= @number

EXEC usp_GetEmployeesSalaryAboveNumber

GO

/* Problem 3.Town Names Starting With */
CREATE PROC usp_GetTownsStartingWith(@letter NVARCHAR(1) = 'b')
AS
  SELECT [Name] 
   FROM Towns
  WHERE LEFT([Name],1) = @letter

EXEC usp_GetTownsStartingWith
GO

/* Problem 4.Employees from Town */
CREATE PROC usp_GetEmployeesFromTown(@town NVARCHAR(20) = 'Sofia')
AS
  SELECT FirstName,LastName FROM Employees AS e
  JOIN Addresses AS a ON e.AddressID = a.AddressID
  JOIN Towns AS t ON a.TownID = t.TownID
  WHERE t.Name = @town

EXEC usp_GetEmployeesFromTown
GO

/* Problem 5.Salary Level Function */
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @level NVARCHAR(10);

	IF(@salary < 30000)
	 BEGIN
		SET @level = 'Low'
	 END
	ELSE IF(@salary BETWEEN 30000 AND 50000)
	 BEGIN
		SET @level = 'Average'
	 END
	ELSE IF(@salary > 50000)
	 BEGIN
		SET @level = 'High'
	 END
	
	RETURN @level;
END

GO

   SELECT FirstName,
          LastName,
		  Salary, 
		  dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevels
    FROM Employees
ORDER BY Salary DESC
GO

/* Problem 6.Employees by Salary Level */
CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@LevelOfSalary NVARCHAR(10))
AS
BEGIN
	IF(@LevelOfSalary = 'Low')
		BEGIN
			 SELECT FirstName,
                    LastName,
				    dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevels
			   FROM Employees
			  WHERE dbo.ufn_GetSalaryLevel(Salary) = 'Low'
			  END
	ELSE IF(@LevelOfSalary = 'Average')
		BEGIN
		 SELECT FirstName,
                    LastName,
				    dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevels
			   FROM Employees
			  WHERE dbo.ufn_GetSalaryLevel(Salary) = 'Average'
		END
	ELSE IF(@LevelOfSalary = 'High')
		BEGIN 
		 SELECT FirstName,
                    LastName,
				    dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevels
			   FROM Employees
			   WHERE dbo.ufn_GetSalaryLevel(Salary) = 'High'
		   END
END
  GO

EXEC usp_EmployeesBySalaryLevel 'High'
GO

/* Problem 7.Define Function */
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(50) , @word NVARCHAR(50))
RETURNS BIT
BEGIN
 DECLARE @isComprised BIT = 0;
 DECLARE @currentIndex INT = 1;
 DECLARE @currentChar CHAR;
	
	WHILE(@currentIndex <= LEN(@word))
	BEGIN
		SET @currentChar = SUBSTRING(@word, @currentIndex, 1);
		IF(CHARINDEX(@currentChar, @setOfLetters) = 0)
		
		  RETURN @isComprised;
		  SET @currentIndex +=1;

	END
 RETURN @isComprised +1;

END
GO

/* Problem 8.* Delete Employees and Departments */

/* PART II – Queries for Bank Database */
/* Problem 9.Find Full Name */
USE Bank

SELECT * FROM AccountHolders
SELECT * FROM Accounts
GO

CREATE PROC usp_GetHoldersFullName
AS
	SELECT CONCAT(FirstName, ' ', LastName) AS[Full Name] FROM AccountHolders
GO
  
EXEC usp_GetHoldersFullName

/* Problem 10.People with Balance Higher Than */
GO

CREATE PROC usp_GetHoldersWithBalanceHigherThan(@number DECIMAL(15,2))
AS
	SELECT ac.FirstName, ac.LastName FROM AccountHolders AS ac
	JOIN Accounts AS a ON ac.Id = a.AccountHolderId
  GROUP BY ac.FirstName, ac.LastName
    HAVING SUM(a.Balance) > @number

GO
EXEC usp_GetHoldersWithBalanceHigherThan 20000

/* Problem 11.Future Value Function */
GO
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(15,2), @YearlyInterestRate DECIMAL (15,2), @NumberOfYears INT)
RETURNS MONEY
	AS
	  BEGIN
	   DECLARE @FutureValue INT;

	  SET @FutureValue = @sum * POWER(1 + @YearlyInterestRate, @NumberOfYears);
	  RETURN @FutureValue
      END
	  
	GO

SELECT dbo.ufn_CalculateFutureValue(1000 , 0.1, 5) AS CFV
GO

/* Problem 12.Calculating Interest */
GO
CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount(@id INT, @interestRate DECIMAL (10, 2))
  AS
	BEGIN 
		
    SELECT ah.Id, 
	       ah.FirstName, 
		   ah.LastName, 
		   a.Balance,
	       dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, 5) AS [BalanceIn5Years]        
      FROM AccountHolders AS ah
   	  JOIN Account AS a 
	    ON a.Id = ah.Id 
	 WHERE a.Id = ah.Id
	END
GO

EXEC usp_CalculateFutureValueForAccount 1, 0.1

GO

/* Problem 13.*Scalar Function: Cash in User Games Odd Rows */
USE DIABLO 
GO 

CREATE OR ALTER FUNCTION ufn_CashInUsersGames (@gameTitle NVARCHAR(50))
RETURNS TABLE
AS
BEGIN
	SELECT SUM(Cash) FROM  (
	   SELECT ug.Cash,
	          ROW_Number() OVER(ORDER BY Cash DESC) AS [RowNumb] 
	     FROM UsersGames AS ug
		JOIN Games AS g 
		   ON g.Id = ug.Id
		WHERE g.Name = 'Love in a mist'
		)  As CashAggr
   	WHERE RowNumb % 2 = 0
END


GO
