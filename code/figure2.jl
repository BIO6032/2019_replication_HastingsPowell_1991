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
fig2a = plot(sol,vars=(0,1), xlim=(5000,6500), ylim=(0,1),
        xlabel="time", ylabel="x", linewidth=0.01, leg=false) #2a
fig2b = plot(sol,vars=(0,2), xlim=(5000,6500), ylim=(0,0.5),
        xlabel="time", ylabel="y",linewidth=0.01,leg=false) #2b
fig2c = plot(sol,vars=(0,3), xlim=(5000,6500), ylim=(7,11),
        xlabel="time", ylabel="z", linewidth=0.01,leg=false) #2c

## Export figures
savefig(fig2a, "article/figures/fig2a")
savefig(fig2b, "article/figures/fig2b")
savefig(fig2c, "article/figures/fig2c")
