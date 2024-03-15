// solve ode equation with states expressed with dictionary
#let ode45(func,tfinal,x0,step,record_step:0.2)={
  let t=0. //initial time
  let x=x0 //initial state
  let xout=((t,x),)
  let dxout=((t,func(t,x)),)
  let dict_biop(x,y,func)={
      let x2=(:)
      for (key, value) in x0 {
        x2.insert(key,func(x.at(key),y.at(key)))
      }
      x2
    }
  let recorded_time=0;
  while t < tfinal{
    let k1=func(t,x)
    let k2=func(t+step/2,dict_biop(x,k1,(x,d)=>x+step/2*d))
    let k3=func(t+step/2,dict_biop(x,k2,(x,d)=>x+step/2*d))
    let k4=func(t+step,dict_biop(x,k3,(x,d)=>x+step*d))
    t=t+step
    for (key, value) in x0 {
      x.at(key)=x.at(key)+step/6*(k1.at(key)+2*k2.at(key)+2*k3.at(key)+k4.at(key))
    }
    if t>recorded_time+record_step{
      xout.push((t,x))
      dxout.push((t,func(t,x)))
      recorded_time=t;
    }
  }
  (xout,dxout)
}

#let get_signal(data,key)={
  let out=((data.at(0).at(0),data.at(0).at(1).at(key)),)
  for kv in data{
    out.push((kv.at(0),kv.at(1).at(key)))
  }
  out
}

#let x0 = (
  x1:0,
  x2: 2,
)
#let (xout,dxout)=ode45((t,x)=>(x1:0,x2:-x.x2,s:1),10,x0,0.1)
#xout.at(-1)
#dxout.at(-1)

