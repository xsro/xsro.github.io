#import "../lib/lib.typ":ode45,get_signal,op,sig
#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart
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
    let u=-rho*op.sign(sigma)-c*(x.x2)
    let dx=(x1:x.x2,x2:u+delta)
    dx.insert("sigma",sigma)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1),0.01,record_step:0.01)

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
          plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
    
    
]
#pagebreak()
== Terminal SMC

#let sig(x)="⌊"+x+"⌉"
#columns(2)[
  For $dot.double(x)=u+delta(t)$, we can design SM manifold as 
  $sigma=dot(x)+c⌊x⌉^(q)$ and its derivative is 
  $
  dot(sigma)=dot.double(x)+q c sig(x)^(q-1)=u+delta + q c sig(x)^(q-1)
  $
  where $sig(x)=abs(x)"sign"(x)$.
  Then, the corresponding control law is 
  $
  u=-k "sign" (sigma) -q c ⌊x⌉^(q-1), k>sup_(t>=0) abs(delta(t))
  $

  - $0<q<1$: finite-time, but the term $⌊x⌉^(q-1)$ causes singularity
  - $q=1$: exponentially stable and non-singular 
  - $q>1$: asymptotically stable and non-singular 

  @FENG20022159
  To achieve finite-time convergence without singularity, non-singular terminal sliding mode controller (NTSMC) is proposed.
  Design the sliding mode surface $sigma = x + 1/alpha ⌊dot(x)⌉^p$ ($1<p<2$), its derivative is
  $
    dot(sigma)
    &= dot(x) + 1/alpha p sig(dot(x))^(p-1) dot.double(x)
    = dot(x) + 1/alpha p sig(dot(x))^(p-1) (u+delta)\
    &= -k"sign"(sigma) +1/alpha p sig(dot(x))^(p-1)delta
  $
  where $dot(x) + 1/alpha p sig(dot(x))^(p-1) (u)=-k"sign"(sigma)$.
  Then, the controller is
  $
    u=-alpha/p sig(dot(x))^(1-p) (dot(x)+k "sign"(sigma)).
  $
  $k$ should be sufficiently large $k>1/alpha p abs(dot(x)(t))^(p-1) abs(delta(t))$. 

  *Hint*: condition $p>1$ guarantees $k>1/alpha p abs(dot(x)(t))^(p-1) abs(delta(t))$ valid. condition $p<2$ guarantees finite-time stability in sliding surface.

  #let plot_one(q,sat)={
    let rhs(t,x)={
      let delta=calc.sin(t)
      let c=1
      let sigma=c*op.sig(x.x1,q)+x.x2
      let rho=1.1
      let u=-rho*op.sign(sigma)-c*q*op.sat(op.sig(x.x1,q - 1),sat)
      let dx=(x1:x.x2,x2:u+delta)
      dx.insert("sigma",sigma)
      dx.insert("delta",-delta)
      dx.insert("u",u)
      dx
    }
    let (xout,dxout)=ode45(rhs,20,(x1:2,x2:1),0.01,record_step:0.02)
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

  q=1/2, singularity problem causes the system panick
  #plot_one(1/2,float.inf)

  q=1/2, saturation value $1$ used outside $sig(x)^(q-1)$
  #plot_one(1/2,1)
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
  u=-k_1 "sign" (x) -k_2 "sign" (dot(x))
  $
  where $(k_1 + k_2) K_m -C > (k_1-k_2) K_M+C$,
  $(k_1-k_2) K_m >C$.

  #let rhs(t,x)={
    let delta=calc.sin(t)
    let k1=6;let k2=2
    let u=-k1*op.sign(x.x1)-k2*op.sign(x.x2)
    let dx=(x1:x.x2,x2:u+delta)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1),0.005,record_step:0.02)

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
== Second Order Sliding Mode Control: Suboptimal Algorithm

  Consider the system
  $
  dot.double(x)=delta+g(x,t)u
  $
  where $abs(delta)<=C$ and $abs(g(x,t)) in [K_m,K_M]$.

  The so-called *suboptimal* controller is given by 
  $
  u=-k_1 "sign" (x-(x^*)/2) +k_2 "sign" (x^*)
  $
  where $
  k_1-k_2>C/(K_m),quad
  k_1 + k_2 > (4C+K_M (k_1-k_2))/(3 K_m),
  $
  and $x^*$ is the value of $x$ detected at the last time whien $dot(x)$ was equal to $0$.
  #let xstar=0;
  #let rhs(t,x)={
    let delta=calc.sin(t)
    let k1=3;let k2=1
    let xstar=x.xstar
    if calc.abs(x.x2) < 0.01{
      xstar=x.x1
    }

    let u=-k1*op.sign(x.x1 - xstar/2)+k2*op.sign(xstar)
    let dx=(x1:x.x2,x2:u+delta,xstar:xstar)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1,xstar:0),0.005,record_step:0.02,force_update:("xstar"))

  #table(columns: (auto,auto),stroke: none,
    cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: auto, y-tick-step:1,
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
          plot.add(get_signal(xout,"xstar"),label:$x^*$)
        },
        y-label:"value",
        x-label:"time",
        )
    }))

