### Hastings & Powell 1991
## Reproducing figure 4

### Figure 4 (Bifurcation diagram)

# Load model
include("HPmodel.jl")

# Packages
using Plots, DifferentialEquations

# Define initial parameters
p = a1,a2,b1,b2,d1,d2 = [5.0,0.1,2.0,2.0,0.4,0.01]
u0 = [1.0,1.0,1.0]
tspan = (0.0,10000.0)
bs = collect(2.0:0.01:3.2)
N = 42
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
B = repeat(bs, inner=42)
points = unique(hcat(B, vec(Z)); dims=1)
plot(points[:,1], points[:,2])
plot(Zmax)
