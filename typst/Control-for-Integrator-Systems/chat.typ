#import "template.typ": template

#show: template.with(
  title:[*Sliding Mode Control*],
  part_no: 1,
  part:[SMC for single-integrators with time-critical stability]
)

#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart
#import "./lib/lib.typ":ode45,get_signal,op,ode,sig

#import cetz.draw: *

#let plot_fun(func,y-tick-step:none,domain: (-2, 2),y-label:$dot(x)$,x-label:$x$)={
  cetz.canvas({
    import cetz.draw: *
    plot.plot(
      size: (2,1),
      axis-style: "school-book", 
      x-tick-step: 2, y-tick-step: y-tick-step, 
      {
        plot.add(domain: domain, func,style: (stroke: red))
      },
      y-label:y-label,
      x-label:x-label
      )
  })
}


#let ode_plot(func,tfinal,x0,step)={
  let (xout,dxout)=ode45((t,x)=>(value:func(t,x.value)),tfinal,(value:x0),step)
  cetz.canvas({
    import cetz.draw: *
    plot.plot(
      size: (4,1),
      axis-style: "school-book", 
      x-tick-step: 1, y-tick-step: none, 
      {
        // plot.add(xout)
        plot.add(get_signal(xout,"value"),label:$x$)
      },
      y-label:$x$,
      x-label:$t$,
      )
  })
}


= Robust Prescribed Time Stabiliztion of Single Integrator Systems
<PTISMC>

#columns(2)[
  As is well known, for a linear system $dot(x)=-k x + delta$ where $delta$ is an unknown bounded input and $x$ is the system state.

  Combining the PT controller with the SMC controller, we can design a controller such that:
  $
  dot(x)=delta(t) + cases(
    - k_1/(T-t) x - k_2 "sign"(x)   & quad 0<t<T,
    - k_2 "sign"(x) & quad t>=T)
  $ with $T> 0$ to be prescribed and $k_2>sup_t abs(delta(t))$.

  Consider $V=1/2 x^2$, we have $dot(V)=x dot(x)$.
  When $t<T$, $dot(V)=x delta -k_1/(T-t) x^2 -k_2 abs(x)<=-(k_2-abs(delta))abs(x)-k_1/(T-t) x^2 <= -k_1/(T-t)2 V(t)$. 
  The system is PT stable with convergence time smaller than $T$.


  The simulation is carried out with a saturation $k_1=k_2=2$, $T=3$.
  We use a saturation on $1/(T-t)$ with threshold as $10$.


  #let sat(x,xm)={
    let y=x;
    if x>xm {
      y=xm
    }
    if x < -xm{
      y=-xm
    }
    y
  }

  #let rhs(t,x)={
    let delta=calc.sin(1/2*calc.pi*t)
    let k1=2
    let k2=2
    let T=3

    let u=-k2*op.sign(x.x)
    if t < T{
      u=u -2*sat(1/(T - t),100)*(x.x)
    }
    let T=0.1
    let dx=(x:u+delta,uf:(u -(x.uf))/T)
    dx.insert("u",u)
    dx.insert("delta",-delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:1,uf:0),0.01,record_step:0.1)

  #cetz.canvas({
      plot.plot(
        size: (8,4),
        axis-style: "school-book", 
        y-min: -3,  
        y-max: 4,  
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"u"),label:$u$)
          // plot.add(get_signal(dxout,"uf"),label:$u_f$)
          plot.add(get_signal(dxout,"delta"),label:$-delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })

  The similar design and analysis of this controller can be found @yangPrescribedtimeRobustControl2023.
  // The proof for PT converge in $t in [0,T)$ .
  // The controller for $t in [T,0)$ is not designed.
  // Some existing results consider a vanishing disturbances like @liStochasticNonlinearPrescribedtime2022. //also  @liPrescribedTimeOutputFeedbackControl2023 @liPrescribedtimeMeannonovershootingControl2023
  

  // Another method is using ISMC, which avoids the reaching phase of sliding mode control at the cost of requiring the initial state.
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
  #footnote()[#cite(<Shi10665914>,form:"full")  (Note: it adopts a non-singular TVG with a parameter $T_s$ in its eq (14).) ]
  TVG:
  $mu(t)=T_p/(T_p-t)$, $t in [0,T_p)$.
  SM manifold: 
  $sigma=x+(k_1 mu(t))^(-p)dot(x)^p$ with $p in (0,1)$.
  Final controller:
  $
    u=-(k_1^p mu^(p)(t)1/p dot(x)^(2-p)-dot(mu)/mu dot(x)+k_2 mu^(1+p) "sign"(sigma)+k_3 sigma)
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

