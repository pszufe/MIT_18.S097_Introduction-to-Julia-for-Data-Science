using PyCall
req = pyimport("requests")
j = pyimport("json")

with open("house.json") as f:
    data = j.load(f)

r = req.post("http://127.0.0.1:8000", json=data)
print(r.status_code)
print(j.dupms(r.json(), indent=4))
