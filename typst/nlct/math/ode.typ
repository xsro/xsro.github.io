= Order Linear Differential Equations

- "https://www.sfu.ca/math-coursenotes/Math%20158%20Course%20Notes/chap_DifferentialEquations.html

== Homogeneity of a Linear DE

Given a linear differential equation
$
F_n(x)(d^n y)/(d x^n)
+F_(n-1)(x)(d^(n-1) y)/(d x^(n-1))
+dots 
+F_2(x)(d^2 y)/(d x^2)
+F_1(x)(d y)/(d x)
+F_0(x)y
=G(x)
$
where $F_i(x)$ and $G(x)$ are functions of $x$,
the differential equation is said to be *homogeneous* 
if $G(x)=0$ and *non-homogeneous* otherwise.

*Note*: One implication of this definition is that $y=0$
 is a constant solution to a linear homogeneous differential equation, 
 but not for the non-homogeneous case.

== First Order Linear Differential Equations

Given a first order non-homogeneous linear differential equation
$
y'+p(t)y=f(t)
$
using variation of parameters the general solution is given by 
$
y(t)=v(t)e^(P(t))+A e^(P(t))
$
where $v'(t)=e^(-P(t))f(t)$ and $P(t)$ is an antiderivative of $-p(t)$

