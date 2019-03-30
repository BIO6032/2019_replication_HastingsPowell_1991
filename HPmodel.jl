###Hastings & Powell 1991
###Model equations

###Packages
using Plots, DifferentialEquations

###Define the parameters and equations
f(u,a,b)=a*u/(1+b*u)

function parameterized_model(du,u,p,t)
    x,y,z = u
    a1,a2,b1,b2,d1,d2 = p
    du[1] = dx = x*(1-x) - f(x,a1,b1)*y
    du[2] = dy = f(x,a1,b1)*y - f(y,a2,b2)*z - d1*y
    du[3] = dz = f(y,a2,b2)*z - d2*z
end
