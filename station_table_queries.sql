/*
Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/
SELECT ROUND(SUM(lat_n),2), ROUND(SUM(long_w),2)
FROM station;

/*
Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. 
Truncate your answer to 4 decimal places.
*/
SELECT ROUND(SUM(lat_n),4)
FROM station
WHERE lat_n BETWEEN 38.7880 AND 137.2345;

/*
Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. 
Truncate your answer to 4 decimal places.
*/
SELECT ROUND(MAX(lat_n),4)
FROM station
WHERE lat_n < 137.2345;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. 
Round your answer to 4 decimal places.
*/
SELECT ROUND(long_w,4)
FROM station
WHERE lat_n = (
    SELECT MAX(lat_n) FROM station WHERE lat_n < 137.2345
);

/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7880. Round your answer to 4 decimal places.
*/
SELECT ROUND(MIN(lat_n),4)
FROM station
WHERE lat_n > 38.7780;

/*
Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7880.
Round your answer to 4 decimal places.
*/
SELECT ROUND(long_w,4)
FROM station
WHERE lat_n = (
    SELECT MIN(lat_n) FROM station WHERE lat_n > 38.7780
); 

/*
Consider  and  to be two points on a 2D plane.

 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.
*/
SELECT ROUND(ABS(MAX(lat_n) - MIN(lat_n)) + ABS(MAX(long_w) - MIN(long_w)), 4)
FROM station;

/*
Consider  and  to be two points on a 2D plane where  are the respective minimum and maximum values of Northern Latitude (LAT_N) 
and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
*/
SELECT ROUND(SQRT(POW(MAX(lat_n) - MIN(lat_n), 2) + POW(MAX(long_w) - MIN(long_w), 2)), 4)
FROM station;

/*
A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
*/
SET @rnum = 0;
WITH numerated_station AS (
    SELECT (@rnum:=@rnum+1) AS num, lat_n
    FROM station
    ORDER BY lat_n
)
SELECT ROUND(lat_n,4)
FROM numerated_station
WHERE num = (SELECT CEILING(COUNT(num)/2) FROM numerated_station);