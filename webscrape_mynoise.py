# mynoise.py

def get_urls(driver):
    return driver.execute_script("""
        return sourceFileA.concat(sourceFileB);
    """)

