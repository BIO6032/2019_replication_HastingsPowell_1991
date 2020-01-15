# Scripts assume that `code/` is used as working directory
# From project root, it can be set with
# cd("./code/")
# or in Atom: right-click code/ > Juno:Work in folder

# Activate project environment
import Pkg; Pkg.activate(".")

# Load required packages
using ParameterizedFunctions
using Plots
using DifferentialEquations

# Load Hastings & Powell's model
include("HPmodel.jl")

# Make the figures
for figfile in filter(f -> isfile(f)&startswith(f, "figure"), readdir())
    @info "Running $figfile"
    include(figfile)
end
