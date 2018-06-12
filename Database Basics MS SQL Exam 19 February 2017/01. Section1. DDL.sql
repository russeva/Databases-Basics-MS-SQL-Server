/* Database Basics MS SQL Exam – 19 Feb 2017 */

/* Section 1. DDL  */
CREATE DATABASE Bakery
USE Bakery

CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(25) UNIQUE,
	Description NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price DECIMAL(12, 5) CHECK(Price >= 0)

)

CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) UNIQUE,

)


CREATE TABLE Distributors(
	Id INT PRIMARY KEY IDENTITY(1,1 ),
	Name NVARCHAR(25) UNIQUE,
	AddressText NVARCHAR(30),
	Summary NVARCHAR(200),
	CountryId INT FOREIGN KEY REFERENCES Countries(Id)

	)

	
CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(30),
	Description NVARCHAR(200),
	OriginCountryId INT FOREIGN KEY  REFERENCES Countries(Id), 
	DistributorId INT  FOREIGN KEY REFERENCES Distributors(Id),
	
)

CREATE TABLE ProductsIngredients(
	ProductId INT FOREIGN KEY REFERENCES Products(Id),
	IngredientId  INT FOREIGN KEY REFERENCES Ingredients(Id),

	CONSTRAINT PK_ProductIdIngredientID PRIMARY KEY(ProductId, IngredientId)
)



CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Gender NVARCHAR(1) CHECK(Gender = 'M' OR Gender = 'F'),
	Age INT,
	PhoneNumber NVARCHAR(10) CHECK (LEN(PhoneNumber) = 10), 
	CountryId INT FOREIGN KEY REFERENCES Countries(Id) NOT NULL

	
)

CREATE TABLE Feedbacks(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Description NVARCHAR(255),
	Rate DECIMAL(10, 2) CHECK (Rate BETWEEN 0 AND 10),
	ProductId INT REFERENCES Products(Id),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id),

	)


