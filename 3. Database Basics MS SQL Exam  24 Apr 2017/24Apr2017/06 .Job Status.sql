SELECT Status,IssueDate FROM Jobs
 WHERE Status <> 'Finished'
ORDER BY IssueDate ASC,
         JobId ASC