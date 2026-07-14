# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-13 — **Authored & built Unit 3 Lesson 3.4 — "Independence, Basis, and
Dimension" (§3.4).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket,
homework (+ the five keys) and the slides deck, mirroring 3.0–3.3's preamble/boxes/tone. **Content:**
(1) **independence** — vectors are independent iff the only combination equal to $\zero$ is all-zero
(no vector a combination of the others); dependent = a nontrivial combination gives $\zero$; geometry
(dependent = share a line/plane); (2) **the test is the nullspace** — stack vectors as columns of $A$:
independent $\iff N(A)=\{\zero\}$ ($r=n$, no free cols), dependent $\iff$ a nonzero special solution,
which *names* the redundancy; (3) **basis** = independent **and** spans — **pivot columns of $A$** (the
*original* columns) are a basis for $C(A)$, the **special solutions** are a basis for $N(A)$, standard
$\mathbf{e}_i$ for $\mathbb{R}^n$; (4) **dimension** = size of any basis (well-defined): $\dim C(A)=r$,
$\dim N(A)=n-r$, with $r+(n-r)=n$; dimension = independent directions = "degrees of freedom." Running
matrix reuses 3.2/3.3's $A=[[1,1,2],[1,2,3]]$: $r=2$, special solution $\svec=(-1,-1,1)$ literally
encodes $\mathbf{a}_3=\mathbf{a}_1+\mathbf{a}_2$ (the column dependency) — a clean tie-back. **Robot-arm
"how many levers does it really have?"** hook (redundant lever = dependent column → degrees of freedom).
Activity Tier A reads basis+dim for $C(A)$ and $N(A)$ off one reduction (1-free and 2-free cases), Tier E
proves "more than $n$ ⇒ dependent," minimal-spanning/maximal-independent, and well-definedness; homework
adds "read the dependency from $\svec$" and the square-case "n independent ⇒ spans." All arithmetic
hand-verified; keys use `\ans{}`/`\ansline{}` and `{\color{keyred}\mathbf{...}}` slots. Built
`make -C unit03/lesson04 all` → clean. **Build gotchas (both fixed):** (a) lesson-plan `\textbf{Worked
($A=\begin{bsmallmatrix}...\\...\end{bsmallmatrix}$)}` errored ("Forbidden control sequence ...
\check@nocorr@") — the `\\` in a matrix inside `\textbf{}` is illegal; moved the math **outside** the
bold. (b) lesson plan used `\cc` and homework_key used `\bb` without defining those per-file macros
(the recurring "each component defines its own vector macros" trap) — added them. Page counts match the
3.3 profile: cover/warmup/exit 1pp, notes/activity/homework 2pp (blank & key match), slides 7pp; student
9pp, full 19pp. **Lesson plan is 3pp** here (3.3 was 2pp) because I added the canonical **Explicit
Instruction** box ("Basis & Dimension from One Reduction"); teacher-facing, no one-page constraint, left
as-is. Visually spot-checked notes_key p1–2, activity_key p1, lesson-plan p3 — clean. Next run authors
3.5 (Dimensions of the Four Subspaces).

**Prior run:** Authored & built Unit 3 Lesson 3.3 — "The Complete Solution to $A\xx=\bb$" (§3.3). Complete
solution $\xx=\xx_p+\xx_n$ (one particular + whole nullspace); find $\xx_p$ by reducing $[A\mid\bb]$ (free
vars 0); shifted line/plane parallel to $N(A)$ (subspace only if $\bb=\zero$); solvability $\bb\in C(A)$
(zero row vs nonzero RHS = $0=$nonzero); solution count by rank. Reused $A=[[1,1,2],[1,2,3]]$, $\xx_p=(1,2,0)$,
$\svec=(-1,-1,1)$. Robot-arm "hit the target" hook. Same page profile (student 9pp, full 18pp).

**Earlier run:** Authored & built Unit 3 Lesson 3.2 — "The Nullspace of $A$: Solving $A\xx=\zero$" (§3.2).
Nullspace $N(A)=\{\xx:A\xx=\zero\}$ as a subspace of $\mathbb{R}^n$ (inputs, vs. $C(A)\subseteq\mathbb{R}^m$);
solve $A\xx=\zero$ by elimination; pivot vs. free columns/variables; special solutions (free var $=1$,
solve back); $N(A)$ = all combinations, free count $n-r$; point/line/plane by $n-r$. Robot-lever
"do-nothing settings" hook. Build gotcha: `\ss` macro collides with LaTeX's ß → renamed `\svec`. Same
page profile (student 9pp, full 18pp).

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

**Unit 3 — lessons 3.0–3.4 authored & built; 3.5–3.6 + tests still skeletons.** Confirmed lesson map (6 lessons):
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
- `unit03/lesson05` — id 3.5, **"Dimensions of the Four Subspaces"** — ◐ scaffolded
- `unit03/lesson06` — id 3.6, **"The Fundamental Theorem of Linear Algebra"** (capstone, added by
  user 2026-07-13) — ◐ scaffolded. Synthesizes the unit: Strang's **Part 1** (dimensions/counting
  of the four subspaces — rank $r$, row space $r$, nullspace $n-r$, left-nullspace $m-r$) and the
  "big picture" diagram, previewing **Part 2** (orthogonality) → Unit 4 §4.1. Author *after* 3.1–3.5.
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
| 3 | The Four Fundamental Subspaces | 3.0 intro + 3.1–3.5 + 3.6 capstone (FTLA) | ◐ 3.0–3.4 authored & built ✅; 3.5–3.6 + tests still skeletons |
| 4 | Orthogonality | 4.1–4.4 | ☐ |
| 5 | Determinants and Linear Transformations | 5.1–5.3 | ☐ |
| 6 | Eigenvalues and Eigenvectors | 6.1–6.4 (§6.4 optional) | ☐ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 3, in order — 3.0–3.4 done.** Next author `unit03/lesson05` (id 3.5, **Dimensions of the
   Four Subspaces**) from Strang §3.5 — the four fundamental subspaces of $A$ ($m\times n$, rank $r$):
   column space $C(A)\subseteq\mathbb{R}^m$ ($\dim r$), row space $C(A^{\mathsf T})\subseteq\mathbb{R}^n$
   ($\dim r$ — same $r$, "row rank = column rank"), nullspace $N(A)\subseteq\mathbb{R}^n$ ($\dim n-r$),
   left nullspace $N(A^{\mathsf T})\subseteq\mathbb{R}^m$ ($\dim m-r$); read bases off the reduced form.
   Builds directly on 3.4 (basis/dimension via one reduction). Mirror 3.0–3.4 for preamble, boxes, and
   tone. Then the **capstone `unit03/lesson06` (id 3.6, The Fundamental Theorem of Linear Algebra)** —
   synthesize the four subspaces + their dimensions (Strang Part 1 + the big-picture diagram), preview
   orthogonality (Part 2 → Unit 4). Finish with the summative tests (`unit03/tests` + `unit03/test_keys`,
   then `make ... drop` to publish the sample test/key). The unit test should now also draw on 3.6's
   synthesis.
2. *(optional)* Rebuild the whole Unit 1/Unit 2 packets (`make -C unitXX student|full`) to confirm the
   `sample_test`/`sample_test_key` merge in as expected before moving on.

## Notes for the next run

- **TikZ gotcha (hit + fixed in 1.0):** font size inside a `\node[...]` must be `font=\scriptsize`,
  **not** a bare `scriptsize` key (that errors: "I do not know the key '/tikz/scriptsize'").
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
