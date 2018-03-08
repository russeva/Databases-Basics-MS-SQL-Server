/* Joins, Subqueries, CTE and Indices */
USE SoftUni

/* Problem 1.Employee Address */
SELECT * FROM Employees
SELECT * FROM Addresses

SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID,a.AddressText
         FROM Employees AS e
   INNER JOIN Addresses AS a 
           ON e.AddressID = a.AddressID
	 ORDER BY AddressID ASC

/* Problem 2.Addresses with Towns */
SELECT TOP (50) FirstName, LastName,t.Name, a.AddressText
           FROM Employees AS e 
     INNER JOIN Addresses AS a 
             ON e.AddressID = a.AddressID
	 INNER JOIN Towns AS t
             ON a.TownID = t.TownID
	   ORDER BY FirstName ASC

/* Problem 3.Sales Employee */

 SELECT EmployeeID, FirstName, LastName, d.Name 
   FROM Employees AS e
   JOIN Departments AS d
     ON e.DepartmentID = d.DepartmentID
  WHERE d.DepartmentID 
     IN 
        (
			SELECT DepartmentID FROM Departments AS d
			WHERE d.Name = 'Sales'
		)
ORDER BY EmployeeID ASC

/* Problem 4.Employee Departments */

SELECT TOP(5) EmployeeID, FirstName, LastName, Salary, d.Name 
         FROM Employees AS e
		 JOIN Departments AS d 
		   ON e.DepartmentID = d.DepartmentID
        WHERE Salary > 15000
     ORDER BY e.DepartmentID ASC

/* Problem 5.Employees Without Project */
          SELECT e.EmployeeID,e.FirstName
		    FROM EmployeesProjects AS ep
RIGHT OUTER JOIN Employees AS e
              ON ep.EmployeeID = e.EmployeeID
           WHERE NOT e.EmployeeID
		      IN
				(
					SELECT EmployeeID FROM EmployeesProjects
	
				)

/* Problem 6.Employees Hired After */
           SELECT e.FirstName, e.LastName, e.HireDate, d.Name 
			 FROM Employees AS e
 RIGHT OUTER JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
            WHERE d.Name 
			   IN ('Sales','Finance')
              AND HireDate >'1/1/1999'
         ORDER BY HireDate ASC

/* Problem 7.Employees with Project */
    SELECT TOP(5) e.EmployeeID,FirstName,p.Name AS [ProjectName]
            FROM Employees AS e
      INNER JOIN EmployeesProjects AS ep
			  ON e.EmployeeID = ep.EmployeeID
RIGHT OUTER JOIN Projects AS p 
              ON ep.ProjectID = p.ProjectID
           WHERE p.EndDate IS NULL
		   ORDER BY e.EmployeeID ASC

/* Problem 8.Employee 24 */
SELECT e.EmployeeID,e.FirstName, 
CASE
	WHEN
	 DATEPART(YEAR,p.StartDate) >= 2005 THEN NULL ELSE p.Name  
	   END AS [ProjectName] 
	 FROM Employees AS e
INNER JOIN EmployeesProjects As ep 
		ON e.EmployeeID = ep.EmployeeID
INNER JOIN Projects As p 
		ON ep.ProjectID = p.ProjectID
	 WHERE e.EmployeeID = '24'

/* Problem 9.Employee Manager */
SELECT e.EmployeeID,e.FirstName, e.ManagerID, m.FirstName AS [ManagerName] 
  FROM Employees AS e
  JOIN Employees AS m 
  ON m.EmployeeID = e.ManagerID
 WHERE e.ManagerID IN(3,7)

 /* Problem 10.Employee Summary */
 SELECT TOP(50) e.EmployeeID,
				m.FirstName + ' '+ m.LastName AS [EmployeeName],
				e.FirstName + ' '+ e.LastName  AS [ManagerName],
				d.Name AS [DepartmentName]
		   FROM Employees AS e
           JOIN Employees AS m
		    ON m.ManagerID = e.EmployeeID
		   JOIN Departments AS d 
		   ON e.DepartmentID = d.DepartmentID
		   ORDER BY e.EmployeeID
				

/* Problem 11.Min Average Salary */

SELECT MIN(a.AverageSalary) AS MinAvgSalary 
FROM 
(
	SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM Employees
	GROUP BY DepartmentID
) AS a

/* Problem 12.Highest Peaks in Bulgaria */
USE Geography
SELECT * FROM Mountains
SELECT * FROM MountainsCountries
SELECT * FROM Peaks

SELECT mc.CountryCode, m.MountainRange as [Mountain], PeakName,Elevation  FROM Peaks AS p
JOIN Mountains AS m ON m.Id = p.MountainId
JOIN MountainsCountries AS mc ON p.MountainId = mc.MountainId
WHERE CountryCode = 'BG' AND
Elevation > 2835
ORDER BY Elevation DESC

/* Problem 13.Count Mountain Ranges */
SELECT * FROM
(
	SELECT CountryCode,m.MountainRange
	  FROM MountainsCountries AS mc
	  JOIN Mountains AS m 
	    ON m.Id = mc.MountainId
) AS Result
WHERE CountryCode IN ('BG','RU','US')


/* Problem 14.Countries with Rivers */
SELECT * FROM CountriesRivers
SELECT * FROM Rivers

SELECT TOP(5) * FROM
(
	SELECT c.CountryName, RiverName FROM Rivers AS r
	  JOIN CountriesRivers AS cr
	    ON r.Id = cr.RiverId
RIGHT JOIN Countries AS c 
        ON cr.CountryCode = c.CountryCode
	 WHERE c.ContinentCode = 'AF'
) AS RiverByCountry
ORDER BY CountryName ASC

/* Problem 15.*Continents and Currencies */

	

/* Problem 16.Countries without any Mountains */
SELECT COUNT(cwm.CountryName) AS CountriesWithoutMountains
FROM
(
	SELECT mountCoun.CountryCode, con.CountryName FROM MountainsCountries AS mountCoun
	RIGHT JOIN Countries AS con ON mountCoun.CountryCode = con.CountryCode
	WHERE MountainId IS NULL
) AS cwm

/* Problem 17.Highest Peak and Longest River by Country */


SELECT TOP(5) Sorted.CountryName,
			  MAX(Sorted.PeakElevation) AS HighestPeakElevation, 
			  MAX(Sorted.Length) AS RiverLength
FROM
(
	   SELECT  c.CountryName AS CountryName,
			   p.Elevation  AS [PeakElevation],
		       r.[Length] 
		 FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc 
	       ON c.CountryCode = mc.CountryCode
	LEFT JOIN Peaks AS p 
	       ON mc.MountainId = p.MountainId
	LEFT JOIN CountriesRivers AS cr 
	       ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r 
	       ON cr.RiverId = r.Id
	
) AS Sorted
Group BY CountryName
ORDER BY MAX(Sorted.PeakElevation) DESC,
         MAX(Sorted.Length) DESC, 
		 Sorted.CountryName






	
	 
	 



		