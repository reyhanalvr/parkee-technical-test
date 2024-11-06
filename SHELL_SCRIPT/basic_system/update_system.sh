#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan sebagai root"
  echo "Penggunaan: sudo $0"
  exit
fi

log_file="/var/log/update_log_$(date +%Y%m%d_%H%M%S).log"

# Fungsi untuk melakukan update menggunakan 'apt'
update_apt() {
    echo "Menggunakan apt untuk memperbarui sistem..." | tee -a "$log_file"
    sudo apt update | tee -a "$log_file"
    sudo apt upgrade -y | tee -a "$log_file"
}

# Fungsi untuk melakukan update menggunakan 'yum'
update_yum() {
    echo "Menggunakan yum untuk memperbarui sistem..." | tee -a "$log_file"
    sudo yum update -y | tee -a "$log_file"
}

# Fungsi untuk melakukan update menggunakan 'dnf'
update_dnf() {
    echo "Menggunakan dnf untuk memperbarui sistem..." | tee -a "$log_file"
    sudo dnf update -y | tee -a "$log_file"
}

if command -v apt > /dev/null; then
    update_apt
elif command -v yum > /dev/null; then
    update_yum
elif command -v dnf > /dev/null; then
    update_dnf
else
    echo "Package manager tidak ditemukan. Script ini mendukung apt, yum, dan dnf." | tee -a "$log_file"
    exit 1
fi

echo "Pembaruan selesai. Hasil pembaruan dicatat dalam file log: $log_file"

