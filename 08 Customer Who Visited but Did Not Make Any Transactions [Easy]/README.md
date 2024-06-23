## [SQL50] 08. Customer Who Visited but Did Not Make Any Transactions

### Description:
[Customer Who Visited but Did Not Make Any Transactions](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50)

Table: `Visits`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.
```

Table: `Transactions`

```
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
```

Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

The result format is in the following example.

Example 1:

```
Input: 
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
Explanation: 
Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
Customer with id = 30 visited the mall once and did not make any transactions.
Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
Customer with id = 96 visited the mall once and did not make any transactions.
As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also, user 54 visited the mall twice and did not make any transactions.
```

### Solution: 

```sql
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
```
### Breakdown of Solution:

```sql
WITH DerivedTable AS
(
    SELECT 
        customer_id, amount
    FROM 
        Visits AS v LEFT JOIN Transactions AS t ON v.visit_id = t.visit_id
)
```
1. To see how many purchases a customer did in each visit, use LEFT JOIN to merge two tables. The result will show like this. For better understanding, I used SELECT * for the below code block.

```
result of LEFT JOIN:

| visit_id | customer_id | transaction_id | visit_id | amount |
| -------- | ----------- | -------------- | -------- | ------ |
| 1        | 23          | 12             | 1        | 910    |
| 2        | 9           | 13             | 2        | 970    |
| 4        | 30          | null           | null     | null   |
| 5        | 54          | 9              | 5        | 200    |
| 5        | 54          | 3              | 5        | 300    |
| 5        | 54          | 2              | 5        | 310    |
| 6        | 96          | null           | null     | null   |
| 7        | 54          | null           | null     | null   |
| 8        | 54          | null           | null     | null   |
```


```sql
SELECT 
    customer_id, COUNT(customer_id) AS count_no_trans
FROM 
    DerivedTable
```
2. [SELECT] Now the remaining task is count `customer_id` with `null` data and return the id and the count
3. [FROM] The table of interest

```sql
WHERE 
    amount IS NULL
```
4. Apply condition. We are counting only the rows with `NULL` data

```sql
GROUP BY 
    customer_id
```
5. Because we are counting the number of customers.