#import "../locale.typ": *

#let title-back(
  authors,
  title,
  date,
  date-format,
  pdf-version,
  language,
  supervisor,
  type-of-thesis,
) = {
  // ---------- Page Setup ---------------------------------------

  set page(
    margin: (top: 5cm, bottom: 5cm, left: 3cm, right: 3cm),
  )

  // ---------- Info at Bottom of Page ---------------------------------------

  let author = authors.first()

  place(
    bottom + left,
    {
      text(
        size: 11pt,
        [#author.name: #emph(title), #type-of-thesis, Technische Universität Darmstadt, #date.display("[year]")],
      )
      linebreak()
      v(1em)
      // ---------- Info-Block ---------------------------------------

      set text(size: 11pt)
      // place(
      // bottom + center,
      grid(
        columns: (auto, auto),
        row-gutter: 1em,
        column-gutter: 1em,
        // align: (right, left),

        // submission date
        text(TITLEPAGE_DATE.at(language)),
        text(
          if (type(date) == datetime) {
            date.display(date-format)
          } else {
            date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
          },
        ),

        // students

        // company
        // university supervisor
        ..if ("ref" in supervisor) {
          (
            text(
              TITLEPAGE_SUPERVISOR_REF.at(language) + [:],
            ),
            if (type(supervisor.ref) == str) { text(supervisor.ref) },
          )
        },
        ..if ("co-ref" in supervisor) {
          (
            text(
              TITLEPAGE_SUPERVISOR_COREF.at(language) + [:],
            ),
            if (type(supervisor.co-ref) == str) { text(supervisor.co-ref) },
          )
        },
        // ),
      )
      set par(hanging-indent: 0pt)

      for line in author.course-of-studies {
        text(size: 11pt, line)
        linebreak()
      }
    },
  )
}
