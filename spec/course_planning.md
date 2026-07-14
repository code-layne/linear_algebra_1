# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-14 — **Scaffolded all of Unit 4 (Orthogonality) — skeletons only, no content authored yet.**
Ran `new_lesson.py` for lessons 4.0–4.4 (component set: cover, warmup, notes, activity, exit_ticket, homework,
slides + keys for keyed components). The 4.0 run created the unit, so `unit04/tests/` (practice + actual),
`unit04/test_keys/` (both keys), `unit04/sample_test/`, `unit04/sample_test_key/`, `unit04/Makefile`, and the
thin-include test Makefiles were all auto-scaffolded too. **Confirmed lesson map (5 lessons):** 4.0 "Right Angles
Revisited --- Setting Up Orthogonality" (intro/spiral) · 4.1 "Orthogonality of the Four Subspaces" · 4.2
"Projections onto Subspaces" · 4.3 "Least Squares Approximations" · 4.4 "Orthogonal Matrices and Gram--Schmidt" —
matches `spec/linear_algebra_v2.md` §4.1–4.4 exactly plus the customary `lesson00` intro. Title macros interpolate
correctly (`\UnitNumberName`=Unit 4: Orthogonality; per-lesson `\LessonNumberName`). **Nothing authored yet** —
every `main.tex` is still the scaffolder skeleton. **Next run: author lesson-by-lesson starting with 4.0**, then
build. `sample_test`/`sample_test_key` PDFs are NOT yet populated (they come from `drop` after the tests are
authored). Unit 4 is the natural continuation of Unit 3's FTLA (§3.6 already set up orthogonal complements).

**Prior run:** **Authored & built the Unit 3 summative tests — Unit 3 is now complete.**
Filled all four skeletons (`tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`,
`test_keys/actual_test_key`), mirroring the Unit 1/Unit 2 test format (`shared/tests.mk` + `test_keys.mk`;
`\parthead` burgundy strips; Part A vocab matching / B multiple choice / C computation / D extended
response). **Blueprint spans the whole unit:** A (8 terms — subspace, nullspace, column space, special
solution, independence, basis, dimension, rank), B (6 MC concept checks across 3.1–3.6), C (7 items — closure
test 3.1; special solutions + $\dim N(A)$ 3.2; complete solution $\xx_p+\xx_n$ 3.3; solvability $\bb\in C(A)$
3.3; independence/basis/rank 3.4; four-subspace dims $r,n-r,r,m-r$ 3.5; orthogonality dot-product right-angle
check 3.6), D (2 items — off-origin line is not a subspace; FTLA orthogonality synthesis). **Practice test
reuses the 3.5/3.6 spine** $A=[[1,1,2],[2,1,3],[3,2,5]]$ (RREF $[[1,0,1],[0,1,1],[0,0,0]]$, $\svec=(-1,-1,1)$,
col3=col1+col2) for continuity; **actual test uses a parallel-but-distinct** $B=[[1,2,1],[2,4,3],[3,6,4]]$
(RREF $[[1,2,0],[0,0,1],[0,0,0]]$, $\svec=(-2,1,0)$, col2=2·col1 → free variable in the *middle*, so students
can't pattern-match). All matrix answers hand-verified in Python (rref, augmented solvability, orthogonality
dot products all $0$). Built `make -C unit03/tests all` and `make -C unit03/test_keys all` → clean (0 `^!`
errors; only overfull is the shared 10.77pt `\namedateperiod` header). Each of the four PDFs is **3pp**;
`drop` published `sample_test/main.pdf` (practice, 3pp) and `sample_test_key/main.pdf` (practice key, 3pp).
Visually spot-checked the practice key p1 (vocab matching + MC marks) and p3 (Part D + teachernote) — clean.
**Gotcha fixed:** the D2 answer uses `\vv` for a generic vector ($\vv\cdot\vv=0\Rightarrow\vv=\zero$), but the
test/key preambles only defined `\bb\xx\zero\svec\T` — added `\newcommand{\vv}{\mathbf{v}}` to both keys.
**Unit 3 is now fully complete (lessons 3.0–3.6 + tests); next run begins Unit 4 (Orthogonality).**

