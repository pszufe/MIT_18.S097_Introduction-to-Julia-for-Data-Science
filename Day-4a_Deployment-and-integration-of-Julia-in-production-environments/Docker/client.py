import requests
import json

with open('test_raw_data.json') as f:
    data = json.load(f)

req=requests.post("http://localhost:8000", json=data)

print(req.status_code)
print(json.dumps(req.json(), indent=4))