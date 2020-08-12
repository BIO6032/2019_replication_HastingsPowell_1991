###Hastings & Powell 1991
### Reproducing figures 2

u0 = [0.76, 0.16, 9.9]  #initial conditions for x,y,z
tspan = (0.0, 10000.0) #timespan
p = [5.0, 0.1, 3.0, 2.0, 0.4, 0.01] # values for a1, a2, b1, b2, d1 and d2

###Solving the differential equations
prob = ODEProblem(parameterized_model!, u0, tspan, p)
sol = solve(prob)

###Figure 2
fig2a = plot(sol, vars = (0, 1), xlim = (5000, 6500), ylim = (0, 1),
             xlabel = "time", ylabel = "x", linewidth = 0.01, leg = false,
             grid = :none, title = "a", titleloc = :left, c = :black
             ) #2a
fig2b = plot(sol, vars = (0, 2), xlim = (5000, 6500), ylim = (0, 0.5),
             xlabel = "time", ylabel = "y", linewidth = 0.01, leg = false,
             grid = :none, title="b", titleloc=:left, c=:black
             ) #2b
fig2c = plot(sol, vars = (0, 3), xlim = (5000, 6500), ylim = (7, 10.5),
             xlabel = "time", ylabel = "z", linewidth = 0.01, leg = false,
             grid = :none, title = "c", titleloc = :left, c = :black,
             ) #2c

fig2 = plot(fig2a, fig2b, fig2c, layout = (3,1),
            size = (500, 900), titlefontsize = 15,
            tickfontsize = 15, guidefontsize = 15,
            left_margin = 8Plots.mm, right_margin = 5Plots.mm,
            bottom_margin = 2Plots.mm,
            framestyle = :box
            )
## Export figures
savefig(fig2, joinpath("..", "article", "figures", "fig2"))
