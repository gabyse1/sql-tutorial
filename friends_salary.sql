/*
You are given three tables: Students, Friends and Packages. 
Students contains two columns: ID and Name. 
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

Write a query to output the names of those students whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.
*/
-- 1
SELECT (SELECT name FROM students WHERE id=f.id) AS name
FROM friends f
WHERE (SELECT salary FROM packages WHERE id=f.friend_id) > (SELECT salary FROM packages WHERE id=f.id)
ORDER BY (SELECT salary FROM packages WHERE id=f.friend_id)

-- 2
SELECT (SELECT name FROM students WHERE id=f.id) AS name
FROM friends f
JOIN packages p1 ON p1.id=f.id
JOIN packages p2 ON p2.id=f.friend_id
WHERE p2.salary > p1.salary
ORDER BY p2.salary