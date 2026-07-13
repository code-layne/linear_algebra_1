# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-13 — **Scaffolded all of Unit 3 — "The Four Fundamental Subspaces."**
Confirmed the §3.1–3.5 lesson map (intro-lesson convention → `lesson00` id 3.0 + 3.1–3.5 = 6 lessons)
and ran `new_lesson.py` for all six with the standard component set (cover, warmup, notes, activity,
exit_ticket, homework, slides + keys for the five keyed components). `lesson00` created the unit,
which auto-scaffolded `unit03/tests/`, `unit03/test_keys/`, `unit03/sample_test/`, `unit03/sample_test_key/`
(practice + actual test/key skeletons + thin-include Makefiles) and `unit03/Makefile`. **Every Unit 3
file is currently a bare skeleton — nothing authored yet.** Next run authors the lessons in order,
mirroring the Unit 1–2 lessons as the model (start with `lesson00` 3.0, build + proofread it as the
unit's model, then scale out 3.1–3.5, then the summative tests).

**Prior run:** Authored the Unit 2 summative tests in full (all 4 files),
closing out Unit 2. Filled every skeleton: `unit02/tests/{practice_test,actual_test}` (blank) and
`unit02/test_keys/{practice_test_key,actual_test_key}` (keys). Same 4-part parthead structure as the
Unit 1 tests — Part A vocab matching (8 terms: pivot, multiplier, upper-triangular $U$, inverse,
singular, $LU$, permutation $P$, transpose), Part B 6× MC (concept checks: multiplier formula, $L$
holds multipliers, singular $\Leftrightarrow ad-bc=0$, $PA$ swaps rows, $(AB)^{\mathsf T}=B^{\mathsf T}A^{\mathsf T}$,
solution count), Part C 7× computation spanning all five lessons (solve $2\times2$ by elimination;
$3\times3$ row-reduce to $U$ with multipliers/pivots; $2\times2$ inverse via $ad-bc$; solve via
$A^{-1}\bb$; factor $A=LU$; two-sweep $L\cc=\bb$ then $U\xx=\cc$; $P$ + transpose/symmetric), Part D
2× extended response (singular matrix → 0/∞ solutions via elimination on $\bb$; $A^{\mathsf T}A$ always
symmetric via reversal rule). Practice test opens with a `remindbox`; keys wrap answers in `\ans{}`,
tag MC with $\leftarrow$, carry `teachernote` scoring. Practice and actual stay parallel (different
numbers, same difficulty); all arithmetic hand-verified. Built `make -C unit02/tests all` +
`make -C unit02/test_keys all` → clean; `drop` published practice test → `sample_test/main.pdf` and
practice key → `sample_test_key/main.pdf`. Page counts: blank tests 3pp each, practice key 3pp,
actual key 2pp (answers compress the work-room whitespace). Visually spot-checked practice_key p1–2
and actual_test p1 — clean. **Unit 2 is now fully authored & built. Next run begins Unit 3 (confirm
the §3.1–3.5 lesson map with the user first).**

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

**Unit 2 — lessons 2.0–2.4 AND the summative tests all authored & built. Unit 2 complete.**
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
- `unit02/lesson03` — id 2.3, **"Matrix Computations and A = LU"** (§2.3) ✅ authored (all components +
  keys + slides; both packets built). Content: $A=LU$ = elimination saved ($U$ = 2.1 result, $L$ =
  multipliers with $1$s on the diagonal, free — the 2.2 undo-matrices $E^{-1}$ gathered); check $LU=A$;
  solve in two triangular sweeps ($L\cc=\bb$ forward reproduces "update the RHS", then $U\xx=\cc$ back);
  cost angle (factor once, two sweeps per order). Reuses 2.2 bakery $A=\begin{bsmallmatrix}1&3\\2&7\end{bsmallmatrix}$
  → $(4,1)$; a $3\times3$ factorization; juice-bar multi-RHS contexts; homework extension
  $L=E_{21}^{-1}E_{31}^{-1}E_{32}^{-1}$; previews §2.4 $PA=LU$.
- `unit02/lesson04` — id 2.4, **"Permutations and Transposes"** (§2.4) ✅ authored (all components +
  keys + slides; both packets built). Content: permutation matrix $P$ (identity with rows swapped),
  row exchange, $PA$ swaps rows, $P^{\mathsf T}=P^{-1}$; the zero-pivot fix $PA=LU$ (2×2 → $L=I$, 3×3
  → nontrivial $L$); solving $A\xx=\bb$ via $PA\xx=P\bb$ and *why* a swap leaves $\xx$ unchanged;
  transpose $A^{\mathsf T}$, symmetric matrices, reversal rule $(AB)^{\mathsf T}=B^{\mathsf T}A^{\mathsf T}$;
  homework extension $A^{\mathsf T}A$ symmetric; previews Unit 2 test then Unit 3.
- `unit02/tests` (practice + actual) + `unit02/test_keys` (both keys) — **authored ✅ & built**;
  `sample_test`/`sample_test_key` populated by `drop` (practice test + key). `unit02/Makefile` present.

**Unit 3 — scaffolded (skeletons only), authoring not started.** Confirmed lesson map (6 lessons):
- `unit03/lesson00` — id 3.0, **"Sets of Vectors and the Road to Subspaces"** (intro) — ◐ scaffolded
- `unit03/lesson01` — id 3.1, **"Vector Spaces and Subspaces"** — ◐ scaffolded
- `unit03/lesson02` — id 3.2, **"The Nullspace of A: Solving Ax = 0"** — ◐ scaffolded
- `unit03/lesson03` — id 3.3, **"The Complete Solution to Ax = b"** — ◐ scaffolded
- `unit03/lesson04` — id 3.4, **"Independence, Basis, and Dimension"** — ◐ scaffolded
- `unit03/lesson05` — id 3.5, **"Dimensions of the Four Subspaces"** — ◐ scaffolded
- `unit03/tests` + `unit03/test_keys` (practice + actual, both keys) — ◐ scaffolded (skeletons);
  `sample_test`/`sample_test_key` drop dirs present. `unit03/Makefile` present.
- Each lesson has the full component set (cover, warmup, notes, activity, exit_ticket, homework,
  slides) + keys for the five keyed components — all still bare skeletons.
- Intro-lesson (3.0) title is a working title; refine during authoring. Bridge from Unit 2
  (solving $A\xx=\bb$) into the idea of a *space of vectors* / solution structure.

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ☑ all lessons + tests authored & built ✅ |
| 2 | Solving Linear Equations Ax = b | 2.0 intro + 2.1–2.4 | ☑ all lessons + tests authored & built ✅ |
| 3 | The Four Fundamental Subspaces | 3.0 intro + 3.1–3.5 | ◐ scaffolded (skeletons); authoring not started |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 3, in order.** Unit 3 is fully scaffolded (skeletons only). Start with
   `unit03/lesson00` (id 3.0) — author all components + keys from Strang §3.1 lead-in / Unit 2
   bridge, down-leveled — then `make -C unit03/lesson00 all`, proofread, and use it as the unit's
   model. Then author 3.1–3.5 the same way (each from its matching LAfE subchapter), then the
   summative tests (`unit03/tests` + `unit03/test_keys`, then `make ... drop` to publish the
   sample test/key). Mirror Unit 1–2 lessons for preamble, box usage, and tone.
2. *(optional)* Rebuild the whole Unit 1/Unit 2 packets (`make -C unitXX student|full`) to confirm the
   `sample_test`/`sample_test_key` merge in as expected before moving on.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
- In-formula answer-key slots use `{\color{keyred}\mathbf{...}}` inside math, never `\ans{}`
  (which is text-mode) — see the `bmatrix` fill-ins in `notes_key`.

## Open questions / decisions pending

- Lesson 1.0 was retitled to "Introducing Vectors — Vocabulary and Length" (was "Unit Overview
  and Spiral Review"). If a separate pure unit-overview lesson is wanted, flag it. Otherwise none.
