--FILE: main.sql
-- Verificación de Tablas y Datos
DESCRIBE country;
DESCRIBE city;
DESCRIBE countrylanguage;

SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM countrylanguage;

-- Consultas Básicas
-- REQ_18: Consulta para encontrar diferentes tipos de gobierno.
SELECT governmentform, COUNT(*) FROM country GROUP BY governmentform;

-- REQ_19: Consulta para ciudades de Australia.
SELECT name FROM city WHERE countrycode = (SELECT code FROM country WHERE name = 'Australia');

-- REQ_20: Consulta para países con población mayor a 30 millones.
SELECT name FROM country WHERE population > 30000000;

-- REQ_21: Consulta para áreas superiores a 1 millón y poblaciones menores a 20 millones.
SELECT name FROM country WHERE surfacearea > 1000000 AND population < 20000000;

-- Consultas con LIKE
-- REQ_23: Consulta Exacta: = ‘Colombia’
SELECT * FROM country WHERE name = 'Colombia';

-- REQ_24: Consulta Omitiendo una parte y un carácter
SELECT * FROM country WHERE name LIKE '%nia' AND LENGTH(name) > 5;

-- REQ_25: Consulta específica con LIKE '%Aires%' AND name NOT LIKE '%La Plata%'
SELECT * FROM city WHERE name LIKE '%Aires%' AND name NOT LIKE '%La Plata%';

-- Funciones sobre Strings
-- REQ_27: LENGTH
SELECT name, LENGTH(name) FROM country;

-- REQ_28: CONCAT
SELECT CONCAT('The capital of ', localname, ' is ', headofstate) AS info FROM country;

-- REQ_29: LOWER, UPPER, RTRIM
SELECT LOWER(localname), UPPER(localname), RTRIM(headofstate) FROM country;

-- Consultas Específicas
-- REQ_30: Ciudades con una 'a'
SELECT name FROM city WHERE name LIKE '%a%';

-- REQ_31: Ciudades con dos veces la letra 'a' sin 'e'
SELECT name FROM city WHERE name LIKE '%a%' AND name LIKE '%a%' AND name NOT LIKE '%e%';

-- REQ_32: Ciudades con sólo un tipo de vocal en el nombre
SELECT name FROM city WHERE (name LIKE '%a%' AND name NOT LIKE '%e%' AND name NOT LIKE '%i%' AND name NOT LIKE '%o%' AND name NOT LIKE '%u%')
   OR (name LIKE '%e%' AND name NOT LIKE '%a%' AND name NOT LIKE '%i%' AND name NOT LIKE '%o%' AND name NOT LIKE '%u%')
   OR (name LIKE '%i%' AND name NOT LIKE '%a%' AND name NOT LIKE '%e%' AND name NOT LIKE '%o%' AND name NOT LIKE '%u%')
   OR (name LIKE '%o%' AND name NOT LIKE '%a%' AND name NOT LIKE '%e%' AND name NOT LIKE '%i%' AND name NOT LIKE '%u%')
   OR (name LIKE '%u%' AND name NOT LIKE '%a%' AND name NOT LIKE '%e%' AND name NOT LIKE '%i%' AND name NOT LIKE '%o%');

--FILE: 02-Data_Insert.sql
INSERT INTO countrylanguage VALUES ('AFG', 'Pashto', 't', 50);
INSERT INTO countrylanguage VALUES ('AFG', 'Dari', 'f', 30);
INSERT INTO countrylanguage VALUES ('ALB', 'Albanian', 't', 98);
INSERT INTO countrylanguage VALUES ('DZA', 'Arabic', 't', 71);