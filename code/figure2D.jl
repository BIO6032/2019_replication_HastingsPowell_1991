### Hastings & Powell 1991
## Reproducing teacup figure (figure 2D)

#### FIGURES 2D
#### b1 = 3.0

u0=[0.7,0.2,8.0]  #initial conditions for x,y,z
tspan=(0.0,10000.0) #timespan
p_b3 = [5.0,0.1,3.0,2.0,0.4,0.01] # parameter values (a1, a2, b1, b2, c1, c2)

# Solving the system of differential equations
prob_b3 = ODEProblem(parameterized_model,u0,tspan,p_b3)
sol_b3 = solve(prob_b3, alg = RK4(), reltol=1e-14) # RK4 algorithme

sol_x_b3 = sol_b3[1,:] # timeseries for x
sol_y_b3 = sol_b3[2,:] # timeseries for y
sol_z_b3 = sol_b3[3,:] # timeseries for z

# Teacup Figures 2D and 5E (Three-dimentional phase plot)
fig2d = plot(sol_b3,vars=(1,2,3),
             linewidth=0.01, linestyle=:dot,
             xlabel="x", xflip=false, xlim=(0.0,1.0), xticks=0.0:0.5:1.0,
             ylabel="y", yflip=true, ylim=(0.0,0.5), yticks=0.0:0.25:0.5,
             zlabel="z", zflip=false, zlim=(7.5,10.5), zticks=7.5:1.5:10.5,
             grid=:none,
             legend =:none, size=(600,600), c=:black)

savefig(fig2d, joinpath("..", "article", "figures", "fig2d")) # export figure

#### Teacup GIF
## Inspired by an example of Lorez attractor: http://docs.juliaplots.org/latest/
## FFmpeg has to be installed prior to running the code
# define the model
mutable struct TeaCup
    dt; a1; a2; b1; b2; d1; d2; x; y; z
end

function step!(t::TeaCup)
    dx = t.x*(1-t.x) - t.a1*t.x*t.y/(1 + t.b1*t.x)     ; t.x += t.dt * dx
    dy = t.a1*t.x*t.y/(1 + t.b1*t.x) - t.a2*t.y*t.z/(1 + t.b2*t.y) - t.d1*t.y ; t.y += t.dt * dy
    dz = t.a2*t.y*t.z/(1 + t.b2*t.y) - t.d2*t.z   ; t.z += t.dt * dz
end

# solution from initial values
TeaCup_sol = TeaCup((dt = 0.05, a1 = 5.0, a2 = 0.1, b1 = 3.0, b2 = 2.0, d1 = 0.4, d2 = 0.01, x = 0.7, y = 0.2, z = 8)...)


# initialize a 3D plot with 1 empty series
plt = plot3d(1, xaxis=("x", (0,1)),
                yaxis=("y",(0,0.5), :flip),
                zaxis=("z", (7.5, 10.5)),
                title = "Animated three-dimentional phase plot",
                marker = :none,
                legend = :none,
                grid=:none,
                linewidth = 3)

# build an animated gif by pushing new points to the plot, saving every 10th frame
 @gif for i=1:30000
    step!(TeaCup_sol)
    push!(plt, TeaCup_sol.x, TeaCup_sol.y, TeaCup_sol.z)
end every 20
