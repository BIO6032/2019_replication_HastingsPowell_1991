# Scripts assume that `code/` is used as working directory
# From project root, it can be set with
# cd("./code/")
# or in Atom: right-click code/ > Juno:Work in folder

# Activate project environment
import Pkg; Pkg.activate(".")

# Load required packages
@info "Loading required packages"
using DifferentialEquations
using Plots
using LaTeXStrings

# Load Hastings & Powell's model
@info "Loading model"
include("HPmodel.jl")

# Make the figures
for figfile in filter(f -> isfile(f) && startswith(f, "figure") && !endswith(f, "gif.jl"), readdir())
    @info "Running $figfile"
    include(figfile)
end
