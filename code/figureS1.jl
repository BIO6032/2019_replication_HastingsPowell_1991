### Hastings & Powell 1991
## Examining behavior when varying b2 value

### Figure S1 (Bifurcation diagram)

## Wrap in function
# b1val : value of b1
# b2low : lower limit of b2 values to examine
# b2up : upper limit of b2 values to examine
# out : desired output plot, either "maxloc" for local maxima only (default) or "all" for all values
function b2_behavior(;b1val::Float64, b2low::Float64=1.5, b2up::Float64=3.2,out::String="maxloc")
  ## Define initial parameters
  p = a1,a2,b1,b2,d1,d2 = [5.0,0.1,b1val,b2low,0.4,0.01]
  u0 = [1.0,1.0,1.0]
  tspan = (0.0,10000.0)
  # b1 values interval
  bs = collect(b2low:0.01:b2up)
  # number of values to collect
  N = 1000

  ## Loop to select all values of z for all b1 values
  Z = zeros(Float64, (N,length(bs)))
  Zmax = zeros(Float64, length(bs))
  Zmin = zeros(Float64, length(bs))
  errors = zeros(Float64, length(bs))
  for j in 1:length(bs)
    # Change b1 value
    p[4] = b2 = bs[j]
    # Solve for given b1 value
    prob = ODEProblem(parameterized_model,u0,tspan,p)
    sol = solve(prob)
    # Save values
    if length(sol[3,:]) > N
      Z[:,j] = sol[3,end-(N-1):end]
      Zmax[j] = maximum(Z[:,j])
      Zmin[j] = minimum(Z[:,j])
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
    if Z[i,j] > Z[i-1,j] && Z[i,j] > Z[i+1,j]
      # Select first local maxima only with arbitrary interval
      Zrange = Zmax[j] - Zmin[j]
      if Z[i,j] > (Zmin[j] + 0.66*(Zrange) )
         Zmaxloc[i,j] = Z[i,j]
      end
    end
  end
  Zmaxloc

  ## Visualize results
  # Vector of b1 values repeated N times
  B = repeat(bs, inner=N)
  # Match local maxima with respective b1 value
  pts_all = unique(hcat(B, vec(Z)); dims=1)
  pts_maxloc = unique(hcat(B, vec(Zmaxloc)); dims=1)
  # Remove null values
  pts_all = pts_all[pts_all[:,2] .> 0.00,:]
  pts_maxloc = pts_maxloc[pts_maxloc[:,2] .> 0.00,:]
  # Select desired output (out parameter value)
  if out == "maxloc" # default
    results = pts_maxloc
  end
  if out == "all" # default
    results = pts_all
  end
  # Plot results (bifurcation diagram)
  scatter(results[:,1], results[:,2],
          markersize=1,
          xlabel="b2", xlim=(b2low,b2up), xticks=b2low:0.25:b2up,
          ylabel="Zmax", yticks=(0.0:2.0:maximum(results[:,2]), string.(0.0:2.0:maximum(results[:,2]))),
          legend=false, grid=:none,
          c=:black)
end

# Examine behavior when changing b2 at b1 = 3.0
figS1_maxloc = b2_behavior(b1val=3.0, b2low=1.5, b2up=3.2,
                            out="maxloc") # default parameters
figS1_all = b2_behavior(b1val=3.0, out="all")

## Export figures
savefig(figS1_maxloc, joinpath("..", "article", "figures", "figS1"))

# Additionnal examinations
b2_behavior(b1val=2.0)
b2_behavior(b1val=4.0)
b2_behavior(b1val=5.0)
b2_behavior(b1val=6.0)
b2_behavior(b1val=1.5)
