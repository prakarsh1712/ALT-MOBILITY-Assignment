-- Combined order and payment summary
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    o.order_amount,
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    p.payment_status
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id;

-- To aggregate key metrics:
-- Summary of key metrics
SELECT 
    order_status,
    payment_status,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_revenue,
    COUNT(*) FILTER (WHERE payment_status = 'completed') AS successful_payments
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY order_status, payment_status
ORDER BY total_orders DESC;
