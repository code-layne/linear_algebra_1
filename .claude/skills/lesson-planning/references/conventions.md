# Conventions

Extracted from the `shared/linalg-*.sty` packages. The live project is always the source of
truth — if the styles diverge from this, follow the package.

## Style packages

| Package | Purpose | Required by |
| --- | --- | --- |
| `linalg-colors` | Color palette (loads `xcolor`) | everything |
| `linalg-article` | Article preamble: geometry, lists, fill-in helpers, page header, name rows, **course macros** | student components |
| `linalg-boxes` | All `tcolorbox` environments, plus `\boxguard`, the `work` environment and `teachernote` | components + lesson plan |
| `linalg-key` | Answer macros (`\ans`, `\ansline`, `\vocabans`) + makes `work` blocks visible; requires `-boxes` | answer keys |
| `linalg-beamer` | Slide theme (`\burgundyheader{}`, `\sectionlabel[color]{}`) | `slides/` |

The `slides` component requires `shared/linalg-beamer.sty`. If that theme was copied from
another course, make sure its internal `\ProvidesPackage`/`\RequirePackage` names were
changed from `apcalc-*`/`precalc-*` to `linalg-*` (like the other style files).

## Per-document-type preambles

**Student component** (warmup, notes, activity, exit_ticket, homework, cover):
```latex
\documentclass[10pt]{article}
\usepackage{linalg-article}
\usepackage{linalg-boxes}
% cover also: \usepackage{ltablex}\keepXColumns
```

**Answer key** (the matching `_key` directory):
```latex
\documentclass[10pt]{article}
\usepackage{linalg-article}
\usepackage{linalg-key}     % pulls in -boxes; do NOT also load -boxes
```

**Lesson plan** (`main.tex` at the lesson root): loads `-boxes` and `graphicx`. The course
macros `\CourseName`, `\SchoolYear`, `\MeetingLength` are defined in `linalg-article.sty`, so
the plan defines only the lesson-specific ones:
```latex
\newcommand{\UnitNumberName}{Unit 1: Vectors as Data \quad}
\newcommand{\LessonNumberName}{Lesson 1.6: Dot Product}
```

The `\TallMath` helper for tall inline math is defined per-document where needed (the
scaffolder includes it):
```latex
\newcommand{\TallMath}[1]{$\displaystyle #1\rule[-1.4em]{0pt}{3.2em}$}
```

## Fill-in helpers (from `-article`)

| Macro | Effect |
| --- | --- |
| `\blank{width}` | Underlined gap of the given width (e.g. `\blank{4.8cm}`) |
| `\writeline` | A full-width gray rule to write on |
| `\writelines{n}` | `n` stacked write-lines |
| `\termblank{Term}` | Bold burgundy term + inline blank, then a write-line |
| `\termblanklong{Term}` | Bold burgundy term on its own line + two write-lines (vocab style) |
| `\namedateperiod` | Name / Date / Period row — **cover and unit tests only** (Namestrip) |
| `\namepartnerperiod` | Name / Partner / Period row — **not used on components**; superseded by Namestrip |
| `\pageheader{Unit X, Lesson Y.Z}{Document Type}` | Full-width burgundy banner header (prints "Linear Algebra") |

**The `\noindent` trap — this is what `vocabpar` fixes.** `\termblanklong` (blank) and `\vocabans`
(key) both open with `\noindent`, which is a **no-op in the middle of a paragraph**. In a `vocabbox`
that opens with an intro sentence, the sentence and the *first* term therefore run together on one
line. See "vocabpar" below for the two-line fix.

## Box environments (from `-boxes`)

Lesson-plan boxes take a background color as the last argument (use the aliases `goldbox`,
`greenbox`, `redbox`, or palette colors like `blush`); the frame/header is burgundy by default:
```latex
\begin{skillbox}[Priority Ideas \& Skills]{goldbox} ... \end{skillbox}   % breakable
\begin{fixedskillbox}[Spiral Review]{blush} ... \end{fixedskillbox}      % no page break
```

Titled student boxes (title is fixed by the environment unless it takes an argument):

| Environment | Title / use | Arg |
| --- | --- | --- |
| `objectivebox` | "Primary Objective" | — |
| `learningtargetbox` | "Learning Targets — I Can…" (cover sheet) | — |
| `vocabbox` | "Vocabulary & Key Concepts" | — |
| `hookbox` | "Hook" | — |
| `notesbox{Title}` | generic titled notes section | title |
| `practicebox` | "Guided Practice" | — |
| `spiralbox` | "Connections & Big Ideas" | — |
| `scenariobox[Title]{color}` | activity/homework scenario | title, color |
| `headlinebox{color}` | colored callout strip | color |
| `blurbbox[Title]{color}` | study/excerpt blurb | title, color |
| `reflectionbox` | "Reflection" (homework) | — |
| `extensionbox` | "Extension — optional" | — |
| `tocbox` | "What's in This Packet" (cover) | — |
| `remindbox` | "Keep in Mind" (cover) | — |

