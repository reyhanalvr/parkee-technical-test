#!/bin/bash
# Jalankan script dengan super user(sudo)

# Check parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: sudo $0 <string_unique_public_key> <username>"
    exit 1
fi

# Variable
string_unique=$1
username=$2

# Memeriksa apakah user ada di sistem
if ! id "$username" &>/dev/null; then
    echo "User $username tidak ditemukan."
    exit 1
fi

# Path authorized keys
user_home=$(eval echo "~$username")
authorized_keys="$user_home/.ssh/authorized_keys"

if [ ! -f "$authorized_keys" ]; then
    echo "File $authorized_keys tidak ditemukan untuk user $username."
    exit 1
fi

# Memeriksa apakah parameter string unique ada dalam authorized_keys
if ! grep -q "$string_unique" "$authorized_keys"; then
    echo "Public key yang mengandung '$string_unique' tidak ditemukan di $authorized_keys."
    exit 1
fi

# Membuat backup file authorized_keys
cp "$authorized_keys" "$authorized_keys.bak"

# Mengecualikan variable string_unique dengan grep -v
echo "Menghapus public key yang mengandung '$string_unique' dari $authorized_keys..."
grep -v "$string_unique" "$authorized_keys.bak" > "$authorized_keys"

if [ $? -eq 0 ]; then
    echo "Public key yang mengandung '$string_unique' berhasil dihapus dari $authorized_keys."
    echo "Backup file authorized_keys sebelum penghapusan disimpan sebagai $authorized_keys.bak"
else
    echo "Gagal menghapus public key dari $authorized_keys."
    exit 1
fi

