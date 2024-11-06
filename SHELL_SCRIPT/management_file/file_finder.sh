#!/bin/bash

# Checking parameter
if [ "$#" -lt 2 ]; then
    echo "Penggunaan: $0 <direktori> <ekstensi file>"
    exit 1
fi

# Variable
direktori=$1
ekstensi=$2

# Check direktori ditemukan atau tidak
if [ ! -d "$direktori" ]; then
    echo "Direktori $direktori tidak ditemukan."
    exit 1
fi

# Mencari file dengan ekstensi di paramter yang diinput
echo "Mencari file dengan ekstensi .$ekstensi di direktori $direktori"
find "$direktori" -type f -name "*.$ekstensi" -print

