#!/usr/bin/python3

import pandas as pd
import requests

# Function untuk mengambil data dari api
def fetch_universities(country_keyword):
    # URL API
    url = f"http://universities.hipolabs.com/search?country={country_keyword}"

    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
    else:
        print("Error fetching data from API:", response.status_code)
        return None
    
    return data

# Function untuk memproses data
def process_universities_data(country_keyword):

    # Mengambil data dari API
    universities_data = fetch_universities(country_keyword)
    
    if universities_data is None:
        return
    
    # Membuat Dataframe
    df = pd.DataFrame(universities_data)
    
    # Filter kolom name | web pages | country | domain | state province
    df_filtered = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
    
    # Menghapus row yang tidak punya data "state-province"
    df_filtered = df_filtered[df_filtered['state-province'].notna()]
    pd.set_option('display.max_rows', None)
    
    print(df_filtered)

# Parameter pencarian - country
country_keyword = input("Masukkan keyword untuk negara: ")
process_universities_data(country_keyword)

