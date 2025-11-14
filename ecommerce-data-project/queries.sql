-- E-Commerce Data Analytics SQL Queries
-- Execute using: sqlite3 ecommerce.db < queries.sql

-- =====================================================
-- 1. Top Customers by Total Spend
-- =====================================================
SELECT 
    c.customer_id,
    c.name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.amount) AS total_spent,
    ROUND(AVG(p.amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'Completed'
GROUP BY c.customer_id, c.name, c.email
ORDER BY total_spent DESC
LIMIT 10;

-- =====================================================
-- 2. Total Revenue Per Product
-- =====================================================
SELECT 
    p.product_id,
    p.name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount)), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_selling_price,
    COUNT(DISTINCT oi.order_id) AS number_of_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.status = 'Completed'
GROUP BY p.product_id, p.name, p.category
ORDER BY total_revenue DESC;

-- =====================================================
-- 3. Monthly Sales Summary
-- =====================================================
SELECT 
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(SUM(p.amount), 2) AS total_revenue,
    ROUND(AVG(p.amount), 2) AS avg_order_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'Completed'
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY month DESC;

-- =====================================================
-- 4. Orders with Customer + Payment Details (Multi-table Join)
-- =====================================================
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.email,
    o.order_id,
    o.order_date,
    o.status AS order_status,
    p.payment_method,
    p.amount AS payment_amount,
    p.status AS payment_status,
    ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount)), 2) AS calculated_order_value,
    COUNT(oi.item_id) AS number_of_items
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id, c.customer_id, c.name, c.email, o.order_date, 
         o.status, p.payment_method, p.amount, p.status
ORDER BY o.order_date DESC
LIMIT 20;

-- =====================================================
-- 5. Product Category Performance
-- =====================================================
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS products_count,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount)), 2) AS category_revenue,
    ROUND(AVG(oi.price), 2) AS avg_product_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.status = 'Completed'
GROUP BY p.category
ORDER BY category_revenue DESC;

-- =====================================================
-- 6. Customer Lifetime Value Analysis
-- =====================================================
SELECT 
    c.customer_id,
    c.name,
    c.registration_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.amount), 2) AS lifetime_value,
    ROUND(AVG(p.amount), 2) AS avg_order_value,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date,
    ROUND(JULIANDAY(MAX(o.order_date)) - JULIANDAY(MIN(o.order_date)), 0) AS customer_lifetime_days
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'Completed'
GROUP BY c.customer_id, c.name, c.registration_date
ORDER BY lifetime_value DESC;

-- =====================================================
-- 7. Order Status Distribution
-- =====================================================
SELECT 
    o.status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders o
GROUP BY o.status
ORDER BY order_count DESC;

-- =====================================================
-- 8. Payment Method Analysis
-- =====================================================
SELECT 
    p.payment_method,
    COUNT(*) AS transaction_count,
    ROUND(SUM(p.amount), 2) AS total_amount,
    ROUND(AVG(p.amount), 2) AS avg_amount,
    COUNT(CASE WHEN p.status = 'Completed' THEN 1 END) AS completed_count,
    COUNT(CASE WHEN p.status = 'Failed' THEN 1 END) AS failed_count
FROM payments p
GROUP BY p.payment_method
ORDER BY total_amount DESC;

-- =====================================================
-- 9. Low Stock Products
-- =====================================================
SELECT 
    product_id,
    name,
    category,
    stock_quantity,
    price,
    CASE 
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity < 10 THEN 'Critical'
        WHEN stock_quantity < 50 THEN 'Low'
        ELSE 'OK'
    END AS stock_status
FROM products
WHERE stock_quantity < 50
ORDER BY stock_quantity ASC;

-- =====================================================
-- 10. Top Selling Products by Quantity
-- =====================================================
SELECT 
    p.product_id,
    p.name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    COUNT(DISTINCT oi.order_id) AS times_ordered,
    ROUND(p.price, 2) AS current_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN payments pay ON o.order_id = pay.order_id
WHERE pay.status = 'Completed'
GROUP BY p.product_id, p.name, p.category, p.price
ORDER BY total_quantity_sold DESC
LIMIT 15;

