#import "fracpower.typ": plot_fun,ode_plot,sat

#let mu1(t,T:1,h:1,k1:1,k2:0)={
  if t>=T {
    0
  }else{
    k1/calc.pow(T - t,h)+k2
  }
}
#let main_tvg=figure(
  table(
    columns: (auto,auto,auto,auto),
    [system],$mu(t)$,"numerical solution","stability",
    //1/(t-T)
    [
      $T=1,h=1,k_1=1,k_2=0$
    ],
    plot_fun(mu1,domain:(0,4),y-label:$mu_1(t)$,x-label:$t$),
    ode_plot((t,x)=>-mu1(t)*x,2,1,0.01),
    [prescribed time\ stability\ convergence time\  is $T$],
    //
    [
      $T=1,h=2,k_1=1,k_2=0$ and the control signal $mu_2(t)x$ is saturated with $2$
    ],
    plot_fun(t=>mu1(t,T:1,h:2,k2:0),domain:(0,4),y-label:$mu_1(t)$,x-label:$t$),
    ode_plot((t,x)=>-sat(mu1(t,T:1,h:2,k2:0)*x,2),2,1,0.001),
    [prescribed time\ stability\ convergence time\  is $T$],
    //
    [
      $T=1,h=1/2,k_1=1,k_2=0$ and the control signal $mu_2(t)x$ is saturated with $2$
    ],
    plot_fun(t=>mu1(t,T:1,h:1/2,k2:0),domain:(0,4),y-label:$mu_1(t)$,x-label:$t$),
    ode_plot((t,x)=>-sat(mu1(t,T:1,h:1/2,k2:0)*x,2),2,1,0.001),
    [prescribed time\ stability\ convergence time\  is $T$],
    //
    [
      $T=2,h=-2,k_1=1,k_2=0$
    ],
    plot_fun(t=>mu1(t,T:2,h:-2,k2:0),domain:(0,4),y-label:$mu_1(t)$,x-label:$t$),
    ode_plot((t,x)=>-mu1(t,T:2,h:-2,k2:0)*x,4,1,0.01),
    [prescribed time\ stability\ convergence time\  is $T$],
  ), 
  caption:[time-varying gain for single integrator, $dot(x)=-mu(t)x$,
    $mu(t)=k_1/(T-t)^h+k_2, t in (0,T]$],
)

#set text(size:7pt)
#main_tvg