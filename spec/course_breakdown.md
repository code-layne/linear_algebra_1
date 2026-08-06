# Linear Algebra — Unit & Lesson Breakdown

The full map of the course as it exists on disk: eight units, **41 lessons**, eight unit test
pairs, and one cumulative final. Structure comes from `spec/linear_algebra_v2.md`; all
mathematics comes from **Gilbert Strang, _Linear Algebra for Everyone_** (Wellesley–Cambridge,
2020), down-leveled for a secondary audience. Design notes and philosophy live in
`spec/linear_algebra_v2.md`; running build state lives in `spec/course_planning.md`.

---

## Structural conventions

- **A unit is a chapter of the book; a lesson is a subchapter.** Lesson id is `<unit>.<n>`,
  matching the book's section number, and the directory is `unitXX/lessonYY/`.
- **Every unit opens with an on-ramp lesson `X.0`** — a course invention with no counterpart
  in the book. It rebuilds the prerequisite skills the chapter assumes, previews the unit's
  destination, and lets the college-level chapter open at a secondary-school entry point.
  Directory `lesson00/`.
- **Unit 3 carries one extra lesson, 3.6** (The Fundamental Theorem of Linear Algebra), a
  capstone that assembles §3.1–3.5 into the big picture. Also not a book section.
- Both additions are deviations from the spec's course map in `spec/linear_algebra_v2.md`,
  which lists only the book's own sections.

**Per lesson** (`unitXX/lessonYY/`): a teacher lesson plan, a cover, and five student
components — warm-up, notes, activity, exit ticket, homework — each with an answer key, plus a
slide deck. These build into five products: `_plan`, `_slides` (3-up print), `_slides.pptx`
(projected), `_student`, `_key`.

**Per unit** (`unitXX/`): a practice test and an actual test, each with a key
(`tests/`, `test_keys/`), and an optional cover pair (`unit_cover/`, `unit_cover_key/`).
The practice test is bound into the student packet; the actual test never is.

**Course-wide**: `finals/` — a cumulative practice final and real final, each with a key.

---

## The course at a glance

| Unit | Title (Strang chapter) | Lessons | Role |
| --- | --- | --- | --- |
| 1 | Vectors and Matrices | 1.0 + 1.1–1.4 (5) | core |
| 2 | Solving Linear Equations $Ax=b$ | 2.0 + 2.1–2.4 (5) | core |
| 3 | The Four Fundamental Subspaces | 3.0 + 3.1–3.5 + 3.6 (7) | core |
| 4 | Orthogonality | 4.0 + 4.1–4.4 (5) | core |
| 5 | Determinants and Linear Transformations | 5.0 + 5.1–5.3 (4) | core |
| 6 | Eigenvalues and Eigenvectors | 6.0 + 6.1–6.4 (5) | core (§6.4 optional) |
| 7 | The Singular Value Decomposition | 7.0 + 7.1–7.4 (5) | advanced / optional |
| 8 | Learning from Data | 8.0 + 8.1–8.4 (5) | enrichment — **not assessed** |

**Core sequence is Units 1–6.** The book's preface allows a short-course path that jumps from
dimensions (§3.5) straight to eigenvalues, compressing Units 4–5 if time is short. Unit 8 is
explored, not tested — the book itself states it is included with no expectation of testing.

---

## Unit 1 — Vectors and Matrices

*Strang Ch. 1. The whole course in miniature: a vector, a combination of vectors, and a matrix
as the columns you combine.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 1.0 | Introducing Vectors — Vocabulary and Length | describe a vector by components and as an arrow, add and scale it, and compute $\|v\|=\sqrt{v_1^2+v_2^2}$ as straight-line distance |
| 1.1 | Linear Combinations of Vectors | build $c v + d w$ and say which points a set of vectors reaches — one vector fills a line, two non-parallel vectors fill the plane |
| 1.2 | Lengths and Angles from Dot Products | compute $v\cdot w$ and read it geometrically: length is $\sqrt{v\cdot v}$, angle from $\cos\theta$, and **zero means perpendicular** |
| 1.3 | Matrices and Column Spaces | read $Ax$ as a combination of $A$'s columns and describe the column space $C(A)$ — every $b$ the columns can build |
| 1.4 | Matrix Multiplication and $A=CR$ | multiply by columns, factor $A=CR$ (independent columns × recipe), and read off the **rank** |

**Big ideas:** a matrix is its columns; $Ax$ is a combination of them; rank counts the
independent ones. **Applications:** data records as vectors; similarity via dot product.

---

## Unit 2 — Solving Linear Equations $Ax=b$

