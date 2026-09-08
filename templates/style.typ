// =====================================================================
// style.typ — параметры оформления отчёта по правилам вуза
// (см. «ПРАВИЛА ОФОРМЛЕНИЯ КУРСОВОЙ РАБОТЫ (ПРОЕКТА), ВКР…» и
//  «Структура итогового отчёта по учебной (аналитической) практике»)
//
// ВАЖНО про шрифт: Times New Roman не входит в состав свободных
// шрифтов, доступных в окружении сборки. Используется метрически
// совместимая замена — Liberation Serif. При открытии проекта на
// компьютере с Times New Roman достаточно поменять значение
// font-main ниже — вёрстка не изменится (шрифты метрически совместимы).
// =====================================================================

#let font-main = "Liberation Serif"   // замена Times New Roman
#let font-mono = "Liberation Mono"    // замена Courier New

// ---- состояние для сквозной нумерации таблиц/рисунков/листингов ----
// нумерация вида "N.M", где N — номер раздела (Заголовка 1 уровня),
// M — порядковый номер внутри раздела (обнуляется в начале раздела)
#let sec-num = state("sec-num", 0)
#let tab-num = state("tab-num", 0)
#let fig-num = state("fig-num", 0)
#let lst-num = state("lst-num", 0)

// =====================================================================
// НАСТРОЙКА СТРАНИЦЫ
// правое — 10 мм, верхнее/нижнее — 20 мм, левое — 30 мм
// нумерация страниц — по центру внизу, сквозная, арабскими цифрами
// =====================================================================
#let report-page(body) = {
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 10mm, top: 20mm, bottom: 20mm),
    numbering: "1",
    number-align: center,
  )
  body
}

// =====================================================================
// ОСНОВНОЙ ТЕКСТ
// TNR 14 пт, обычный, по ширине, отступ первой строки 1,25 см,
// межстрочный — полуторный, интервалы до/после — 0, запрет висящих строк,
// перенос слов запрещён
// =====================================================================
#let report-text(body) = {
  set text(font: font-main, size: 14pt, lang: "ru")
  set par(
    justify: true,
    first-line-indent: 1.25cm,
    leading: 1.0em,           // подобранный интервал ≈ полуторный для 14pt
    spacing: 1.0em,
  )
  set par.line(numbering: none)
  // запрет переноса слов
  set text(hyphenate: false)
  body
}

// =====================================================================
// ЗАГОЛОВКИ
// Уровень 1 (разделы) — 18 пт, полужирный, ПРОПИСНЫЕ; начинаются с новой
//   страницы; ненумерованные разделы (ВВЕДЕНИЕ, ЗАКЛЮЧЕНИЕ, СПИСОК…) —
//   по центру; нумерованные — по ширине (фактически по левому краю из-за
//   коротких заголовков), с сохранением связи со следующим абзацем.
// Уровень 2 (подразделы) — 16 пт, полужирный, с обычным регистром.
// Уровень 3 (пункты) — 14 пт, полужирный.
// =====================================================================
#let setup-headings(doc) = {
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    // сброс нумерации таблиц/рисунков/листингов в начале нового раздела
    if it.numbering != none {
      sec-num.update(n => n + 1)
      tab-num.update(0)
      fig-num.update(0)
      lst-num.update(0)
    }
    pagebreak(weak: true)
    set text(font: font-main, size: 18pt, weight: "bold")
    set par(first-line-indent: 0pt, justify: true)
    set block(above: 0pt, below: 12pt, sticky: true)
    let body-upper = upper(it.body)
    if it.numbering != none {
      context {
        let num = counter(heading).display("1")
        align(left)[#num #body-upper]
      }
    } else {
      align(center)[#body-upper]
    }
  }

  show heading.where(level: 2): it => {
    set text(font: font-main, size: 16pt, weight: "bold")
    set par(first-line-indent: 1.25cm, justify: true)
    set block(above: 24pt, below: 12pt, sticky: true)
    context {
      let num = counter(heading).display("1.1")
      align(left)[#num #it.body]
    }
  }

  show heading.where(level: 3): it => {
    set text(font: font-main, size: 14pt, weight: "bold")
    set par(first-line-indent: 1.25cm, justify: true)
    set block(above: 24pt, below: 12pt, sticky: true)
    context {
      let num = counter(heading).display("1.1.1")
      align(left)[#num #it.body]
    }
  }

  doc
}

// Обычный (нумеруемый) заголовок раздела/подраздела/пункта
#let h1(body) = heading(level: 1, body)
#let h2(body) = heading(level: 2, body)
#let h3(body) = heading(level: 3, body)
// Ненумерованный заголовок первого уровня (ВВЕДЕНИЕ, ЗАКЛЮЧЕНИЕ и т.п.)
#let h1n(body) = heading(level: 1, numbering: none, body)

// =====================================================================
// ТАБЛИЦЫ — подпись над таблицей, курсив 12 пт, автонумерация N.M
// =====================================================================
#let gost-table(caption-text, content) = {
  tab-num.update(n => n + 1)
  context {
    let s = sec-num.get()
    let t = tab-num.get()
    block(above: 12pt, below: 0pt, breakable: false)[
      #set text(font: font-main, size: 12pt, style: "italic", weight: "regular")
      #set par(first-line-indent: 0pt, justify: true)
      Таблица #s.#t --- #caption-text
    ]
  }
  v(2pt)
  set text(font: font-main, size: 12pt, hyphenate: true)
  content
  v(6pt)
}

// =====================================================================
// РИСУНКИ — подпись под рисунком, полужирный 12 пт по центру
// =====================================================================
#let gost-figure(content, caption-text) = {
  fig-num.update(n => n + 1)
  align(center)[#content]
  context {
    let s = sec-num.get()
    let f = fig-num.get()
    align(center)[
      #set text(font: font-main, size: 12pt, weight: "bold")
      Рисунок #s.#f --- #caption-text
    ]
  }
  v(6pt)
}

// =====================================================================
// ССЫЛКИ НА ИСТОЧНИКИ — [n] или [n1, n2, …]
// =====================================================================
#let cite-num(..nums) = {
  let arr = nums.pos().map(str)
  "[" + arr.join(", ") + "]"
}

// =====================================================================
// МАРКИРОВАННЫЕ / НУМЕРОВАННЫЕ СПИСКИ
// маркер на 1,25 см, текст на 2,25 см
// =====================================================================
#let setup-lists(doc) = {
  set list(indent: 1.25cm, body-indent: 1cm, marker: [--])
  set enum(indent: 1.25cm, body-indent: 1cm)
  doc
}
