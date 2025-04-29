#set text(font: ("Noto Serif CJK SC","Noto Serif CJK SC"))

#set page(background: rotate(24deg,
[
  #text(180pt, fill: gray.lighten(80%))[
    *NLCT*\
  ]
  #text(50pt, fill: gray.lighten(80%))[
    (Working In Progress)
  ]
]
))

#align(center)[
  #text(gray,size: 20pt)[
    Supplement
    for 
  ]
  #text(size:24pt)[Nonlinear Systems and Control]\
  #link("mailto:xsro@foxmail.com")\
  #datetime.today().display()\
  Work In Progress
]

#outline(depth: 2,indent:2em)

Some exercises are mentioned in the textbook's mainbody.
So I organize some solutions here for reference.
Only a little solutions is presented in this supplement.
They are
#locate(loc => {
    for e in query(<exercise>, loc) [
      #link(e.location())[#e.value]
    ]
}).


#let part(short:"1",long:"1",body)={
  [
    #pagebreak()
    #set page(header: [
      #set text(gray)
      #long
    ])
    #align(
      end + horizon,
      rect(inset: 12pt,(text(size:26pt,weight:"bold")[
        #short
      ]))
    )
    #pagebreak()
    #body
  ]
}
#set math.equation(supplement: none)
#show ref: it => {
  if it.element != none and it.element.func() == math.equation {
    [(#it)]
  } else {
    it
  }
}

#set math.equation(numbering: "(1)")

#part(
  short:"Math Review",
  long:"Missing Math for Control"
)[
  #set heading(numbering: "1.1")
  #include "math/mechanic.typ"
  #include "math/ode.typ"
  #include "math/ode_numerical.typ"
  #include "math/space.typ"
  #include "math/diffgeo.typ"
]

#part(
  short:"Solutions",
  long:"Some Solutions to Nonlinear Systems(3rd edition)"
)[
  #set heading(numbering: none)
  = chapter 1 Introduction
  
  #include "solution/1.1.typ"
  
  = chapter 2 Second Order Systems
  
  = chapter 3 Fundamental Properties
  
  #include "solution/3.24.typ"
  
  = chapter 4 Lyapunov Stability 
  
  = chapter 5 Input-Output Stability
  
  #include "solution/5.6.typ"
  
  = chapter 6 Passivity
  
  = chapter 7 Frequency Domain analysis of Feedback Systems
  
  = chapter 8 Advanced Stability Analysis
  
  = chapter 9 Stability of Perturbed Systems
  
  = chapter 10 Perturbation Theory and Averaging 
  
  = chapter 11 Singular Perturbations
  
  = chapter 12 Feedback Control
  
  = chapter 13 Feedback Linearization
  
  = chapter 14 Nonlinear Design Tools
    
]

#include "references.typ"



