---
name: lesson-planning
description: >-
  Author complete, build-ready lessons for the Linear Algebra & Mathematical Modeling
  LaTeX curriculum (a project with a shared/ style package — prefix linalg — and a
  Makefile hierarchy that compiles components with latexmk and merges them with pdfunite).
  Use this whenever the user wants to create, draft, or build a lesson, a lesson plan, a
  unit, or any lesson component — warm-up, guided notes, activity, exit ticket, homework,
  cover sheet, or their answer keys. The course is defined by spec/course_structure.md
  (four themes, ten units, each with an essential question and a topic list); decompose
  units into lessons from it. Trigger this even when the user just says "make lesson 2.3"
  or "I need a warm-up and key for tomorrow," and even if they don't say "skill" or "LaTeX."
---

# Lesson Planning — Linear Algebra & Mathematical Modeling

This skill authors lessons for the **Linear Algebra & Mathematical Modeling** course and
produces print-ready PDFs through the project's own build system. **It builds around the
project's conventions — it does not invent its own.** The course is *not* a procedural
linear-algebra course; it is a conceptual, modeling-and-communication course for a
**secondary-school** audience (see `spec/course_structure.md`). Author every component in
that spirit: emphasize representation, interpretation, justification, and modeling over
symbol-pushing.

## The course at a glance

- **Structure** comes from `spec/course_structure.md` — the philosophy, the **four themes**
  (Representation, Transformation, Prediction, Communication), and the **ten units**, each
  with an Essential Question and a list of topics + applications. This is the unit/lesson map.
- **Content** comes from the two **MIT OpenCourseWare mirrors in `spec/`**: **18.06 Linear
  Algebra** (the spine — Strang) and **18.02 Multivariable Calculus** (vectors, dot product,
  determinants, geometry). Each lesson's mathematics, examples, and exercises are sourced
  from the matching OCW lecture / reading / problem set — see `references/course-workflow.md`.
- **Audience is secondary school.** Both OCW courses are *undergraduate*; always down-level:
  concrete numbers and geometry first, formalism later, applications up front, heavy
  scaffolding. Never paste undergraduate problems verbatim — rewrite to level and voice.
- **Style prefix is `linalg`** — `shared/linalg-{colors,article,boxes,key}.sty`. A teacher
  **slide deck** (`slides`) is also supported once `shared/linalg-beamer.sty` is in place; if
  you copy that theme in from another course, fix its internal `apcalc-*` package references
  to `linalg-*` first (same renaming the other styles needed).

## What a lesson is

A lesson lives in `unitXX/lessonYY/` and consists of:

- **`main.tex`** — the teacher-facing **lesson plan** (the root document of the lesson dir).
- A set of **student components**, each its own subdirectory containing **either** a
  `main.tex` (authored, compiled to a PDF) **or** a `main.pdf` (a prefab PDF, used as-is):
  `cover`, `warmup`, `notes`, `activity`, `exit_ticket`, `homework`, and optional `slides`.
- An **answer key** for each keyed component, as a *separate* sibling directory:
  `warmup_key`, `notes_key`, `activity_key`, `exit_ticket_key`, `homework_key`.
  (`cover` has no key.)

`shared/lesson.mk` discovers a component if it has a `main.tex` **or** a `main.pdf`,
compiles the `main.tex` ones with `latexmk -xelatex`, and merges all of them with
`pdfunite` in pedagogical order into `lessonYY_student.pdf` (cover + blank components) and
`lessonYY_full.pdf` (cover + keyed versions, plus the lesson plan and slides). A prefab `main.pdf` is
fed straight to `pdfunite` from the source tree with no compile step (Step 4).

## Workflow

Follow these steps in order. Read the referenced files as you reach each step rather than
all upfront.

### Step 0 — Detect project context (always do this first)

1. **Confirm the prefix.** `ls shared/*-colors.sty` → it is `linalg`. All
   `\usepackage{linalg-article}` etc. use it.
2. **Course macros live in `shared/`.** `linalg-article.sty` defines `\CourseName`,
   `\SchoolYear`, `\MeetingLength`, so a lesson plan defines only `\UnitNumberName` and
   `\LessonNumberName` (the scaffolder handles this).
3. **Find the insertion point.** List `unit*/lesson*` to find the next unit/lesson number
   and whether the target lesson already exists.
4. **Find a model lesson — or recognize there isn't one yet.** If a built lesson already
   exists, open it and mirror its preamble, box usage, and tone. **This is a greenfield
   course**: if no lesson exists yet, `references/conventions.md` and
   `references/components.md` are your reference, and the *first* lesson you author becomes
   the model for the rest — build and proofread it carefully before scaling out.

### Step 1 — Map the unit into lessons, then gather the lesson's content

The content path is always `references/course-workflow.md`:

- **Decompose the unit into lessons** from `spec/course_structure.md`. The convention is
  **one lesson per topic bullet**, in listed order (Lesson `<unit>.<n>`). Present the
  proposed lesson map for the unit and **confirm it with the user before authoring** —
  topics occasionally merge or split.
- **Gather the lesson's content**: the unit's Essential Question and governing theme, the
  specific topic, the relevant applications (these drive activity/homework contexts and
  modeling tasks), and the **matching OCW lecture / reading / problem set** (18.06 first,
  18.02 for vectors/geometry/determinants) — then **down-level it for secondary students**.

