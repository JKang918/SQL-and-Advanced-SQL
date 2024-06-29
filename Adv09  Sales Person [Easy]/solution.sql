SELECT 
    name
FROM 
    SalesPerson
WHERE sales_id 
    NOT IN
        #subtable with sales_id involved with RED  
        (
        SELECT 
            sales_id
        FROM
            Orders o 
            LEFT JOIN Company c ON o.com_id = c.com_id
        WHERE name = "RED"
        );

