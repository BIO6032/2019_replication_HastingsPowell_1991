#### Teacup GIF
## Inspired by an example of Lorez attractor: http://docs.juliaplots.org/latest/
## FFmpeg has to be installed prior to running the code

## Preparation

# Activate project environment
import Pkg; Pkg.activate(".")

# Load required packages
using ParameterizedFunctions
using Plots
using DifferentialEquations

# Load Hastings & Powell's model
include("HPmodel.jl")

## Produce the GIF

# define the model
mutable struct TeaCup
    dt; a1; a2; b1; b2; d1; d2; x; y; z
end

function step!(t::TeaCup)
    dx = t.x*(1-t.x) - t.a1*t.x*t.y/(1 + t.b1*t.x)     ; t.x += t.dt * dx
    dy = t.a1*t.x*t.y/(1 + t.b1*t.x) - t.a2*t.y*t.z/(1 + t.b2*t.y) - t.d1*t.y ; t.y += t.dt * dy
    dz = t.a2*t.y*t.z/(1 + t.b2*t.y) - t.d2*t.z   ; t.z += t.dt * dz
end

# solution from initial values
TeaCup_sol = TeaCup((dt = 0.05, a1 = 5.0, a2 = 0.1, b1 = 3.0, b2 = 2.0, d1 = 0.4, d2 = 0.01, x = 0.76, y = 0.16, z = 9.9)...)


# initialize a 3D plot with 1 empty series
# requires same trick to flip axis Y as for figure2D
plt = plot3d(1, xlabel = "x", xlim = (0.0, 1.0), xticks = 0.0:0.5:1.0, xrotation = 30.0,
                ylabel = "y", ylim = (0.0, 0.5), yticks = (0.0:0.25:0.5, string.(0.5:-0.25:0.0)), yrotation = -10.0,
                zlabel = "z", zlim = (7.5, 10.5), zticks = 7.5:1.5:10.5, zrotation = 0.0,
                linewidth = 0.1,
                marker = :none, legend = :none, size = (600, 600), c = :black,
                right_margin = 5Plots.mm, left_margin = 2Plots.mm,
                )

# build an animated gif by pushing new points to the plot, saving every 20th frame
anim = @animate for i = 1:30000
    step!(TeaCup_sol)
    push!(plt, TeaCup_sol.x, (0.5 - TeaCup_sol.y), TeaCup_sol.z)
end every 20
gif(anim, joinpath("..", "article", "figures", "figure2D.gif"), fps = 40)
