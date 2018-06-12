SELECT  d.Name AS [Distributor],
        i.Name AS [IngridientName],
		p.Name AS[ProductName], 
		AverageRate.AverageRate As [AverageRate]  
 FROM 
	    (SELECT f.ProductId, 
		        AVG(f.Rate) AS [AverageRate]  
		   FROM Feedbacks AS f
	   GROUP BY f.ProductId
		 HAVING AVG(f.Rate) BETWEEN 5 AND 8) AS AverageRate
JOIN Ingredients AS i 
  ON i.Id = AverageRate.ProductId
JOIN ProductsIngredients AS [pi] 
  ON i.Id = [pi].IngredientId
JOIN Products As p 
  ON  [pi].ProductId = p.Id
JOIN Distributors AS d 
  ON d.Id = i.DistributorId
ORDER BY d.Name ASC,i.Name ASC, p.Name ASC




