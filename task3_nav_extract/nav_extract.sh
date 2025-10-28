import csv, json

with open("nav.tsv", newline="", encoding="utf-8") as tsv:
    reader = csv.reader(tsv, delimiter="\t")
    data = [{"Scheme Name": row[0], "Asset Value": row[1]} for row in reader]

with open("nav.json", "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)

print(" Saved nav.json")
