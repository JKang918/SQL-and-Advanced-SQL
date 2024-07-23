WITH Requests AS
(SELECT user_id, COUNT(user_id) AS requests, SUM(IF(action = 'timeout', 0, 1)) AS confirmed
FROM
    Confirmations
GROUP BY
    user_id)

SELECT
    s.user_id, IFNULL(ROUND(confirmed/requests, 2), 0.00) AS confirmation_rate

FROM
    Signups s
    LEFT JOIN Requests r ON s.user_id = r.user_id;