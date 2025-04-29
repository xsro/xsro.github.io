#import "@preview/ctheorems:0.1.0": *

#set heading(numbering: "1.1.")

#let theorem = thmbox("theorem", "Theorem", fill: rgb( "#E1F5FE"),stroke:rgb("#4FC3F7"))
#let proposition = thmbox("proposition", "Proposition", fill: rgb( "#E1F5FE"),stroke:rgb("#4FC3F7"))

#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)

#let definition = thmbox("definition", "Definition", stroke:rgb("#4FC3F7"), inset: (x: 0.3em, top: 0.2em, bottom:0.2em))

#let example = thmplain("example", "Example", numbering:none)
#let proof = thmplain(
  "proof",
  "Proof",
  base: "theorem",
  bodyfmt: body => [#body #h(1fr) $square$],
).with(numbering:none)

