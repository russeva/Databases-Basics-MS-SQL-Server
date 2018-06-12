CREATE VIEW v_UserWithCountries AS
SELECT CONCAT(FirstName,' ',LastName) AS [CustomerName],
	   c.Age,
       c.Gender,
       con.Name AS [CountryName] 
  FROM Customers AS c
 JOIN Countries AS Con
   ON c.Id = Con.Id 

SELECT TOP(5) * FROM v_UserWithCountries
ORDER BY Age