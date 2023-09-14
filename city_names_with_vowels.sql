-- Query the list of CITY names from STATION that both start and end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) IN ('a','e','i','o','u') AND RIGHT(city,1) IN ('a','e','i','o','u');

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) NOT IN ('a','e','i','o','u')

-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE RIGHT(city,1) NOT IN ('a','e','i','o','u')

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) NOT IN ('a','e','i','o','u') OR RIGHT(city,1) NOT IN ('a','e','i','o','u')

-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE LEFT(city,1) NOT IN ('a','e','i','o','u') AND RIGHT(city,1) NOT IN ('a','e','i','o','u')

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name).
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
SELECT city, LENGTH(city)
FROM station
WHERE LENGTH(city)=(
    SELECT MIN(LENGTH(city)) FROM station ORDER BY city LIMIT 1
)
ORDER BY city
LIMIT 1;
SELECT city, LENGTH(city)
FROM station
WHERE LENGTH(city)=(
    SELECT MAX(LENGTH(city)) FROM station ORDER BY city LIMIT 1
)
ORDER BY city
LIMIT 1;