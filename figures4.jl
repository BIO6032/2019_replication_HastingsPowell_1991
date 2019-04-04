### Hastings & Powell 1991
## Reproducing figure 4

### Figure 4 (Bifurcation diagram)

# Load model
include("HPmodel.jl")

# Packages
using Plots, DifferentialEquations

## Define initial parameters
p = a1,a2,b1,b2,d1,d2 = [5.0,0.1,2.0,2.0,0.4,0.01]
u0 = [1.0,1.0,1.0]
tspan = (0.0,10000.0)
# b1 values interval
bs = collect(2.0:0.01:5.0)
# number of values to collect
N = 100

## Loop to select all values of z for all b1 values
Z = zeros(Float64, (N,length(bs)))
Zmax = zeros(Float64, length(bs))
for j in 1:length(bs)
  # Change b1 value
  p[3] = b1 = bs[j]
  # Solve for given b1 value
  prob = ODEProblem(parameterized_model,u0,tspan,p)
  sol = solve(prob)
  # Save values
  Z[:,j] = sol[3,end-(N-1):end]
  Zmax[j] = maximum(sol[3,:])
end
Z
Zmax

## Select only local maxima
Zmaxloc = zeros(Float64, size(Z))
for i in 2:(N-1), j in 1:length(bs)
  if Z[i,j] > Z[i-1,j] && Z[i,j] > Z[i+1,j]
     Zmaxloc[i,j] = Z[i,j]
  end
end
Zmaxloc

## Visualize results
# Vector of b1 values repeated N times
B = repeat(bs, inner=N)
# Match local maxima with respective b1 value
points_maxloc = unique(hcat(B, vec(Zmaxloc)); dims=1)
# Remove null values
pts_maxloc = points_maxloc[points_maxloc[:,2] .> 0.00,:]
# Fig.4 A)
scatter(pts_maxloc[:,1], pts_maxloc[:,2],
        markersize=1,
        xlim=(2.2,3.2), ylim=(9.5,13))
# Fig.4 B)
scatter(pts_maxloc[:,1], pts_maxloc[:,2],
        markersize=1,
        xlim=(3.0,6.5), ylim=(3.0,10))
# Fig.4 C)
scatter(pts_maxloc[:,1], pts_maxloc[:,2],
        markersize=1,
        xlim=(2.25,2.6), ylim=(11.4,12.8))

# using parameters from Andrew's bifurcation diagram
scatter(pts_maxloc[:,1], pts_maxloc[:,2],
        markercolor=:green,
        markerstrokecolor=:white,
        markersize=2,
        markerstrokewidth=0,legend=false,
        markeralpha = 0.1,
        xlim=(2.2,3.2), ylim=(9.5,13))

# Initial tries
B = repeat(bs, inner=N)
points = unique(hcat(B, vec(Z)); dims=1)
plot(points[:,1], points[:,2])
plot(pts_maxloc[:,1], pts_maxloc[:,2])
plot(Zmax)

## Bifurcation analysis from juliadiffeq tutorial
# Install
# using Pkg
# Pkg.add("PyDSTool")
using PyDSTool
# Example
using ParameterizedFunctions
f = @ode_def begin
  dv = ( i + gl * (vl - v) - gca * 0.5 * (1 + tanh( (v-v1)/v2 )) * (v-vca) )/c
  dw = v-w
end vl vca i gl gca c v1 v2
u0 = [0;0]
tspan = [0;30]
p = [-60,120,0.0,2,4,20,-1.2,18]
dsargs = build_ode(f,u0,tspan,p)
ode = ds[:Generator][:Vode_ODEsystem](dsargs)
ode[:set](pars = Dict("i"=>-220))
ode[:set](ics  = Dict("v"=>-170))
PC = ds[:ContClass](ode)
bif = bifurcation_curve(PC,"EP-C",["i"],
                        max_num_points=450,
                        max_stepsize=2,min_stepsize=1e-5,
                        stepsize=2e-2,loc_bif_points="all",
                        save_eigen=true,name="EQ1",
                        print_info=true,calc_stab=true)
using Plots
plot(bif,(:i,:v))
