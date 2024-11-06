#!/bin/bash

# Check parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <username> <ip_address_server>"
    exit 1
fi

# Variable
username=$1
ip_address=$2

# Check koneksi SSH dengan mode quiet dan BatchMode=yes untuk non interaktif
echo "Menguji koneksi SSH ke server $username@$ip_address..."
ssh -q -o BatchMode=yes "$username@$ip_address" exit

if [ $? -eq 0 ]; then
    echo "Koneksi SSH ke $username@$ip_address berhasil."
else
    echo "Koneksi SSH ke $username@$ip_address gagal."
fi

