#!/bin/bash
# Jalankan Script dengan super user(sudo) 

# Check parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: sudo $0 <file_public_key> <username>"
    exit 1
fi

# Variable
file_public_key=$1
username=$2

# Check file public key ditemukan atau tidak
if [ ! -f "$file_public_key" ]; then
    echo "File public key $file_public_key tidak ditemukan."
    exit 1
fi

# Memeriksa apakah user ada di sistem
if ! id "$username" &>/dev/null; then
    echo "User $username tidak ditemukan."
    exit 1
fi

# Menentukan home directory dari user dan path ke authorized_keys
user_home=$(eval echo "~$username")
ssh_dir="$user_home/.ssh"
authorized_keys="$ssh_dir/authorized_keys"

# Membuat direktori .ssh jika belum ada, dengan permission yang benar
if [ ! -d "$ssh_dir" ]; then
    echo "Membuat direktori $ssh_dir..."
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
    chown "$username:$username" "$ssh_dir"
fi

# Menambahkan public key ke authorized_keys jika belum ada
if grep -Fxq -f "$file_public_key" "$authorized_keys"; then
    echo "Public key sudah ada di $authorized_keys."
else
    echo "Menambahkan public key ke $authorized_keys..."
    cat "$file_public_key" >> "$authorized_keys"
    chmod 600 "$authorized_keys"
    chown "$username:$username" "$authorized_keys"
    echo "Public key berhasil ditambahkan ke $authorized_keys."
fi

