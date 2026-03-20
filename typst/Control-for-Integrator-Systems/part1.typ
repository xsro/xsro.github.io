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
    plot_fun(x=>-op.sig(x,0)),
    ode_plot((t,x)=>-op.sig(x,0),10,1,0.1),
    [
      when $x(0)>0$\
      $x(t)=cases(
      x(0)-t quad t in (0,x(0)),
      0 quad t>=x(0))$
    ],
    [Finite time\ if $v<1$],
    //
    $dot(x)=-x^(1/3)$,
    plot_fun(x=>-op.sig(x,1/3)),
    ode_plot((t,x)=>-op.sig(x,1/3),10,1,0.1),
    [
      when $x(0)>0$\
      $x(t)=cases(
      (|x(0)|^(2/3)-2/3 t)^(3/2) quad t in (0,(2/3)|x(0)|^(3/2)),
      0 quad t>=x(0))$
    ],
    [Finite time\ if $v<1$],
    //
    $dot(x)=-x^(1)=-x$,
    plot_fun(x=>-op.sig(x,1)),
    ode_plot((t,x)=>-op.sig(x,1),10,1,0.1),
    $x=x(0)e^(-t)$,
    [Exponential\ if $=1$],
    //
    $dot(x)=-x^(3)$,
    plot_fun(x=>-op.sig(x,3)),
    ode_plot((t,x)=>-op.sig(x,3),10,1,0.1),
    $x(t)=(x(0)^(-2)+2t)^(-1/2)$,
    [(practical)\ Fixed time\ if $v>1$ #footnote("converges to a neighborhood of the origin in a ﬁxed time independent of the initial condition.")],
    ),
  caption: [fractional power feedback $dot(x)=-"sign"(x)|x|^v, v>=0$]
)

#let main2sat=4
#let sat_fractional_power(x,v)={
  op.sat(op.sig(x,v),main2sat)
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


= Notations of *sgn* and *sig*

In homogeneous theory and high order sliding mode, 
the *signum* function ensures the definition on $RR$ and the function is *odd*.
We always use following notations with scalar value $x$
$
"sgn"(x)=cases(
  x/abs(x) quad &"if"  x!=0,
  0 &"if"  x=0
),quad quad quad
sig(x)^q=abs(x)^q"sgn"(x).
$
For vector $bold(x)=[x_1,x_2,dots,x_n]^T in RR^n$,
two notations are used in literatures.
The first one is a element-wise notation as 
$
sig(bold(x))^q=lr([ abs(x_1)^q"sgn"(x_1),abs(x_2)^q"sgn"(x_2),dots,abs(x_n)^q"sgn"(x_n)])^T
$
Most results of $RR^1$ can be used in this definition.
However, this notation needs every controller part knows the global coordinate.
So a notation inspired by unit-vector is also very famous,
which is
$
"sgn"(x)=cases(
  x/norm(x) quad &"if"  norm(x)!=0,
  0 &"if"  norm(x)=0
),
quad quad quad
sig(bold(x))^q=norm(bold(x))^q "sgn"(bold(x))
$


This operation has following properties:
+ derivative: $"d"/("d" x) sig(x)^q=q abs(x)^(q-1)$
+ integral: $"d"/("d" x) abs(x)^q=q sig(x)^(q-1)$
+ When power $q=0$, $sig(x)^0="sgn"(x)$
*For the vector case, when we use the second definition with Euclidean norm, 
the second propery is not satisfied.*

  
#pagebreak()

== Derivative and Integral of *signum*

If we use the Euclidean norm and the second definition of the signum function,
we have 
$
(partial)/(partial x_i)norm(bold(x))
=(partial)/(partial x_i)sqrt(sum_(i=1)^n x_i^2)
=1/2 (sum_(i=1)^n x_i^2)^(-1/2) (partial)/(partial x_i) sum_(i=1)^n x_i^2
=1/2 (sum_(i=1)^n x_i^2)^(-1/2) 2 x_i
=x_i/norm(bold(x)) \
(partial)/(partial bold(x))norm(bold(x))
=lr([
  (partial)/(partial x_1)norm(bold(x)),
  (partial)/(partial x_2)norm(bold(x)),
  dots,
  (partial)/(partial x_n)norm(bold(x))
  ])
