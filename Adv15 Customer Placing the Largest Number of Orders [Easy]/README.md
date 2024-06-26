## [Advanced SQL50] 15. Customer Placing the Largest Number of Orders

### Description:
[Customer Placing the Largest Number of Orders](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/?envType=study-plan-v2&envId=premium-sql-50)

Table: `Orders`

```
+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
```

Write a solution to find the `customer_number` for the customer who has placed the largest number of orders.

The test cases are generated so that **exactly one customer** will have placed more orders than any other customer.

The result format is in the following example.

Example 1:

```
Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
```

### Solution: 

```sql
SELECT 
    customer_number
FROM
    Orders
GROUP BY 
    customer_number
ORDER BY 
    COUNT(customer_number) DESC
LIMIT 1;
```


### Breakdown of Solution:

The key to solving this problem is given in the problem itself: **exactly one customer will have placed more orders**\
So the idea is to sort the customers in the order of their order counts in *descending order*. And return the first row with LIMIT 

```sql
SELECT 
    customer_number
FROM
    Orders
```
1. Require only `customer_number` in the output

```sql
GROUP BY 
    customer_number
ORDER BY 
    COUNT(customer_number) DESC
```
2. Note that the COUNT does not have to be placed behind SELECT. It can directly be used in ORDER BY.

```sql
LIMIT 1;
```
3. Return the first row
