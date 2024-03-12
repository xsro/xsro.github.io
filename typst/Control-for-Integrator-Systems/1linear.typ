= Stabiliztion of Integrator Systems via linear feedback 

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

= Stabiliztion of Single Integrator Systems via positive power feedback

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

= Discussion: negative power feedback

Faster covergence will be found if we use negative power.
However, this will need infinite gain (infinite energy).
So, it is impossible for physical implementation.
Simulations are carried out with a satutated power function
for the infinite gain is not possible to simulate.

#main2
#pagebreak()