**Prior run:** **Authored & built Unit 3 Lesson 3.6 — "The Fundamental Theorem of
Linear Algebra" (§3.6, the Unit 3 capstone).** Filled every skeleton: lesson plan, cover, warmup, notes,
activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring 3.0–3.5's preamble/boxes/tone.
**Content — synthesis of the whole unit in two parts:** (1) **the big picture** — assemble the four subspaces
into one two-room diagram; **Part 1** = the dimensions from $r$ ($r$, $n-r$, $r$, $m-r$; recap of 3.5); (2)
**Part 2 = orthogonality (the new idea)** — $A\xx=\zero$ computed **row by row** says every row $\cdot\,\xx=0$,
so $\xx\perp$ every row ⇒ $N(A)\perp C(A^{\mathsf T})$ in $\mathbb{R}^n$; transpose ⇒ $N(A^{\mathsf T})\perp C(A)$
in $\mathbb{R}^m$; the pair in each room are **orthogonal complements** (perpendicular + dims fill the room +
meet only at $\zero$ since $\vv\cdot\vv=0\Rightarrow\vv=\zero$). The lesson explicitly reduces Part 2 to
Lesson 1.2 ("dot $=0$ ⇔ perpendicular") — no new machinery. **Reused the 3.5 spine matrix** $A=[[1,1,2],[2,1,3],[3,2,5]]$
→ $[[1,0,1],[0,1,1],[0,0,0]]$, $r=2$, $\svec=(-1,-1,1)$, $\yy=(1,1,-1)$; orthogonality hand-verified in
Python (all dot products $0$: rows·$\svec$, cols·$\yy$). Activity/HW use fresh singular $3\times3$ and the
$3\times4$ (two null vectors) so students check a right angle against a **whole basis**. **Big-picture two-room
TikZ diagram** (burgundy input $\mathbb{R}^n$ / blue output $\mathbb{R}^m$, $\perp$ on each divider) on notes §1
+ slides hook. **Robot-arm "the whole machine in one picture"** hook. Previews **Unit 4 (Orthogonality:
projection, least squares)**. Built `make -C unit03/lesson06 all` → clean (no `^!` errors; only overfull is the
shared 10.77pt `\namedateperiod` header, present in every lesson). Page counts: cover/warmup/exit 1pp (blank &
key), notes 3pp (blank & key), activity/homework 2pp (blank & key), slides 6pp, lesson plan 3pp; student 10pp,
full 19pp. **Gotcha fixed:** in a TikZ node a bare color name (e.g. `burgundy`) resets `fill`, so `$\perp$`
rendered as a solid "tofu" box — use `text=<color>` (keep `fill=white`) instead; `\perp` renders fine in body
math. Visually spot-checked notes p1/p2 (diagram + Part 2) and the slides hook — clean. New per-file macro
`\aaa` (matrix column) added where used. **Unit 3 lessons complete; next run authors the Unit 3 tests.**

**Prior runs:** 3.5 "Dimensions of the Four Subspaces" — the four subspaces across two rooms, all dims from
$r$ (row rank = column rank), all four bases from one reduction, two nullspaces = column vs row redundancy;
spine matrix, non-square activity; macros `\T`, `\yy`. 3.4 "Independence, Basis, and Dimension" — independence
$\iff N(A)=\{\zero\}$, basis = independent + spans, dimension = basis size; gotcha: `\\` in a matrix inside
`\textbf{}` is illegal. 3.3 — complete solution $\xx=\xx_p+\xx_n$, solvability $\bb\in C(A)$. 3.2 — nullspace
$N(A)$, special solutions, $\dim N(A)=n-r$ (macro `\ss` collides with ß → use `\svec`).

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

