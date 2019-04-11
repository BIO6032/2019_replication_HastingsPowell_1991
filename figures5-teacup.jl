###Hastings & Powell 1991
##Reproducing teacup figure (figure 2D) and figure 5

include("HPmodel.jl")

#Packages
using Plots, DifferentialEquations

#Values
u0=[0.7,0.2,8]  #initial conditions for x,y,z
tspan=(0.0,10000) #timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01]

# Solving the system of differential equations
prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob, alg = RK4(), reltol=1e-10) # canonical Runge-Kutta Order 4 method

#Teacup figure 2D
fig2d = plot(sol,vars=(1,2,3), color = :red,
            linewidth=0.01, linestyle = :dot,
            xlabel = "x", ylabel = "y", zlabel = "z",
            legend = :none, yflip = true,
            title = "Fig. 5E - Chatotic dynamic",
            ygridlinewidth = 2, ygridalpha = 2)
# Export figure
savefig(fig2d, "figures/fig2d")

# Figures 5 A and B

solution = collect(reshape(1.0:3*lastindex(sol), 3, lastindex(sol))) # create array
# transfer the solutions into the array
for i in 1:lastindex(sol)
     global solution
     t = sol.t[i]
     solution[:,i] = reshape(sol(t),3,1)
end
solution

constant = 9.0 # poincaré section
epsilon = 0.05 # margin of error

solution_x = solution[1,:]
solution_y = solution[2,:]
solution_z = solution[3,:]
indices_x = findall(solution_x -> 0.9 <= solution_x <= 1, solution_x)
indices_y = findall(solution_y -> 0 <= solution_y <= 0.1, solution_y)
indices_z = findall(solution_z -> constant - epsilon <= solution_z <= constant + epsilon, solution_z)

indices = zeros(Int64, 10000)
for i in 1:length(indices_x)
    if any(indices_y -> indices_y == indices_x[i], indices_y)
        if any(indices_z -> indices_z == indices_x[i], indices_z)
            indices[i] = indices_x[i]
        end
    end
end
indices = indices[findall(indices -> indices > 0, indices)]

# Figure 5A
plot(solution[1,indices], solution[2,indices],
    legend = false, xlabel = "x(n)", ylabel = "y(n)",
    seriestype=:scatter, mc = :red,
    title = "Figure 5A - Poincaré section")

# Figure 5B
indices_n = indices[1:length(indices)-1]
indices_nplus1 = indices[2:length(indices)]
plot(solution[1,indices_n], solution[1,indices_nplus1],
    legend = false, xlabel = "x(n)", ylabel = "x(n+1)",
    seriestype=:scatter, mc = :red,
    title = "Figure 5B - Poincaré map")


## GIF
# define the model
mutable struct Lorenz
    dt; a1; a2; b1; b2; d1; d2; x; y; z
end

function step!(l::Lorenz)
    dx = l.x*(1-l.x) - l.a1*l.x*l.y/(1 + l.b1*l.x)     ; l.x += l.dt * dx
    dy = l.a1*l.x*l.y/(1 + l.b1*l.x) - l.a2*l.y*l.z/(1 + l.b2*l.y) - l.d1*l.y ; l.y += l.dt * dy
    dz = l.a2*l.y*l.z/(1 + l.b2*l.y) - l.d2*l.z   ; l.z += l.dt * dz
end

attractor = Lorenz((dt = 0.05, a1 = 5.0, a2 = 0.1, b1 = 3.0, b2 = 2.0, d1 = 0.4, d2 = 0.01, x = 0.7, y = 0.2, z = 8)...)

using Plots
# initialize a 3D plot with 1 empty series
plt = plot3d(1, xlim=(0,1), ylim=(0,0.5), zlim=(7.5, 10.5),
                title = "Tea cup GIF", marker = 2)
# build an animated gif by pushing new points to the plot, saving every 10th frame
@gif for i=1:1500
    step!(attractor)
    push!(plt, attractor.x, attractor.y, attractor.z)
end every 10
