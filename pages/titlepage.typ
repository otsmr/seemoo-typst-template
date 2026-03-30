#import "../locale.typ": *
#import "../colors.typ": CTtitle

#let titlepage(
  authors,
  date,
  title-font,
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
) = {
  // ---------- Page Setup ---------------------------------------

  set page(
    // identical to document
    margin: (top: 4cm, bottom: 3cm, left: 3cm, right: 3cm),
  )
  // The whole page in `title-font`, all elements centered
  set text(font: title-font, size: page-grid)
  set align(center)

  // ---------- Logo(s) ---------------------------------------

  if logo-top != none {
    // one logo: centered
    place(
      top + center,
      dy: -3 * page-grid,
      box(logo-top, height: 12 * page-grid),
    )
  }

  // ---------- Title ---------------------------------------

  v(10 * page-grid)
  text(fill: CTtitle, tracking: 1.3pt, size: 0.8 * page-grid, upper(title))
  v(0.25 * page-grid)
  if subtitle != none {
    text(fill: luma(80), size: page-grid, subtitle)
  }
  v(page-grid)


  // ---------- Author(s) ---------------------------------------

  grid(
    columns: 100%,
    gutter: if (many-authors) {
      14pt
    } else {
      1.25 * page-grid
    },
    ..authors.map(author => align(
      center,
      {
        text(weight: "bold", tracking: 1.3pt, size: 7pt, upper(author.name))
      },
    ))
  )

  v(8 * page-grid)


  // ---------- Sub-Title-Infos ---------------------------------------
  //
  // type of thesis (optional)
  if (type-of-thesis != none and type-of-thesis.len() > 0) {
    align(center, text(size: 11pt, type-of-thesis))
    v(0.25 * page-grid)
  }

  // submission date
  if (date != none) {
    text(
      date.display(date-format),
      size: 11pt,
    )
    v(0.25 * page-grid)
  }

  v(8 * page-grid)

  // course of studies
  text(size: 10pt, authors.map(author => author.course-of-studies).dedup().join(" | "))
  v(0.25 * page-grid)


  if logo-bottom != none {
    place(
      bottom + center,
      dy: -1 * page-grid,
      box(logo-bottom, height: 3 * page-grid),
    )
  }
}
