#import "common.typ": definition,theorem,proposition,proposition
#pagebreak(weak: true)
= Topological Space

- 拓扑学 http://staff.ustc.edu.cn/~wangzuoq/Courses/22S-Topology/

== Metic Space

#definition[
  A *metric space* $(M,d)$ consists of a set $M$ and a mapping, 
  called distance, $d: M times M arrow RR$, 
  which satisfies the following:
  + $0<=d(x,y)<infinity, forall x,y in M$
  + $d(x,y)=0$, if and only if $x=y$
  + $d(x,y)=d(y,x)$
  + Triangle Inequality: $d(x,z)<=d(x,y)+d(x,z),x,y,z in M$
]

#definition[
  Let $V$ be a vector space,
  if there exists a mapping $norm(dot): V arrow RR$,
  satisfying 
  + $norm(dot) >=0$, $forall x in V$ and $norm(x)=0$, if and only if $x=0$
  + $norm(r x)=abs(r)norm(x)$, $r in RR$, $x in V$
  + Triangle Inequality: $norm(x+y)<=norm(x)+norm(y),quad x,y in V$
  Then $(M,norm(dot))$ is called a *normed space*, 
  and $norm(x)$ is called the norm of $x$
]

#let product(x,y)={
  [$angle.l #x,#y angle.r$]
}
#definition[
  Given a vector space $V$.
  If there exists a mapping $product(dot,dot):V times V arrow CC$, 
  satisfies the following requirements:
  + $product(x,x)>=0,forall x in V$. Moreover, $product(x,x)=0$, if and only if $x=0$
  + $product(x,y)=overline(product(y,x)), x,y in V$
  + $product(a x+b y,z)=a product(x,z)+b product(y,z),x,y,z in V, a,b in CC$
  Then $(V,product(dot,dot))$ is called an *inner product space*,
  and $product(x,y)$ is called the inner product of $x,y$
]

#proposition[
  + Let $V$ be an inner product space.
    Define a norm on $V$ as 
    $norm(x)=sqrt(product(x,x))$
    Then $V$ becomes a normed space. Such a norm is called the norm induced by the inner product
  + Let $M$ be a normed space.
    Define a distance $d$ as 
    $d(x,y)=norm(x-y)$,
    Then $M$ becomes a metric space.
]
#definition[
  A metric space $M$ is complete if each Cauchy sequence ${x_n}$ converges to a point $x in M$.
]

== Topological Spaces

#definition[
  Given a set $X$ and a set of its subsets $cal(T)$.
  + $(X,cal(T))$ is called a topological space, 
    if $cal(T)$ satisfies the following
    + $X in cal(T), emptyset in cal(T)$;
    + If $U_lambda in cal(T),forall lambda in Lambda subset RR$, then $union_(lambda in Lambda) U_lambda in cal(T)$;
    + If $U_i in cal(T), i=1,dots,n$, then $sect_(i=1)^n U_i in cal(T)$
  + An element in $U in cal(T)$ is called an open set.
    Its complement,denoted by $U^c$ is called a closed set.
  + For a point $x in X$, a subset $N$ is called a neighborhood of $x$ if there exists an open set $U$ such that $x in U subset N$
  + Let $cal(B) subset cal(T)$. $cal(B)$ is a topological basis if any element $U in cal(T)$ can be expressed as a union of some elements in $cal(B)$
  + A set of neighborhoods $cal(N) subset cal(T)$ is called a neighborhood basis of $x$ if for any neighborhood $N$ of $x$, there is an $N_0 in cal(N)$, such that $N_0 subset N$
]


== Continuous Mapping

#definition[
Let $M$, $N$ be two topological spaces.
A mapping $pi:M arrow N$ is continuous,
if one of the following two equivalent conditions holds:

- For any $U subset N$ open, its inverse image 
  $
  pi^(-1)(U):={x in M | pi(x) in U}
  $
  is open 
- For any $C subset N$ closed, its inverse image $pi^(-1)(C)$ is closed
]

*Note*: the two conditions are equivalent.

#definition[
Let $M$,$N$ be two topological spaces.
$M$ and $N$ are said to be homeomorphic(同胚 pei 胚胎) 
if there exists a mapping $pi:M arrow N$, which is 
+ one-to-one( 单射 injective), 
+ onto(满射 surjective) 
+ and continuous (both $pi$ and $pi^(-1)$ are continuous).
$pi$ is called a homeomorphism.
]

