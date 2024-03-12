= First-Order Sliding Mode Controllers

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
   #set par(justify: true)
   Consider the fisrt order system $dot(x)=u+delta$,
  $delta$ is the bounded disturbance $|delta|<C$.
  The first control law is 
  $
  dot(x)=u=-k"sign"x 
  $<single_integrator_sign>
  where $k>C$.

  Select 
  $
  V=1/2 x^2.
  $<single_integrator_sign_V>
  Calculate the derivative along the system trajectory:
  $
  dot(V)
  &=x dot(x)\
  &=x (-k"sign"x+delta)\
  &=-k|x|+x delta\
  &<= -k|x|+|x| |delta|\
  &<=-(k-C)|x|<=0
  $<single_integrator_sign_dV>

  This implies $x arrow 0$( LaSalle's invariance principle) and $dot(x) arrow 0$ (Barbalat's lemma).
  If so, $-k "sign"(x)+delta arrow 0$?

  This differential equation should be understood in *Pilippov sense*.
  The solution here is not a classical(continuously differentiable) solution but a absolutely continuous solution.
  the solution satisfy the *Pilippov DI* (Pilippov Differential Inclusion) of the differential equation.

  We use the concept of *Equivalent Control* describes this feature, that is ,$"sign"x=delta$.
  Use a low pass filter, we can say $"LPF"("sign"(x))approx delta$

  Another important feature of this system is finite-time stability.
  From @single_integrator_sign_V and @single_integrator_sign_dV,
  we have 
  $
  dot(V)(t)<=-(k-C) sqrt(2V(t))
  $
  Let $a=-(k-C)sqrt(2)$ and integrate it. we get
  $
    (d V(t))/sqrt(V(t))<=-a d t \
    2 sqrt(V(t)) - 2 sqrt(V(0))<=-a t\
   sqrt(V(t))<=sqrt(V(0))-a/2 t\
  $
  Consequently, $V(t)$ reaches zero in a ﬁnite time tr that is bounded by
  $
    t_r<=2sqrt(V(0))/a
  $
 ]
)

#pagebreak()

= SMC Chattering Elimination: Quasi-Sliding Mode
In many practical control systems, including DC motors and aircraft control, 
it is important to avoid control chattering by providing continuous/smooth signals.
One obvious solution to make the control function continuous/smooth is to approximate the discontinuous function $v(sigma)=-rho "sign" (sigma)$ by some continuous/smooth function.
For instance, it could be replaced by a "sigmoid function".
#import "smc/quasi-sliding.typ":sigmoid
#sigmoid()
#pagebreak()

= SMC Chattering Attenuation: Asymptotic Sliding Mode

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  *Assume $dot(delta)$ is also bounded and $dot(x)$ is measurable.* 
  Let $|dot(delta)|<=C_1$. Define $s=x+c dot(x)$. 
  The control law is given by 
  $
  dot(u)=v\
  v=-rho "sign"(s)-1/c u
  $
  Select 
  $
  V=1/2 s^2
  $
  Calculate the derivative along the system trajectory:
  $
  dot(V)&=s dot(s)=s(dot(x)+c dot.double(x))\
            &= s(u+delta+c(v+dot(delta)))\
            &= s(- c rho "sign"(s) +delta + c dot(delta))\
            &<=-(c rho - C-c C_1)|s| 
  $
  $s$ converges to zero in finite time while $x$ converges to zero asymptotically.
])

#pagebreak()

= Integral Sliding Mode Control

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  Assuming the initial conditions are known,
  we can split the control with
  $
  dot(x)=u+delta \
  u=u_1+u_2=-rho_1 "sign" (s)-k x
  $
  The auxiliary sliding variable is designed as
  $
  cases(s=x-z,dot(z)=u_2=-k x,)
  $
  then
  $
  dot(s)=dot(x)-dot(z)=u+delta-u_2=u_1-delta
  $
  Select 
  $
  u_1=-rho_1 "sign" (s)
  $
  Then 
  $
  s=0 arrow.double x=z arrow.double u_2=dot(z)=dot(x)
  $
  So design $u_2=-k x$ such that $dot(x)=-k x$

  Now we will address the issue of starting the auxiliary sliding mode from the very beginning without any reaching phase. In order to achieve it we have to enforce the initial condition $s(0)=0 $
  $
  s(0)=0 arrow.double z(0)=x(0)
  $

  Advantage: We can set $z(0)$ to keep $s(0)=0$, The system is starting from  auxiliary sliding surface.

])

#pagebreak()
= Super Twist Algorithm (STA)

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  $
  dot(x)=u+delta \
  u=c |x|^(1/2) "sign"(x)+w\
  dot(w)=b "sign"(x)
  $

  - The super-twisting control is a *second-order* sliding mode control, since it drives both $sigma arrow 0$ and $dot(sigma) arrow 0$ in finite time. 
  - The super-twisting control is *continuous*.
 ]
)

#pagebreak()