== Numerical methods for ode

The closed-loop control system is usually written as 
$
dot(x)=f(t,x).
$
To verify the control performance, several numerical method is important.

- https://www.math.hkust.edu.hk/~machas/numerical-methods-for-engineers.pdf

=== Euler method -- First Order

$
x_(n+1)=x_n+Delta t f(t_n,x_n)
$
For small enough $Delta t$, 
the numerical solution should converge to the exact solution of the ode, 
when such a solution exists.
The Euler Method has a local error, that is, the error incurred over a single time step,
of $O(Delta t^2)$. 
The global error, however, 
comes from integrating out to a time $T$. 
If this integration takes $N$ time steps, 
then the global error is the sum of $N$ local errors. 
Since $N = T/(∆t)$, the global error is given by $O(∆t)$, 
and it is customary to call the Euler Method a first-order method. 

=== Modified Euler,Heun’s method,predictor-corrector method -- Second Order

$
k_1=Delta t f(t_n,x_(n)) quad 
k_2=Delta t f(t_n+Delta t, x_n+k_1)\
x_(n+1)=x_n+1/2  (k_1+k_2)
$

=== Runge-Kutta methods

First, we compute the Taylor series for $x_(n+1)$ directly:
$
x_(n+1)=x(t_n+Delta t)=x(t_n)+Delta t dot(x)(t_n)+1/2 (Delta t)^2 dot.double(x)(t_n)+O(Delta t^3)
$
Now, $dot(x)(t_n)=f(t_n,x_n)$.
The second derivative is more tricky and requires partial derivatives.
We have 
$
dot.double(x)(t_n)
=lr(d/(d t)f(t,x(t))|)_(t=t_n)
=f_t (t_n,x_n)+dot(x)(t_n) f_x (t_n,x_n)
=f_t (t_n,x_n)+f(t_n,x_n) f_x (t_n,x_n)
$
Putting all the terms together, we obtain
$
x_(n+1)=x_n+Delta t f(t_n,x_n)
+1/2(Delta t)^2(f_t (t_n,x_n)+f(t_n,x_n)+f(t_n,x_n)f_x(t_n,x_n))+O(Delta t^3)
$<talyor>
Second, we compute the Taylor series for $x_(n+1)$ from the Runge-Kutta formula.
We start with 
$
x_(n+1)=x_n+a Delta t f(t_n,x_n)+b Delta t f(t_n + alpha Delta t, x_n + beta Delta t f(t_n,x_n))+O(Delta t^3)
$
and the Taylor series that we need is 
$
f(t_n+ alpha Delta t, x_n + beta Delta t f(t_n,x_n))\
=f(t_n,x_n)
+ alpha Delta t f_t(t_n,x_n)
+ beta Delta t f(t_n,x_n) f_x(t_n,x_n)
+ O(Delta t^2)
$
The Taylor-series for $x_(n+1)$ from the Runge-Kutta method is therefore given by 
$
x_(n+1)=x_n + (a+b) Delta t f(t_n, x_n)
+ (Delta t)^2 (alpha b f_t(t_n,x_n)+beta b f(t_n,x_n)f_x(t_n,x_n))+O(Delta t^3)
$<rk>
Comparing @talyor and @rk, we find three constraints for the four constants.
$
a+b=1,
alpha b =1\/2,
beta b = 1\/2
$

=== Second-order Runge-Kutta methods

The family of second-order Runge-Kutta methods that solve $dot(x)=f(t,x)$ is given by 
$
k_1=Delta t f(t_n,x_n),quad 
k_2=Delta t (f_n+ alpha Delta t,x_n+beta k_1),\
x_(n+1)=x_n+a k_1 + b k_2
$
where we have derived three constraints for the four constants $alpha$,$beta$,$a$ and $b$:
$
a+b =1 , alpha b =1/2, beta b=1/2
$
The modified Euler method corresponds to $alpha=beta=1$ and $a=b=1/2$.
The function $f(t,x)$ is evaluated at the times $t=t_n$ and $t=t_n+Delta t$.

The midpoint method corresponds to $alpha=beta=1/2$, $a=0$ and $b=1$.
In this method, the function $f(t,x)$ is evaluated at the times $t=t_n$
and $t=t_n+Delta t \/2 $ and we have 
$
k_1=Delta t f(t_n,x_n) quad 
k_2=Delta t f(t_n+1/2 Delta t, x_n+1/2 k_1),\
x_(n+1)=x_n+k_2
$

=== Higher Order Runge-Kutta methods

Higher-order Runge-Kutta methods can also be derived,
but require substantially more algebra. 
For example, the general form of the third-order method is given by 
$
k_1&=Delta t f(t_n,x_n),\
k_2&=Delta t f(t_n+alpha Delta t, x_n+beta k_1),\
k_3&=Delta t f(t_n + gamma Delta t, x_n+delta k_1+epsilon k_2),\
x_(n+1)&=x_n+ a k_1+b k_2+c k_3
$
with constraints $alpha$,$beta$,$gamma$,$delta$,$epsilon.alt$,$a$,$b$ and $c$.
The foutth-order method has stages $k_1$,$k_2$,$k_3$ and $k_4$.
The fifth-order methood requires at least six stages. 
The table below gives the order of the method and the minimum number of stages required.

#align(center)[ 
#table(columns:8,[order],..(2,3,4,5,6,7,8).map(i=>[#i]),
       [minimum \#stage],..(2,3,4,6,7,9,11).map(i=>[#i]))
]

Because the fifth-order method requires two more stages than the fourth-order method,
the fourth-order method has found some popularity.
The general fouth-order method with four stages has 13 constants and 11 constraints.
A particularly simple fourth-order method that has been widely used in the past by physicsts ig given by 
$
k_1&=Delta t f(t_n,x_n),quad 
&k_2&=Delta t f(t_n+1/2 Delta t, x_n+1/2 k_1),\
k_3&=Delta t f(t_n+1/2 Delta t, x_n+1/2 k_2),
&k_4&=Delta t f(t_n+Delta t,x_n+k_3);\
$
$
x_(n+1)=x_n+1/6(k_1+2k_2+2k_3+k_4)
$

=== Adaptive Runge-Kutta methods

An adaptive ode solver automatically finds the best integration step-size $Delta t$ at each time step.
The Dormand-Prince method, which is implemented in #smallcaps("MATLAB")'s most widely used solver, #link("https://ww2.mathworks.cn/help/matlab/ref/ode45.html?lang=en")[`[t,y,te,ye,ie] = ode45(odefun,tspan,y0,options)`],
determines the step size by comparing the results of fourth- and fifth- order Runge-Kutta methods.
This solver requires six function evaluations per time step, 
and saves computational time by constructing both fourth- and fifth-order methods using the same function evaluation's.

=== stiff ODE

- https://ww2.mathworks.cn/help/matlab/math/solve-stiff-odes.html?lang=en

For some ODE problems, the step size taken by the solver is forced down to an unreasonably small level in comparison to the interval of integration, even in a region where the solution curve is smooth. *These step sizes can be so small that traversing a short time interval might require millions of evaluations*. This can lead to the solver failing the integration, but even if it succeeds it will take a very long time to do so.

Equations that cause this behavior in ODE solvers are said to be stiff. The problem that stiff ODEs pose is that explicit solvers (such as ode45) are untenably slow in achieving a solution. This is why ode45 is classified as a nonstiff solver along with ode23, ode78, ode89, and ode113.

Solvers that are designed for stiff ODEs, known as stiff solvers, typically do more work per step. The pay-off is that they are able to take much larger steps, and have improved numerical stability compared to the nonstiff solvers.