*Note*: If a mapping is both injective and surjective it is said to bijective(满射).

#definition[
Given a topological space $M$.
+ A set $U subset M$ is said to be clopen if it is both closed and open.
  A topological space(度量空间), $M$, is said to be *connected* if the only two clopen sets are $M$ and $emptyset$
+ A continuous mapping $pi: I=[0,1] arrow M$ is called a path on $M$.
  $M$ is said to be *pathwise(or arcwise) connected* if for any two points $x,y in M$ there exists a path,
  $pi$, such that $pi(0)=x$ and $pi(1)=y$
]

*Tip on open and closed set*: As described by topologist James Munkres, unlike a door, "a set can be open, or closed, or both, or neither!"
#link("https://en.wikipedia.org/wiki/Clopen_set")
A set is closed if its complement is open.
But A set can be closed or open if its complement is closed.\
#link("https://en.wikipedia.org/wiki/Open_set")\
A subset $U$ of a metric space $(M,d)$ is called open if,
for any point $x$ in $U$, 
there exists a real number $epsilon$ 
such that any point $y in M$ satisfying $d(x,y)<epsilon$ belongs to $U$.
Equivalently, $U$ is open if every point in $U$ has a neighborhood contained in $U$.

*Note*: $RR$ is connected and A pathwise connected space $M$ is connected while the converse is incorrect.

#definition[
A topological space $M$ is said to be _locally connected_ at $x in M$ if every neighborhood $N_x$ of $x$ contains a connected neighborhood $U_x$, i.e., $x in U_x subset N_x$. 
$M$ is said to be locally connected if it is locally connected at each $x in M$
]

local connectedness does not imply connectedness 
(hence no pathwise connectedness); 
conversely, pathwise connectedness (connectedness) does not imply local connectedness.

#definition[
  Let ${U_lambda|lambda in Lambda}$ be a set of open sets in $M$.
  The set is called an open covering of $M$ if 
  $
  union.big_(lambda in Lambda) U_lambda supset M.
  $
  $M$ is said to be a compact space if every open covering has a finite sub-covering,
  i.e., there exists a finite subset ${U_lambda_i| i=1,2,dots,k}$ such that 
  $
  union.big_(i=1)^k U_(lambda_i) supset M
  $
]

From Calculus we know that with the conventional topology,
a set, $U subset RR^n$ is compact, if and only if it is bounded and closed.
Unfortunately, it is not true for general metric spaces.

#definition[
  In a topological space,
  $M$, a sequence ${x_k}$ is said to converge to $x$, 
  if for any neighborhood $U in.rev x$ there exists a positive integer
  $N>0$ such that when $n>N$, $x_n in U$.
]

+ Impose the discrete topology on $RR^1$. i.e., each point is an open set.
  Then $x_k$ converges to nowhere.
  Because it can never get into any ${r}$, which is a neighborood of $r$
// commented if 
// + Impose the co-finite topology on $RR^1$.
//   Recall that in this topology $U != emptyset$ is open,
//   if and only if $U^c$ is finite.
//   Then $x_k$ converges to every point.
//   Let $r in RR$ be any point, and $U in.rev r$ be a co-finite neighborhood.
//   Since $U^c$ is finite at most finite $x_k in U^c$.

#proposition[
  Let $M$, $N$ be two topological spaces.
  $M$ is first countable.
  $f: M arrow N$ is continuous,
  if and only if for each $x_k arrow x$, $f(x_k) arrow f(x)$
]

#definition[
  A topological space is called sequentially compact if 
  every sequence contains a convergent subsequence.
]

#definition[
  (*Bolzano-Weierstrass*) Let $M$ be a first countable topological space.
  if $M$ is compact, it is sequentially compact.
]




== Quotient Spaces

#definition[
  Let $S$ be any set and $tilde$ be a relation between two elements of $S$.
  $tilde$ is said to be an equivalent relation if
  1. $x tilde x$
  2. If $x tilde y$, then $y tilde x$
  3. If $x tilde y$, and $y tilde z$, then $x tilde z$
]

#definition[
  Let M be a topological space, 
  "$tilde$" an equivalent relation on $M$
]