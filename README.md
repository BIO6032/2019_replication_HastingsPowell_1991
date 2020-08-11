# [Re] Chaos in a Three-Species Food Chain
## 2019 Replication of Hastings & Powell (1991)

This project is a replication and implementation in *Julia v1.3.1* of Hastings & Powell (1991), a classic paper in ecological modelling. Full reference to the original article:

> Hastings, A., & Powell, T. (1991). Chaos in a Three-Species Food Chain. Ecology, 72(3), 896–903. https://doi.org/10.2307/1940591

The goal of this project was to test if the results of the original paper could be reproduced, as well as to provide a fully reproducible version for it on GitHub.

The reproduction was successful for all important results. As a bonus, we represented the dynamics of the three-species system in the following animated 3D GIF:

![Animated three-dimensional phase plot](article/figures/figure2D.gif)

### Model reproduction

All the scripts required to reproduce the model are in the `code/` subfolder.
They assume that `code/` is used as the working directory.

#### Initial setup
To reproduce our project, we recommend the following steps as initial setup, assuming *Julia v1.3.1* is already installed:
1. Clone this repository
```
git clone https://github.com/BIO6032/2019_replication_HastingsPowell_1991.git
```
2. Launch *Julia* in the repository, then set `code/` as the working directory:
```julia
cd("code")
```
3. Run the following commands to install the exact versions of packages (as specified in the Project Environment)
```julia
import Pkg; Pkg.activate(".")
Pkg.instantiate()
```

#### Running the model
After setup, `main.jl` can be run to reproduce all figures in a single call.

```julia
include("main.jl") # make sure you ran cd("code") to set the correct working directory
```

Note that this is not an especially intensive task. On an ordinary laptop, it takes about 1 minute, 2.00 GB of memory and uses a single core. However, if using the packages for the first time, precompiling may take an additional 5 minutes (Julia has to do this after installing or changing versions).

Alternatively, individual scripts in `code/` (producing one figure each) can be run separately after running lines 1-15 of `main.jl` (which will load the packages and the model). To run interactively, simply run the content line-by-line in a terminal or through a Julia IDE, such as [Juno](https://junolab.org/) or [Julia for VS Code](https://www.julia-vscode.org/).

The GIF can be reproduced by running the following. This is longer than for the core figures and takes about 8-10 minutes.

```julia
include("figure2D-gif.jl") # make sure you ran cd("code") to set the correct working directory
```

### Article reproduction

Our article uses the [ReScience C](https://rescience.github.io/) journal template. All elements are in the `article/` subfolder. Instructions to reproduce the article are provided in the subfolder [README](article/README.md).
