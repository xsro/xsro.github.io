#set page(paper:"presentation-16-9",margin: 1cm)
#set text(size:0.5cm)
#set figure.caption(position: top)
#set heading(numbering: "1.1")
#set math.equation(
  numbering: "(1)",
  supplement: none,
)
#show ref: it => {
  // provide custom reference for equations
  if it.element != none and it.element.func() == math.equation {
    // optional: wrap inside link, so whole label is linked
    link(it.target)[(#it)]
  } else {
    it
  }
}

#text(size: 1cm)[Sliding Mode Control for Integrator Systems]
#outline(indent: 1cm)
#bibliography("ref.bib",style: "gb-7714-2015-author-date")

#pagebreak()

//part 1
#include "1linear.typ"

//part 4 PTC
#include "4PTC.typ"

// part 2
#include "2single.typ"

//part 3
#include "3double.typ"

//part 5
#include "5Filippov.typ"

#align(center+horizon,text(blue,size:3cm)[THANKS])












