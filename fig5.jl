#### Hastings & Powell 1991
#### Replication of Figure 5 - Poincaré sections and Poincaré maps

## Simplified system of differenial equations (eq. 4)
using Plots
using DifferentialEquations
f(u,a,b) = a*u/(1+b*u)

function parameterized_model(du,u,p,t)
  x,y,z = u
  a1,a2,b1,b2,d1,d2 = p
  du[1] = dx = x*(1-x) - f(x,a1,b1)*y
  du[2] = dy = f(x,a1,b1)*y - f(y,a2,b2)*z - d1*y
  du[3] = dz = f(y,a2,b2)*z - d2*z
end

# Parameter values
u0 = [0.7,0.2,8] # initial values of x, y and z
tspan = (0.0,6500) # timespan
p = [5.0,0.1,3.0,2.0,0.4,0.01] # values of a1, a2, b1, b2, d1 and d2

# Solving the system of differential equations
prob = ODEProblem(parameterized_model,u0,tspan,p)
sol = solve(prob, alg = RK4(), reltol=1e-10) # canonical Runge-Kutta Order 4 method

# Plotting the results (Fig.5 E)

plot(sol,vars=(1,2,3), color = :red,
    linewidth=0.01, linestyle = :dot,
    xlabel = "x", ylabel = "y", zlabel = "z",
    legend = :none, yflip = true,
    title = "Fig. 5E - Chatotic dynamic",
    ygridlinewidth = 2, ygridalpha = 2)




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
epsilon = 0.0001 # margin of error

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
