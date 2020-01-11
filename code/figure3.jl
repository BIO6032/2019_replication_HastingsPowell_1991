###Hastings & Powell 1991
### Reproducing figure 3

#initial conditions serie 1
u0=[0.77,0.16,9.9]   #initial conditions for x,y,z
tspan=(0.0,10000) #timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01]

prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob)

plot(sol, vars=1, xlim=(0,500), ylim=(0,1), c=:black)

#initial condition changing x by 0.01
u0=[0.78,0.16,9.9]
tspan=(0.0,10000) #timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01]

prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob)

fig3=plot!(sol,vars=1,xlim=(0,500), ylim=(0,1), linestyle=:dash,
        grid=:none, legend=false, xlabel="time", ylabel="x", c=:darkgrey)

## Export figures
savefig(fig3, joinpath("..", "article", "figures", "fig3"))
