SELECT CONCAT(c.FirstName ,' ',c.LastName) AS [Name],
	   c.PhoneNumber,
	   c.Gender FROM Customers AS c
LEFT JOIN Feedbacks AS f 
       ON f.CustomerId = c.Id
    WHERE f.Id IS NULL
