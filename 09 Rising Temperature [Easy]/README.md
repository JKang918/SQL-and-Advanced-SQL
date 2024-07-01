## [SQL50] 09. Rising Temperature:
[Rising Temperature](https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50)

Table: `Weather`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
```


Write a solution to find all dates' `Id` with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
```

### Solution: 

```sql
SELECT 
    w1.Id
FROM 
    Weather w1, Weather w2
WHERE 
    dateDiff(w1.recordDate,w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
```

### Breakdown of Solution:

Before we begin, we need to first know that `recordDate` is not necessarily in ascending order. If it were, below can also be an answer:

```sql
SELECT 
    w1.Id
FROM 
    Weather w1
    LEFT JOIN Weather w2 ON w1.id - 1 = w2.id
WHERE 
    w1.temperature > w2.temperature
```

For example, if w1.id is 1, w2.id of null is joined. if w1.id is 2, w2.id of 1 is joined. So if today's temperature (w1.temperature) is greater than yesterday's temperature (w2.temperature), extract that id.

But the problem is `recordDate` is not in ascending order.

So instead, we should go for the above solution.

```sql
WHERE 
    dateDiff(w1.recordDate,w2.recordDate) = 1 AND w1.Temperature > w2.Temperature;
```

The key to understand this solution lies in the WHERE statement.

`dateDiff` takes two date expressions and return the difference between the two. If the output is `1`, it means the first input is one day after the second input.

So the above means that `w1.recordDate` is one day after `w2.recordDate`.

To sum up, the above condition means, today's temperature is greater than yesterday's temperature.

For more information for `datediff`, check out [here](https://www.w3resource.com/mysql/date-and-time-functions/mysql-datediff-function.php#:~:text=The%20MySQL%20DATEDIFF()%20function,ignoring%20the%20time%20portion%20completely.)  

Similary, the below also works.

```sql
SELECT 
    w1.Id
FROM 
    Weather w1
JOIN 
    Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE 
    w1.temperature > w2.temperature;
```

To better understand this, let me share an example case.


```
Input: 
Weather table:
| id | recordDate | temperature |
| -- | ---------- | ----------- |
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
```

```sql
SELECT 
    *
FROM 
    Weather w1
JOIN 
    Weather w2 ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
```

```
Output: 
| id | recordDate | temperature | id | recordDate | temperature |
| -- | ---------- | ----------- | -- | ---------- | ----------- |
| 2  | 2015-01-02 | 25          | 1  | 2015-01-01 | 10          |
| 3  | 2015-01-03 | 20          | 2  | 2015-01-02 | 25          |
| 4  | 2015-01-04 | 30          | 3  | 2015-01-03 | 20          |
```

- checkout how the joined table looks