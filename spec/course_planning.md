# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-07-24 — **Authored & built Unit 7 Lesson 7.4 — "The Victory of Orthogonality" (§7.4 — the
unit capstone: why perpendicular directions make the SVD, compression, and PCA all work).** Filled every skeleton: lesson plan,
cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 7.3's preamble/boxes/tone.
**Content — a celebration lesson (light on new machinery, heavy on tying threads):** (1) an **orthogonal matrix** $Q$ has
**perpendicular unit columns**, captured by the one test $Q\T Q=I$ (diagonal $1$'s = unit length, off-diagonal $0$'s = perpendicular)
⇒ the **inverse is free**, $Q^{-1}=Q\T$; (2) orthogonal matrices **preserve length** — one-line proof $|Q\xx|^2=(Q\xx)\T(Q\xx)=\xx\T Q\T Q\xx=\xx\T\xx=|\xx|^2$
— so they are **rigid motions** (rotation or reflection, no distortion); (3) the SVD $A=U\Sigma V\T$ is **rotate–stretch–rotate** —
$V\T$ turns, $\Sigma$ stretches by the $\sigma$'s, $U$ turns; **all the stretching lives in $\Sigma$**; (4) **the victory & the
revolution** — orthogonal factors are reversible for free, length-preserving, and **never amplify errors** (why modern algorithms
compute with them), and orthogonality is the thread through the whole course (projections/least squares U4, perpendicular eigenvectors
U6, perpendicular singular vectors for *every* matrix U7). **Spine = the unit's recurring $Q=\tfrac1{\sqrt2}[[1,1],[1,-1]]$** ($Q\T Q=I$,
$Q^{-1}=Q\T=Q$; $\xx=(3,1)\to Q\xx=\tfrac1{\sqrt2}(4,2)$, both length $\sqrt{10}$) — and the Unit-6 spine $A=[[2,1],[1,2]]=Q\,\mathrm{diag}(3,1)\,Q\T$
(symmetric ⇒ $U=V=Q$) makes rotate–stretch–rotate concrete. **Warmup literally does the notes' three opening checks** (perpendicular
unit columns via dot products U4; $Q\T Q=I$ U1/U6; length after $Q$ on $(3,1)\to10$ U4). **Custom rotate–stretch–rotate pipeline TikZ**
(5 blush boxes $\xx\to V\T\to\Sigma\to U\to A\xx$, burgundy arrows, "turn/stretch/turn" labels; needs `arrows.meta, positioning, calc`)
on notes §3 + slides. **Activity/Exit/HW spines (all hand-verified pure Python; clean integer rotations):** Tier R verify
$\tfrac15[[3,-4],[4,3]]$ orthogonal ($Q\T Q=I$, $3$-$4$-$5$); Tier A length preserved on $(5,0)\to(3,4)$ len 5 + free inverse + $\det=1$
rotation; Tier E rotate–stretch–rotate with $\sigma=4,1$ ⇒ max/min stretch $=\sigma_1/\sigma_2$ (only $\Sigma$ scales). Exit:
$\tfrac15[[4,-3],[3,4]]$ orthogonal, $Q^{-1}=Q\T$, $|\xx|=6\Rightarrow|Q\xx|=6$, justify rotate–stretch–rotate. HW: orthogonal-or-not
screen ($\tfrac1{\sqrt2}[[1,-1],[1,1]]$ yes / $[[2,0],[0,1]]$ no — unit-length is the discriminator / $\tfrac1{13}[[5,-12],[12,5]]$ yes);
length + free inverse on the $5$-$12$-$13$ rotation ($(13,0)\to(5,12)$ len 13); SVD factors ($\sigma=5,2$, only $\Sigma$ stretches);
justify $Q^{-1}=Q\T$ & length/stability; **extension** $\det Q=\pm1$ from $\det(Q\T Q)=1$ — rotation $+1$ vs reflection $-1$ (U5
callback). **Built `make -C unit07/lesson04 all` → clean** (0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math; 0 overfull
>15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 2pp/3pp, activity 1pp/2pp, homework 2pp/2pp,
slides 6pp, lesson plan 2pp; **student 8pp, full 18pp.** Visually spot-checked notes_key p2 (pipeline figure — clean blush boxes,
burgundy arrows, turn/stretch/turn labels, no tofu; red answers $Q\xx=\tfrac1{\sqrt2}(4,2)$, $|Q\xx|^2=10$, all practice correct) —
clean. **Gotcha (recurred, TikZ):** the pipeline needs `\usetikzlibrary{arrows.meta, positioning, calc}` — `positioning` for `right=of`
and `calc` for `($(node)+(dx,dy)$)` label placement (2 build failures fixed by adding them; 7.1 only needed `positioning`). **Unit 7
lessons 7.0–7.4 are now all authored & built; next run authors the Unit 7 summative tests** (`tests/practice_test` + `actual_test`,
`test_keys/`), then `drop` to populate `sample_test`/`sample_test_key`, to complete the unit. Lessons 7.0–7.4 are the Unit 7 models;
Unit 4/5/6 tests are the assessment-format model.

**Prior run:** **Authored & built Unit 7 Lesson 7.3 — "Principal Component Analysis" (§7.3 — the
"keep the biggest $\sigma$" idea on *data* instead of pixels).** Filled every skeleton: lesson plan, cover, warmup, notes,
activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 7.2's preamble/boxes/tone. **Content —
the three-move PCA pipeline:** (1) **center** the data matrix $A$ (rows = data points, cols = features; subtract each column's
mean so the cloud sits at the origin — directions now describe *spread*, not location — the one new setup move); (2) form the
symmetric $A\T A$ (column dot products = spreads/overlaps of features) and take its **eigenvectors = the principal components**
$\vv_1\perp\vv_2$ (the Lesson 7.1 recipe; symmetric ⇒ perpendicular, ordered biggest $\sigma$ first); (3) each **eigenvalue *is*
the spread** along its direction ($\sum$ squared projections $=\vv\T A\T A\vv=\lambda=\sigma^2$), so **PC1** (largest $\lambda$) is
the best single direction and its share is $\sigma_1^2/(\sigma_1^2+\sigma_2^2)$; keep the top few → **dimension reduction**. Framed
honestly ("statisticians divide by $n-1$ to get variance, but the *fraction* is the same") to avoid the covariance-normalization
tangent. **Spine = 4 students, two quiz scores** raw $(5,6),(6,5),(3,2),(2,3)$ → means $(4,4)$ → centered
$(1,2),(2,1),(-1,-2),(-2,-1)$ → $A\T A=[[10,8],[8,10]]$, $\lambda=18,2$, $\vv_1=\tfrac1{\sqrt2}(1,1)$ (PC1, 90%),
$\vv_2=\tfrac1{\sqrt2}(1,-1)$ (PC2, 10%); **rich interpretation**: PC1 = "overall score" (both quizzes rise together), PC2 = "which
quiz you did better on." **Warmup literally does the 3 setup moves on the spine data** (center → means $(4,4)$ Unit 1; form $A\T A$
Unit 1/7.1; eigenvalues of symmetric $[[10,8],[8,10]]$ via $\det(A\T A-\lambda I)=0\to18,2$ Unit 6/7.1 + fraction 90%) — so warmup
answers = notes opening. **Custom data-cloud + principal-axes TikZ** (4 charcoal dots leaning along the diagonal, long burgundy PC1
arrow on $(1,1)$, short royalblue PC2 arrow on $(1,-1)$, `arrows.meta`) on notes §3 + slides. **Activity/Exit/HW spines (all
hand-verified pure Python, all $[[a,b],[b,a]]$-form ⇒ $\pm45^\circ$ components, integer $\lambda$):** Tier R center+$A\T A$ on
$(5,7),(7,5),(3,1),(1,3)$→$[[20,12],[12,20]]$; Tier A full PCA of that ($\lambda32,8$, PC1 keeps 80%) + interpret; Tier E
$4$-feature spread spectrum $\sigma^2=60,25,10,5$ → cumulative $60/85/95\%$ ⇒ keep 3 for 95% + justify center/keep-biggest. Exit:
centered $(2,3),(3,2),(-2,-3),(-3,-2)$→$[[26,24],[24,26]]$ ($\lambda50,2$, PC1 96%) + justify center + dimension reduction. HW:
center $(6,5),(5,6),(2,3),(3,2)$→$[[10,8],[8,10]]$; full PCA of $[[34,16],[16,34]]$ (centered $(1,4),(4,1),(-1,-4),(-4,-1)$;
$\lambda50,18$, PC1 only **74%** — a deliberate "one component is *not* enough, keep both" contrast); **line case** $\sigma_2=0$
(centered $(3,3),(1,1),(-1,-1),(-3,-3)$→$[[20,20],[20,20]]$, $\lambda40,0$ — one PC exact, PCA analogue of a rank-1 image); justify;
extension spread spectrum $\sigma^2=90,6,3,1$ → cumulative $90/96/99/100\%$ ⇒ keep 2 for 95%, 3 for 99%. **Built
`make -C unit07/lesson03 all` → clean** (0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math; 0 overfull >15pt after
fixing 2: a wide warmup centered-points display line → split into two `\[...\]`, and a lesson-plan multicols line → inserted
breakpoints in the inline point lists). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 2pp/3pp,
activity 1pp/2pp, homework 2pp/2pp, slides 6pp, lesson plan 3pp; **student 8pp, full 19pp.** Visually spot-checked notes_key p2
(data-cloud figure — clean charcoal dots on the diagonal, long burgundy PC1 / short royalblue perpendicular PC2, correct labels, no
tofu; red eigenvectors $(1,1)/(1,-1)$, $90\%$, and all practice answers correct) — clean. **Gotchas (none new):** long inline
point-sequences `$(a,b),(c,d),(e,f),(g,h)$` are a single unbreakable math box → in narrow columns/display lines split into two
`\[...\]` or insert `$...$ $...$` breakpoints; `\usetikzlibrary{arrows.meta}` + `royalblue`/`charcoal`/`linegray` all fine after
`-boxes`/`-key`/`-beamer`. **Next run: author Unit 7 Lesson 7.4** ("The Victory of Orthogonality", §7.4 — why perpendicular
directions make the SVD, compression, and PCA all work). Lessons 7.0/7.1/7.2/7.3 are the Unit 7 models.

