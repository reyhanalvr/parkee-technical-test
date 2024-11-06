import pandas as pd

branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')

# Gabungkan semua DF menjadi satu
df = pd.concat([branch_a, branch_b, branch_c], ignore_index=True)

df.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)

df['date'] = pd.to_datetime(df['date'], errors='coerce')

df.sort_values(by='date', ascending=False, inplace=True)
df.drop_duplicates(subset='transaction_id', keep='first', inplace=True)

df['total_sales'] = df['quantity'] * df['price']  # Menghitung total untuk setiap transaksi
total_sales_per_branch = df.groupby('branch')['total_sales'].sum().reset_index()

total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

print("Data processing complete. The total sales per branch have been saved to 'total_sales_per_branch.csv'.")

