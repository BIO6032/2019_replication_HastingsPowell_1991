###Hastings & Powell 1991
### Reproducing figure 3

tspan=(0.0,10000) # timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01] # parameter values

# Initial conditions serie 1
u0_serie1=[0.77,0.16,9.9]   #initial conditions for x,y,z
prob_serie1 = ODEProblem(parameterized_model,u0_serie1,tspan,p)
sol_serie1 = solve(prob_serie1)

plot(sol_serie1, vars=1, xlim=(0,500), ylim=(0,1), c=:black, linewidth=2)

# Initial conditions changing x by 0.01
u0_serie2=[0.78,0.16,9.9]

prob_serie2 = ODEProblem(parameterized_model,u0_serie2,tspan,p)
sol_serie2 = solve(prob_serie2)

fig3=plot!(sol_serie2,vars=1,xlim=(0,500), ylim=(0,1), linestyle=:dash, linewidth=2,
        grid=:none, legend=false, xlabel="time", ylabel="x", c=:darkgrey, framestyle=:box)

## Export figures
savefig(fig3, joinpath("..", "article", "figures", "fig3"))
