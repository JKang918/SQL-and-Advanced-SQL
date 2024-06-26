SELECT name AS Customers
FROM Customers
WHERE id NOT IN 
(#Operand should contain ONE COLUMN
SELECT o.customerID
FROM
    Orders o
    LEFT JOIN Customers c ON o.customerID = c.id);