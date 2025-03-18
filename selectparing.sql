SELECT * FROM country ORDER BY SurfaceArea LIMIT 1;

SELECT * FROM country ORDER BY Population DESC LIMIT 10;

SELECT * FROM country WHERE Continent = 'Europe' ORDER BY Population DESC LIMIT 10;

SELECT COUNT(*) AS 'Riigid Antarktikas' FROM country WHERE Continent='Antarctica';

SELECT COUNT(*) AS "Riikide arv", SUM(Population) AS "Kõigi riikide elanikkond" FROM country WHERE HeadOfState = 'Elisabeth II';

SELECT COUNT(*) AS 'Kõik riikided', MAX(Population) AS 'Suurim rahvaarv', MIN(Population) AS 'Väiksem rahvaarv' FROM country WHERE Region = 'Polynesia';
