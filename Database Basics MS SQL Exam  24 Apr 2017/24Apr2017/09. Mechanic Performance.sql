SELECT CONCAT(m.FirstName,' ',m.LastName) AS [Mechanic],
		AverageDays.AverageDays AS [AverageDays] FROM
(SELECT MechanicId,
       AVG(DATEDIFF(DAY,j.IssueDate, j.FinishDate )) AS [AverageDays] 
  FROM Jobs AS j
GROUP BY MechanicId) AS AverageDays
JOIN Mechanics AS m ON AverageDays.MechanicId = m.MechanicId
