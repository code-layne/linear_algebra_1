# Build System

The project compiles with **XeLaTeX** (via `latexmk`) and merges PDFs with **`pdfunite`**
(poppler). The skill authors `.tex`; the project's own Makefiles do the building. **Never edit
`shared/` or the Makefiles to make a lesson build — fix the lesson's `.tex` instead.**

## The three-level Make hierarchy

Each level is a thin `Makefile` that includes a `shared/*.mk`. The scaffolder creates all
three as needed (see "Scaffolding a lesson"), so you rarely write them by hand:

- **Root `Makefile`** (`include shared/root.mk`) — discovers `unit*/Makefile`, delegates, and
  merges unit PDFs into `target/compiled/curriculum_{student,key}.pdf`.
- **`unitXX/Makefile`** (`include ../shared/unit.mk`) — discovers `lesson*/Makefile`,
  delegates, and merges lesson PDFs into `target/compiled/unitXX_{student,key}.pdf`.
- **`lessonYY/Makefile`** (`include ../../shared/lesson.mk`) — the engine. It:
  - **Discovers a component if it has `main.tex` or `main.pdf`.** Authored components
    (`main.tex`) are compiled; prefab components (`main.pdf`) are used as-is from the source
    tree. A directory with neither is skipped.
  - Compiles each `<comp>/main.tex` with
    `latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error`,
    sending output to `target/UNIT/LESSON/<comp>/` and a stamp to `.stamps/`.

## The five lesson work products

Every lesson builds five files into `target/compiled/unitXX/`:

| Product | What it is |
|---|---|
| `lessonYY_plan.pdf` | The teacher-facing lesson plan — the lesson-root `main.tex`, on its own. |
| `lessonYY_slides.pdf` | The Beamer deck **printed**: 3 slides per letter page, thumbnails down the left column and a ruled notes column beside each. |
| `lessonYY_slides.pptx` | The same deck wrapped for PowerPoint — one full-bleed page image per slide, the **projected** form. |
| `lessonYY_student.pdf` | `cover warmup notes activity exit_ticket homework` — the blank versions, in that pedagogical order. |
| `lessonYY_key.pdf` | The same packet with each component swapped for its `_key` (cover unchanged), in the same order. |

Three passes make those products more than a `pdfunite` concatenation:

- **`shared/handout.tex`** re-frames the compiled deck into the 3-up printable. The deck is the
  source of truth — never edit the handout or the PPTX, edit `slides/main.tex` and rebuild.
- **`shared/pdf2pptx.py`** wraps the raw deck (not the 3-up handout) as OOXML. It is
  dependency-free — poppler only, which the build already needs. `PPTX_DPI` (default 300)
  trades file size against projected sharpness.
- **`shared/paginate.tex`** rebuilds each merged packet so page numbers run across the whole
  lesson, every component starts on an **odd (recto)** page, and the **student and key packets
  are page-for-page identical**: each component gets the same slot — `max(blank, key)` pages
  rounded up to even — with the shorter one padded by blank versos. Page 7 of the key is
  page 7 of the student packet.

Since the two packets are laid out against each other, `student` and `key` both compile every
component of *both* before merging — they stay aligned whether built together or separately.

## Commands

```bash
make -C unitXX/lessonYY all       # all five products
make -C unitXX/lessonYY plan      # lessonYY_plan.pdf
make -C unitXX/lessonYY slides    # lessonYY_slides.pdf (3-up with notes column)
make -C unitXX/lessonYY pptx      # lessonYY_slides.pptx
make -C unitXX/lessonYY student   # lessonYY_student.pdf
make -C unitXX/lessonYY key       # lessonYY_key.pdf
make -C unitXX/lessonYY clean     # remove this lesson's target/ and stamps

make -C unitXX student|key        # merge a whole unit's packets
make student|key                  # merge the whole curriculum (from project root)
make clean | distclean            # clean everything (distclean also removes target/ and .stamps)
```

Only the two packets aggregate to unit and curriculum level; `plan`, `slides`, and `pptx` are
per-lesson teacher artifacts and stay in `target/compiled/unitXX/`.

Outputs land in `target/`: per-component PDFs under `target/UNIT/LESSON/<comp>/main.pdf`,
work products under `target/compiled/`.

If the lesson plan embeds a warm-up thumbnail, build `student` before `plan` (or just run
`make all`, which builds every product anyway). Authored warm-ups are text-only in the plan
(no thumbnail); prefab warm-ups embed `warmup/main` — the PDF in the source tree — which
resolves regardless of build order.

## Scaffolding a lesson

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/new_lesson.py --project . --unit 01 --lesson 06 \
  --title "Dot Product" --unit-title "Vectors as Data" \
  --components cover,warmup,notes,activity,exit_ticket,homework,slides \
  [--prefab warmup,warmup_key] [--lesson-id 1.6]