=bold(x)^T/norm(bold(x))
=("sgn"(bold(x)))^T\
(partial)/(partial bold(x))sig(bold(x))^0
=(partial)/(partial bold(x))bold(x)norm(bold(x))
=lr([
  (partial)/(partial x_1)norm(bold(x)),
  (partial)/(partial x_2)norm(bold(x)),
  dots,
  (partial)/(partial x_n)norm(bold(x))
  ])
=bold(x)^T/norm(bold(x))\
$

Generally, when use the Euclidean norm,
We can calculate the derivatives as 
$
(partial)/(partial bold(x))norm(bold(x))^q
=q* norm(bold(x))^(q-1) (partial)/(partial bold(x)) norm(bold(x))
=q* norm(bold(x))^(q-1) ("sgn"(bold(x)))^T
=q (sig(bold(x))^(q-1))^T
$
Let $bold(x)=bold(x)(t)$ and the derivative of signum is
$
(d)/(d t)sig(bold(x))^q
=(d)/(d t) norm(bold(x))^(q-1) dot.c bold(x)
=((q-1) sig(bold(x))^(q-2))^T dot.c dot(bold(x)) dot.c bold(x)
+  norm(bold(x))^(q-1) dot.c dot(bold(x))
=(q-1) norm(bold(x))^(q-1)(("sgn"bold(x))^T dot(bold(x))) "sgn"(bold(x))
+  norm(bold(x))^(q-1) dot.c dot(bold(x))
$
In the scalar case, 
$
(d)/(d t)sig(x)^q=(q-1) sig(x)^(q-2) dot.c dot(x) dot.c x
+  norm(x)^(q-1) dot.c dot(x)
=q norm(x)^(q-1) dot.c dot(x)
$
#pagebreak()


= Control Single Integrator System

== Bang-Bang Control $dot(x)=-k"sign"(x)+delta$

#columns(2, gutter: 11pt)[

  #set par(justify: true)
  Consider the fisrt order system $dot(x)=u+delta$,
  $delta$ is the bounded disturbance $|delta|<C$.
  The first control law is 
  $
  u=-k"sign"x 
  $<single_integrator_sign>
  where $k>C$.
  Select 
  $
  V=1/2 x^2.
  $<single_integrator_sign_V>
  Calculate the derivative along the system trajectory:
  $
  dot(V)
  &=x dot(x)
  =x (-k"sign"x+delta)\
  &=-k|x|+x delta
  <= -k|x|+|x| |delta|\
  &<=-(k-C)|x|<=0
  $<single_integrator_sign_dV>

  This implies $x arrow 0$(Lyapunov direct method).
  But we cannot say $dot(x) arrow 0$.
  We cannot use Barbalat's lemma for $dot(x)$ is not *uniformly continuous*.
  So can we have $-k "sign"(x)+delta arrow 0$?

