# Write your MySQL query statement below
SELECT 
    w1.Id
FROM 
    Weather w1
JOIN 
    Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE 
    w1.temperature > w2.temperature;

#or this also works

SELECT 
    w1.Id
FROM 
    Weather w1, Weather w2
WHERE 
    dateDiff(w1.Date,w2.Date) = 1 AND w1.Temperature > w2.Temperature;
