# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-13 — Authored **Lesson 1.4 "Matrix Multiplication and $A=CR$" in full**
(all components + keys + slides), mirroring Lessons 1.0–1.3 as the gold model. Content from
LAfE §1.4, down-leveled: matrix multiplication **by columns** ($AB=[A\mathbf b_1\ A\mathbf b_2]$ —
each column of the product is a combination of $A$'s columns), the factorization $A=CR$ ($C$ = the
independent columns, $R$ = the recipe that rebuilds every column of $A$ from $C$), and **rank** =
number of independent columns = columns in $C$. Running example $A=\begin{bsmallmatrix}1&3&4\\2&1&3\end{bsmallmatrix}$
with col 3 = col 1 + col 2 → $C=\begin{bsmallmatrix}1&3\\2&1\end{bsmallmatrix}$, $R=\begin{bsmallmatrix}1&0&1\\0&1&1\end{bsmallmatrix}$.
"Rebuilding a catalog from base products" application (base products = $C$, recipe card = $R$;
data-as-a-table theme). Builds clean: `make -C unit01/lesson04 all` exit 0 → `lesson04_student.pdf`
(9 pp) and `lesson04_full.pdf` (17 pp); warm-up and exit ticket 1 page each (blank + key);
`\ans`-in-math scan clean; notes/activity/homework blank+key paginate in lockstep (2 pp each);
TikZ dependent-column figure (dashed $\mathbf a_3=\mathbf a_1+\mathbf a_2$) renders. **Unit 1 lessons
all authored** — next is the Unit 1 test + keys.

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

**Unit 1 — lessons 1.0, 1.1, 1.2, 1.3, 1.4 all authored.**
- `unit01/lesson00` — id 1.0, **"Introducing Vectors — Vocabulary and Length"** ✅ authored
  (cover, warmup, notes, activity, exit_ticket, homework, slides + all keys). Content: vector
  as components/arrow, scalar, add/scale, magnitude $\|\mathbf v\|=\sqrt{v_1^2+v_2^2}$, unit
  vector; drone/displacement application; previews linear combinations (1.1).
- `unit01/lesson01` — id 1.1, **"Linear Combinations of Vectors"** ✅ authored (all components +
  keys + slides). Content: $c\mathbf v+d\mathbf w$, weights, span, line vs plane, parallel
  exception, standard basis, finding weights; robot-moves + juice/smoothie contexts; previews
  the dot product (1.2).
- `unit01/lesson02` — id 1.2, **"Lengths and Angles from Dot Products"** ✅ authored (all
  components + keys + slides). Content: dot product, length $\sqrt{\mathbf v\cdot\mathbf v}$,
  unit vector, angle/cosine, sign, perpendicular $\Leftrightarrow$ dot $=0$; viewer/song
  data-similarity contexts; previews matrices \& column spaces (1.3).
- `unit01/lesson03` — id 1.3, **"Matrices and Column Spaces"** ✅ authored (all components +
  keys + slides). Content: matrix as columns, $A\mathbf x$ as a combination of columns, column
  space $C(A)=$ span of columns, line (parallel columns) vs. plane (independent columns),
  reachability of $\mathbf b$; gift-box "build an order" + kit/production contexts; previews
  $A=CR$ (1.4).
- `unit01/lesson04` — id 1.4, **"Matrix Multiplication and $A=CR$"** ✅ authored (all components +
  keys + slides). Content: multiply by columns $AB=[A\mathbf a_1\ \ldots]$, factorization $A=CR$
  ($C$ = independent columns, $R$ = recipe), rank = columns in $C$; catalog/base-product context;
  previews Unit 2 (solving $A\mathbf x=\mathbf b$).
- `unit01/tests` + `unit01/test_keys` + `sample_test`/`sample_test_key` — test skeletons only.
- Root `Makefile` and `unit01/Makefile` created. Toolchain present (xelatex, latexmk, pdfunite).

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ◐ all lessons authored ✅; tests skeleton only |
| 2 | Solving Linear Equations Ax = b | 2.1–2.4 | ☐ |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 | ☐ |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author the Unit 1 practice/actual tests + keys** (skeletons already scaffolded in
   `unit01/tests` + `unit01/test_keys`; `drop` publishes practice test/key to `sample_test`/
   `sample_test_key`). Cover the full arc: vectors + length (1.0), linear combinations/span (1.1),
   dot product/angles (1.2), matrices + column space (1.3), and $A=CR$/rank (1.4). Keep practice and
   actual in the same format. See `references/components.md` for the test structure.
2. **Confirm the Unit 2 lesson map with the user** (Solving $A\mathbf x=\mathbf b$, §2.1–2.4, plus a
   `lesson00` intro per the confirmed convention), then begin authoring Unit 2.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
- In-formula answer-key slots use `{\color{keyred}\mathbf{...}}` inside math, never `\ans{}`
  (which is text-mode) — see the `bmatrix` fill-ins in `notes_key`.

## Open questions / decisions pending

- Lesson 1.0 was retitled to "Introducing Vectors — Vocabulary and Length" (was "Unit Overview
  and Spiral Review"). If a separate pure unit-overview lesson is wanted, flag it. Otherwise none.