## The five conventions — and the order they run in

Imported from the Algebra 2 course (2026-08-01), where each was found the hard way. They exist for
one outcome: **every component is the same number of pages blank and keyed**, so the student packet
never carries a padding page, and no box breaks leaving a stub.

**When reviewing or revising a lesson, execute them in this order:**

> **1. vocabpar → 2. teachernote → 3. namestrip → 4. work rule → 5. boxguard**

The order is not arbitrary — the first four all change how much vertical space a component takes,
and **boxguard repairs the pagination the other four disturb**, so it must run last. Within that,
vocabpar comes first because it makes vocab boxes *taller* and can reverse a guard verdict measured
before it; teachernote and namestrip both *remove* material; the work rule re-matches blank to key
once the lengths have settled. Re-measure after each step rather than trusting a verdict recorded
against earlier box heights.

Each of the five is documented in its own section below. A convention lands *after* lessons are
written, so any of the 41 authored lessons can be behind on one — bring a lesson forward by name
(see the Retrofit section in `SKILL.md`). **There is no bulk sweep:** a project-wide pass would
re-flow the pagination of every verified lesson at once.

### 1. vocabpar — paragraph breaks in the vocab box

`\termblanklong` (blank) and `\vocabans` (key) both open with `\noindent`, a no-op mid-paragraph.
Left alone, the `vocabbox` intro sentence and the **first** term run together on one line, in the
blank and the key alike.

The fix is per-lesson, two lines, applied to `notes/main.tex` **and** `notes_key/main.tex`:

```latex
% both files — \par is REQUIRED; \vspace alone does not end the paragraph
Fill in each term as we build it together.
\par\vspace{2pt}
\termblanklong{First term}        % \vocabans{First term}{…} in the key
```

Anywhere else an `\ansline` or `\writeline` is followed by a `\noindent`-opening macro is exposed
to the same collision — check homework and activity keys, not just the vocab box.

Fix it per-lesson rather than patching `\termblanklong` in `shared/linalg-article.sty`: a
shared-package change re-flows every already-verified lesson at once.

**vocabpar changes box heights, so boxguard must be re-run after it** — that is why it is first in
the order.

### 2. teachernote — teacher prose in the lesson plan, never in a key

A `teachernote` is the one block in a key with no counterpart in the blank, so it makes the key
longer than its blank for no student-facing reason. **Teacher-only prose belongs in the lesson
plan**, which is teacher-facing already and sits outside the page-matched packet.

The plan closes with one note per component, in packet order, each titled for it:

```latex
\begin{teachernote}[Warm-Up]        ... \end{teachernote}   % → "Teacher Note: Warm-Up"
\begin{teachernote}[Guided Notes]   ... \end{teachernote}
\begin{teachernote}[Group Activity] ... \end{teachernote}
\begin{teachernote}[Exit Ticket]    ... \end{teachernote}
\begin{teachernote}[Homework]       ... \end{teachernote}
```

**There is no exemption — this applies to assessment keys too.** A unit test's answer rationale
and Part D scoring go on **page 2 of `unitXX/unit_cover_key/main.tex`**, not at the foot of
`practice_test_key`/`actual_test_key`. That document shares its page 1 with the student cover by
`\input`-ing the same `unit_cover/body.tex` (so the two can never drift) and is merged by
`shared/unit.mk` into the **key packet only** — which matters, because the practice test *is*
bound into the student packet, and its rationale must not ride along. One unit, one notes page:
cover + notes = a single double-sided sheet. A unit with no `unit_cover_key/` falls back to the
plain cover in both packets. The course finals (`finals/*_key/`) are merged into no packet at
all and have no cover, so their scoring notes stay in the key.

The environment now lives in **`linalg-boxes`** (the lesson plan does not load `-key`) and the title
argument is **optional** — a bare `\begin{teachernote}` still renders plain "Teacher Note", so the
196 files that still carry one keep compiling untouched. To migrate a lesson:

```bash
python3 .claude/skills/lesson-planning/scripts/movenotes.py unit06/lesson00
```

It lifts the note out of each `_key`, appends it to the plan with the right title, and refuses to
run twice on the same lesson. `--check` reports without changing anything.

