# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-12 — Scaffolded all of Unit 1 (5 lessons + unit tests). All
skeletons only — no content authored yet. Verified the scaffold builds (lesson00 `make all`
→ `lesson00_full.pdf`, exit 0).

## Current state

**Infrastructure — ready:**
- `shared/` style package in place (prefix `linalg`), burgundy-dominant palette; Guided
  Practice / Teacher Note boxes in royal blue. `\CourseName` = "Linear Algebra".
- `spec/linear_algebra_v2.md` — course map mirrors *Linear Algebra for Everyone* (8 units =
  8 chapters; lessons = subchapters). LAfE is the sole content source (no supplements).
- `spec/everyone_prefaceTOC01.pdf` — the book's table of contents (source for the unit map).
- lesson-planning skill reconciled to the above; syncs with upstream on start, logs here on end.

**Confirmed conventions (user, 2026-07-12):**
- Each unit gets an **intro lesson (`lesson00`, id `X.0`)** before the book sections — spiral
  review of prerequisite skills + a roadmap of where the unit is going. So Unit 1 = 5 lessons.
- **Standard component set per lesson:** cover, warmup, notes, activity, exit_ticket, homework,
  **slides** (+ keys for the keyed components). Teacher slide decks are in scope.

**Unit 1 — scaffolded (all skeletons, no content yet).**
- `unit01/lesson00` — id 1.0, "Unit Overview and Spiral Review" (intro/spiral)
- `unit01/lesson01` — id 1.1, "Linear Combinations of Vectors"
- `unit01/lesson02` — id 1.2, "Lengths and Angles from Dot Products"
- `unit01/lesson03` — id 1.3, "Matrices and Column Spaces"
- `unit01/lesson04` — id 1.4, "Matrix Multiplication and A = CR"
- `unit01/tests` + `unit01/test_keys` + `sample_test`/`sample_test_key` — test skeletons only.
- Root `Makefile` and `unit01/Makefile` created. Toolchain present (xelatex, latexmk, pdfunite).

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ◐ scaffolded (skeletons only) |
| 2 | Solving Linear Equations Ax = b | 2.1–2.4 | ☐ |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 | ☐ |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 1, Lesson 1.1** (Linear Combinations of Vectors) as the model lesson — all
   components + keys from LAfE §1.1, down-leveled. Build and proofread carefully; it sets the
   pattern for the whole course.
2. **Author Lesson 1.0** (intro/spiral) — its warmup/notes should review prerequisite skills
   (coordinates, arithmetic with signed numbers, reading the plane) and map the unit's arc.
3. Then author 1.2–1.4 following the 1.1 model.

## Open questions / decisions pending

- None outstanding for Unit 1 scaffolding. (Content authoring is the next phase.)
