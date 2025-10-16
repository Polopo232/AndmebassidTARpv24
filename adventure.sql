SELECT g.CountryRegionCode AS Country, e.Gender, SUM(e.YearlyIncome) AS TotalSalary
FROM DimCustomer e
JOIN DimGeography g ON e.GeographyKey = g.GeographyKey
GROUP BY g.CountryRegionCode, e.Gender
ORDER BY Country, Gender

-------------------------------------------------------

SELECT g.CountryRegionCode AS Country, e.Gender, SUM(e.YearlyIncome) AS TotalSalary
FROM DimCustomer e
JOIN DimGeography g ON e.GeographyKey = g.GeographyKey
GROUP BY g.CountryRegionCode, e.Gender

UNION ALL

SELECT g.CountryRegionCode AS Country, NULL AS Gender, SUM(e.YearlyIncome) AS TotalSalary
FROM DimCustomer e
JOIN DimGeography g ON e.GeographyKey = g.GeographyKey
GROUP BY g.CountryRegionCode
ORDER BY Country, Gender;

-------------------------------------------------

SELECT g.EnglishCountryRegionName AS Country, c.Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON g.GeographyKey = c.GeographyKey
GROUP BY g.EnglishCountryRegionName, c.Gender

UNION ALL

SELECT g.EnglishCountryRegionName AS Country, NULL AS Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON g.GeographyKey = c.GeographyKey
GROUP BY g.EnglishCountryRegionName

UNION ALL

SELECT NULL AS Country,c.Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
GROUP BY c.Gender

UNION ALL

SELECT NULL AS Country, NULL AS Gender, SUM(YearlyIncome) AS TotalSalary
FROM DimCustomer
ORDER BY Country, Gender;
---------------------------------------------------------------

SELECT
    g.EnglishCountryRegionName AS Country,
    c.Gender,
    SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON g.GeographyKey = c.GeographyKey
GROUP BY GROUPING SETS (
    (g.EnglishCountryRegionName, c.Gender),
    (g.EnglishCountryRegionName),
    (c.Gender),
    ()
)
ORDER BY Country, Gender;

-------------------------------------------------------- 

select Gender, sum(YearlyIncome) as TotalSalary, EnglishCountryRegionName as Country
from DimCustomer
join DimGeography on DimGeography.GeographyKey = DimCustomer.GeographyKey
group by
GROUPING SETS
(
(EnglishCountryRegionName, Gender),
(EnglishCountryRegionName),
(Gender),
()
);
---------------------------------------------------------------
select Gender, sum(YearlyIncome) as TotalSalary, EnglishCountryRegionName as Country
from DimCustomer
join DimGeography on DimGeography.GeographyKey = DimCustomer.GeographyKey
group by
GROUPING SETS
(
(EnglishCountryRegionName, Gender),
(EnglishCountryRegionName),
(Gender),
()
)
order by grouping(EnglishCountryRegionName), grouping(Gender), Gender
---------------------------------------------------------
SELECT g.EnglishCountryRegionName AS Country, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY ROLLUP (g.EnglishCountryRegionName)
ORDER BY Country;
----------------------------------------------------------

SELECT
    g.EnglishCountryRegionName AS Country,
    c.Gender,
    SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY ROLLUP (g.EnglishCountryRegionName, c.Gender)
ORDER BY Country, Gender;
-----------------------------------------------------

SELECT g.EnglishCountryRegionName AS Country, c.Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY GROUPING SETS
(
    (g.EnglishCountryRegionName, c.Gender),
    (g.EnglishCountryRegionName),
    ()
)
ORDER BY Country, Gender;
-----------------------------------------------------

SELECT
    g.EnglishCountryRegionName AS Country,
    c.Gender,
    SUM(c.YearlyIncome) AS TotalSalary
FROM
    DimCustomer c
JOIN
    DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY CUBE (g.EnglishCountryRegionName, c.Gender)
ORDER BY Country, Gender;

SELECT
    g.EnglishCountryRegionName AS Country,
    c.Gender,
    SUM(c.YearlyIncome) AS TotalSalary
FROM
    DimCustomer c
JOIN
    DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName, c.Gender WITH CUBE
ORDER BY Country, Gender;
-------------------------------------------------

SELECT
    g.EnglishCountryRegionName AS Country,
    c.Gender,
    SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY GROUPING SETS
