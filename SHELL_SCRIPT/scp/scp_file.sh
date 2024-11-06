if [ $# -lt 3 ]; then
	echo "Penggunaan: $0 <file_source> <username> <ip_address_remote>"
	exit 1
fi

file_source=$1
username=$2
ip_address=$3

echo "Menyalin file dengan SCP"
scp -r "$file_source" "$username@$ip_address:~/"

if [ $? -eq 0 ]; then
    echo "File berhasil disalin menggunakan SCP."
else
    echo "Gagal menyalin file menggunakan SCP."
fi
