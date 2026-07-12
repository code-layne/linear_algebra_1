# Linear Algebra — Course Structure & Design Notes

## Course identity

**Linear Algebra** — a conceptual, geometry-first course for a **secondary-school** audience.
The unit/lesson structure **mirrors the table of contents of the primary text**: each **unit is
a chapter** and each **lesson is a subchapter (section)** of that book.

- **Primary text (sole source):** *Linear Algebra for Everyone* — Gilbert Strang
  (Wellesley–Cambridge, 2020). The structure below is its table of contents (see
  `spec/everyone_prefaceTOC01.pdf`). **No supplementary materials are used** — all mathematics,
  examples, and exercises come from this book.

---

## Guiding philosophy

This course prioritizes:

- **Conceptual understanding over formal abstraction**
- **Clarity and structure over completeness**
- **Applications as illustration, not as the central burden**

Students should leave understanding what a matrix *does*, how systems of equations behave, the
meaning of span/independence/basis/dimension, why eigenvectors matter, and how linear algebra
appears in real systems. Prize the *idea in words → idea in symbols → matrix form* progression
the book models: geometry and concrete numbers first, formalism after.

## Role of applications (guided, not open-ended)

Applications are included in a **constrained, structured** way — not as an open-ended modeling
discipline. The instructor supplies the model structure, assumptions, and setup; students
supply the **computation, interpretation, and connection to meaning**. This is **not** a
"modeling" course.

## Audience

*Linear Algebra for Everyone* is written for a broad audience but still at a **college level** —
always **down-level**: lead with 2-D and small-integer examples, reframe formal machinery
(vector-space axioms, proofs, ε-rigor) as intuition and pictures, scaffold heavily, and never
assign college-level problems verbatim.

---

## Course map — units are chapters, lessons are subchapters

The lesson id is `<unit>.<n>`, matching the book's section number. **One lesson per
subchapter**, in book order. (A rich subchapter may split, or adjacent ones merge — confirm the
per-unit lesson map with the instructor before authoring.)

### Unit 1 — Vectors and Matrices
- 1.1 Linear Combinations of Vectors
- 1.2 Lengths and Angles from Dot Products
- 1.3 Matrices and Column Spaces
- 1.4 Matrix Multiplication and A = CR

### Unit 2 — Solving Linear Equations Ax = b
- 2.1 The Idea of Elimination
- 2.2 Elimination Matrices and Inverse Matrices
- 2.3 Matrix Computations and A = LU
- 2.4 Permutations and Transposes

### Unit 3 — The Four Fundamental Subspaces
- 3.1 Vector Spaces and Subspaces
- 3.2 The Nullspace of A: Solving Ax = 0
- 3.3 The Complete Solution to Ax = b
- 3.4 Independence, Basis, and Dimension
- 3.5 Dimensions of the Four Subspaces

### Unit 4 — Orthogonality
- 4.1 Orthogonality of the Four Subspaces
- 4.2 Projections onto Subspaces
- 4.3 Least Squares Approximations
- 4.4 Orthogonal Matrices and Gram–Schmidt

### Unit 5 — Determinants and Linear Transformations
- 5.1 3 by 3 Determinants
- 5.2 Properties and Applications of Determinants
- 5.3 Linear Transformations

### Unit 6 — Eigenvalues and Eigenvectors
- 6.1 Introduction to Eigenvalues
- 6.2 Diagonalizing a Matrix
- 6.3 Symmetric Positive Definite Matrices
- 6.4 Systems of Differential Equations  *(advanced — optional)*

### Unit 7 — The Singular Value Decomposition (SVD)  *(advanced — optional)*
- 7.1 Singular Values and Singular Vectors
- 7.2 Compressing Images by the SVD
- 7.3 Principal Component Analysis
- 7.4 The Victory of Orthogonality (and a Revolution)

### Unit 8 — Learning from Data  *(optional enrichment — not assessed)*
- 8.1 Piecewise Linear Learning Functions
- 8.2 Convolutional Neural Nets
- 8.3 Minimizing Loss by Gradient Descent
- 8.4 Mean, Variance, and Covariance

---

## Scope & sequencing notes

Following the book's own preface:

- **Core sequence:** Units 1–6. This delivers systems, the four subspaces, orthogonality/least
  squares, determinants/transformations, and eigenvalues — the highlights for a first course.
- **Short-course path:** the preface notes a course can jump from **dimensions (§3.5) directly
  to eigenvalues (2×2)** — i.e. compress or defer parts of Units 4–5 if time is short.
- **§6.4 (Systems of Differential Equations)** and **Unit 7 (SVD)** are advanced; include them
  as extensions where the class is ready. SVD is a genuine highlight if reachable.
- **Unit 8 (Learning from Data)** is optional enrichment. The book states it is included "with
  no expectation of testing students" — use it exploratorily, not as assessed material.
- **Appendix 10 (Markov Matrices)** in the text is a natural optional enrichment topic for
  long-term behavior / transition matrices if desired.

## Applications by unit (for hooks, activities, homework contexts)

Guided, instructor-framed applications that illustrate each unit — students compute *then*
interpret:

- **U1–U2:** mixtures and networks as systems; data records as vectors; similarity via dot
  product.
- **U3:** solution structure (particular + nullspace); when systems have none/one/many solutions.
- **U4:** best-fit line / least squares on real data; orthogonality.
- **U5:** geometric transformations of the plane (area/orientation via determinant).
- **U6:** "natural directions" — stretching directions, steady states, population/state models.
- **U7–U8 (optional):** image compression (SVD/PCA); intro to learning from data.

---

## Outcome goals

Students should build durable intuition for linear systems, understand matrices as operators
(not just arrays), be prepared for college-level linear algebra, and recognize linear algebra
in real-world contexts.
