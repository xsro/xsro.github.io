= Control Algorithm for Double Integrator

== Conventional Sliding Mode Control 

#columns(2,gutter: 21pt)[
  The basic idea of Sliding Mode Control 
  is reduce the order of system.
  Take the double integrator system for example,
  $
  cases(dot(x)=v,dot(v)=u+d)
  $
  The disturbance $d$ here is called *matched disturbance*
  which can be eliminated by SMC.

  Define a *sliding variable* 
  $
  sigma=v+c x.
  $
  Calculate the derivative 
  $
  dot(sigma)=dot(v)+c dot(x)=u+d + c v
  $<eq:sliding_surface>
  Design the control input as $u=-c v -k "sign" (sigma)$.
  The dynamic of the sliding variable is 
  $
  dot(sigma)=-k "sign" (sigma)+delta
  $.
  This means the system state *reaches* the surface $sigma=0$ in finite time.
  Then the system state *slides* in the surface.

  if we need the system converges in finite time, we can desgin the sliding surface @eq:sliding_surface as 
  $
  sigma=v+c |x|^(1/2) "sign"(x)
  $

  == Second Order Sliding Mode Control 

  Twisting Control is the typical controller charaterized by
  $
  u=-k_1 "sign" (x) -k_2 "sign" (v)
  $
  where $(k_1 + k_2) K_m -C > (r_1-r_2) K_M+C$,\
  $(r_1-r_2) K_m >C$.

]


#pagebreak()
== Robust Integral Sign Error 
#columns()[
  @xianContinuousAsymptoticTracking2004 gives the RISE control for double integrator.
  Consider the system 
  $
  dot.double(x)=u-f
  $
  where 
  - $f (x)$ are uncertain nonlinear $C^2$ functions.

  Define $
  e_1=-x\
  e_2=dot(e)_1 +e_1
  $
  The final control law is 
  $
  u =&(k_s+1)e_2(t)-(k_s+1)e_2(0)\
     &+integral_0^t (k_s+1) alpha e_2(tau) + beta "sign" e_2(tau) d tau\
  $ where $beta > norm(N_d(t))+1/alpha norm(dot(N)_d)$ and $alpha > 1/2$ and 
  the control gain $k_s$ is selected sufficiently large relative to the system initial conditions.
  
  Take the derivative of $u$:
  $
  dot(u)= & (k_s +1) dot(e)_2(t)\
               &+ (k_s+1) alpha e_2(t) + beta "sign" e_2(t) \
            = &  (k_s +1)  r+beta "sign" (e_2)
  $
  where $r=dot(e)_2+alpha e_2=dot.double(e)_1+(1+alpha)dot(e)_1+alpha e_1$.
  
  Then
  $
  dot(r)&=-e_2 -dot(u)+N\
  N&=dot.double(e)_1+alpha dot(e)_2+e_2 +dot(f)\
  tilde(N)&=dot.double(e)_1+alpha dot(e)_2+e_2 \
  N_d&=dot(f)
  $
  select 
  $
  V=1/2 e_2^2 + 1/2 e_1^2  + 1/2 r^2+P
  $
  where $L:=r(N_d -beta "sgn" (e_2))$ and $P=xi_b - integral_0^t L(tau) d tau$
  $
  dot(V)
  &=e_2 dot(e)_2 + e_1 dot(e)_1+ r dot(r) -L\
  &=-e_1^2-alpha e_2^2 +e_1 e_2 -r^2 + r tilde(N)-k_s r^2
  $

]


#pagebreak()