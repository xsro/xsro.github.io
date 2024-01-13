#import "common.typ":exercise

#exercise(code:"5.6")[
  Verify that $D_+W(t)$ satisfies @5.12(5.12 in textbook) when $V(t,x(t))=0$.
$
D_+ W <= (c_4 L)/(2 sqrt(c_1)) norm(u(t))
$<5.12>

Hint: Using Exercise 3.24, show that $
  V(t+h,x(t+h))<=c_4 h^2 L^2 norm(u)^2 \/2 + h o(h)
  $ where $o(h)/h arrow 0$ as $h arrow 0$.
  Then apply $c_4>=2 c_1$
]

From textbook, the system is 
$
dot(x)=f(t,x,u),x(0)=x_0\
y=h(t,x,u)
$

From $V(t,x(t))=0$ and @Vbound, we have $x(t)=0$

Let $V(t,x(t))=0$.
$
D_+W &= lim sup_(h arrow 0^+) 1/h [W(t+h,x(t+h))-W(t,x(t))]\
     &= lim sup_(h arrow 0^+) 1/h sqrt(V(t+h,x(t+h)))
$ 
From @Vbound, We have 
$
  V(t+h,x(t+h)) <=
  c_4/2 norm(x(t+h))^2\
$

From textbook 5.9, we have
$
norm(f(t,x(t),u)-f(t,x(t),0)) <= L norm(u)
$
Use Taylor Series:
$
x(t+h)= f(t,x,u) h + o(h) \
arrow.stroked
norm(x(t+h))^2
<=(norm(f(t,x,u))h+norm(o(h)))^2
$
$
1/h^2 V(t+h,x(t+h)) 
<= c_4/2 (norm(x(t+h))/h)^2 
<= c_4/2 (norm(f(t,x,u))+norm(o(h))/h)^2
$
$
lim sup_(h arrow 0^+) 1/h sqrt(V(t+h,x(t+h)))
<= sqrt(c_4/2) norm(f(t,x,u))
<= sqrt(c_4/2) L norm(u)
$
since $sqrt(c_4\/(2c_1))>=1$. Thus
$
D_+ W <=  sqrt(c_4/2) L norm(u) sqrt(c_4\/(2c_1))= (c_4 L)/(2 sqrt(c_1)) norm(u(t))
$
which agrees with the right hand side of @5.12