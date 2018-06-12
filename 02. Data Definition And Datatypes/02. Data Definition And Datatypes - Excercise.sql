/* CREATE MINIONS DATABASE*/

/* Problem 1.Create Database */
CREATE DATABASE Minions
USE Minions

/* Problem 2.Create Tables */
CREATE TABLE Minions(
	Id INT PRIMARY KEY IDENTITY,
	[Name] nvarchar(50) NOT NULL,
	Age INT NOT NULL,

)

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY,
	[Name] nvarchar(50) NOT NULL,
)

/* Problem 3.Alter Minions Table */
ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns (Id)

/* Problem 4.Insert Records in Both Tables */
INSERT INTO Towns ([Name]) VALUES
('Sofia'),
('Plovdiv'),
('Varna')

GO
ALTER TABLE Minions
ALTER COLUMN Age  
INT NUll

INSERT INTO Minions ([Name], Age, TownId) VALUES
('Kevin', 22, 1),
('Bob', 15, 3),
('Steward', NULL, 2)

/* Problem 5.Truncate Table Minions */
TRUNCATE TABLE Minions

/* Problem 6.Drop All Tables */
DROP TABLE Minions

USE Minions

/* Problem 7.Create Table People */
CREATE TABLE People(
	Id INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(2000),
	Height NUMERIC(5, 2),
	[Weight] NUMERIC(5, 2),
	Gender CHAR(1) CHECK(Gender = 'f' OR Gender = 'm'), 
	Birthday DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthday, Biography) VALUES
('Mimo', NULL, 1.74, 72.00, 'm', '1989-10-31', 'Bla bla blaaaaah....' ),
('Denitsa' , Null, 1.60, 42.00,'f', '1991-08-27',' Todododod lala...'),
('Stew', NULL, 1.42, 34.00, 'm', '2001-06-13','Hohoho-hoe'),
('Peter', NULL, 1.68, 73.50, 'm', '1993-07-04',NULL),
('Carla', NULL, 1.55, 40.00,'f', '2000-10-12','I hate chocolate...')

/* Problem 8.Create Table Users */
CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY NOT NULL,
Username VARCHAR(30) UNIQUE NOT NULL,
Password VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY CHECK (DATALENGTH(Picture) < 900 * 1024),
LastLoginTime DATETIME NOT NULL,
IsDeleted BIT
)

/* Problem 9.Change Primary Key */
ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC0756AEE217]

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id,Username)

/* Problem 10.Add Check Constraint */
ALTER TABLE Users
ADD CONSTRAINT CHK_Password CHECK(DATALENGTH([Password]) >= 5)


INSERT INTO Users (Username, [Password], ProfilePicture, LastLoginTime, isDeleted) VALUES
('holla2', 'qwert', NULL, GETDATE(), 'false'),
('peter_panda', '123456', NULL, GETDATE(),'false' ),
('sk72', 'CantBr3akTh@t', NULL, GETDATE(), 'false'),
('lost_and_found', '2708918779', NULL, GETDATE(),'true'),
('socrat','FREEZERROUT',NULL, GETDATE(),'false')

INSERT INTO Users VALUES
('bambi','123456',NULL, GETDATE(), 'true')

/* Problem 11.Set Default Value of a Field */
ALTER TABLE Users
ADD DEFAULT GETDATE() FOR LastLoginTime

ALTER TABLE Users
DROP CONSTRAINT [PK_Users]

ALTER TABLE Users 
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

/* Problem 12.Set Unique Field */
ALTER TABLE Users 
ADD CONSTRAINT CHK_MinUserameLength CHECK(DATALENGTH(Username) >= 3)

/* Problem 13.Movies Database */


CREATE DATABASE Movies
GO

USE Movies
GO

CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(100) NOT NULL,
	Notes TEXT,
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes TEXT,
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes TEXT,
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYeear SMALLDATETIME NOT NULL,
	[Length] DECIMAL(10, 2) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories (Id) NOT NULL,
	Rating DECIMAL(10, 2),
	Notes TEXT
)

