SELECT project_id, ROUND(SUM(experience_years)/COUNT(project_id), 2) AS average_years
FROM
    (SELECT 
        project_id, experience_years
    FROM 
        Project p
        LEFT JOIN Employee e ON p.employee_id = e.employee_id) AS JoinedTable
GROUP BY project_id;