=== Equivalent Control

  First, we can use the concept of *Equivalent Control* @shtesselSlidingModeControl2014 describes this feature.
  Use a low pass filter, we can say $"LPF"(k "sign"(x))approx delta$.

  For example, the following low pass filter is used in simulation, 
  #let rhs(t,x)={
    let delta=calc.sin(t)
    let u=-1.1*op.sign(x.x)
    let T=0.1
    let dx=(x:u+delta,uf:(u -(x.uf))/T)
    dx.insert("u",u)
    dx.insert("delta",-delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:1,uf:0),0.01,record_step:0.01)

  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(xout,"uf"),label:$u_"filtered"$)
          plot.add(get_signal(dxout,"u"),label:$u$)
          plot.add(get_signal(dxout,"delta"),label:$-delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  The filter is
  $
    U_"filtered"(s)/U(s)=1/(T s +1 )\
    T dot(u)_"filtered"+u_"filtered"=u
  $

  #colbreak()

  === Filippov solution 

  This differential equation should be understood in *Filippov sense* @cortesDiscontinuousDynamicalSystems2008.
  The solution here is not a classical(continuously differentiable) solution but a absolutely continuous solution.
  the solution satisfy the *Filippov DI* (Filippov Differential Inclusion) associated with the differential equation.
  The DI is 
  $
  dot(x) in F(t,x)+delta(t)\
  F(t,x)=cases(
    k &"if" x<0,
    [-k,k] &"if" x=0,
    -k &"if" x>0
  )
  $<a>
  This means when $x>0$, we have $dot(x)<0$, and when $x<0$, we have $dot(x)>0$.
  The system must converges to $x=0$ and $dot(x)=0$.
  We have $dot(x)=0$ satify the Differential Inclusion @a.
  We can not say $k "sign"(x)=delta(t)$.
  We say the time average satifies: $⟨k "sign"(x)⟩=delta(t)$.

  In sliding mode, the discontinuous term does not converge pointwise to the disturbance; its average effect cancels it, which is captured by Filippov's convexification.


  // #colbreak()
  === Finite-time convergence

  Another important feature of this system is finite-time stability.
  From @single_integrator_sign_V and @single_integrator_sign_dV,
  we have 
  $
  dot(V)(t)<=-(k-C) sqrt(2V(t))
  $
  Let $a=(k-C)sqrt(2)$ and integrate it. we get
  $
    (d V(t))/sqrt(V(t))<=-a d t \
    2 sqrt(V(t)) - 2 sqrt(V(0))<=-a t\
   sqrt(V(t))<=sqrt(V(0))-a/2 t\
  $
  Consequently, $V(t)$ reaches zero in a finite time $t_r$ that is bounded by
  $
    t_r<=2sqrt(V(0))/a=(|x(0)|)/(k-C)
  $

  #cetz.canvas({
      plot.plot(
        size: (6,2),
        axis-style: "school-book", 
        x-tick-step: 2, y-tick-step:1,
        {
          for i in (1,2,3){
            let rhs(t,x)={
            let delta=calc.sin(t)
            let u=-1.1*op.sign(x.x)
            let T=0.1
            let dx=(x:u+delta,uf:(u -(x.uf))/T)
            dx.insert("u",u)
            dx.insert("delta",-delta)
            dx
          }
          let (xout,dxout)=ode45(rhs,6,(x:i,uf:0),0.01,record_step:0.01)
          plot.add(get_signal(xout,"x"),label:$x(0)=#i$)
          }
          
        },
        y-label:"value",
        x-label:"time",
        )
    })
]



#pagebreak()
== SMC Chattering Elimination: Quasi-Sliding Mode

In many practical control systems, including DC motors and aircraft control, 
it is important to avoid control chattering by providing continuous/smooth signals.
One obvious solution to make the control function continuous/smooth is to approximate the discontinuous function $v(sigma)=-rho "sign" (sigma)$ by some continuous/smooth function.
For instance, it could be replaced by a "sigmoid function".

#let plot_sign()={
  cetz.canvas({
  plot.plot(size: (2,2),axis-style: "school-book", x-tick-step: none, y-tick-step: none, {
    plot.add(domain: (-3, 0), x=>-1,style: (stroke: red))
    plot.add(domain: (0, 3), x=>1,style: (stroke: red))
    plot.add(((0,0),),mark:"o",mark-style:(stroke:red,fill: red))
  })
})
}

#let plot_signv(func)={
  cetz.canvas({
  plot.plot(size: (2,2),axis-style: "school-book", x-tick-step: none, y-tick-step: none, {
    plot.add(domain: (-3, 3), func,style: (stroke: red))
  })
})
}

