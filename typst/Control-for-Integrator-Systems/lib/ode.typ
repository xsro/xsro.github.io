// solve ode equation with single state
#let ode(func,tfinal,x0,step)={
  let t=0.
  let x=x0
  let xout=((t,x),)
  let dxout=()
  while t < tfinal{
    let k1=func(t,x)
    dxout.push((t,k1))
    let k2=func(t+step/2,x+step/2*k1)
    let k3=func(t+step/2,x+step/2*k2)
    let k4=func(t+step,x+step*k3)
    t=t+step
    x=x+step/6*(k1+2*k2+2*k3+k4)
    xout.push((t,x))
  }
  dxout.push((t,func(t,x)))
  (xout,dxout)
}

#let sign(a)={
  if calc.abs(a)==0{
    0
  }else{
    a/calc.abs(a)
  }
}

#let sat(a,threhold)={
  if calc.abs(a)>threhold {
    sign(a)*threhold
  }else{
    a
  }
}



#let (x,dx)=ode((t,x)=>-x,10,1,0.01)
#x.at(0)
#x.at(-1)