#import "template.typ": template

#show: template.with(
  title:[*Sliding Mode Control*],
  part:[*part 2*: SMC for double-integrators ]
)

#import "./lib/lib.typ":ode45,get_signal,op,sig,sgn
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
  $<eq_smc>
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
    
  == Order of SMC

  There are two consistent definitions for the order of sliding mode:
  - *relative degree*: the order of the lowest derivative of $sigma$ in which $u$ appears explicitly.
  - *discontinuity order* (I recommend): the order of the lowest discontinuous derivative of $sigma$ along the sliding motion.

  Higher-order sliding modes produce smoother control signals and significantly reduce chattering.

  #table(
    columns: 3,
    rows: 3,
    [Order], [Condition], [Algorithm],
    [1], [$s=0$, $dot(s)$ discontinuous], [SMC #ref(<eq_smc>)],
    [2], [$s,dot(s)=0$, $dot.double(s)$ discontinuous], [STA,Twisting],
    [n], [$s,dots,s^((n-1))=0$, $s^((n))$ discontinuous], [HOSM],
  )
]
#pagebreak()
== Terminal SMC

#columns(2)[
  === Terminal SMC
  
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

  

  === Non-singular terminal SMC (NTSMC)

  NTSMC#footnote(cite(<FENG20022159>,form:"full")) is proposed to ensure finite-time stability without singularity.
  Design the sliding mode surface $sigma = x + 1/alpha ⌊dot(x)⌉^p$ ($1<p<2$), its derivative is
  $
    dot(sigma)
    = dot(x) + 1/alpha p sig(dot(x))^(p-1) dot.double(x)
    = dot(x) + 1/alpha p sig(dot(x))^(p-1) (u+delta).
  $
  Let $dot(sigma)=1/alpha p sig(dot(x))^(p-1)(delta(t)-k"sign"(sigma))$.
  Then, the controller is
  $
    u=- (alpha/p sig(dot(x))^(2-p)+k "sign"(sigma)).
  $
  $k$ should be sufficiently large $k>sup_(t>=0)abs(delta(t))$. 

  *Hint*: 
  $p>1$ guarantees finite-time stability in sliding surface.
  $p<2$ guarantees $sig(dot(x))^(2-p)$is non-singular.   

  === Prescribed-time NTSMC

  Using Time-varying gain (TVG), NTSMC can be prescribed-time stable. 
  #footnote()[see #cite(<Shi10665914>), it adopts a non-singular TVG with a parameter $T_s$ in #cite(<Shi10665914>)'s eq (14). 
  For simplicity, we use a singular one here.]
  TVG:
  $mu(t)=T_p/(T_p-t)$, $t in [0,T_p)$.
  SM manifold: 
  $sigma=x+(k_1 mu(t))^(-p)dot(x)^(p/q)$.
  Final controller:
  $
    u=-(k_1^p mu^(p/1)(t)1/p dot(x)^(2-p)-dot(mu)/mu dot(x)+k_2 mu^(1+p) "sign"(sigma)+k_3 sigma)
  $
  

  // #footnote(cite(<Shi10665914>,form:"full"))
]

  #pagebreak()
  #let plot_one(xout,dxout,y-tick-step)={
    let fig1=cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x1"),label:$x$)
          plot.add(get_signal(xout,"x2"),label:$dot(x)$)
          plot.add(get_signal(dxout,"sigma"),label:$sigma$)
        },
        y-label:"value",
        x-label:"time",
        )
      })
    let fig2=cetz.canvas({
    plot.plot(
      size: (8,2),
      axis-style: "school-book", 
      x-tick-step: 5, y-tick-step:y-tick-step,
      {
        plot.add(get_signal(xout,"x1"),label:$x$)
        plot.add(get_signal(dxout,"u"),label:$u$)
      },
      y-label:"value",
      x-label:"time",
      )
    })
    table(columns: (auto,auto),stroke: none,fig1,fig2)
  }

  #let plot_tsmc(q,sat,y-tick-step)={
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
    let (xout,dxout)=ode45(rhs,20,(x1:2,x2:1),0.01,record_step:0.1)
    plot_one(xout,dxout,y-tick-step)
  }

  #let plot_ntsmc(alpha,p,k,y-tick-step)={
    let rhs(t,x)={
      let delta=calc.sin(t)
      let sigma=x.x1+1/alpha*op.sig(x.x2,p)
      let u=-1*(alpha/p*op.sig(x.x2,2-p)+k*op.sign(sigma))
      let dx=(x1:x.x2,x2:u+delta)
      dx.insert("sigma",sigma)
      dx.insert("delta",-delta)
      dx.insert("u",u)
      dx
    }
    let (xout,dxout)=ode45(rhs,20,(x1:2,x2:1),0.01,record_step:0.1)
    plot_one(xout,dxout,y-tick-step)
  }

  TSMC with q=1/2, singularity problem causes the system panick
  #plot_tsmc(1/2,float.inf,20)

  TSDM with q=1/2, saturation value $1$ used outside $sig(x)^(q-1)$
  #plot_tsmc(1/2,1,2)

  NTSMC with $alpha=1$, $p=1.5$, $k=1$
  #plot_ntsmc(1,1.5,1,2)


#pagebreak()
= Second Order Sliding Mode Control 

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