#figure(
  table(
    align: horizon,
    columns: 6,
    [], 
    $"sign"(x)$, $"sat"(x/epsilon)$, 
    $x/(abs(x)+epsilon)$,$tanh(x)$,$(1-e^(-T x))/(1+e^(-T x))$,
    [continuity],
    [discontinuous], [continuous], [smooth #footnote("I am not sure about this")],[smooth],[smooth],
    [],
    [#plot_sign()],
    [
      #let sat(a)={
        if calc.abs(a)>1{
          a/calc.abs(a)
        }else{
          a
        }
      }
      #plot_signv(x=>sat(x/0.5))
      $epsilon=0.5$
    ],
    [
      #plot_signv(x=>x/(calc.abs(x)+0.5))
      $epsilon=0.5$
    ],
    [
      #plot_signv(x=>calc.tanh(x))
    ],
    [
      #plot_signv(x=>(1-calc.exp(-5*x))/(1+calc.exp(-5*x)),)
      $T=5$
    ],
  ),
  caption: [replaced $"sign"$ by a “sigmoid function”],
)



*Sacrifice the key property of finite-time convergence to ensure that the designed control law is continuous within a finite time interval.*
Some liturature will use a function $f(x,epsilon)=x/(|x|+epsilon)$ with a vanishing function $epsilon(t)=e^(-t)$.
In a specified time $T$, we we know $epsilon>0$ so the controller output is continuous in finite time and can robust to the disturbance when $t arrow infinity$.


#pagebreak()
=== SMC Chattering Elimination: Quasi-Sliding Mode Simulation

$dot(x)=-1.1*"sign"(x)+"sin"(t)$  
The control input $u$ is discontinuous 
#let rhs(t,x)={
  let delta=calc.sin(t)
  let u=-1.1*op.sign(x.x)
  let dx=(x:u+delta)
  dx.insert("u",u)
  dx.insert("delta",-delta)
  dx
}
#let (xout,dxout)=ode45(rhs,20,(x:1),0.01,record_step:0.01)

#cetz.canvas({
  plot.plot(
    size: (18,2),
    axis-style: "school-book", 
    x-tick-step: 5, y-tick-step:1,
    {
      plot.add(get_signal(xout,"x"),label:$x$)
      plot.add(get_signal(dxout,"u"),label:$u$)
      plot.add(get_signal(dxout,"delta"),label:$-delta$)
    },
    y-label:"value",
    x-label:"t",
    )
  })

$dot(x)=-1.1*(x)/(abs(x)+epsilon)+"sin"(t)$,
$epsilon=0.01$
The control input $u$ is continous and uniformly continous. ($dot(u)=-1.1 epsilon/(abs(x)+epsilon)^2 <= 1.1 * 1/epsilon$)

#let rhs(t,x)={
  let delta=calc.sin(t)
  let eps=0.01
  let u=-1.1*x.x/(calc.abs(x.x)+eps)
  let dx=(x:u+delta)
  dx.insert("u",u)
  dx.insert("delta",-delta)
  dx
}
#let (xout,dxout)=ode45(rhs,20,(x:1),0.01,record_step:0.01)

#cetz.canvas({
  plot.plot(
    size: (18,2),
    axis-style: "school-book", 
    x-tick-step: 5, y-tick-step:1,
    {
      plot.add(get_signal(xout,"x"),label:$x$)
      plot.add(get_signal(dxout,"u"),label:$u$)
      plot.add(get_signal(dxout,"delta"),label:$-delta$)
    },
    y-label:"value",
    x-label:"t",
    )
  })


$dot(x)=-1.1*(x)/(abs(x)+epsilon)+"sin"(t)$,
$epsilon=e^(-t)$ The control input $u$ is continuous but *not uniformly continous*

#let rhs(t,x)={
  let delta=calc.sin(t)
  let eps=calc.exp(-t)
  let u=-1.1*x.x/(calc.abs(x.x)+eps)
  let dx=(x:u+delta)
  dx.insert("u",u)
  dx.insert("delta",-delta)
  dx.insert("eps",eps)
  dx
}
#let (xout,dxout)=ode45(rhs,20,(x:1),0.01,record_step:0.01)

