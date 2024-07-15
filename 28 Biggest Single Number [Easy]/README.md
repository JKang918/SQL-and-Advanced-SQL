## [SQL50] 28. Biggest Single Number
[Biggest Single Number](https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50)

Table: `MyNumbers`

```
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
```

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.

The result format is in the following example.

Example 1:

```
Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
```

### Solution: 

```sql
SELECT 
    MAX(num) AS num
FROM 
    (SELECT 
        *, 
        COUNT(num) AS count
    FROM 
        MyNumbers
    GROUP BY 
        num) AS CountInfo
WHERE 
    count = 1;
```

### Breakdown of Solution:

```sql

    (SELECT 
        *, 
        COUNT(num) AS count
    FROM 
        MyNumbers
    GROUP BY 
        num) AS CountInfo
```
subquery

1. To get that count information: how many times each number appears?

```sql
SELECT 
    MAX(num) AS num
FROM 
    (SELECT 
        *, 
        COUNT(num) AS count
    FROM 
        MyNumbers
    GROUP BY 
        num) AS CountInfo
WHERE 
    count = 1;
```
2. WHERE statement -> count should be one
3. MAX function -> among numbers that appear only once, return the maximum among them.

