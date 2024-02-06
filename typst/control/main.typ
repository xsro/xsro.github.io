#set page(width: 210mm,height: auto,margin: 1cm)
#text(size: 1cm)[Illustrations for Control Theory]
#text(size:0.5cm)[build at: #datetime.today().display()]
#outline()
#pagebreak()

#set figure.caption(position: top)

= SMC Chattering Elimination: Quasi-Sliding Mode
In many practical control systems, including DC motors and aircraft control, 
it is important to avoid control chattering by providing continuous/smooth signals.
One obvious solution to make the control function continuous/smooth is to approximate the discontinuous function $v(sigma)=-rho "sign" (sigma)$ by some continuous/smooth function.
For instance, it could be replaced by a "sigmoid function".
#import "smc/quasi-sliding.typ":sigmoid
#sigmoid()
#pagebreak()

= Ternary Differential Equations' Solutions
#set text(size:7pt)
#import "smc/ternary.typ": ternary
#ternary()
#pagebreak()
#set text(size:11pt)

= Conditions for Existence and Uniqueness of Classical, Caratheodory, Filippov Solutions
#import "smc/solution-existence-uniqueness.typ": solution
#solution()
#pagebreak()

= Sliding Mode Control Algorithms
Consider the system $dot.double(y)=u+f$, design $u$ to regulate $y$ to track $y_c$.
define error variable $e=y_c-y$, then $dot.double(e)=dot.double(y)_c-f-u$.
Convergence requirements and analysis can be found at
@shtesselSlidingModeControl2014 for SMC ,
@xianContinuousAsymptoticTracking2004 for RISE
#import "smc/smc-regulation.typ": main 
#main()
#pagebreak()

= Fractional power feedback

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

#import "homogenetity/fracpower.typ": main,main2
#set text(size:7pt)
#main
#set text(size:11pt)
#pagebreak()

= Fractional (negative) power feedback

Faster covergence will be found if we use negative power.
However, this will need infinite gain (infinite energy).
So, it is impossible for physical implementation.
Simulations are carried out with a satutated power function
for the infinite gain is not possible to simulate.

#main2




#pagebreak()


#bibliography("ref.bib",style: "gb-7714-2015-author-date")

