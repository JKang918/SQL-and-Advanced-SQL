SELECT *
FROM
    (SELECT name, bonus
    FROM
        Employee e
        LEFT JOIN Bonus b ON e.empId = b.empId
    ) AS JoinedTable
WHERE
    bonus IS NULL OR bonus < 1000;