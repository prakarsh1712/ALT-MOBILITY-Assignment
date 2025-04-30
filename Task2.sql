-- Count of repeat customers
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM customer_orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS repeaters;

-- Monthly order counts (customer activity over time)
SELECT DATE_TRUNC('month', order_date) AS month, 
       COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY month
ORDER BY month;

-- Customer Segmentation (orders per customer)
SELECT customer_id, COUNT(*) AS order_count
FROM customer_orders
GROUP BY customer_id
ORDER BY order_count DESC;