INSERT INTO Directors(DirectorName, Notes) VALUES
	('Steven Spielberg', NULL),
	('Ridley Scott', NUll),
	('James Cameron', NULL),
	('Duncan Jones', NULL),
	('David Cronenberg', NULL)
	
INSERT INTO Genres(GenreName, Notes) VALUES
	('Sci-Fi',NULL),
	('Sci-Comedy',NULL),
	('Sci-Thriller',NULL),
	('Sci-Drama',NULL),
	('Sci-Horror',NULL)

INSERT INTO Categories(CategoryName, Notes) VALUES
	('Animation', NULL),
	('Documentary',NULL),
	('Action Movie', NULL),
	('Musical',NULL),
	('Pistachho-Drama',NULL)

INSERT INTO Movies(Title, DirectorId, CopyrightYeear,[Length], GenreId, CategoryId, Rating, Notes) VALUES
	('Up to Hell', 3, '1993', '90', 4, 2, 8.5, NULL),
	('Scooby Snacks', 1, '2001', '103', 3, 1, 4.6, NULL),
	('Wild Wild East', 4,'1973', '172', 5, 1, 7.3, NULL),
	('Ho-Ho-Hoes',4, '2004', '165', 4, 1,5.9, NULL),
	('Barbarons', 2,'2006', '184', 2, 1, 4.7, NULL)

SELECT * FROM Movies

/* Problem 14.Car Rental Database */

CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName VARCHAR(50) NOT NULL,
	DailyRate DECIMAL(10, 2),
	WeeklyRate DECIMAL(10, 2),
	MonthlyRate DECIMAL(10, 2),
	WeekendRate DECIMAL(10, 2),
)

CREATE TABLE Cars(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber INT NOT NULL,
	Manufacturer VARCHAR(30) NOT NULL,
	Model VARCHAR(30) NOT NULL,
	CarYear INT NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Doors INT NOT NULL,
	Picture VARBINARY(MAX),
	Condition VARCHAR(150),
	Available BIT
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title VARCHAR(20) NOT NULL,
	Notes TEXT
)

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	DriverLiscenceNumber BIGINT UNIQUE NOT NULL,
	FullName NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(150) NOT NULL,
	City VARCHAR(30) NOT NULL,
	ZIPCode INT NOT NULL,
	Notes TEXT
)

CREATE TABLE RentalOrders(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
	CarId INT FOREIGN KEY REFERENCES Cars(Id),
	TankLevel DECIMAL(10,2),
	KilometrageStart DECIMAL(10, 2),
	KilometrageEnd DECIMAL(10, 2),
	TotalKilometrage DECIMAL(10, 2),
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	TotalDays INT,
	RateApplied DECIMAL(10, 2) NOT NULL,
	TaxRate DECIMAL(10, 2),
	OrderStatus VARCHAR(50),
	Notes TEXT
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
	('Economy Cars', '12','60','240', '32'),
	('4x4 Cars', '18','90','360','44'),
	('Automatic Cars', '15','75','300','36'),
	('Luxury Cars', '25', '125', '500','60')

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
	('435698','Ford','Focus','2007', 1,'4', NULL,'good', 0),
	('152804','Lexus','BlaBla','2012', 4,'2', NULL,'perfect', 0),
	('700187','Audi','S6','2008', 3,'2', NULL,'good', 1),
	('520184','Land Rover','Cruiser','2010', 2,'5', NULL,'perfect',1)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
	('Daisy','Gordons','Miss',NULL),
	('Peter','Pan','Mr',NULL),
	('Mimo','Stewart','Mr',Null),
	('Sarah','Parker','Mrs',NULL)

INSERT INTO Customers(DriverLiscenceNumber, FullName, [Address], City, ZIPCode,Notes) VALUES
	(2133494,'Luke Pargeter', '146 Albion Road','London', 9700, NULL),
	(234479,'Sammy Porter', '14 Swanswick Close','London',6400,NULL),
	(34572123,'Marina Pastir','1 Bamborough Garden','London', 9000, NULL)

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, StartDate, EndDate, RateApplied) VALUES
(1, 2, 2, 2017-05-11, 2017-05-16, 16),
(2, 1, 3, 2017-04-09, 2017-04-12, 24)

