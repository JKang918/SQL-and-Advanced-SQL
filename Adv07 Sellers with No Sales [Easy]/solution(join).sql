SELECT 
    seller_name
FROM 
    Seller a
LEFT JOIN 
    (SELECT 
        DISTINCT seller_id
    FROM 
        Orders
    WHERE 
        YEAR(sale_date) = 2020) b
ON 
    a.seller_id = b.seller_id

WHERE
    b.seller_id IS NULL

ORDER BY
    seller_name;