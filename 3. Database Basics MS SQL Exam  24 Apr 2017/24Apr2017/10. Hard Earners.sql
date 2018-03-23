SELECT CONCAT(m.FirstName,' ',m.LastName) AS [Mechanic],	
	  JobsAggRegation.Jobs FROM
(SELECT TOP(3) MechanicId,
        COUNT(Status) AS [Jobs]
   FROM Jobs
  WHERE Status <> 'Finished'
GROUP BY MechanicId
) AS JobsAggRegation
JOIN Mechanics AS m ON JobsAggRegation.MechanicId = m.MechanicId