(
    (g.EnglishCountryRegionName, c.Gender),
    (g.EnglishCountryRegionName),
    (c.Gender),
    ()
)
ORDER BY Country, Gender;
-----------------------------------------------------
SELECT g.EnglishCountryRegionName AS Country, c.Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName, c.Gender

UNION ALL

SELECT g.EnglishCountryRegionName AS Country, NULL AS Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY g.EnglishCountryRegionName

UNION ALL

SELECT NULL AS Country, c.Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
GROUP BY c.Gender

UNION ALL

SELECT NULL AS Country,  NULL AS Gender, SUM(c.YearlyIncome) AS TotalSalary
FROM DimCustomer c
ORDER BY Country, Gender;
------------------------------------------------------
SELECT g.EnglishCountryRegionName AS Country,g.City,SUM(f.YearlyIncome) AS TotalSalary
FROM DimCustomer f
JOIN DimGeography g ON f.GeographyKey = g.GeographyKey
GROUP BY ROLLUP (g.EnglishCountryRegionName, g.City)
ORDER BY Country,City;
-------------------------------------------------------

Create table Sales
(
Id int primary key identity,
Continent nvarchar(50),
Country nvarchar(50),
City nvarchar(50),
SaleAmount int
)
Go

Insert into Sales values('Asia', 'India', 'Bangalore', 1000)
Insert into Sales values('Asia', 'India', 'Chennai', 2000)
Insert into Sales values('Asia', 'Japan', 'Tokyo', 4000)
Insert into Sales values('Asia', 'Japan', 'Hiroshima', 5000)
Insert into Sales values('Europe', 'United Kingdom','London', 1000)
Insert into Sales values('Europe', 'United Kingdom', 'Manchester', 2000)
Insert into Sales values('Europe', 'France', 'Paris',4000)
Insert into Sales values('Europe', 'France', 'Cannes',5000)
Go

SELECT Continent, Country, City, SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

SELECT Continent, Country, City, SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY CUBE (Continent, Country, City)

SELECT Continent, Sum (SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Continent)

-----------------------------------------------------------------------------

SELECT Continent, Country, City, SUM(SaleAmount) AS TotalSales,
GROUPING (Continent) AS GP_Continent,
GROUPING (Country) AS GP_Country,
GROUPING(City) AS GP_City
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

-----------------------------------------------------------------------------

SELECT
	CASE WHEN
		GROUPING (Continent) = 1 THEN 'AII' ELSE ISNULL(Continent, 'Unknown')
	END AS Continent,
	CASE WHEN
		GROUPING (Country) = 1 THEN 'AII' ELSE ISNULL(Country, 'Unknown')
	END AS Country,
	CASE
		WHEN GROUPING(City) = 1 THEN 'AII' ELSE ISNULL(City, 'Unknown')
	END AS City,
	SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

-------------------------------------------------------------------------

SELECT ISNULL(Continent, 'All') AS Continent,
	ISNULL(Country, 'All') AS Country, 
	ISNULL(City, 'All') AS City,
	SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

--------------------------------------------------------------------------

SELECT * FROM Sales

Update Sales Set City = NULL where Id = 1

SELECT ISNULL(Continent, 'All') AS Continent,
ISNULL(Country, 'All') AS Country,
ISNULL(City, 'All') AS City,
SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

--------------------------------------------------------------------------

SELECT Continent, Country, City, SUM (SaleAmount) AS TotalSales,
	CAST(GROUPING (Continent) AS NVARCHAR(1)) +
	CAST(GROUPING (Country) AS NVARCHAR(1)) +
	CAST(GROUPING (City) AS NVARCHAR(1)) AS Groupings,
	GROUPING_ID (Continent, Country, City) AS GPID
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)

--------------------------------------------------------------------------

SELECT Continent, Country, City, SUM (SaleAmount) AS TotalSales,
GROUPING_ID(Continent, Country, City) AS GPID
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)
ORDER BY GPID

---------------------------------------------------------------------------

SELECT Continent, Country, City, SUM (SaleAmount) AS TotalSales,
	GROUPING_ID (Continent, Country, City) AS GPID
FROM Sales
GROUP BY ROLLUP (Continent, Country, City)
HAVING GROUPING_ID (Continent, Country, City) = 3




SELECT * FROm DimCustomer
