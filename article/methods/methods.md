# Methods

The model formulation used in this paper is the same as the one used in Hastings & Powell's original paper. The three-species food chain has $X$ as the numbers of the species at the lowest level of the food chain, $Y$ as the numbers of the species that preys upon $X$, and $Z$ as the species that preys upon $Y$. The first form of the model is given as:

$$ dX/dT = R_0X(1 - X/K_0) - C_1F_1(X)Y $$
$$ dY/dT = F_1(X)Y - F_2(Y)Z - D_1(Y) $$
$$ dZ/dT = C_2F_2(Y)Z - D_2Z $$

with

$$ F_i(U) = A_iU/(B_i + U) $$ for $$ i = 1,2 $$

as the functional response. T represents time, $R_0$ is the "intrinsic growth rate" and $K_0$ the "carrying capacity" of species X, $C_1^-1$ and $C_2$ are conversion rates of prey to predator for species Y and Z respectively, $D_1$ and $D_2$ are constant death rates for species Y and Z respectively, $A_i$ and $B_i$ for $i = 1,2$ parametrize the saturating functional response; $B_i$ is the prey population level where the predation rate per prey unit is half its maximum value.

The specified model has 10 dimensional parameters and is hard to analyse; hence, Hastings | Powell chose to reduce the number of parameters and to nondimensionalize the system by posing

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

As noted by the Hastings and Powell, numerical integration is the only way to investigate the global dynamical behavior of the system. We used Julia version 1.1.0 (Bezanson et al., 2017), along with packages "DifferentialEquations.jl" to compute the numerical integrations, "ParameterizedFunctions.jl" to simplify the parameterized function call, and "Plot.jl" to represent our results. We chose algorithm ????? as the most appropriate to our differential equations. The objective of this paper being to reproduce the main results of the original publication, we did not reproduce its figure 1, which was only a schematic representation of the three-species food chain. All the code used to replicate the original paper is available alongside the article.
