#import "lib/ode-dict.typ":ode45,get_signal
#import "lib/ode.typ":sign
#import "@preview/cetz:0.2.0"
#import cetz.plot
#import cetz.draw: *

= Control Single Integrator System

== Robustness of $dot(x)=-"sign"(x)+delta$

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

  This implies $x arrow 0$(Lyapunov direct method) and $dot(x) arrow 0$ (Barbalat's lemma).
  If so, $-k "sign"(x)+delta arrow 0$?

  This differential equation should be understood in *Pilippov sense*.
  The solution here is not a classical(continuously differentiable) solution but a absolutely continuous solution.
  the solution satisfy the *Pilippov DI* (Pilippov Differential Inclusion) of the differential equation.

  We use the concept of *Equivalent Control* describes this feature, that is ,$"sign"x=delta$.
  Use a low pass filter, we can say $"LPF"("sign"(x))approx delta$.

  For example, the following low pass filter is used in simulation, 
  $
    U_"filtered"(s)/U(s)=1/(T s +1 )\
    T dot(u)_"filtered"+u_"filtered"=u
  $

  #let rhs(t,x)={
    let delta=calc.sin(t)
    let u=-1.1*sign(x.x)
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
 ]

#pagebreak()
== Finite-time convergence of  $dot(x)=-k"sign"(x)+delta$

#columns(2)[
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
            let u=-1.1*sign(x.x)
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
  import cetz.plot
  import cetz.draw: *
  plot.plot(size: (2,2),axis-style: "school-book", x-tick-step: none, y-tick-step: none, {
    plot.add(domain: (-3, 0), x=>-1,style: (stroke: red))
    plot.add(domain: (0, 3), x=>1,style: (stroke: red))
    plot.add(((0,0),),mark:"o",mark-style:(stroke:red,fill: red))
  })
})
}

#let plot_signv(func)={
  cetz.canvas({
  import cetz.plot
  import cetz.draw: *
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
    let v=-rho*sign(s)-1/c*(u)
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

  - Elimination of Reaching Phase: The system state always starts on the sliding surface, simplifying control design.
  - Improved Robustness:  ISMC extends this robustness to the entire state space, making the system less sensitive to uncertainties.
  - Guaranteed Stability: Once the sliding mode is achieved, ISMC guarantees the system's stability. This provides a strong theoretical foundation for the control performance.
])

#pagebreak()
#columns(2)[
  The first simulation demonstrates the traditional SMC is sensitive to  disturbance in reaching phase.
  #let rhs(t,x)={
    let delta=sign(calc.sin(10*t)-0.5)
    let u=-1.1*sign(x.x)
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
    let delta=sign(calc.sin(10*t)-0.5)
    let rho1=3
    let k=1
    let s=(x.x)-(x.z)
    let u1=-rho1*sign(s)
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
 ]

#pagebreak()
== Super Twist Algorithm (STA)

#box(height: 210/16*9mm,
 columns(2, gutter: 11pt)[
  $
  dot(x)=u+delta \
  u=-c |x|^(1/2) "sign"(x)-w\
  dot(w)=b "sign"(x)
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
    let u=-c*calc.sqrt(calc.abs(x.x))*sign(x.x)-x.w
    let dx=(x:u+delta,w:b *sign(x.x));
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
 ]
)

#pagebreak()
== RISE for single integrator

#columns(2)[
  Here we follow the design of RISE @xianContinuousAsymptoticTracking2004 and apply them to single integrator.
  $
    dot(x)=u+delta
  $ where $delta in cal(C)^2$ 

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
    let dw=ks*alpha*alpha *(x.x)+beta *sign(x.x);
    let dx=(x:u+delta,w:dw);
    dx.insert("u",u)
    dx
  }
  #let (xout,dxout)=ode45(rhs,16,(x:1,w:0),0.01)
  #import "@preview/cetz:0.2.0"
  #import cetz.plot
  #import cetz.draw: *
  #cetz.canvas({
      plot.plot(
        size: (10,2),
        axis-style: "school-book", 
        x-tick-step: 5, y-tick-step:1,
        {
          plot.add(get_signal(xout,"x"),label:$x$)
          plot.add(get_signal(dxout,"u"),label:$u$)
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