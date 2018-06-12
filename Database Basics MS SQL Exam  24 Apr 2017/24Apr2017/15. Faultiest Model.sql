     SELECT TOP 1 WITH TIES m.ModelId, 
		     m.Name, 
			 COUNT(*) AS [Times Serviced],
			 ISNULL(SUM(op.Quantity * p.Price),0) AS [Parts Total] 
	   FROM Models AS m
	   JOIN Jobs AS j ON j.ModelId = m.ModelId
	   JOIN Orders AS o ON o.JobId = j.JobId
	   JOIN OrderParts AS op ON op.OrderId = o.OrderId
	   JOIN Parts As p ON p.PartId = op.PartId
   GROUP BY m.ModelId,m.Name
   ORDER BY [Times Serviced] DESC

