/* Exercises: Triggers and Transactions */
/* Problem 1.Create Table Logs */
USE Bank

CREATE TABLE Logs(
	LogId INT PRIMARY KEY IDENTITY,
	AccountId INT ,
	OldSum DECIMAL(15, 2),
	NewSum DECIMAL(15, 2)
)

GO

CREATE TRIGGER tr_TableLogs ON Accounts FOR UPDATE
AS
BEGIN
	DECLARE @AccId INT = (Select Id FROM inserted) 
	DECLARE @OldBalance  DECIMAL= (Select Balance FROM deleted)
	DECLARE @NewBalance DECIMAL = (Select Balance FROM inserted)

	IF @OldBalance <> @NewBalance
		INSERT INTO Logs(AccountId, OldSum, NewSum) VALUES
		(@AccId, @OldBalance, @NewBalance)
END		
GO

Select * FROM Accounts
UPDATE Accounts
SET Balance += 10
WHERE Id = 1
GO

/* Problem 2.Create Table Emails */
CREATE TABLE NotificationEmails(
	Id INT PRIMARY KEY IDENTITY,
	Recipient INT, 
	[Subject] NVARCHAR(100), 
	Body NVARCHAR(100)
)

GO
CREATE OR ALTER TRIGGER tr_CreateNewEmail ON Logs FOR UPDATE, INSERT
AS
	BEGIN
		DECLARE @recipient INT = (SELECT AccountId FROM inserted)
		DECLARE @subject NVARCHAR(100) = CONCAT('Balanced change for account: ', @recipient)
		DECLARE @oldBalance DECIMAL(12, 5) = (SELECT OldSum FROM deleted)
		DECLARE @newBalance DECIMAL(12, 5) = (SELECT NewSum FROM inserted)
		DECLARE @body NVARCHAR(100) = CONCAT('On ',GETDATE(),' your balance was changed from ',@oldBalance,' to ',@newBalance)

		INSERT INTO NotificationEmails (Recipient, [Subject], Body) 
	    VALUES (@recipient, @subject, @body)
	END
GO

UPDATE Accounts
SET Balance += 10
WHERE Id = 1
GO

SELECT * FROM NotificationEmails
GO

/* Problem 3.Deposit Money */
CREATE OR ALTER PROC usp_DepositMoney (@AccountId INT, @MoneyAmount DECIMAL(12, 4))
AS
BEGIN
  IF(@MoneyAmount >= 0)
  BEGIN
		UPDATE Accounts
		SET Balance +=@MoneyAmount
		WHERE Id = @AccountId
	END
	
END 
GO
		
SELECT * FROM Accounts	

EXEC usp_DepositMoney 1, 10
GO
/* Problem 4.Withdraw Money */
CREATE OR ALTER PROC usp_WithrawMoney (@AccountId INT, @MoneyAmount DECIMAL(12, 4))
AS
BEGIN
  IF(@MoneyAmount >= 0)
  BEGIN
		UPDATE Accounts
		SET Balance -=@MoneyAmount
		WHERE Id = @AccountId
   END
END
	  
GO

/* Test Drive Problem 3. and Problem 4.*/
SELECT * FROM Accounts 
WHERE Id = 1

EXEC usp_DepositMoney 1, 30
EXEC usp_WithrawMoney 1, 60

EXEC usp_WithrawMoney 1, 45

GO

/* Problem 5.Money Transfer */
CREATE PROC usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL (12,4))
AS
BEGIN
	BEGIN TRANSACTION
	
	EXEC usp_WithrawMoney @SenderId,@Amount
	DECLARE @senderBalance DECIMAL(15, 2) = (SELECT Balance FROM  Accounts WHERE Id = @SenderId)
	
	IF(@senderBalance < 0)
	BEGIN
	
	  ROLLBACK
	END 
	
COMMIT
END	
GO

/* TEST Problem. 5 */
SELECT * FROM Accounts 
WHERE Id = 1

SELECT * FROM Accounts
WHERE Id = 2

EXEC usp_TransferMoney 1, 2, 300

/* PART II – Queries for Diablo Database */
/* Problem 6.Trigger */
USE Diablo
GO

CREATE OR ALTER TRIGGER tr_RestrictItemsInserting ON UserGameItems FOR UPDATE, INSERT
AS
BEGIN
	DECLARE @itemMinLevel INT = (SELECT it.MinLevel FROM inserted AS i
								 JOIN Items AS it ON i.ItemId = it.Id)
    DECLARE @userLevel INT = (SELECT ug.Level FROM inserted AS i
							  JOIN UsersGames As ug ON i.UserGameId = ug.Id)

	IF(@userLevel < @itemMinLevel)
	BEGIN
		ROLLBACK
		DECLARE @error NVARCHAR(50) = CONCAT('You must reach level ', @itemMinLevel, ' to buy this item')
		RAISERROR(@error,16,1)
		RETURN
	END
END
	
/* Problem 7.*Massive Shopping */

/* Part III – Queries for SoftUni Database */
/* Problem 8.Employees with Three Projects */
GO
USE SoftUni

GO
CREATE OR ALTER PROCEDURE usp_AssignProject(@emloyeeId INT , @projectID INT)
AS
BEGIN
	SELECT e.FirstName, p.ProjectID FROM EmployeesProjects AS ep
	JOIN Employees AS e ON ep.EmployeeID = e.EmployeeID
	JOIN Projects As p ON ep.ProjectID = p.ProjectID
	ORDER BY e.EmployeeID

	DECLARE @projectsCount INT = (SELECT COUNT(p.ProjectID) FROM EmployeesProjects AS ep
									JOIN Projects AS p ON ep.EmployeeID = p.ProjectID 
									WHERE ep.EmployeeID = 1)

	IF(@projectsCount >= 3)
	  BEGIN
	    ROLLBACK
	    RAISERROR('The employee has too many projects!', 16, 1)
	    RETURN
	END

END	

/* Problem 9.Delete Employees */

CREATE TABLE  Deleted_Employees_SoftUni(
	EmployeeId INT PRIMARY KEY IDENTITY, 
	FirstName NVARCHAR(30), 
	LastName NVARCHAR(30),
	MiddleName NVARCHAR(30),
	JobTitle NVARCHAR(50),
	DepartmentId INT ,
	Salary DECIMAL(15, 2)
) 

GO

CREATE OR ALTER TRIGGER tr_DeletedEmployees ON Employees FOR DELETE
AS
	INSERT INTO Deleted_Employees_SoftUni
	     SELECT  d.FirstName,
				 d.LastName,
				 d.MiddleName,
				 d.JobTitle,
				 d.DepartmentID,
				 d.Salary
		   FROM deleted AS d
	










	


	
	

	