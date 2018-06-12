 /* Database Basics MS SQL Exam – 22 Oct 2017 */

/* Section 1. DDL */
CREATE DATABASE ReportService
USE ReportService

CREATE TABLE Users(
	      Id INT IDENTITY NOT NULL,
	Username NVARCHAR(30) UNIQUE NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	    Name NVARCHAR(50), 
	  Gender NVARCHAR(1), 
   BirthDate DATETIME,
	     Age INT,
	   Email NVARCHAR(50) NOT NULL,

	   CONSTRAINT PK_Users PRIMARY KEY(Id),
	   CONSTRAINT CHK_Gender CHECK (Gender IN ('M', 'F'))

)
CREATE TABLE Departments(
		Id INT IDENTITY NOT NULL,
	  Name NVARCHAR(50) NOT NULL

	  CONSTRAINT PK_Departments PRIMARY KEY(Id)
)

CREATE TABLE Employees(
		Id INT IDENTITY NOT NULL,
 FirstName NVARCHAR(25),
  LastName NVARCHAR(25),
	Gender NVARCHAR(1),
 BirthDate DATETIME,
	   Age INT,
 DepartmentId INT NOT NULL,

  CONSTRAINT PK_Employees PRIMARY KEY(Id),
  CONSTRAINT CHK_EmployeeGender CHECK (Gender IN('M','F')),
  CONSTRAINT FK_Employees_Depatments FOREIGN KEY (DepartmentId) REFERENCES Employees(Id)

)

CREATE TABLE Categories(
		Id INT IDENTITY NOT NULL,
      Name NVARCHAR(50),
DepartmentId INT NOT NULL,

CONSTRAINT PK_Categories PRIMARY KEY(Id),
CONSTRAINT FK_Categories_Departments FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)
	
)

CREATE TABLE Status(
		Id INT IDENTITY NOT NULL,
		Label NVARCHAR(30) NOT NULL,

		CONSTRAINT PK_Status PRIMARY KEY(Id)
)

CREATE TABLE Reports(
		Id INT IDENTITY NOT NULL,
CategoryId INT NOT NULL,
  StatusId INT NOT NULL,   
  OpenDate DATETIME NOT NULL,
 CloseDate DATETIME,
Description NVARCHAR(200), 
    UserId INT NOT NULL,
EmployeeId INT ,

CONSTRAINT PK_Reports PRIMARY KEY(Id),
CONSTRAINT FK_Reports_Categories FOREIGN KEY(CategoryId) REFERENCES Categories(Id),
CONSTRAINT FK_Reports_Status FOREIGN KEY(StatusId) REFERENCES Status(Id),
CONSTRAINT FK_Reports_Users FOREIGN KEY(UserId) REFERENCES Users(Id),
CONSTRAINT FK_Reports_Employees FOREIGN KEY(EmployeeId) REFERENCES Employees(Id),
)


/* 2.Insert */

INSERT INTO Employees(FirstName, LastName, Gender,BirthDate, DepartmentId) VALUES
('Marlo','O’Malley', 'M','9/21/1958',1),
('Niki','Stanaghan','F','11/26/1969', 4),
('Ayrton', 'Senna','M','03/21/1960' , 9),
('Ronnie', 'Peterson',	'M', '02/14/1944', 9),
('Giovanna', 'Amati', 'F', '07/20/1959',5)

SELECT * FROM Departments

INSERT INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, Description, UserId, EmployeeId) VALUES
(5, 1,'04/13/2017', NULL, 'Stuck Road on Str.133',6, 2),
(6, 3, '09/05/2015','12/06/2015','Charity trail running', 3, 5),
(14, 2,'09/07/2015',NULL, 'Falling bricks on Str.58', 5, 2),
(4,	3,'07/03/2017','07/06/2017','Cut off streetlight on Str.11',	1, 1)

/* 3.Update */
UPDATE Reports
   SET StatusId = 2
 WHERE CategoryId = 4 AND StatusId = 1

 /* 4.Delete */
DELETE FROM Reports
 WHERE StatusId = 4


 /* Section 3. Querying */

 /* 5.Users by Age */
 SELECT Username,Age FROM Users
 ORDER BY Age ASC, Username DESC

 /* 6.Unassigned Reports */
 SELECT Description, OpenDate FROM Reports
 WHERE EmployeeId IS NULL
 ORDER BY OpenDate ASC, Description DESC

 /* 7.Employees & Reports */
 SELECT e.FirstName,
	    e.LastName, 
		r.Description, 
		FORMAT(r.OpenDate, 'yyyy-MM-dd') AS OpenDate 
   FROM Reports AS r 
   JOIN Employees AS e 
     ON r.EmployeeId = e.Id
	 ORDER BY EmployeeId ASC, OpenDate ASC, r.Id ASC
 
 /* 8.Most reported Category */
 SELECT c.Name, 
        COUNT(*) AS [RaportNumbers] 
   FROM Categories AS c
   JOIN Reports AS r
     ON c.Id = r.CategoryId
GROUP BY c.Name 
ORDER BY RaportNumbers DESC

/* 9.Employees in Category */
SELECT c.Name, 
 COUNT(r.EmployeeId) AS EmployeesNumber
  FROM Categories AS c
JOIN Reports AS r ON c.Id = r.CategoryId
LEFT JOIN Employees AS e ON r.EmployeeId = c.Id
GROUP BY c.Name
ORDER BY c.Name ASC

/* 10.Users per Employee  */

SELECT CONCAT(FirstName,' ',LastName) AS [Name], 
       COUNT(r.UserId) AS UsersCount
	   FROM Reports AS r
 JOIN Employees AS e ON r.EmployeeId = e.Id
