SELECT CONCAT(c.FirstName,' ',c.LastName) AS [Client],
	   DATEDIFF(DAY, 24-04-2017, j.IssueDate) AS [DaysGoing],
	   j.Status AS [Status]
 FROM Jobs AS j
 JOIN Clients AS c ON c.ClientId = j.ClientId
WHERE j.Status = 'In Progress'
ORDER BY DaysGoing DESC, c.ClientId ASC