SELECT j.JobId, 
	   ISNULL(SUM(p.Price * op.Quantity),0) AS  [Total] 
	    FROM Parts AS p
		JOIN OrderParts AS op ON op.PartId = p.PartId
		JOIN Orders AS o ON o.OrderId = op.OrderId
		JOIN Jobs AS j ON j.JobId = o.JobId
	   WHERE j.Status = 'Finished'
	   GROUP BY j.JobId
    ORDER BY Total DESC, j.JobId 

