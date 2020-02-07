### Hastings & Powell 1991
## Reproducing teacup figure (figure 2D)

#### FIGURES 2D
#### b1 = 3.0

u0=[0.76,0.16,9.9]  #initial conditions for x,y,z
tspan=(0.0,10000.0) #timespan
p_b3 = [5.0,0.1,3.0,2.0,0.4,0.01] # parameter values (a1, a2, b1, b2, c1, c2)

# Solving the system of differential equations
prob_b3 = ODEProblem(parameterized_model,u0,tspan,p_b3)
sol_b3 = solve(prob_b3, alg = RK4(), reltol=1e-14) # RK4 algorithme

sol_x_b3 = sol_b3[1,:] # timeseries for x
sol_y_b3 = sol_b3[2,:] # timeseries for y
sol_z_b3 = sol_b3[3,:] # timeseries for z

# Teacup Figures 2D and 5E (Three-dimensional phase plot)
gr()
fig2d = plot(sol_x_b3, sol_y_b3, sol_z_b3, #sol_b3,vars=(1,2,3),
             linewidth=0.01, linestyle=:dot,
             xlabel="x", xflip=false, xlim=(0.0,1.0), xticks=0.0:0.5:1.0,
             ylabel="y", yflip=true, ylim=(0.0,0.5), yticks=0.0:0.25:0.5,
             zlabel="z", zflip=false, zlim=(7.5,10.5), zticks=7.5:1.5:10.5,
             tick_direction=:out, guidefontsize=12, tickfontsize=12,
             legend =:none, size=(600,600), c=:black,
             right_margin=5Plots.mm, left_margin=2Plots.mm,
             )
# Seems like there's a bug with the axes labels when flipping y
# Only solution we could find was to substract y values from 0.5, then plot and replace labels
sol_y_b3_flip = copy(sol_y_b3)
sol_y_b3_flip = 0.5 .- sol_y_b3_flip
fig2d_flip = plot(sol_x_b3, sol_y_b3_flip, sol_z_b3, #sol_b3,vars=(1,2,3),
             linewidth=0.01, linestyle=:dot,
             xlabel="x", xflip=false, xlim=(0.0,1.0), xticks=0.0:0.5:1.0, xrotation=30.0,
             ylabel="y", yflip=false, ylim=(0.0,0.5), yticks=(0.0:0.25:0.5, string.(0.5:-0.25:0.0)), yrotation=-10.0,
             zlabel="z", zflip=false, zlim=(7.5,10.5), zticks=7.5:1.5:10.5, zrotation=0.0,
             tick_direction=:out, guidefontsize=12, tickfontsize=12,
             legend =:none, size=(600,600), c=:black,
             right_margin=5Plots.mm, left_margin=2Plots.mm,
             )
# Otherwise, it's also possible to use the pyplot backend (additionnal dependency)
#=
pyplot()
fig2d_pyplot = plot(sol_x_b3, sol_y_b3, sol_z_b3, #sol_b3,vars=(1,2,3),
             linewidth=0.1,
             xlabel="x", xflip=false, xlim=(0.0,1.0), xticks=0.0:0.5:1.0,
             ylabel="y", yflip=true, ylim=(0.0,0.5), yticks=0.0:0.25:0.5,
             zlabel="z", zflip=false, zlim=(7.5,10.5), zticks=7.5:1.5:10.5,
             tick_direction=:out, guidefontsize=12, tickfontsize=12,
             legend =:none, size=(600,600), c=:black)
gr()
=#

# Export figures
# savefig(fig2d, joinpath("..", "article", "figures", "fig2d_misplaced"))
savefig(fig2d_flip, joinpath("..", "article", "figures", "fig2d"))
# savefig(fig2d_pyplot, joinpath("..", "article", "figures", "fig2d_pyplot"))