**Prior run:** **Authored & built Unit 7 Lesson 7.2 — "Compressing Images by the SVD" (§7.2 — write $A$ as a
sum of rank-1 layers and keep the biggest).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket,
homework (+ the five keys) and the slides deck, mirroring Lesson 7.1's preamble/boxes/tone. **Content — the one new mechanic + the
compression idea:** (1) the **outer product** $\uu\vv\T$ (a column times a row) is a *matrix* whose every column is a multiple of
$\uu$ — a **rank-1** matrix, stored in $m+n$ numbers not $mn$; (2) multiplying out $A=U\Sigma V\T$ regroups $A$ into ordered
**rank-1 layers** $A=\sigma_1\uu_1\vv_1\T+\sigma_2\uu_2\vv_2\T+\cdots$, biggest $\sigma$ first; (3) **compress** = keep the first
$k$ layers $A_k$ (the *closest* rank-$k$ matrix, **Eckart–Young** stated not proved); (4) **energy** $\sigma_1^2+\sigma_2^2+\cdots=$
sum of squares of all entries, so big-$\sigma$ layers hold the most, and each layer costs $1+m+n$ numbers ⇒ storage win.
**Deliberately clean symmetric spines** (form $[[a,b],[b,a]]$: eig $a\pm b$, $\uu_i=\vv_i=\tfrac1{\sqrt2}(1,\pm1)$, integer layers
since $a,b$ same parity) so the arithmetic stays integer while focus stays on compression: **notes spine** $[[5,3],[3,5]]$
($\sigma 8,2$; layers $[[4,4],[4,4]]+[[1,-1],[-1,1]]$; $A_1$ keeps $64/68\approx94\%$). **Warmup literally builds the notes' opening**
(outer product $[1,2]^T[3,1]=[[3,1],[6,2]]$ Unit 1; $\sigma$'s of symmetric $[[5,3],[3,5]]$ via $\det(A-\lambda I)=0\to8,2$ Unit 6/7.1;
energy identity $8^2+2^2=68=5^2+3^2+3^2+5^2$). **Custom singular-value bar-chart TikZ** (6 decaying bars, first two burgundy "keep",
rest blushmid "drop", dashed divider, `arrows.meta` axis) on notes §3 + verbally on slides. **Activity/Exit/HW spines (all
hand-verified pure Python):** Tier R outer product $[2,1]^T[1,3]$ + build layer $[[3,3],[3,3]]$; Tier A full decomposition of
$[[4,2],[2,4]]$ ($\sigma6,2$; $B_1=[[3,3],[3,3]]$ keeps $36/40=90\%$); Tier E storage on $600\times800$ ($480{,}000$ vs rank-20
$28{,}020\approx5.8\%$) + justify keep-biggest. Exit: $[[6,4],[4,6]]$ ($\sigma10,2$) build $A_1=[[5,5],[5,5]]$ + energy $100/104\approx96\%$
+ justify. HW: outer products; full decompose $[[7,5],[5,7]]$ ($\sigma12,2$; $144/148\approx97\%$); $500\times500$ storage ($20{,}020\approx8\%$);
justify; rank-1 $\sigma_2{=}0$ case (one layer exact); extension $\sigma$-spectrum $10,6,3,1$ cumulative-energy → keep 3 of 4 for $99\%$
(PCA preview). **Built `make -C unit07/lesson02 all` → clean** (0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math; no
overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 1pp/2pp, homework
2pp/2pp, slides 6pp, lesson plan 3pp; **student 9pp, full 19pp.** Visually spot-checked notes_key p2 (bar-chart figure — clean
burgundy keep / blushmid drop bars, dashed divider, no tofu; layer arithmetic + red answers correct) and activity_key p1 (all tiers,
red answers correct) — clean. **Gotcha (recurred, 7.0-style):** `{\color{keyred}\mathbf{...}}` is a *math-mode* answer — a text-mode
percentage answer (`...\approx \_\_\%`) must use `\ans{4\%}`, not a bare `\mathbf` (fixed one such in notes_key §4). **Next run:
author Unit 7 Lesson 7.3** ("Principal Component Analysis", §7.3 — same keep-biggest-$\sigma$ idea on *data*: center the data matrix,
its top singular directions are the principal components). Lessons 7.0/7.1/7.2 are the Unit 7 models.

**Prior run:** **Authored & built Unit 7 Lesson 7.1 — "Singular Values and Singular Vectors" (§7.1 — the
$A\T A$ recipe to *find* $\sigma,\vv,\uu$ for any matrix).** Filled every skeleton: lesson plan, cover, warmup, notes,
activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 7.0's preamble/boxes/tone.
**Content — the five-step recipe:** (1) build the symmetric $A\T A$ (entries = column dot products); (2) its eigenvalues
$\lambda_1\ge\lambda_2\ge0$ + perpendicular unit eigenvectors are the input vectors $\vv_i$ (Unit 6); (3) singular values
$\sigma_i=\sqrt{\lambda_i}$; (4) output vectors $\uu_i=A\vv_i/\sigma_i$ (perpendicular & unit automatically); (5) assemble
$A=U\Sigma V\T$. **Why it works** (the engine): $A\vv=\sigma\uu\Rightarrow A\T A\vv=\sigma^2\vv$, so $\vv$ is an eigenvector of
$A\T A$; $A\T A$ is *symmetric* for **any** $A$ (any shape) ⇒ real $\lambda\ge0$ (real $\sigma=\sqrt\lambda$) + perpendicular
eigenvectors, and $\lambda=|A\vv|^2/|\vv|^2\ge0$. **Fresh non-symmetric spine** $A=\begin{bsmallmatrix}1&2\\-2&2\end{bsmallmatrix}$:
$A\T A=\begin{bsmallmatrix}5&-2\\-2&8\end{bsmallmatrix}\to\lambda 9,4\to\sigma 3,2$; $\vv_1=\tfrac1{\sqrt5}(1,-2)\to\uu_1=\tfrac1{\sqrt5}(-1,-2)$,
$\vv_2=\tfrac1{\sqrt5}(2,1)\to\uu_2=\tfrac1{\sqrt5}(2,-1)$; $U\Sigma V\T=A$ verified in Python. **Warmup literally does Steps 1–3 on the
spine matrix** (transpose+$A\T A$ Units 1/6; eigenvalues of the symmetric $[[5,-2],[-2,8]]\to9,4$ Unit 6; normalize $(1,-2)\to\tfrac1{\sqrt5}$
Unit 4) — so the warmup answers *are* the notes' opening. **Custom 5-box recipe-pipeline TikZ** ($A\to A\T A\to\lambda,\vv\to\sigma,\uu\to U\Sigma V\T$,
blush boxes + burgundy arrows, arrows.meta) on notes §2 + mirrored across slides. **Activity/Exit/HW spine (all hand-verified in pure
Python):** Tier R diagonal-$A\T A$ ($[[3,0],[0,2]]$; swap $[[0,3],[2,0]]$ with the ordering catch $\lambda9\!\to\!\ee_2$); Tier A full recipe on
tilted $[[2,2],[1,-2]]$ ($A\T A=[[5,2],[2,8]]$, $\sigma3,2$, $\uu$'s = swapped $\vv$'s, perp-out check); Tier E **non-square** $3\times2$
$[[2,0],[0,2],[1,2]]$ ($A\T A=[[5,2],[2,8]]$, $\sigma3,2$) + justify $\lambda\ge0$. Exit: $[[1,-2],[2,2]]$ ($\sigma3,2$) find $\sigma$'s + one
$\uu_1=A\vv_1/\sigma_1=\tfrac1{\sqrt5}(-1,2)$ + justify $\sigma=\sqrt\lambda$. HW: diagonal-order $[[0,3],[2,0]]$; full recipe $[[2,1],[-2,2]]$
($A\T A=[[8,-2],[-2,5]]$, $\sigma3,2$); isolated $\uu$ step on the notes matrix; justify $\lambda\ge0$/real & why-beats-eigenvectors;
extension non-square $[[3,0],[0,3],[0,4]]$ ($A\T A=[[9,0],[0,25]]\to\sigma5,3$). **Built `make -C unit07/lesson01 all` → clean** (0 `^!`/file-line
errors across all 13 logs; no `\ans`-in-math; no overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes
3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 6pp, lesson plan 3pp; **student 10pp, full 19pp.** Visually spot-checked notes_key p2
(recipe-pipeline figure — clean blush boxes/burgundy arrows/labels, red answers correct, no tofu), activity_key p1 (all tiers, red answers
correct), and the slide title — clean. **Gotchas (none new):** `\usetikzlibrary{arrows.meta, positioning}` works fine after `-boxes`/`-key`
(tcolorbox already loads tikz); define every math macro (`\uu\vv\ee\T`) in each file incl. plan & beamer preambles. **Next run: author Unit 7
Lesson 7.2** ("Compressing Images by the SVD", §7.2 — keep the largest $\sigma$'s: $A\approx\sigma_1\uu_1\vv_1\T+\cdots$). Lessons 7.0/7.1 are
the Unit 7 models.

**Prior run:** **Authored & built Unit 7 Lesson 7.0 — "Setting Up the SVD" (the intro/spiral on-ramp).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides
deck, mirroring Lesson 6.0's preamble/boxes/tone. **Content — spiral + roadmap for the SVD:** (1) a matrix stretches the
**unit circle** into an **ellipse**; the two half-widths are the **singular values** $\sigma_1\ge\sigma_2\ge0$ (diagonal
$D=[[3,0],[0,2]]\to\sigma 3,2$). (2) **The big idea — perpendicular in $\to$ perpendicular out:** every matrix has unit
vectors $\vv_1\perp\vv_2$, $\uu_1\perp\uu_2$ with $A\vv_i=\sigma_i\uu_i$. Spine = the Unit-6 symmetric $A=[[2,1],[1,2]]$
($\vv_1=[1,1]\to A\vv_1=[3,3]=3\vv_1$, $\vv_2=[1,-1]\to 1\vv_2$; perpendicular in \& out; $\sigma 3,1$; tilted-$45^\circ$
ellipse). (3) **Input frame $\ne$ output frame** — the swap $S=[[0,2],[1,0]]$ ($S\ee_1=[0,1],S\ee_2=[2,0]$; $\sigma 2,1$;
largest input $\ee_2\to$ output $[1,0]\ne\ee_2$). (4) **The SVD $A=U\Sigma V^{\top}$** (rotate–stretch–rotate) + why it
matters: exists for **every** matrix (any shape), $\sigma\ge0$ always — unlike eigenvectors (Unit 6); *find* via
$\sigma=\sqrt\lambda$ from $A^{\top}A$ (deferred to 7.1). **Custom circle$\to$ellipse TikZ** (unit circle + $\vv$'s, gold
"$A$" arrow, tilted ellipse + $\uu$'s, semi-axes $\sigma_1=3,\sigma_2=1$) on notes §2 + slides hook. **Warmup spirals the
prereqs** (matrix$\times$vector Unit 1; dot-product $\perp$ test Unit 4; length/normalize Unit 4). **Activity/Exit/HW spine
(all hand-verified in pure Python):** Tier R read $\sigma$ off diagonals (+ ordering: $[[2,0],[0,4]]\to\sigma_1=4$ from
$\ee_2$); Tier A swap $[[0,1],[4,0]]$ (frames differ) + symmetric $[[5,2],[2,5]]$ ($\sigma 7,3$, Unit-6 eigenvector tie-in);
Tier E the 7.1 preview $A^{\top}A=[[5,4],[4,5]]\to\lambda 9,1\to\sigma 3,1$ (recovers the notes). Exit: diagonal $[[4,0],[0,3]]$
+ swap $[[0,3],[2,0]]$ ($\sigma 3,2$) + justify $\sigma$ geometrically. HW: read $\sigma$'s (incl. circle-stays-circle
$[[3,0],[0,3]]$); swap $[[0,4],[3,0]]$ ($\sigma 4,3$); symmetric $[[3,1],[1,3]]$ ($\sigma 4,2$); justify $\sigma\ge0$ \&
every-matrix-has-SVD; extension $A^{\top}A=[[9,0],[0,16]]\to\sigma 4,3$. **Built `make -C unit07/lesson00 all` → clean**
(0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math that breaks; no overfull >15pt). Page counts: cover/warmup/exit
1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 1pp/2pp, homework 2pp/2pp, slides 5pp, lesson plan 3pp;
**student 9pp, full 18pp.** Visually spot-checked notes_key p2 (circle$\to$ellipse figure — clean tilted ellipse, colored
$\vv$/$\uu$ arrows, gold "$A$", no tofu), slides hook, and activity_key p1 (all red answers correct) — clean. **Gotchas
(recurred):** (a) `\ww` used in the lesson-plan spiral-review but not defined — added it (define every math macro the body
uses, plan preamble included); (b) `\emph{...}` cannot wrap an inline matrix (the `\\` triggers "Forbidden control sequence
\check@nocorr@") — replaced with `(\textbf{...} ...)`; (c) in a key, `$\sigma_1=\ans{$x$}, $\sigma_2=...$` closes math early
and leaves `\sigma_2` in text mode — used `{\color{keyred}\mathbf{...}}` for in-formula answers instead. Transpose macro:
`\newcommand{\T}{^{\top}}`. **Next run: author Unit 7 Lesson 7.1** ("Singular Values and Singular Vectors", §7.1 — find
$\sigma,\vv,\uu$ from $A^{\top}A$). Lesson 7.0 is now the Unit 7 model (mirrors 6.0/5.0/4.0).

**Prior run:** **Scaffolded all of Unit 7 (The Singular Value Decomposition) — skeletons only.**
Ran `new_lesson.py` for lessons 7.0–7.4 (component set: cover, warmup, notes, activity, exit_ticket, homework, slides
+ keys for the keyed components). The 7.0 run created the unit, so `unit07/tests/` (practice + actual),
`unit07/test_keys/` (both keys), `unit07/sample_test/`, `unit07/sample_test_key/`, `unit07/Makefile`, and the
thin-include test Makefiles were all auto-scaffolded too. **Confirmed lesson map (6 lessons; user chose 7.0 + 7.1–7.4):**
7.0 "Setting Up the SVD" (intro/spiral, mirrors 6.0/5.0/4.0) · 7.1 "Singular Values and Singular Vectors" (§7.1) ·
7.2 "Compressing Images by the SVD" (§7.2) · 7.3 "Principal Component Analysis" (§7.3) · 7.4 "The Victory of
Orthogonality" (§7.4) — matches `spec/linear_algebra_v2.md` §7.1–7.4 plus the customary `lesson00` intro. **Unit 7 is
advanced/optional per the spec, but authored as an ordinary unit of lessons** (same component set + down-leveling as
1–6). `sample_test`/`sample_test_key` PDFs are NOT yet populated (they come from `drop` after the tests are authored).
Lessons 6.0–6.4 are the model set; Unit 4/5/6 tests are the assessment-format model; Lesson 4.0 remains the cross-unit
style model. The core sequence (Units 1–6) is complete; Unit 7 (and optionally Unit 8) is the optional/advanced extension
now in progress.

**Prior run:** **Authored & built the Unit 6 summative tests — Unit 6 is now complete.**
Filled all four skeletons (`tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`, `test_keys/actual_test_key`),
mirroring the Unit 4/5 test format (`shared/tests.mk` + `test_keys.mk`; `\parthead` burgundy strips; Part A vocab matching / B
multiple choice / C computation / D extended response; 8/12/35/10 pts). **Blueprint spans the whole unit §6.0–6.4:** A (8 terms —
eigenvector, eigenvalue, characteristic equation, diagonalization, diagonalizable matrix, symmetric matrix, positive definite
matrix, spectral theorem), B (6 MC concept checks — eigenvector def, $\det(A-\lambda I)=0$, triangular $\lambda$-on-diagonal,
diagonalizable$\Leftrightarrow n$ indep eigenvectors, symmetric$\Rightarrow\perp$ eigenvectors, $2\times2$ posdef test
$a>0$&$ac-b^2>0$; actual variant: $\lambda$ def, char eq, $\Lambda$ holds $\lambda$'s, $A^k=X\Lambda^kX^{-1}$, repeated-eigenvalue
$\Rightarrow$ not diagonalizable, $S=Q\Lambda Q^{\T}$), C (7 items — eigenvector test + eigenvalue 6.0; char eq $\to$ eigenvalues
6.1; eigenvectors + trace/det check 6.1; power $A^2=X\Lambda^2X^{-1}$ 6.2; diagonalizable-or-not repeated-vs-distinct 6.2; posdef
test + $\perp$-from-symmetry 6.3; system $\frac{d\uu}{dt}=A\uu$ general solution + stability 6.4), D (2 items — why
$\det(A-\lambda I)=0$ finds $\lambda$ via singular reasoning 6.1; why $A^k=X\Lambda^kX^{-1}$ (cancellation) + symmetric$\Rightarrow
\perp$ & all-$\lambda>0\Rightarrow$ invertible 6.2/6.3). **Practice vs. actual use parallel-but-distinct numbers, all hand-verified
in pure Python:** practice C1 $[[3,1],[1,3]]$ ($[1,1]\to\lambda4$); C2 $[[4,2],[1,3]]\to\lambda^2-7\lambda+10\to\lambda2,5$; C3
eigvecs $[2,1],[1,-1]$, trace7/det10; C4 $[[2,1],[1,2]]\to A^2=[[5,4],[4,5]]$; C5 $[[3,0],[1,3]]$ no / $[[2,1],[1,2]]$ yes; C6
$[[2,1],[1,2]]$ posdef $\det3$; C7 $\lambda3,-1$, $\uu(0)=[5,1]\to c_13,c_22$, $\uu=3e^{3t}[1,1]+2e^{-t}[1,-1]$, **not** stable
(growing mode). actual C1 $[[4,1],[1,4]]$ ($\to\lambda5$); C2 $[[3,1],[2,2]]\to\lambda^2-5\lambda+4\to\lambda1,4$; C3 eigvecs
$[1,1],[1,-2]$, trace5/det4; C4 $[[3,1],[1,3]]\to A^2=[[10,6],[6,10]]$; C5 $[[2,0],[1,2]]$ no / $[[3,1],[1,3]]$ yes; C6
$[[4,1],[1,4]]$ posdef $\det15$; C7 $\lambda-1,-3$, $\uu(0)=[4,2]\to c_13,c_21$, $\uu=3e^{-t}[1,1]+e^{-3t}[1,-1]$, **stable**
(both $\lambda<0$) — a deliberate stable/unstable contrast to the practice C7. Built `make -C unit06/tests all` and
`make -C unit06/test_keys all` → **clean** (0 `^!`/file-line errors across all 4 logs; no `\ans`-in-math; no overfull >15pt). Page
counts: practice test 3pp, actual test 3pp, practice key 3pp, actual key 2pp; `drop` published `sample_test/main.pdf` (practice, 3pp)
and `sample_test_key/main.pdf` (practice key, 3pp). Visually spot-checked the practice key Part C/D page (all matrices, red answers,
trace/det checkmark, differential-equation general solution, teachernote) — clean, no tofu. **Unit 6 is now fully complete (lessons
6.0–6.4 + tests). This completes the core sequence Units 1–6.** Next run: begin the optional/advanced Units 7–8 if desired (confirm
with the user), else the course core is done. Lessons 6.0–6.4 are the Unit 6 models; Unit 4/5/6 tests are the assessment-format model.

**Prior run:** **Authored & built Unit 6 Lesson 6.4 — "Systems of Differential Equations" (Strang §6.4, advanced/optional).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck,
mirroring Lesson 6.3's preamble/boxes/tone. **Content — the unit capstone: put eigenvalues in charge of \emph{time}.** (1) **One
equation:** $\frac{du}{dt}=\lambda u\Rightarrow u(t)=u(0)e^{\lambda t}$ (the exponential is the function whose rate of change is a
multiple of itself); sign of $\lambda$ = grow ($\lambda>0$) vs. decay ($\lambda<0$). (2) **Eigenvectors are pure modes:** a start on
an eigenvector stays on its eigen-line, $\uu(t)=e^{\lambda t}\xx$ — verified by differentiating ($\lambda e^{\lambda t}\xx$ matches
$A(e^{\lambda t}\xx)=e^{\lambda t}\lambda\xx$ because $A\xx=\lambda\xx$), so the system collapses to the scalar equation along an
eigenvector. (3) **General solution = split the start:** $\uu(0)=c_1\xx_1+c_2\xx_2\Rightarrow\uu(t)=c_1e^{\lambda_1 t}\xx_1+c_2e^{\lambda_2 t}\xx_2$;
each mode runs independently. (4) **Stability from the signs:** all $\lambda<0\Rightarrow\uu\to\zero$ (stable), any $\lambda>0\Rightarrow$
growth; ties to 6.2 via $\uu(t)=Xe^{\Lambda t}X^{-1}\uu(0)$ (replace $\lambda^k$ with $e^{\lambda t}$). **Spine = the symmetric
$A=[[1,2],[2,1]]$ from 6.3 Tier E** ($\lambda=3,-1$; eigvecs $[1,1],[1,-1]$) — one growing mode, one decaying, no new eigen-finding.
**Custom phase-portrait TikZ** (burgundy $\xx_1$ outward arrows $\lambda3$ "grows" on $y=x$; royalblue $\xx_2$ inward arrows
$\lambda{-}1$ "decays" on $y=-x$; gold trajectory swinging toward $\xx_1$; caption "the growing mode wins") on notes §3 + slides §2.
**Warmup = the three moves** (grow/decay from sign of $\lambda$; split $[5,3]=c_1[1,1]+c_2[1,-1]\to c_14,c_21$; eigenvector recall
$A[1,1]=3[1,1]$). **Activity/Exit/HW spine (all hand-verified in pure Python):** Tier R single equations + pure modes on the spine;
Tier A full solution from $\uu(0)=[5,1]$ ($c_13,c_22$; $\uu=3e^{3t}[1,1]+2e^{-t}[1,-1]$, growing mode wins); Tier E the \emph{stable}
contrast $[[-2,1],[1,-2]]$ ($\lambda=-1,-3$; from $[4,2]$ get $3e^{-t}[1,1]+e^{-3t}[1,-1]\to\zero$, $e^{-3t}$ faster). Exit uses
$[[0,1],[1,0]]$ ($\lambda=1,-1$; from $[3,1]$ get $c_12,c_21$; justify which mode wins). HW: single eqns; general solution on spine;
fit $[4,2]$ ($c_13,c_21$); a stability screen ($\lambda{-2,-5}$ decay / $\lambda{3,1}$ grow / $\lambda{2,-4}$ mixed→saddle/grows);
justify eigenvector-start-stays-on-line & signs-decide; extension = matrix exponential $e^{\Lambda t}=\mathrm{diag}(e^{3t},e^{-t})$.
**Built `make -C unit06/lesson04 all` → clean** (0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math; no overfull >15pt).
Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 1pp/2pp, homework 2pp/2pp, slides 6pp,
lesson plan 2pp; **student 9pp, full 18pp** (matches 6.0/6.1/6.2/6.3). Visually spot-checked notes_key p2 (phase-portrait figure —
clean outward/inward arrows, dashed eigen-lines, gold trajectory, no tofu; red answers correct) — clean. **Gotcha (recurred once):**
`\uu`/`\xx`/`\zero`/`\T` are per-file macros — the warmup_key teachernote used `\uu`/`\xx` but the blank warmup didn't, so the key
preamble needed them added (define every math macro the body uses, keys included, even when the blank doesn't). **Unit 6 lessons
6.0–6.4 are now all authored & built; next run authors the Unit 6 summative tests** (`tests/practice_test` + `actual_test`,
`test_keys/`), then `drop` to populate `sample_test`/`sample_test_key`, to complete the unit. Lessons 6.0–6.4 are the Unit 6 models;
Unit 4/5 tests are the assessment-format model.

**Prior run:** **Authored & built Unit 6 Lesson 6.3 — "Symmetric Positive Definite Matrices" (Strang §6.3).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides
deck, mirroring Lesson 6.2's preamble/boxes/tone. **Content — the family Lesson 6.2 promised: the matrices that \emph{always}
diagonalize.** (1) **Symmetric $\Rightarrow\perp$ eigenvectors:** $S=S^{\T}$ (numbers mirror across the diagonal); the
\textbf{spectral theorem} guarantees real eigenvalues \emph{and} perpendicular eigenvectors, verified on the unit spine
$S=[[2,1],[1,2]]$ ($\lambda3,1$; eigvecs $[1,1]\cdot[1,-1]=0$). (2) **Cleanest diagonalization $S=Q\Lambda Q^{\T}$:** normalize
the eigenvectors (÷$\sqrt2$) into orthonormal $Q=\tfrac1{\sqrt2}[[1,1],[1,-1]]$; since $Q^{\T}Q=I$ (Unit 4), $Q^{-1}=Q^{\T}$, so
6.2's $X^{-1}$ becomes a free transpose — verified $Q\Lambda Q^{\T}=\tfrac12[[4,2],[2,4]]=S$. (3) **Positive definite = all
$\lambda>0$:** the quick $2\times2$ test $a>0$ \& $ac-b^2>0$ ($=\det>0\Rightarrow$ invertible); spine $2>0$, $\det3>0$. (4)
**Energy $\xx^{\T}S\xx$:** $=2x^2+2xy+2y^2=x^2+y^2+(x+y)^2>0$ (sum of squares) — a bowl that curves up; a negative eigenvalue
makes a saddle. **Custom perpendicular-eigenvector TikZ** (burgundy $\xx_1$ $\lambda3$ + royalblue $\xx_2$ $\lambda1$ on dashed
$y=\pm x$ eigen-lines, hand-drawn right-angle mark at origin, caption "symmetric $\Rightarrow$ perpendicular") on notes §1 +
slides §1. **Warmup = the three checks in miniature** (transpose/symmetry $S=S^{\T}$; dot-product $\perp$ test $[1,1]\cdot[1,-1]$;
normalize $[1,1]\to\tfrac1{\sqrt2}[1,1]$). **Activity/Exit/HW spine (all hand-verified in pure Python):** Tier R three checks on
$[[3,1],[1,3]]$ ($\lambda4,2$; posdef); Tier A full $S=Q\Lambda Q^{\T}$ on $[[5,2],[2,5]]$ ($\lambda7,3$; $Q=\tfrac1{\sqrt2}[[1,1],
[1,-1]]$; $\tfrac12[[10,4],[4,10]]$✓); Tier E the contrast $[[1,2],[2,1]]$ ($\lambda3,-1$ — symmetric so still $\perp$, but energy
at $[1,-1]=-2<0$ ⇒ \emph{not} posdef, a saddle). Exit uses $[[4,1],[1,4]]$ ($\lambda5,3$; posdef; justify $\perp$ from symmetry
alone). HW: spectral factorization on the spine; a posdef \emph{screen} ($[[2,1],[1,2]]$ yes, $[[1,3],[3,1]]$ no $\det{-}8$,
$[[1,2],[2,4]]$ no $\det0$/semidef $\lambda5,0$); energy at $[1,0]{\to}2,[1,1]{\to}6$; posdef-vs-invertible ($\lambda6,-2$: not
posdef but invertible); justify $Q^{\T}Q=I$ \& posdef$\Rightarrow$invertible; extension = ellipse geometry (axis $1/\sqrt\lambda$,
smallest $\lambda\Rightarrow$ longest axis, along $[1,-1]$). **Built `make -C unit06/lesson03 all` → clean** (0 `^!`/file-line
errors across all 13 logs; no `\ans`-in-math; no overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page
constraint), notes 3pp/3pp, activity 1pp/2pp, homework 2pp, slides 6pp, lesson plan 2pp; **student 9pp, full 18pp** (matches
6.0/6.1/6.2). Visually spot-checked notes_key p2 (perpendicular-eigenvector figure — clean arrows, dashed eigen-lines, crisp
right-angle mark, no tofu) — clean. **Gotcha (unchanged):** `\xx`/`\vv`/`\qq`/`\zero`/`\T` are per-file macros — define every
math macro the body uses (incl. the lesson-plan and beamer preambles); `royalblue`/`linegray`/`charcoal` confirmed defined in
`linalg-colors`. **Next run: author Unit 6 Lesson 6.4** ("Systems of Differential Equations", §6.4, advanced/optional). Lessons
6.0/6.1/6.2/6.3 are the Unit 6 models.

**Prior run:** **Authored & built Unit 6 Lesson 6.2 — "Diagonalizing a Matrix" (Strang §6.2).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides
deck, mirroring Lesson 6.1's preamble/boxes/tone. **Content — the payoff of 6.1's eigen-finding: put the eigenvectors to
work.** (1) **Line them up:** eigenvectors into the columns of $X$, eigenvalues down the diagonal of $\Lambda$; multiplying
$A\cdot X$ column by column scales each eigenvector, so $AX=X\Lambda$ ($\Lambda$ on the \emph{right} scales columns). (2)
**Solve for $A$:** if $X$ is invertible, $A=X\Lambda X^{-1}$ (and $\Lambda=X^{-1}AX$ — diagonal in eigenvector coordinates);
uses the Unit~2 inverse formula for $X^{-1}$. (3) **Payoff — powers:** $A^2=X\Lambda X^{-1}X\Lambda X^{-1}=X\Lambda^2 X^{-1}$
(inner $X^{-1}X$ cancels), so $A^k=X\Lambda^k X^{-1}$ — just raise the $\lambda$'s. (4) **When it fails:** need $n$
independent eigenvectors ($X$ invertible); distinct $\lambda$'s always work, a repeat can fail. **Reused the unit spine**
$A=[[2,1],[1,2]]$ ($\lambda3,1$; eigvecs $[1,1],[1,-1]$) end-to-end so nothing new is computed: $X=[[1,1],[1,-1]]$,
$\det X=-2$, $X^{-1}=[[\tfrac12,\tfrac12],[\tfrac12,-\tfrac12]]$, and $A^2=X\Lambda^2X^{-1}=[[5,4],[4,5]]$ (matches squaring
$A$). **Custom diagonalization-pipeline TikZ** (four blush boxes → burgundy arrows $X^{-1}/\Lambda/X$ labeled
rewrite→scale→rebuild) on notes §3 + slides "Big idea" frame. **Warmup = the three assembly moves** (build $X$ from column
vectors; $2\times2$ inverse of $[[1,1],[0,1]]$; right-multiply $[[1,1],[1,-1]]\mathrm{diag}(3,1)$ scales columns).
**Activity/Exit/HW spine (all hand-verified in pure Python, exact fractions):** Tier R build+assemble $A=X\Lambda X^{-1}$
from eigen-data $[1,0]\!\to\!\lambda6,[1,1]\!\to\!\lambda2$ (fraction-free $\det X=1$, $A=[[6,-4],[0,2]]$); Tier A full job on
$[[4,-2],[1,1]]$ ($\lambda2,3$; eigvecs $[1,1],[2,1]$; integer $X^{-1}=[[-1,2],[1,-1]]$; $A^2=[[14,-10],[5,-1]]$); Tier E the
shear $[[2,1],[0,2]]$ (repeated $\lambda2$, one eigenvector $[1,0]$ ⇒ \emph{not} diagonalizable). Exit uses $[[1,4],[0,3]]$
($\lambda1,3$; eigvecs $[1,0],[2,1]$; $\det X=1$; $A=X\Lambda X^{-1}$) + justify why $A^k=X\Lambda^kX^{-1}$ is easy. HW: full
diagonalize symmetric $[[1,2],[2,1]]$ ($\lambda3,-1$); power $A^4=[[16,45],[0,1]]$ on $[[2,3],[0,1]]$; diagonalizable-or-not
($[[3,0],[1,3]]$ repeat→no vs $[[2,1],[1,2]]$ distinct→yes); read eigenvalues of $A^3/A^{-1}$ off $\Lambda=\mathrm{diag}(2,5)$;
justify the $X^{-1}X$ cancellation; extension $A^4=[[81,65],[0,16]]$ on the notes matrix $[[3,1],[0,2]]$. **Built
`make -C unit06/lesson02 all` → clean** (0 `^!`/file-line errors across all 13 logs; no `\ans`-in-math; no overfull >15pt).
Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 2pp/3pp, activity 2pp, homework 2pp, slides 6pp,
lesson plan 2pp; **student 9pp, full 18pp** (matches 6.0/6.1). Visually spot-checked notes_key p2 (pipeline figure — clean
blush boxes, burgundy arrows, no tofu) and slides "Big idea" frame — clean. **Gotcha (unchanged):** `\xx`/`\vv`/`\zero` are
per-file macros — define every math macro the body uses (incl. the lesson-plan and beamer preambles). **Next run: author
Unit 6 Lesson 6.3** ("Symmetric Positive Definite Matrices", §6.3). Lessons 6.0/6.1/6.2 are the Unit 6 models.

**Prior run:** **Authored & built Unit 6 Lesson 6.1 — "Introduction to Eigenvalues" (Strang §6.1).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides
deck, mirroring Lesson 6.0's preamble/boxes/tone. **Content — the payoff of 6.0's Tier E/preview: \emph{find} the special
directions with no guessing, via the two-step method.** (1) rewrite $A\xx=\lambda\xx$ as $(A-\lambda I)\xx=\zero$; a nonzero
$\xx$ crushed to $\zero$ forces $A-\lambda I$ \textbf{singular} $\Rightarrow$ \textbf{characteristic equation}
$\det(A-\lambda I)=0$ (Unit 5 callback). (2) \textbf{Step 1 — eigenvalues:} expand $\det(A-\lambda I)$ into the characteristic
polynomial and solve; on the 6.0 spine $A=[[2,1],[1,2]]$: $(2-\lambda)^2-1=\lambda^2-4\lambda+3=(\lambda-1)(\lambda-3)$,
$\lambda=1,3$ — \emph{recovers} the guessed values. (3) \textbf{Step 2 — eigenvectors:} solve $(A-\lambda I)\xx=\zero$ for
each $\lambda$ ($\lambda3\to[1,1]$, $\lambda1\to[1,-1]$). (4) \textbf{trace/det check} ($\lambda_1+\lambda_2=$ trace,
$\lambda_1\lambda_2=\det$), diagonal/triangular $\lambda$-on-the-diagonal, $\lambda=0\Leftrightarrow\det A=0$, and the 6.2
preview $A=X\Lambda X^{-1}$. **Warmup = the method's three moves in miniature** (form $A-\lambda I$ on $[[4,1],[2,3]]$; $2\times2$
determinant; factor $\lambda^2-5\lambda+6$). **Custom two-eigen-line TikZ** (burgundy $\xx_1$ + $A\xx_1=3\xx_1$ on the $y=x$
eigen-line; royalblue $\xx_2$ unchanged on $y=-x$, $\lambda=1$) on notes §3 + slides Step 2. **Activity/Exit/HW spine (all
hand-verified in pure Python, exact ints):** Tier R diagonal $[[6,0],[0,2]]$ + full method on symmetric $[[4,1],[1,4]]$
($\lambda3,5$); Tier A full job on $[[4,2],[1,3]]$ ($\lambda2,5$; eigvecs $[1,-1],[2,1]$; trace/det check) + $\lambda=0$ on
$[[2,4],[1,2]]$ ($[2,-1]\to\zero$, $\det=0$); Tier E rotation $[[0,-1],[1,0]]$ → $\lambda^2+1=0$, \emph{no real} eigenvalue
(turns every vector, 5.3 callback). Exit uses $[[2,2],[1,3]]$ ($\lambda1,4$; eigvec $[1,1]$ for $\lambda4$; justify why
$\det(A-\lambda I)=0$). HW: full method $[[5,2],[2,5]]$ ($\lambda3,7$), diagonal/triangular read-off, negative eigenvalue
$[[1,2],[2,1]]$ ($\lambda3,-1$, a flip), trace/det check on the warmup matrix $[[4,1],[2,3]]$ ($\lambda2,5$), + a $3\times3$
triangular extension $[[2,1,7],[0,3,4],[0,0,5]]\to\lambda2,3,5$. **Built `make -C unit06/lesson01 all` → clean** (0 `^!`/file-line
errors across all 13 logs; no `\ans`-in-math; no overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page
constraint), notes 2pp, activity 2pp, homework 2pp, slides 5pp, lesson plan 2pp; **student 9pp, full 16pp** (matches 6.0).
Visually spot-checked notes_key p1/p2 (two-eigen-line figure — clean dashed lines, colored arrows, no tofu) and slides Step 2 —
clean. **Gotcha (unchanged):** `\xx`/`\zero` are per-file macros — define every math macro the body uses (incl. the lesson-plan
and beamer preambles). **Next run: author Unit 6 Lesson 6.2** ("Diagonalizing a Matrix", §6.2). Lessons 6.0/6.1 are the Unit 6
models.

**Prior run:** **Authored & built Unit 6 Lesson 6.0 — "Special Directions --- Setting Up Eigenvalues" (the intro/spiral lesson).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides
deck, mirroring Lesson 5.0's preamble/boxes/tone. **Content — spiral + roadmap for Eigenvalues:** (1) a matrix usually
\emph{turns} a vector (Lesson 5.3 callback: $A[1,0]^{\T}=[2,1]^{\T}$ under the spine $A=[[2,1],[1,2]]$); (2) the one big
idea — \textbf{special directions} where $A\xx$ stays on the same line: $A\xx=\lambda\xx$ ($\xx\ne\zero$), $\xx$ the
\emph{eigenvector}, $\lambda$ the \emph{eigenvalue}/stretch factor; verified $[1,1]^{\T}\to\lambda3$, $[1,-1]^{\T}\to\lambda1$,
non-example $[2,1]^{\T}\to[5,4]^{\T}$ (turned); (3) the reusable \textbf{test} — compute $A\xx$, is it a multiple of $\xx$?;
(4) why it matters (a matrix acts like the single number $\lambda$ along an eigenvector) + the §5 callback
$\lambda=0\Leftrightarrow\det A=0\Leftrightarrow$ not invertible, and the 6.1 preview $\det(A-\lambda I)=0$. **Warmup is the
lesson in miniature** ($A[1,1]^{\T}=[3,3]^{\T}=3[1,1]^{\T}$ + scalar-multiple + $2\times2$ determinant recall). **Custom
eigenvector TikZ** (burgundy $\xx$ + $A\xx=3\xx$ on a dashed eigen-line; royalblue $\yy$ turned to $A\yy$) on notes §2 +
slides hook. **Activity/Exit/HW spine (all hand-verified in pure Python, exact ints):** Tier R diagonal $\mathrm{diag}(2,5)$
axes + test $[1,1]^{\T}/[1,0]^{\T}$ on the spine; Tier A find $\lambda$ from eigenvectors ($B=[[4,2],[1,3]]$: $[2,1]^{\T}\to5$,
$[1,-1]^{\T}\to2$), screen candidates, $\lambda=0$ on $C=[[2,4],[1,2]]$ ($[2,-1]^{\T}\to\zero$, $\det=0$); Tier E the 6.1
method $\det(A-\lambda I)=(2-\lambda)^2-1=\lambda^2-4\lambda+3=(\lambda-1)(\lambda-3)$ recovering $\lambda=1,3$. Exit uses
$E=[[3,1],[1,3]]$ ($[1,1]^{\T}\to4$, $[1,0]^{\T}$ turned). HW adds a negative eigenvalue ($[[1,2],[2,1]]$, $[1,-1]^{\T}\to-1$,
a flip), diagonal/triangular $\lambda$-on-the-diagonal, $\lambda=0$ vs $\det=0$, and the $\det(A-\lambda I)=0$ extension
($E$: $\lambda^2-6\lambda+8\to\lambda=2,4$). **Built `make -C unit06/lesson00 all` → clean** (0 `^!`/file-line errors across
all 13 logs; no `\ans`-in-math; no overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint),
notes 2pp, activity 2pp, homework 2pp, slides 5pp, lesson plan 2pp; **student 9pp, full 16pp.** Visually spot-checked
notes_key p2 (eigenvector figure — clean, dashed eigen-line, colored arrows, no tofu) and the slides hook — clean.
**Gotcha (unchanged):** `\xx`/`\yy`/`\vv`/`\zero` are per-file macros — define every math macro the body uses (incl. the
lesson-plan and beamer preambles). **Next run: author Unit 6 Lesson 6.1** ("Introduction to Eigenvalues", §6.1). Lesson 6.0
is the Unit 6 model (mirrors 5.0/4.0).

**Prior run:** **Scaffolded all of Unit 6 (Eigenvalues and Eigenvectors) — skeletons only.**
Ran `new_lesson.py` for lessons 6.0–6.4 (component set: cover, warmup, notes, activity, exit_ticket, homework, slides
+ keys for the keyed components). The 6.0 run created the unit, so `unit06/tests/` (practice + actual),
`unit06/test_keys/` (both keys), `unit06/sample_test/`, `unit06/sample_test_key/`, `unit06/Makefile`, and the
thin-include test Makefiles were all auto-scaffolded too. **Confirmed lesson map (5 lessons; user chose to include the
optional §6.4):** 6.0 "Special Directions --- Setting Up Eigenvalues" (intro/spiral) · 6.1 "Introduction to Eigenvalues"
(§6.1) · 6.2 "Diagonalizing a Matrix" (§6.2) · 6.3 "Symmetric Positive Definite Matrices" (§6.3) · 6.4 "Systems of
Differential Equations" (§6.4, advanced/optional) — matches `spec/linear_algebra_v2.md` §6.1–6.4 plus the customary
`lesson00` intro. `sample_test`/`sample_test_key` PDFs are NOT yet populated (they come from `drop` after the
tests are authored).

**Prior run:** **Authored & built the Unit 5 summative tests — Unit 5 is now complete.**
Filled all four skeletons (`tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`, `test_keys/actual_test_key`),
mirroring the Unit 1–4 test format (`shared/tests.mk` + `test_keys.mk`; `\parthead` burgundy strips; Part A vocab matching / B
multiple choice / C computation / D extended response; 8/12/35/10 pts). **Blueprint spans the whole unit §5.0–5.3:** A (8 terms —
determinant, minor, cofactor expansion, linear transformation, orientation, singular matrix, area/volume factor, product rule),
B (6 MC concept checks — $\det I=1$, swap negates, shear leaves unchanged, $\det=0\Rightarrow$ singular, $|\det|=$ area factor,
product rule; actual variant: $\det<0$ flips, scale-a-row, $\det A^{\T}=\det A$, dependent cols $\Leftrightarrow\det=0$,
$\det A^{-1}=1/\det A$, shear $\det=1$), C (7 items — 2×2 det + area + orientation sign; 3×3 by cofactor expansion; 3×3 by
elimination-to-triangular + product of pivots; row-rule effects swap/scale/shear/$\det(kA)=k^n\det$; product rule
$\det(AB)$/$\det A^{-1}$/$\det A^{\T}$/$\det A^2$; image area under a transformation $|\det A|$ + orientation; $\det=0$ collapse ⇒
singular ⇒ unit square onto a line), D (2 items — why a shear/elimination step preserves $\det$ (same base & height ⇒ same volume);
why $|\det A|$ is the area factor and $\det=0\Rightarrow$ no inverse (square collapses to a line)). **Practice vs. actual use
parallel-but-distinct numbers** (practice: C1 $[1,3;2,1]\to-5$; C2 cofactor $[1,2,0;0,3,1;1,0,2]\to8$; C3 pivots
$[1,2,1;2,5,3;0,2,5]\to3$; C4 $\det=6$; C5 $\det A=4,\det B=2$; C6 $[3,1;0,2]\to6$, tri area $4\to24$; C7 $[2,1;4,2]\to0$. actual:
C1 $[2,4;1,1]\to-2$; C2 $[2,1,0;1,2,1;0,1,2]\to4$; C3 $[1,2,0;2,5,1;0,3,5]\to2$; C4 $\det=8$; C5 $\det A=6,\det B=2$; C6
$[4,1;0,2]\to8$, tri area $3\to24$; C7 $[3,1;6,2]\to0$; D1 concrete $[1,2;2,5]\to1$ before/after $R_2-2R_1$). **All arithmetic
hand-verified in pure Python** (2×2/3×3 determinants by cofactor, elimination-to-pivots, row-rule effects, product-rule
consequences). Built `make -C unit05/tests all` and `make -C unit05/test_keys all` → **clean** (0 `^!`/file-line errors across all 4
logs; no `\ans`-in-math; no overfull >15pt). Page counts: all four PDFs **3pp**; `drop` published `sample_test/main.pdf` (practice,
3pp) and `sample_test_key/main.pdf` (practice key, 3pp). Visually spot-checked the practice key Part C/D page (all matrices, red
answers, teachernote) and the actual key p1 (vocab matching + MC arrows + teachernote) — clean, no tofu. **Unit 5 is now fully
complete (lessons 5.0–5.3 + tests); next run begins Unit 6 (Eigenvalues and Eigenvectors).**

**Prior run:** **Authored & built Unit 5 Lesson 5.3 — "Linear Transformations" (Strang §5.3) — the final Unit 5 lesson.**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck,
mirroring Lesson 5.2's preamble/boxes/tone. **Content — the payoff the 5.0/5.1/5.2 Tier E/previews built toward: a matrix *moves
space*.** (1) **A matrix is a linear transformation** $\xx\mapsto A\xx$ — origin fixed, grid lines stay straight & evenly spaced, so
the unit square maps to a **parallelogram**; $A\ee_1,A\ee_2$ are the **columns** (Lesson 1.3 callback), so watching the unit square
tells the whole map. (2) **Gallery of motions** read straight off the matrix: stretch $\mathrm{diag}(2,3)$ ($\det6$), rotation
$[0,-1;1,0]$ ($\det1$), reflection $[1,0;0,-1]$ ($\det-1$), shear $[1,1;0,1]$ ($\det1$) — the last three have $|\det|=1$ (move without
resizing). (3) **The determinant is the area factor:** unit square → column parallelogram of area $|\det A|$, so **new area
$=|\det A|\cdot$ old area** (worked $A=[3,1;0,2]$, $\det6$: triangle area $4\to24$). (4) **Sign, collapse, road ahead:** $\det>0$
preserves orientation, $\det<0$ **flips** it (reflection), $\det=0$ **collapses** the square onto a line (area 0) $\Rightarrow$ not
invertible (Unit 2 "singular" seen geometrically); composition multiplies factors $|\det(AB)|=|\det A||\det B|$ (the 5.2 product rule
as area). **Hook:** photo/animation software multiplies each pixel by a matrix — $|\det A|$ is how much the image grows, its sign says
if it mirror-flipped. **Warmup is the lesson in miniature** ($A=[3,1;0,2]$: columns $(3,0),(1,2)$ → $\det6$ → image area $=|\det|=6$).
**Custom unit-square→parallelogram TikZ** (burgundy $\ee_1$/royalblue $\ee_2$, arrow $A$, image parallelogram "area $|\det A|=6$") on
notes §1 + slides hook. **Activity/Exit/HW spine** (all hand-verified in pure Python, exact ints): Tier R name-motion+area factor
($\mathrm{diag}(2,3)$ area5→30; reflection/shear $|\det|=1$); Tier A orientation sign ($[0,2;2,0]\to-4$ flip), $\det=0$ collapse
$[2,1;4,2]$ (parallel cols → line, no inverse), composition $\det(AB)=\det A\det B$; Tier E rotation $\det1$, rotate-then-stretch
$SR=[0,-2;2,0]$ $\det4=4\cdot1$, **3D volume** $\mathrm{diag}(2,3,-1)\to-6$ (5.1 Tier E reflection callback). Exit: $[4,1;0,2]\to\det8$
(area3→24), orientation flip, $\det=0$ collapse justification. HW: image areas, name-motion+orientation, composition $AB=[2,2;0,3]$
$\det6$, $\det=0$ explain; ext rotation $\det1$ + 3D $\mathrm{diag}(2,2,3)\to12$, $\mathrm{diag}(1,1,-1)\to-1$. **Preview: Unit 6**
(eigenvectors = directions only *stretched*). **Built `make -C unit05/lesson03 all` → clean** (0 `^!` errors across all 13 logs; no
`\ans`-in-math; no overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 2pp/3pp, activity
2pp/2pp, homework 2pp/2pp, slides 6pp, lesson plan 2pp; **student 9pp, full 18pp**. Visually spot-checked notes_key p1 (unit-square→
parallelogram figure — clean, colored basis arrows, no tofu) and slides hook — clean. **Gotcha (unchanged):** `\ee`/`\T`/`\xx`/`\yy`
etc. are per-file macros — define every math macro the body uses (incl. the lesson-plan preamble). **Unit 5 lessons (5.0–5.3) are now
all authored & built; next run authors the Unit 5 summative tests to complete the unit.**

**Prior run:** **Authored & built Unit 5 Lesson 5.2 — "Properties and Applications of Determinants" (Strang §5.2).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck,
mirroring Lesson 5.1's preamble/boxes/tone. **Content — the rules determinants obey, read as facts about volume, so you stop
expanding:** (1) **three founding rules** — $\det I=1$ (unit cube, vol 1); a **swap** of two rows/cols **negates** $\det$ (reflection);
**scaling** a row by $t$ scales $\det$ by $t$ (stretch an edge); equal rows ⇒ flat ⇒ $\det=0$; (2) **the key property — shear
invariance:** adding a multiple of one row to another leaves $\det$ **unchanged** (a shear slides the box, same base & height ⇒ same
volume) = exactly the Unit 2 elimination step; 2×2 check $[2,1;1,3]=5$ stays 5 after a column shear; (3) **the fast way —
$\det=\pm$(product of pivots):** reduce to triangular $U$ (shears free, one sign flip per swap) and multiply the pivots; worked
$A=[1,2,0;2,5,1;0,1,3]\xrightarrow{R_2-2R_1,\,R_3-R_2}$ pivots $1,1,2\to\det 2$ (no cofactors); (4) **product rule**
$\det(AB)=\det A\det B$ (compose maps ⇒ multiply volume factors; worked $5\cdot6=30$), consequences $\det A^{-1}=1/\det A$,
$\det A=0\Leftrightarrow$ singular, $\det A^{\T}=\det A$. **Applications:** Cramer's rule (Tier E/HW ext — solve $2x-y=3,x+3y=5\to(2,1)$
and $x+2y=4,3x+y=7\to(2,1)$ via determinant ratios) + transpose-rule checks. **Hook:** cofactors are real work — is there a faster
way? You already own elimination; does it change $\det$? **Warmup is the lesson in miniature:** one matrix $M=[1,2;2,5]$ walked through
compute-$\det$ (=1) → one elimination step → triangular $\det U$ (=1) → punchline $\det M=\det U$ (elimination didn't change it).
**Custom before/after shear TikZ** (burgundy upright box → green sheared box, "same base, same height, area $=bh$") on notes §2 + slides
hook. **Built `make -C unit05/lesson02 all` → clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math; no overfull >15pt). Page
counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 5pp,
lesson plan 2pp; **student 10pp, full 17pp** (matches 5.1). Visually spot-checked notes_key p1/p2 (shear figure + pivot-product worked
example — clean) and activity_key p1 (swap sign → $-8$, product rule → 24, inverses → 1/6, Cramer — all correct). All arithmetic
hand-verified in pure Python (exact fractions; no numpy/sympy). **Gotcha (unchanged):** `\T`/`\xx`/`\avec`/`\bb` are per-file macros,
not in shared styles — define every math macro the body uses (incl. the lesson-plan preamble). `\checkmark` is available (amssymb via
`linalg-article`); BSD `awk` on macOS lacks GNU `match(...,arr)` — use `grep`/`perl` for the overfull scan.

**Prior run:** **Authored & built Unit 5 Lesson 5.1 — "3 by 3 Determinants" (Strang §5.1).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck,
mirroring Lesson 5.0's preamble/boxes/tone. **Content — the 5.0 idea one dimension up (area → volume):**
(1) **from area to volume** — three columns span a *box* (parallelepiped) and $|\det A|$ is its **volume**; (2) **cofactor
expansion** as the method — expand across the top row into three $2\times2$ minors (cross out the entry's row & column) with the
sign pattern $+\,-\,+$, so a hard $3\times3$ reduces to three easy $2\times2$s they own from 5.0; worked spine
$A=[2,1,0;1,3,1;0,1,2]\to 2(5)-1(2)+0=\det 8$ (the two minors $[3,1;1,2]=5$, $[1,1;0,2]=2$); (3) **volume + triangular
shortcut** — axis box $\mathrm{diag}(2,3,4)\to 24$, triangular $[2,5,1;0,3,4;0,0,2]\to 2\cdot3\cdot2=12$ (product of the diagonal,
the Unit 2 $U$ callback); (4) **$\det=0$ = flat** — coplanar columns → flat box → zero volume → **not invertible**
($Z=[1,0,1;0,1,1;1,1,2]$, col3=col1+col2, $\det 0$), landing the same chain $\det\ne0\Leftrightarrow$ independent
$\Leftrightarrow$ invertible. **Hook:** a parallelogram → a box; one number is its volume, and computing it needs nothing new.
**Tier E / extension previews 5.3:** apply a matrix to the unit **cube** → image volume $=|\det A|$ (the volume-scaling factor),
incl. a reflection ($\det\,\mathrm{diag}(2,3,-1)=-6$) and a $\det=0$ collapse. **Numbers thread through:** the $2\times2$ minor
$[3,1;1,2]=5$ appears in the warmup (all three warmup items are literally the pieces of cofactor expansion) and is the first term
of the notes' $\det 8$; the notes spine $[2,1,0;1,3,1;0,1,2]$ echoes 5.0's $[2,1;1,3]\to 5$. **Custom parallelepiped TikZ** (burgundy
$a_1$, green $a_2$, blue $a_3$ column-edges, shaded visible faces, dashed hidden edges, "volume = |det A|") on notes §1 + slides hook.
**Built `make -C unit05/lesson01 all` → clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math; no overfull >15pt). Page
counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 5pp,
lesson plan 2pp; **student 10pp, full 17pp**. Visually spot-checked notes_key p1 (parallelepiped figure — clean, three colored edges,
dashed hidden edges) and p2 (cofactor expansion, triangular shortcut, $\det Z=0$ — all correct). All arithmetic hand-verified in
pure Python (no numpy/sympy on this host). **Gotcha:** BSD `awk` on macOS lacks GNU `match(...,arr)` — use `grep`/`perl` for the
overfull-hbox scan.

**Confirmed Unit 5 lesson map** (unchanged):

| Lesson | Section (topic) | Status |
| --- | --- | --- |
| 5.0 (lesson00) | Setting Up Determinants --- the 2 by 2 Determinant, Area, and Orientation (on-ramp, mirrors 4.0/2.0) | **authored & built** |
| 5.1 (lesson01) | 3 by 3 Determinants (Strang §5.1) | **authored & built** |
| 5.2 (lesson02) | Properties and Applications of Determinants (Strang §5.2) | **authored & built** |
| 5.3 (lesson03) | Linear Transformations (Strang §5.3) | **authored & built** |

Unit 5 summative tests (`tests/practice_test` + `actual_test`, `test_keys/practice_test_key` + `actual_test_key`) are **authored &
built**; `sample_test`/`sample_test_key` populated by `drop` (practice test + key, 3pp each). **Unit 5 is now fully complete — nothing
left.** Lessons 5.0/5.1/5.2/5.3 are the Unit 5 models; Unit 4 tests + these Unit 5 tests are the assessment-format model; Lesson 4.0
remains the cross-unit style model.

---

**Prior run:** **Authored & built the Unit 4 summative tests — Unit 4 is now complete.**
Filled all four skeletons (`tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`,
`test_keys/actual_test_key`), mirroring the Unit 1–3 test format (`shared/tests.mk` + `test_keys.mk`;
`\parthead` burgundy strips; Part A vocab matching / B multiple choice / C computation / D extended
response). **Blueprint spans the whole unit §4.0–4.4:** A (8 terms — orthonormal vectors, orthogonal
matrix $Q$, projection matrix, normal equations, least squares, residual, orthogonal complement,
Gram--Schmidt), B (6 MC concept checks across 4.1–4.4), C (7 items — orthogonal complement $V^\perp$
dot-product test 4.1; projection onto a line $\hat x=\avec\cdot\bb/\avec\cdot\avec$ 4.2; projection onto a
subspace via normal equations $A^{\T}A\hat\xx=A^{\T}\bb$ + $A^{\T}\ee=\zero$ 4.2; least-squares line fit
$y=C+Dt$ + residuals + $\sum e_i=0$ 4.3; orthonormal test + $Q^{\T}Q=I$ 4.4; coordinates by dot product
$c_i=q_i\cdot\bb$ 4.4; Gram--Schmidt building $Q$ 4.4), D (2 items — why best fit ⇒ $\ee\perp C(A)$ ⇒
$A^{\T}\ee=\zero$ + all-ones ⇒ $\sum e_i=0$; why orthonormal $Q$ ⇒ coords are dot products and least
squares collapses to $\hat\xx=Q^{\T}\bb$). **Practice vs. actual use parallel-but-distinct numbers**
(practice: $\avec=(1,1),\bb=(3,1)$; $A=[[1,0],[1,1],[1,2]],\bb=(6,0,0)\to\hat\xx=(5,-3)$; fit
$(0,3)(1,3)(2,5)(3,9)\to y=2+2t$; $q=\tfrac15(3,4),\tfrac15(4,-3)$; GS $(3,4),(1,0)$. actual:
$\avec=(1,2),\bb=(4,3)$; $A=[[1,1],[0,1],[1,1]],\bb=(1,1,3)\to\hat\xx=(1,1)$; fit $(0,4)(1,2)(2,6)\to
y=3+t$; $q=\tfrac13(1,2,2),\tfrac13(2,1,-2)$; GS $(4,3),(1,0)\to Q=\tfrac15[[4,3],[3,-4]]$). **All arithmetic
hand-verified in Python (exact fractions):** every projection, normal-equation solve, residual, $A^{\T}\ee$,
orthonormality check, coordinate dot product, and Gram--Schmidt remainder. Built `make -C unit04/tests all`
and `make -C unit04/test_keys all` → **clean** (0 `^!`/file-line errors across all 4 logs; no `\ans`-in-math).
Page counts: practice test 3pp, actual test 3pp, practice key 3pp, actual key 2pp; `drop` published
`sample_test/main.pdf` (practice, 3pp) and `sample_test_key/main.pdf` (practice key, 3pp). Visually
spot-checked both keys' Part C/D pages (matrices, dot products, checkmarks, teacher-note box) — clean.
**Unit 4 is now fully complete (lessons 4.0–4.4 + tests); next run begins Unit 5 (Determinants and Linear
Transformations).**

**Prior run:** **Authored & built Unit 4 Lesson 4.4 — "Orthogonal Matrices and
Gram--Schmidt" (§4.4) — the final lesson of Unit 4.** Filled every skeleton: lesson plan, cover, warmup,
notes, activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 4.3's
preamble/boxes/tone. **Content — turns the whole unit's machinery ``free'' when columns are orthonormal:**
(1) **orthonormal vectors** — perpendicular \emph{and} unit length ($q_i\cdot q_j=0$, $q_i\cdot q_i=1$);
normalize the 4.0 pair $(3,4),(4,-3)$ (length 5) → $q_1=\tfrac15(3,4)$, $q_2=\tfrac15(4,-3)$; (2) **the
matrix $Q$** with $Q^{\T}Q=I$ (column $i\cdot$ column $j$), and $Q^{\T}=Q^{-1}$ when square; (3)
**coordinates for free** — $\bb=\sum(q_i\cdot\bb)q_i$; e.g. $\bb=(5,0)\to 3q_1+4q_2$, no solving; (4)
**least squares becomes trivial** — with $A=Q$, the 4.3 normal equations collapse to $\hat{\xx}=Q^{\T}\bb$,
$\pp=QQ^{\T}\bb$; (5) **Gram--Schmidt** — normalize the first, subtract the overlap
$B=\avec_2-(q_1\cdot\avec_2)q_1$, normalize the remainder; \emph{why} it works: $q_1\cdot B=0$ (removed the
parallel part); previews $A=QR$ ($R=Q^{\T}A$ upper triangular). **Hook:** graph paper vs. a skewed grid —
orthonormal $=$ ``perfect graph paper.'' **Worked spine (all hand-verified in Python, exact fractions):**
GS on $\avec_1=(3,4),\avec_2=(1,0)\to Q=\tfrac15[[3,4],[4,-3]]$; QR $A=[[3,1],[4,0]]=QR$ with
$R=[[5,3/5],[0,4/5]]$. Activity: Tier R normalize/test $(1,2,2),(2,-2,1)$ (both length 3, $\perp$) →
$\tfrac13$; Tier A verify $Q^{\T}Q=I$ + coords of $\bb=(10,5)\to 10q_1+5q_2$; Tier E GS on
$(4,3),(1,0)\to\tfrac15[[4,3],[3,-4]]$ + justify $q_1\cdot B=0$. Exit: orthonormality of $\tfrac13(2,2,1),
\tfrac13(2,-1,-2)$, normalize $(1,1,1,1)$ (length 2), and why $Q^{\T}Q=I\Rightarrow\hat{\xx}=Q^{\T}\bb$. HW:
orthonormal test $\tfrac13(1,2,2),\tfrac13(2,1,-2)$; coords $\bb=(5,10)\to 11q_1-2q_2$; GS
$(3,4),(0,1)\to\tfrac15[[3,-4],[4,3]]$; extension $A=QR$ with $R=[[5,4/5],[0,3/5]]$ (verified $QR=A$).
**Custom orthonormal-axes TikZ** (burgundy $q_1$, blue $q_2$, hand-computed right-angle square — no `calc`
dependency, ``both length 1'' label) on notes §1 + slides hook. **Built `make -C unit04/lesson04 all` →
clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math; only overfull is the shared 10.77pt
`\namedateperiod` header). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp
blank / 3pp key, activity/homework 2pp, slides 6pp, lesson plan 2pp; **student 10pp, full 18pp** (matches
4.0–4.3). Visually spot-checked notes_key p1 (orthonormal-axes figure — right-angle mark crisp, arrows/labels
clean) and slides hook — all clean. **Gotchas fixed at build:** defined `\ww` in the activity + activity_key
preambles (Tier R uses $\vv,\ww$) and `\avec` in the lesson-plan preamble (vocab table uses $\avec_1,\avec_2$)
— the same ``define every math-vector macro the body uses'' trap. **Unit 4 lessons (4.0–4.4) are now all
authored & built; next run authors the Unit 4 summative tests.**

**Prior run:** **Authored & built Unit 4 Lesson 4.3 — "Least Squares Approximations"
(§4.3).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the
five keys) and the slides deck, mirroring Lesson 4.2's preamble/boxes/tone. **Content — turns 4.2's
projection into a data method:** (1) **overdetermined $A\xx=\bb$** — fitting $y=C+Dt$ to $m$ points gives $m$
equations, 2 unknowns; $\bb\notin C(A)$, so \emph{no} exact solution; (2) **best $=$ closest $=$ projection**
(Lesson 4.2) — the least-squares $\hat\xx$ makes $\pp=A\hat\xx$ nearest $\bb$; (3) **normal equations**
$A^{\T}A\hat\xx=A^{\T}\bb$ (same as 4.2, now for data) — the $2\times2$ solve gives $(C,D)$; (4) **fitted
values $\pp=A\hat\xx$, residuals $\ee=\bb-\pp$** — least squares minimizes $\|\ee\|^2$ (squares can't cancel);
(5) **where the error goes** — $A^{\T}\ee=\zero\Rightarrow\ee\in N(A^{\T})$ (4.1 payoff), and the all-ones
column forces $\sum e_i=0$. **Hook:** stretch a spring, ruler slightly off, 4 points miss any line → what is
"best"? **Worked spine (all hand-verified):** spring data $t=(0,1,2,3)$, $\bb=(3,3,5,9)$,
$A=[[1,0],[1,1],[1,2],[1,3]]$ → $A^{\T}A=[[4,6],[6,14]]$, $A^{\T}\bb=(20,40)$, $\hat\xx=(2,2)$, line $y=2+2t$,
$\pp=(2,4,6,8)$, $\ee=(1,-1,-1,1)\in N(A^{\T})$ (±1 residuals — looks like real scatter). Activity: Tier R
**best constant $=$ mean** (single $1$s column, $\bb=(4,6,8)\to\hat C=6$), Tier A 3-pt fit
$(0,3)(1,1)(2,5)\to y=2+t$, Tier E 4-pt sales fit $(2,1,2,5)\to y=1+t$ + predict $t=4$ + interpret. Exit:
3-pt fit $(0,4)(1,2)(2,6)\to y=3+t$ (same $A^{\T}A$ as notes, new data). HW: best constant $(2,5,8)\to5$;
3-pt $(0,1)(1,0)(2,5)\to y=2t$; 4-pt plant $(4,4,6,10)\to y=3+2t$, predict $t=4=11$; extension checks
$A^{\T}\ee=\zero$ and $\sum e_i=0$. **Custom scatter+residual TikZ** (blue data points, burgundy best-fit
line, dashed vertical residuals, "data" label) on notes §4 + slides hook. **Built `make -C unit04/lesson03
all` → clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math; only overfull is the shared 10.77pt
`\namedateperiod` header + ≤6pt cosmetic). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page
constraint), notes 2pp blank / 3pp key, activity/homework 2pp, slides 6pp, lesson plan 2pp; **student 9pp,
full 18pp** (matches 4.1/4.2). Visually spot-checked notes_key p2 (scatter+residual figure — clean, dashes
crisp, best-fit line through the points) and slides hook — all clean. **Gotchas avoided:** simplified the
notes figure to explicit display coords (no nested `xscale/yscale` gymnastics); chose 4 equally-spaced
points so the min integer residual $(1,-1,-1,1)$ is small (3 points force a $\pm2$ middle residual). **Next
run: author Lesson 4.4** ("Orthogonal Matrices & Gram--Schmidt"). Lesson 4.0 remains the Unit 4 model.

