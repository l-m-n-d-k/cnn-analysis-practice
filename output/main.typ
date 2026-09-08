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

#outline(title: [СОДЕРЖАНИЕ], depth: 3, indent: auto)
#pagebreak(weak: true)

#include "../sections/01_vvedenie.typ"
#include "../sections/02_section1_postanovka.typ"
#include "../sections/03_section1_arhitektury.typ"
#include "../sections/04_section1_primenenie.typ"
#include "../sections/05_section1_sravnenie_trendy.typ"
#include "../sections/06_section1_vyvody.typ"
#include "../sections/07_zaklyuchenie.typ"
#include "../sections/08_spisok_istochnikov.typ"