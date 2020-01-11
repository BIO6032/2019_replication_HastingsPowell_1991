### Hastings & Powell 1991
## Reproducing teacup figure (figure 2D) and figure 5

#### FIGURES 2D (=5E), 5A and 5B ####
#### b1 = 3.0

u0=[0.7,0.2,8]  #initial conditions for x,y,z
tspan=(0.0,10000) #timespan
p_b3 = [5.0,0.1,3.0,2.0,0.4,0.01] # parameter values (a1, a2, b1, b2, c1, c2)

# Solving the system of differential equations
prob_b3 = ODEProblem(parameterized_model,u0,tspan,p_b3)
sol_b3 = solve(prob_b3, alg = RK4(), reltol=1e-14) # RK4 algorithme

sol_x_b3 = sol_b3[1,:] # timeseries for x
sol_y_b3 = sol_b3[2,:] # timeseries for y
sol_z_b3 = sol_b3[3,:] # timeseries for z

constant_b3 = 9.0 # poincaré section (z value)
epsilon_b3 = 0.05 # margin of error for z value

# Find timesteps where points are in poincaré section
ind_x_b3 = findall(i -> 0.9 <= i <= 1, sol_x_b3) # x between 0.9 and 1 (high)
ind_y_b3 = findall(i -> 0 <= i <= 0.1, sol_y_b3) # y between 0 and 0.1 (low)
ind_z_b3 = findall(i -> constant_b3 - epsilon_b3 <= i <= constant_b3 + epsilon_b3, sol_z_b3) # z around constant

ind_xyz_b3 = zeros(Int64, 10000) # initialize the vector of concordant indices
# for loop : concordant indices
for j in 1:length(ind_x_b3)
    if any(i -> i == ind_x_b3[j], ind_y_b3) # concordant x and y indices
        if any(i -> i == ind_x_b3[j], ind_z_b3) # concordant x, y and z indices
            ind_xyz_b3[j] = ind_x_b3[j] # if the index if concordant, keep it
        end
    end
end

# for loop : non adjacent indices
for j in 1:(length(ind_xyz_b3)-1)
    if ind_xyz_b3[j] == ind_xyz_b3[j+1] - 1 # if 2 consecutive concordant indices are also
                                      # consecutive in the solution, don't keep them
        ind_xyz_b3[j] = 0
    end
end
ind_xyz_b3 = ind_xyz_b3[findall(i -> i > 0, ind_xyz_b3)] # remove extra values (0 values)



# Figure 5A - Poincaré section
xmin = 0.95 ; xmax = .983 ; ymin = 0.015 ; ymax = .04
fig5a = plot(sol_x_b3[ind_xyz_b3], sol_y_b3[ind_xyz_b3],
    legend = false,
    seriestype=:scatter,
    xaxis=("x(n)", (xmin, xmax), xmin:0.01:xmax),
    yaxis=("y(n)", (ymin, ymax), ymin:0.005:ymax),
    xgrid = :none, ygrid = :none,
    title="A", titleloc=:left)

#savefig(fig5a, joinpath("..", "article", "figures", "fig5a") # export figure



# Figure 5B - Poincaré map
ind_n_b3 = ind_xyz_b3[1:length(ind_xyz_b3)-1] # indices for x(n)
ind_nplus1_b3 = ind_xyz_b3[2:length(ind_xyz_b3)] # indices for x(n+1)

xmin = 0.95 ; xmax = 0.98
fig5b = plot(sol_x_b3[ind_n_b3], sol_x_b3[ind_nplus1_b3],
    legend = false,
    seriestype=:scatter,
    xaxis=("x(n)", (xmin, xmax), xmin:0.005:xmax),
    yaxis=("x(n+1)", (xmin, xmax), xmin:0.005:xmax),
    xgrid = :none, ygrid = :none,
    title="B", titleloc=:left)
plot!(xmin:0.01:xmax, xmin:0.01:xmax , color = :black)

#savefig(fig5b, joinpath("..", "article", "figures", "fig5b") # export figure



#Teacup Figures 2D and 5E (Three-dimentional phase plot)
fig2d = plot(sol_b3,vars=(1,2,3),
            linewidth=0.01, linestyle = :dot,
            xaxis=("x"),
            yaxis=("y", :flip),
            zaxis=("z"),
            grid=:none,
            legend =:none, size=(600,600))

savefig(fig2d, joinpath("..", "article", "figures", "fig2d")) # export figure



