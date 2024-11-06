#!/bin/bash

# Check parameter
if [ $# -lt 3 ]; then
	echo "Penggunaan: $0 <file_source> <username> <ip_address_remote>"
	exit 1
fi

#Variable
file_source=$1
username=$2
ip_address=$3

# Copy file dengan Rsync
echo "Copy file menggunakan Rsync..."
rsync -avz "$file_source" "$username@$ip_address:~/"

if [ $? -eq 0 ]; then
    echo "File berhasil dicopy menggunakan Rsync."
else
    echo "Gagal copy menggunakan Rsync."
fi
