
-- Task 4: SQL for Data Analysis
-- =============================================

-- 1. Basic SELECT + WHERE + ORDER BY
SELECT customer_id, first_name, last_name, country
FROM customers
WHERE country = 'USA'
ORDER BY first_name ASC
LIMIT 10;


-- 2. Using JOINS (INNER, LEFT)
-- INNER JOIN: Find all orders with customer names
SELECT o.order_id, c.first_name, c.last_name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- LEFT JOIN: Find all customers and their orders (including those with no orders)
SELECT c.customer_id, c.first_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


-- 3. Subquery: Customers who spent more than the average total amount
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);


-- 4. Aggregate Functions (SUM, AVG, COUNT)
-- Total revenue, average order value, and total number of orders
SELECT 
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    COUNT(order_id) AS total_orders
FROM orders;


-- 5. Create a View for monthly sales analysis
CREATE VIEW monthly_sales AS
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_revenue,
    COUNT(order_id) AS monthly_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');


-- 6. Optimize with Index: Create an index on customer_id for faster joins
CREATE INDEX idx_customer_id ON orders(customer_id);
