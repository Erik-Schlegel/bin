# In webscrape_script.py

import os
import requests
import importlib.util
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import argparse

# Function to download files from URLs
def download_files(urls, download_directory):
    for url in urls:
        file_name = os.path.join(download_directory, os.path.basename(url))
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            with open(file_name, 'wb') as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)

def import_module_from_file(module_name, file_path):
    spec = importlib.util.spec_from_file_location(module_name, file_path)
    if spec is None:
        return None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

# Setup command-line argument parsing
parser = argparse.ArgumentParser(description='Scrape .ogg files from a webpage.')
parser.add_argument('url', type=str, help='The URL of the page to scrape.')
parser.add_argument('-o', '--output', type=str, help='The output folder to save the files.')
parser.add_argument('-s', '--selector', type=str, help='The selector module to use.', default='webscrape_mynoise.py')

args = parser.parse_args()
if args.selector:
    selector_module_path = os.path.join(os.path.expanduser('~/bin'), args.selector)
else:
    selector_module_path = os.path.join(os.path.expanduser('~/bin'), 'webscrape_mynoise.py')

selector_module = import_module_from_file('selector', selector_module_path)

# Setup headless chrome options
chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

# Initialize the webdriver
driver = webdriver.Chrome(options=chrome_options)

# Open the URL
driver.get(args.url)

# Wait for the JavaScript to load resources
driver.implicitly_wait(10)  # Adjust the wait time if necessary

# Extract URLs using the selector module
selectedUrls = selector_module.get_urls(driver)

# Define the directory where files will be saved
download_directory = args.output if args.output else os.path.join(os.getcwd(), 'downloaded_files')

# Create the directory to save the files if it does not exist
os.makedirs(download_directory, exist_ok=True)

# Download files
download_files(selectedUrls, download_directory)

# Close the browser
driver.quit()