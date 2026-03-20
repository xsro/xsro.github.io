#import "template.typ": template

#show: template.with(
  title:[*Sliding Mode Control*],
  part_no: 4,
  part:[Noncontinuous Control Theory],
)

= Discontinuous System Theory

see @cortesDiscontinuousDynamicalSystems2008

#pagebreak()
== Ternary Differential Equations' Solutions
#text(size:0.33cm)[
  #figure(table(
  columns: (auto, auto, auto,auto,auto),
  inset: 10pt,
  align: horizon+left,
  [*differetial* \ *equation*], [*differetial inclusion*], [*classical solution*],[*caratheodory solution*],[*Filippov solution*],
  // row 1
  $dot(x)=cases(
    1 " if" x<0,
    a " if" x=0,
    -1 "if" x>0,
  )$,
  $dot(x) in cal(F)(x) = cases(
    1 " if" x<0,
    [-1,1] " if" x=0,
    -1 "if" x>0,
  )$,
  [
    Only when $a=0$, classical solution exists.\
    The maximal classical solution is 
    1. if $x(0)>0$, $x_1(t)=x(0)-t, t<x(0)$
    2. if $x(0)<0$, $x_2(t)=x(0)+t, t< -x(0)$ 
    3. if $x(0)=0$, $x_3(t)=0, t in [0,infinity)$ 
  ],
  [
    Only when $a=0$, caratheodory solution exists.\
   The maximal classical solution is
    1. if $x(0)>0$, $x_1(t)=max(x(0)-t,0), t in [0,infinity)$
    2. if $x(0)<0$, $x_2(t)=min(x(0)+t,0), t in [0,infinity)$
    3. if $x(0)=0$, $x_3(t)=0, t in [0,infinity)$ 
    *Note*:These only absolutely continuous
    (not continuously differentiable) 
  ],
  [
    Whatever the value of $a$ is, 
    the Filippov solution is
    1. if $x(0)>0$, $x_1(t)=max(x(0)-t,0), t in [0,infinity)$
    2. if $x(0)<0$, $x_2(t)=min(x(0)+t,0), t in [0,infinity)$
    3. if $x(0)=0$, $x_3(t)=0, t in [0,infinity)$ 
  ],
  // row 2
    $dot(x)=cases(
    -1 " if" x<0,
    a " if" x=0,
    1 "if" x>0,
  )$,
  $dot(x) in cal(F)(x) = cases(
    -1 " if" x<0,
    [-1,1] " if" x=0,
    1 "if" x>0,
  )$,
  [
    From $x=x(0) != 0 $,classical solution exists as 
    1. $x_1(t)=x(0)+t$ if $x(0)>0$
    2. $x_2(t)=x(0)-t$ if $x(0)<0$
    From $x=x(0) = 0 $, classical solution exists when $a=1$ or $a=-1$
    1. when $a=1$, $x_1(t)=t, t in [0,infinity)$
    2. when $a=-1$,$x_2(t)=-t, t in [0,infinity)$
  ],
  [
    From $x=x(0) != 0 $,classical solution exists as 
    1. $x_1(t)=x(0)+t$ if $x(0)>0$
    2. $x_2(t)=x(0)-t$ if $x(0)<0$.
    From $x=x(0) = 0 $, two  caratheodory solutions exist for *all* $a in RR$
    1. $x_1(t)=t, t in [0,infinity)$
    2. $x_2(t)=-t, t in [0,infinity)$
    These two solutions only violate the vector field in $t=0$
  ],
  [
    Filippov solution exists for all $a in RR$ and $x(0) in RR$.
    1. if $x(0) >= 0$, $x_1(t)=x(0)+t, t in [0,infinity)$
    2. if $x(0) <= 0$,, $x_2(t)=x(0)-t, t in [0,infinity)$
    *Note*: When $x(0)=0$, exists two Filippov solutions.
  ],
  $dot(x)=cases(
      1 "if" x != 0,
      0 "if" x=0
    )
  $,
  $dot(x) in {1}
  $,
  $x=0,t in [0,infinity)$,
  [
    two caratheodory solutions:
    1. $x(t)=0, t in [0,infinity)$
    2. $x(t)=t, t in [0,infinity)$
  ],
  [
    one unique solution:
    1. $x(t)=t, t in [0,infinity)$
  ]
),caption:"solutions to ternary differential equations")
]
#pagebreak()


== Conditions for Existence and Uniqueness of Classical, Caratheodory, Filippov Solutions
#figure(
  table(
    columns: (auto, auto, auto,auto),
    inset: 10pt,
    align: horizon,
    [],
    "solution",
    "existence",
    "uniqueness",
    //classical
    "classical",
    [continuously differentiable],
    [$X: RR^d arrow RR^d$ is continuous ],
     [essentially one-sided Lipschitz on $B(x, epsilon)$,
    #footnote([
      Every vector field that is locally Lipschitz at $x$ 
      satisfies the one-sided Lipschitz condition on a neighborhood of $x$, but the converse is not true.
    ])],
    //Filippov
    "Filippov",
    "absolutely continuous",
     [$X: RR^d arrow RR^d$ is measurable and locally essentially bounded ],
     [Prosition 4&5],
  ),
  caption:[conditions of solutions to $dot(x)=X(x(t))$]
)


*Proposition 4*


Let $X: RR^d arrow RR^d$ be measurable and locally essentially bounded. 
Assume that, for all $x \in RR^d$, there exists $epsilon.alt > 0$ such that $X$ is essentially one-sided Lipschitz on $B(x, epsilon.alt)$. 
Then, for all $x_0 in RR^d$, there exists a unique Filippov solution of (10) with initial condition $x(0) = x_0$.

*Proposition 5*

Let $X: RR^d arrow RR^d$ be a piecewise
continuous vector field, with $RR^d =
D_1 union D_2$. Let $S_X = "bdry"(D_1) =
"bdry"(D_2)$ be the set of points at
which $X$ is discontinuous, and
assume that $S_X$ is a $C^2$-manifold.
Furthermore, assume that, for
$i in {1,2}$, $X|_(overline(D_i))$ is continuously dif-
ferentiable on $D_i$ and $X|_(overline(D_1)) - X|_(overline(D_2))$
is continuously differentiable on
$S_X$. If, for each $x in S_X$, either
$X|_(overline(D_1))(x)$ points into $D_2$ or $X|_(overline(D_2))(x)$
points into $D_1$, then there exists a
unique Filippov solution of (10)
starting from each initial condition.
#pagebreak()


