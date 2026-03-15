#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart
#import cetz.draw: *

#import "lib/lib.typ":  op,sig,ode,ode45,get_signal


#let mu1(t,T:1,h:1,k1:1,k2:0)={
  if t>=T {
    0
  }else{
    k1/calc.pow(T - t,h)+k2
  }
}

#let table_eles(profiles)={
  let eles=()
  for p in profiles{
    eles.push($T=#p.T,\ h=#p.h,\ k_1=#p.k1$)
    let mu0=(t)=>mu1(t,T:p.T,h:p.h,k1:p.k1,k2:p.k2)
    let pic=cetz.canvas({
      plot.plot(
        size: (2,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step: none, 
        {
          plot.add(domain: (0,2), mu0,style: (stroke: green))
        },
        y-label:$mu(t)$,
        x-label:$t$
        )
      })
    eles.push(pic)

    let rhs=(t,x)=>(-mu0(t)*x)
    if ("sat" in p){
      rhs=(t,x)=>(-sat(mu0(t)*x,p.sat))
    }
    let (xout,dxout)=ode(rhs,4,1,p.step)
    let odepic=cetz.canvas({
      plot.plot(
        size: (4,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step:none,
        {
          plot.add(xout,label:$x$)
          plot.add(dxout,label:$dot(x)$)
        },
        y-label:$x$,
        x-label:$t$,
        )
    })
    eles.push(odepic)
    if p.h == 1{
      eles.push([Prescribed Time\ Stable with $T$])
    }
    else{
      eles.push([unstable \ x(t)=#xout.at(-1).at(1) \ $t>=T$])
    }

  }
  eles
}

#let profiles1=(
  (T:2,h:1,k1:1,k2:0,step:0.01),
  (T:2,h:1,k1:2,k2:0,step:0.01),
  (T:2,h:1,k1:1/2,k2:0,step:0.01),
)
#let main_tvg=figure(
  table(
    align: horizon,
    columns: (auto,auto,auto,auto),
    ..([system],$mu(t)$,"numerical solution","stability"),
    ..table_eles(profiles1)
    ),
    caption:[
      time-varying gain control with prescribed time stability
    ]
)


= Time-varying Gain
== Prescribed Time Stabiliztion of Single Integrator Systems by Time-varying Gain

Generally prescribed/preassigned/pre-appointed time stability is 
reached by time-varying gain (time-varying scaling function, time-base generator).
Following table gives the basic example, we see that
the solution for the first case is the same as $dot(x)=-"sign"(x)$.
@songPrescribedtimeControlIts2023 .

The system is:
$
dot(x)=-mu(t) x
,
mu(t)=cases(
  k_1/(T-t)^h quad 0<t<T,
  0 quad t>=T),
$ with $T> 1$ to be prescribed and $k_1>0,k_2>0,h=1$.\
The analytical solution with $h=1$ can be found easily as:
$
x(t)=x(0)((T- t)/T)^(k_1), t in [0,T) \
x(t)=0, t in [T,infinity)
$.

#main_tvg
#pagebreak()


== Robust Prescribed Time Stabiliztion of Single Integrator Systems

#columns(2)[
  As is well known, for a linear system $dot(x)=-k x + delta$ where $delta$ is an unknown bounded input and $x$ is the system state.

  From the BIBO stability theorem, we can see that a larger $k$ can make $x$ converge to a smaller vicinity of the origin.
  This motivates the design of a high-gain controller.
  So it's a open problem to bring PT to SMC.
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

  Robust PT controller mainly consider vanishing disturbances like @liStochasticNonlinearPrescribedtime2022 @liPrescribedTimeOutputFeedbackControl2023
  @liPrescribedtimeMeannonovershootingControl2023.

  Another method is using ISMC, which avoids the reaching phase of sliding mode control at the cost of requiring the initial state.
]


#pagebreak()

== Discussion: Time-varying Gain with different power


The analytical solution with $h!=1$ can be found easily as:
$
x(t)=x(0)exp(-k_1/(-h+1)(T^(-h+1)-(T-t)^(-h+1)))\
x(t)=x(0)exp(-k_1/(-h+1) T^(-h+1)), t in [T,infinity)
$.
These system can be nearly stable but we can always observe some error.
#let profiles2=(
  // (T:2,h:2,k1:1/2,k2:0,step:0.01,sat:10),  //the first simulation is quite "ill"
  (T:2,h:-1,k1:1/2,k2:0,step:0.01),
  (T:2,h:-3,k1:1/2,k2:0,step:0.01),
)

#figure(
  table(
    align: horizon,
    columns: (auto,auto,auto,auto),
    ..([system],$mu(t)$,"numerical solution","stability"),
    ..table_eles(profiles2)
    ),
    caption: [time-varying gain control with similar form without stability ]
)
#pagebreak()
