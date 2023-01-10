using Genie, Genie.Requests, Genie.Renderer.Json
using BSON: @load
using DataFrames
using LinearAlgebra
using GLM

@load "reg.bson" linear_model

route("/") do
"""<div style="white-space:pre">To receive a prediction for GLM linear model send POST request with JSON payload.

Example row:
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
    try
        (":input" => input_data,":prediction" => predict(linear_model, DataFrame(input_data))) |> Json.json
    catch e
        (:error => "Ooops! There was a problem while generating a prediction.") |> Json.json
    end
end


up(port=8000, async=false)