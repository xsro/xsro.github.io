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
     [essentially one-sided Lipschitz on $B(x, epsilon)$],
  ),
  caption:[conditions of solutions to $dot(x)=X(x(t))$]
)
#pagebreak()
