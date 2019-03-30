###Hastings & Powell 1991
### Reproducing figures 2 and 3

include("HPmodel.jl")

#Packages
using Plots, DifferentialEquations

u0=[0.7,0.2,8]  #initial conditions for x,y,z
tspan=(0.0,10000) #timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01] # values for a1, a2, b1, b2, d1 and d2

###Solving the differential equations
prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob, alg = RK4(), reltol=1e-10) #have to make sure that RK4 and reltol are correct

###Figure 2
plot(sol,vars=(0,1), xlim=(5000,6500), ylim=(0,1)) #2a
plot(sol,vars=(0,2), xlim=(5000,6500), ylim=(0,0.5)) #2b
plot(sol,vars=(0,3), xlim=(5000,6500), ylim=(7,11)) #2c

###Figure 3, to do
plot(sol, vars=1, xlim=(0,500), ylim=(0,1))
