# pull julia image
FROM julia:1.8.3

# set up the app
WORKDIR /home/app
COPY . /home/app


# Prepare Julia env
RUN julia -e "using Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.precompile(); "

# ports
EXPOSE 8000
# run julia app
CMD julia -e 'using Pkg; Pkg.activate("."); include("app.jl"); '
