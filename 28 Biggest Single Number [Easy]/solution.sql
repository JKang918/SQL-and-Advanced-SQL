SELECT 
    MAX(num) AS num
FROM 
    (SELECT 
        *, 
        COUNT(num) AS count
    FROM 
        MyNumbers
    GROUP BY 
        num) AS CountInfo
WHERE 
    count = 1;