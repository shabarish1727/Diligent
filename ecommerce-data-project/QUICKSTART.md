# Quick Start Guide

Follow these steps to run the complete project.

## Step 1: Install Dependencies

```bash
pip install -r requirements.txt
```

## Step 2: Generate Synthetic Data

```bash
python generate_data.py
```

This will create CSV files in the `data/` folder:
- customers.csv
- products.csv
- orders.csv
- order_items.csv
- payments.csv

## Step 3: Ingest Data into SQLite

```bash
python ingest_to_sqlite.py
```

This creates the `ecommerce.db` database with all tables loaded.

## Step 4: Run SQL Queries

**Option A: Run all queries from file**
```bash
sqlite3 ecommerce.db < queries.sql
```

**Option B: Interactive SQLite shell**
```bash
sqlite3 ecommerce.db
```

Then paste queries from `queries.sql` or write your own.

**Option C: Run a specific query**
```bash
sqlite3 ecommerce.db "SELECT COUNT(*) FROM customers;"
```

## Git Setup & Push to GitHub

### If Git is installed:

```bash
# Navigate to project directory
cd ecommerce-data-project

# Initialize Git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: E-commerce data project with synthetic data generation and SQLite ingestion"

# Add your GitHub repository as remote (replace URL with your repo)
git remote add origin https://github.com/YOUR_USERNAME/ecommerce-data-project.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### If Git is not installed:

1. Download Git from: https://git-scm.com/downloads
2. Install Git
3. Restart your terminal
4. Follow the commands above

## Verification

To verify everything works:

```bash
# Check CSV files exist
dir data\*.csv

# Check database exists
dir ecommerce.db

# Test a query
sqlite3 ecommerce.db "SELECT COUNT(*) as customer_count FROM customers;"
```

## Troubleshooting

### "Module not found" error
- Make sure you installed requirements: `pip install -r requirements.txt`

### "data directory not found" error
- Run `generate_data.py` first to create the CSV files

### "sqlite3 command not found"
- On Windows, you may need to download SQLite separately or use Python:
  ```python
  import sqlite3
  conn = sqlite3.connect('ecommerce.db')
  cursor = conn.cursor()
  cursor.execute("SELECT * FROM customers LIMIT 5")
  print(cursor.fetchall())
  ```

## Next Steps

- Explore the queries in `queries.sql`
- Modify `generate_data.py` to customize data volume
- Add your own SQL queries
- Build visualizations with the data
- Create a web dashboard

