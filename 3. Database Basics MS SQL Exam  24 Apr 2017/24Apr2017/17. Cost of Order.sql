CREATE OR ALTER FUNCTION udf_GetCost(@jobId INT)
RETURNS DECIMAL
  BEGIN 
	 DECLARE @totalCosts DECIMAL(6,2) = (SELECT  SUM(p.Price * pn.Quantity)
	                                       FROM PartsNeeded AS PN
										JOIN Parts AS p ON p.PartId = pn.PartId
										 WHERE JobId = @jobId
									     GROUP BY pn.JobId)
	IF(@totalCosts IS NULL OR @totalCosts <= 0)
		SET @totalCosts = 0;
		
  RETURN @totalCosts;
 END
  
  SELECT dbo.udf_GetCost(1) AS [Total Cost]
  
  
  