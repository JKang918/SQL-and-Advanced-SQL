## [Advanced SQL50] 21. Duplicate Emails

### Description:
[Duplicate Emails](https://leetcode.com/problems/duplicate-emails/description/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Person`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
```

Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
```

### Solution: 

```sql
WITH Subtable AS
(SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email)
SELECT Email
FROM Subtable
Where email_cnt > 1;
```

or

```sql
SELECT Email
FROM
(SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email) AS Subtable
Where email_cnt > 1;
```

### Breakdown of Solution:

```sql
SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email
```
subquery
1. First column shows email addresses, second column shows the count of each eamil address

```sql
WITH Subtable AS
(SELECT email AS Email, COUNT(email) AS email_cnt
FROM Person
GROUP BY email)
```
2. Name the previous subquery (derived table) as Subtable

```sql
SELECT Email
FROM Subtable
Where email_cnt > 1;
```
3. Extract email addresses with the count of greater than 2.

The alternative apporach follows the same logic.
