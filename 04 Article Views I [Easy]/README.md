## [SQL50] 04. Article Views I

### Description:
[Article Views I](https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50)

Table: `Views`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
```

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.

The result format is in the following example.

Example 1:

```
Input: 
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output: 
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
```

### Solution: 

```sql
SELECT DISTINCT author_id AS id 
FROM Views 
WHERE author_id = viewer_id 
ORDER BY author_id;
```
### Breakdown of Solution:

```sql
SELECT DISTINCT author_id AS id 
```
1. Output shows only `author_id` renamed as `id`.
2. `DISTINCT` to prevent duplicate rows with same `id`

```sql
FROM Views 
```
3. The table of interest

```sql
WHERE author_id = viewer_id 
```
4. Apply condition. This results in extracting **all** rows meeting this condition, hence there might be duplicate rows. To prevent this, `DISTINCT` was used with `SELECT`.

```sql
ORDER BY author_id;
```
5. The output should be sorted in ascending order. The default in MySQL is ascending order so `ASC` can be skipped. If it should have been descending order, `DESC` should be appended. 