See `references/course-workflow.md` for the decomposition rules and the content-mapping
table. Unit 10 is a **capstone modeling project**, not ordinary lessons — it gets special
handling (also in `course-workflow.md`).

### Step 2 — Scaffold the lesson directory

Run the scaffold script. It creates the lesson directory, the one-line lesson `Makefile`,
the component subdirectories you request, **and (if missing) the root `Makefile` and the
unit `Makefile`** so the unit/curriculum builds work:

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/new_lesson.py --project . --unit 01 --lesson 03 \
  --title "Dot Product" --unit-title "Vectors as Data" \
  --components cover,warmup,notes,activity,exit_ticket,homework
```

The script is bundled with the skill, so it is invoked via `${CLAUDE_SKILL_DIR}` (the
working directory at runtime is the user's project, not the skill folder); `--project .`
is the project root. It auto-detects the prefix and writes each authored component's
`main.tex` as a correctly-preambled skeleton (and the matching `_key` skeleton for keyed
components). Pass `--prefab warmup` to create that component as an empty drop-in directory
instead (Step 4). Add `slides` to the component list to scaffold a Beamer deck — the
scaffolder requires `shared/linalg-beamer.sty` to exist and errors clearly if it doesn't.
Then fill in the skeletons.

### Step 3 — Author the lesson plan and components

Author each file following `references/components.md`, which gives the required section
structure and a worked skeleton for every component and its key. Hold to these invariants:

- **Student components** preamble with `\documentclass[10pt]{article}` +
  `\usepackage{linalg-article}` + `\usepackage{linalg-boxes}`.
- **Answer keys** are *separate files* that swap `-boxes` for `\usepackage{linalg-key}`
  and wrap every answer in `\ans{...}` (inline) or `\ansline{...}` (fills a write-line).
  Mirror the blank document exactly, then fill the blanks with `\ans`. Use `teachernote`
  for teacher-only guidance. There is **no** answer-key toggle — never try to build one.
- Use the project's box vocabulary (`skillbox`, `objectivebox`, `learningtargetbox`,
  `vocabbox`, `hookbox`, `notesbox`, `practicebox`, `scenariobox`, `tocbox`, etc.) and
  fill-in helpers (`\blank`, `\writeline`, `\termblanklong`, `\namedateperiod`) rather than
  reinventing layout. The full catalog is in `references/conventions.md`.
- **Match the course pedagogy.** Favor interpretation, justification, and modeling prompts
  over rote computation; lean on the unit's applications for context. Never ask students to
  "sketch/draw/construct" a graph from scratch — give a pre-drawn figure to read, a table to
  complete, or a computation/interpretation question instead.
- If the warm-up is a **prefab** PDF (`warmup/main.pdf` in the source tree), the lesson plan
  may embed its thumbnail via `\includegraphics[page=1]{warmup/main}`. **Authored** warm-ups
  compile to `target/` and have no source PDF to embed, so keep the spiral review text-only;
  the scaffolder picks the right form automatically.

### Step 4 — Handle prefab components

When the user supplies a ready-made PDF for a component, just drop it in — no wrapper needed:

1. Place the PDF as `<comp>/main.pdf` (e.g. `warmup/main.pdf`).
2. If the key is also a prefab PDF, place it as `<comp>_key/main.pdf`.

`shared/lesson.mk` discovers the component by its `main.pdf` and feeds it straight to
`pdfunite`, skipping compilation. Use `--prefab <comp>` when scaffolding to create the empty
drop-in directory.

### Step 5 — Build

Build from the lesson directory (or the unit/root for wider packets):

```bash
make -C unit01/lesson03 student   # cover + blank student components → lessonYY_student.pdf
make -C unit01/lesson03 full      # lesson plan + keyed versions      → lessonYY_full.pdf
make -C unit01/lesson03 all       # both
```

`make -C unit01 student|full` merges a unit; `make student|full` at the root merges the
whole curriculum. Output lands in `target/`. The build needs XeLaTeX, `latexmk`, and
`pdfunite`; if a compile fails, surface the `.log` and fix the offending `.tex` rather than
editing the build system. Details and troubleshooting in `references/build.md`.

## Reference files

- `references/conventions.md` — the style packages, every box environment, the fill-in and
  answer-key macros, color palette, and per-document-type preambles. Read before authoring.
- `references/components.md` — section-by-section spec and a skeleton for the lesson plan and
  each component + key.
- `references/course-workflow.md` — decomposing `spec/course_structure.md` into units and
  lessons, the four themes, the content-mapping table, and the Unit 10 capstone.
- `references/build.md` — the Makefile hierarchy, scaffolding, prefab PDFs, build commands,
  and troubleshooting.

## Guardrails

- Structure comes from `spec/course_structure.md`; content comes from the 18.06/18.02 OCW
  mirrors in `spec/`. Don't invent mathematics — source it, then adapt.
- Audience is secondary school: down-level the undergraduate OCW material every time
  (concrete first, applications up front, no verbatim college problem sets).
- Greenfield: there may be no existing lesson to mirror; lean on the reference docs and make
  the first lesson a clean model.
- Keep blank and key documents in lockstep — the key is the blank with answers filled in.
- This is a modeling/communication course: interpretation and justification over procedure;
  no "sketch from scratch" questions.
- Don't modify `shared/` or the Makefiles to make a lesson build; fix the lesson's `.tex`.
