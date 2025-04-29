#let sign(x)={
  if calc.abs(x)==0 {
    0
  }
  else if x > 0 {
    1
  }
  else if x < 0 {
    -1
  }
}

#let sig(x,q)={
  if x==0{
    0
  }
  else{
    sign(x)*calc.pow(calc.abs(x),q)
  }
}

#let sat(x,th)={
  if calc.abs(x)>th{
    sign(x) * th
  }
  else{
    x
  }
}