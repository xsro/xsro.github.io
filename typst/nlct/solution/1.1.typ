#import "common.typ":exercise

#exercise(code:"1.1")[
  A mathematical model that describes a wide variety of physical 
  nonlinear systems is the $n$th-order differential equation
  $
  y^"(n)"=g(t,y,dot(y),dots,y^"(n-1)",u)
  $
  where $u$ and $y$ are scalar variables.
  With $u$ as input and $y$ as output, find a state model.
]



Solution:

Let $x_1=y$,$x_2=y^"(1)"$,$dots$,$x_n=y^"(n-1)"$
$
dot(x)_1&=x_2\
dot(x)_"n-1"&=x_n\
dot(x)_"n"&=g(t,x_1,dots,x_n,u)\
y&=x_1
$