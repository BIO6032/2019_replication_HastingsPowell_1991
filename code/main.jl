import Pkg; Pkg.activate(".")

using ParameterizedFunctions
using Plots
using DifferentialEquations

include("HPmodel.jl")

# Make the figures
for figfile in filter(f -> isfile(f)&startswith(f, "figure"), readdir())
    @info "Running $figfile"
    include(figfile)
end