#### FIGURES 5C and 5D ####
#### b1 = 6.0

#Values
p_b6 = [5.0,0.1,6.0,2.0,0.4,0.01] # parameter values (a1, a2, b1, b2, c1, c2)

# Solving the system of differential equations
prob_b6 = ODEProblem(parameterized_model,u0,tspan,p_b6)
sol_b6 = solve(prob_b6, alg = RK4(), reltol=1e-14) # RK4 algorithme

sol_x_b6 = sol_b6[1,:] # timeseries for x
sol_y_b6 = sol_b6[2,:] # timeseries for y
sol_z_b6 = sol_b6[3,:] # timeseries for z

constant_b6 = 3.0 # poincaré section (z value)
epsilon_b6 = 0.05 # margin of error for z value

# Find timesteps where points are in poincaré section
ind_x_b6 = findall(i -> 0.93 <= i <= 1, sol_x_b6) # x between 0.9 and 1 (high)
ind_y_b6 = findall(i -> 0 <= i <= 0.085, sol_y_b6) # y between 0 and 0.1 (low)
ind_z_b6 = findall(i -> constant_b6 - epsilon_b6 <= i <= constant_b6 + epsilon_b6, sol_z_b6) # z around constant

ind_xyz_b6 = zeros(Int64, 15000) # initialize the vector of concordant indices
# for loop : concordant indices
for j in 1:length(ind_x_b6)
    if any(i -> i == ind_x_b6[j], ind_y_b6) # concordant x and y indices
        if any(i -> i == ind_x_b6[j], ind_z_b6) # concordant x, y and z indices
            ind_xyz_b6[j] = ind_x_b6[j] # if the index if concordant, keep it
        end
    end
end

# for loop : non adjacent indices
for j in 1:(length(ind_xyz_b6)-1)
    if ind_xyz_b6[j] == ind_xyz_b6[j+1] - 1 # if 2 consecutive concordant indices are also
                                      # consecutive in the solution, don't keep them
        ind_xyz_b6[j] = 0
    end
end
ind_xyz_b6 = ind_xyz_b6[findall(i -> i > 0, ind_xyz_b6)] # remove extra values (0 values)



# Figure 5C - Poincaré section
xmin = 0.93 ; xmax = 1.003 ; ymin = -0.003 ; ymax = .09
fig5c = plot(sol_x_b6[ind_xyz_b6], sol_y_b6[ind_xyz_b6],
    legend = false,
    seriestype=:scatter,
    xaxis=("x(n)", (xmin, xmax), xmin:0.02:xmax),
    yaxis=("y(n)", (ymin, ymax), 0:0.02:ymax),
    xgrid = :none, ygrid = :none,
    title="C", titleloc=:left)

#savefig(fig5c, joinpath("..", "article", "figures", "fig5c") # export figure



# Figure 5D - Poincaré map
ind_n_b6 = ind_xyz_b6[1:length(ind_xyz_b6)-1] # indices for x(n)
ind_nplus1_b6 = ind_xyz_b6[2:length(ind_xyz_b6)] # indices for x(n+1)

xmin = 0.93 ; xmax = 1.003
fig5d = plot(sol_x_b6[ind_n_b6], sol_x_b6[ind_nplus1_b6],
    legend = false,
    seriestype=:scatter,
    xaxis=("x(n)", (xmin, xmax), xmin:0.01:xmax),
    yaxis=("x(n+1)", (xmin, xmax), xmin:0.01:xmax),
    xgrid = :none, ygrid = :none,
    title="D", titleloc=:left)
plot!(xmin:0.01:xmax, xmin:0.01:xmax, color = :black)

#savefig(fig5d, joinpath("..", "article", "figures", "fig5d") # export figure

# Export complete fig5
fig5 = plot(fig5a, fig5b, fig5c, fig5d, layout=4, titlefontsize=10)
savefig(fig5, joinpath("..", "article", "figures", "fig5"))

#Teacup (Three-dimentional phase plot)
# b1 = 6.0
fig2d2 = plot(sol_b6,vars=(1,2,3),
            linewidth=0.01, linestyle = :dot,
            xaxis=("x"),
            yaxis=("y",:flip),
            zaxis=("z"),
            grid=:none,
            legend =:none,
            size=(600,600))

# Export figure
savefig(fig2d2, joinpath("..", "article", "figures", "fig2d2")) # export figure




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
