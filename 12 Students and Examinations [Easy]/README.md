## [SQL50] 12. Students and Examinations
[Students and Examinations](https://leetcode.com/problems/students-and-examinations/?envType=study-plan-v2&envId=top-sql-50)

Table: `Students`

```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
```

Table: `Subjects`

```
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
```

Table: `Examinations`

```
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
```


Write a solution to find the number of times each student attended each exam.

Return the result table ordered by `student_id` and `subject_name`.

The result format is in the following example.

 

Example 1:

```
Input: 
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output: 
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation: 
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
```

### Solution: 

```sql
WITH Subtable AS
(
    SELECT 
        *, COUNT(subject_name) AS attended_exams
    FROM 
        Examinations
    GROUP BY 
        student_id, subject_name
)

SELECT 
    t.student_id, t.student_name, s.subject_name, IFNULL(attended_exams, 0) AS attended_exams
FROM 
    Students t
    CROSS JOIN 
        Subjects s
    LEFT JOIN 
        Subtable sub 
            ON t.student_id = sub.student_id AND s.subject_name = sub.subject_name
ORDER BY 
    student_id, subject_name;
```

### Breakdown of Solution:

```sql
WITH Subtable AS
(
    SELECT 
        *, COUNT(subject_name) AS attended_exams
    FROM 
        Examinations
    GROUP BY 
        student_id, subject_name
)
```
subquery

1. From `Examinations` table, by using aggregation, compute `attended_exams`. The subquery itself will result in like below table:

```
| student_id | subject_name | attended_exams |
| ---------- | ------------ | -------------- |
| 1          | Math         | 3              |
| 1          | Physics      | 2              |
| 1          | Programming  | 1              |
| 2          | Programming  | 1              |
| 13         | Math         | 1              |
| 13         | Programming  | 1              |
| 13         | Physics      | 1              |
| 2          | Math         | 1              |
```


```sql
SELECT 
    t.student_id, t.student_name, s.subject_name, IFNULL(attended_exams, 0) AS attended_exams
FROM 
    Students t
    CROSS JOIN 
        Subjects s
    LEFT JOIN 
        Subtable sub 
            ON t.student_id = sub.student_id AND s.subject_name = sub.subject_name
```
2. Now, create a list of `students` and `subject_name` where we can attach data in `attended_exams`. We use `corss join` in this case.

To give you a better understanding, let me show how two tables are merged in the case of `cross join`.

```sql
# Example
SELECT 
    *
FROM 
    Students t
    CROSS JOIN 
        Subjects s
```

```
| student_id | student_name | subject_name |
| ---------- | ------------ | ------------ |
| 1          | Alice        | Programming  |
| 1          | Alice        | Physics      |
| 1          | Alice        | Math         |
| 2          | Bob          | Programming  |
| 2          | Bob          | Physics      |
| 2          | Bob          | Math         |
| 13         | John         | Programming  |
| 13         | John         | Physics      |
| 13         | John         | Math         |
| 6          | Alex         | Programming  |
| 6          | Alex         | Physics      |
| 6          | Alex         | Math         |
```

So here, we can see that whe `cross join` is applied, the number of row for each student in `Students` gets multiplied by the number of subjects, in this case 3.

What we are going to do is simply `left join` the subtable to this list from `cross join`. 

Note that student_id **AND** student_name combined represent each distinct data.

If you do so, `attended_exams` will be added to right part of the cross-joined table. Subsitute `0` for `null`s.

```sql
ORDER BY 
    student_id, subject_name;
```

3. order by `student_id` and `subject_name`
