## [SQL50] 44. Fix Names in a Table
[Fix Names in a Table](https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50)

Table: `Users`

```
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
```

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by `user_id`.

The result format is in the following example.

Example 1:

```
Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
```

### Solution: 

```sql
SELECT
    user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM
    Users
ORDER BY
    user_id;
```

### Breakdown of Solution:

This problem simply asks whether you can us `SUBSTRING`

function, `SUBSTRING` has takes three arguments:

    - SUBSTRING("string", "start_position", "length"): cut a string from the specified position for the specified length.

In this problem, the first character should be upper case. Thus start_position is 1 and length is 1.

The rest characters should be lower case. Thus start_position is 2 and length is n - 1 with n being the length of the string. In this particular case, the third argument, `length` can be left out. `length` is automatically calculated as the length of the substring that starts with the 2nd element till the end.