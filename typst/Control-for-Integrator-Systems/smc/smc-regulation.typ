#let main()=figure(
table(
  columns: (auto,auto,auto,auto,auto),
  [Sliding Mode Controller],[name],[Sliding\ variable\ convergence],[Output\ Tracking\ convergence], [Type],
  //Traditional
  $
  u=rho "sign" (sigma)\ sigma=dot(e)+c e
  $,
  [Traditional],[Finite time],[Asymptotic],[Discontinuous],
  //integral
  $
  u=u_1+u_2,\
  u_1=rho_1 "sign"(s) ,
  u_2=-integral sigma "d" t\ 
  sigma=dot(e)+c e\ s=sigma-z, dot(z)=-u_2
  $,
  [integral],[$s$: Finite time\ $sigma$: Asysmptotic],[Asymptotic],[Discontinuous],
  //integral2 continuous
  $
  dot(u)=v,\
  v=c overline(c) dot(e)+(c+overline(c))u+rho "sign"(s)\ 
  s=dot(sigma)+overline(c) sigma,
  sigma=dot(e)+c e
  $,
  [integral],[$s$: Finite time\ $sigma$: Asysmptotic],[Asymptotic],[Continuous],
  //Super-twisting
  $
  u=c |sigma|^(1/2) "sign"(sigma)+w\ dot(w)=b "sign"(sigma)\ sigma=dot(e)+c e
  $,
  [Super-twisting\ (Second Order SMC)],[Finite time],[Asymptotic],[Continuous],
  //
  $u=-rho "sign"(sigma)\ sigma=dot(e)+c|e|^(1/2)"sign"(e)$,
  [prescribed\ convergence\ law],
  [Finite time],[Finite time],[Discontinuous],
  // rise
  $
  u=(k_s+1)e_2(t)-(k_s+1)e_2(0)+w\
  dot(w)=(k_s+1) alpha e_2 + beta "sign" e_2 \
  e_1=e, 
  e_2=dot(e)_1+e_1\ 
  $,
  [RISE],
  [],[Asysmptotic],[Continuous]
),caption: [regulate the system $dot.double(e)=dot.double(y)_c-f-u$]
)
#set page(width: 210mm,height: auto,margin: 1cm)
#main()