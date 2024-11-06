#!/bin/bash

# Pastikan script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan sebagai root"
  echo "Penggunaan: sudo $0"
  exit
fi

# Lokasi file konfigurasi netplan
netplan_config="/etc/netplan/01-netcfg.yaml"
sudo chmod 600 $netplan_config

# Konfigurasi jaringan dengan netplan
echo "Mengkonfigurasi jaringan dengan netplan..."

cat << EOF > $netplan_config
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

netplan apply

echo "Konfigurasi jaringan selesai. IP address telah diatur ke 192.168.1.100, gateway ke 192.168.1.1, dan DNS ke 8.8.8.8 dan 8.8.4.4."