#cetz.canvas({
  plot.plot(
    size: (18,2),
    axis-style: "school-book", 
    x-tick-step: 5, y-tick-step:1,
    {
      plot.add(get_signal(xout,"x"),label:$x$)
      plot.add(get_signal(dxout,"u"),label:$u$)
      plot.add(get_signal(dxout,"delta"),label:$-delta$)
      plot.add(get_signal(dxout,"eps"),label:$epsilon=e^(-t)$)
    },
    y-label:"value",
    x-label:"t",
    )
  })

#pagebreak()
== SMC Chattering Attenuation: Asymptotic Sliding Mode

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  *Assume $dot(delta)$ is also bounded and $dot(x)$ is measurable.* 
  Let $|dot(delta)|<=C_1$. Define $s=x+c dot(x)$. 
  The control law is given by 
  $
  dot(x)=u+delta\
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

  #let rhs(t,s)={
    let C1=1 // upper bound of disturbance 
    let C2=1 // upper bound of derivative of disturbance
    let c=1
    let delta=C1 * calc.sin(C2/C1*t)
    let rho=3
    let x=s.x;let u=s.u;
    let dx=(u)+delta
    let s=x+c *(dx)
    let v=-rho*op.sign(s)-1/c*(u)
    let dx=(x:dx,u:v,s:s)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:1,u:0.),0.01,record_step:0.01)

  #cetz.canvas({
      plot.plot(
        size: (10,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"s"),label:$s$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  #cetz.canvas({
      plot.plot(
        size: (10,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:2,
        {
          plot.add(get_signal(dxout,"u"),label:$v$)
          plot.add(get_signal(xout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
])

#pagebreak()
== Integral Sliding Mode Control

#columns(2, gutter: 11pt)[
  Defined the integral SM manifold $s=x - z$ with $dot(z)=-k x$, then its derivative is $dot(s)=dot(x)+k x=u+delta + k x$.
  So the controller is 
  $
    u=-rho "sign"(s)- k x
  $

  Now we will address the issue of starting the auxiliary sliding mode from the very beginning without any reaching phase. In order to achieve it we have to enforce the initial condition $s(0)=0 $
  $
  s(0)=0 arrow.double z(0)=x(0)
  $

  Advantage: We can set $z(0)$ to keep $s(0)=0$, The system is starting from  auxiliary sliding surface.

  - Elimination of Reaching Phase: The system state always starts on the sliding surface, simplifying control design.
  - Improved Robustness:  ISMC extends this robustness to the entire state space, making the system less sensitive to uncertainties.
  - Guaranteed Stability: Once the sliding mode is achieved, ISMC guarantees the system's stability. This provides a strong theoretical foundation for the control performance.

  *Tips*: see @PTISMC

  The first simulation demonstrates the traditional SMC is sensitive to  disturbance in reaching phase.
  #let rhs(t,x)={
    let delta=op.sign(calc.sin(10*t)-0.5)
    let u=-1.1*op.sign(x.x)
    let T=0.1
    let dx=(x:u+delta,uf:(u -(x.uf))/T)
    dx.insert("u",u)
    dx.insert("delta",-delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:4,uf:0),0.01,record_step:0.01)
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(xout,"uf"),label:$u_"filtered"$)
          plot.add(get_signal(dxout,"u"),label:$u$)
          plot.add(get_signal(dxout,"delta"),label:$-delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })

  The second one uses integral SMC is
  #let rhs(t,x)={
    let delta=op.sign(calc.sin(10*t)-0.5)
    let rho1=3
    let k=1
    let s=(x.x)-(x.z)
    let u1=-rho1*op.sign(s)
    let u2=-k*x.x
    let u=u1+u2
    let T=0.1
    let dx=(x:u+delta,z:u2)
    dx.insert("s",s)
    dx.insert("u1",u1)
    dx.insert("u2",u2)
    dx.insert("u",u)
    dx.insert("delta",-delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:4,z:4),0.01,record_step:0.01)

  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"s"),label:$s$)
          plot.add(get_signal(dxout,"delta"),label:$-delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
    #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:3,
        {
          plot.add(get_signal(dxout,"u1"),label:$u_1$)
          plot.add(get_signal(dxout,"u2"),label:$u_2$)
          plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
    // *Tips*: see @PTISMC
 ]

#pagebreak()
== Super Twist Algorithm (STA)

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  $
  dot(x)=-c |x|^(1/2) "sign"(x)-w+delta_1\
  dot(w)=b "sign"(x)+delta_2
  $

  - The super-twisting control is a *second-order* sliding mode control, since it drives both $sigma arrow 0$ and $dot(sigma) arrow 0$ in finite time. (Second-Order Sliding Mode or 2-SM means the control law drives the sliding variable and its derivative to zero in *finite time*)
  - The super-twisting control is *continuous*.

  The parameters $c$ and $b$ are quite difficult to select.
  The parameters given by @shtesselSlidingModeControl2014 are 
  $
  c=1.5 sqrt(C), b=1.1 C
  $
  @SEEBER2017241 gives a condition
  $
  b > C , c > sqrt(b + C)
  $

  #let x0=(x:1,w:0)
  #let rhs(t,x)={
    let C=1 
    let delta=C*calc.sin(t)
    let c=1.5 *calc.sqrt(C)
    let b=1.1 *C
    let u=-c*calc.sqrt(calc.abs(x.x))*op.sign(x.x)-x.w
    let dx=(x:u+delta,w:b *op.sign(x.x));
    dx.insert("u",u)
    dx.insert("delta",delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:1,w:0),0.05)

  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step:1,
        {
          plot.add(get_signal(xout,"w"),label:$w$)
          plot.add(get_signal(dxout,"delta"),label:$delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })

    #let x0=(x:1,w:0)
  #let rhs(t,x)={
    let C=0.1 
    let delta1=C*(calc.sin(2*t))
    let delta2=C*calc.cos(t)
    let c=1.5 *calc.sqrt(C)
    let b=1.1 *C
    let u=-c*calc.sqrt(calc.abs(x.x))*op.sign(x.x)-x.w
    let dx=(x:u+delta1,w:b *op.sign(x.x)+delta2);
    dx.insert("u",u)
    dx.insert("delta",delta1)
    dx
  }
  #let (xout,dxout)=ode45(rhs,10,(x:1,w:0),0.05)

  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"u"),label:$u$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 1, y-tick-step:1,
        {
          plot.add(get_signal(xout,"w"),label:$w$)
          plot.add(get_signal(dxout,"delta"),label:$delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
 ]
)

