#import "@preview/codelst:2.0.2": *
#import "@preview/hydra:0.6.1": hydra
#import "@preview/abbr:0.3.0"
#import "@preview/glossarium:0.5.6": gls, glspl, make-glossary, print-glossary, register-glossary
#import "locale.typ": APPENDIX, REFERENCES, TABLE_OF_CONTENTS
#import "pages/titlepage.typ": *
#import "pages/title-back.typ": *
#import "pages/declaration-of-authorship.typ": *
#import "check-attributes.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let seemoo-abbr = abbr


#let clean-seemoo(
  title: none,
  subtitle: none,
  authors: (:),
  language: none,
  type-of-thesis: none,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-table-of-figures: true,
  show-table-of-tables: true,
  show-title-back: true,
  show-abstract: true,
  abstract: none,
  appendix: none,
  declaration-of-authorship-content: none,
  titlepage-content: none,
  city: "Darmstadt",
  supervisor: (:),
  date: none,
  date-format: "[month repr:long] [day], [year]",
  bibliography: none,
  glossary: none,
  bib-style: "ieee",
  math-numbering: "(1)",
  enable-math-numbering: false,
  logo-top: image("graphics/logos/tud-logo-rgb.pdf"),
  logo-bottom: image("graphics/logos/seemoo-logo-rgb.pdf"),
  ignored-link-label-keys-for-highlighting: (),
  abbr-list-csv: "abbr.csv",
  abbr-page-break: true,
  table-of-figures-page-break: true,
  table-of-tables-page-break: false,
  pdf-version: "v1.0.0",
  body,
) = {
  // check required attributes
  let many-authors = authors.len() > 3
  check-attributes(
    title,
    authors,
    language,
    type-of-thesis,
    show-declaration-of-authorship,
    show-table-of-contents,
    show-abstract,
    abstract,
    appendix,
    supervisor,
    date,
    city,
    glossary,
    bibliography,
    bib-style,
    logo-top,
    logo-bottom,
    math-numbering,
    ignored-link-label-keys-for-highlighting,
  )

  // ---------- Fonts & Related Measures ---------------------------------------

  let body-font = "Palatino"
  let body-size = 11.4pt
  let heading-font = "Palatino"
  let h1-size = 11pt
  let h2-size = 10pt
  let h3-size = 10pt
  let h4-size = 10pt
  let page-grid = 13pt // vertical spacing on all pages


  // ---------- Basic Document Settings ---------------------------------------

  set document(title: title, author: authors.map(author => author.name))
  let in-frontmatter = state("in-frontmatter", true) // to control page number format in frontmatter

  // customize look of figure
  set figure.caption(separator: [ --- ], position: bottom)

  // math numbering
  if (enable-math-numbering) {
    set math.equation(numbering: math-numbering)
  }

  // initialize `glossarium`
  // CAVEAT: all `figure` show rules must come before this (see `glossarium` docs)
  show: make-glossary

  // register the glossary passed in `glossary`
  if (glossary != none) {
    register-glossary(glossary)
  }

  // show links in dark blue
  // show link: set text(fill: blue.darken(40%))

  // ========== TITLEPAGE ========================================

  if (titlepage-content != none) {
    titlepage-content
  } else {
    titlepage(
      authors,
      date,
      heading-font,
      language,
      logo-top,
      logo-bottom,
      many-authors,
      supervisor,
      title,
      subtitle,
      type-of-thesis,
      date-format,
      page-grid,
    )
  }
  counter(page).update(1)

  // ---------- Heading Format (Part I) ---------------------------------------
  show heading: set text(weight: "bold", font: heading-font)
  show heading.where(level: 1): it => { v(2 * page-grid) + text(size: 2 * page-grid, it) }

  // ---------- Page Setup ---------------------------------------

  // adapt body text layout to basic measures
  set text(
    font: body-font,
    lang: language,
    size: body-size - 0.5pt, // 0.5pt adjustment because of large x-hight
    top-edge: 0.75 * body-size,
    bottom-edge: -0.25 * body-size,
    fill: luma(0),
  )
  set par(
    spacing: page-grid,
    leading: page-grid - body-size,
    justify: true,
  )

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 3.7cm,
      outside: 3.7cm,
      inside: 2.4cm,
    ),
    header: text(
      font: heading-font,
      size: body-size,
      context if (
        not query(heading.where(level: 1).after(here())).map(h => h.location().page()).at(0, default: 0)
          == here().page()
      ) {
        if calc.odd(here().page()) {
          pad(
            right: -22pt,
            align(right, hydra(
              2,
              display: (a, it) => {
                (
                  text(size: 7pt, tracking: 1pt, weight: "bold", upper(it.body)) + "      " + counter(page).display("1")
                )
              },
            )),
          )
        } else {
          pad(
            left: -22pt,
            align(left, hydra(
              1,
              display: (a, it) => {
                counter(page).display("1") + "      " + text(size: 7pt, tracking: 1pt, weight: "bold", it.body)
              },
            )),
          )
        }
      },
    ),
    header-ascent: page-grid,
  )


  // ========== FRONTMATTER ========================================

  // ---------- INFO PAGE with Confidentiality Statement------------

  if (show-title-back) {
    pagebreak()
    title-back(
      authors,
      title,
      date,
      date-format,
      pdf-version,
      language,
      supervisor,
      type-of-thesis,
    )
  }


  // ---------- Abstract ---------------------------------------

  show heading.where(level: 1): it => {
    set par(leading: 4pt, justify: false)
    text(upper(it.body), size: 11pt, weight: 0, tracking: 1pt, top-edge: 0.75em, bottom-edge: 1pt)
    line(length: 100%, stroke: 1pt)
    v(page-grid, weak: true)
  }

  if (show-abstract and abstract != none) {
    heading(level: 1, numbering: none, ABSTRACT.at("en"))
    text(abstract.first())
    v(100pt)
    heading(level: 1, numbering: none, ABSTRACT.at("de"))
    text(abstract.last())
    pagebreak()
  }

  // ---------- ToC (Outline) ---------------------------------------
  set page(numbering: "i", footer: none) // numbering for List fo Abbreviations and other entries before body

  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    set block(above: 7pt)
    set text(font: heading-font, weight: 0, size: body-size)
    link(
      it.element.location(), // make entry linkable
      grid(
        columns: (15pt, auto, 1fr, auto),
        it.prefix(), it.body(), box(width: 100%, repeat(" ")), it.page(),
      ),
      // move(dx: -10pt, it.prefix()) + it.body() + box(width: 1fr) + it.page(),
    )
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: 7pt)
    set text(font: heading-font, size: body-size)
    link(
      it.element.location(),
      grid(
        columns: (auto, auto, 1fr, auto),
        it.indented(
          it.prefix(),
          "",
        ),
        it.body(),
        box(width: 100%, repeat(" . ")),
        it.page(),
      ),
    )
  }


  if (show-table-of-contents) {
    outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: 3,
    )
  }

  // Figures
  show outline.entry.where(level: 1): it => {
    set block(above: page-grid - body-size)
    set text(font: heading-font, size: body-size)
    link(
      it.element.location(), // make entry linkable
      it.indented(
        it.prefix(),
        it.body() + "  " + box(width: 1fr, repeat([.], gap: 2pt), baseline: 30%) + "  " + it.page(),
      ),
    )
  }

  if (show-table-of-figures) {
    if table-of-figures-page-break {
      pagebreak()
    }
    [= #TABLE_OF_FIGURES.at(language)]
    outline(
      title: none,
      target: figure.where(kind: image),
      indent: auto,
      depth: 3,
    )
  }

  if (show-table-of-tables) {
    if table-of-tables-page-break {
      pagebreak()
    }
    [= #TABLE_OF_TABLES.at(language)]
    outline(
      title: none,
      target: figure.where(kind: table), //TODO verfiy
      indent: auto,
      depth: 3,
    )
  }

  // Abbreviations

  if abbr-page-break {
    pagebreak()
  }
  show: abbr.show-rule
  abbr.load(abbr-list-csv)
  abbr.config(style: key => {
    let val = if text.weight <= "medium" { 15% } else { 30% }
    set text(fill: blue.darken(val))
    key
  })
  abbr.list()


  set page(numbering: "1") // numbering for body body
  in-frontmatter.update(false) // end of frontmatter
  counter(page).update(1) // so the first chapter starts at page 1 (now in arabic numbers)

  // ========== DOCUMENT BODY ========================================


  // ---------- Heading Format (Part II: H1-H4) ---------------------------------------

  set heading(numbering: "1.1.1")

  show heading: it => {
    set par(leading: 4pt, justify: false)
    text(it, top-edge: 0.75em, bottom-edge: -0.25em)
    v(page-grid, weak: true)
  }

  show heading.where(level: 1): it => {
    set par(leading: 0pt, justify: false)
    pagebreak()
    context {
      v(page-grid * 4)
      if counter(heading).display() != "0" {
        place(
          top + right,
          dx: 50pt, // move further right, adjust as needed
          dy: -10pt, // no vertical shift
          text(
            counter(heading).display(),
            top-edge: "bounds",
            size: 70pt,
            weight: "bold",
            rgb("#8c8c8c"),
            font: "Euler Math",
          ),
        )
      }
      text(
        // heading text on separate line
        upper(it.body),
        weight: "light",
        tracking: 1.3pt,
        size: h1-size,
      )
      grid.cell(colspan: 2, line(length: 100%, stroke: 1pt))
      v(page-grid)
    }
  }

  show heading.where(level: 2): it => {
    set text(size: h2-size, weight: 100, tracking: 1pt)
    v(6pt)
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(12pt)
    }
    upper(it.body)
    v(6pt)
  }
  show heading.where(level: 3): it => {
    set text(size: h2-size, weight: 100, tracking: 1pt)
    v(6pt)
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(12pt)
    }
    emph(upper(it.body))
    v(6pt)
  }

  // ---------- Body Text ---------------------------------------

  body


  // ========== APPENDIX ========================================

  set heading(numbering: "A.1")
  counter(heading).update(0)

  // ---------- Bibliography ---------------------------------------

  show std-bibliography: set heading(numbering: none)
  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
    bibliography
  }

  // ---------- Glossary  ---------------------------------------

  // if (glossary != none) {
  //   heading(level: 1, GLOSSARY.at(language), outlined: false)
  //   print-glossary(glossary)
  // }

  // ---------- Appendix (other contents) ---------------------------------------

  if (appendix != none) {
    // the user has to provide heading(s)
    appendix
  }

  // ========== LEGAL BACKMATTER ========================================

  set heading(numbering: it => h(-18pt) + "", outlined: false)

  // ---------- Declaration Of Authorship ---------------------------------------

  if (show-declaration-of-authorship) {
    pagebreak()
    declaration-of-authorship(
      authors.first(),
      date,
      type-of-thesis,
      city,
      date-format,
    )
  }
}
