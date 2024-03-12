#let header=[
  #set text(gray,size:0.3cm)
  built with #link("https://typst.app","typst") 
  by #link("https://xsro.github.io/about","liu")
  at: #datetime.today().display()
  ]
#set page(width: 210mm,height: auto,margin: 1cm,header:header)
#set math.equation(numbering: "(1)")
#text(size: 1cm)[Sliding Mode Control for Integrator Systems]
#outline()
#pagebreak()

#set figure.caption(position: top)

#bibliography("ref.bib",style: "gb-7714-2015-author-date")

#pagebreak()

//part 1
#include "1linear.typ"

// part 2
#include "2single.typ"

//part 3
#include "3double.typ"

//part 4 PTC
#include "4PTC.typ"

//part 5
#include "5Filippov.typ"












