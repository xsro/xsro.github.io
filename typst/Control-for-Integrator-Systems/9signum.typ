#import "lib/lib.typ":sig
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