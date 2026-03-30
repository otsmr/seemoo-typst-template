#let title-back(
  authors,
  title,
  date,
  date-format,
  pdf-version,
  language,
  many-authors,
) = {
  // ---------- Page Setup ---------------------------------------

  set page(
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )

  // ---------- Info at Bottom of Page ---------------------------------------

  place(
    bottom + left,
    {
      for author in authors {
        text(size: 11pt, [#author.name: #title, © #date.display(date-format)])
        linebreak()
      }
      v(1em)
      text(size: 9pt, fill: luma(100), [Version: #pdf-version])
    },
  )
  // ---------- Info-Block ---------------------------------------

  // set text(size: 11pt)
  // place(
  //   bottom + center,
  //   grid(
  //     columns: (auto, auto),
  //     row-gutter: 1em,
  //     column-gutter: 1em,
  //     align: (right, left),

  //     // submission date
  //     text(weight: "bold", fill: luma(80), TITLEPAGE_DATE.at(language)),
  //     text(
  //       if (type(date) == datetime) {
  //         date.display(date-format)
  //       } else {
  //         date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
  //       },
  //     ),

  //     // students
  //     align(text(weight: "bold", fill: luma(80), TITLEPAGE_STUDENT_ID_AND_COURSE.at(language)), top),
  //     stack(
  //       dir: ttb,
  //       for author in authors {
  //         text([#author.student-id, #author.course])
  //         linebreak()
  //       },
  //     ),

  //     // company
  //     ..if (not at-university) {
  //       (
  //         align(text(weight: "bold", fill: luma(80), TITLEPAGE_COMPANY.at(language)), top),
  //         stack(
  //           dir: ttb,
  //           for author in authors {
  //             let company-address = ""

  //             // company name
  //             if (
  //               "name" in author.company and author.company.name != none and author.company.name != ""
  //             ) {
  //               company-address += author.company.name
  //             } else {
  //               panic(
  //                 "Author '"
  //                   + author.name
  //                   + "' is missing a company name. Add the 'name' attribute to the company object.",
  //               )
  //             }

  //             // company address (optional)
  //             if (
  //               "post-code" in author.company and author.company.post-code != none and author.company.post-code != ""
  //             ) {
  //               company-address += text([, #author.company.post-code])
  //             }

  //             // company city
  //             if (
  //               "city" in author.company and author.company.city != none and author.company.city != ""
  //             ) {
  //               company-address += text([, #author.company.city])
  //             } else {
  //               panic(
  //                 "Author '"
  //                   + author.name
  //                   + "' is missing the city of the company. Add the 'city' attribute to the company object.",
  //               )
  //             }

  //             // company country (optional)
  //             if (
  //               "country" in author.company and author.company.country != none and author.company.country != ""
  //             ) {
  //               company-address += text([, #author.company.country])
  //             }

  //             company-address
  //             linebreak()
  //           },
  //         ),
  //       )
  //     },
  //     // university supervisor
  //     ..if ("ref" in supervisor) {
  //       (
  //         text(
  //           weight: "bold",
  //           fill: luma(80),
  //           TITLEPAGE_SUPERVISOR_REF.at(language) + [:],
  //         ),
  //         if (type(supervisor.ref) == str) { text(supervisor.ref) },
  //       )
  //     },
  //     ..if ("co-ref" in supervisor) {
  //       (
  //         text(
  //           weight: "bold",
  //           fill: luma(80),
  //           TITLEPAGE_SUPERVISOR_COREF.at(language) + [:],
  //         ),
  //         if (type(supervisor.co-ref) == str) { text(supervisor.co-ref) },
  //       )
  //     },
  //   ),
  // )
}
