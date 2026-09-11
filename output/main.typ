// =====================================================================
// main.typ — сборка отчёта по индивидуальной теме
// «Анализ сверточных нейронных сетей и областей их практического
//  применения» (раздел 1 итогового отчёта по учебной практике)
//
// Компиляция:  typst compile --root . output/main.typ
// =====================================================================
#import "../templates/style.typ": *

#show: report-page
#show: setup-headings
#show: report-text
#show: setup-lists

// =====================================================================
// ТИТУЛЬНЫЕ ЛИСТЫ (скан) — полностраничные, без нумерации страниц
// =====================================================================
#set page(margin: 0pt, numbering: none)
#for p in range(1, 5) {
  if p > 1 { pagebreak() }
  place(top + left)[
    #image("../docs/Scanned_20260911_111411.pdf", page: p, width: 100%, height: 100%)
  ]
}
#counter(page).update(0)
#pagebreak()
#set page(
  margin: (left: 30mm, right: 10mm, top: 20mm, bottom: 20mm),
  numbering: "1",
  number-align: center,
)

// =====================================================================
// СОДЕРЖАНИЕ: заголовок — прописными, по центру, полужирный
// =====================================================================
#align(center)[
  #set text(font: font-main, size: 18pt, weight: "bold")
  СОДЕРЖАНИЕ
]
#v(12pt)
#outline(depth: 3, indent: auto, title: none)
#pagebreak(weak: true)

#include "../sections/01_vvedenie.typ"
#include "../sections/02_section1_postanovka.typ"
#include "../sections/03_section1_arhitektury.typ"
#include "../sections/04_section1_primenenie.typ"
#include "../sections/05_section1_sravnenie_trendy.typ"
#include "../sections/06_section1_vyvody.typ"
#include "../sections/09_section2_praktika.typ"
#include "../sections/07_zaklyuchenie.typ"
#include "../sections/08_spisok_istochnikov.typ"