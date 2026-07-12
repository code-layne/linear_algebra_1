# Conventions

Extracted from the `shared/linalg-*.sty` packages. The live project is always the source of
truth — if the styles diverge from this, follow the package.

## Style packages

| Package | Purpose | Required by |
| --- | --- | --- |
| `linalg-colors` | Color palette (loads `xcolor`) | everything |
| `linalg-article` | Article preamble: geometry, lists, fill-in helpers, page header, name rows, **course macros** | student components |
| `linalg-boxes` | All `tcolorbox` environments | components + lesson plan |
| `linalg-key` | Answer macros + teacher note; requires `-boxes` | answer keys |
| `linalg-beamer` | Slide theme (`\navyheader{}`, `\sectionlabel[color]{}`) | `slides/` |

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
| `\termblank{Term}` | Bold navy term + inline blank, then a write-line |
| `\termblanklong{Term}` | Bold navy term on its own line + two write-lines (vocab style) |
| `\namedateperiod` | Name / Date / Period row |
| `\namepartnerperiod` | Name / Partner / Period row (group activities) |
| `\pageheader{Unit X, Lesson Y.Z}{Document Type}` | Full-width navy banner header (prints "Linear Algebra") |

## Box environments (from `-boxes`)

Lesson-plan boxes take a background color as the last argument (use the aliases `goldbox`,
`greenbox`, `redbox`, or palette colors like `sky`):
```latex
\begin{skillbox}[Priority Ideas \& Skills]{goldbox} ... \end{skillbox}   % breakable
\begin{fixedskillbox}[Spiral Review]{sky} ... \end{fixedskillbox}        % no page break
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

## Answer-key macros (from `-key`)

| Macro / env | Effect |
| --- | --- |
| `\ans{text}` | Inline answer in bold `keyred`; use in place of a blank |
| `\ansline{text}` | Bold `keyred` answer that fills a write-line with a dotted trail |
| `teachernote` (env) | Red "Teacher Note" callout for teacher-only guidance |

`\ans` is a **text-mode** macro (`\textcolor{keyred}{\textbf{#1}}`). Never place it inside
`$...$`; wrap math fragments instead (`\ans{$\hat v$}`, `\ans{$\sqrt{n}$}`), and never let it
span a blank line.

**Key-authoring rule:** copy the blank component verbatim, then replace each blank/`\writeline`
with `\ans{…}`/`\ansline{…}` and mark correct multiple-choice options, e.g.
`\textcolor{keyred}{\textbf{$\leftarrow$ correct}}`. The key and blank must stay structurally
identical so they paginate the same way.

## Color palette (from `-colors`)

Primary: `navy` (#1F3A5F), `navylight`, `sky` (pale blue bg), `skymid`, `goldacc`, `goldbg`,
`hookbg`, `greenbg`/`greenacc`, `redbg`/`redacc`, `charcoal`, `slate`, `linegray`, `keyred`
(#CC0000). Lesson-plan background aliases: `goldbox`, `greenbox`, `redbox`.

## Lesson-plan section order (canonical)

Primary Objective → Priority Ideas & Skills → Vocabulary, Concepts & Theorems → Activate
Prior Knowledge & Spiral Review (embeds the warm-up thumbnail if prefab) → Hook → Lesson (and
"Lesson (cont.)") → Explicit Instruction (one box per technique) → Active Monitoring →
Group Work & Differentiation (Tiers R / A / E) → Individual Work & Assessment (Exit Ticket +
a conceptual/justification check) → Reinforcement & Extension (Homework + Extension +
Preview). Tag the Primary Objective with the governing **theme** (Representation /
Transformation / Prediction / Communication); see `course-workflow.md`.
