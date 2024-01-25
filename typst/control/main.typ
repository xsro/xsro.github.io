#set page(width: 210mm,height: auto,margin: 1cm)
#text(size: 1cm)[Illustrations for Control Theory]
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
see @shtesselSlidingModeControl2014 for convergence requirements and analysis.
#import "smc/smc-regulation.typ": main 
#main()
#pagebreak()


#bibliography("ref.bib")