#pagebreak()
== Second Order Sliding Mode Control : Quasi-Continuous Control Algorithm 

An important class of controllers comprises the recently proposed so-called quasicontinuous controllers, featuring control continuous everywhere except the 2-sliding manifold
$x=dot(x)=0$.
$
u=-alpha 
(dot(x)+beta sig( x )^(1/2))
/(abs(dot(x))+beta abs(x)^(1/2))
$
  #let rhs(t,x)={
    let delta=calc.sin(t)
    let alpha=6;let beta=2
    let num=x.x2+beta*op.sig(x.x1,1/2)
    let den=calc.abs(x.x2)+beta*calc.sqrt(calc.abs(x.x1))
    let u=-alpha*num/den;
    let dx=(x1:x.x2,x2:u+delta)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x1:2,x2:1),0.005,record_step:0.02)

  #table(columns: (auto,auto),stroke: none,
    cetz.canvas({
      plot.plot(
        size: (8,3),
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
        size: (8,3),
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
  =&e_2 dot(e)_2 + e_1 dot(e)_1+ r dot(r) -L\
  =&e_2 (r-alpha e_2)-e_1 (e_2-e_1)\
   &+ r (-e_2 -((k_s+1)r+beta "sign"(e_2))+N)\
    &-r(N_d -beta "sign"(e_2))\
  =&-e_1^2-alpha e_2^2 +e_1 e_2  + r tilde(N)-(k_s+1) r^2\
  =&-e_1^2-alpha e_2^2 +1/2 e_1^2+1/2  e_2^2  + |r| rho(norm(z))norm(z)-(k_s+1) r^2\
  <= & -lambda_3 norm(z)^2 + abs(r) rho(norm(z)) norm(z) -k_s r^2\
  <= & -(lambda_3 - (rho^2(norm(z)))/(4 k_s)) norm(z)^2
  $

  #let rhs(t,x)={
    let delta=calc.sin(t)
    let c=1
    let e1=- x.x1
    let e2=-x.x2 - x.x1
    let ks=1
    let e20=-3
    let alpha=1
    let beta=1
    let u=(ks+1)*e2 - (ks+1)*e20+x.w;
    let dw=(ks+1)*alpha*e2+beta*op.sign(e2)
    let dx=(x1:x.x2,x2:u+delta,w:dw)
    dx.insert("delta",-delta)
    dx.insert("u",u)
    dx
  }
  #colbreak()
  #let (xout,dxout)=ode45(rhs,20,(x1:2,x2:1,w:0),0.01,record_step:0.02)
  #cetz.canvas({
    plot.plot(
      size: (8,3),
      axis-style: "school-book", 
      x-tick-step: 5, y-tick-step:1,
      {
        plot.add(get_signal(xout,"x1"),label:$x$)
        plot.add(get_signal(xout,"x2"),label:$dot(x)$)
      },
      y-label:"value",
      x-label:"time",
      )
    })
    #cetz.canvas({
    plot.plot(
      size: (8,3),
      axis-style: "school-book", 
      x-tick-step: 5, y-tick-step:3,
      {
        plot.add(get_signal(dxout,"delta"),label:$-delta$)
        plot.add(get_signal(dxout,"u"),label:$u$)
        plot.add(get_signal(xout,"w"),label:$w$)
      },
      y-label:"value",
      x-label:"time",
      )
    })
]


#pagebreak()