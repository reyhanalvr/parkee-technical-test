#!/bin/bash

# Checking parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <direktori_sumber> <lokasi_backup>"
    exit 1
fi

#Variable
direktori_sumber=$1
lokasi_backup=$2

# Check direktori ditemukan atau tidak
if [ ! -d "$direktori_sumber" ]; then
    echo "Direktori sumber $direktori_sumber tidak ditemukan."
    exit 1
fi

# Membuat nama file backup berdasarkan tanggal saat ini
nama_backup=$(basename "$direktori_sumber")_$(date +%Y%m%d_%H%M%S).tar.gz

# Membuat direktori backup jika belum ada
mkdir -p "$lokasi_backup"

# Membuat backup dan compress file
echo "Membuat backup dari $direktori_sumber ke $lokasi_backup/$nama_backup"
tar -czvf "$lokasi_backup/$nama_backup" -C "$direktori_sumber" .

# Validasi proses script berhasil atau tidak
if [ $? -eq 0 ]; then
    echo "Backup berhasil disimpan di $lokasi_backup/$nama_backup"
else
    echo "Backup gagal."
    exit 1
fi

# Menghapus backup yang lebih lama dari 7 hari
echo "Menghapus backup yang lebih lama dari 7 hari di $lokasi_backup"
find "$lokasi_backup" -name "$(basename "$direktori_sumber")_*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

