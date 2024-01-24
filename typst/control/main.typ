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
#import "quasi-sliding.typ":sigmoid
#sigmoid()
#pagebreak()

= Ternary Differential Equations' Solutions
#set text(size:7pt)
#import "ternary.typ": ternary
#ternary()
#pagebreak()
#set text(size:11pt)

= Conditions for Existence and Uniqueness of Classical, Caratheodory, Filippov Solutions
#import "solution-existence-uniqueness.typ": solution
#solution()