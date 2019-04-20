### Hastings & Powell 1991
### Model equations

### Packages
using ParameterizedFunctions

### Define parameters and equations
f(u,a,b)=a*u/(1+b*u)

parameterized_model = @ode_def begin
    dx = x*(1-x) - f(x,a1,b1)*y
    dy = f(x,a1,b1)*y - f(y,a2,b2)*z - d1*y
    dz = f(y,a2,b2)*z - d2*z
end a1 a2 b1 b2 d1 d2
