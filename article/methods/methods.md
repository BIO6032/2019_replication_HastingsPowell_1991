# Methods

The model formulation used in this paper is the same as the one used in Hastings & Powell's original paper. The three-species food chain has $X$ as the numbers of the species at the lowest level of the food chain, $Y$ as the numbers of the species that preys upon $X$, and $Z$ as the species that preys upon $Y$. The first form of the model is given as:

$$ dX/dT = R_0X(1 - X/K_0) - C_1F_1(X)Y $$
$$ dY/dT = F_1(X)Y - F_2(Y)Z - D_1(Y) $$
$$ dZ/dT = C_2F_2(Y)Z - D_2Z $$

with

$$ F_i(U) = A_iU/(B_i + U) $$ for $$ i = 1,2 $$

as the functional response. T represents time, $R_0$ is the "intrinsic growth rate" and $K_0$ the "carrying capacity" of species X, $C_1^-1$ and $C_2$ are conversion rates of prey to predator for species Y and Z respectively, $D_1$ and $D_2$ are constant death rates for species Y and Z respectively, $A_i$ and $B_i$ for $i = 1,2$ parametrize the saturating functional response; $B_i$ is the prey population level where the predation rate per prey unit is half its maximum value.

The specified model has 10 dimensional parameters and is hard to analyse; hence, Hastings & Powell chose to reduce the number of parameters and to nondimensionalize the system by posing

$$ x = X/K_0 $$
$$ y = C_1Y/K_0 $$
$$ z = C_1Z/(C_2K_0) $$
$$ t = R_0T $$

from which we obtain the new system of equations with nondimensional measures of time and population size as

$$ dx/dt = x(1 - x) - f_1(x)y $$
$$ dy/dt = f_1(x)y - f_2(y)z - d_1y $$
$$ dz/dt = f_2(y)z - d_2z $$

with

$$ f_i(u) = a_iu/(1 + b_iu) $$

The parameter values used in this paper are the same as the ones in the original paper and are given in Table 1. However, the initial conditions of the simulations (i.e. the values of $x$, $y$ and $z$ at the start) were not given in the original paper. This is an important element to mention, as the initial conditions strongly affect the simulations, particularly in the context of examining chaotic behavior, as we will show in the next section. We knew from figure 3 of the original paper that $y \approx 0.75$, and we tried to approximate $x$ and $z$ by trial and errors. In order to replicate the original results as closely as possible, we used slightly different initial conditions in all of our representations to present the closest matching graphical result. Nevertheless, we believe that the slight graphical mismatches caused by the different original conditions do not alter the result's interpretation; thus, we still consider the original results as fully replicated.


Nondimensional parameters and values of the parameters used in the simulations
|Nondimensional parameters | Dimensional parameters | Parameter values used in the simulations |
| --- | --- | --- |
| $a_1$ | $(K_0A_1)/(R_0B_1)$ | 5.0 |
| $b_1$ | $K_0/B_1$ | varied from 2.0 to 6.2 |
| $a_2$ | $(C_2A_2K_0)/(C_1R_0B_2)$ | 0.1 |
| $b_2$ | $K_0/(C_1B_2)$ | 2.0 |
| $d_1$ | $D_1/R_0$ | 0.4 |
| $d_2$ | $D_2/R_0$ | 0.01 |

As noted by the Hastings & Powell, numerical integration is the only way to investigate the global dynamical behavior of the system. We used Julia version 1.1.0 (Bezanson et al., 2017), along with packages "DifferentialEquations.jl" to compute the numerical integrations, "ParameterizedFunctions.jl" to simplify the parameterized function call, and "Plot.jl" to represent our results. We let the "solve" function select the appropriate algorithm to solve our differential equations, as we believe such a function to be more precise than us at determining the correct algorithm. In our implementation, it selected a composite algorithm combining, amongst others, algorithms Tsit5 and Rosenbrock23.

In order to replicate figure 2 of the original paper, we followed Hastings & Powell's method and let our system run for 10 000 time steps. We then represented the system's behavior by plotting the species nondimensional variables against time (between time steps 5000 and 6500 as in the original paper, which eliminates transient behavior), as well as a three dimensional phase plot of the three species (for all time steps). Note that while plotting the species against time, we achieved the closest matching result to Hastings & Powell's original figure by using initial conditions $x=1$, $y=1$ and $z=1$. In the three dimensional phase plot, our best match was achieved with conditions $x=0.7$, $y=0.8$ and $z=8$. In this case, we also had to set RK4 as the solving algorithm, as well as a relative tolerance of $1e-14$; if not, the system's behavior was unexpectedly different from the original paper.

To replicate figure 3 and illustrate the effect of a small change in initial conditions, we used conditions $x=0.77$, $y=0.16$ and $z=9.9$ (again to have the closest match), plotted the trajectory for species x between time steps 0 and 500, then changed the initial $x$ value by 0.01 (to $x=0.78$) and plotted the new trajectory for the same interval on the same graph.

To replicate figure 4, we also constructed a bifurcation diagram for species $z$ where we varied values of b1 from 2.2 to 6.2 in steps of 0.01. However, we had to develop a slightly different approach. Hastings & Powell constructed what we consider a special type of bifurcation diagram, representing only the maxima of z as a function of b1, rather than all possible values in the system, as in a logistic bifurcation diagram for example. This raised the problem of correctly identifying the maxima values in the cycling dynamic. Moreover, Hastings & Powell mention that, in order to clarify their figure, they eliminated points resulting from the appearance of secondary local maxima in the cycling dynamics of species $Z$. Hence, we selected the values to put in our bifurcation diagrams using the following method: 1) we selected the 1000 last solutions for our system between time steps 1 and 10 000, in order the eliminate transient behavior; 2) we then selected the values that were greater than both their preceding and following value, which identified local maxima only; and 3) we only kept values that were greater than 66% of the cycle's maximal amplitude, in order to remove secondary local maxima. This threshold of 66% was determined by trial and errors to be the one that best removed values in second branches of b1 while keeping the values in the primary branch. We note however that for some values of b1, the true solutions of the system were unstable and the system does not reach a cycling behavior within 10 000 steps. For these values of b1 (37 values between 5.01 and 6.2), we could not present any values of $z$ in our bifurcation diagram.

###### Add methods description for figure 5

The objective of this paper being to reproduce the main results of the original paper, we did not reproduce its figure 1, which was only a schematic representation of the three-species food chain. All the code used to replicate the original paper is available alongside the article.
