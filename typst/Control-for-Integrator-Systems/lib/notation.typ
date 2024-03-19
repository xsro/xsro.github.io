#let sign(a)={
  if calc.abs(a)==0{
    0
  }else{
    a/calc.abs(a)
  }
}
#let sig(x,q)=sign(x)*calc.pow(calc.abs(x),q)
