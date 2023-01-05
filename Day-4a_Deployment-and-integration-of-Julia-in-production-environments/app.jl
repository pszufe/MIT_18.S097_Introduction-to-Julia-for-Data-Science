using Genie, Genie.Requests, Genie.Renderer.Json
using Flux
using BSON: @load
using DataFrames
using LinearAlgebra
using GLM


@load "nn_model.bson" model

@load "reg.bson" reg

route("/") do
"""<div style="white-space:pre">To receive a prediction send POST request with JSON payload.

Example:
>> curl -X POST -d @house.json -H "Content-Type: application/json" http://localhost:8000/
>> cat house.json
{
    "crim": 0.00632,
    "tax": 296.0,
    "chas": 0.0,
    "black": 396.9,
    "lstat": 4.98,
    "age": 65.2,
    "indus": 2.31,
    "rm": 6.575,
    "dis": 4.09,
    "zn": 18.0,
    "nox": 0.538,
    "ptratio": 15.3,
    "rad": 1.0
}</div>"""
end

route("/", method = POST) do
    
    input_data = jsonpayload()
    keys_json = keys(input_data)
    columns = ["CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT"]
    missing_fields = [k for k in columns if k ∉ keys_json]
    
    if length(missing_fields) != 0
        missing_str = join(missing_fields, ",")
        Json.json(:error => "The fields: $missing_str are missing from the JSON payload."*
            "The prediction can not be returned.")
    else
        try
            Json.json(Dict("input" => input_data,
                        "prediction" => model([input_data[f] for f in columns])[1])
                     )
        catch e
            Json.json(:error => "Ooops! There was a problem while generating a prediction.")
        end
    end
end

route("/glm") do
"""<div style="white-space:pre">To receive a prediction for GLM linear model send POST request with JSON payload.

First row:
{
    "crim": 0.00632,
    "tax": 296.0,
    "chas": 0.0,
    "black": 396.9,
    "lstat": 4.98,
    "age": 65.2,
    "indus": 2.31,
    "rm": 6.575,
    "dis": 4.09,
    "zn": 18.0,
    "nox": 0.538,
    "ptratio": 15.3,
    "rad": 1.0
}</div>"""
    
end

route("/glm", method = POST) do
    input_data = jsonpayload()
    try
        (":input" => input_data,":prediction" => predict(reg, DataFrame(input_data))) |> Json.json
    catch e
        (:error => "Ooops! There was a problem while generating a prediction.") |> Json.json
    end
end


#start the server - it will not block the Jupyter due to async=true
up(port=8000, async=true)