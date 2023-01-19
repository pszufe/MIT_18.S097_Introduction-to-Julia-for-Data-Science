import requests
import json

mode = "AWS" 

with open('test_raw_data.json') as f:
    data = json.load(f)

url = "http://3.235.124.12:8000" if mode=="AWS" else "http://localhost:8000"     

req=requests.post(url, json=data)

if mode == "AWS":
    print(req.status_code)
    print(json.dumps(req.json(), indent=4))
else: 
    print(req.status_code)
    print(req.text)