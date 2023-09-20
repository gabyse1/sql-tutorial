/*
You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. 
List the rows such that X1 ≤ Y1.
*/
SELECT DISTINCT f.x, f.y
FROM functions f
WHERE (f.x=f.y AND (SELECT COUNT(*) FROM functions WHERE x=f.x AND y=f.y) = 2)
OR (f.x<f.y AND (f.y,f.x) IN (SELECT x,y FROM functions WHERE x=f.y AND y=f.x))
ORDER BY f.x;