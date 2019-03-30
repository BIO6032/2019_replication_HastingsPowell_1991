###Hastings & Powell 1991
##Reproducing figure 4

###Figure 4 (Bifurcation diagram)
include("HPmodel.jl")
p = [5.0,0.1,2.0,2.0,0.4,0.01]

#Packages
using Plots, DifferentialEquations

## Attempt 5 - Function within for loop with explicit parameter values
# Previous attempts didn't work but were kept below
using DifferentialEquations
u0 = [1.0,1.0,1.0]
tspan = (0.0,10000.0)
bs = collect(2.0:0.01:3.2)
N = 42
Z = zeros(Float64, (N,length(bs)))
Zmax = zeros(Float64, length(bs))
for j in 1:length(bs)
  b1 = bs[j]
  function model(du,u,p,t)
    x,y,z = u
    # a1,b1,a2,b2,d1,d2 = p # not working for now
    du[1] = dx = x*(1 - x) - (5.0*x/(1 + b1*x))*y
    du[2] = dy = (5.0*x/(1 + b1*x))*y - (0.1*y/(1 + 2.0*y))*z - 0.4*y
    du[3] = dz = (0.1*y/(1 + 2.0*y))*z - 0.01*z
  end
  prob = ODEProblem(model,u0,tspan)
  sol = solve(prob)
  Z[:,j] = sol[3,end-(N-1):end]
  Zmax[j] = maximum(sol[3,:])
end
Z
B = repeat(bs, inner=42)
points = unique(hcat(B, vec(Z)); dims=1)
using Plots
scatter(points)
plot(points[:,1], points[:,2])
plot(Zmax)
