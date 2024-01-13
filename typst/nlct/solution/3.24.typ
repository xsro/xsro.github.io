#import "common.typ":exercise,solve

#exercise(code:" 3.24 ")[
  Let $V: RR times RR^n arrow RR$
  be continuously differentiable. 
  Suppose that $V(t,0)=0$ for all $t >= 0$ and 
  $
  V(t,x) >= c_1||x||^2;
  norm((diff V)/(diff x)(t,x)) <= c_4 norm(x),
  forall 
  (t,x) in [0,infinity) times D
  $
  where $c_1$ and $c_4$ are positive constants and 
  $D subset RR^n$ is a convex domain that contains the origin
  $x=0$
  
  + Show that $V(t,x) <= 1/2 c_4 norm(x)^2$ for all $x in D$. \
   Hint: Use the representation $V(t,x)=integral_0^1 (diff V)/(diff x) (t,sigma x) d sigma x $
  + Show that the constants $c_1$ and $x_4$ must satisfy $2 c_1 <= c_4$
  + Show that $W(t,x)=sqrt(V(t,x))$ satisfies the Lipschitz condition
  $
  |W(t,x_2)-W(t,x_1)| <= 
  c_4 /(2 sqrt(c_1)) norm(x_2-x_1),
  forall t >= 0,
  forall x_1,x_2 in D
  $
]

#solve(1)

$
V(t,x)=integral_0^1 (diff V)/(diff V)(t,sigma x) d x 
<= integral_0^1 norm((diff V)/(diff x)(t,sigma x)) norm(x) d sigma 
<= integral_0^1 c_4 sigma  d sigma norm(x)^2 
<= 1/2 c_4 norm(x)^2
$

#solve(2)

Since 
$
c_1 norm(x)^2 
<= V(t,x) 
<= 1/2 c_4 norm(x)^2,
forall x in D
$<Vbound>
we must have $c_1<=1/2 c_4$

#solve(3)

Consider two ponts $x_1$ and $x_2$ such that $alpha x_1 + (1-alpha)x_2 != 0$
for all $0<=alpha<=1$; that is, 
the orgin does not lie on the line connecting $x_1$ and $x_2$.
The Jacobian $[diff W \/ diff x]$ is defined for every $x=alpha x_1 + (1-alpha )x_2$ and given by 
$
(diff W)/(diff x)(t,x)=1/(2 sqrt(V(t,x))) (diff V)/(diff x)(t,x)
$
By the mean value theorem, there is $alpha^* in (0,1)$
such that, with $z=alpha^* x_1+(1-alpha^*)x_2$
$
W(t,x_2)-W(t,x_1)
=(diff W)/(diff x)(t,z) (x_2-x_1)
= 1/(2 sqrt(V(t,z))) (diff V)/(diff x)(t,z)(x_2-x_1)
$
Hence 
$
|W(t,x_2)-W(t,x_1)|
<= 1/(2 sqrt(c_1) norm(z))
$
Consider now the case when the origin lies on the line connecting $x_1$ and $x_2$;
that is , $0=alpha_0 x_1+(1-alpha_0)x_2$ for some $alpha_0 in [0,1]$.
We have 
$
abs(W(t,x_2)-W(t,0)) 
= abs(W(t,x_2))=sqrt(V(t,x_2))
<=sqrt(c_4/2)norm(x_2)\
abs(W(t,x_1)-W(t,0)) 
= abs(W(t,x_1))=sqrt(V(t,x_1))
<=sqrt(c_4/2)norm(x_1)\
abs(W(t,x_2)-W(t,x_1))
=abs(W(t,x_2)-W(t,0)+W(t,0)-W(t,x_1))
<=sqrt(c_4/2)(norm(x_1)+norm(x_2))
$
Since the origin lies on the line connecting $x_1$ and $x_2$,
we have $norm(x_2)+norm(x_1)=norm(x_2-x_1)$.
We also have $1<=sqrt(c_4 \/ 2 c_1)$.
Therefore,
$
abs(W(t,x_2)-W(t,x_1))<=c_4/(2sqrt(c_1))norm(x_2-x_1)
$
