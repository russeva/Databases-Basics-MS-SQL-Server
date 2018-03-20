SELECT  p.Name,
        p.Description, 
		TopTen.AverageRate,
		 TopTen.FeedbackAmount
 FROM
  (SELECT TOP (10) f.ProductId, 
               AVG(f.Rate) AS [AverageRate], 
               COUNT(f.Id) AS [FeedbackAmount] 
	     FROM Feedbacks AS f
     GROUP BY f.ProductId
     ORDER BY AVG(f.Rate) DESC, 
	          COUNT(f.Id) ASC
			   ) AS TopTen
	           JOIN Products AS p ON p.Id = TopTen.ProductId
		   ORDER BY AverageRate DESC, FeedbackAmount ASC
			   