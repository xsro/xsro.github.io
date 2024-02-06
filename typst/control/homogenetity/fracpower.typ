#import "@preview/cetz:0.2.0"

#let plot_fun(func,y-tick-step:none,domain: (-2, 2),y-label:$dot(x)$,x-label:$x$)={
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    plot.plot(
      size: (2,2),
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

#let ode(func,tfinal,x0,step)={
  let t=0.
  let x=x0
  let out=((t,x),)
  while t < tfinal{
    let k1=func(t,x)
    let k2=func(t+step/2,x+step/2*k1)
    let k3=func(t+step/2,x+step/2*k2)
    let k4=func(t+step,x+step*k3)
    t=t+step
    x=x+step/6*(k1+2*k2+2*k3+k4)
    out.push((t,x))
  }
  out
}
#let ode_plot(func,tfinal,x0,step)={
  let out=ode(func,tfinal,x0,step)
  cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    plot.plot(
      size: (4,2),
      axis-style: "school-book", 
      x-tick-step: 1, y-tick-step: none, 
      {
        plot.add(out)
      },
      y-label:$x$,
      x-label:$t$,
      )
  })
}

#let sign(a)={
  if calc.abs(a)==0{
    0
  }else{
    a/calc.abs(a)
  }
}
#let fractionalpower(x,v)={
  if x==0 {
    0
  }else{
    sign(x)*calc.pow(calc.abs(x),v)
  }
}

#let main=figure(
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

#let sat(a,threhold)={
  if calc.abs(a)>threhold {
    sign(a)*threhold
  }else{
    a
  }
}
#let sat_fractional_power(x,v)={
  sat(fractionalpower(x,v),10)
}

#let main2=figure(
  table(
    columns:(auto,auto,auto,auto,auto),
    [system],
    [$x-dot(x)$ curve],
    [numerical solution $x=x(t)$],
    [numerical\ simulation\ step],
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
    ),
  caption: [fractional power feedback $dot(x)=-"sign"(x)|x|^v, v<0$, 
  the right-hand side function is satutated with threhold $10$]
)

#set page(width: auto,height: auto,margin: 1cm)
#main
#pagebreak()
#main2
#pagebreak()