"""
Generate Synthetic E-Commerce Data
Creates realistic CSV files for customers, products, orders, order_items, and payments.
"""

import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta
import os

# Initialize Faker
fake = Faker()
Faker.seed(42)  # For reproducibility
random.seed(42)

# Configuration
NUM_CUSTOMERS = 200
NUM_PRODUCTS = 50
NUM_ORDERS = 250
DATA_DIR = "data"

# Create data directory if it doesn't exist
os.makedirs(DATA_DIR, exist_ok=True)

print("Generating synthetic e-commerce data...")

# 1. Generate Customers
print("Generating customers...")
customers = []
for i in range(1, NUM_CUSTOMERS + 1):
    customers.append({
        'customer_id': i,
        'name': fake.name(),
        'email': fake.email(),
        'phone': fake.phone_number(),
        'address': fake.address().replace('\n', ', '),
        'city': fake.city(),
        'state': fake.state(),
        'zip_code': fake.zipcode(),
        'country': fake.country(),
        'registration_date': fake.date_between(start_date='-2y', end_date='today').isoformat()
    })

customers_df = pd.DataFrame(customers)
customers_df.to_csv(os.path.join(DATA_DIR, 'customers.csv'), index=False)
print(f"✓ Generated {len(customers_df)} customers")

# 2. Generate Products
print("Generating products...")
product_categories = ['Electronics', 'Clothing', 'Home & Garden', 'Books', 'Sports', 
                      'Toys', 'Health & Beauty', 'Food & Beverages', 'Automotive', 'Furniture']
products = []
for i in range(1, NUM_PRODUCTS + 1):
    products.append({
        'product_id': i,
        'name': fake.catch_phrase() + ' ' + random.choice(['Pro', 'Premium', 'Deluxe', 'Standard', 'Basic']),
        'category': random.choice(product_categories),
        'price': round(random.uniform(10, 500), 2),
        'cost': round(random.uniform(5, 250), 2),
        'stock_quantity': random.randint(0, 1000),
        'description': fake.text(max_nb_chars=200),
        'supplier': fake.company(),
        'created_date': fake.date_between(start_date='-3y', end_date='-1y').isoformat()
    })

products_df = pd.DataFrame(products)
products_df.to_csv(os.path.join(DATA_DIR, 'products.csv'), index=False)
print(f"✓ Generated {len(products_df)} products")

# 3. Generate Orders
print("Generating orders...")
order_statuses = ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled']
orders = []
start_date = datetime.now() - timedelta(days=730)  # 2 years ago

for i in range(1, NUM_ORDERS + 1):
    order_date = fake.date_time_between(start_date=start_date, end_date='now')
    orders.append({
        'order_id': i,
        'customer_id': random.randint(1, NUM_CUSTOMERS),
        'order_date': order_date.isoformat(),
        'status': random.choice(order_statuses),
        'shipping_address': fake.address().replace('\n', ', '),
        'shipping_city': fake.city(),
        'shipping_state': fake.state(),
        'shipping_zip': fake.zipcode()
    })

orders_df = pd.DataFrame(orders)
orders_df.to_csv(os.path.join(DATA_DIR, 'orders.csv'), index=False)
print(f"✓ Generated {len(orders_df)} orders")

# 4. Generate Order Items
print("Generating order items...")
order_items = []
item_id = 1

for order_id in range(1, NUM_ORDERS + 1):
    num_items = random.randint(1, 5)  # Each order has 1-5 items
    used_products = set()
    
    for _ in range(num_items):
        product_id = random.randint(1, NUM_PRODUCTS)
        while product_id in used_products:
            product_id = random.randint(1, NUM_PRODUCTS)
        used_products.add(product_id)
        
        product_price = products_df[products_df['product_id'] == product_id]['price'].values[0]
        quantity = random.randint(1, 5)
        
        order_items.append({
            'item_id': item_id,
            'order_id': order_id,
            'product_id': product_id,
            'quantity': quantity,
            'price': product_price,
            'discount': round(random.uniform(0, 0.2), 2)  # 0-20% discount
        })
        item_id += 1

order_items_df = pd.DataFrame(order_items)
order_items_df.to_csv(os.path.join(DATA_DIR, 'order_items.csv'), index=False)
print(f"✓ Generated {len(order_items_df)} order items")

# 5. Generate Payments
print("Generating payments...")
payment_methods = ['Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery']
payment_statuses = ['Completed', 'Pending', 'Failed', 'Refunded']

payments = []
for order_id in range(1, NUM_ORDERS + 1):
    # Calculate total amount for this order
    order_total = order_items_df[order_items_df['order_id'] == order_id]
    amount = (order_total['quantity'] * order_total['price'] * (1 - order_total['discount'])).sum()
    
    payment_date = orders_df[orders_df['order_id'] == order_id]['order_date'].values[0]
    payment_date_obj = datetime.fromisoformat(payment_date.replace('Z', '+00:00').split('+')[0])
    payment_date_obj += timedelta(hours=random.randint(0, 48))
    
    payments.append({
        'payment_id': order_id,  # One payment per order for simplicity
        'order_id': order_id,
        'payment_method': random.choice(payment_methods),
        'amount': round(amount, 2),
        'payment_date': payment_date_obj.isoformat(),
        'status': random.choice(payment_statuses),
        'transaction_id': fake.uuid4()
    })

payments_df = pd.DataFrame(payments)
payments_df.to_csv(os.path.join(DATA_DIR, 'payments.csv'), index=False)
print(f"✓ Generated {len(payments_df)} payments")

print("\n" + "="*50)
print("Data generation completed successfully!")
print("="*50)
print(f"\nGenerated files in '{DATA_DIR}/' directory:")
print("  - customers.csv")
print("  - products.csv")
print("  - orders.csv")
print("  - order_items.csv")
print("  - payments.csv")

