---
name: lesson-planning
description: >-
  Author complete, build-ready lessons for the Linear Algebra LaTeX curriculum (a project
  with a shared/ style package — prefix linalg — and a Makefile hierarchy that compiles
  components with latexmk and merges them with pdfunite).
  Use this whenever the user wants to create, draft, or build a lesson, a lesson plan, a
  unit, or any lesson component — warm-up, guided notes, activity, exit ticket, homework,
  cover sheet, or their answer keys. The course is defined by spec/linear_algebra_v2.md, whose
  course map mirrors Strang's Linear Algebra for Everyone: eight units are its eight chapters
  and each lesson is a subchapter; decompose units into lessons from it. Trigger this even
  when the user just says "make lesson 2.3" or "I need a warm-up and key for tomorrow," and
  even if they don't say "skill" or "LaTeX."
---

# Lesson Planning — Linear Algebra

This skill authors lessons for the **Linear Algebra** course and produces print-ready PDFs
through the project's own build system. **It builds around the project's conventions — it
does not invent its own.** The course is a conceptual, **geometry-first** linear-algebra
course for a **secondary-school** audience (see `spec/linear_algebra_v2.md`). Author every
component in that spirit: emphasize geometric intuition, interpretation, and justification
over symbol-pushing, and treat applications as **guided illustration — not** open-ended
modeling.

## The course at a glance

- **Structure** comes from `spec/linear_algebra_v2.md` — the guiding philosophy and a **course
  map that mirrors the primary text's table of contents**: **eight units are the eight chapters
  of Strang's *Linear Algebra for Everyone*, and each lesson is a subchapter (section)**. The
  core sequence is Units 1–6; Units 7–8 and §6.4 are optional/advanced. This is the
  unit/lesson map.
- **Content** comes **entirely from the primary text, Gilbert Strang's _Linear Algebra for
  Everyone_** (units = chapters, lessons = subchapters) — **no supplementary materials**. Every
  lesson's mathematics, examples, and exercises are sourced from the matching subchapter. See
  `references/course-workflow.md`.
- **Audience is secondary school.** The book is college-level; always down-level: concrete
  numbers and geometry first, formalism later, applications up front, heavy scaffolding. Never
  paste a college-level problem verbatim — rewrite to level and voice.
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

## What a unit is

A unit (`unitXX/`) holds its lessons plus **unit-level summative assessments**, scaffolded
automatically when the unit is first created (Step 2):

- **`tests/`** — the blank tests, one subdir each: **`practice_test/`** (a study copy students
  keep) and **`actual_test/`** (the real test given in a testing setting). Its `Makefile`
  (`include ../../shared/tests.mk`) compiles both and its `drop` target publishes the
  *practice* test to `sample_test/main.pdf`.
- **`test_keys/`** — the matching answer keys: **`practice_test_key/`** and
  **`actual_test_key/`**; its `drop` publishes the *practice* test key to `sample_test_key/main.pdf`.
- **`sample_test/`** and **`sample_test_key/`** — prefab drop-in dirs that receive those
  published PDFs. `shared/unit.mk` merges `sample_test` into **both** the unit student and full
  packets, and `sample_test_key` into the **full** packet only. The **actual** test and its key
  are never merged into any packet — they stay out of student hands.

So the practice test is what students study from (in the packet); the actual test is authored
alongside it, shares the format, but is distributed separately at test time.

## Workflow

Follow these steps in order. Read the referenced files as you reach each step rather than
all upfront.

### Step 0 — Sync with upstream, then detect project context (always do this first)

**Sync the worktree first — before reading or writing anything.** This skill runs in a git
worktree; start *every* invocation by pulling the latest upstream changes so you author
against the current shared styles, spec, and lesson map. Do this automatically — the user
should never have to ask:

```bash
git fetch origin
# Integrate the latest default branch (usually main) into this worktree's branch:
DEFAULT=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
git merge --no-edit "origin/${DEFAULT:-main}"
```

If the working tree is dirty or the merge reports conflicts, **stop and surface it to the
user** — never force, reset, or discard changes to make the sync succeed. Once the sync is
clean, detect project context:

1. **Read the planning log.** Open `spec/course_planning.md` (the running handoff log) for the
   current build state and the next steps left by the previous run. It orients the whole
   session; you update it at the end (Step 6). If it does not exist yet, this is the first run.
2. **Confirm the prefix.** `ls shared/*-colors.sty` → it is `linalg`. All
   `\usepackage{linalg-article}` etc. use it.
3. **Course macros live in `shared/`.** `linalg-article.sty` defines `\CourseName`,
   `\SchoolYear`, `\MeetingLength`, so a lesson plan defines only `\UnitNumberName` and
   `\LessonNumberName` (the scaffolder handles this).
4. **Find the insertion point.** List `unit*/lesson*` to find the next unit/lesson number
   and whether the target lesson already exists.
