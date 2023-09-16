/*
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, 
then the ascending company_codes will be C_1, C_10, and C_2.
*/
SELECT company.company_code, founder, num_lead_managers, num_senior_managers, num_managers, num_employees
FROM company
INNER JOIN (
    SELECT company_code, COUNT(DISTINCT lead_manager_code) AS num_lead_managers
    FROM lead_manager
    GROUP BY company_code
) lead_managers ON company.company_code = lead_managers.company_code
INNER JOIN (
    SELECT company_code, COUNT(DISTINCT senior_manager_code) AS num_senior_managers
    FROM senior_manager
    GROUP BY company_code
) senior_managers ON company.company_code = senior_managers.company_code
INNER JOIN (
    SELECT company_code, COUNT(DISTINCT manager_code) AS num_managers
    FROM manager
    GROUP BY company_code
) managers ON company.company_code = managers.company_code
INNER JOIN (
    SELECT company_code, COUNT(DISTINCT employee_code) AS num_employees
    FROM employee
    GROUP BY company_code
) employees ON company.company_code = employees.company_code
ORDER BY company_code



-- OTHERS ANSWER
SELECT c.Company_Code, c.founder, count(Distinct e.Lead_Manager_Code), 
count(distinct e.Senior_Manager_Code), count(distinct e.Manager_Code), 
count(distinct e.employee_Code) FROM Company c 
JOIN Employee e ON c.Company_Code = e.Company_Code GROUP BY c.Company_Code, c.Founder ORDER BY c.Company_Code;