### 3. namestrip — the name/date/period row belongs on the cover only

When a review says "lesson 3.2 needs a namestrip," the name/date/period row is repeating on
components stapled *behind* the cover sheet. The student writes their name once; every repeat costs
vertical space at the top of a page — space that matters most on the warm-up and exit ticket, which
are held to one page.

Strip `\namedateperiod`/`\namepartnerperiod` from `warmup`, `notes`, `activity`, `exit_ticket`,
`homework` **and from all five `_key` files**, which stay in lockstep. Two exemptions:

- **`cover/`** — the one place the row belongs. Never strip it.
- **`unitXX/tests/` and `test_keys/`** (and `finals/`) — taken in a testing setting, not stapled
  behind a lesson cover, so they keep the row.

Apply it with the script — it skips `cover/`, hits blanks and keys together, and is idempotent:

```bash
python3 .claude/skills/lesson-planning/scripts/namestrip.py --project . --unit 06 --lesson 00
python3 .claude/skills/lesson-planning/scripts/namestrip.py --project . --unit 06 --lesson 00 --check
```

`--check` writes nothing and exits 1 if it finds anything, so it doubles as a review gate. Rebuild
afterward and confirm the warm-up and exit ticket are **still 1 page**, blank *and* key.

**Going forward this is automatic:** `new_lesson.py` and the worksheet skeletons no longer emit a
name row, so newly scaffolded lessons are born namestripped. Namestrip is **not always free** —
on a retrofit it can reclaim enough space that the *key* fits a box the blank still pushes, opening
a mismatch that a `\boxguard` then closes. That is why it runs before boxguard, never after.

### 4. The work rule — `\begin{work}` (defined in `-boxes`, visible under `-key`)

