#### Differential Equations - Hastings & Powell ####

# Testing merge conflicts

## Differential Equations
using DifferentialEquations
function f1(u)
  f1 = a1*u/(1 + b1*u)
end
function f2(u)
  f2 = a2*u/(1 + b2*u)
end
function model(du,u,p,t)
  x,y,z = u
  # a1,b1,a2,b2,d1,d2 = p # not working for now
  du[1] = dx = x*(1 - x) - f1(x)*y
  du[2] = dy = f1(x)*y - f2(y)*z - d1*y
  du[3] = dz = f2(y)*z - d2*z
end
u0 = [1.0,1.0,1.0] # not sure if those are the right parameters
tspan = (0.0,10000.0)
p = [5.0,3.0,0.1,2.0,0.4,0.01]
a1,b1,a2,b2,d1,d2 = p
prob = ODEProblem(model,u0,tspan,p)
sol = solve(prob)

## Dynamics (fig 2)
using Plots
# 3D phase space plot
plot(sol, vars=(1,2,3), xlim=(0,1),ylim=(0,0.5),zlim=(7.5,10.5))
# Timeseries of 2nd component only (y)
plot(sol,vars=(0,1), xlim=(5000,6500), ylim=(0,1))
plot(sol,vars=(0,2), xlim=(5000,6500), ylim=(0,0.5))
plot(sol,vars=(0,3), xlim=(5000,6500), ylim=(7,11))

#### Bifucation diagram (fig 4)
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



#### Previous attempts
# Explore synthax
sol.u
sol.u[2][3]
sol.u[;]
sol.u[2]
Array(sol.u)
AbstractMatrix(sol)
plot(sol,vars=(0,3))

# sol[i,j] is ith component at timestep j
# 3rd component (z) at all timesteps
zsol = sol[3,:]
zmax = maximum(zsol)

## Attempt 1 - Same ODE structure as in "Differential Equations" section
# bs = LinRange(2.0, 3.2, 121)
bs = collect(2.0:0.01:3.2)
zmax = zeros(Float64, length(bs))
for j in 1:length(bs)
  u0 = [1.0,1.0,1.0]
  tspan = (0.0,10000.0)
  p = [5.0,bs[j],0.1,2.0,0.4,0.01]
  a1,b1,a2,b2,d1,d2 = p
  prob = ODEProblem(model,u0,tspan,p)
  sol = solve(prob)
  zmax[j] = maximum(sol[3,:])
end
zmax
## solve() doesn't seem able to find b1 value defined in the loop
## Any way to fix this??

# Attempt 2 - Add function and parameter value from the start
function model(du,u,p,t)
  x,y,z = u
  # a1,b1,a2,b2,d1,d2 = p # not working for now
  du[1] = dx = x*(1 - x) - (5.0*x/(1 + b1*x))*y
  du[2] = dy = (5.0*x/(1 + b1*x))*y - (0.1*y/(1 + 2.0*y))*z - 0.4*y
  du[3] = dz = (0.1*y/(1 + 2.0*y))*z - 0.01*z
end
bs = LinRange(2.0, 3.2, 121)
bs = collect(2.0:0.01:3.2)
zmax = zeros(Float64, length(bs))
for j in 1:length(bs)
  u0 = [1.0,1.0,1.0]
  tspan = (0.0,10000.0)
  p = [5.0,bs[j],0.1,2.0,0.4,0.01]
  a1,b1,a2,b2,d1,d2 = [5.0,bs[j],0.1,2.0,0.4,0.01]
  prob = ODEProblem(model,u0,tspan,p)
  sol = solve(prob)
  zmax[j] = maximum(sol[3,:])
end
zmax

# Attempt 3 - Explicit parameters and += 0.1 for b1
using DifferentialEquations
u0 = [1.0,1.0,1.0]
tspan = (0.0,10000.0)
a1,b1,a2,b2,d1,d2 = [5.0,2.0,0.1,2.0,0.4,0.01]
p = a1,b1,a2,b2,d1,d2
function f1(u)
  f1 = a1*u/(1 + b1*u)
end
function f2(u)
  f2 = a2*u/(1 + b2*u)
end
function model(du,u,p,t)
  x,y,z = u
  # a1,b1,a2,b2,d1,d2 = p # not working for now
  du[1] = dx = x*(1 - x) - f1(x)*y
  du[2] = dy = f1(x)*y - f2(y)*z - d1*y
  du[3] = dz = f2(y)*z - d2*z
end
bs = collect(2.0:0.01:3.2)
zmax = zeros(Float64, length(bs))
for j in 1:121
  b1 += 0.01
  p = a1,b1,a2,b2,d1,d2
  prob = ODEProblem(model,u0,tspan,p)
  sol = solve(prob)
  zmax[j] = maximum(sol[3,:])
end
zmax

## Attempt 4 - Explicit parameters and function within for loop
# but only keeping 1 maximum per b1 value
using DifferentialEquations
u0 = [1.0,1.0,1.0]
tspan = (0.0,10000.0)
bs = collect(2.0:0.01:3.2)
zmax = zeros(Float64, length(bs))
for j=1:length(bs)
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
  zmax[j] = maximum(sol[3,:])
end
zmax

# teststs 
