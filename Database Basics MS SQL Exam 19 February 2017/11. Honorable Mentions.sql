SELECT f.ProductId,
       CONCAT(c.FirstName,' ',c.LastName) AS [CustomerName],
	   ISNULL(f.Description,'') AS [Description]
  FROM 
		(SELECT CustomerId 
		  FROM Feedbacks
	  GROUP BY CustomerId
		HAVING COUNT(Description) >= 3
	)AS SortedFeedbacks
  JOIN Customers As c 
    ON SortedFeedbacks.CustomerId = c.Id
  JOIN Feedbacks AS f
    ON c.Id = f.CustomerId
	ORDER BY ProductId ASC, CustomerName ASC , f.Id ASC
	
	 






