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
pyplot()
plt = plot3d(1, xaxis=("x", (0,1)),
                yaxis=("y",(0,0.5), :flip),
                zaxis=("z", (7.5, 10.5)),
                title = "Animated three-dimensional phase plot",
                marker = :none,
                legend = :none,
                grid=:none,
                linewidth = 1,
                c=:black)

# build an animated gif by pushing new points to the plot, saving every 20th frame
anim = @animate for i=1:20000
    step!(TeaCup_sol)
    push!(plt, TeaCup_sol.x, TeaCup_sol.y, TeaCup_sol.z)
end every 20
gif(anim, joinpath("..", "article", "figures", "figure2D.gif"), fps=40)
