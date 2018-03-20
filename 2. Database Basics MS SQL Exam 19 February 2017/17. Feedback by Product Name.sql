CREATE OR ALTER FUNCTION udf_FeedbackByProductName(@productName NVARCHAR(50))
RETURNS NVARCHAR(20)
	BEGIN
		DECLARE @rating DECIMAL(12, 2);
		DECLARE @status NVARCHAR(20);
		
		SET @rating = (SELECT AVG(f.Rate) FROM Feedbacks AS f
					     JOIN Products AS p ON f.ProductId = p.Id
					    WHERE p.Name = @productName)
					   
					   IF(@rating < 5)
						 SET @status = 'Bad'
						 
					 
					  IF(@rating BETWEEN 5 AND 8)
					    SET @status = 'Average'
					   

					  IF(@rating > 8)
					    SET @status = 'Good'
						

						IF(@rating IS NULL)
						 SET @status = 'No rating'
						
		 RETURN @status		
	END

GO

SELECT TOP 5 Id,Name, dbo.udf_FeedbackByProductName(Name) AS [RatingStatus]
FROM Products
ORDER BY Id
