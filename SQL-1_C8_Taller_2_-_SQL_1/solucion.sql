```
-- Cargar las bases de datos necesarias
USE world;

-- Verificar que las tablas existen y tienen datos
DESCRIBE country;
DESCRIBE city;
DESCRIBE countrylanguage;

-- Pregunta 1: Explique las tablas y que relación existen entre ellas.
/* 
country -> city (relación uno a muchos)
country -> countrylanguage (relación uno a muchos)
city -> country (relación muchos a uno) 
*/

-- Búsqueda básica
-- Encontrar los diferentes tipos de gobierno en todo el mundo sin repetir.
SELECT DISTINCT governmentform FROM country;

-- Encontrar las ciudades de Australia
SELECT * FROM city WHERE countrycode = 'AUS';

-- Que países tienen una población mayor a 30 Millones ordenados de menor a mayor
SELECT name, population FROM country WHERE population > 30000000 ORDER BY population ASC;

-- Que países tienen un área superior a 1.000.000 y una población menor a 20.000.000
SELECT name, surfacearea, population FROM country WHERE surfacearea > 1000000 AND population < 20000000;

-- Búsqueda de Strings
-- Resultado de la consulta LIKE con NOT LIKE
SELECT name FROM city WHERE district LIKE '%Aires%' AND name NOT LIKE '%La Plata%';

-- Ciudades que tengan solamente una 'a' en su nombre (una y sola vez) y que su nombre sea más largo que 22 caracteres
WITH CityFilter AS (
    SELECT name, LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'a', '')) AS a_count
    FROM city
)
SELECT name FROM CityFilter WHERE a_count = 1 AND LENGTH(name) > 22;

-- Encuentra todas las ciudades cuyo nombre contenga al menos dos veces la letra 'a' en cualquier posición, pero que no contengan la letra 'e'. Además, el nombre de la ciudad debe tener exactamente 8 caracteres.
WITH CityFilter AS (
    SELECT name, LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'a', '')) AS a_count
    FROM city
)
SELECT c.name, cc.name AS country_name FROM city c JOIN country cc ON c.countrycode = cc.code WHERE a_count >= 2 AND NOT EXISTS (SELECT * FROM city WHERE name LIKE '%e%' AND LENGTH(name) = 8);

-- Ciudades que tengan sólo un tipo de vocal en su nombre. Esto incluye: todas las que se escriben solo con 'a', todas las que se escriben solo con 'e', todas las que se escriben solo con 'i', etc.
WITH CityFilter AS (
    SELECT name,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'a', '')) = LENGTH(name) THEN 1 ELSE 0 END AS a_only,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'e', '')) = LENGTH(name) THEN 2 ELSE 0 END AS e_only,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'i', '')) = LENGTH(name) THEN 3 ELSE 0 END AS i_only,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'o', '')) = LENGTH(name) THEN 4 ELSE 0 END AS o_only,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'u', '')) = LENGTH(name) THEN 5 ELSE 0 END AS u_only
    FROM city
)
SELECT name, countrycode FROM CityFilter WHERE a_only + e_only + i_only + o_only + u_only > 0;

-- Búsqueda con condiciones numéricas
-- Nombre de los 5 países más densamente poblados.
WITH CountryDensity AS (
    SELECT name, population / surfacearea AS density
    FROM country
)
SELECT TOP 5 name, density FROM CountryDensity ORDER BY density DESC;

-- Nombre de los países que tienen una superficie menor a 1/5 del promedio.
WITH AverageSurfaceArea AS (
    SELECT AVG(surfacearea) AS avg_surfacearea
    FROM country
), FilteredCountries AS (
    SELECT c.name, c.surfacearea, a.avg_surfacearea
    FROM country c CROSS JOIN AverageSurfaceArea a
)
SELECT name FROM FilteredCountries WHERE surfacearea < (avg_surfacearea / 5);

-- El promedio de la expectativa de vida mundial.
WITH LifeExpectancyAverage AS (
    SELECT AVG(lifeexpectancy) AS avg_life_expectancy
    FROM country
)
SELECT avg_life_expectancy FROM LifeExpectancyAverage;

-- Listar para cada continente el número de países que lo conforman y el promedio de su población, la consulta deberá estar ordenada por el nombre del continente de manera ascendente.
WITH ContinentPopulation AS (
    SELECT continent, COUNT(*) AS country_count, AVG(population) AS avg_population
    FROM country
    GROUP BY continent
)
SELECT * FROM ContinentPopulation ORDER BY continent ASC;

-- Lista los continentes que tienen al menos un país con una población superior a 100 millones, y muestra el número total de países en ese continente que cumplen con esta condición, junto con la suma total de la población de esos países.
WITH HighPopulationCountries AS (
    SELECT continent, COUNT(*) AS country_count, SUM(population) AS total_population
    FROM country
    WHERE population > 100000000
    GROUP BY continent
)
SELECT * FROM HighPopulationCountries;

-- Búsqueda en más de una tabla
-- Nombre de cada país, con el promedio entre la población conocida y la población calculada sumando la población de sus ciudades.
WITH CountryCityPop AS (
    SELECT c.code, SUM(ci.population) AS city_population
    FROM country c JOIN city ci ON c.code = ci.countrycode
    GROUP BY c.code
)
SELECT c.name, (c.population + IFNULL(cc.city_population, 0)) / 2 AS avg_population
FROM country c LEFT JOIN CountryCityPop cc ON c.code = cc.code;

-- Encuentra todas las ciudades con un nombre que contenga al menos dos vocales y no tenga la letra 'e'.
WITH CityFilter AS (
    SELECT name,
           CASE WHEN LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'a', '')) >= 2
                AND (LENGTH(name) - LENGTH(REPLACE(LOWER(name), 'e', ''))) = 0 THEN 1 ELSE 0 END AS condition_met
    FROM city
)
SELECT c.name, c.countrycode
FROM CityFilter c JOIN country cc ON c.countrycode = cc.code
WHERE condition_met = 1;

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
)
SELECT name, gdp_growth
FROM country c JOIN GDPgrowth g ON c.code = g.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country);

-- Encuentra todos los países con una tasa de desempleo superior al 5%.
WITH UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, unemployment_rate
FROM country c JOIN UnemploymentRate u ON c.code = u.code
WHERE unemployment_rate > (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al 5%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
),
UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, gdp_growth, unemployment_rate
FROM country c JOIN GDPgrowth g ON c.code = g.code
JOIN UnemploymentRate u ON c.code = u.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country)
AND unemployment_rate < (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al 5%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
),
UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, gdp_growth, unemployment_rate
FROM country c JOIN GDPgrowth g ON c.code = g.code
JOIN UnemploymentRate u ON c.code = u.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country)
AND unemployment_rate < (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al 5%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
),
UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, gdp_growth, unemployment_rate
FROM country c JOIN GDPgrowth g ON c.code = g.code
JOIN UnemploymentRate u ON c.code = u.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country)
AND unemployment_rate < (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al 5%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
),
UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, gdp_growth, unemployment_rate
FROM country c JOIN GDPgrowth g ON c.code = g.code
JOIN UnemploymentRate u ON c.code = u.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country)
AND unemployment_rate < (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al 5%.
WITH GDPgrowth AS (
    SELECT AVG(gdp_growth) as avg_gdp_growth
    FROM country
),
UnemploymentRate AS (
    SELECT AVG(unemployment_rate) as avg_unemployment_rate
    FROM country
)
SELECT name, gdp_growth, unemployment_rate
FROM country c JOIN GDPgrowth g ON c.code = g.code
JOIN UnemploymentRate u ON c.code = u.code
WHERE gdp_growth > (SELECT AVG(gdp_growth) FROM country)
AND unemployment_rate < (SELECT AVG(unemployment_rate) FROM country);

-- Encuentra todos los países con una tasa de crecimiento del PIB superior al 2% y una tasa de desempleo inferior al