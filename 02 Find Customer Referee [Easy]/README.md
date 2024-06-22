## [SQL50] 02. Find Customer Referee

>Description: [Find Customer Referee](https://leetcode.com/problems/find-customer-referee/?envType=study-plan-v2&envId=top-sql-50)\

Table: `Customer`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
```

Find the names of the customer that are not referred by the customer with `id = 2`.

Return the result table in any order.

The result format is in the following example.



Example 1:

```
Input: 
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
```

### Solution: 

```sql
SELECT name 
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;
```
### Breakdown of Solution:




```sql
SELECT name 
```
1. Output shows only `name` column

```sql
FROM Customer
```
2. The table of interest

```sql
WHERE referee_id != 2 OR referee_id IS NULL;
```
3. Apply condition. Use "OR" since one of the conditions should be met.
The default in MySQL is that unless the second condition is added, rows with referee_id with NULL are screened out. 
