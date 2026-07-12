# Course Workflow — from `linear_algebra_v2.md` to lessons

The course structure comes from **`spec/linear_algebra_v2.md`** — the design notes plus the
**course map**, which mirrors the table of contents of the primary text. The mathematical
**content** comes **entirely from the primary text, Gilbert Strang's _Linear Algebra for
Everyone_**: **units are its chapters and lessons are its subchapters (sections).** No
supplementary materials are used — every lesson's mathematics, examples, and exercises are
sourced from that book and adapted. This file explains how to turn the spec into lessons and
how to source and adapt the text into each lesson's parts.

## Course identity (read this first)

This is **Linear Algebra**, a conceptual, geometry-first course for a **secondary-school**
audience. It is **not** a modeling course: per the spec, applications are **guided
illustration, not the central burden** — the instructor supplies model structure and
assumptions; students supply computation, interpretation, and connection to meaning. Prize
*conceptual understanding over formal abstraction* and *clarity/structure over completeness*.

*Linear Algebra for Everyone* is written for a broad audience but still at a college level, so
always **down-level** when you adapt it:

- Lead with **concrete numbers and geometry**; introduce notation/formalism only after the
  idea is felt. Prefer 2-D and small integer examples over general n-D abstraction.
- **Skip or reframe** the book's heavier machinery (formal vector-space axioms, proofs,
  abstract bases, ε-style rigor) into intuition, worked numeric cases, and pictures.
- Anchor in the unit's **guided applications** (systems in context, geometric
  transformations, best-fit lines) so the math is motivated — but keep them bounded and
  instructor-framed, not open-ended modeling.
- Scaffold heavily: smaller steps, more guided examples, write-on space, vocabulary support.
- Keep the book as the *source*, but rewrite its examples and problems to secondary level and
  the course's voice — never paste a college-level problem verbatim.

## Where the content lives

- `spec/linear_algebra_v2.md` — the course design notes: philosophy, the unit list, and each
  unit's topics + applications. **This is the unit/lesson map.**
- **_Linear Algebra for Everyone_ (Strang)** — the **sole source** and the spine of every
  lesson: units are its chapters, lessons its subchapters. A lesson's core idea, geometry,
  worked examples, and exercises all come from the matching subchapter. (This is an external
  book; the repo ships only the design notes in `spec/` — author from the book's structure.)

A practical loop per lesson: find the topic's subchapter in *Linear Algebra for Everyone* →
extract the core idea, a worked example, and practice items → **down-level and
re-contextualize** them for secondary students → build the components around them.

## The course units

`spec/linear_algebra_v2.md` holds the full course map — the eight units are the eight chapters
of *Linear Algebra for Everyone*, and each unit's lessons are that chapter's sections:

| Unit | Chapter | Lessons (sections) |
| --- | --- | --- |
| 1 | Vectors and Matrices | 1.1–1.4 |
| 2 | Solving Linear Equations Ax = b | 2.1–2.4 |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 |
| 4 | Orthogonality | 4.1–4.4 |
| 5 | Determinants and Linear Transformations | 5.1–5.3 |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 advanced/optional) |
| 7 | The Singular Value Decomposition *(advanced/optional)* | 7.1–7.4 |
| 8 | Learning from Data *(optional enrichment, not assessed)* | 8.1–8.4 |

The **core sequence is Units 1–6**; Unit 7, Unit 8, and §6.4 are optional/advanced (see the
spec's "Scope & sequencing notes," including the short-course path §3.5 → eigenvalues). Read
the per-unit lesson list from the spec's course map — it carries the exact section titles.

## Decomposing a unit into lessons

**Convention: one lesson per topic bullet / subchapter, in listed order.** Lesson id is
`<unit>.<n>` where `n` counts topics within the unit (Lesson 1.1, 1.2, …). Always **present
the proposed lesson map for the unit and confirm it with the user before authoring** — a rich
subchapter sometimes splits, or adjacent topics merge, and the user may want a different grain.

Worked example — **Unit 1 (Vectors and Matrices)**:

| Lesson | Section (topic) | Likely application context |
| --- | --- | --- |
| 1.1 | Linear Combinations of Vectors | combining and scaling data records |
| 1.2 | Lengths and Angles from Dot Products | similarity / closeness of two records |
| 1.3 | Matrices and Column Spaces | a table of data as a matrix; what its columns span |
| 1.4 | Matrix Multiplication and A = CR | building outputs as column combinations |

Do the same for the other units from the spec's course map. Pull the lesson's mathematical
treatment and examples from the matching *Linear Algebra for Everyone* section, but rewrite in
the course's conceptual, geometry-first voice — formalism follows intuition, and anchor the
lesson in a guided application where one fits.

## Mapping content into a lesson

| Lesson element | Source |
| --- | --- |
| Lesson title (`\LessonNumberName`) | "Lesson X.Y: <Topic>" |
| **Primary Objective** (lesson plan) | What students will be able to *do / interpret / justify* with this topic, in student terms |
| **Priority Ideas & Skills** (gold box) | Left: the concrete ideas/skills for this topic. Right: "Key Understandings" — the *why*, i.e. the geometric/conceptual meaning drawn from the Strang subchapter |
| **Vocabulary, Concepts & Theorems** | Terms/notation the topic introduces (use `\TallMath{...}` for tall formulas) |
| **Hook** | A scenario built from the unit's listed **applications** that motivates the topic |
| **Learning Targets** (cover, "I can…") | One target per priority idea/skill, reworded as "I can …" |
| Activity / homework contexts | The unit's applications — have students compute *then* interpret and connect to meaning |
| Connections line | The unit's core idea plus links to prior/next lessons (spiral). This course has no formal standards framework; add an external standard only if the user supplies one |

Keep wording in the course's teaching voice. The recurring move in every component: compute
*then* interpret and justify — "what does this number mean here, and how do you know?" Where a
lesson uses a tool (Desmos, GeoGebra — e.g. for Unit 2's transformation work), show its output
as a pre-made figure rather than asking students to construct one.

## Optional / advanced units

Units 7 (SVD) and 8 (Learning from Data), plus §6.4 (Systems of Differential Equations), are
**optional/advanced** — include them only where the class is ready (Unit 8 is enrichment the
book explicitly does not test). They are still **ordinary units of lessons**: author them with
the standard component set (warm-up, notes, activity, exit ticket, homework, keys) just like
Units 1–6, using the same down-leveling and application-anchored approach. For long-term
behavior / transition matrices, the text's **Appendix 10 (Markov Matrices)** is a natural
optional enrichment topic.
