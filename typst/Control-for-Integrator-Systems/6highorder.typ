= High-Order Sliding Mode Control for Integrator Systems

#columns(2)[
  Consider the system 
  $
  sigma^((r))=u+delta.
  $
  Nested Aliding Controllers are given by 
  $
  u&=-alpha Psi_(r-1,r)(sigma,dot(sigma),dots,sigma^((r-1)))\
  Psi_(0,r)&="sign"(sigma)\
  Psi_(i,r)&="sign"(sigma^((i))+beta_i N_(i,r) Psi_(i-1,r))\
  N_(i,r)&=(|sigma|^(1/r)+|dot(sigma)|^(q/(r-1))+dots + |sigma^(q/(r-i+1))|)^(1/q)
  $
]



#pagebreak()