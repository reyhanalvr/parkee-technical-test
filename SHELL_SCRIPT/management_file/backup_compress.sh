#!/bin/bash

# Checking parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <direktori_sumber> <lokasi_backup>"
    exit 1
fi

direktori_sumber=$1
lokasi_backup=$2

if [ ! -d "$direktori_sumber" ]; then
    echo "Direktori sumber $direktori_sumber tidak ditemukan."
    exit 1
fi

# Membuat nama file backup berdasarkan tanggal saat ini
nama_backup=$(basename "$direktori_sumber")_$(date +%Y%m%d_%H%M%S).tar.gz

#lokasi_backup="${lokasi_backup%/}"

# Membuat direktori backup jika belum ada
mkdir -p "$lokasi_backup"

# Membuat backup dan compress file
echo "Membuat backup dari $direktori_sumber ke $lokasi_backup/$nama_backup"
tar -czvf "$lokasi_backup/$nama_backup" -C "$direktori_sumber" .

# Mengecek apakah proses backup berhasil
if [ $? -eq 0 ]; then
    echo "Backup berhasil disimpan di $lokasi_backup/$nama_backup"
else
    echo "Backup gagal."
    exit 1
fi

