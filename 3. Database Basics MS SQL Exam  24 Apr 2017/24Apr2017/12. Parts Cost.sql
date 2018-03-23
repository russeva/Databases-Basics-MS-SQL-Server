SELECT SUM(p.Price * op.Quantity) AS [PartsTotal] FROM OrderParts As OP
JOIN Parts AS p ON p.PartId = op.PartId
JOIN Orders As o ON o.OrderId = op.PartId
WHERE o.IssueDate> DATEADD(WEEK, -3, 2017-04-24)
