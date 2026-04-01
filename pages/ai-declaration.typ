
#let ai-declaration(ai-tools) = {
  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(upper(it.body), size: 11pt, weight: 0, tracking: 1pt, top-edge: 0.75em, bottom-edge: 1pt)
    line(length: 100%, stroke: 1pt)
  }

  [
    #heading(level: 1, numbering: none)[AI Declaration]
    This thesis was written independently and was linguistically revised with the help of #ai-tools.join(", ", last: " and ").
  ]
}
