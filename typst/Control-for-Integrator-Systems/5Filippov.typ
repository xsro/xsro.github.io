
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