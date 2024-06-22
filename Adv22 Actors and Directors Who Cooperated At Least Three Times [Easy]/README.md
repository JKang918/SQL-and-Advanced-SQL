## [Advanced SQL50] 22. Actors and Directors Who Cooperated At Least Three Times

### Description:
[Actors and Directors Who Cooperated At Least Three Times](https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/?envType=study-plan-v2&envId=premium-sql-50)

Table: `ActorDirector`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key (column with unique values) for this table.
```

Write a solution to find all the pairs `(actor_id, director_id)` where the actor has cooperated with the director at least three times.

Return the result table in any order.

The result format is in the following example.

Example 1:

```
Input: 
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output: 
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
```

### Solution: 

```sql
WITH Subtable AS
(SELECT actor_id, director_id, COUNT(*) AS pair_count
FROM ActorDirector
GROUP BY actor_id, director_id)
SELECT actor_id, director_id
FROM Subtable
WHERE pair_count >= 3;
```

or

```sql
SELECT actor_id, director_id
FROM
(SELECT actor_id, director_id, COUNT(*) AS pair_count
FROM ActorDirector
GROUP BY actor_id, director_id) AS Subtable
WHERE pair_count >= 3;
```

### Breakdown of Solution:

```sql
SELECT actor_id, director_id, COUNT(*) AS pair_count
FROM ActorDirector
GROUP BY actor_id, director_id
```
subquery
1. First and second columns show `actor_id` and `director_id` and the third column is the count of actor-director pairs. (GROUP BY)

```sql
WITH Subtable AS
(SELECT actor_id, director_id, COUNT(*) AS pair_count
FROM ActorDirector
GROUP BY actor_id, director_id)
```
2. Name the previous subquery (derived table) as Subtable

```sql
SELECT actor_id, director_id
FROM Subtable
WHERE pair_count >= 3;
```
3. Extract acotr director pairs with the count of greater than or equal to 3.

The alternative apporach follows the same logic.
