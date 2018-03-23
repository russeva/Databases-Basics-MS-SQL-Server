SELECT m.ModelId,
       m.Name,
	   CAST(AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)) AS VARCHAR(10)) + ' days' AS [Average Service Time] 
 FROM Jobs as j
    JOIN Models AS m ON m.ModelId = j.ModelId
	GROUP BY m.ModelId, m.Name
ORDER BY CAST(AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)) AS VARCHAR(10)) + ' days' ASC



