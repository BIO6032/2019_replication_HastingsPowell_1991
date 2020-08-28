### Hastings & Powell 1991
## Reproducing figure 4
using LaTeXStrings

### Figure 4 (Bifurcation diagram)

## Define initial parameters
p = a1, a2, b1, b2, d1, d2 = [5.0, 0.1, 2.0, 2.0, 0.4, 0.01]
u0 = [0.76, 0.16, 9.9]
tspan = (0.0, 10000.0)
# b1 values interval
bs = collect(2.0:0.01:6.2)
# number of values to collect
N = 1000

## Loop to select all values of z for all b1 values
Z = zeros(Float64, (N, length(bs)))
Zmax = zeros(Float64, length(bs))
Zmin = zeros(Float64, length(bs))
errors = zeros(Float64, length(bs))
for j in 1:length(bs)
  # Change b1 value
  local p[3] = local b1 = bs[j]
  # Solve for given b1 value
  local prob = ODEProblem(parameterized_model!, u0, tspan, p)
  local sol = solve(prob)
  # Save values
  if length(sol[3,:]) > N
    Z[:,j] = sol[3, end-(N-1):end]
    Zmax[j] = maximum(Z[:, j])
    Zmin[j] = minimum(Z[:, j])
  else
    # Safeguard for when true solution is unstable
    errors[j] = j
  end
end
Z
Zmax
Zmin
errors[errors .> 0]

## Select only local maxima
Zmaxloc = zeros(Float64, size(Z))
for i in 2:(N-1), j in 1:length(bs)
  # Select maxima values(greater than neighbors)
  if Z[i, j] > Z[i-1, j] && Z[i, j] > Z[i+1, j]
    # Select first local maxima only with arbitrary interval
    Zrange = Zmax[j] - Zmin[j]
    if Z[i, j] > (Zmin[j] + 0.66*(Zrange))
       Zmaxloc[i, j] = Z[i, j]
    end
  end
end
Zmaxloc

## Visualize results
# Vector of b1 values repeated N times
B = repeat(bs, inner = N)
# Match local maxima with respective b1 value
points_maxloc = unique(hcat(B, vec(Zmaxloc)); dims = 1)
# Remove null values
pts_maxloc = points_maxloc[points_maxloc[:,2] .> 0.00, :]
# Fig.4 A)
fig4a = scatter(pts_maxloc[:, 1], pts_maxloc[:, 2],
                markersize = 2, markeralpha = 0.5,
                xlim = (2.2, 3.2), ylim = (9.5, 13.0),
                xlabel = L"b_1", ylabel = L"z_{max}", legend = false,
                grid = :none, c = :black, msw = 0.0, msc = :black,
                title = "a", titleloc = :left
                )
# Fig.4 B)
fig4b = scatter(pts_maxloc[:, 1], pts_maxloc[:, 2],
                markersize = 2, markeralpha = 0.5, 
                xlim = (3.0, 6.5), ylim = (3.0, 10.0),
                xticks = 3.0:0.5:6.5, yticks = (3.0:1.0:10.0, string.(3.0:1.0:10.0)),
                xlabel = L"b_1", ylabel = L"z_{max}", legend = false,
                grid = :none, c = :black, msw = 0.0, msc = :black,
                title = "b", titleloc = :left
                )
# Fig.4 C)
fig4c = scatter(pts_maxloc[:, 1], pts_maxloc[:, 2],
                markersize = 2, markeralpha = 0.5,
                xlim = (2.25, 2.6), ylim = (11.4, 12.8),
                xticks = 2.25:0.05:2.60, yticks = 11.1:0.2:12.8,
                xlabel = L"b_1", ylabel = L"z_{max}", legend = false,
                grid = :none, c = :black, msw = 0.0, msc = :black,
                title = "c", titleloc = :left
                )
# Fig.4 - Combine A,B,C
fig4 = plot(fig4a, fig4b, fig4c, layout = (3, 1),
            size = (500, 900), titlefontsize = 11,
            tickfontsize = 8, guidefontsize = 10,
            left_margin = 10Plots.mm, right_margin = 5Plots.mm,
            bottom_margin = 2Plots.mm,
            framestyle = :box
            )

## Export figures
savefig(fig4, joinpath("..", "article", "figures", "fig4.pdf"))
