#let exercise(body,code:"1")={
  rect(fill: gray.lighten(60%),inset:8pt,radius:4pt,
  [
    *Exercise #code*: #label(code) #metadata(code)<exercise>
    #body
  ],)
}

#let solve(number) = {
  [*Solution to #number*]
}