**Any worked solution goes in a `work` block, and that block is byte-identical in the blank and the
key.** The package swap decides only whether it is shipped: under `-boxes` the blank builds the box
and emits a `\vphantom` of it (exact height, no ink and nothing in the PDF's text layer); under
`-key` the same box prints in `keyred`. The two therefore *cannot* drift — which is what keeps a
component the same length on both sides.

```latex
% notes/main.tex AND notes_key/main.tex — the same lines in both files
\begin{work}
  \det(A-\lambda I) &= (2-\lambda)^2-1 \\
                    &= \lambda^2-4\lambda+3 \\
            \lambda &= 1 \text{ or } 3
\end{work}
```

Format, non-negotiable:

- **One statement per line.** Never two steps on one row, and never an inline
  `a=b \Rightarrow c=d` chain — that is the idiom this rule replaces.
- **The `&` goes immediately before the relation**, so every relation in the block lands in one
  column. Works for `=`, `<`, `>`, `\le`, `\ge`, `\Rightarrow`.
- **Simplifying:** row 1 is the original expression, the relation, and the first simplification;
  every later row starts at the `&=` and aligns to the one above.
- **Solving:** one row per step, each aligned on its relation.

Do not wrap a `work` block in `\[ \]`, `align`, or `equation` — it supplies its own display. It is
set flush left (2em indent), not centered.

**When it applies:** a task that asks for multi-step work. A table cell holding a single final
answer is already the same size in both files — leave those as `\blank{}`/`\ans{}`. `work` blocks
do not go inside table cells; if a table asks for real work, pull the items out of the table.

`\workrowsep` (default `0pt`) adds leading between rows. It moves the blank and the key together,
so raising it for handwriting room can never break the match.

**Reach for `work` before `\writelines`.** The other place lengths drift is a prose `\ansline` that
wraps to four lines against a one-line `\writeline`; the fix there is `\writelines{n}` in the blank,
sized from the key's true wrapped length. But if the answer is a multi-step computation, `work`
fixes it correctly and cannot come apart, while a lengthened write-line only papers over it. Note
`\writelines{n}` occupies **n+1** line slots (it ends in `\\`), so raising one is not free —
re-measure the blank after any change.

### 5. boxguard — the page-break rule

When a review says "lesson 6.2 has a boxguard problem on page 4," a box broke across a page leaving
roughly an inch — a title plus a line or two — at the **top or bottom** of a page. **Push the whole
box to the next page.** Breaking a box is fine only when each side of the break gets a substantial
chunk. The white space you give up is cheaper than a stub that reads as a printing mistake.

`\boxguard` is defined in `shared/linalg-boxes.sty` (so it reaches every key through
`linalg-key.sty`) — no per-file preamble needed:

```latex
\boxguard                      % default: needs 16 lines of room, else break
\begin{notesbox}{2. ...}

\boxguard[30]                  % box OPENS with an unbreakable TikZ/pgfplots figure or tabularx
\begin{notesbox}{3. ...}
```

Prefer `\boxguard` to a hard `\newpage` — it self-adjusts when content above it changes. Apply
every guard to the blank **and** its `_key`, then rebuild and confirm the page counts did not move.

Two limits, both learned on the Algebra 2 course:

1. **`\boxguard` is inert inside a breakable `tcolorbox`** — `\needspace` measures the outer page
   while tcolorbox splits its own assembled vbox afterwards. To force a split at a chosen point
   *inside* a breakable box, use tcolorbox's own **`\tcbbreak`**. It is unconditional, so mirror it
   in the blank and the key and re-check both page counts.
2. **A guard that costs a page also costs the blank/key match — but the page can often be bought
   back.** Before declining a guard, measure the overflow: a few lines of mirrored table stretch
   (`\arraystretch` 1.7→1.5, `itemsep` 4pt→3pt) is usually cheaper than the stub.

**Boxguard is opt-in and nothing detects a missed one.** A stranded stub is not a compile error and
`make` still exits 0, so violations surface only when someone looks at the PDF. A "guard costs a
page" verdict is valid only for the box heights it was measured against — **re-measure rather than
trusting a prior refusal**, especially after vocabpar.

## Answer-key macros (from `-key`)

| Macro / env | Effect |
| --- | --- |
| `\ans{text}` | Inline answer in bold `keyred`; use in place of a blank |
| `\ansline{text}` | Bold `keyred` answer that fills a write-line with a dotted trail |
| `\vocabans{Term}{definition}` | Keyed vocabulary entry — the counterpart of `\termblanklong` |
| `work` (env) | Worked steps — **defined in `-boxes`**, authored identically in both files; see the work rule |

**`teachernote` is no longer a key macro.** It lives in `-boxes` and belongs in the **lesson plan**
— see convention 2 above.

`\ans` is a **text-mode** macro (`\textcolor{keyred}{\textbf{#1}}`). Never place it inside
`$...$`; wrap math fragments instead (`\ans{$\hat v$}`, `\ans{$\sqrt{n}$}`), and never let it
span a blank line.

**Key-authoring rule:** copy the blank component verbatim, then replace each blank/`\writeline`
with `\ans{…}`/`\ansline{…}` and mark correct multiple-choice options, e.g.
`\textcolor{keyred}{\textbf{$\leftarrow$ correct}}`. The key and blank must stay structurally
identical so they paginate the same way.

## Color palette (from `-colors`)

**Burgundy is the dominant color.** Defined colors and where they are used:

- **Burgundy family (primary):** `burgundy` (#6B2137), `burgundylight` (#9C3A54) — box
  frames/headers, the `\pageheader` banner, and term labels.
- **Blush tints (paired backgrounds):** `blush` (#FBEEF1), `blushmid` (#E9BFCB) — light
  backgrounds under burgundy frames (objective/notes/reflection boxes) and the banner subtitle.
- **Royal blue:** `royalblue` (#24509C) on `skyblue` (#E7F0FB) — `practicebox`
  ("Guided Practice") and the `teachernote` callout.
- **Gold:** `goldacc` (#D4820A), `goldbg`, `hookbg` — Hook, Extension, Reinforcement, Keep-in-Mind.
- **Green:** `greenbg`/`greenacc` — Vocabulary.
- **Red:** `redbg`/`redacc` — still defined; available as a `scenariobox`/`blurbbox` color.
- **Neutrals:** `charcoal`, `slate`, `linegray`. **Answer red:** `keyred` (#CC0000).
- **Lesson-plan background aliases:** `goldbox`, `greenbox`, `redbox`.

Deprecated aliases `navy`→`burgundy`, `navylight`→`burgundylight`, `sky`→`blush`,
`skymid`→`blushmid` still resolve, but prefer the burgundy/blush names in new material.

## Lesson-plan section order (canonical)

Primary Objective → Priority Ideas & Skills → Vocabulary, Concepts & Theorems → Activate
Prior Knowledge & Spiral Review (embeds the warm-up thumbnail if prefab) → Hook → Lesson (and
"Lesson (cont.)") → Explicit Instruction (one box per technique) → Active Monitoring →
Group Work & Differentiation (Tiers R / A / E) → Individual Work & Assessment (Exit Ticket +
a conceptual/justification check) → Reinforcement & Extension (Homework + Extension +
Preview). Keep the Primary Objective in plain student terms — what they can do, interpret,
and justify with the topic. This course has no theme/standards framework to tag; see
`course-workflow.md`.
