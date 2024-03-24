#import "lib/ode-dict.typ":ode45,get_signal
#import "lib/notation.typ":sig,sigl,sigr,sign
#import "@preview/cetz:0.2.0"
  #import cetz.plot
  #import cetz.draw: *

= High-Order Sliding Mode Control for Integrator Systems

Tranditionally, a linear feedback can stabilize high-order system without robustness

#let highorder(ux)=(0,6).map(
  C=>cetz.canvas({
  plot.plot(
    size: (6,3),
    axis-style: "school-book", 
    x-tick-step: 1, y-tick-step:4,
    {
      let rhs(t,x)={
        let delta=C*calc.sin(t)
        let u=ux(x)
        let dx=(
          x1:x.x2,
          x2:x.x3,
          x3:x.x4,
          x4:u+delta,
          // u:u,
        )
        dx
      }
      let (xout,dxout)=ode45(rhs,14,(x1:4,x2:3,x3:2,x4:1),0.005,record_step:0.1)
      plot.add(get_signal(xout,"x1"),label:$x_1$)
      plot.add(get_signal(xout,"x2"),label:$x_2$)
      plot.add(get_signal(xout,"x3"),label:$x_3$)
      plot.add(get_signal(xout,"x4"),label:$x_4$)
    },
    y-label:"value",
    x-label:"time",
    title:$delta=#C$
    )
})
)
#table(columns:(auto,auto,auto),align: center+horizon,
  [],$x^((4))=u$,$x^((4))=u+10*sin(t)$,
  [linear\ feedback],..highorder(x=>-(x.x1)-4*(x.x2)-6*(x.x3)-4*(x.x4)),
  [relay SMC\ feedback],..highorder(x=>-10*sign(x.x1+2*sig(x.x2,4/3)+2*sig(x.x3,2)+sig(x.x4,4))),
  )


#pagebreak()
#columns(2)[
  Consider the system 
  $
  sigma^((r))=u+delta.
  $
  Nested Sliding Controllers are given by 
  $
  u&=-alpha Psi_(r-1,r)(sigma,dot(sigma),dots,sigma^((r-1)))\
  Psi_(0,r)&="sign"(sigma)\
  Psi_(i,r)&="sign"(sigma^((i))+beta_i N_(i,r) Psi_(i-1,r))\
  N_(i,r)&=(|sigma|^(1/r)+|dot(sigma)|^(q/(r-1))+dots + |sigma^(q/(r-i+1))|)^(1/q)
  $
]



#pagebreak()