WITH GroupedTable AS
    (
        SELECT 
            class, COUNT(class) AS cnt
        FROM 
            Courses
        GROUP BY 
            class
    )

SELECT 
    class
FROM 
    GroupedTable
WHERE 
    cnt > 4;