**Prior run:** **Authored & built Unit 4 Lesson 4.2 — "Projections onto Subspaces"
(§4.2).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the
five keys) and the slides deck, mirroring Lesson 4.1's preamble/boxes/tone. **Content — turns 4.1's
"error lands in the complement" into a method:** (1) **closest $=$ perpendicular error** — the closest
point $\pp$ on a line to a target $\bb$ is where $\ee=\bb-\pp\perp$ the line (drop a perpendicular, from
4.0); (2) **projection onto a line** — force $\avec\cdot(\bb-\hat{x}\avec)=0$ ⇒
$\hat{x}=\frac{\avec\cdot\bb}{\avec\cdot\avec}$, $\pp=\hat{x}\avec$; (3) the **projection matrix**
$P=\frac{\avec\avec^{\T}}{\avec^{\T}\avec}$ (line), $\pp=P\bb$, $P\pp=\pp$/$P^2=P$; (4) **projection onto
a subspace** $C(A)$ — error ⊥ every column ⇒ $A^{\T}\ee=\zero$ ⇒ the **normal equations**
$A^{\T}A\hat{\xx}=A^{\T}\bb$, then $\pp=A\hat{\xx}$; (5) **where the error goes** — $\ee\in N(A^{\T})$, the
orthogonal complement of $C(A)$ (the 4.1 payoff), so projection splits $\bb=\pp+\ee$. **Hook:** drone off
a straight road, closest point = foot of the perpendicular (its shadow). **Worked spine:** line
$\avec=(1,2)$, $\bb=(4,3)$ → $\hat{x}=2$, $\pp=(2,4)$, $\ee=(2,-1)$; subspace
$A=[[1,0],[1,1],[1,2]]$, $\bb=(6,0,0)$ → $\hat{\xx}=(5,-3)$, $\pp=(5,2,-1)$, $\ee=(1,-2,1)\in N(A^{\T})$
(the least-squares matrix, treated purely as "project onto a plane" — reserves line-fitting for 4.3).
Activity Tier E uses fresh $A=[[1,1],[0,1],[1,1]]$, $\bb=(1,1,3)$ → $\hat{\xx}=(1,1)$, $\pp=(2,1,2)$,
$\ee=(-1,0,1)$; homework reuses the notes $A$ with $\bb=(2,1,6)$ → $\hat{\xx}=(1,2)$, $\pp=(1,3,5)$,
$\ee=(1,-2,1)$. **All projections/dot products hand-verified in Python (fractions; every $\avec\cdot\ee$
and $A^{\T}\ee$ is $0$).** Custom **closest-point TikZ figure** ($\bb$ blue, $\pp$ on line burgundy, $\ee$
dashed + right-angle mark via `calc`) on notes §1 + the slides hook. **Built `make -C unit04/lesson02 all`
→ clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math). Page counts: cover/warmup/exit 1pp (blank
& key ✓ 1-page constraint), notes 2pp blank / 3pp key, activity/homework 2pp (blank & key), slides 6pp,
lesson plan 2pp; **student 9pp, full 18pp** (matches 4.1). Visually spot-checked notes_key p1
(closest-point figure — clean, right-angle mark crisp), p3 (teachernote), slides hook — all clean.
**Gotchas avoided:** used `\avec` for vector $a$ (not built-in `\aa`=å); defined `\zero` in the
exit_ticket key preamble (blank didn't need it); in the key denominator fill used `{\color{keyred}\avec}`
(not nested `\mathbf{\avec}`). **Next run: author Lesson 4.3** ("Least Squares Approximations"). Lesson 4.0
remains the Unit 4 model.

**Prior run:** **Authored & built Unit 4 Lesson 4.1 — "Orthogonality of the Four
Subspaces" (§4.1).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket,
homework (+ the five keys) and the slides deck, mirroring Lesson 4.0's preamble/boxes/tone.
**Content — extends §3.6 from "perpendicular" to "orthogonal complements":** (1) lift $\vv\cdot\ww=0$
from vectors to **orthogonal subspaces** (every vector ⊥ every vector; check basis-vs-basis; the
two-walls-share-a-line counterexample → orthogonal subspaces meet only at $\zero$); (2) **why**
$N(A)\perp C(A^{\T})$ — read $A\xx=\zero$ *row by row*, every row·$\xx=0$ ⇒ $\xx\perp$ whole row space;
transpose ⇒ $N(A^{\T})\perp C(A)$; (3) the new idea past 3.6 = **orthogonal complement** = perpendicular
**and** dims fill the room ($r+(n-r)=n$), so nullspace is *every* vector ⊥ the row space; counterexample
two ⊥ lines in $\mathbb{R}^3$ ($1+1\ne3$); (4) **punchline** $V^{\perp}=$ nullspace of the matrix whose
rows span $V$ (activity Tier E + homework ext) → sets up projection in 4.2. **Hook:** tabletop plane +
the one perpendicular (up/down) line = complements filling $\mathbb{R}^3$. **Worked example reuses the
3.5/3.6 spine** $A=[[1,1,2],[2,1,3],[3,2,5]]$ ($r=2$, null dir $\xx=(-1,-1,1)$, left-null dir
$\yy=(1,1,-1)$); activity uses a fresh rank-2 $B=[[1,2,3],[2,4,6],[1,1,1]]$ ($\xx=(1,-2,1)$,
$\yy=(2,-1,0)$); homework uses $C=[[1,0,1],[0,1,1],[1,1,2]]$ ($\xx=(-1,-1,1)$, $\yy=(1,1,-1)$). All dot
products hand-verified. Two-room **big-picture TikZ diagram** (blush/skyblue boxes, $\perp$ via
`text=<color>`, arrow $A$) on notes §3 + a slide; custom tabletop-plane+normal hook figure on the slides.
**Built `make -C unit04/lesson01 all` → clean** (0 `^!` errors across all 13 logs; no `\ans`-in-math).
Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 2pp blank / 3pp key (key adds
answers + teachernote), activity/homework 2pp (blank & key), slides 6pp, lesson plan 2pp; **student 9pp,
full 18pp.** Visually spot-checked notes_key p2 (two-room diagram — $\perp$ clean, no tofu), slides
big-picture + tabletop-hook frames — all clean. **Gotcha avoided:** kept the extensionbox/spiralbox macros
(`\avec\bb\pp`) in the *preamble* (an early draft defined `\avec` mid-body, after first use). **Next run:
author Lesson 4.2** ("Projections onto Subspaces"). Lesson 4.0 remains the Unit 4 model.

**Prior run:** **Authored & built Unit 4 Lesson 4.0 — "Right Angles Revisited --- Setting Up
Orthogonality" (the intro/spiral lesson).** Filled every skeleton: lesson plan, cover, warmup, notes, activity,
exit_ticket, homework (+ the five keys) and the slides deck, mirroring Unit 3's lesson-3.0 preamble/boxes/tone.
**Content — spiral + roadmap for Orthogonality:** (1) recall the **dot product** $\vv\cdot\ww$, its **sign**
(acute/right/obtuse), **length** $\|\vv\|=\sqrt{\vv\cdot\vv}$, and **unit vector** (Lessons 1.0/1.2); (2) the one
big idea **perpendicular $\Leftrightarrow$ dot $=0$** — check $(3,4)\cdot(4,-3)=0$, and *solve* for orthogonality
($2x-6=0\Rightarrow x=3$); (3) the **four subspaces are perpendicular pairs** (§3.6 spiral) — read $A\xx=\zero$
row by row so every row $\perp\xx$, verified on $A=[[1,2],[2,4]]$, null dir $(-2,1)$; (4) roadmap **drop a
perpendicular** — closest point / projection, previewing 4.1→4.4. **Hook:** hiker off a straight trail, shortest
route back is the perpendicular (motivates projection/least squares). Two TikZ figures (right-angle mark on
$(3,4)\perp(4,-3)$; closest-point/projection diagram) + a projection-preview extension deriving
$t=\frac{\avec\cdot\bb}{\avec\cdot\avec}$ (activity Tier E + homework). All numbers hand-checked. **Built
`make -C unit04/lesson00 all` → clean** (0 `^!` errors on a full 13-file scan; no `\ans`-in-math). Page counts:
cover/warmup/exit 1pp (blank & key), notes 3pp (blank & key), activity/homework 2pp (blank & key), slides 6pp,
lesson plan 2pp; **student 10pp, full 18pp.** Visually spot-checked notes_key p2 (both figures), lesson plan p1,
slide 4 — clean. **Gotchas fixed:** (a) `\aa` is LaTeX's built-in å — renamed the column-vector macro to `\avec`
across all 8 files that used it (same trap as `\ss`, already flagged in Notes below); (b) the `($(p)+(...)$)`
right-angle marks need `\usetikzlibrary{calc}` — added to notes/notes_key/slides (self-contained, no `shared/`
change); (c) `\pp` must be defined per-file — added to the activity/homework blanks (keys already had it).
**Next run: author Lesson 4.1** ("Orthogonality of the Four Subspaces"). Lesson 4.0 is the Unit 4 model.

**Prior run:** **Scaffolded all of Unit 4 (Orthogonality) — skeletons only.**
Ran `new_lesson.py` for lessons 4.0–4.4 (component set: cover, warmup, notes, activity, exit_ticket, homework,
slides + keys for keyed components). The 4.0 run created the unit, so `unit04/tests/` (practice + actual),
`unit04/test_keys/` (both keys), `unit04/sample_test/`, `unit04/sample_test_key/`, `unit04/Makefile`, and the
thin-include test Makefiles were all auto-scaffolded too. **Confirmed lesson map (5 lessons):** 4.0 "Right Angles
Revisited --- Setting Up Orthogonality" (intro/spiral) · 4.1 "Orthogonality of the Four Subspaces" · 4.2
"Projections onto Subspaces" · 4.3 "Least Squares Approximations" · 4.4 "Orthogonal Matrices and Gram--Schmidt" —
matches `spec/linear_algebra_v2.md` §4.1–4.4 exactly plus the customary `lesson00` intro. `sample_test`/
`sample_test_key` PDFs are NOT yet populated (they come from `drop` after the tests are authored).

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
| 4 | Orthogonality | 4.0 intro + 4.1–4.4 | ☑ all lessons + tests authored & built ✅ |
| 5 | Determinants and Linear Transformations | 5.0 intro + 5.1–5.3 | ☑ all lessons + tests authored & built ✅ |
| 6 | Eigenvalues and Eigenvectors | 6.0 intro + 6.1–6.4 (§6.4 optional) | ◧ scaffolded; **6.0/6.1/6.2 authored & built ✅**; 6.3–6.4 + tests skeleton |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.1–7.4 | ☐ |
| 8 | Learning from Data *(optional enrichment)* | 8.1–8.4 | ☐ |

## Next steps

1. **Author Unit 6 (Eigenvalues and Eigenvectors)** — Unit 6 is **scaffolded**; lesson map is **confirmed** (5 lessons,
   incl. the optional §6.4 — user chose to include it): 6.0 "Special Directions --- Setting Up Eigenvalues" (intro,
   **authored & built ✅**) · 6.1 "Introduction to Eigenvalues" (**authored & built ✅**) · 6.2 "Diagonalizing a Matrix"
   (**authored & built ✅**) · 6.3 "Symmetric Positive Definite Matrices" · 6.4 "Systems of Differential Equations".
   **Next: author Lesson 6.3** ("Symmetric Positive Definite Matrices", §6.3 — symmetric matrices always diagonalize, with
   \emph{perpendicular} eigenvectors: $A=Q\Lambda Q^{\T}$; positive definite ⇔ all $\lambda>0$), then 6.4, and finally the
   Unit 6 summative tests (Unit 4 + Unit 5 tests are the format model). 6.0/6.1/6.2 are the Unit 6 models; Lesson 4.0 the
   cross-unit style model. Content comes from Strang §6.3–6.4.
2. *(optional)* Rebuild the whole Unit 1–5 packets (`make -C unitXX student|full`, or `make student|full`
   at the root) to confirm the `sample_test`/`sample_test_key` drop-ins merge in as expected.

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
