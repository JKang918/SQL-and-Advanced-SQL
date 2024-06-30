## [Advanced SQL50] 30. Employees with Missing Information

### Description:
[Employees with Missing Information](https://leetcode.com/problems/employees-with-missing-information/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Employees`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
```

Table: `Salaries`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
```

Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:

- The employee's name is missing, or
- The employee's salary is missing.

Return the result table ordered by `employee_id` in ascending order.

The result format is in the following example.

Example 1:

```
Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
```

### Solution: 

```sql
(SELECT 
    e.employee_id
FROM 
    Employees e
LEFT JOIN 
    Salaries s ON e.employee_id = s.employee_id
WHERE 
    s.employee_id IS NULL)

UNION ALL

(SELECT 
    s.employee_id
FROM 
    Salaries s
LEFT JOIN 
    Employees e ON s.employee_id = e.employee_id
WHERE 
    e.employee_id IS NULL)
ORDER BY 
    employee_id;
```

### Breakdown of Solution:

Idea:

We need `employee_id` with missing data in either `name` or `salary` column. 

```sql
(SELECT 
    e.employee_id
FROM 
    Employees e
LEFT JOIN 
    Salaries s ON e.employee_id = s.employee_id
WHERE 
    s.employee_id IS NULL)
```
First subquery\
1. Using `Employees` table as reference, we obtain all id with missing `salary` data

```sql
(SELECT 
    s.employee_id
FROM 
    Salaries s
LEFT JOIN 
    Employees e ON s.employee_id = e.employee_id
WHERE 
    e.employee_id IS NULL)
```
Second subquery\
2. Using `Salary` table as reference, we obtain all id with missing `name` data

```sql
#... Frist Subquery
UNION ALL
#... Second Subquery
```
3. Use the concept of union. We need all `id`s from the first subquery and the second subquery


```sql
ORDER BY 
    employee_id;
```
4. Order in ascending order


