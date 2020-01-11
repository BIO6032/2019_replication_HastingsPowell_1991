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
bs = collect(2.0:0.01:6.2)
# number of values to collect
N = 1000

## Loop to select all values of z for all b1 values
Z = zeros(Float64, (N,length(bs)))
Zmax = zeros(Float64, length(bs))
Zmin = zeros(Float64, length(bs))
errors = zeros(Float64, length(bs))
for j in 1:length(bs)
  # Change b1 value
  p[3] = b1 = bs[j]
  # Solve for given b1 value
  prob = ODEProblem(parameterized_model,u0,tspan,p)
  sol = solve(prob)
  # Save values
  if length(sol[3,:]) > N
    Z[:,j] = sol[3,end-(N-1):end]
    Zmax[j] = maximum(Z[:,j])
    Zmin[j] = minimum(Z[:,j])
  else
    errors[j] = j
  end
end
Z
Zmax
Zmin
errors[errors .> 0]
## Select only local maxima
Zmaxloc = zeros(Float64, size(Z))
Zmaxloc_all = zeros(Float64, size(Z))
for i in 2:(N-1), j in 1:length(bs)
  # Select maxima values(greater than neighbors)
  if Z[i,j] > Z[i-1,j] && Z[i,j] > Z[i+1,j]
    Zmaxloc_all[i,j] = Z[i,j]
    # Select first local maxima only with arbitrary interval
    # if Z[i,j] > (5/8)*(Zmax[j] + Zmid[j])
    Zrange = Zmax[j] - Zmin[j]
    if Z[i,j] > (Zmin[j] + 0.66*(Zrange) )
       Zmaxloc[i,j] = Z[i,j]
    end
  end
end
Zmaxloc

## Visualize results
# Vector of b1 values repeated N times
B = repeat(bs, inner=N)
# Match local maxima with respective b1 value
points_maxloc_all = unique(hcat(B, vec(Zmaxloc_all)); dims=1)
points_maxloc = unique(hcat(B, vec(Zmaxloc)); dims=1)
# Remove null values
pts_maxloc_all = points_maxloc_all[points_maxloc_all[:,2] .> 0.00,:]
pts_maxloc = points_maxloc[points_maxloc[:,2] .> 0.00,:]
# Fig.4 A)
fig4a = scatter(pts_maxloc_all[:,1], pts_maxloc_all[:,2],
                markersize=1,
                xlim=(2.2,3.2), ylim=(9.5,13),
                xlabel="b1", ylabel="Zmax", legend=false)
fig4a = scatter(pts_maxloc[:,1], pts_maxloc[:,2],
                markersize=1,
                xlim=(2.2,3.2), ylim=(9.5,13),
                xlabel="b1", ylabel="Zmax", legend=false)
# Fig.4 B)
fig4b = scatter(pts_maxloc_all[:,1], pts_maxloc_all[:,2],
                markersize=1,
                xlim=(3.0,6.5), ylim=(3.0,10),
                xlabel="b1", ylabel="Zmax", legend=false)
fig4b = scatter(pts_maxloc[:,1], pts_maxloc[:,2],
                markersize=1,
                xlim=(3.0,6.5), ylim=(3.0,10),
                xlabel="b1", ylabel="Zmax", legend=false)
# Fig.4 C)
fig4c = scatter(pts_maxloc[:,1], pts_maxloc[:,2],
                markersize=1,
                xlim=(2.25,2.6), ylim=(11.4,12.8),
                xlabel="b1", ylabel="Zmax", legend=false)

# Check selected values
plot(Z[:,1])
plot(Z[:,21])
plot(Z[:,21], xlim=(0,100))
plot(Z[:,29])
plot(Z[:,30])
plot(Z[:,31])
plot(Z[:,31], xlim=(0,100))
plot(Z[:,41])
plot(Z[:,41], xlim=(0,100))
plot(Z[:,51], xlim=(0,200))
plot(Z[:,60])
plot(Z[:,61], xlim=(0,200))
plot(Z[:,71], xlim=(0,200))
plot(Z[:,121], xlim=(0,200))
plot(Z[:,221], xlim=(0,1000))
plot(Z[:,301], xlim=(0,1000))

## Export figures
savefig(fig4a, joinpath("..", "article", "figures", "fig4a")
savefig(fig4b, joinpath("..", "article", "figures", "fig4b")
savefig(fig4c, joinpath("..", "article", "figures", "fig4c")

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
