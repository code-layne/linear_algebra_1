# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-12 — Authored **Lesson 1.0 in full** (all components + keys + slides)
as the course's model lesson. Refocused/retitled it from "Unit Overview and Spiral Review" to
**"Introducing Vectors — Vocabulary and Length"** per user request (intro vocabulary + the
vector concept + magnitude). Builds clean: `make -C unit01/lesson00 all` exit 0 →
`lesson00_student.pdf` (10 pp) and `lesson00_full.pdf` (17 pp); warm-up and exit ticket 1 page each.

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

**Unit 1 — lesson 1.0 authored; 1.1–1.4 scaffolded (skeletons only).**
- `unit01/lesson00` — id 1.0, **"Introducing Vectors — Vocabulary and Length"** ✅ authored
  (cover, warmup, notes, activity, exit_ticket, homework, slides + all keys). Content: vector
  as components/arrow, scalar, add/scale, magnitude $\|\mathbf v\|=\sqrt{v_1^2+v_2^2}$, unit
  vector; drone/displacement application; previews linear combinations (1.1).
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
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ◐ 1.0 authored ✅; 1.1–1.4 skeletons |
| 2 | Solving Linear Equations Ax = b | 2.1–2.4 | ☐ |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 | ☐ |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 1, Lesson 1.1** (Linear Combinations of Vectors) from LAfE §1.1, using
   **lesson 1.0 as the gold model** (mirror its preamble, box usage, tone, and `\vv`/`\ww`
   macros; keep the compute→interpret→justify loop). Reuse the drone/data-record contexts.
2. Then author 1.2–1.4 following the same model.
3. Author the Unit 1 practice/actual tests + keys once the lessons are drafted.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
- In-formula answer-key slots use `{\color{keyred}\mathbf{...}}` inside math, never `\ans{}`
  (which is text-mode) — see the `bmatrix` fill-ins in `notes_key`.

## Open questions / decisions pending

- Lesson 1.0 was retitled to "Introducing Vectors — Vocabulary and Length" (was "Unit Overview
  and Spiral Review"). If a separate pure unit-overview lesson is wanted, flag it. Otherwise none.
