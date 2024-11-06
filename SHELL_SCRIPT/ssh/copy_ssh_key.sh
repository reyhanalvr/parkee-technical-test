if [ "$#" -lt 3 ]; then
	echo "Penggunaan: $0 <file_public_key> <username> <ip_address_server> "
	exit 1
fi

file_public_key=$1
username=$2
ip_address=$3

# Check pub key
if [ ! -f "$file_public_key" ]; then
    echo "File public key $file_public_key tidak ditemukan."
    exit 1
fi

# Copy pub key ke server remote
echo "Menyalin public key ke server $username@$ip_address..."
ssh-copy-id -i "$file_public_key" "$username@$ip_address"

if [ $? -eq 0 ]; then
    echo "Public key berhasil disalin ke $username@$ip_address."
else
    echo "Gagal menyalin public key ke server."
    exit 1
fi
