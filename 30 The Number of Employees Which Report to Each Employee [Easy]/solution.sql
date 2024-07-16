WITH Counts AS
(SELECT
    reports_to AS id, COUNT(reports_to) AS reports_count, ROUND(AVG(age), 0) AS average_age
FROM
    Employees
GROUP BY
    reports_to)

SELECT
    e.employee_id, name, reports_count, average_age

FROM
    Employees e
    INNER JOIN Counts ON e.employee_id = id 

ORDER BY
    e.employee_id ASC;