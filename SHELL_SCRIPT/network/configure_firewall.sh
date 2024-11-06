#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan sebagai root"
  echo "Penggunaan: sudo $0"
  exit
fi

echo "Mengatur aturan firewall dengan iptables..."

# Mengizinkan semua koneksi keluar
iptables -P OUTPUT ACCEPT

# Mengizinkan koneksi masuk ke port 22, 80, dan 443
iptables -A INPUT -p tcp --dport 22 -j ACCEPT   # SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT   # HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # HTTPS

# Menolak semua koneksi masuk selain port port diatas
iptables -P INPUT DROP

# Mengizinkan koneksi loopback (localhost)
iptables -A INPUT -i lo -j ACCEPT

# Menampilkan aturan firewall yang telah diterapkan
echo "Aturan firewall yang telah diterapkan:"
iptables -L -v

echo "Konfigurasi firewall selesai."