GROUP BY CONCAT(FirstName,' ',LastName)
ORDER BY UsersCount DESC, Name ASC


/* 11.Emergency Patrol */
SELECT r.OpenDate,
       r.Description, 
	   u.Email AS [ReportersEmail]
  FROM Reports AS r
   JOIN Users AS u ON r.UserId = u.Id
   JOIN Categories AS c ON c.Id = r.CategoryId
   JOIN Departments AS d ON c.DepartmentId = d.Id
 WHERE r.CloseDate IS NULL
   AND DATALENGTH(r.Description) > 20 
   AND Description LIKE '%str%'
   AND d.ID IN (1,4,5)
   ORDER BY OpenDate ASC, Email ASC, r.Id ASC

/* 12.Birthday Report */
SELECT r.OpenDate,u.BirthDate,c.Name FROM Categories AS c
FULL OUTER JOIN  Reports AS r ON c.Id = r.CategoryId
JOIN Users AS u ON r.UserId = u.Id
WHERE DAY(r.OpenDate) = DAY(u.BirthDate)
AND MONTH(r.OpenDate) = MONTH(u.BirthDate)
ORDER BY C.Name

/* 13.Numbers Coincidence */
SELECT Username
 FROM Users AS u
 JOIN Reports AS r ON u.Id = r.UserId
 JOIN Categories As c ON r.UserId = c.Id
WHERE (Username LIKE '[0-9]_%' AND CAST(c.Id AS VARCHAR) = LEFT(Username,1)) OR
      (Username LIKE '[0-9]_%' AND CASt(c.Id AS VARCHAR) = RIGHT(Username, 1))
ORDER BY Username ASC

/* 14.Open/Closed Statistics */
SELECT e.FirstName + ' '+ LastName AS [Name],
       r.OpenDate,
	   r.CloseDate,
	   ISNULL(SUM(r.OpenDate),0 ),
	   ISNULL(SUM(r.CloseDate), 0)
  FROM Employees AS e
  JOIN Reports AS r
    ON e.Id = r.Id
 WHERE DATEPART(YEAR,r.OpenDate) = 2016 OR DATEPART(YEAR, r.CloseDate) = 2016
 GROUP BY  e.FirstName + ' '+ LastName 
 
 /* author solution */
 --Task 14 - Count open and closed reports per employee in the last month

SELECT E.Firstname+' '+E.Lastname AS FullName, 
	   ISNULL(CONVERT(varchar, CC.ReportSum), '0') + '/' +        
       ISNULL(CONVERT(varchar, OC.ReportSum), '0') AS [Stats]
FROM Employees AS E
JOIN (SELECT EmployeeId,  COUNT(1) AS ReportSum
	  FROM Reports R
	  WHERE  YEAR(OpenDate) = 2016
	  GROUP BY EmployeeId) AS OC ON OC.Employeeid = E.Id
LEFT JOIN (SELECT EmployeeId,  COUNT(1) AS ReportSum
	       FROM Reports R
	       WHERE  YEAR(CloseDate) = 2016
	       GROUP BY EmployeeId) AS CC ON CC.Employeeid = E.Id
ORDER BY FullName


 /* Section 4. Programmability */
/* 17.Employee’s Load */
SELECT * FROM Reports
GO

CREATE OR ALTER FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT
  BEGIN
	 DECLARE @sum INT;
		 SET @sum = (SELECT COUNT(*) AS [ReportsCount]
					   FROM Reports AS r
					   JOIN Employees AS e ON r.EmployeeId = e.Id
				   WHERE e.Id = @employeeId AND r.StatusId = @statusId
				   GROUP BY e.FirstName
				   );
    RETURN @sum

  END
  GO

SELECT Id,FirstName,LastName,ISNULL(dbo.udf_GetReportsCount(Id,2),0) AS ReportsCount FROM Employees
GO
  
  /* 18.Assign Employee */
  CREATE OR ALTER PROCEDURE usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
  AS
	BEGIN TRANSACTION
		DECLARE @categoryId INT= (
								 SELECT Categoryid
								 FROM Reports
								 WHERE Id = @reportId);
		
		DECLARE @employeeDepId INT= (
									SELECT Departmentid
									FROM Employees
									WHERE Id = @employeeId);

		DECLARE @categoryDepId INT= (
									SELECT Departmentid
									FROM Categories
									WHERE Id = @categoryId);									  

		UPDATE Reports
		SET EmployeeId = @employeeId
		WHERE Id = @reportId

		IF @employeeId IS NULL AND @categoryDepId <> @employeeDepId
		BEGIN 
			ROLLBACK;
			THROW 50013,'Employee doesn''t belong to the appropriate department!', 1;
		END
		COMMIT
	END
 
  GO
  
  /* 19.Close Reports */
 

  GO

  CREATE OR ALTER TRIGGER tr_CloseReport ON Reports FOR UPDATE
  AS
  DECLARE @newBalance DATETIME = (SELECT CloseDate FROM inserted)
	
	UPDATE Reports
	SET StatusId = 3
	WHERE CloseDate = @newBalance

 SELECT * FROM Reports
  WHERE Id = 3

  UPDATE Reports
  SET CloseDate = GETDATE()
  WHERE Id = 3

  SELECT * FROM Status

  /* 20.Categories Revision */
  SELECT  c.Name ,
  COUNT(r.StatusId) AS [ReportNumber],
   s.Label AS [MainStatus]
  FROM Categories AS c
  JOIN Reports AS r ON r.CategoryId = c.Id
  JOIN Status AS s ON s.Id = r.StatusId 
  WHERE StatusId IN(1,2)
  GROUP BY c.Name, s.Label
  
  
  


  SELECT * FROM Status

 