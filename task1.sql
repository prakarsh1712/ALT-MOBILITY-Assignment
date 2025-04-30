-- Total orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM customer_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Monthly sales trend
SELECT DATE_TRUNC('month', order_date) AS month, 
       SUM(order_amount) AS total_sales
FROM customer_orders
GROUP BY month
ORDER BY month;
