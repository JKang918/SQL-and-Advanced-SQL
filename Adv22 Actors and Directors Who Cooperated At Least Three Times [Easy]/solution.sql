WITH Subtable AS
(SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email)
SELECT Email
FROM Subtable
Where email_cnt > 1;


##Alternative approach
SELECT Email
FROM
(SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email) AS Subtable
Where email_cnt > 1;

