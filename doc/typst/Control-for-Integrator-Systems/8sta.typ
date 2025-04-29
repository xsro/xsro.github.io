#import "lib/lib.typ":sig,sgn

= Super Twisting Control

The STA (Super Twisting Algorithm) can be written as
$
dot(x)_1&=-k_1 sig(x_1)^(1/2)+x_2+rho.alt_1(x,t)\
dot(x)_2&=-k_2 sgn(x_1)+rho.alt_2(x,t)
$<classical_sta>
where $x_i$ are the scalar state variables, 
$k_i$ are gains to be designed,
and $rho.alt_i$ are the perturbation terms.
*Under some conditions on $k_i$, the algorithm is robust against a bounded perturbation* 
$rho.alt_1(x,t)=0$, $abs(rho.alt_2(x,t)) <= L$.
Since the righthand side of @classical_sta is discontinuous,
the solutions will be understood in the sense of *Filippov*.

Finite time convergence and robustness for the STA has been proved by 
+ *geometrical methods* @levant_principles_2007
+ *Homogeneity properties* of the algorithm @levant_homogeneity_2005 @orlov_finite_2004

- Weak Lyapunov function $V_w(x)=k_2 abs(x_1) + 1/2 x_2^2$ @orlov_finite_2004, $sqrt(V_w(x))$ @Utkin2017
- Strong Lyapunov function: $V$ in @polyakov_reaching_2009,@moreno_strict_2012,@seeber_stability_2017


"Weak" measns $dot(V)_w(x)=-k_1k_2 abs(x_1)^(1/2)$ is only negative semidefinite. (Finite time) convergence can only be asserted by using a generaization of LaSalle's invariance principle for discontinuous systems @orlov_finite_2004, but it is not possible to provide robustness results, or to estimate the convergence time from it.
@Utkin2017 analyse the weak Lyapunov function $sqrt(V_w(x))$ and the finite time and robust convergence for the STA is proved.

#pagebreak()

== Strick Lyapunov Functions for STA
#set math.mat(delim: "[")
#columns(2)[
  #set cite(form:"full")
  @polyakov_reaching_2009
  $
  V=cases(
    k^2/4 ((y sgn(x_1))/gamma+k_0 e^(m(x_1,x_2))sqrt(s(x_1,x_2)))^2 quad & x_1 x_2!=0,
    (2 k^2 x_2^2)/(alpha^2) & x_1=0,
    abs(x_1)/2              & x_2=0
  )
  $
  @moreno_strict_2012
  $
  V(x)=zeta^T P zeta,
  zeta=mat(sig(x_1)^(1/2);x_2)
  $
  @seeber_stability_2017
  $
  V(x)=cases(
    2 sqrt(x_2^2+ 3 alpha^2 k_1^2 x_1)-x_2 
    quad & x in M,
    2 sqrt(x_2^2+ 3 alpha^2 k_1^2 x_1)+x_2 & -x in M,
    3 abs(x_2) &"otherwise"
  )
  $
]
#pagebreak()

