/*
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project. 
Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
If there is more than one project that have the same number of completion days, then order by the start date of the project.
*/
SET @last_date = DATE('1990-01-01');
SET @py_count = 0;
SELECT MIN(rp.start_date) AS s_date, MAX(rp.end_date) AS e_date
FROM (SELECT IF(DATEDIFF(end_date, @last_date)<>1, @py_count:=@py_count+1, @py_count) AS id_py, start_date, @last_date:=end_date AS end_date
    FROM (SELECT * FROM projects order by start_date) np) rp
GROUP BY rp.id_py
ORDER BY COUNT(rp.id_py), s_date


----------------OTHER PERSON
SELECT start_date, Min(end_date) 
FROM 
/* Choose start dates that are not end dates of other projects (if a start date is an end date, it is part of the samee project) */
(SELECT start_date 
 FROM   projects 
 WHERE  start_date NOT IN (SELECT end_date 
                           FROM   projects)) a, 
/* Choose end dates that are not end dates of other projects */ 
(SELECT end_date 
 FROM   projects 
 WHERE  end_date NOT IN (SELECT start_date 
                         FROM   projects)) b 
/* At this point, we should have a list of start dates and end dates that don't necessarily correspond with each other */
/* This makes sure we only choose end dates that fall after the start date, and choosing the MIN means for the particular start_date, we get the closest end date that does not coincide with the start of another task */
WHERE  start_date < end_date 
GROUP  BY start_date 
ORDER  BY Datediff(start_date, Min(end_date)) DESC, 
          start_date