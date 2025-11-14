"""Test script to verify database integrity and run sample queries."""

import sqlite3

print("=" * 60)
print("DATABASE VERIFICATION & TESTING")
print("=" * 60)

# Connect to database
conn = sqlite3.connect('ecommerce.db')
cursor = conn.cursor()

# Test 1: Count records in each table
print("\n1. RECORD COUNTS:")
print("-" * 60)
tables = ['customers', 'products', 'orders', 'order_items', 'payments']
for table in tables:
    cursor.execute(f'SELECT COUNT(*) FROM {table}')
    count = cursor.fetchone()[0]
    print(f"  {table:15} : {count:>6} records")

# Test 2: Verify relationships
print("\n2. RELATIONSHIP VERIFICATION:")
print("-" * 60)
cursor.execute("""
    SELECT COUNT(*) 
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
""")
valid_orders = cursor.fetchone()[0]
print(f"  Orders with valid customers: {valid_orders}")

cursor.execute("""
    SELECT COUNT(*) 
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
""")
valid_items = cursor.fetchone()[0]
print(f"  Order items with valid orders/products: {valid_items}")

cursor.execute("""
    SELECT COUNT(*) 
    FROM payments p
    JOIN orders o ON p.order_id = o.order_id
""")
valid_payments = cursor.fetchone()[0]
print(f"  Payments with valid orders: {valid_payments}")

# Test 3: Top 5 Customers by Total Spend
print("\n3. TOP 5 CUSTOMERS BY TOTAL SPEND:")
print("-" * 60)
cursor.execute("""
    SELECT 
        c.customer_id,
        c.name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(p.amount), 2) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    WHERE p.status = 'Completed'
    GROUP BY c.customer_id, c.name
    ORDER BY total_spent DESC
    LIMIT 5
""")
results = cursor.fetchall()
for row in results:
    print(f"  ID: {row[0]:3} | {row[1]:30} | Orders: {row[2]:2} | Total: ${row[3]:>10}")

# Test 4: Total Revenue by Product Category
print("\n4. REVENUE BY PRODUCT CATEGORY:")
print("-" * 60)
cursor.execute("""
    SELECT 
        p.category,
        ROUND(SUM(oi.quantity * oi.price * (1 - oi.discount)), 2) AS category_revenue,
        SUM(oi.quantity) AS total_units_sold
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    JOIN payments pay ON o.order_id = pay.order_id
    WHERE pay.status = 'Completed'
    GROUP BY p.category
    ORDER BY category_revenue DESC
    LIMIT 5
""")
results = cursor.fetchall()
for row in results:
    print(f"  {row[0]:20} | Revenue: ${row[1]:>10} | Units: {row[2]:>6}")

# Test 5: Monthly Sales Summary
print("\n5. MONTHLY SALES SUMMARY (Last 6 Months):")
print("-" * 60)
cursor.execute("""
    SELECT 
        strftime('%Y-%m', o.order_date) AS month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(p.amount), 2) AS total_revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE p.status = 'Completed'
    GROUP BY strftime('%Y-%m', o.order_date)
    ORDER BY month DESC
    LIMIT 6
""")
results = cursor.fetchall()
for row in results:
    print(f"  {row[0]} | Orders: {row[1]:>4} | Revenue: ${row[2]:>10}")

# Test 6: Sample Order with Full Details
print("\n6. SAMPLE ORDER WITH FULL DETAILS:")
print("-" * 60)
cursor.execute("""
    SELECT 
        c.name AS customer_name,
        o.order_id,
        o.order_date,
        p.payment_method,
        p.amount,
        COUNT(oi.item_id) AS item_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.order_id, c.name, o.order_date, p.payment_method, p.amount
    ORDER BY o.order_date DESC
    LIMIT 3
""")
results = cursor.fetchall()
for row in results:
    print(f"  Order #{row[1]} | {row[0]} | {row[2][:10]} | {row[3]:15} | ${row[4]:>8} | Items: {row[5]}")

print("\n" + "=" * 60)
print("✓ ALL TESTS COMPLETED SUCCESSFULLY!")
print("=" * 60)

conn.close()

