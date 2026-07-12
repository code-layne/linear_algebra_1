# Course Workflow — from `course_structure.md` to lessons

The course is defined by two things working together: **`spec/course_structure.md`** lays out
the units and lessons (themes, essential questions, the topic list per unit), and the two
**MIT OpenCourseWare mirrors in `spec/` are the content** — the actual mathematics, examples,
and exercises each lesson is built from. This file explains how to turn the structure spec
into lessons and how to source and adapt the OCW content into each lesson's parts.

## Audience: secondary school, not undergraduate (read this first)

Both OCW courses are flagged **`"level": ["Undergraduate"]`**. This course targets a
**secondary-school** audience and is conceptual/modeling-first, *not* a college course
transplanted down. So when you pull from OCW, **adapt every time**:

- Lead with **concrete numbers and geometry**; introduce notation/formalism only after the
  idea is felt. Prefer 2-D and small integer examples over general n-D abstraction.
- **Skip or reframe** undergraduate machinery (formal vector-space axioms, proofs, abstract
  bases, ε-style rigor) into intuition, worked numeric cases, and pictures.
- Anchor in the unit's **applications** (recommendation systems, populations, networks,
  Markov chains, …) so the math is motivated by a real question.
- Scaffold heavily: smaller steps, more guided examples, write-on space, vocabulary support.
- Keep the OCW lecture/problem-set as the *source*, but rewrite problems to secondary level
  and the course's voice — never paste an undergraduate problem set verbatim.

## Where the content lives

- `spec/course_structure.md` — units, lessons, themes, essential questions, applications.
- `spec/18.06-mit_opencourseware_linear_algebra/` — the spine of the course (Strang). For a
  topic, find the matching lecture under `resources/lecture-N-<topic>/` (and lecture-note
  PDFs under `resources/18-06_lNN/`), plus `pages/readings/`, `pages/assignments/` (problem
  sets **with solutions**), and `pages/exams/` for exercise material.
- `spec/18.02-mit_opencourseware_multivariable_calculus/` — vectors, dot product,
  determinants, and geometric interpretation (`resources/lecture-1-dot-product/`,
  `resources/determinants/`, `resources/vectors_matrices/`); best for Units 1, 3, 4.
- Each mirror's `data.json` has the course description; `content_map.json` maps resource UIDs
  to their `data.json` paths if you need to resolve a link. Strang's text is the instructional
  model (geometry-first); Shilov is for instructor rigor only — not student-facing.

A practical loop per lesson: find the topic's OCW lecture/reading → extract the core idea and
a worked example → **down-level and re-contextualize** it for secondary students → build the
components around it, sourcing practice items from the matching problem set (rewritten).

## The four themes

Every unit sits under one or more recurring themes; use the governing theme the way an AP
course uses a Big Idea — as the tag on the Primary Objective and the through-line of the
lesson.

| Theme | Question it answers | Units it dominates |
| --- | --- | --- |
| **Representation** | How can information be represented mathematically? | 1, 2, 7 |
| **Transformation** | How do mathematical objects change? | 3, 4 |
| **Prediction** | How can models forecast behavior? | 5, 6, 8, 9 |
| **Communication** | How do we justify conclusions from a model? | every unit; the capstone 10 |

Communication is a thread through *all* units (writing explanations, defending assumptions,
analyzing limitations) — surface it in reflection/justification prompts even when another
theme governs the topic.

## Decomposing a unit into lessons

**Convention: one lesson per topic bullet, in listed order.** Lesson id is
`<unit>.<n>` where `n` counts topics within the unit (Lesson 1.1, 1.2, …). Always **present
the proposed lesson map for the unit and confirm it with the user before authoring** —
adjacent topics sometimes merge (e.g. magnitude + direction) or a rich topic splits, and the
user may want a different grain.

Worked example — **Unit 1 (Vectors as Data)**, EQ *"How can a list of numbers describe
something meaningful?"*, theme Representation:

| Lesson | Topic | Likely application context |
| --- | --- | --- |
| 1.1 | Vectors | grades / demographic data as lists of numbers |
| 1.2 | Magnitude | size of a data vector |
| 1.3 | Direction | orientation / unit vectors |
| 1.4 | Vector addition | combining records |
| 1.5 | Scalar multiplication | scaling/weighting |
| 1.6 | Dot product | similarity score |
| 1.7 | Similarity measures | recommendation / ratings systems |

Do the same for Units 2–9 from their topic lists. Pull the lesson's mathematical treatment
and examples from the matching 18.06 lecture(s) and Strang section, but rewrite in the
course's conceptual/modeling voice — formalism follows intuition, and where a topic has an
application listed, anchor the lesson in it.

## Mapping content into a lesson

| Lesson element | Source |
| --- | --- |
| Lesson title (`\LessonNumberName`) | "Lesson X.Y: <Topic>" |
| **Primary Objective** (lesson plan) | What students will be able to *do/interpret/justify* with this topic; append the governing theme, e.g. `(Theme: Representation)` |
| **Priority Ideas & Skills** (gold box) | Left: the concrete ideas/skills for this topic. Right: "Key Understandings" — the *why*, in modeling terms (drawn from the unit's framing + Strang) |
| **Vocabulary, Concepts & Theorems** | Terms/notation the topic introduces (use `\TallMath{...}` for tall formulas) |
| **Hook** | A scenario built from the unit's listed **applications** that motivates the topic |
| **Learning Targets** (cover, "I can…") | One target per priority idea/skill, reworded as "I can …" |
| Activity / homework contexts | The unit's applications — make tasks *model and interpret*, not just compute |
| Connections line | The unit's Essential Question + governing theme (this course's analog to a standards line); add an external standard only if the user supplies one |

Keep wording in the course's teaching voice. The recurring move in every component:
compute *then* interpret and justify — "what does this number mean here, and how do you
know?" Use tools named in the spec (Desmos, GeoGebra) for Unit 3's transformation work; show
their output as a pre-made figure rather than asking students to construct one.

## Unit 10 — Capstone Modeling Project (special case)

Unit 10 is not a sequence of warmup/notes/exit-ticket lessons. It is a project. Author it as
a project packet rather than the standard component set — e.g. a cover, a **project brief**
(problem definition, assumptions, model, analysis, limitations, communication — the six
requirements from the spec), milestone/checkpoint sheets, and a rubric. Confirm the exact
deliverables (written report, mathematical analysis, presentation, model critique) and the
packet structure with the user before scaffolding; only scaffold the component directories
that fit, and use prefab PDFs (Step 4) for anything supplied ready-made.
