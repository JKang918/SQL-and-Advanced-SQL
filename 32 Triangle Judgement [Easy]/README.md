## [SQL50] 32. Triangle Judgement
[Triangle Judgement](https://leetcode.com/problems/triangle-judgement/?envType=study-plan-v2&envId=top-sql-50)

Table: `Triangle`

```
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
```

Report for every three line segments whether they can form a triangle.

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Input: 
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output: 
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

### Solution: 

```sql
SELECT
    *, IF(x + y > z and y + z > x and z + x > y, "Yes", "No") AS triangle
FROM
    Triangle;
```

### Breakdown of Solution:

This problem simply asks whether you can us `IF` function in SQL.

condition argument is to check whether the triangle condition is met.

If the condition is met, print "Yes", or else print "No" in the newly formed `triangle` column.