**Unit 3 — COMPLETE: lessons 3.0–3.6 AND the summative tests all authored & built.** Confirmed lesson map (6 lessons):
- `unit03/lesson00` — id 3.0, **"Sets of Vectors and the Road to Subspaces"** (intro) — ✅ authored
  & built (all components + keys + slides). Content: $\mathbb{R}^n$ \& span (recall); subspace =
  closed under $+$/scaling (contains $\zero$) via the closure test; geometric catalog (lines/planes
  through the origin yes, off-origin line \& first quadrant no); $C(A)$ as a subspace (renames Unit~2
  reachability); nullspace preview ($A\xx=\zero$). Serves as the Unit 3 model.
- `unit03/lesson01` — id 3.1, **"Vector Spaces and Subspaces"** (§3.1) — ✅ authored & built (all
  components + keys + slides). Content: **vector space** (closed under $+$/scaling + usual rules,
  $\mathbb{R}^n$ the model); **subspace** = subset that is itself a vector space ⇒ the two-part
  subspace requirement; "$\zero$ necessary but not sufficient" with the union-of-axes counterexample
  (fails addition); the catalog ($\mathbb{R}^2$/$\mathbb{R}^3$); the precise $C(A)$-is-a-subspace
  proof via $A(\xx+\yy)=A\xx+A\yy$. Robot-arm reachable-set hook; extension widens "vector space" to
  $2\times2$ matrices. Previews 3.2 (nullspace).
