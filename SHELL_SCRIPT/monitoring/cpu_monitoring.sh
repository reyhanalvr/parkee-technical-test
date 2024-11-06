#!/bin/bash

log_file="/var/log/cpu_usage.log"

# Check log file sudah ada atau belum
if [ ! -w "$log_file" ]; then
    sudo touch "$log_file"
    sudo chmod 666 "$log_file"
fi

# Looping 
while true; do
    # Rata-rata penggunaan CPU 1 menit
    cpu_load=$(awk '{print $1}' < /proc/loadavg)

    # Ambil jumlah CPU (Buat Hitung Threshold)
    cpu_count=$(grep -c ^processor /proc/cpuinfo)
    load_threshold=$(echo "0.75 * $cpu_count" | bc)

    # Jika CPU load melebihi threshold, akan dicatat ke log
    if (( $(echo "$cpu_load > $load_threshold" | bc -l) )); then
        echo "$(date): CPU load is $cpu_load, which is above threshold $load_threshold." >> "$log_file"
    fi

    # Print output CPU Load
    echo "$(date): Current CPU load is $cpu_load"

    sleep 10
done

