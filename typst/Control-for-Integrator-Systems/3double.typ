#import "lib/ode-dict.typ":ode45,get_signal
#import "lib/notation.typ":sig,sign
#import "@preview/cetz:0.2.0"
#import cetz.plot
#import cetz.draw: *

= Control Algorithm for Double Integrator

== Conventional Sliding Mode Control 

#columns(2,gutter: 21pt)[
  The basic idea of Sliding Mode Control 
  is reduce the order of system.
  Take the double integrator system for example,
  $
  dot.double(x)=u+d
  $
  The disturbance $d$ here is called *matched disturbance*
  which can be eliminated by SMC.

  Define a *sliding variable* 
  $
  sigma=dot(x)+c x.
  $
  Calculate the derivative 
  $
  dot(sigma)=dot.double(x)+c dot(x)=u+d + c v
  $<eq:sliding_surface>
  Design the control input as $u=-c v -k "sign" (sigma)$.
  The dynamic of the sliding variable is 
  $
  dot(sigma)=-k "sign" (sigma)+delta.
  $
  This means the system state *reaches* the surface $sigma=0$ in finite time.
  Then the system state *slides* in the surface.

  #let rhs(t,x)={
    let delta=calc.sin(t)
    let c=1
    let sigma=c*x.x1+x.x2
    let rho=1.1
    let u=-rho*sign(sigma)-c*(x.x2)
    let dx=(x1:x.x2,x2:u+delta)
    dx.insert("sigma",sigma)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1),0.01,record_step:0.1)

  The first simulation shows $x$ converges asymptotically.
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x1"),label:$x$)
          plot.add(get_signal(xout,"x2"),label:$dot(x)$)
          plot.add(get_signal(dxout,"sigma"),label:$sigma$)
          // plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
    
    
]
#pagebreak()
== Terminal SMC
#columns(2)[
  If we need the system converges in finite time, we can desgin the sliding surface @eq:sliding_surface as 
  $
  sigma=dot(x)+c⌊x⌉^(q)\
  dot(sigma)=dot.double(x)+q c ⌊x⌉^(q-1))=u+delta + q c ⌊x⌉^(q-1))
  $
  and the corresponding control law is 
  $
  u=-rho "sign" (sigma) -q c ⌊x⌉^(q-1))
  $
  We call this 2-SM(Second Order Sliding Mode).

  When $q<1$,  the term $⌊x⌉^(q-1))$ is singular.
  #colbreak()
    #for q in (1/2,2){
      let rhs(t,x)={
      let delta=calc.sin(t)
      let c=1
      let sigma=c*sig(x.x1,q)+x.x2
      let rho=1.1
      let u=-rho*sign(sigma)-c*q*sig(x.x1,q - 1)
      let dx=(x1:x.x2,x2:u+delta)
      dx.insert("sigma",sigma)
      dx.insert("delta",-delta)
      dx.insert("u",u)
      dx
    }
    let (xout,dxout)=ode45(rhs,20,(x1:2,x2:1),0.01,record_step:0.02)
    [q=#q]
    cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x1"),label:$x$)
          plot.add(get_signal(xout,"x2"),label:$dot(x)$)
          plot.add(get_signal(dxout,"sigma"),label:$sigma$)
          // plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  }
]
#pagebreak()
== Second Order Sliding Mode Control 

  The $n$-th Order Sliding Mode Control means 
  the relative degree of the sliging variable system is $n$ 
  and the controller drives the system variable to zero in *finite time*.

  Consider the system
  $
  dot.double(x)=delta+g(x,t)u
  $
  where $abs(delta)<=C$ and $abs(g(x,t)) in [K_m,K_M]$.

  Twisting Control is the typical controller charaterized by
  $
  u=-k_1 "sign" (x) -k_2 "sign" (v)
  $
  where $(k_1 + k_2) K_m -C > (k_1-k_2) K_M+C$,
  $(k_1-k_2) K_m >C$.

  #let rhs(t,x)={
    let delta=calc.sin(t)
    let k1=6;let k2=2
    let u=-k1*sign(x.x1)-k2*sign(x.x2)
    let dx=(x1:x.x2,x2:u+delta)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1),0.005,record_step:0.02)

  The first simulation shows $x$ converges asymptotically.
  #table(columns: (auto,auto),stroke: none,
    cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x1"),label:$x$)
          plot.add(get_signal(xout,"x2"),label:$dot(x)$)
        },
        y-label:"value",
        x-label:"time",
        )
    }),
    cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:3,
        {
          plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    }))

#pagebreak()
== Robust Integral Sign Error for Double Integrator
#columns()[
  @xianContinuousAsymptoticTracking2004 gives the RISE control for high-order integrator.
  Consider the system 
  $
  dot.double(x)=u-f
  $
  where 
  - $f (x)$ are uncertain nonlinear $C^2$ functions.

  Define $
  e_1=-x\
  e_2=dot(e)_1 +e_1=-dot(x)-x
  $
  The final control law is 
  $
  u =&(k_s+1)e_2(t)-(k_s+1)e_2(0)\
     &+integral_0^t (k_s+1) alpha e_2(tau) + beta "sign" e_2(tau) d tau\
  $ where $beta > norm(N_d (t))+1/alpha norm(dot(N)_d (t))$ and $alpha > 1/2$ and 
  the control gain $k_s$ is selected sufficiently large relative to the system initial conditions.
  
  Take the derivative of $u$:
  $
  dot(u)= & (k_s +1) dot(e)_2(t)\
               &+ (k_s+1) alpha e_2(t) + beta "sign" e_2(t) \
            = &  (k_s +1)  r+beta "sign" (e_2)
  $
  where $r=dot(e)_2+alpha e_2=dot.double(e)_1+(1+alpha)dot(e)_1+alpha e_1=$.
  
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
  =&e_2 dot(e)_2 + e_1 dot(e)_1+ r dot(r) -L\
  =&e_2 (r-alpha e_2)-e_1 (e_2-e_1)\
   &+ r (-e_2 -((k_s+1)r+beta "sign"(e_2))+N)\
    &-r(N_d -beta "sign"(e_2))\
  =&-e_1^2-alpha e_2^2 +e_1 e_2  + r tilde(N)-(k_s+1) r^2\
  =&-e_1^2-alpha e_2^2 +1/2 e_1^2+1/2  e_2^2  + |r| rho(norm(z))norm(z)-(k_s+1) r^2\
  <= & -lambda_3 norm(z)^2 + abs(r) rho(norm(z)) norm(z) -k_s r^2\
  <= & -(lambda_3 - (rho^2(norm(z)))/(4 k_s)) norm(z)^2
  $

]


#pagebreak()