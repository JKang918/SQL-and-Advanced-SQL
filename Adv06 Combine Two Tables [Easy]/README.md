## [Advanced SQL50] 06. Combine Two Tables

### Description:
[Combine Two Tables](https://leetcode.com/problems/combine-two-tables/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Person`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key (column with unique values) for this table.
This table contains information about the ID of some persons and their first and last names.
```

Table: `Address`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key (column with unique values) for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
```

Write a solution to report the first name, last name, city, and state of each person in the `Person` table. If the address of a `personId` is not present in the `Address` table, report `null` instead.

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Input: 
Person table:
+----------+----------+-----------+
| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
+----------+----------+-----------+
Address table:
+-----------+----------+---------------+------------+
| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
+-----------+----------+---------------+------------+
Output: 
+-----------+----------+---------------+----------+
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
Explanation: 
There is no address in the address table for the personId = 1 so we return null in their city and state.
addressId = 1 contains information about the address of personId = 2.
```

### Solution: 

```sql
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
```

or

```sql
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
```

### Breakdown of Solution:

```sql
(SELECT
    firstName,
    lastName,
    city,
    state
FROM 
    Person AS p LEFT JOIN Address AS a ON p.personID = a.personID)
```
subquery
1. As can be seen in the output of Example 1, `Person` is the reference point, and `Address` is joined to `Person`. Consequently, `personID 3` is absent from the left (reference) table and thus does not appear in the joined table. Additionally, `personID 1` remains in the table as a primary key, but since there are no matching records (city and state) to join, they are `null`s.

```sql
SELECT 
    *
FROM
    DerivedTable;
```
2. The rest is simple. Just extract required columns in the order instructed in the problem. As the joined table alreaddy have all the columns in the exactly required order, you can use `*`.

The alternative apporach follows the same logic.
