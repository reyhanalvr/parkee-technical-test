#!/bin/bash

# Path logfile
log_file="/var/log/disk_usage.log"

# Threshold
threshold=80

# Check logfile bisa diedit atau tidak, kalau tidak buat log file baru
if [ ! -w "$log_file" ]; then
    sudo touch "$log_file"
    sudo chmod 666 "$log_file"
fi

# Looping
while true; do
    # Mengambil penggunaan untuk setiap mount point
    disk_usage=$(df -h --output=pcent,target | grep -vE '^Use%' | awk '{print $1 " " $2}')

    echo "Checking disk usage..."

    echo "$disk_usage" | while read -r usage mount_point; do
    	# Menghilangkan % dari disk usage
        usage=$(echo $usage | tr -d '%')

        if [ "$usage" -gt "$threshold" ]; then
	
	    message="Disk usage on $mount_point is ${usage}% which is above the threshold of ${threshold}%."
            echo "$(date): $message" >> "$log_file"

            # Menggunakan wsl-notify-send untuk mengirimkan notifikasi
	    (cd ~ && /mnt/c/Tools/wsl-notify-send.exe --appId "wsl-notify" -c "Disk Usage" "$message")
        fi
    done

    sleep 60
done

