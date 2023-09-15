-- Query the total population of all cities in CITY where District is California.
SELECT SUM(population)
FROM city
WHERE district='California';

-- Query the average population of all cities in CITY where District is California.
SELECT AVG(population)
FROM city
WHERE district='California';

-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT FLOOR(AVG(population))
FROM city;

-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(population)
FROM city
WHERE countrycode='JPN';

-- Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(population) - MIN(population)
FROM city;

