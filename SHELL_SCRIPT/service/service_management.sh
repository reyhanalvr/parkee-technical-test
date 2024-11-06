#!/bin/bash

# Check paramater
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <tindakan> <nama_service>"
    echo "Tindakan yang valid: start, stop, status"
    exit 1
fi

# Variable
tindakan=$1
nama_service=$2

# Jalankan script berdasarkan parameter tindakan
case $tindakan in
    start)
        echo "Memulai service $nama_service..."
        sudo systemctl start $nama_service
        ;;
    stop)
        echo "Menghentikan service $nama_service..."
        sudo systemctl stop $nama_service
        ;;
    status)
        echo "Memeriksa status service $nama_service..."
        sudo systemctl status $nama_service
        ;;
    *)
        echo "Tindakan tidak valid. Gunakan start, stop, atau status."
        exit 1
        ;;
esac