- `unit03/lesson02` — id 3.2, **"The Nullspace of A: Solving Ax = 0"** — ✅ authored & built (all
  components + keys + slides). Content: **nullspace** $N(A)=\{\xx:A\xx=\zero\}$, a subspace of
  $\mathbb{R}^n$ (inputs — contrast $C(A)\subseteq\mathbb{R}^m$); solving $A\xx=\zero$ by elimination;
  **pivot vs. free columns/variables**; **special solutions** (free var $=1$, solve back); $N(A)$ = all
  combinations, free count $=n-r$; **point/line/plane** by $n-r$. Robot-lever "do-nothing settings"
  hook (reuses 3.1's $A=[[1,2],[2,4]]$). Extension: nonzero nullspace ⇔ dependent columns, and
  $N(A)=\{\zero\}$ ⇔ invertible. Previews 3.3 (particular + nullspace). Macro gotcha: `\ss` collides
  with LaTeX's built-in ß → renamed `\svec`.
- `unit03/lesson03` — id 3.3, **"The Complete Solution to Ax = b"** — ✅ authored & built (all
  components + keys + slides). Content: **complete solution** $\xx=\xx_p+\xx_n$ (one particular solution
  $+$ the whole nullspace); why it captures every solution ($A(\xx_p+\xx_n)=\bb$); finding $\xx_p$ by
  reducing $[A\mid\bb]$ (free vars $=0$); the **shifted** solution set (line/plane parallel to $N(A)$, off
  origin unless $\bb=\zero$ — so *not* a subspace); **solvability** $\bb\in C(A)$ (zero row vs. nonzero RHS
  = $0=$nonzero); solution count by rank. Reuses 3.2's $A=[[1,1,2],[1,2,3]]$, $\bb=(3,5)$, $\xx_p=(1,2,0)$,
  $\svec=(-1,-1,1)$. Robot-arm "hit the target" hook. Previews 3.4 (basis/dimension).
- `unit03/lesson04` — id 3.4, **"Independence, Basis, and Dimension"** — ✅ authored & built (all
  components + keys + slides). Content: **linear independence** (only the trivial combination gives
  $\zero$; no vector a combination of the others); the **test is the nullspace** (columns independent
  $\iff N(A)=\{\zero\}$; a special solution names the redundancy); **basis** = independent $+$ spans (pivot
  columns of $A$ for $C(A)$, special solutions for $N(A)$, standard $\mathbf{e}_i$ for $\mathbb{R}^n$);
  **dimension** = size of any basis, $\dim C(A)=r$, $\dim N(A)=n-r$, $r+(n-r)=n$. Running matrix reuses
  3.2/3.3's $A=[[1,1,2],[1,2,3]]$ ($\svec=(-1,-1,1)$ encodes $\mathbf{a}_3=\mathbf{a}_1+\mathbf{a}_2$).
  Robot-arm "how many levers does it really have?" (degrees-of-freedom) hook. Extension: more than $n$ in
  $\mathbb{R}^n$ ⇒ dependent; basis is min-spanning/max-independent; in the square case $n$ independent ⇒
  spans. Previews 3.5 (four subspaces). Lesson plan runs 3pp (added Explicit Instruction box).
- `unit03/lesson05` — id 3.5, **"Dimensions of the Four Subspaces"** — ✅ authored & built (all
  components + keys + slides). Content: the **four fundamental subspaces** of an $m\times n$ matrix (rank
  $r$) split across two rooms — input $\mathbb{R}^n$ holds row space $C(A^{\mathsf T})$ ($\dim r$) and
  nullspace $N(A)$ ($\dim n-r$); output $\mathbb{R}^m$ holds column space $C(A)$ ($\dim r$) and left
  nullspace $N(A^{\mathsf T})$ ($\dim m-r$). **Row rank = column rank**; two counting rules $r+(n-r)=n$,
  $r+(m-r)=m$; all four bases from one reduction; the two nullspaces name column vs. row redundancies. Spine
  $A=[[1,1,2],[2,1,3],[3,2,5]]$ → $[[1,0,1],[0,1,1],[0,0,0]]$, $\svec=(-1,-1,1)$, $\yy=(1,1,-1)$; activity
  uses non-square $2\times3$/$3\times4$. Two-room robot-arm hook. Previews 3.6 (FTLA). New macros `\T`,
  `\yy` per file.
- `unit03/lesson06` — id 3.6, **"The Fundamental Theorem of Linear Algebra"** (capstone) — ✅ authored
  & built (all components + keys + slides). Synthesizes the unit into the **big picture**: **Part 1**
  (the four dimensions $r,\,n-r,\,r,\,m-r$, recap of 3.5) and **Part 2 (new)** orthogonality —
  $A\xx=\zero$ row-by-row ⇒ $\xx\perp$ every row ⇒ $N(A)\perp C(A^{\mathsf T})$, and (transpose)
  $N(A^{\mathsf T})\perp C(A)$; the pairs are **orthogonal complements**. Reduces Part 2 to Lesson 1.2
  (dot $=0$ ⇔ perpendicular). Reuses the 3.5 spine matrix; two-room TikZ big-picture diagram (notes §1 +
  slides). Previews **Unit 4 (Orthogonality)**.
- `unit03/tests` (practice + actual) + `unit03/test_keys` (both keys) — **authored ✅ & built**;
  `sample_test`/`sample_test_key` populated by `drop` (practice test + key, 3pp each). `unit03/Makefile` present.
- All six lessons (3.0–3.6) have the full authored component set (cover, warmup, notes, activity,
  exit_ticket, homework, slides) + keys. **Unit 3 has nothing left — lessons and tests all done.**

### Per-unit progress

Status legend: ☐ not started · ◐ in progress · ☑ complete

| Unit | Chapter | Lessons | Status |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ☑ all lessons + tests authored & built ✅ |
| 2 | Solving Linear Equations Ax = b | 2.0 intro + 2.1–2.4 | ☑ all lessons + tests authored & built ✅ |
| 3 | The Four Fundamental Subspaces | 3.0 intro + 3.1–3.5 + 3.6 capstone (FTLA) | ☑ all lessons + tests authored & built ✅ |
| 4 | Orthogonality | 4.0 intro + 4.1–4.4 | ◐ all lessons + tests **scaffolded** (skeletons only); authoring not started |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 4 lesson-by-lesson, starting with 4.0** (all skeletons already scaffolded on disk).
   Read each `unit04/lessonYY/**/main.tex` skeleton with the Read tool before writing it, then fill it
   following `references/components.md`. Planned content per lesson (down-level from LAfE Ch. 4):
   - **4.0** intro/spiral — recall dot product & perpendicular ($\vv\cdot\ww=0$, Lesson 1.2), length/unit
     vectors, and the FTLA orthogonal-complement picture (§3.6); roadmap projection → least squares → $Q$.
   - **4.1** Orthogonality of the four subspaces — $C(A^{\mathsf T})\perp N(A)$ and $C(A)\perp N(A^{\mathsf T})$
     as *orthogonal complements* (each pair fills its room); extends §3.6 with the "why perpendicular."
   - **4.2** Projections onto subspaces — projection onto a line ($\hat\xx=\frac{\aa\cdot\bb}{\aa\cdot\aa}\aa$),
     then onto a subspace; projection matrix $P=A(A^{\mathsf T}A)^{-1}A^{\mathsf T}$; error $\bb-\pp\perp$ the space.
   - **4.3** Least squares — best-fit line on real data; the **normal equations** $A^{\mathsf T}A\hat\xx=A^{\mathsf T}\bb$;
     minimize the error; the U4 guided application (fit a line, then interpret).
   - **4.4** Orthogonal matrices & Gram–Schmidt — orthonormal vectors, $Q^{\mathsf T}Q=I$, why $Q$ makes
     projection/least-squares trivial; Gram–Schmidt to build $Q$; the factorization $A=QR$.
   Build each with `make -C unit04/lessonYY all`; verify warmup/exit are 1pp (blank & key).
2. **Then author the Unit 4 summative tests** (`unit04/tests/{practice,actual}_test`, `unit04/test_keys/…`),
   mirroring the Unit 1–3 format, and `drop` to populate `sample_test`/`sample_test_key`.
3. *(optional)* Rebuild the whole Unit 1/Unit 2/Unit 3 packets (`make -C unitXX student|full`) to confirm the
   `sample_test`/`sample_test_key` merge in as expected before moving on.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
- **TikZ gotcha (hit + fixed in 3.6):** in a `\node`, a **bare color name** (e.g. `burgundy`) is
  `color=`, which resets `fill` too — so `\node[fill=white, burgundy] {$\perp$}` fills the box with
  burgundy and the glyph renders as a solid "tofu" square. Use `text=<color>` (keeps `fill=white`):
  `\node[fill=white, text=burgundy, inner sep=1.2pt] {$\perp$}`. (`\perp` renders fine in body math.)
- In-formula answer-key slots use `{\color{keyred}\mathbf{...}}` inside math, never `\ans{}`
  (which is text-mode) — see the `bmatrix` fill-ins in `notes_key`.
- **Per-file `\vv\ww\xx\yy\bb\zero` macros are NOT shared** — each component defines its own in the
  preamble. If a body uses `\bb` (or any such macro) but the preamble omits it → "Undefined control
  sequence" (hit in 3.1 activity). Define every math-vector macro the body uses.
- **Do NOT name a macro `\ss`** — it's LaTeX's built-in ß, so `\newcommand{\ss}` errors "Command
  already defined" (hit in 3.2 for the special-solution vector). Use `\svec` (or similar). Watch for a
  key that uses a macro the blank doesn't define, too (3.2 exit_ticket_key used `\ss` in math without
  a def). Same trap for **`\aa`** (built-in å) and **`\cc`** — `\cc` is *not* a built-in, so defining
  it is fine, but you must define it per-file (3.4 lesson plan used `\cc` undefined).
- **`\\` inside a matrix inside `\textbf{}`/`\emph{}` is illegal** — errors "Forbidden control sequence
  found while scanning use of \check@nocorr@" (hit in 3.4 lesson plan: `\textbf{Worked ($A=\begin{bsmallmatrix}
  1\\2\end{bsmallmatrix}$)}`). Fix: keep the math (with its `\\`) **outside** the bold/italic argument —
  `\textbf{Worked} ($A=...$)`. Bold math \emph{without} a `\\` (e.g. `\textbf{Basis for $C(A)$:}`) is fine.

## Open questions / decisions pending

- Lesson 1.0 was retitled to "Introducing Vectors — Vocabulary and Length" (was "Unit Overview
  and Spiral Review"). If a separate pure unit-overview lesson is wanted, flag it. Otherwise none.
