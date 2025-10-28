import requests
from bs4 import BeautifulSoup
import pandas as pd
from tabulate import tabulate

def scrape_olx(url, limit=10):
    headers = {"User-Agent": "Mozilla/5.0"}
    r = requests.get(url, headers=headers)
    soup = BeautifulSoup(r.text, "html.parser")

    items = []
    ads = soup.select("li[data-aut-id='itemBox']") or soup.select("a[data-aut-id='itemTitle']")

    for ad in ads[:limit]:
        title_tag = ad.select_one("h6") or ad.select_one("a[title]")
        price_tag = ad.select_one("span[data-aut-id='itemPrice']")
        title = title_tag.get_text(strip=True) if title_tag else "N/A"
        price = price_tag.get_text(strip=True) if price_tag else "N/A"
        desc = "Description not fetched (requires details page)"
        items.append({"Title": title, "Price": price, "Description": desc})

    df = pd.DataFrame(items)
    print(tabulate(df, headers="keys", tablefmt="github", showindex=False))
    df.to_csv("olx_results.csv", index=False)
    print("\nSaved results to olx_results.csv")

if __name__ == "__main__":
    url = "https://www.olx.in/items/q-car-cover?isSearchCall=true"
    scrape_olx(url, limit=10)
