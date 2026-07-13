# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-13 — **Authored Unit 2 Lesson 2.2 in full** (all 13 files). Filled
every skeleton for `unit02/lesson02` — lesson plan + cover, warmup, notes, activity,
exit_ticket, homework (+ all 5 keys) + slides. Through-line: **2.1's "subtract $\ell\times$ a
row" IS a matrix**. Each step is an **elimination matrix** $E_{21}=\begin{bsmallmatrix}1&0\\-\ell&1\end{bsmallmatrix}$
with $E_{21}A=U$; undo it by flipping the sign ($E^{-1}$ adds back, $E^{-1}E=I$); build the
**inverse** $A^{-1}$ two ways (the $ad-bc$ formula and **Gauss–Jordan** on $[A\mid I]$) and solve
via $\xx=A^{-1}\bb$; a **singular** matrix ($ad-bc=0$) is the zero-pivot breakdown from 2.1.
Running example threaded through every component: $A=\begin{bsmallmatrix}1&3\\2&7\end{bsmallmatrix}$,
$\det=1$, $A^{-1}=\begin{bsmallmatrix}7&-3\\-2&1\end{bsmallmatrix}$, solution $(4,1)$. Hook =
"same recipe, new order weekly → build $A^{-1}$ once" (bakery/gift-box/juice-bar multi-RHS
applications). Homework extension: $(EF)^{-1}=F^{-1}E^{-1}$ reverse-order → previews $L$.
Built `make -C unit02/lesson02 all` → clean (both `lesson02_student.pdf` + `lesson02_full.pdf`).
Page-count QA: warmup + exit_ticket each 1 page (blank AND key ✓); notes 3/3, activity 2/2,
homework 2/2 (key paginates identically to blank). No build errors. Spot-checked notes_key (both
pages), lesson plan p1, and activity_key visually — clean, all arithmetic verified. Next run
authors **Lesson 2.3** (Matrix Computations and $A=LU$).

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
- `unit01/tests` (practice + actual) + `unit01/test_keys` (both keys) — **authored ✅ & built**;
  `sample_test`/`sample_test_key` populated by `drop` (practice test + key).
- Root `Makefile` and `unit01/Makefile` created. Toolchain present (xelatex, latexmk, pdfunite).

**Unit 2 — lessons 2.0, 2.1 & 2.2 authored & built; 2.3–2.4 scaffolded (skeletons + tests), NOT authored.**
Confirmed lesson map:
- `unit02/lesson00` — id 2.0, **"From Combinations to Solutions --- Setting Up Ax = b"** ✅ authored
  (all components + keys + slides; both packets built). Content: solve $A\xx=\bb$ = run 1.3
  backwards to find weights; column view vs. row/equation view; elimination (subtract to remove a
  variable) + back-substitute + check; one/none/infinitely-many via two lines and reachability;
  trail-mix / smoothie / fertilizer blend contexts; previews §2.1 pivots.
- `unit02/lesson01` — id 2.1, **"The Idea of Elimination"** (§2.1) ✅ authored (all components +
  keys + slides; both packets built). Content: pivot, multiplier $\ell=\text{entry}\div\text{pivot}$,
  elimination step (lower row $-\,\ell\times$ pivot row), upper-triangular form $U$,
  back-substitution, check by rebuilding $\bb$; $3\times3$ staircase; zero-pivot → row exchange +
  no/infinitely-many breakdown; snack-pack / feed-blend contexts; homework extension lists the
  multipliers as a first look at $L$; previews §2.2 elimination matrices & inverses.
- `unit02/lesson02` — id 2.2, **"Elimination Matrices and Inverse Matrices"** (§2.2) ✅ authored
  (all components + keys + slides; both packets built). Content: elimination step as a matrix
  $E_{21}$ ($EA=U$); undoing a step ($E^{-1}$, $E^{-1}E=I$); the inverse $A^{-1}A=I$ and
  $\xx=A^{-1}\bb$; the $2\times2$ $ad-bc$ formula; **Gauss–Jordan** on $[A\mid I]\to[I\mid A^{-1}]$;
  **singular** ($ad-bc=0$) = zero-pivot breakdown. Bakery / gift-box / juice-bar multi-RHS
  contexts; homework extension does reverse-order $(EF)^{-1}=F^{-1}E^{-1}$ → previews $L$; previews
  §2.3 $A=LU$.
- `unit02/lesson03` — id 2.3, **"Matrix Computations and A = LU"** (§2.3).
- `unit02/lesson04` — id 2.4, **"Permutations and Transposes"** (§2.4).
- `unit02/{tests,test_keys,sample_test,sample_test_key}` + `unit02/Makefile` scaffolded.
- Lessons 2.3–2.4 `main.tex` files are **skeletons only** — content authoring is the next run's job.

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ☑ all lessons + tests authored & built ✅ |
| 2 | Solving Linear Equations Ax = b | 2.0 intro + 2.1–2.4 | ◐ 2.0, 2.1 & 2.2 authored & built ✅; 2.3–2.4 scaffolded, not authored |
| 3 | The Four Fundamental Subspaces | 3.1–3.5 | ☐ |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 2 Lesson 2.3 — "Matrix Computations and A = LU"** (§2.3) into the scaffolded
   skeletons, mirroring 2.0/2.1/2.2 as the model. Collect 2.2's undo-matrices $E^{-1}$ into one
   lower-triangular $L$ (multipliers with $1$s on the diagonal) so $A=LU$; solve $A\xx=\bb$ in two
   triangular sweeps ($L\mathbf{c}=\bb$ forward, then $U\xx=\mathbf{c}$ back); note the cost/count
   angle from the section title. Tie straight to 2.2's $E^{-1}$'s and the homework-extension $L$
   preview. Then 2.4 (Permutations and Transposes), then the Unit 2 tests/keys. Keep blank/key in
   lockstep; source math from LAfE §2.3, down-leveled.
2. *(optional)* Rebuild the whole Unit 1 packet (`make -C unit01 student|full`) to confirm the new
   `sample_test`/`sample_test_key` merge in as expected before moving on.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
- In-formula answer-key slots use `{\color{keyred}\mathbf{...}}` inside math, never `\ans{}`
  (which is text-mode) — see the `bmatrix` fill-ins in `notes_key`.

## Open questions / decisions pending

- Lesson 1.0 was retitled to "Introducing Vectors — Vocabulary and Length" (was "Unit Overview
  and Spiral Review"). If a separate pure unit-overview lesson is wanted, flag it. Otherwise none.