```

It detects the prefix (`linalg`) from `shared/*-colors.sty`. Because `\CourseName` is defined
in `shared/linalg-article.sty`, the generated lesson plan omits the course macros (so
`--course`/`--year` are unnecessary here). It writes the lesson `Makefile`, the lesson plan,
and each authored component + key skeleton — **and creates the root `Makefile` and the unit
`Makefile` if they don't already exist** (never clobbering them). Pass `--prefab <dirs>` to
create empty drop-in directories instead (where you place each `main.pdf`). `slides` is in the
default component list — every lesson ships a deck — and the scaffolder requires
`shared/linalg-beamer.sty` for it, erroring clearly if it is missing; drop `slides` from
`--components` for a lesson that genuinely has none. Then author the skeletons
(`references/components.md`).

## Prefab PDFs

To include a ready-made PDF as a component, drop it in as `<comp>/main.pdf` (and
`<comp>_key/main.pdf` for a prefab key). `lesson.mk` discovers it and feeds it straight to
`pdfunite` — no `main.tex`, no compile step. `make clean` removes only `target/` and stamps, so
your source PDFs are never deleted. (Requires the `lesson.mk` that discovers `main.pdf`; older
Makefiles that glob only `main.tex` will silently omit prefab-only components — update first.)

## Unit assessments (tests)

Each unit carries summative assessments alongside its lessons, scaffolded automatically when
the unit is created:

- **`unitXX/tests/`** — `practice_test/main.tex` (student study copy) and `actual_test/main.tex`
  (real test), plus `Makefile` = `include ../../shared/tests.mk`.
- **`unitXX/test_keys/`** — `practice_test_key/main.tex` and `actual_test_key/main.tex`, plus
  `Makefile` = `include ../../shared/test_keys.mk`.
- **`unitXX/sample_test/`**, **`unitXX/sample_test_key/`** — drop-in dirs that receive published
  PDFs (initially empty, with a `.gitkeep`).

`shared/tests.mk`/`shared/test_keys.mk` compile every `*/main.tex` subdir, then a `drop` target
**publishes the practice test/key** to `sample_test/main.pdf` and `sample_test_key/main.pdf`.
`shared/unit.mk` then merges `sample_test` into the unit **student** packet and
`sample_test_key` into the unit **key** packet (falling back to `sample_test` if no key has been
published). The **actual** test/key are never merged.

```bash
make -C unitXX/tests all         # compile practice + actual tests, publish sample_test/main.pdf
make -C unitXX/test_keys all     # compile both keys, publish sample_test_key/main.pdf
make -C unitXX key               # merges the published sample test key into the unit key packet
make -C unitXX/tests clean       # remove target/UNIT/tests
```

Build order matters: run `make -C unitXX/tests all` (and `test_keys all`) **before** the unit
packet, so the `sample_test` prefab exists when `unit.mk` merges it. Output lands in
`target/UNIT/tests/<name>/main.pdf` and `target/UNIT/test_keys/<name>/main.pdf`.

## Course final exam (`finals/`)

A cumulative course-wide final lives in a top-level **`finals/`** dir (sibling of `unitXX/`),
holding four flat subdirs — `practice_final/`, `practice_final_key/`, `final/`, `final_key/`,
each with a `main.tex`. It is **created by hand, not by the scaffolder**, and uses its own
**self-contained `finals/Makefile`** (the SKILL's "Authoring a course-wide final exam" section
has the full Makefile text). That Makefile globs `*/main.tex`, compiles each to
`target/finals/<name>/main.pdf`, and — unlike unit tests — has **no `drop`/publish step and no
`sample_*` dirs**; the final is standalone and is merged into no packet.

```bash
make -C finals all       # compile all four → target/finals/<name>/main.pdf
make -C finals clean      # remove target/finals
```

Do not add `finals` to `shared/root.mk`/`unit.mk` — it builds only via its own Makefile.

## Troubleshooting

`-file-line-error` makes errors report as `file:line: message`. Read the component's log at
`target/UNIT/LESSON/<comp>/main.log`. Common issues:

- **`File 'warmup/main' not found`** in the lesson plan → the plan embeds a thumbnail but the
  warm-up isn't built/present. Build `student` first, or (authored warm-ups) keep the spiral
  review text-only, or (prefab) ensure the PDF is present as `warmup/main.pdf` so the thumbnail
  (`\includegraphics{warmup/main}`) resolves.
- **`Undefined control sequence \CourseName`** → the course macros aren't defined. In this
  course they live in `shared/linalg-article.sty` (`\CourseName`, `\SchoolYear`,
  `\MeetingLength`); make sure the document loads `linalg-article` and don't redefine them.
- **`\includegraphics` fails for a screenshot** → put images in `images/` (the plan sets
  `\graphicspath{{images/}}`) and load `graphicx` (the plan does; `-article` does not).
- **Key won't compile / option clash** → a key loads `-key` only; do **not** also load
  `-boxes` (it's pulled in). Mirror the blank, swapping that one package line.
- **Garbled glyphs or font errors** → the build is XeLaTeX-only (it uses `unicode-math` /
  `fontspec`-style features); don't compile with `pdflatex`. `latexmk -xelatex` is set in
  `lesson.mk`.
- **`pdfunite: command not found`** → install poppler-utils.
- **A new component didn't appear in the packet** → its directory has neither `main.tex` nor
  `main.pdf`, or its name isn't in `STUDENT_ORDER`. Use the standard component names; the key
  packet is derived from that same list by swapping in each `_key` sibling.
- **`handout pass failed` / `pagination pass failed`** → the message names the log
  (`target/UNIT/LESSON/.handout/handout.log` or `.paginate/paginate.log`) and prints the first
  errors. Almost always an upstream problem: a deck or component PDF that failed to compile.
- **The key packet is longer than the student packet** → it shouldn't be; `paginate` pads both
  to the same slot per component. If they differ, a component is missing its `_key` sibling
  (it then appears blank in both) or a packet was merged from a stale `target/`.

If a fix seems to require changing `shared/` or a Makefile, stop and raise it — that's a
project-level refactor, not a per-lesson change.
