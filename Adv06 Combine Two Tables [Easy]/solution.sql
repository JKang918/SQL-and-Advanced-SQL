WITH DerivedTable AS
(SELECT
    firstName,
    lastName,
    city,
    state
FROM 
    Person AS p LEFT JOIN Address AS a ON p.personID = a.personID)

SELECT 
    *
FROM
    DerivedTable;

#Alternatively
SELECT 
    *
FROM
    (SELECT
        firstName,
        lastName,
        city,
        state
    FROM 
        Person AS p LEFT JOIN Address AS a ON p.personID = a.personID) AS DerivedTable;
