## [Advanced SQL50] 07. Sellers with No Sales

### Description:
[Sellers with No Sales](https://leetcode.com/problems/sellers-with-no-sales/description/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Customer`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| customer_name | varchar |
+---------------+---------+
customer_id is the column with unique values for this table.
Each row of this table contains the information of each customer in the WebStore.
```

Table: `Orders`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| sale_date     | date    |
| order_cost    | int     |
| customer_id   | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the column with unique values for this table.
Each row of this table contains all orders made in the webstore.
sale_date is the date when the transaction was made between the customer (customer_id) and the seller (seller_id).
```

Table: `Seller`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| seller_id     | int     |
| seller_name   | varchar |
+---------------+---------+
seller_id is the column with unique values for this table.
Each row of this table contains the information of each seller.
```


Write a solution to report the names of all sellers who did not make any sales in `2020`.

Return the result table ordered by `seller_name` in ascending order.

The result format is in the following example.


Example 1:

```
Input: 
Customer table:
+--------------+---------------+
| customer_id  | customer_name |
+--------------+---------------+
| 101          | Alice         |
| 102          | Bob           |
| 103          | Charlie       |
+--------------+---------------+
Orders table:
+-------------+------------+--------------+-------------+-------------+
| order_id    | sale_date  | order_cost   | customer_id | seller_id   |
+-------------+------------+--------------+-------------+-------------+
| 1           | 2020-03-01 | 1500         | 101         | 1           |
| 2           | 2020-05-25 | 2400         | 102         | 2           |
| 3           | 2019-05-25 | 800          | 101         | 3           |
| 4           | 2020-09-13 | 1000         | 103         | 2           |
| 5           | 2019-02-11 | 700          | 101         | 2           |
+-------------+------------+--------------+-------------+-------------+
Seller table:
+-------------+-------------+
| seller_id   | seller_name |
+-------------+-------------+
| 1           | Daniel      |
| 2           | Elizabeth   |
| 3           | Frank       |
+-------------+-------------+
Output: 
+-------------+
| seller_name |
+-------------+
| Frank       |
+-------------+
Explanation: 
Daniel made 1 sale in March 2020.
Elizabeth made 2 sales in 2020 and 1 sale in 2019.
Frank made 1 sale in 2019 but no sales in 2020.
```


### Solution 1. Join: 

```sql
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
```

### Breakdown of Solution:

```sql
    (SELECT 
        DISTINCT seller_id
    FROM 
        Orders
    WHERE 
        YEAR(sale_date) = 2020) b
```
subquery
1. From `Orders` table, get `seller_id` who has made sales in 2020.


```sql
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
```
2. Join the subtable onto `Seller` table. Among the sellers, sellers who did not make any sales in 2020, therefore who is not included in the subtable, will be `Null` when the two tables are joined. To be precisly speaking, `a.seller_id` (left table) will be as it was but because for those sellers there is no matching id in table `b`, `b.seller_id` will be `Null` 

```sql
WHERE
    b.seller_id IS NULL

ORDER BY
    seller_name;
```

3. Sellers whose `b.seller_id` `IS NULL` are what we are interested in.

---

### Solution 2. Not In: 

```sql
SELECT
    seller_name
FROM
    Seller
WHERE
    seller_id NOT IN
(
    SELECT
        DISTINCT seller_id
    FROM
        Orders
    WHERE
        YEAR(sale_date) = 2020
)

ORDER BY seller_name;
```

### Breakdown of Solution:


We are interested in sellers who did not make sales in 2020. 

Get the list of `seller_id` from `Orders` who made sales in 2020.

Get `seller_name` who have no matching recored in the list of sellers who made sales in 2020 using `NOT IN` statement.
