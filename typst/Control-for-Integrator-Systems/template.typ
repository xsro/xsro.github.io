#let template(title:"title",part:"part",part_no:0,body) = [
  #set page(paper:"presentation-16-9",margin: 1cm)

  #let get_pdf_url(part_no:0)={
    if part_no == 0{
      return "https://xsro.github.io/"
    }
    else if part_no == 1{
      return "https://xsro.github.io/print/Control-for-Integrator-Systems.pdf"
    }
    else {
      return "https://xsro.github.io/print/Control-for-Integrator-Systems-"+str(part_no)+".pdf"
    }
  }

  #align(center+horizon)[
    #text(rgb("#005826"),size: 1cm,title)

    #text(black,size: 0.8cm)[*Part #part_no*: #part]

    #text(black,size: 0.4cm,)[
      #link(get_pdf_url(part_no: part_no))

      #link("https://xsro.github.io/posts/release/control-for-integrator-systems/","xsro.github.io")
    ]

    #text(black,size: 0.4cm,)[#link("mailto://xsro@foxmail.com","xsro@foxmail.com")]

  ]


  #pagebreak()
  #set page(
    header: link(get_pdf_url(part_no: part_no),text(gray,size:0.2cm)[xsro.github.io (#datetime.today().display())])
  )

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

  

  #outline(indent: 1cm)
  #bibliography("ref.bib",style: "gb-7714-2015-author-date")

  #pagebreak()

  #body

  #align(center+horizon,text(blue,size:3cm)[THANKS])
]