#pagebreak()
== RISE for single integrator

#columns(2)[
  Here we follow the design of RISE @xianContinuousAsymptoticTracking2004 and apply them to single integrator.
  $
    dot(x)=u+delta
  $ where #text(red)[$delta in cal(C)^2$ (both $abs(delta)$ and $abs(dot(delta))$ is bounded).]

  The main idea of RISE is using a Lyapunov function contains $delta$.
  Let $L=(alpha x+dot(x))(dot(delta)-beta "sign"(x))$, we calculate 
  $
    V&=1/2 (alpha x+dot(x))^2+xi_b-P\
    dot(V)&=(alpha x+dot(x))(alpha dot(x)+dot(u)+dot(delta))-L\
    &=(alpha x+dot(x))(alpha dot(x)+dot(u)+dot(delta)-dot(delta)+beta "sign"(x))\
    &=(alpha x+dot(x))(alpha dot(x)+dot(u)+beta "sign"(x))\
  $
  so we design
  $
   dot(u)=-alpha dot(x) -beta "sign"(x)-k_s alpha (alpha x+dot(x) ) \
   u=-(k_s+1)alpha x(t)+(k_s+1)alpha x(0) - w\
   dot(w)=k_s alpha^2 x+ beta "sign"(x)
  $
  #let x0=(x:1,w:0)
  #let rhs(t,x)={
    let alpha=1;
    let ks=20;
    let beta=1+1/alpha +0.1
    let delta=calc.sin(t)
    let u=-(ks+1)*alpha*((x.x)-(x0.x))-(x.w);
    let dw=ks*alpha*alpha *(x.x)+beta *op.sign(x.x);
    let dx=(x:u+delta,w:dw);
    dx.insert("werror",x.w -delta)
    dx.insert("u",u)
    dx.insert("delta",-delta)
    dx
  }
  #let (xout,dxout)=ode45(rhs,16,(x:1,w:0),0.01)
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"u"),label:$u$)
          plot.add(get_signal(dxout,"delta"),label:$-delta$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  #cetz.canvas({
      plot.plot(
        size: (8,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:5,
        {
          plot.add(get_signal(dxout,"werror"),label:$w-delta$)
          plot.add(get_signal(xout,"w"),label:$w$)
        },
        y-label:"value",
        x-label:"time",
        )
    })
  #text(size:9pt,$
  P=&integral_0^t L(tau) d tau\
  =&integral_0^t alpha x(dot(delta)-beta "sign"(x)) d tau
  +integral_0^t dot(x)(dot(delta)-beta "sign"(x)) d tau\
  =&integral_0^t alpha x(dot(delta)-beta "sign"(x)) d tau
  +x dot(delta)|_0^t - integral_0^t x dot.double(delta)d tau
  -integral_0^t dot(x)beta "sign"(x)d tau\
  =&integral_0^t alpha x(dot(delta)-1/alpha dot.double(delta))-alpha beta |x| d tau
  +x dot(delta) |_0^t
  -beta abs(x)|_0^t\
  <=&xi_b := integral_0^t alpha abs(x) (abs(dot(delta))+1/alpha abs(dot.double(delta))-beta) d tau
  +abs(x(t)) (abs(dot(delta)(t))-beta)
  -x(0) dot(delta)(0)+beta abs(x(0))
  $)
]

