#!/bin/bash


# Nama Host
echo "Nama Host:"
hostname

# Uptime
echo -e "\nWaktu Sistem Saat Ini:"
date

# Jumlah Pengguna
echo -e "\nJumlah Pengguna yang Sedang Login:"
who | wc -l

