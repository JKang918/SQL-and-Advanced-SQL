WITH DerivedTable AS
(
    SELECT 
        customer_id, amount
    FROM 
        Visits AS v LEFT JOIN Transactions AS t ON v.visit_id = t.visit_id
)

SELECT 
    customer_id, COUNT(customer_id) AS count_no_trans
FROM 
    DerivedTable
WHERE 
    amount IS NULL
GROUP BY 
    customer_id;