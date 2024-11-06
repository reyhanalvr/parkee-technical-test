import pandas as pd

# Membaca data dari CSV
branch_a = pd.read_csv('branch_a.csv')
branch_b = pd.read_csv('branch_b.csv')
branch_c = pd.read_csv('branch_c.csv')

# Gabungkan semua DataFrame menjadi satu
df = pd.concat([branch_a, branch_b, branch_c], ignore_index=True)

# Menghapus data dengan nilai NaN pada kolom dibawah
df.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)

# Ubah format row date menjadi datetime
df['date'] = pd.to_datetime(df['date'], errors='coerce')

# Menghilangkan duplikat berdasarkan transaction_id, lalu memilih data dengan tanggal paling baru
df.sort_values(by='date', ascending=False, inplace=True)
df.drop_duplicates(subset='transaction_id', keep='first', inplace=True)

# Menghitung total penjualan per cabang
df['total_sales'] = df['quantity'] * df['price']  # Menghitung total untuk setiap transaksi
total_sales_per_branch = df.groupby('branch')['total_sales'].sum().reset_index()

# Menyimpan hasil perhitungan ke file CSV
total_sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)

print("Data processing complete. The total sales per branch have been saved to 'total_sales_per_branch.csv'.")

