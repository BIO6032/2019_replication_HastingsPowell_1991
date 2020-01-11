import Pkg; Pkg.activate(".")

using ParameterizedFunctions
using Plots
using DifferentialEquations

include("HPmodel.jl")

# Make the figures
include("figure2.jl")