/* Problem 15.Hotel Database */


CREATE DATABASE Hotel
GO

USE Hotel

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(10) NOT NULL,
	Notes TEXT,
)


CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	AccountNumber INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber BIGINT NOT NULL,
	EmergencyName NVARCHAR(50),
	EmergencyNumber NVARCHAR(50),
	Notes TEXT,
)

CREATE TABLE RoomStatus(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	RoomStatus NVARCHAR(20) NOT NULL,
	Notes TEXT
)

CREATE TABLE RoomTypes(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	RoomType NVARCHAR(20) NOT NULL,
	Notes TEXT
)

CREATE TABLE BedTypes(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	BedType NVARCHAR(20) NOT NULL,
	Notes TEXT
)


CREATE TABLE Rooms(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	RoomNumber INT NOT NULL,
	RoomType INT FOREIGN KEY REFERENCES RoomTypes(Id) NOT NULL ,
	BedType INT FOREIGN KEY REFERENCES BedTypes(Id) NOT NULL,
	Rate DECIMAL(10, 2) NOT NULL,
	RoomStatus INT FOREIGN KEY REFERENCES RoomStatus(Id) NOT NULL,
	Notes TEXT
)

CREATE TABLE Payments(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	PaymentDate INT,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATE,
	LastDateOccupied DATE,
	TotalDays INT NOT NULL,
	AmountCharged DECIMAL(10, 2) NOT NULL,
	TaxRate DECIMAL(10, 2),
	TaxAmount DECIMAL(10, 2),
	PaymentTotal DECIMAL(10, 2) NOT NULL,
	Notes TEXT
)

CREATE TABLE Occupancies(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE,
	AccountNumber INT,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	RateApplied DECIMAL(10, 2),
	PhoneCharge DECIMAL(10, 2),
	Notes TEXT

)

INSERT INTO Employees(FirstName, LastName, Title) VALUES
('Denitsa','Ruseva','Miss'),
('Peter','Peev','Mr'),
('Stewart','Little','Mr')

INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber) VALUES
	('63289032',' Rosalia','Rose','00447593609492'),
	('12068332',' Petra','Rita','00447593607629'),
	('79103284',' Nika','Achikgyozyan','00447593619503')

INSERT INTO	RoomTypes(RoomType) VALUES
('Single'),
('Double'),
('Apartment')

INSERT INTO RoomStatus(RoomStatus) VALUES
('Available'),
('Occupied'),
('Cleaning in progress')

INSERT INTO BedTypes(BedType) VALUES
('Single'),
('Double'),
('King Size')

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus) VALUES
('100', 1, 1, '60.00', 1),
('101', 2, 2, '85.00', 1),
('102', 3, 3, '110.00', 1)

/* Problem 16.Create SoftUni Database */
CREATE DATABASE SOFTUNI
GO
USE SOFTUNI

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	AddressText NVARCHAR(200),
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL 
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate DATE,
	Salary INT CHECK(Salary > 0),
	AddressId INT FOREIGN KEY REFERENCES Addresses (Id),

)

/* Problem 17.Backup Database */
/* Problem 18.Basic Insert */

INSERT INTO Towns([Name]) VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')
	

INSERT INTO Departments([Name]) VALUES	
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4,'2013-02-01',3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
	('Maria', 'Petrova', 'Ivanova',	'Intern', 5, '2016-08-28', 525.25),
	('Georgi', 'Teziev', 'Ivanov', 'CEO', 2,'2007-09-12', 3000),
	('Peter', 'Pan', 'Pan',	'Intern', 3, '2016-08-28', 599.88)
	
	
SELECT [Name] FROM Towns
ORDER BY [Name] DESC

SELECT [Name] FROM Departments
ORDER BY [Name] DESC

SELECT FirstName,LastName,JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees 
SET Salary *= 1.1

SELECT Salary FROM Employees

USE Hotel

UPDATE Payments
SET TaxRate -= 0.03

TRUNCATE TABLE Occupancies

	
	
	