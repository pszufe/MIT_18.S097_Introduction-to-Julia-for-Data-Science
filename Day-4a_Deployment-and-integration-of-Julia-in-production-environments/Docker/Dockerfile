# pull julia image
FROM julia:1.8.5

# set up the app
WORKDIR /home/app
# copy julia env files
COPY Project.toml Manifest.toml /home/app
# copy application and model files
COPY app.jl linear_regression.bson /home/app

# Create and prepare Julia env
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate();'

# ports
#EXPOSE 5050
# run app
CMD julia -e 'using Pkg; Pkg.activate("."); ;include("app.jl");'
