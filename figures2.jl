###Hastings & Powell 1991
### Reproducing figures 2

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
