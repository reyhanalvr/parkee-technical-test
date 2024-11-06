#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "Penggunaan: #0 <direktori_penyimpanan_ssh>"
	exit 1
fi

direktori=$1

if [ ! -d "$direktori" ]; then
	echo "Direktori $direktori tidak ditemukan. Membuat direktori baru"
	mkdir -p "$direktori"
fi

# Membuat SSH Key
ssh_key_path="$direktori/id_rsa"
if ssh-keygen -t rsa -b 4096 -f "$ssh_key_path" -N ""; then
    echo "SSH Key berhasil dibuat dan disimpan di:"
    echo "Private Key: $ssh_key_path"
    echo "Public Key : ${ssh_key_path}.pub"
else
    echo "Gagal membuat SSH Key."
    exit 1
fi
