## [SQL50] 05. Invalid Tweets

### Description:
[Invalid Tweets](https://leetcode.com/problems/invalid-tweets/?envType=study-plan-v2&envId=top-sql-50)

Table: `Tweets`

```
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
This table contains all the tweets in a social media app.
```

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is **strictly greater than** `15`.

Return the result table in **any order**.

The result format is in the following example.

Example 1:

```
Input: 
Tweets table:
+----------+----------------------------------+
| tweet_id | content                          |
+----------+----------------------------------+
| 1        | Vote for Biden                   |
| 2        | Let us make America great again! |
+----------+----------------------------------+
Output: 
+----------+
| tweet_id |
+----------+
| 2        |
+----------+
Explanation: 
Tweet 1 has length = 14. It is a valid tweet.
Tweet 2 has length = 32. It is an invalid tweet.
```

### Solution: 

```sql
SELECT tweet_id
FROM Tweets
WHERE CHAR_LENGTH(content) > 15
```
### Breakdown of Solution:

```sql
SELECT tweet_id
```
1. Output shows only `tweet_id`

```sql
FROM Tweets
```
2. The table of interest

```sql
WHERE CHAR_LENGTH(content) > 15
```
3. When tweet (string) has length of greater than 15, it's invalid. Use function, `CHAR_LENGTH` in MySQL.