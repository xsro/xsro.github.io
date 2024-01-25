#let main()=figure(
table(
  columns: (auto,auto,auto,auto,auto),
  [Sliding Mode Controller],[name],[Sliding\ variable\ convergence],[Output\ Tracking\ convergence], [Type],
  //
  $u=rho "sign" (sigma)\ sigma=dot(e)+c e$,
  [Traditional],[Finite time],[Asymptotic],[Discontinuous],
  //
  $u=u_1+u_2,\
  u_1=rho_1 "sign"(s) ,
  u_2=-integral sigma "d" t\ 
  sigma=dot(e)+c e\ s=sigma-z, dot(z)=-u_2$,
  [integral],[Asysmptotic],[Asymptotic],[Discontinuous],
  //
  $u=c |sigma|^(1/2) "sign"(sigma)+w\ dot(w)=b "sign"(sigma)\ sigma=dot(e)+c e$,
  [Super-twisting],[Finite time],[Asymptotic],[Continuous],
  //
  $u=-rho "sign"(sigma)\ sigma=dot(e)+c|e|^(1/2)"sign"(e)$,
  [prescribed\ convergence\ law],
  [Finite time],[Finite time],[Discontinuous],
)
)
#set page(width: 210mm,height: auto,margin: 1cm)
#main()