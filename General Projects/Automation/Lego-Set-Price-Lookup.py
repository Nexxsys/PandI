import requests
from bs4 import BeautifulSoup
import csv

# Base URL of the website
base_url = "https://www.brickeconomy.com/set/"

# List of set numbers
list_of_sets = [70638, 71709, 75957, 70663, 70333, 71699, 42072, 75945, 75946, 76100, 75206, 61047, 76083, 76058, 75167, 60156, 60083, 31028, 60135, 60151, 60085, 60002, 60105, 60193, 70674, 21160, 60148, 76076, 70622, 10673, 75169, 10659, 60119, 42059, 31055, 10754, 10659, 60206, 75173]

# Define headers to mimic a browser request
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
}

# Prepare to write to CSV
csv_file = open('c:\\Users\\tmloh\\Py-Dev\\lego-pricing\\set_prices.csv', 'w', newline='', encoding='utf-8')
csv_writer = csv.writer(csv_file)
csv_writer.writerow(['Set Number', 'Price', 'UPC'])

# Loop through each set number, fetch the price and UPC, and write to CSV
for set_number in list_of_sets:
    full_url = f"{base_url}{set_number}-1/"
    response = requests.get(full_url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        price_div = soup.find("div", class_="col-xs-7 set-price-ca")
        upc_div = soup.find("div", class_="col-xs-5 text-muted", text="UPC").find_next_sibling("div", class_="col-xs-7")

        if price_div:
            price = price_div.text.strip()
        else:
            price = "Not Found"

        if upc_div:
            upc = upc_div.text.strip()
        else:
            upc = "Not Found"

        print(f"Writing set {set_number} with price {price} and UPC {upc} to CSV...")
        csv_writer.writerow([set_number, price, upc])
    else:
        print(f"Failed to fetch set {set_number}, status code: {response.status_code}")

csv_file.close()
print("CSV file has been written successfully.")
