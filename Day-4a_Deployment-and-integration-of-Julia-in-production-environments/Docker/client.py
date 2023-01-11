import requests
import json

with open('house.json') as f:
    data = json.load(f)

req=requests.post("http://127.0.0.1:8000", json=data)

print(req.status_code)
print(json.dumps(req.json(), indent=4))
