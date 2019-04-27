# Methods

The model formulation used in this paper is the same as the one in the original publication. Hastings & Powell used a 10 parameters model to represent the three-species food chain, with $X$ as the numbers of the species at the lowest level of the food chain, $Y$ as the numbers of the species that preys upon $X$, and $Z$ as the species that preys upon $Y$. However, all of their analyses are based on a simpler version of the model with nondimensional measures of time and population size, hence 6 parameters only, and $x$, $y$ and $z$ as the numbers of the three species. We chose to present this simpler nondimensional version only in this paper, and we invite readers to consult Hastings & Powell's paper for more details on the original dimensional parameters. Our model's formulation is given as:

$$ dx/dt = x(1 - x) - f_1(x)y $$
$$ dy/dt = f_1(x)y - f_2(y)z - d_1y $$
$$ dz/dt = f_2(y)z - d_2z $$

with

$$ f_i(u) = a_iu/(1 + b_iu) $$

as the functional response.

The parameter values used in this paper are the same as the ones in the original paper (Table 1). However, the initial conditions of the simulations (i.e. the values of $x$, $y$ and $z$ at the start) were not given in the original paper. This is an important element to mention, as the initial conditions strongly affect the simulations, particularly in the context of examining chaotic behavior. We knew from figure 3 of the original paper that $y \approx 0.75$, and we tried to approximate $x$ and $z$ by trial and errors. In order to replicate the original figures as closely as possible, we used different initial conditions in all of our representations to present the closest matching graphical result. The conditions used are specified in each figure. We believe that the use of such different conditions do not alter the results' interpretation.

Nondimensional parameters and the values used in the simulations
| Nondimensional parameters | Parameter values used in the simulations |
| --- | --- |
| $a_1$ | 5.0 |
| $b_1$ | varied from 2.0 to 6.2 |
| $a_2$ | 0.1 |
| $b_2$ | 2.0 |
| $d_1$ | 0.4 |
| $d_2$ | 0.01 |

As noted by Hastings & Powell, numerical integration is the only way to investigate the global dynamical behavior of the system. We used Julia version 1.1.0 (Bezanson et al., 2017), along with packages "DifferentialEquations.jl" to compute the numerical integrations, "ParameterizedFunctions.jl" to simplify the parameterized function call, and "Plot.jl" to represent our results. We let the "solve" function select the appropriate algorithm to solve our differential equations, as we believe such a function to be more precise at determining the correct algorithm. In our implementation, it selected a composite algorithm combining, amongst others, algorithms Tsit5 and Rosenbrock23.

In order to replicate figure 2 of the original paper, we followed Hastings & Powell's method and let our system run for 10 000 time steps. We then represented the system's behavior by plotting the species nondimensional variables against time (between time steps 5000 and 6500, which eliminates transient behavior), as well as a three dimensional phase plot of the three species (for all time steps ### for now! ###). Note that in this case of the three dimensional phase plot, we had to set RK4 as the solving algorithm, as well as a relative tolerance of $1e-14$; if not, the representation was unexpectedly different from the original paper.

To replicate figure 3 and illustrate the effect of a small change in initial conditions, we plotted the trajectory for species x between time steps 0 and 500 starting at $x = 0.77$, then changed the initial $x$ value by 0.01 (to $x=0.78$) and plotted the new trajectory for the same interval on the same graph.

To replicate figure 4, we constructed a bifurcation diagram for species $z$ where we varied values of $b1$ from 2.2 to 6.2 in steps of 0.01. However, our approach had to be slightly different. Hastings & Powell constructed what we consider a special type of bifurcation diagram, representing only the maxima of z as a function of b1, rather than all possible values in the system's behavior, as in a typical logistic bifurcation diagram for example. This raised the problem of correctly identifying the maxima values in the cycling dynamic. Moreover, Hastings & Powell mentioned that, in order to clarify their figure, they eliminated points resulting from the appearance of secondary local maxima in the cycling dynamics of species $Z$, but they do not provide details on how they identified such points. Hence, we adopted the following method: 1) we selected the 1000 last solutions for our system between time steps 1 and 10 000, in order to eliminate transient behavior; 2) we selected the values that were greater than both their preceding and following values, which identified local maxima only; and 3) we only kept values that were greater than a given threshold of the cycle's maximal amplitude, in order to remove secondary local maxima. We determined by trial and errors that the best threshold was 66%, as it best removed values in apparent second branches of b1 while keeping the values in the primary branch. We note however that for some values of b1, the true solutions of the system were unstable and that the system did not reach a cycling behavior within 10 000 steps. For these values of b1 (37 values, all between 5.01 and 6.2), we could not present any values of $z$ in our bifurcation diagram.

Hastings & Powell mention in their original paper that they also examined the system's behavior when varying $b2$ instead of $b1$, although they do not present the results. We examined the same behavior by constructing another bifurcation diagram of $z$ for values of $b2$ varying from 1.5 to 3.2, using the same method as described above. We fixed $b1 = 3.0$, as it is the example used to illustrate chaotic behavior throughout Hastings & Powell's paper.

###### Add methods description for figure 5

The objective of this paper being to reproduce the main results of the original paper, we did not reproduce its figure 1, which was only a schematic representation of the three-species food chain. All the code used to replicate the original paper is available alongside the article.
