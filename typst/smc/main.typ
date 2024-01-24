#import "@preview/cetz:0.2.0"

#text(size: 1cm)[Illustrations for Sliding Mode Control]

#outline()
#pagebreak()

#set figure.caption(position: top)
#set page(width: 210mm,height: auto,margin: 1cm)
= Chattering Elimination: Quasi-Sliding Mode

In many practical control systems, including DC motors and aircraft control, 
it is important to avoid control chattering by providing continuous/smooth signals.
One obvious solution to make the control function continuous/smooth is to approximate the discontinuous function $v(sigma)=-rho "sign" (sigma)$ by some continuous/smooth function.
For instance, it could be replaced by a "sigmoid function"

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