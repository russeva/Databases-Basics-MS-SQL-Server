SELECT FirstName, Age, PhoneNumber 
  FROM Customers 
WHERE (FirstName LIKE '%_an_%' AND Age <= 21) 
   OR (PhoneNumber LIKE '%38' AND CountryId <> 31)
   ORDER BY FirstName ASC, Age DESC

   