#pagebreak()



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
          plot.add(domain: (0,1.9), mu0,style: (stroke: green))
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


= Stability Definitions in Control Theory

#list(
  "Asymptotic / Exponential: Infinite-time convergence",
  "Finite-time: Finite convergence time (depends on initial conditions)",
  "Fixed-time: Finite convergence time (upper bounded, independent of initial conditions)",
  "Prescribed-time: Convergence time can be preassigned arbitrarily"
)

#align(center)[
  

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [Stability], [Controller], [Convergence time],
  ),
  [Exponential],
  $dot(x)=-x$,
  $T arrow infinity$,
  "Finite time",
  $dot(x)=-"sign"(x)$,
  $T<=abs(x(0))/k$,
  [Fixed-time],
  [$dot(x)=-sig(x)^p-sig(x)^q$,$0<p<1$,$q>1$],
  $T$,
  "Predefined time",
  $dot(x)=-mu(t) x, mu(t)=max{1/(T_p-t),0}$,
  $T=T_p$,
)

]


#pagebreak()

== Finite time stability

#columns(2)[
  Consider the following:
  $
    dot(x) = g(t, x), quad x(0) = x_0
  $<nonlinear_system>
  where $x in RR^n$ and $g : RR_+ times RR^n -> RR^n$ is a nonlinear function, which can be discontinuous. 
  The solutions of (1) are understood in the sense of Filippov. Assume the origin is an equilibrium point of @nonlinear_system.

  *Definition 1 (@BhatS0363012997321358):*
  The origin of @nonlinear_system is said to be globally finite-time stable if it is globally asymptotically stable and any solution $x(t, x_0)$ of @nonlinear_system reaches the equilibria at some finite time moment, i.e., $x(t, x_0) = 0$, $forall t >= T(x_0)$, where $T : RR^n arrow RR_+ union {0}$ is the settling-time function.

  The finite-time stability property may exhibit homogeneous systems with negative degree [16], [20]. 
  Any solution of the system $dot{x} = -x^(1/3)$, $x \in RR$ converges to the origin in finite time $T(x_0) := (3/2)root(3, | x_0 |^2)$.

  *Definition 2:*
  The origin of @nonlinear_system is said to be fixed-time stable if it is globally finite-time stable and the settling-time function $T(x_0)$ is bounded, i.e., $exists T_(max) > 0 : T(x_0) <= T_(max)$, $forall x_0 in RR^n$.

  The origin of $dot(x) = -x^(1/3) - x^3$, $x in RR$ is fixed-time stable, since it is globally finite-time stable and $
  x(t, x_0) = 0$ for $forall t >= 2.5$ and $forall x_0 in RR$.

  ---

  *Definition 3:*
  The set $M$ is said to be globally finite-time attractive for @nonlinear_system if any solution $x(t, x_0)$ of @nonlinear_system reaches $M$ in some finite time moment $t = T(x_0)$ and remains there $forall t <= T(x_0)$, $T : RR^n arrow RR_+ union {0}$ is the settling-time function.
]

