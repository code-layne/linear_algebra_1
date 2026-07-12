# Components

The spec for authoring each file after scaffolding. The scaffolder (`scripts/new_lesson.py`)
gives you a correctly-preambled skeleton with TODO markers; this file says what fills them.
Once one lesson is built, **also open it as the gold reference** — this is a greenfield
course, so the first lesson you build becomes the model for the rest. For macros and boxes
see `references/conventions.md`; for where content comes from, `references/course-workflow.md`.

Contents: [Lesson plan](#lesson-plan) · [Cover](#cover) · [Warm-up](#warm-up) ·
[Guided notes](#guided-notes) · [Activity](#activity) · [Exit ticket](#exit-ticket) ·
[Homework](#homework) · [Slides](#slides) · [Answer-key discipline](#answer-key-discipline)

General rules:
- Student components preamble with `linalg-article` + `linalg-boxes`; keys with
  `linalg-article` + `linalg-key`.
- Keep the **key structurally identical** to its blank — it is the blank with answers filled in.
- **Secondary-school audience.** Source the math from the matching OCW lecture/reading, then
  down-level it: concrete numbers and geometry first, formalism later, applications up front.
- Every component runs the loop **compute → interpret → justify** ("what does this mean here,
  and how do you know?"). Never ask students to *sketch/draw/construct* a graph from scratch —
  give a pre-drawn figure to read, a table to complete, or a computation/interpretation task.
- Use the project's boxes and fill-in macros rather than hand-rolling layout.

## Lesson plan

`main.tex` at the lesson root — teacher-facing, never handed to students. Canonical section
order:

1. **Title block** — `\CourseName: \SchoolYear` + `\UnitNumberName \LessonNumberName`.
2. **Primary Objective** — a `tcolorbox` (sky/navy). One or two sentences in student terms,
   ending with the governing course theme, e.g. `(Theme: Representation)`.
3. **Priority Ideas & Skills** — `skillbox{goldbox}`, two `minipage`s. Left: the priority
   ideas/skills for this topic. Right: "Key Understandings" — the *why*, in modeling terms.
4. **Vocabulary, Concepts & Theorems** — `skillbox{greenbox}`, a `tabularx` term/definition
   table (use `\TallMath{...}` for tall formulas/matrices).
5. **Activate Prior Knowledge & Spiral Review** — `fixedskillbox{sky}`; left lists the
   reviewed skills, right shows the warm-up thumbnail via `\includegraphics[page=1]{warmup/main}`
   **only if the warm-up is a prefab PDF** (authored warm-ups stay text-only).
6. **Hook** — `skillbox{sky}`: an entry question/scenario built from the unit's applications.
7. **Lesson** (and optional **Lesson (cont.)**) — `skillbox{sky}` with `\begin{multicols}{2}`;
   the worked instructional progression, bolding the questions you'll pose. Geometry/numbers
   first, then the general statement.
8. **Explicit Instruction: <technique>** — one `skillbox{sky}` per technique, two columns:
   numbered steps on the left, a worked example (often a Desmos/GeoGebra screenshot for
   transformation work) on the right.
9. **Active Monitoring** — `skillbox{redbox}`: what to circulate and check; cold-call prompts.
10. **Group Work & Differentiation** — `skillbox{redbox}`: a `multicols{3}` with **Tier R —
    Remediate / Tier A — Approaching Proficiency / Tier E — Extension** bullet lists that
    mirror the activity tiers.
11. **Individual Work & Assessment** — `skillbox{redbox}`: exit-ticket items + a short
    **conceptual/justification check** (interpret-a-result item), with a note on collecting
    and using results.
12. **Reinforcement & Extension** — `skillbox{goldbox}`: homework overview, an extension, and a
    preview of the next lesson.

## Cover

`cover/main.tex` — student-facing front page of the packet. No key. Structure:
- Full-bleed navy banner (tikz) with `\LARGE` course name, unit, and `Lesson <id>  <title>`.
- `\namedateperiod`.
- `learningtargetbox` — an "I can…" list, one target per priority idea/skill.
- `tocbox` — a `tabularx` listing each packet component (#, Component, Description, Score blank)
  with a Total row. Keep the rows aligned with the components you actually scaffolded.
- Optionally mirror the lesson plan's Priority Ideas & Vocabulary for student reference.

## Warm-up

`warmup/` (+ `warmup_key/`) — short spiral review of *prerequisite* skills (e.g. arithmetic,
prior lessons' vectors/matrices). Frequently a **prefab PDF**: if so, drop it in as
`warmup/main.pdf` (and `warmup_key/main.pdf`) — `lesson.mk` merges it directly and the lesson
plan can embed its thumbnail. If authored: 3–5 quick problems with work space (`\vspace`),
`\namedateperiod`, and the spiral review stays text-only in the plan. Key mirrors with `\ans`.

## Guided notes

`notes/` (+ `notes_key/`) — the student's fill-in notes. Structure:
- `\pageheader{Unit X, Lesson Y.Z}{Guided Notes}` + `\namedateperiod`.
- `objectivebox` — "By the end of this lesson, I will be able to…" with `\writeline`s for
  students to fill (the key uses `\ansline{...}`, one per priority idea/skill).
- `vocabbox` — `\termblanklong{Term}` per key term (key replaces each with `\ans{definition}`).
- `hookbox` — the same hook as the plan, with write-lines for student responses.
- Direct-instruction sections in `notesbox{Title}` with blanks (`\blank`, `\writeline`) at the
  points where students record steps/definitions/results. Build the worked example from the
  OCW lecture, down-leveled.
- Optional `practicebox` ("Guided Practice") with 1–2 worked-with-class problems.

## Activity

`activity/` (+ `activity_key/`) — differentiated group practice, ideally a small **modeling
investigation** drawn from the unit's applications.
- `\pageheader{Unit X, Lesson Y.Z}{Group Activity}` + `\namepartnerperiod`.
- Three `tcolorbox`es titled **Tier R — Remediate**, **Tier A — Approaching Proficiency**,
  **Tier E — Extension** (`colframe=black!40`), each with problems and generous `\vspace` work
  room. Tiers escalate in difficulty and align to the same skills; the top tier should reach an
  interpret/justify/critique-the-model task.
- Key mirrors exactly, filling answers with `\ans{...}` and marking correct MC options with
  `\textcolor{keyred}{\textbf{$\leftarrow$ correct}}`, plus brief worked steps.

## Exit ticket

`exit_ticket/` (+ `exit_ticket_key/`) — a short independent check (2–3 items), no notes.
`\pageheader{...}{Exit Ticket}` + `\namedateperiod`; a tight `enumerate` with a little work
space. Include at least one "what does this result mean?" item. Key fills with `\ans`.

## Homework

`homework/` (+ `homework_key/`) — independent practice + stretch.
`\pageheader{...}{Homework}` + `\namedateperiod`; a numbered practice set (problems sourced
from the OCW problem set, rewritten to level), an `extensionbox` ("Extension — optional"), and
a short preview of the next lesson. Key fills with `\ans` and shows worked steps for the
harder items.

## Slides

`slides/` — optional teacher Beamer deck. No key. Requires `shared/linalg-beamer.sty`.
Preamble: `\documentclass[aspectratio=169,11pt]{beamer}` + `\usepackage{linalg-beamer}`.
The title slide is hand-built (navy background canvas + minipage); content slides use
`\navyheader{Title}` and `\sectionlabel[color]{LABEL}`. Note `\CourseName` is **not** defined
in beamer — write the course name literally. Mirror the existing `slides/main.tex` closely;
the beamer theme is bespoke. Keep slides aligned to the lesson's instructional progression and
down-leveled for the secondary-school audience.

## Answer-key discipline

There is no key toggle — every key is a separate file under `<comp>_key/`:
- Copy the blank component **verbatim**, then swap `\usepackage{linalg-boxes}` for
  `\usepackage{linalg-key}`.
- Replace each blank/write-line with `\ans{answer}` (inline) or `\ansline{answer}` (fills a
  write-line). Title becomes "<DocTitle> — Answer Key".
- For multiple choice, keep all options and tag the correct one
  (`\textcolor{keyred}{\textbf{$\leftarrow$ correct}}`), then show the reasoning in a short
  `itemize`.
- `\ans` is text-mode: never put it inside `$...$` — wrap math fragments instead
  (`\ans{$\hat v$}`) — and never let it span a blank line.
- Use the `teachernote` environment for teacher-only guidance (pacing, common errors).
- Because the key matches the blank line-for-line, the two paginate identically — verify by
  building both and comparing.
