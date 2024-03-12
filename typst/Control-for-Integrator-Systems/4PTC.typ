#import "@preview/cetz:0.2.0"
#import cetz.plot
#import cetz.draw: *

#import "lib/ode.typ": ode,sat,sign


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
    columns: (auto,auto,auto,auto),
    ..([system],$mu(t)$,"numerical solution","stability"),
    ..table_eles(profiles1)
    ),
    caption:[
      time-varying gain control with prescribed time stability
    ]
)

#let profiles2=(
  (T:2,h:2,k1:1/2,k2:0,step:0.01,sat:10),
  (T:2,h:-1,k1:1/2,k2:0,step:0.01),
  (T:2,h:-3,k1:1/2,k2:0,step:0.01),
)

#let main_tvg2=figure(
  table(
    columns: (auto,auto,auto,auto),
    ..([system],$mu(t)$,"numerical solution","stability"),
    ..table_eles(profiles2)
    ),
    caption: [time-varying gain control with similar form without stability 
    #footnote([the first simulation is quite "ill"])]
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
x(t)=x(0)((T- t)/T)^k_1, t in [0,T) \
x(t)=0, t in [T,infinity)
$.

#main_tvg
#pagebreak()
== Discussion: Time-varying Gain with different power

The analytical solution with $h!=1$ can be found easily as:
$
x(t)=x(0)exp(-k_1/(-h+1)(T^(-h+1)-(T-t)^(-h+1)))\
x(t)=x(0)exp(-k_1/(-h+1) T^(-h+1)), t in [T,infinity)
$.
These system can be nearly stable but we can always observe some error.
#main_tvg2
#pagebreak()