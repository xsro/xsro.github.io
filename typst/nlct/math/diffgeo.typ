#import "common.typ":theorem,definition

= Differentiable Manifold



== Structure of Manifolds

#definition[
  Let $(M,cal(T))$ be a second coutable,
  $T_2$(Hausdorff) topological space.
  $M$ is called an $n$ dimensional topological manifold 
  if there exists a subset $cal(A)={A_lambda | lambda in Lambda} subset cal(T)$, such that 
  + $union.big_(lambda in Lambda) A_lambda  supset M$;
  + For each $U in cal(A)$ there exists a homeomorphism $phi:U arrow phi(U) subset RR^n$, 
    which is called a coordinate chart, denoted by $(U,phi)$.
  + Moreover, if for two coordinate charts:
    $(U,phi)$ and $(V,Psi)$, if $U sect V$ is not empty, 
    then both $Psi circle.small phi^(-1): phi(U sect V) arrow Psi(U sect V)$ and $phi circle.small Psi^(-1):Psi(U sect V) arrow phi(U sect V)$ 
    are $C^r(C^infinity,C^omega)$. such two coordinate charts are said to be consistent.
  + If a coordinate chart, $W$, is consistent with all charts in $cal(A)$,
    then $W in cal(A)$.

  Then $(M,cal(T))$ is called a $C^r$($C^infinity$, analytic, respectively) differentiable manifold.
]

#definition[
  Let $M$,$N$ be two $C^r$ manifolds with dimensions $m$,$n$ respectively.
  $F:M arrow N$ is called a $C^r$ mapping, if for each $x in M$ 
  and $y=F(x) in N$ there are coordinate charts $(U,phi)$ about $x$ and $(V,psi)$ about y, such that 
  $
  tilde(F)=psi circle.small F circle.small phi^(-1)
  $
]

== Fiber Bundle

== Vector Field

== One Parameter Group

== Lie Algebra of Vector Fields

== Co-tangent Space


== Lie Derivatives 

== Frobenius’ Theory

== Lie Series, Chow’s Theorem

== Tensor Field


== Riemannian Geometry

== Symplectic Geometry