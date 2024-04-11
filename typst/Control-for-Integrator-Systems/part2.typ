#set page(paper:"presentation-16-9",margin: 1cm)
#set page(header: link("https://xsro.github.io/print/Control-for-Integrator-Systems-2.pdf",text(gray.lighten(0%),size:0.2cm)[xsro.github.io (#datetime.today().display())]))
#set page(background: rotate(45deg,text(color.luma(90%),size:2cm)[working\ in progress]))
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

#text(rgb("#005826"),size: 1cm)[*Sliding Mode Control for Integrator Systems*]\
#text(black,size: 0.8cm)[*part 2*: Second and High Order Sliding Mode Control]

#outline(indent: 1cm)
#pagebreak()
#bibliography("ref.bib",style: "gb-7714-2015-author-date")

#pagebreak()

#include "9signum.typ"
#include "8sta.typ"
#include "7homo.typ"
#include "6highorder.typ"


#align(center+horizon,text(blue,size:3cm)[THANKS])