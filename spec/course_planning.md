# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-12 — Infrastructure set up (styles, spec, skill); no lessons
authored yet.

## Current state

**Infrastructure — ready:**
- `shared/` style package in place (prefix `linalg`), burgundy-dominant palette; Guided
  Practice / Teacher Note boxes in royal blue. `\CourseName` = "Linear Algebra".
- `spec/linear_algebra_v2.md` — course map mirrors *Linear Algebra for Everyone* (8 units =
  8 chapters; lessons = subchapters). LAfE is the sole content source (no supplements).
- `spec/everyone_prefaceTOC01.pdf` — the book's table of contents (source for the unit map).
- lesson-planning skill reconciled to the above; syncs with upstream on start, logs here on end.

**Course build — not started.** No units or lessons scaffolded yet. This is greenfield: the
first lesson authored becomes the model for the rest.

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.1–1.4 | ☐ |
| 2 | Solving Linear Equations Ax = b | 2.1–2.4 | ☐ |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 | ☐ |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Confirm the Unit 1 lesson map** with the user (proposed: 1.1 Linear Combinations of
   Vectors, 1.2 Lengths and Angles from Dot Products, 1.3 Matrices and Column Spaces, 1.4
   Matrix Multiplication and A = CR).
2. **Scaffold and author Unit 1, Lesson 1.1** as the model lesson — build and proofread it
   carefully (it sets the pattern for the whole course) before scaling out.
3. Decide the standard component set per lesson (warm-up, notes, activity, exit ticket,
   homework, cover + keys) and whether slides are wanted.

## Open questions / decisions pending

- Component set and whether teacher slide decks are in scope for each lesson.
- Grain of the Unit 1 map (keep 4 lessons as in the book, or split/merge any section).
