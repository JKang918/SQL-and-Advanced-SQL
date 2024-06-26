## [Advanced SQL50] 02. Customers Who Neve Order

### Description:
[Customers Who Neve Order](https://leetcode.com/problems/customers-who-never-order/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Customers`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.
```

Table: `Orders`

```
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
```

Write a solution to find all customers who never order anything.

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
```

### Solution: 

```sql
SELECT name AS Customers
FROM Customers
WHERE id NOT IN 
(#Operand should contain ONE COLUMN
SELECT o.customerID
FROM
    Orders o
    LEFT JOIN Customers c ON o.customerID = c.id);
```

### Breakdown of Solution:

```sql
#Operand should contain ONE COLUMN
SELECT o.customerID
FROM
    Orders o
    LEFT JOIN Customers c ON o.customerID = c.id
```
subquery
1. These are customerIDs who have ever ordered

```sql
SELECT name AS Customers
FROM Customers
WHERE id NOT IN 
(......);
```
2. with `id` not in the previous subtable column, the rest of customers are guaranteed to be customers who never ordered.
