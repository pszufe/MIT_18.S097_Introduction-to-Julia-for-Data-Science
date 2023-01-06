# pull latest julia image
FROM julia:latest

# set up the app
WORKDIR /home/app
COPY . /home/app

# instantiate Julia packages
RUN julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile(); "

# ports
EXPOSE 8000

# or maybe include a Julia file
CMD julia -e 'using Pkg; Pkg.activate("."); include("regression.jl"); '
