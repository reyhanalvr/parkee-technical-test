#!/bin/bash

# Print Output Nama Host
echo "Nama Host:"
hostname

# Print Output Waktu Sistem
echo -e "\nWaktu Sistem Saat Ini:"
date

# Print Output Jumlah Pengguna
echo -e "\nJumlah Pengguna yang Sedang Login:"
who | wc -l

