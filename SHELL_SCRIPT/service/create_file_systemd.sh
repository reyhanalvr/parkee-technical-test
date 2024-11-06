#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan sebagai root"
  echo "Penggunaan: sudo $0"
  exit
fi

# Membuat direktori untuk script Python jika belum ada
mkdir -p /usr/local/bin

# Membuat script Python sederhana
cat << 'EOF' > /usr/local/bin/simple_service.py
#!/usr/bin/env python3

import time

def main():
    while True:
        print("Service Parkee is running 123...")
        time.sleep(5)

if __name__ == "__main__":
    main()
EOF

# Memberikan izin eksekusi untuk script Python
chmod +x /usr/local/bin/simple_service.py

# Membuat file unit systemd
cat << 'EOF' > /etc/systemd/system/simple_service.service
[Unit]
Description=Simple Python Service
After=network.target

[Service]
ExecStart=/usr/bin/env python3 -u /usr/local/bin/simple_service.py
Restart=always
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Memuat ulang systemd untuk membaca file unit yang baru dibuat
systemctl daemon-reload

# Mengaktifkan service agar dijalankan saat booting
systemctl enable simple_service.service

echo "Service file created and enabled."

