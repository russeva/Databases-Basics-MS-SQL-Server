SELECT CONCAT(m.FirstName,' ',m.LastName) AS [Mechanic],
	  j.Status AS [Status],
	  j.IssueDate AS [IssueDate] 
 FROM Mechanics As m
 JOIN Jobs AS j ON m.MechanicId = j.MechanicId
ORDER BY m.MechanicId ASC, j.IssueDate ASC, j.JobId ASC