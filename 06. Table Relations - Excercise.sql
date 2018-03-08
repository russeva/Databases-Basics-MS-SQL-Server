/* Problem 1.One-To-One Relationship */

USE Demo
CREATE TABLE Passports(
	PassportID INT PRIMARY KEY,
	PassportNumber NVARCHAR(30) NOT NULL UNIQUE,

	CONSTRAINT PK_PassportID 
	DEFAULT(100) 
	)


CREATE TABLE Persons (
	PersonId INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	Salary DECIMAL(10, 2),
	PassportID INT
	
	CONSTRAINT FK_Persons_Passports 
	FOREIGN KEY(PassportId) 
	REFERENCES Passports(PassportId)
	)


INSERT INTO Passports(PassportNumber) VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')

INSERT INTO Persons(FirstName, Salary, PassportID) VALUES
('Roberto','43300.00',102),
('Tom','56100.00',103),
('Yana','60200.00',101)

SELECT * FROM Passports
SELECT * FROM Persons

SELECT PersonId, FirstName,PassportNumber FROM Persons
JOIN Passports ON Passports.PassportID = Persons.PassportID


/* Problem 2.One-To-Many Relationship */
CREATE TABLE Manufacturers(
	ManufacturerId INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	EstablishedON DATE
	)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	ManufacturerID INT
	
	CONSTRAINT FK_Models_Manufacturer 
	FOREIGN KEY(ManufacturerID) 
	REFERENCES Manufacturers(ManufacturerId)
	)
	

INSERT INTO Manufacturers([Name], EstablishedON) VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')

INSERT INTO Models(ModelID,[Name],ManufacturerID) VALUES
(101,'X1', 1),
(102,'i6', 1),
(103,'Model S', 2),
(104,'Model X', 2),
(105,'Model 3', 2),
(106,'Nova',3)

SELECT * FROM Models
SELECT * FROM Manufacturers

/* Problem 3.Many-To-Many Relationship */
CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Exams(
	ExamID INT PRIMARY KEY,
	[Name] NVARCHAR(50),
)

CREATE TABLE StudentsExam(
	StudentID INT,
	ExamID INT,

	CONSTRAINT PK_StudentsExam 
	PRIMARY KEY(StudentID, ExamID),

	CONSTRAINT FK_StudentsExam_Students
	FOREIGN KEY(StudentID)
	REFERENCES Students(StudentID),

	CONSTRAINT FK_StudentsExam_Exams
	FOREIGN KEY(ExamID)
	REFERENCES Exams(ExamID)
)

INSERT INTO Students([Name]) VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams(ExamID, [Name]) VALUES
('101','Spring MVC'),
('102', 'Neo4j'),
('103', 'Oracle 11g')

INSERT INTO StudentsExam(StudentID,ExamID) VALUES
('1','101'),
('1','102'),
('2','101'),
('3','103'),
('2','102'),
('2','103')

/* Problem 4.Self-Referencing */
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY,
	[Name] NVARCHAR(30) NOT NULL,
	ManagerID INT

	CONSTRAINT FK_Teachers_Teachers
	FOREIGN KEY(ManagerID)
	REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers(TeacherID, [Name], ManagerID) VALUES
('101', 'John', NULL),
('102', 'Maya', 106),
('103', 'Silvia', 106),
('104', 'Ted', 105),
('105', 'Mark', 101),
('106', 'Greta', 101)

SELECT * FROM Teachers

/* Problem 5.Online Store Database */
CREATE DATABASE OnlineStore
USE OnlineStore

CREATE TABLE Cities(
	CityID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	Birthday DATE,
	CityID INT

	CONSTRAINT FK_Customers_Cities
	FOREIGN KEY(CityID) 
	REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY,
	CustomerID INT

	CONSTRAINT FK_Orders_Customers
	FOREIGN KEY(CustomerID)
	REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes(
	ItemTypeID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	ItemTypeID INT

	CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY(ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
	OrderID INT,
	ItemID INT

	CONSTRAINT PK_OrderItems
	PRIMARY KEY(OrderID, ItemID)

	CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY(OrderID)
	REFERENCES Orders(OrderID),

	CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY(ItemID)
	REFERENCES Items(ItemID)
)

/* Problem 5.University Database */
CREATE DATABASE University
USE University

CREATE TABLE Majors(
	MajorID INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
	)

CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY IDENTITY,
	SubjectName NVARCHAR(50) NOT NULL
	)

CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY,
	StudentNumber DECIMAL(10, 2),
	MajorID INT

	CONSTRAINT FK_Students_Major
	FOREIGN KEY(MajorID)
	REFERENCES Majors(MajorID)
	)

CREATE TABLE Payments(
	PaymentID INT PRIMARY KEY IDENTITY,
	PaymentDate DATE,
	PaymentAmoiunt DECIMAL(10, 2),
	StudentID INT

	CONSTRAINT FK_Payments_Students
	FOREIGN KEY(StudentID)
	REFERENCES Students(StudentID)
	)

CREATE TABLE Agenda(
	StudentID INT,
	SubjectID INT,

	CONSTRAINT PK_Agenda
	PRIMARY KEY (StudentID,SubjectID),

	CONSTRAINT FK_Agenda_Students
	FOREIGN KEY(StudentID)
	REFERENCES Students(StudentID),

	CONSTRAINT FK_Agenda_Subjects
	FOREIGN KEY(SubjectID)
	REFERENCES Subjects(SubjectID)
	)
	

/* Problem 6.SoftUni Design */
/*Create an E/R Diagram of the SoftUni Database*/


/* Problem 7.Geography Design */
/* Create an E/R Diagram of the Geography Database. */

/* Problem 8.*Peaks in Rila */
USE Geography

SELECT * FROM Peaks
SELECT * FROM Mountains

SELECT m.MountainRange, p.PeakName, p.Elevation 
FROM Peaks AS p
JOIN Mountains AS m 
ON p.MountainId = m.Id
WHERE MountainRange = 'Rila'
ORDER BY Elevation DESC


