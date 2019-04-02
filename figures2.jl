###Hastings & Powell 1991
### Reproducing figures 2 and 3

include("HPmodel.jl")

#Packages
using Plots, DifferentialEquations

u0=[1.0,1.0,1.0]  #initial conditions for x,y,z
tspan=(0.0,10000) #timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01] # values for a1, a2, b1, b2, d1 and d2

###Solving the differential equations
prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob) #have to make sure which alg (RK4?) and reltol (1e-10?) are correct

###Figure 2
plot(sol,vars=(0,1), xlim=(5000,6500), ylim=(0,1)) #2a
plot(sol,vars=(0,2), xlim=(5000,6500), ylim=(0,0.5)) #2b
plot(sol,vars=(0,3), xlim=(5000,6500), ylim=(7,11)) #2c

###Figure 3,
pl=plot(sol, vars=1, xlim=(0,2000), ylim=(0,1))

##Attempt figure 3 changing b1 to 3.001
#probably not the most efficient way to do it, find another solution
#difference seen only on a larger timescale, have to find why
function model(du,u,p,t)
  x,y,z = u
  du[1] = dx = x*(1 - x) - (5.0*x/(1 + 3.001*x))*y
  du[2] = dy = (5.0*x/(1 + 3.001*x))*y - (0.1*y/(1 + 2.0*y))*z - 0.4*y
  du[3] = dz = (0.1*y/(1 + 2.0*y))*z - 0.01*z
end
prob2 = ODEProblem(model,u0,tspan)
sol2 = solve(prob)

plot!(sol2,vars=1,xlim=(0,2000), ylim=(0,1))
