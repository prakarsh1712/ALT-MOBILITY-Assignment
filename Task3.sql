-- Count of payment statuses
SELECT payment_status, COUNT(*) AS count
FROM payments
GROUP BY payment_status;

-- Payment status rate (% of total)
SELECT payment_status,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
FROM payments
GROUP BY payment_status;

-- Failure trend over time
SELECT DATE_TRUNC('month', payment_date) AS month, 
       COUNT(*) FILTER (WHERE payment_status = 'failed') AS failed_payments
FROM payments
GROUP BY month
ORDER BY month;
