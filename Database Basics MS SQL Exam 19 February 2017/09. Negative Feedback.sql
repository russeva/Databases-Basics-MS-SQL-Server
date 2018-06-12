SELECT f.ProductId,
       f.Rate,f.Description, 
	   f.CustomerId, 
	   c.Age,c.Gender 
  FROM Feedbacks AS f
JOIN Customers AS c
   ON c.Id = f.CustomerId
WHERE Rate < 5
ORDER BY ProductId DESC, Rate ASC