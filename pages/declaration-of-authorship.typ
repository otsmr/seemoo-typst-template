#import "../locale.typ": *

#let declaration-of-authorship(
  author,
  date,
  type-of-thesis,
  city,
  date-format,
) = {
  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(upper(it.body), size: 11pt, weight: 0, tracking: 1pt, top-edge: 0.75em, bottom-edge: 1pt)
    line(length: 100%, stroke: 1pt)
  }


  [


    #heading(level: 1, numbering: none)[Erklärung zur Abschlussarbeit]

    #align(right)[
      _gemäß § 22 Abs. 7 und § 23 Abs. 7 APB TU Darmstadt_
    ]

    Hiermit versichere ich, #author.name, die vorliegende #type-of-thesis gemäß § 22 Abs. 7 APB der TU Darmstadt ohne Hilfe Dritter und nur mit den angegebenen Quellen und Hilfsmitteln angefertigt zu haben. Alle Stellen, die Quellen entnommen wurden, sind als solche kenntlich gemacht. Diese Arbeit hat in gleicher oder ähnlicher Form noch keiner Prüfungsbehörde vorgelegen. Mir ist bekannt, dass im Falle eines Plagiats (§ 38 Abs. 2 APB) ein Täuschungsversuch vorliegt, der dazu führt, dass die Arbeit mit 5,0 bewertet und damit ein Prüfungsversuch verbraucht wird. Abschlussarbeiten dürfen nur einmal wiederholt werden. Bei der abgegebenen Thesis stimmen die schriftliche und die zur Archivierung eingereichte elektronische Fassung gemäß § 23 Abs. 7 APB überein.

    #v(1fr) // Equivalent to \vfill

    #heading(level: 1, numbering: none)[Thesis Statement]

    #align(right)[
      _pursuant to § 22 paragraph 7 and § 23 paragraph 7 of APB TU Darmstadt_
    ]

    I herewith formally declare that I, #author.name, have written the submitted #type-of-thesis independently pursuant to § 22 paragraph 7 of APB TU Darmstadt. I did not use any outside support except for the quoted literature and other sources mentioned in the paper. I clearly marked and separately listed all of the literature and all of the other sources which I employed when producing this academic work, either literally or in content. This thesis has not been handed in or published before in the same or similar form. I am aware, that in case of an attempt at deception based on plagiarism (§ 38 paragraph 2 APB), the thesis would be graded with 5.0 and counted as one failed examination attempt. The thesis may only be repeated once. In the submitted thesis the written copies and the electronic version for archiving are pursuant to § 23 paragraph 7 of APB identical in content.

    #v(1fr)

  ]


  let end-date = if (type(date) == datetime) {
    date
  } else {
    date.at(1)
  }

  v(2em)
  emph(
    text(city + [, ] + end-date.display(date-format)),
  )

  v(1em)
  align(right, grid(
    rect(
      width: 150pt,
      height: 4em,
      inset: 1pt,
      stroke: (top: none, y: none, bottom: black),
      if author.keys().contains("signature") {
        box(author.signature)
      },
    ),
    align(center, pad(top: 6pt, author.name)),
  ))
}
