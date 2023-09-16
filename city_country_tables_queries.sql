/*
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
SELECT SUM(population)
FROM city
WHERE countrycode IN (
    SELECT code FROM country WHERE continent = 'Asia'
);

-- optional + more difficult than above
SELECT SUM(city.population)
FROM city
INNER JOIN country ON city.countrycode = country.code
WHERE country.continent = 'Asia';

/*
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
SELECT name
FROM city
WHERE countrycode IN (
    SELECT code FROM country WHERE continent = 'Africa'
);

/*
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent)
 and their respective average city populations (CITY.Population) rounded down to the nearest integer.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/
SELECT country.continent, FLOOR(AVG(city.population))
FROM city
INNER JOIN country ON city.countrycode = country.code
GROUP BY country.continent;
