#!/bin/bash

# Checking parameter
if [ "$#" -lt 1 ]; then
    echo "Penggunaan: $0 <direktori>"
    exit 1
fi

direktori=$1

if [ ! -d "$direktori" ]; then
    echo "Direktori $direktori tidak ditemukan."
    exit 1
fi

# Header buat tabel
printf "%-30s %-10s %-10s %-10s\n" "Nama File" "Baris" "Kata" "Karakter"
printf "%-30s %-10s %-10s %-10s\n" "------------------------------" "--------" "--------" "----------"

# Loop untuk semua file .txt dalam direktori
for file in "$direktori"/*.txt; do
    if [ -f "$file" ]; then
        # Menggunakan wc untuk menghitung baris, kata, dan karakter
        baris=$(wc -l < "$file")
        kata=$(wc -w < "$file")
        karakter=$(wc -m < "$file")
        
        printf "%-30s %-10d %-10d %-10d\n" "$(basename "$file")" "$baris" "$kata" "$karakter"
    fi
done

