#import "@preview/cetz:0.2.0"

#let plot_fun(func,y-tick-step:none,domain: (-2, 2),y-label:$dot(x)$,x-label:$x$)={
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    plot.plot(
      size: (2,1),
      axis-style: "school-book", 
      x-tick-step: 1, y-tick-step: y-tick-step, 
      {
        plot.add(domain: domain, func,style: (stroke: red))
      },
      y-label:y-label,
      x-label:x-label
      )
  })
}

#import "lib/ode.typ": ode,sat,sign
#let ode_plot(func,tfinal,x0,step)={
  let (xout,dxout)=ode(func,tfinal,x0,step)
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    plot.plot(
      size: (4,1),
      axis-style: "school-book", 
      x-tick-step: 1, y-tick-step: none, 
      {
        plot.add(xout)
      },
      y-label:$x$,
      x-label:$t$,
      )
  })
}

#let fractionalpower(x,v)={
  if x==0 {
    0
  }else{
    sign(x)*calc.pow(calc.abs(x),v)
  }
}

= Linear feedback for single integrator and variants

== Stabiliztion of Integrator Systems via linear feedback 

From the linear control theory, we know the integrator system $x^((n))=u$ can be stabilized with linear feedback $u=-k_n x -k_(n-1) dot(x)+ dots -k_1 x^((n-1))$.
then the closed loop system expressed in differential equation is 
$
x^((n))+k_1 x^((n-1))+k_2 x^((n-2))+dots +k_(n-1)dot(x)+k_n x=0.
$
With Laplace transformation, the system can be expressed with 
$
p(s)=s^(n)+k_1 s^(n-1)+k_2 s^(n-2)+dots +k_(n-1)s+k_n =0.
$
To make sure the system is stable, 
- all roots of $p(s)=0$ must have negative real parts.
- the polynomial $p(s)$ must be a *Hurwitz* polynomial. 
- The system must satisfy *Routh–Hurwitz stability criterion*
- The system matrix $A$ associated with $k_i$ must be a *Hurwitz matrix*: $"Re"["eig"(A)]<0$

*Note*: $k_i>0$ is a necessary condition for the system to be stable.

First, we analyse the single integrator system:
$
dot(x)=u
$
which can be stabilized with linear feedback $u=-k x$.
Under linear feedback, the exponential stability will be observed.

#pagebreak()

== Stabiliztion of Single Integrator Systems via $-|x|^v "sign"(x)$

From @polyakov_generalized_2020, we can find solutions of the system
$dot(x)=-x^(v)$ has some good properties.
Due to the definition of power function, usually we extend the function's 
definition to the whole rational field $RR$ as $dot(x)=- "sign"(x) |x|^v, v>=0$.
In some books like @polyakov_generalized_2020, a condition on $v$ is used.
#footnote([
  I haven't figure out this condition yet.
  The condition write $v$ as $v=p/q$ and says 
  $p$ should be an odd integer and $q$ is an even natual number.
  I think both $p$ and $q$ should be odd natural number and $q!=0$.
])
The general solution to this system is
$
x(t)=(x(0)^(-v+1)+(v-1)t)^(1/(-v+1)) "sign"(x(0))
=x(0)/(1+(v-1)t|x(0)|^(v-1))^(1/(v-1))  "if" v!=1.
$

#figure(
  table(
    columns:(auto,auto,auto,auto,auto),
    [system],
    [$x-dot(x)$ curve],
    [numerical solution $x=x(t)$],
    [analytical solution],
    [stability],
    //
    $dot(x)=-x^(0)=-"sign"(x)$,
    plot_fun(x=>-fractionalpower(x,0)),
    ode_plot((t,x)=>-fractionalpower(x,0),10,1,0.1),
    [
      when $x(0)>0$\
      $x(t)=cases(
      x(0)-t quad t in (0,x(0)),
      0 quad t>=x(0))$
    ],
    [Finite time\ if $v<1$],
    //
    $dot(x)=-x^(1/3)$,
    plot_fun(x=>-fractionalpower(x,1/3)),
    ode_plot((t,x)=>-fractionalpower(x,1/3),10,1,0.1),
    [
      when $x(0)>0$\
      $x(t)=cases(
      (|x(0)|^(2/3)-2/3 t)^(3/2) quad t in (0,(2/3)|x(0)|^(3/2)),
      0 quad t>=x(0))$
    ],
    [Finite time\ if $v<1$],
    //
    $dot(x)=-x^(1)=-x$,
    plot_fun(x=>-fractionalpower(x,1)),
    ode_plot((t,x)=>-fractionalpower(x,1),10,1,0.1),
    $x=x(0)e^(-t)$,
    [Exponential\ if $=1$],
    //
    $dot(x)=-x^(3)$,
    plot_fun(x=>-fractionalpower(x,3)),
    ode_plot((t,x)=>-fractionalpower(x,3),10,1,0.1),
    $x(t)=(x(0)^(-2)+2t)^(-1/2)$,
    [(practical)\ Fixed time\ if $v>1$ #footnote("converges to a neighborhood of the origin in a ﬁxed time independent of the initial condition.")],
    ),
  caption: [fractional power feedback $dot(x)=-"sign"(x)|x|^v, v>=0$]
)

#let main2sat=4
#let sat_fractional_power(x,v)={
  sat(fractionalpower(x,v),main2sat)
}

#pagebreak()
== Discussion: negative power feedback

Faster covergence will be found if we use negative power.
However, this will need infinite gain (infinite energy).
So, it is impossible for physical implementation.
Simulations are carried out with a satutated power function
for the infinite gain is not possible to simulate.


#figure(
  table(
    columns:(auto,auto,auto,auto,auto),
    [system],
    [$x-dot(x)$ curve],
    [numerical solution $x=x(t)$],
    [step],
    [stability],
    //
    $dot(x)=-"sat"(x^(-1/3))$,
    plot_fun(x=>-sat_fractional_power(x,-1/3)),
    ode_plot((t,x)=>-sat_fractional_power(x,-1/3),2,1,0.0012),
    [0.0012],
    [Finite time],
    //
    $dot(x)=-"sat"(x^(-1))=-"sat"(1/x)$,
    plot_fun(x=>-sat_fractional_power(x,-1)),
    ode_plot((t,x)=>-sat_fractional_power(x,-1),2,1,0.01),
    [0.01],
    [Finite Time],
    //
    $dot(x)=-"sat"(x^(-3))$,
    plot_fun(x=>-sat_fractional_power(x,-3)),
    ode_plot((t,x)=>-sat_fractional_power(x,-3),2,1,0.01),
    [0.01],
    [Finite Time],
    //
    $dot(x)=-10*"sign"(x)$,
    plot_fun(x=>-10*sat_fractional_power(x,0)),
    ode_plot((t,x)=>-10*sat_fractional_power(x,0),2,1,0.1),
    [0.1],
    [Finite time],
    )
)
#pagebreak()