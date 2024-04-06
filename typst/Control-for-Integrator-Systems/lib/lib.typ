#import "ode-dict.typ":ode45,get_signal
#import "operation.typ" as op

// wrap ode45 to SISO problem
#let ode(func,tfinal,x0,step)={
  let (xout,dxout)=ode45((t,x)=>(value:func(t,x.value)),tfinal,(value:x0),step)
  (get_signal(xout,"value"),get_signal(dxout,"value"))
}

// notation for sig ⌊⌋ ⌈⌉
#let sig(a)=$lr(⌊#a⌉)$
