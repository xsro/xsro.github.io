#set page(width: auto,height: auto,margin: 1cm)
#let solution()=figure(
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
#let m=2
#solution()