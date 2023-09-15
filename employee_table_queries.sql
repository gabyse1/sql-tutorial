/*
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2000
per month who have been employees for less than  months. Sort your result by ascending employee_id.
*/
SELECT name
FROM employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;

/*
We define an employee's total earnings to be their monthly salary*months worked, 
and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees 
who have maximum total earnings. Then print these values as 2 space-separated integers.
*/
SELECT MAX(salary*months), COUNT(*)
FROM employee
WHERE (salary*months) = (
    SELECT MAX(salary*months) FROM employee
);