*Strang Ch. 2. Elimination as the algorithm, then elimination stored as a factorization.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 2.0 | From Combinations to Solutions — Setting Up $Ax=b$ | read $Ax=b$ both as a column combination and as a system, solve a $2\times2$, and interpret one / none / infinitely many solutions geometrically |
| 2.1 | The Idea of Elimination | eliminate with pivots and multipliers to reach upper-triangular form, finish by back-substitution, and explain when a row exchange is needed |
| 2.2 | Elimination Matrices and Inverse Matrices | write one elimination step as a matrix $E$, undo it with $E^{-1}$, build $A^{-1}$ by $ad-bc$ and by Gauss–Jordan, and explain why a singular matrix has none |
| 2.3 | Matrix Computations and $A=LU$ | factor $A=LU$ ($U$ = elimination's result, $L$ = the stored multipliers) and solve in two triangular sweeps — factor once, reuse for every $b$ |
| 2.4 | Permutations and Transposes | fix a zero pivot with a permutation matrix ($PA=LU$), transpose, recognize symmetry, and apply $(AB)^\top=B^\top A^\top$ |

**Big ideas:** elimination is systematic, reversible, and storable. **Applications:** mixtures
and networks as systems.

---

## Unit 3 — The Four Fundamental Subspaces

*Strang Ch. 3. The structural heart of the course — where "solve it" becomes "describe all
solutions."*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 3.0 | Sets of Vectors and the Road to Subspaces | see all combinations of some vectors as a line or plane **through the origin**, and recast Unit 2's "is $b$ reachable?" as "is $b$ in a subspace?" |
| 3.1 | Vector Spaces and Subspaces | apply the subspace test (closed under addition and scaling, so it contains $0$), catalog the subspaces of $\mathbb{R}^2,\mathbb{R}^3$, and prove $C(A)$ is one |
| 3.2 | The Nullspace of $A$: Solving $Ax=0$ | find pivot and free columns, build a special solution per free variable, and count $n-r$ to know if $N(A)$ is a point, line, or plane |
| 3.3 | The Complete Solution to $Ax=b$ | combine a particular solution with the nullspace ($x = x_p + x_n$) and read the solution set as the nullspace shifted off the origin |
| 3.4 | Independence, Basis, and Dimension | test independence via $Ax=0$, build bases (pivot columns for $C(A)$, special solutions for $N(A)$), and state $\dim C(A)=r$, $\dim N(A)=n-r$ |
| 3.5 | Dimensions of the Four Subspaces | name all four subspaces, get every dimension from the single number $r$, and read bases for all four off **one** reduction |
| 3.6 | The Fundamental Theorem of Linear Algebra *(capstone)* | assemble the big picture — Part 1 (the dimensions) and Part 2 (each room splits into **orthogonal complements**) |

**Big ideas:** rank $r$ determines everything; solution structure is particular + nullspace.
**Applications:** when systems have no / one / many solutions.

---

## Unit 4 — Orthogonality

*Strang Ch. 4. Right angles turn into a method: the closest point.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 4.0 | Right Angles Revisited — Setting Up Orthogonality | rebuild dot product, length, and unit vectors, and see why the four subspaces come in perpendicular pairs |
| 4.1 | Orthogonality of the Four Subspaces | test subspace orthogonality, derive $N(A)\perp C(A^\top)$ by reading $Ax=0$ one row at a time, and define orthogonal complement |
| 4.2 | Projections onto Subspaces | project onto a line or subspace by forcing the error perpendicular — $\hat{x}=\frac{a\cdot b}{a\cdot a}$, then the normal equations $A^\top A\hat{x}=A^\top b$ |
| 4.3 | Least Squares Approximations | fit $y=C+Dt$ to non-collinear data as a **projection**, read fitted values and residuals, and justify why the best line has perpendicular residual |
| 4.4 | Orthogonal Matrices and Gram–Schmidt | recognize orthonormal columns and $Q^\top Q=I$, collapse the normal equations to $\hat{x}=Q^\top b$, and run Gram–Schmidt |

**Big ideas:** "closest" means "error perpendicular"; orthonormal columns make everything free.
**Applications:** best-fit line on real data.

---

## Unit 5 — Determinants and Linear Transformations

*Strang Ch. 5. One number that reports area, orientation, and invertibility — then the matrix
as a motion.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 5.0 | Setting Up Determinants — the $2\times2$ Determinant, Area, and Orientation | compute $ad-bc$ and read it as **area** (magnitude) and **orientation** (sign); $\det=0$ collapses the parallelogram and kills the inverse |
| 5.1 | $3\times3$ Determinants | expand by cofactors with the $+\,-\,+$ pattern, read $|\det A|$ as the **volume** of the box, and use the triangular shortcut |
| 5.2 | Properties and Applications of Determinants | use the properties instead of expanding — a shear leaves $\det$ unchanged, so $\det A=\pm$(product of pivots) — plus the product rule $\det(AB)=\det A\det B$ |
| 5.3 | Linear Transformations | read a matrix as a motion of the plane (stretch, rotation, reflection, shear) and use $|\det A|$ as the **area scale factor**, sign as orientation |

**Big ideas:** the determinant is geometry compressed to one number. **Applications:**
geometric transformations of the plane.

---

## Unit 6 — Eigenvalues and Eigenvectors

*Strang Ch. 6. The directions along which a matrix acts like a plain number.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 6.0 | Special Directions — Setting Up Eigenvalues | recognize $Ax=\lambda x$ — the output lands on the same line — verify a candidate eigenvector, and connect $\lambda=0$ to $\det A=0$ |
| 6.1 | Introduction to Eigenvalues | find them from scratch: $(A-\lambda I)x=0$ forces $\det(A-\lambda I)=0$; solve the characteristic equation, then the eigenvectors; check with trace and determinant |
| 6.2 | Diagonalizing a Matrix | build $A=X\Lambda X^{-1}$, compute powers via $A^k=X\Lambda^k X^{-1}$, and decide when a matrix **cannot** be diagonalized |
| 6.3 | Symmetric Positive Definite Matrices | use $S=Q\Lambda Q^\top$ (real eigenvalues, perpendicular eigenvectors), test positive definiteness ($\lambda>0$, or $a>0$ and $ac-b^2>0$), read it as positive energy |
| 6.4 | Systems of Differential Equations *(advanced/optional)* | solve $du/dt = Au$ by splitting the start into eigenvectors and letting each run at its own rate; read growth / decay / stability from the signs |

**Big ideas:** eigenvectors are the natural coordinates; the spectral theorem is the payoff.
**Applications:** steady states, population and state models.

---

## Unit 7 — The Singular Value Decomposition *(advanced / optional)*

*Strang Ch. 7. What Unit 6 could not do for every matrix, this does for all of them.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 7.0 | Setting Up the SVD | see a matrix stretch the unit circle into an ellipse whose half-widths are the singular values, and name $A=U\Sigma V^\top$ as rotate–stretch–rotate |
| 7.1 | Singular Values and Singular Vectors | find them with the $A^\top A$ recipe: $\sigma_i=\sqrt{\lambda_i}$, $v_i$ from $A^\top A$, $u_i=Av_i/\sigma_i$ — and justify why it always works |
| 7.2 | Compressing Images by the SVD | write $A$ as ordered rank-1 layers $\sigma_i u_i v_i^\top$, keep the biggest $k$, and justify the choice by energy $\sigma^2$ versus storage |
| 7.3 | Principal Component Analysis | center a data table, read $A^\top A$'s eigenvectors as principal components, and measure the fraction of spread the first captures |
| 7.4 | The Victory of Orthogonality | tie it together: $Q^\top Q=I$ gives a free inverse and preserved length, so all stretching lives in $\Sigma$ |

**Big ideas:** every matrix has an SVD; the largest singular values carry the information.
**Applications:** image compression, data summarization.

---

## Unit 8 — Learning from Data *(enrichment — explored, not assessed)*

*Strang Ch. 8. Where the whole course shows up inside modern AI.*

| Lesson | Title | Students can… |
| --- | --- | --- |
| 8.0 | Setting Up — Learning from Data | describe a network as layers of a linear step plus one nonlinearity, evaluate $\mathrm{ReLU}(Av+b)$, and frame learning as shrinking a loss |
| 8.1 | Piecewise Linear Learning Functions | build continuous piecewise-linear functions by shifting and adding ReLUs, read folds from biases and slopes from weights, apply the $N \to N+1$ counting rule |
| 8.2 | Convolutional Neural Nets | convolve a filter across a signal, read the feature map, and count what weight sharing saves — the same layer, with $A$ reusing one filter |
| 8.3 | Minimizing Loss by Gradient Descent | read a loss as a bowl, step against the slope ($w \leftarrow w - sL'(w)$), explain the learning rate, and lift it to $\nabla L$ |
| 8.4 | Mean, Variance, and Covariance | measure a data set's shape, pack it into the covariance matrix $V$, and see $V$'s eigenvectors as the principal components — closing the loop to Unit 7 |

**Big ideas:** modern AI is, at heart, the linear algebra of this course.

---

## Assessment map

| Level | Instrument | Location |
| --- | --- | --- |
| Lesson | warm-up, exit ticket, homework (each keyed) | `unitXX/lessonYY/<component>[_key]/` |
| Unit | practice test (in the student packet) + actual test | `unitXX/tests/`, `unitXX/test_keys/` |
| Course | cumulative practice final + real final | `finals/` |

Unit 8 is enrichment; its material is not represented on assessments as tested content.

---

## Status snapshot — 2026-08-06

All **41 lesson plans and their component sets are authored**, all **8 unit test pairs
(practice + actual, with keys) are authored**, and the **cumulative final is authored** in all
four forms. Units 1 and 2 additionally carry the `unit_cover` / `unit_cover_key` pair; Units
3–8 have no cover yet and fall back to the plain packet merge.

Build state, convention-retrofit progress, and the next actions are tracked separately in
`spec/course_planning.md` — that file, not this one, is the running log.
