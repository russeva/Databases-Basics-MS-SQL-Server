SELECT TOP(15) i.Name,
			   i.Description, 
			   c.Name FROM Ingredients AS i
JOIN Countries AS c 
  ON c.Id = i.OriginCountryId
WHERE OriginCountryId = 32 OR OriginCountryId = 31
ORDER BY i.Name ASC, c.Name ASC