5. **Find a model lesson — or recognize there isn't one yet.** If a built lesson already
   exists, open it and mirror its preamble, box usage, and tone. **This is a greenfield
   course**: if no lesson exists yet, `references/conventions.md` and
   `references/components.md` are your reference, and the *first* lesson you author becomes
   the model for the rest — build and proofread it carefully before scaling out.

### Step 1 — Map the unit into lessons, then gather the lesson's content

The content path is always `references/course-workflow.md`:

- **Decompose the unit into lessons** from `spec/linear_algebra_v2.md`. The convention is
  **one lesson per topic bullet / subchapter**, in listed order (Lesson `<unit>.<n>`).
  Present the proposed lesson map for the unit and **confirm it with the user before
  authoring** — topics occasionally merge or split.
- **Gather the lesson's content**: the specific topic, the unit's relevant applications
  (these drive activity/homework contexts), and the **matching _Linear Algebra for Everyone_
  subchapter** (the sole source for the math, examples, and exercises) — then **down-level it
  for secondary students**.

See `references/course-workflow.md` for the decomposition rules and the content-mapping
table. The optional Discrete Systems (Markov) unit is an ordinary unit of lessons — it gets
no special-case handling.

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

**Unit assessments scaffold automatically.** When the run creates a *new* unit, the scaffolder
also lays down that unit's `tests/`, `test_keys/`, `sample_test/`, and `sample_test_key/` dirs
(practice + actual test skeletons and their keys, plus thin-include Makefiles) — see
"What a unit is." It never clobbers authored tests on later lessons. Use `--no-tests` to skip
them, or `--tests` to (re)scaffold them for a unit that already exists (idempotent).

### Step 3 — Author the lesson plan and components

**Before writing any component, do a full `Read` on each scaffolded `main.tex` skeleton you
are about to replace.** Use the `Read` tool on the actual file — a `cat`/`bash` dump does
**not** register the file with the editor and the first write will fail ("file has not been
read yet"). Read every skeleton you intend to author (each component and its `_key`) up front,
then write them. This is mandatory, not optional.

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
- **Match the course pedagogy.** Favor geometric intuition, interpretation, and justification
  over rote computation; lean on the unit's guided applications for context. Never ask students to
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

### Step 6 — Update the course planning log (always do this last)

**Before you finish, record progress in `spec/course_planning.md`.** This is the running
handoff log that lets the next invocation — often in a fresh worktree after the Step 0 sync —
pick up exactly where this one left off. Do this at the **end of every execution of this
skill**, even a partial one; the user should never have to ask.

Update the file to reflect reality *now*:

- **Last updated** — today's date (absolute), and a one-line summary of what this run did.
- **Current state** — the unit/lesson build status: which units/lessons are scaffolded, which
  components are authored vs. still skeleton vs. built, and any confirmed lesson maps. Keep the
  per-unit progress table in sync with what actually exists on disk.
- **Next steps** — the concrete next actions (e.g. "author Unit 1 Lesson 1.2 notes + key",
  "confirm the Unit 2 lesson map with the user"), plus any open questions or decisions pending
  from the user.

Keep it terse and current — overwrite stale entries rather than appending a changelog. If the
file does not exist yet, create it with these sections. Since it lives in `spec/`, it is
tracked and travels with the branch, so the Step 0 sync always brings the latest state forward.

## Reference files

- `references/conventions.md` — the style packages, every box environment, the fill-in and
  answer-key macros, color palette, and per-document-type preambles. Read before authoring.
- `references/components.md` — section-by-section spec and a skeleton for the lesson plan and
  each component + key.
- `references/course-workflow.md` — decomposing `spec/linear_algebra_v2.md` into units and
  lessons, the unit map, the content-mapping table, and the optional Discrete Systems unit.
- `references/build.md` — the Makefile hierarchy, scaffolding, prefab PDFs, build commands,
  and troubleshooting.

## Guardrails

- **Bookend every run with the planning log:** read `spec/course_planning.md` at the start
  (Step 0) and update its current-state + next-steps at the end (Step 6). Never skip the
  end-of-run update, even for a partial run.
- **Full `Read` each skeleton before writing it** (Step 3). A `bash`/`cat` dump does not
  register the file with the editor, so the write fails; always use the `Read` tool first.
- Structure comes from `spec/linear_algebra_v2.md`; content comes **only** from Strang's
  *Linear Algebra for Everyone* — no supplementary materials. Don't invent mathematics —
  source it from the book, then adapt.
- Audience is secondary school: down-level the college-level text every time (concrete first,
  applications up front, no verbatim college problems).
- Greenfield: there may be no existing lesson to mirror; lean on the reference docs and make
  the first lesson a clean model.
- Keep blank and key documents in lockstep — the key is the blank with answers filled in.
- This is a conceptual, geometry-first course: interpretation and justification over
  procedure; applications are guided illustration, not open-ended modeling; no "sketch from
  scratch" questions.
- Don't modify `shared/` or the Makefiles to make a lesson build; fix the lesson's `.tex`.
