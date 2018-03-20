CREATE OR ALTER PROCEDURE usp_SendFeedback(@customerId INT, @productId INT, @rate DECIMAL(4,2) ,@description NVARCHAR(255))
AS
	BEGIN TRANSACTION
		  DECLARE @customerFeedbacksCount INT = (SELECT COUNT(Id) AS [FeedbackCounts]
											       FROM Feedbacks
	                                              WHERE CustomerId = @customerId);

		  IF(@customerFeedbacksCount > 3)
		  BEGIN
			ROLLBACK
			RAISERROR('You are limited to only 3 feedbacks per product!',16,1);
		  END
	 
	 INSERT INTO Feedbacks(Id, ProductId, Rate, Description) VALUES
	 (@customerId, @productId, @rate, @description)


	COMMIT
	
	GO
	EXEC usp_SendFeedback 15, 1, 2.00, 'Terrible food';
	                               
	
	