using HTTP
using JSON

raw_data = JSON.parsefile("test_raw_data.json")

println(" \n REQUEST BODY: $raw_data  \n")

headers = Dict(
    "Accept" => "application/json",
    "Content-Type"=> "application/json")

resp = HTTP.post("http://3.235.124.12:8000", headers=headers, body = raw_data |> json)

println("\n RESPONSE: \n")
if resp.status == 200 
    println(String(resp.body)) 
    println(resp.headers)
else println("wrong page")
end


