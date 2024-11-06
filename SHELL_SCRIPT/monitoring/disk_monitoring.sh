#!/bin/bash

log_file="/var/log/disk_usage.log"
threshold=80

if [ ! -w "$log_file" ]; then
    sudo touch "$log_file"
    sudo chmod 666 "$log_file"
fi

while true; do
    disk_usage=$(df -h --output=pcent,target | grep -vE '^Use%' | awk '{print $1 " " $2}')

    echo "Checking disk usage..."

    echo "$disk_usage" | while read -r usage mount_point; do
        usage=$(echo $usage | tr -d '%')

        if [ "$usage" -gt "$threshold" ]; then
            # Menggunakan wsl-notify-send dengan appId dan kategori
	    (cd ~ && /mnt/c/Tools/wsl-notify-send.exe --appId "wsl-notify" -c "Disk Usage" "Disk Usage Warning")
        fi
    done

    sleep 60
done