#pagebreak()
#columns(2)[
== Fixed time stability

*Definition 4:*
The set \($M$\) is said to be fixed-time attractive for @nonlinear_system if it is globally finite-time attractive and the settling-time function $T(x_0)$ is globally bounded by some number $T_(max) > 0$.

Denote by $D^* phi(t)$ the upper right-hand derivative of a function $phi(t)$,
$
  D^* phi(t) : = limsup_(h -> + 0) (phi(t + h) - phi(t))/h .
$

  Lemma 1: @Polyakov6104367
  If there exists a continuous radially unbounded function $V: RR^n arrow RR_+ union {0}$ such that  
  1) $V(x) = 0 arrow.double x in M$;  
  2) any solution $x(t)$ of (1) satisfies the inequality  
  $
  D^*V(x(t)) <= -(alpha V^p (x(t)) + beta V^q (x(t)))^k
  $ 
  for some $alpha, beta, p, q, k > 0$ with $p k < 1$, $q k > 1$,  
  then the set $M subset RR^n$ is globally fixed-time attractive for @nonlinear_system, and  
  $
  T(x_0) <= 1/(alpha^k(1-p k)) + 1/beta^k(q k-1)),
  forall x_0 in RR^n.
  $
]




#pagebreak()

== Prescribed Time Stabiliztion of Single Integrator Systems by Time-varying Gain

Generally prescribed/preassigned/pre-appointed time stability is 
reached by time-varying gain (time-varying scaling function, time-base generator).
Following table gives the basic example, we see that
the solution for the first case is the same as $dot(x)=-"sign"(x)$.
@songPrescribedtimeControlIts2023 .

The system is:
$
dot(x)=-mu(t) x
,quad 
mu(t)=cases(
  k_1/(T-t)^h quad & 0 < t < T ,
  0 quad &t>=T),
$ with $T> 1$ to be prescribed and $k_1>0,k_2>0,h=1$.\
The analytical solution with $h=1$ can be found easily as:
$
x(t)=x(0)((T- t)/T)^(k_1), t in [0,T) \
x(t)=0, t in [T,infinity)
$.

#main_tvg
#pagebreak()


== Robust Prescribed Time Stabiliztion of Single Integrator Systems
<PTISMC>

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

  @songTimevaryingFeedbackRegulation2017 proves the PT converge in $t in [0,T)$.
  The controller for $t in [T,0)$ is not designed.
  Some existing results consider a vanishing disturbances like @liStochasticNonlinearPrescribedtime2022. //also  @liPrescribedTimeOutputFeedbackControl2023 @liPrescribedtimeMeannonovershootingControl2023
  The similar design and analysis of this controller can be found in @yangPrescribedtimeRobustControl2023.

  Another method is using ISMC, which avoids the reaching phase of sliding mode control at the cost of requiring the initial state.
]


#pagebreak()

== Discussion: Time-varying Gain with $h<0$


The analytical solution with $dot(x)=-k_1(T-t)^(-h) x$ and $-h>0$ can be found easily as:
$
x(t)=x(0)exp(-k_1/(-h+1)(T^(-h+1)-(T-t)^(-h+1))) ,
t in [0,T)
quad 
x(t)=x(0)exp(-k_1/(-h+1) T^(-h+1)), 
t in [T,infinity)
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











