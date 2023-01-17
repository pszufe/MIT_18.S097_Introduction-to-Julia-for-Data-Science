using Genie
using Genie.Requests, Genie.Renderer.Json
using BSON: @load
using GLM
using DataFrames
using LinearAlgebra
using MLJ

Genie.Configuration.config!(
  server_port                     = 8000,
  server_host                     = "0.0.0.0",
  app_env                         = "prod"
)

# println(Genie.Configuration.env())

# load pipeline transformations and model
pip = machine("preprocessing.mlj")
restore!(pip)
@load "linear_model.bson" linear_model

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
    println(input_data)
     try
         pre_data = MLJ.transform(pip, DataFrame(input_data))
         (":input" => input_data, ":prediction" => GLM.predict(linear_model, pre_data)) |> Json.json
     catch e
         (:error => "Ooops! There was a problem while generating a prediction.") |> Json.json
     end
end


up(host="0.0.0.0", async=false)