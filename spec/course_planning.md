# Course Planning Log

Running handoff log for the Linear Algebra course build. The **lesson-planning skill reads
this at the start of every run (Step 0) and overwrites it at the end (Step 6)** with the
current state and next steps. Keep it terse and current — it should always describe reality
*now*, not a changelog.

---

**Last updated:** 2026-08-06 — **Wrote `spec/course_breakdown.md`, the course-wide unit-and-lesson map** (8 units, 41 lessons,
one line of "students can…" per lesson, plus the `X.0` on-ramp / 3.6-capstone conventions and the assessment map). Auditing
the tree for it turned up one **stale claim in this log**, now corrected: Unit 8 lessons **8.3 and 8.4 are authored**, not
skeletons, and the Unit 8 tests are authored too. No `.tex` was edited and nothing was built this run.

**Prior run:** 2026-08-03 (later) — **Retrofitted the Unit 1 and Unit 2 summative TESTS with teachernote → work rule → boxguard,
and retired the test-key `teachernote` exemption course-wide.** All four practice/actual pairs now come out **3pp blank = 3pp key**,
breaking at identical points; the eight test keys carry no teacher prose at all — it moved to a new **page 2 of
`unitXX/unit_cover_key/`**, which `shared/unit.mk` merges into the **key packet only**. Details in "Unit 1–2 test retrofit" directly
below. Prior runs: the Unit 2 cover sheet, the Unit 2 five-convention retrofit (Lessons 2.0–2.4), the Unit 1 cover sheet, and the
Lesson 1.0–1.4 retrofits, all detailed further down.

---

## Unit 1–2 test retrofit (`tests/` + `test_keys/`) — 2026-08-03

**Scope:** the user asked for the conventions on "the unit sample and actual tests" for **Units 1 and 2 only** — 8 files
(`practice_test`, `actual_test`, and their keys). Order run: **teachernote → work rule → boxguard** (vocabpar and namestrip do not
apply: tests have no `vocabbox`, and they legitimately keep their name row).

**Baseline — measure, don't assume.** U1 practice 3pp/2pp **mismatch** (this was the long-standing `unit01` 74/73 packet gap),
U1 actual 2/2 aligned, U2 practice 3/3 aligned, U2 actual 3pp/2pp **mismatch**. All 32 course test files opened with **zero** `work`
blocks and **zero** `\boxguard`; every blank carried the drift-prone 13-`\vspace` pattern against inline `\ans` in the key.

**1. teachernote — the exemption is GONE, and a new home was built for the prose.**

- `references/conventions.md` used to exempt unit-test keys ("not page-matched into a student packet, so their keys keep scoring
  guidance in a `teachernote`"). **That premise was wrong in one direction that matters:** `unit.mk` substitutes `sample_test_key`
  for `sample_test` at the tail of the key packet, so a longer key *does* cost packet alignment. The user's call: no exemption;
  all teacher notes leave the keys.
- **The destination is a new `unitXX/unit_cover_key/main.tex`** — page 1 is the existing cover, page 2 is all four scoring notes
  (practice + actual, Part B rationale + Part D scoring), so **cover + notes = one double-sided teacher sheet**.
- **The leak this had to avoid, and how.** The unit cover is merged into **both** packets, so simply appending page 2 would have put
  the practice test's own answer rationale ("rank $1$ because column 2 is $2\times$ column 1") and Part D weights ($c=2,d=1$) into
  every **student** packet — the practice test is bound in there. Fix: `unit_cover/main.tex` stays the 1pp student cover;
  `unit_cover_key/main.tex` is the 2pp teacher form; **both `\input` a shared `unit_cover/body.tex`** so page 1 is
  byte-identical by construction (verified pixel-identical at 60 dpi). `shared/unit.mk` gained `HAS_UNIT_COVER_KEY` and a
  `_unit_cover_key` rule, and the `key` target now uses `$(or $(UNIT_COVER_KEY_PDF),$(UNIT_COVER_PDF))` — **a unit with no
  `unit_cover_key/` falls back to the plain cover in both packets, so Units 3–8 are untouched** (dry-run confirmed on unit03).
- 8 notes removed from the four test keys; 4 titled notes now on each cover key. **`movenotes.py` was not usable** — it only targets
  a lesson directory, and a unit test has no lesson plan. Done by hand.
- **`finals/*_key/` keeps its notes** and is called out as such in the docs: `finals/` has no cover and is merged into no packet, so
  there is nowhere to move them and nothing to gain. **This is the one loose end from the "no exemption" decision.**

**2. work rule — 36 byte-identical `work` blocks (9 per file), checksum-verified.** They replaced the
`\vspace{1.2–2.6cm}`-in-blank / inline-`\ans`-in-key pattern and unified the hand-tuned `itemsep` drift (Part C 13pt/12pt → 12pt,
Part D 16pt/12pt → 14pt). Removing the teachernotes had *shortened* the keys and pushed **U2 practice from aligned into 3/2**, so
three of four pairs were mismatched going in; the work rule closed **all three**, and took U1 actual 2/2 → 3/3 (more writing room,
still aligned). All Part C/D arithmetic was **re-verified in pure Python for both forms before authoring — 48/48 checks pass.**

**Two findings worth carrying forward:**

- **(j) The `work` block does NOT drift — prove it before blaming it.** Mid-run the key looked ~6.6pt taller per item. An isolation
  smoke doc (same block, `-boxes` vs `-key`) measured the reserved gap at **104.98pt on both sides, identical**. The apparent drift
  was ordinary page glue: `\abovedisplayskip`/`\belowdisplayskip` are rubber, so a page that must squeeze shrinks them. **Measure
  the block in isolation before editing anything.**
- **(k) The real prose drift is `\writeline` vs `\ansline`, and it is ~12.4pt every time.** `\writeline` is a bare rule (~4pt line);
  `\ansline{text}` is a full text line. Two of them in Part C were enough to tip an item over a page edge. **The fix that beats
  `\writelines{n}`: fold short prose answers into the shared `work` block as a `\text{}` row** — byte-identical, zero drift. Applied
  to Unit 1 Part C (Unit 2's Part C was already fully in work blocks). Part D's prose pairs were left as `\writeline`/`\ansline`:
  they sit on p3 with slack and move no break.

**3. boxguard — 12 guards, all mirrored blank and key, all free (no page gained).**

- **`\boxguard[12]` before `\parthead{Part C}` on both *actual* tests** (4 files). Part C was opening at the foot of p1, splitting
  item 1's prompt from the space for its answer. Now both actual tests match the practice form: Parts A+B on p1, Part C on p2,
  Part D on p3.
- **`\boxguard[14]` before the last Part C item on all 8 files.** Same defect, one page later: the final item's prompt sat at the
  foot of p2 with its answer block atop p3. Now that item is whole at the top of p3 on both sides.
- **`\boxguard` works between `\item`s** (vertical mode after a `work` block's `\par`) — placed on its own line before the `\item`.
  Worth knowing: the documented sites so far were all before a `tcolorbox`.
- **No `\tcbbreak` was needed** — the only boxes in a test are the `remindbox` and the `\parthead` strips, and none was ever
  stranded as a sliver.

**(e) confirmed, with a trap:** `pdftotext` reports only *visible* words, and a blank's `work` blocks have **no text layer by
design** — so a first-words comparison makes blank and key look like they break differently when they do not. **Compare a marker
that prints on both sides** (the Part D strip): it lands at an **identical y on an identical page in all four pairs.**

**Verified:** `make -C unitXX/tests all` and `make -C unitXX/test_keys all` exit 0 for both units and republished all four
`sample_test*/main.pdf`; every pair **3pp/3pp**; 36/36 work blocks byte-identical by checksum; **zero** `\ans` inside `$...$`;
**zero** `teachernote` in any test key (4 on each cover key); max overfull `\hbox` **10.77pt** (the standard pageheader banner);
both cover keys **2pp** with page 1 pixel-identical to the student cover; and `pdftotext` on all four **blanks** finds **zero**
solution strings (against 677/647/732/683 words of real prompt text, and a key control that does hit). **Leak check: "Exam Scoring
Notes" appears 0 times in either student packet and on p2 of both key packets.** Unit packets rebuilt: **unit01 74/75 and unit02
74/75** — key = student + exactly the one teacher-notes page, with the sample-test pair now 3/3 on both sides, so **Unit 1's
old 74/73 deficit is gone**. `git status` shows only the 12 edited sources, the 4 new files, and the 4 republished sample PDFs —
nothing compiled in place.

**Not done (out of scope this run):** Units 3–8 tests are still un-retrofitted (24 files, same uniform baseline: no `work`, no
`\boxguard`, 13 `\vspace` per blank, 2 teachernotes per key) and Units 3–8 have no `unit_cover/` at all — **a unit needs one before
its test notes have anywhere to go**, so cover-sheet authoring is now a prerequisite for the test retrofit there. `finals/` keys
keep their teachernotes.

---

## Unit 2 retrofit (Lessons 2.0–2.4) — 2026-08-02

**Baseline: all five lessons opened fully aligned** — warmup 1/1, notes 3/3, activity 2/2, exit 1/1, homework 2/2, every one.
That is 5 for 5, so expectation (a) below ("a `homework` 2pp/1pp baseline defect is common") is now **8 aligned out of 10 lessons**;
only 1.0 and 1.1 ever had it. **Measure, don't assume.**

**What each convention did, across the unit:**

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro in all five `notes` + `notes_key` pairs (10 files). Every lesson in
   Unit 2 had the collision.
2. **teachernote** — `movenotes.py` lifted **21 notes** into the plans (4 each for 2.0–2.3, **5 for 2.4** — 2.4 was the only lesson
   in the unit whose `homework_key` also carried one). Every plan grew 2pp → 3pp. No `_key` carries a note now.
3. **namestrip** — 50 name rows removed (5 components × blank/key × 5 lessons), including a `\namepartnerperiod` in each activity
   pair; every `cover/` kept its row. **Opened no new mismatch on any of the five** — the first unit where namestrip was free
   throughout, despite every lesson having a five-term `vocabbox`. Confirms (d): the vocabbox height gap is always there, but
   whether it surfaces depends on where the page break happens to fall.
4. **work rule** — **99 byte-identical `work` blocks** (2.0: 17, 2.1: 20, 2.2: 23, 2.3: 22, 2.4: 17), all checksum-verified. They
   replaced the usual `\vspace{0.2–2.4cm}`-in-blank / `\ans`-or-`\ansline`-in-key pairs and let the hand-tuned `itemsep` drift be
   unified per file (12/11 → 10, 9/7 → 8, 16/15 → 14/13, 8/6 → 8/7). **A NEW defect shape showed up in Unit 2 and is worth naming:
   the key-only `{\footnotesize (...)}` parenthetical** — a bracketed one-line hint appended after an answer with no counterpart in
   the blank. Found **10 of them** (2.0 warmup ×1; 2.1 warmup ×1, activity ×1, exit ×1, homework ×2; 2.2 warmup ×2, homework ×1;
   2.3 warmup ×2, activity ×1). Each became a shared `work` block. **Grep every key for `\footnotesize` before starting.**
5. **boxguard** — 12 guards total, mirrored blank and key:
   - **`\boxguard` before the `notes` `practicebox` in all five lessons.** This is now the single most reliable guard site in the
     course: in every Unit 2 lesson the **key** stranded practicebox items atop p3 while the blank carried the box whole, exactly
     the vocabbox-gap asymmetry finding (g). The **default 16 lines fired in the key and stayed inert in the blank** every time —
     no lesson needed a raised `[n]`.
   - **`\boxguard` before `notes` box 4 in 2.1 and 2.3**, where the *blank* stranded a one-line tail atop p3. **Sizing note that
     corrects an earlier mis-measure: at 55 dpi a letter page is 595 px tall and the text block ~550 px, so ~110 px of free space
     is ~12 lines, not ~6.** A first attempt at `\boxguard[8]` was inert; the default 16 was correct. **Measure free space against
     the full 11 in page, not a 9 in guess.**
   - **`\tcbbreak` in 2.0 (activity Tier A before item 4; homework before item 4) and 2.3 (activity Tier A before Order 2).** All
     free.
   - **Two guards were measured and DECLINED because they cost a page** (and, in one case, the blank/key match):
     `\tcbbreak` before homework item 4 in **2.2** took both sides 2pp → 3pp, and `\tcbbreak` before homework item 5 in **2.3**
     took the key alone to 3pp. In both the box was already breaking with a substantial chunk on each side, so the trade was wrong.
     **Reverted; this is the (b)-limit working as documented.**
   - **In 2.3 a guard was MOVED rather than removed:** `\tcbbreak` before activity Tier A item 4 left that one-line item alone atop
     p2. Moving the break up one item (before Order 2) gives p2 a two-item chunk instead. **When a `\tcbbreak` leaves a thin
     opening on the next page, move it earlier rather than dropping it.**

**Three content defects found and fixed** (none of them a pagination issue; all three were invisible to the page counts):

- **2.0 activity, Tier A item 4 — the numbers contradicted the question.** The prompt asked what "goes wrong" with a target of
  $8$ g protein / **$4$** g fiber, but that target solves cleanly as $(4,0)$ — nothing goes wrong. The key's own answer
  ($x_2=-\tfrac45$, $x_1=\tfrac{22}{5}$) requires a **$2$ g** fiber target. Changed the prompt to $2$ g in blank and key; verified
  in Python. **The teacher note in the plan ("a system can be mathematically solvable yet physically impossible") is now true.**
- **2.2 notes — three prose lines credited Lesson 2.1 for numbers that are 2.2's own.** §1 called $\ell=2\div1$ "our system's
  multiplier from 2.1" (2.1's pivot was $2$), §1 called $E_{21}\bb=[7,1]^\top$ "the triangular system from 2.1" (2.1's was
  $[13,1]^\top$), and §3 called $(4,1)$ "matching 2.1's answer" (2.1's was $(5,1)$). 2.2 runs the **bakery** system
  $A=[\begin{smallmatrix}1&3\\2&7\end{smallmatrix}]$, not 2.1's. Re-voiced all three to describe 2.2's own example.
- **2.3 notes — the same defect inherited.** §3 called $\cc=[7,1]^\top$ "the updated right-hand side from 2.1" and the solution
  "the same answer as 2.1 and 2.2." Both now credit **2.2**, which is the lesson those numbers actually come from.

**Lesson for later retrofits: check cross-lesson references whenever a lesson reuses a running example.** Units carry an example
forward (2.2 and 2.3 both reuse 2.1's *method* on 2.2's *numbers*), and the prose drifts one lesson behind the arithmetic. Grep
each lesson's notes for references to a neighbouring lesson number and re-verify the cited value.

**The `homework_key` answers-in-the-prompt defect is 10 for 10** — every Unit 2 lesson had it, and Unit 2 escalates the pattern:
**2.1, 2.2, and 2.4 had it in *two* items each** (1 and 2 / 1 and 3 / 1 and 4), where Unit 1 lessons had it in one. 2.0 had it in
items 2 and 4; 2.3 in item 1. In every case the key had *replaced* the question stems (matrices, systems, pivot pairs) with the
answers, so the key did not mirror the blank at all. All stems restored byte-identically and the work moved into `work` blocks.
**Restate the rule: on any remaining lesson, diff `homework` against `homework_key` item by item before anything else.**

**Verified (all five lessons):** `make -C unit02/lessonYY all` exits 0 for each; every component's page count equals its key's
(warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 — identical across all five); warm-up and exit ticket still
1 page on both sides; **student and key packets both 14pp for every lesson**, plans 3pp. Zero `\ans` inside `$...$`, zero
`teachernote` in any `_key` (21 in the five plans), zero name rows outside `cover/`, max overfull `\hbox` 10.77pt (the standard
pageheader banner), both convention scripts report clean/idempotent on all five, and all 99 `work` blocks confirmed byte-identical
blank vs key by checksum. `pdftotext` on all 25 blanks finds no solution string in the text layer (the two `\checkmark` hits, in
2.3 and 2.4 `notes`, are taught worked examples in the lesson body, not student answers). `git status` shows only the 55 edited
`.tex` files (11 per lesson) — nothing compiled in place. Notes/activity/exit-ticket/homework pages spot-checked visually on
**both sides** of every lesson; red answers and work blocks render with no tofu. All lesson arithmetic independently re-verified in
Python for every lesson (every elimination, multiplier, $LU$ and $\PP A=LU$ factorization, inverse, transpose, and two-sweep solve).

---

## Unit cover sheets (`unitXX/unit_cover/main.tex`)

**What the repo already had.** `shared/unit.mk` has always supported an **optional** `unit_cover/` component:
`HAS_UNIT_COVER := $(wildcard unit_cover/main.tex)`, a `_unit_cover` rule that compiles it with `latexmk -xelatex` to
`target/compiled/$(UNIT)/unit_cover.pdf`, and both the `student` and `key` unit targets `pdfunite` it **first**, ahead of the lesson
packets and the sample test. A unit opts in simply by having the directory. Until now **zero units had one**, so the rule was inert
course-wide. (This is *not* the binder cover: `algebra_2` also has a `binder_cover/` — a `cover.py`-generated prefab PDF whose two
identical pages are the front and back of the student's binder. This course has no binder covers and no `cover.py`.)

**The model, ported from `algebra_2/unit01/unit_cover/main.tex` and `unit02`'s.** Same one-page skeleton, re-voiced for this course:

1. **Full-bleed banner** — a `remember picture, overlay` tikzpicture filling the top **1.70in** in `burgundy`, with the text set
   **inside a `\node` anchored to `current page.north`** (a negative `\vspace` would push it off the sheet). "Linear Algebra" in white
   at 30pt over "Unit N: Title" in `blushmid` at 19pt. Body then clears it with `\vspace*{1.32in}`.
2. **Unit Overview** — a plain `tcolorbox` (`colback=blush, colframe=burgundy`), one paragraph opening `\textbf{Unit Overview.}\quad`.
3. **Lessons in This Unit** — `\begin{skillbox}[Lessons in This Unit]{goldbox}` wrapping a 3-column `tabularx`
   (`c` / `>{\bfseries\raggedright\arraybackslash}p{0.29\linewidth}` / `X`) = **#, Title, Focus**, `\hline` between rows,
   `\arraystretch` 1.32. Rows are `1.0`–`1.4` (the intro lesson gets a row like any other).
4. **Big Ideas of Unit N** — `\begin{skillbox}[...]{greenbox}`, 5 bullets. **This replaces `algebra_2`'s SOL-standards table**: this
   course has no standards documents, so the slot carries the unit's throughlines instead.
5. **`remindbox`** — Source (LAfE chapter + sections) and Assessment (practice test is bound at the back).

**Two things that differ from the `algebra_2` model, both deliberate:**

- **`\pagestyle{empty}`.** `unit.mk` merges the unit cover **without** the packet-wide pagination pass (`shared/paginate.tex` runs
  per *lesson*, inside `lesson.mk`), so a folio here would print a stray "1" immediately before Lesson 1.0's own page 1. The
  `algebra_2` covers do print that number; this course's do not. **Keep `\pagestyle{empty}` in every future unit cover.**
- **`\frac`, not `\dfrac`, inside a table cell.** The `\dfrac` in the 1.2 row's $\cos\theta$ formula inflated the row's line height
  and pushed "as perpendicular" onto a line of its own.

**One-page fit is tight and is the whole layout constraint.** The first draft ran 2pp (the `remindbox` alone spilled). What bought it
back: `\arraystretch` 1.45 → **1.32** and the inter-box `\vspace`s trimmed to 0.13in / 0.11in / 0.10in. **Budget for a 5-lesson unit:
overview ~8 lines, 5 table rows, 5 bullets, 1 remindbox.** A unit with more lessons (Unit 3 has 7) will need shorter Focus cells or
fewer Big Ideas bullets — verify with `pdfinfo` every time.

**Verified (Unit 1 cover):** `make -C unit01 _unit_cover` exits 0; `unit_cover.pdf` is **1 page**, **zero** overfull/underfull `\hbox`.
`make -C unit01 student` → `unit01_student.pdf` **74pp** with the cover as p1 (`pdftotext` p1 = "Linear Algebra / Unit 1: Vectors and
Matrices / Unit Overview…", p2 = Lesson 1.0's own cover); `make -C unit01 key` → `unit01_key.pdf` **73pp**, same cover leading it. The
1-page student/key difference is **pre-existing and at the tail** — `sample_test` is 3pp against a 2pp `sample_test_key`, exactly the
one gap `unit.mk`'s own comment allows; the cover changes nothing about blank/key alignment.

**Verified (Unit 2 cover, 2026-08-03):** `make -C unit02 _unit_cover` exits 0; `unit_cover.pdf` is **1 page**, **zero**
overfull/underfull `\hbox`. `make -C unit02 student` → **74pp**, `make -C unit02 key` → **74pp** (Unit 2 is aligned end to end,
unlike Unit 1's 74/73), cover as p1 of both, Lesson 2.0's own cover as p2.

**Two things the Unit 2 cover added to the model:**

- **Math in the banner needs `\mbox`.** `Unit 2: Solving Linear Equations $A\xx=\bb$` set bare inside the tikz `\node` had its
  math relation glue stretched across the `text width=\paperwidth`, printing as `Ax   =   b` with visible gaps. Wrapping it —
  `\mbox{$A\xx = \bb$}` — fixes it. **Any future unit cover whose title carries math must `\mbox` it** (Units 3, 6, 7 will).
- **The 1-page budget is real and the `remindbox` is what spills.** First draft was 2pp with *only* the `remindbox` on p2 —
  same failure mode as Unit 1's first draft. What bought it back, with the table and `\vspace`s left at the Unit 1 values:
  trimming the overview from ~10 printed lines to **8**, and tightening two Big Ideas bullets from 3 printed lines to 2.
  Confirms the budget: **overview ~8 lines, one table row per lesson, 5 bullets, 1 remindbox.**

**Not done (deliberately out of scope for this run):** Units 3–8 have no `unit_cover/`. Adding them is a per-unit authoring job —
copy `unit02/unit_cover/main.tex` (now the better model — it has the `\mbox` fix), swap the banner title, overview, lesson rows,
big ideas, and the LAfE chapter reference, then re-check the 1-page fit. Lesson counts on disk: Units 1, 2, 4, 6, 7, 8 have **5**
each (a 5-row table fits, as proven twice), **Unit 5 has 4**, and **Unit 3 has 7** — Unit 3's cover will need shorter Focus cells
or fewer Big Ideas bullets to hold one page.

---

**The five-conventions order — user's decision, recorded in `SKILL.md` and `references/conventions.md`:**

> **1. vocabpar → 2. teachernote → 3. namestrip → 4. work rule → 5. boxguard**

(The first four all change vertical space; **boxguard runs last because it repairs the pagination the other four disturb**. vocabpar
leads because it makes vocab boxes taller and can reverse a guard verdict measured before it.)

**Lesson 1.4 retrofit (`unit01/lesson04`, Matrix Multiplication and $A=CR$) — what each convention actually did.** **Baseline was
aligned** — warmup 1/1, notes 2/2, activity 2/2, exit 1/1, homework 2/2 — the third lesson in a row to open clean (1.2, 1.3, 1.4).

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro sentence in `notes` + `notes_key`; the intro no longer collides with
   "Matrix multiplication (by columns):".
2. **teachernote** — `movenotes.py` lifted 3 notes (warm-up, activity, exit ticket) into the plan as titled blocks. No `_key` carries
   one now; the plan grew 2pp → 3pp.
3. **namestrip** — `namestrip.py` removed 10 name rows (5 components × blank/key), incl. 2 `\namepartnerperiod` in the activity pair;
   `cover/` kept its row. **Opened no new mismatch** — like 1.1 and 1.2, unlike 1.0 and 1.3. Note this lesson *does* have a four-term
   `vocabbox`, so expectation (d) below ("a 4-term vocab box makes namestrip expose the blank/key height gap") is **not** reliable:
   here the gap stayed hidden. Re-measure; never carry the verdict forward.
4. **work rule** — 19 byte-identical `work` blocks: `activity` 9, `homework` 6, `notes` 2, `exit_ticket` 2. (`warmup` needed none —
   all three items are single inline fills, already the same size on both sides.) They replaced the usual drift-prone pattern
   (`\vspace{0.6/0.7/0.8/0.9/1.2/1.3/1.6cm}` in the blank against an inline `\ans`/`\ansline` in the key) and let the hand-tuned
   `itemsep` drift be unified per file (activity 10pt→8pt across all three tiers, exit 16pt→14pt, homework 12pt→10pt and 6pt→5pt).
   Six prompts mixing computation with interpretation were **split** — `work` block for the computation, `\writeline`/`\ansline` for
   the prose (notes practice item 2; activity Tier R item 3, Tier A item 3, Tier E items 1 and 3; homework items 2 and 5b, and the
   extension box) — the pattern first used on 1.2. Also repaired **the recurring `homework_key` defect, and it was item 1 again (as
   on 1.3, not item 2 as on 1.0–1.2)**: the key had folded answers into both sub-stems (`= {}\ans{…}` on (a) and (b)) *and* appended
   a plain un-reddened parenthetical line ("(1b: col~1 $=\ldots$)") with no counterpart in the blank. Stems restored byte-identically,
   all four steps moved into a `work` block. **Five for five — check `homework_key` items 1 and 2 first on every remaining lesson.**
5. **boxguard** — 2 guards, mirrored blank and key:
   - **`\boxguard[24]` before the notes `practicebox`.** The two new `work` blocks in that box grew `notes` from 2pp to 3pp on both
     sides, and the box then split badly — the blank stranded a write-line tail plus item 3, the key stranded item 3 alone, atop p3.
     **The default `\boxguard` (16 lines) fixed the blank but was inert in the key**, because the key's four `\vocabans` entries make
     its `vocabbox` ~10 lines shorter than the blank's four `\termblanklong`, so the key still had ~18 lines free where the blank had
     ~14. Raised to `[24]` — above the key's free space — and both sides now push the whole box to p3 and break at the identical
     point. **New finding worth keeping: on a lesson with a multi-term vocab box, size a `notes` guard against the KEY's free space,
     not the blank's; the blank is always the tighter side and will fire at a lower value.**
   - **`\tcbbreak` — not `\boxguard` — before homework item 4**, inside the `Practice` `notesbox`. Both sides split that box mid-item
     5, leaving 5(b) as a stub at the top of p2 with 5(a) on p1. `\boxguard` is inert inside a breakable tcolorbox (the documented
     limit), so the unconditional `\tcbbreak` is the right instrument; mirrored in both files, it moves items 4 and 5 whole to p2 and
     keeps `homework` at 2/2. Second use of `\tcbbreak` in this course, after 1.3.
   `activity` needs no guards — Tier R and Tier A sit whole on p1, Tier E whole on p2, blank and key alike, even after nine `work`
   blocks were added. `notes` is the only component whose page count moved (2→3 on **both** sides).

**Verified (Lesson 1.4):** `make -C unit01/lesson04 all` exits 0; warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 —
**every component equals its key**; warm-up and exit ticket still 1 page on both sides; student and key packets both 14pp, plan 3pp.
Zero `\ans` inside `$...$`, zero `teachernote` in a `_key` (3 in the plan), zero name rows outside `cover/`, max overfull `\hbox`
10.77pt (the standard pageheader banner), both convention scripts report clean/idempotent, all 19 `work` blocks confirmed
byte-identical blank vs key by checksum, and `pdftotext` on all five blanks confirms **no solution string reaches the blank's text
layer** (the four hits are a taught TikZ figure label, the rank definition sentence, and two prompt stems — not answers). `git status`
shows only the 11 edited `.tex` files (nothing compiled in place). Notes/activity/exit-ticket/homework key pages and the plan's three
migrated teacher notes spot-checked visually — red answers and work blocks render with no tofu. All lesson arithmetic independently
re-verified in Python (every $A\bb_j$, all six $A=CR$ factorizations, every rank, and each parallel/multiple test).

**No content defect found this time** — the plan's *Group Work* box, the cover's contents row, and the activity all agree on
"Rebuilding a Catalog from Base Products" with the same parts/labor catalog spine.

---

**Lesson 1.3 retrofit (`unit01/lesson03`, Matrices and Column Spaces) — what each convention actually did.** **Baseline was aligned**
— warmup 1/1, notes 3/3, activity 2/2, exit 1/1, homework 2/2 — the second lesson in a row to open clean (1.2 was the first).

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro sentence in `notes` + `notes_key`; the intro no longer collides with
   "Matrix (its columns):".
2. **teachernote** — `movenotes.py` lifted 3 notes (warm-up, activity, exit ticket) into the plan as titled blocks. No `_key` carries
   one now; the plan grew 2pp → 3pp.
3. **namestrip** — `namestrip.py` removed 10 name rows (5 components × blank/key), incl. 2 `\namepartnerperiod` in the activity pair;
   `cover/` kept its row. **This one opened a mismatch** — like 1.0, unlike 1.1 and 1.2: `notes_key` collapsed to 2pp against a 3pp
   blank. **Cause worth remembering: the `vocabbox` is structurally ~10 lines taller in the blank** (four `\termblanklong` terms, each
   term + 2 write-lines) **than in the key** (four `\vocabans`, term + answer on 1–2 lines). That gap always existed; the extra name
   row was the only thing keeping the key on 3 pages. **On any lesson with a 4-term vocab box, expect namestrip to expose it.**
4. **work rule** — the fix for that mismatch, and the substantive edit. 10 byte-identical `work` blocks: `activity` 6, `homework` 2,
   `notes` 1, `exit_ticket` 1. They replaced the usual drift-prone pattern (`\vspace{0.3/0.7/0.8/0.9/1.4cm}` in the blank against an
   inline `\ans`/`\ansline` in the key) and let the hand-tuned `itemsep` drift be unified per file (activity 10pt→8pt across all three
   tiers, exit 16pt→14pt, homework 12pt→10pt and 6pt→5pt). Four prompts mixing computation with interpretation were **split** —
   `work` block for the computation, `\writeline`/`\ansline` for the prose (activity Tier R item 3, Tier E items 1 and 3; homework
   item 5a) — the pattern first used on 1.2. The notes `practicebox` item 1 moved from a `\hfill \blank{4.0cm}` / `\hfill \ans{…}`
   pair into a 3-row `work` block; that added height to *both* sides and pushed the key's practicebox off p2, restoring 3/3.
   Also repaired a variant of **the same defect 1.0, 1.1, and 1.2 had in `homework_key` item 2 — here it was item 1**: the key had
   folded the answer into the question stem as plain un-reddened text ("\ (Columns $[1\;3]^\top$ and $[2\;1]^\top$.)") and answered
   (a)–(d) inline, so the stem did not mirror the blank. Stem restored byte-identically, all six steps moved into a `work` block.
   **Four for four — check `homework_key` item 1 *and* item 2 first on every remaining lesson; the defect migrates between items.**
5. **boxguard** — 2 guards, mirrored blank and key, **both free** (no component gained a page):
   - `\boxguard` before the notes `practicebox`. The **key** was stranding practicebox item 3 alone (2 lines) atop p3 while the blank
     carried the whole box there; after the guard both sides break at the identical point.
   - **`\tcbbreak` — not `\boxguard` — before homework item 5**, inside the `Practice` `notesbox`. Both sides split that box mid-item
     5, leaving (b) as a 2-line sliver at the *top* of p2 with (a) on p1. `\boxguard` is inert inside a breakable tcolorbox (the
     documented limit), so the unconditional `\tcbbreak` is the right instrument; mirrored in both files, it moves item 5 whole to p2.
     **First use of `\tcbbreak` in this course — reach for it whenever the stub is *inside* a box rather than before it.**
   `activity` needs no guards — Tier R and Tier A sit whole on p1, Tier E whole on p2, blank and key alike.

**Verified (Lesson 1.3):** `make -C unit01/lesson03 all` exits 0; warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 —
**every component equals its key**; warm-up and exit ticket still 1 page on both sides; student and key packets both 14pp, plan 3pp.
Zero `\ans` inside `$...$`, zero `teachernote` in a `_key` (3 in the plan), zero name rows outside `cover/`, max overfull
`\hbox` 10.77pt (the standard pageheader banner), both convention scripts report clean/idempotent, all 10 `work` blocks confirmed
byte-identical blank vs key by checksum, and `pdftotext` on all four blanks confirms **no solution string reaches the blank's text
layer** (the three "whole plane" hits are prompt text, an objective, and a taught TikZ figure label — not answers). `git status` shows
only the 11 edited `.tex` files (nothing compiled in place). Notes/activity/exit-ticket/homework key pages spot-checked visually — red
answers and work blocks render with no tofu. All lesson arithmetic independently re-verified in Python (every $A\xx$, both column
spaces, the $[5\;5]^\top$ solve, and every parallel/multiple test incl. the $[5\;6]^\top$ inconsistency).

**No content defect found this time** — unlike 1.2, the plan's *Group Work* box, the cover's contents row, and the activity all agree
on "Building Orders from Two Boxes" with the same $A=[\begin{smallmatrix}2&1\\1&3\end{smallmatrix}]$ mug/shirt spine.

**Lesson 1.2 retrofit (`unit01/lesson02`) — what each convention actually did.** **Baseline was already aligned** — warmup 1/1,
notes 3/3, activity 2/2, exit 1/1, homework 2/2. **The first lesson to open with no page mismatch**, so expectation (a) below
("the baseline defect is `homework` 2pp/1pp") is *not* universal — 1.0 and 1.1 had it, 1.2 did not. The work here was to apply the
conventions *without* breaking an alignment that already held.

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro sentence in `notes` + `notes_key`; the intro no longer collides with
   "Dot product:".
2. **teachernote** — `movenotes.py` lifted 3 notes (warm-up, activity, exit ticket) into the plan as titled blocks. No `_key` carries
   one now; the plan grew 2pp → 3pp.
3. **namestrip** — `namestrip.py` removed 10 name rows (5 components × blank/key), incl. 2 `\namepartnerperiod` in the activity pair;
   `cover/` kept its row. **Opened no new mismatch** — same as 1.1, unlike 1.0. Re-measured after it; counts unchanged.
4. **work rule** — 10 byte-identical `work` blocks: `activity` 4, `homework` 4, `exit_ticket` 2. (`notes` needed none — its
   practicebox answers are single final answers on `\hfill` lines, already the same size both sides.) They replaced the usual
   drift-prone pattern — `\vspace{0.4/0.5/0.8/0.9/1.2/1.3/1.6cm}` in the blank against an inline `\ans`/`\ansline` in the key — and
   let the hand-tuned `itemsep` drift be unified to one value per file (activity 10pt→8pt across all three tiers, exit 16pt→14pt,
   homework 12pt→10pt and 6pt→5pt). Two prompts that mix computation with interpretation (activity Tier A item 1, homework item 5a)
   were **split**: `work` block for the computation, `\writeline`/`\ansline` for the interpretation — a clean pattern worth reusing.
   Also repaired **the same real defect 1.0 and 1.1 had, in the same place**: `homework_key` item 2 had *dropped* both length prompts
   ($\begin{smallmatrix}3\\4\end{smallmatrix}$, $\begin{smallmatrix}5\\12\end{smallmatrix}$), replacing the question text with the
   answers — prompts restored, work moved into a `work` block. **Three for three: check `homework_key` item 2 first on every
   remaining lesson.**
5. **boxguard** — 3 guards, mirrored blank and key, **all free** (no component gained a page): `\boxguard` before the notes
   `practicebox`, `\boxguard[30]` before notes box 4 (it opens with text then an unbreakable TikZ grid), and `\boxguard[20]` before
   the activity's Tier A tcolorbox. `homework` was inspected page by page and needs none — its Practice box splits with a substantial
   chunk on each side, and the extension/spiral boxes are whole.

**The new finding from 1.2: the blank and the key can have *different* stubs in the same component.** Both prior retrofits found a
defect on one side; here each side had its own, in both multi-page components. In `notes`, the *blank* split box 4 (2-line stub atop
p3) while the *key* split the practicebox (item 3 alone on p3). In `activity`, the *blank*'s Tier A left only item 3 (2 lines) atop
p2 while the *key*'s left ~5 lines. **So render and inspect both sides — a clean blank does not certify the key, or vice versa.**
After guarding, blank and key break at *identical* points in both components, which is the outcome to aim for.

**Verified (Lesson 1.2):** `make -C unit01/lesson02 all` exits 0; warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 —
**every component equals its key**; warm-up and exit ticket still 1 page on both sides; student and key packets both 14pp, plan 3pp.
Zero `\ans` inside `$...$`, zero `teachernote` in a `_key` (3 in the plan), zero name rows outside `cover/`, zero overfull
`\hbox > 15pt` (max 10.77pt = the standard pageheader banner), both convention scripts report clean/idempotent, all 10 `work` blocks
confirmed byte-identical blank vs key by checksum, and `pdftotext` on all four blanks confirms **no solution string reaches the
blank's text layer**. `git status` shows only the 11 edited `.tex` files (nothing compiled in place). Notes/activity/exit-ticket key
pages spot-checked visually — red answers and work blocks render with no tofu. All lesson arithmetic independently re-verified in
Python (dot products, norms, all four angles incl. $37^\circ$/$45^\circ$/$135^\circ$/$16^\circ$, every perpendicularity test).

**One content defect found and fixed (not a convention issue — user chose the direction).** The lesson plan's *Group Work* box and the
cover's contents row described the activity as **"Are These Records Alike?"** with vectors $\begin{smallmatrix}\text{steps}\\\text{active min}\end{smallmatrix}$,
while the authored activity is **"Are These Viewers Alike?"** with action/romance ratings on a $-2\ldots+2$ scale. Evidence the activity
was the newer text: the migrated teacher note already mixed both vocabularies ("sorts *viewers*" then "a scaled *record*"), i.e. the
lesson was drafted as "records" and partly rewritten, leaving the plan and cover behind. **Decisive argument — the math requires signed
data:** steps/active-minutes are non-negative, so two such vectors always sit in the first quadrant, always give a dot product $\ge 0$
and an angle $\le 90^\circ$. That would destroy Tier A item 2 (read the *sign*: Ava$\cdot$Dan $=-5$ = opposite taste) and the notes'
three-case table ($>0$ acute / $=0$ right / $<0$ obtuse). **Resolved to "Viewers"** — 8 refs updated in the plan (incl. the Reinforcement
box and the migrated teacher note) and 1 in the cover's contents row; the activity pair was left untouched. Zero "record" strings remain
in the lesson, all four "Are These Viewers Alike?" titles agree, and page counts were unaffected (plan still 3pp, cover 1pp).

**Lesson for later retrofits:** when a plan and its component disagree on a scenario, **check whether the numbers depend on the
context's sign range before deciding which side to rewrite** — that, not word count, settled this one.

---

**Lesson 1.1 retrofit (`unit01/lesson01`) — what each convention actually did.** Baseline was `homework` 2pp blank / 1pp key —
the *same* opening defect as 1.0, from the same cause.

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro sentence in `notes` + `notes_key`; the intro no longer collides with
   "Linear combination:".
2. **teachernote** — `movenotes.py` lifted 3 notes (warm-up, activity, exit ticket) into the plan as titled blocks. No `_key` in the
   lesson carries one now; the plan grew to 3pp.
3. **namestrip** — `namestrip.py` removed 10 name rows (5 components × blank/key); `cover/` kept its row. **Unlike 1.0, it opened no
   new mismatch here** — re-measured after it and the counts were unchanged. Expect either outcome; always re-measure.
4. **work rule** — the fix for the homework mismatch, and the substantive edit. 10 byte-identical `work` blocks now carry every
   multi-step solution: `activity` 4, `homework` 3, `exit_ticket` 2, `notes` 1. They replaced the same drift-prone pattern 1.0 had —
   a bare `\vspace{1.4cm}`/`{1.6cm}`/`{0.9cm}`/`{0.5cm}` in the blank against an inline `\ans`/`\ansline` in the key — and let the
   hand-tuned `itemsep` hacks (16pt/14pt, 12pt/10pt, 10pt/8pt, 6pt/5pt) be unified to one value per file. Also repaired **the same
   real defect 1.0 had, in the same place**: `homework_key` item 2 had *dropped* both target-vector prompts, replacing the question
   text with the answers — prompts restored, work moved into a `work` block. **Worth checking `homework_key` item 2 first on every
   remaining lesson.**
5. **boxguard** — 2 guards, mirrored blank and key: `\boxguard[20]` before notes box 2 (it opens with a TikZ figure) and `\boxguard`
   before the notes `practicebox`. Each fixed a genuine stub in the *key* (box 2 took a title + 2 lines at the foot of p1; the
   practicebox took a title + 1 line at the foot of p2). **Both were free — no component gained a page.** `activity` and `homework`
   were inspected page by page and need no guards: every box already breaks whole. A **third guard was measured and declined** —
   `\boxguard` before notes box 1 cost no page, but it was still a bad trade: it left p1 ~40% empty and pushed box 3 into a
   title + 4-line stub at the foot of p2, i.e. it *moved* the defect rather than fixing it. Box 1's break is acceptable as it stands
   (title + 7 lines incl. a display on p1, 5 lines on p2 — a substantial chunk each side).

**Verified (Lesson 1.1):** `make -C unit01/lesson01 all` exits 0; warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 —
**every component equals its key**; warm-up and exit ticket still 1 page on both sides; student and key packets both 14pp, plan 3pp.
Zero `\ans` inside `$...$`, zero `teachernote` in a `_key` (3 in the plan), zero name rows outside `cover/`, zero overfull
`\hbox > 15pt`, both convention scripts report clean/idempotent, all 10 `work` blocks confirmed byte-identical blank vs key by
checksum, and `pdftotext` on all four blanks confirms **no solution string reaches the blank's text layer**. `git status` shows only
the 11 edited `.tex` files (nothing compiled in place). Key pages spot-checked visually — red answers and work blocks render with no
tofu. All lesson arithmetic independently re-verified in Python (both robot/juice/smoothie spines and every weight solve).

---

**Lesson 1.0 retrofit (`unit01/lesson00`) — what each convention actually did.** Baseline was `homework` 2pp blank / 1pp key.

1. **vocabpar** — `\par\vspace{2pt}` after the vocabbox intro sentence in `notes` + `notes_key`; the intro no longer collides with
   "Vector:".
2. **teachernote** — `movenotes.py` lifted 3 notes (warm-up, activity, exit ticket) into the plan as titled blocks. No `_key` in the
   lesson carries one now; the plan grew to 3pp.
3. **namestrip** — `namestrip.py` removed 10 name rows (5 components × blank/key); `cover/` kept its row. This *opened a second
   mismatch* exactly as the docs warn — the freed space let `activity_key` collapse to 1pp against a 2pp blank.
4. **work rule** — the fix for both mismatches, and the substantive edit. 12 byte-identical `work` blocks now carry every multi-step
   solution: `activity` 7, `homework` 3, `exit_ticket` 2. They replaced the drift-prone pattern of a bare `\vspace{1.4cm}` in the
   blank against an inline `\ansline` in the key, and let the hand-tuned `itemsep` hacks (16pt/14pt, 12pt/10pt, 10pt/8pt) be unified
   to one value per file. Also repaired a real defect: `homework_key` item 2 had *dropped* the three norm prompts, replacing the
   question text with the answers — the prompts are restored and the work moved into a `work` block.
5. **boxguard** — 4 guards, mirrored blank and key: `\boxguard` before notes box 3 and before the notes `practicebox`, `\boxguard[30]`
   before the activity's Tier A tcolorbox. Each fixed a genuine stub (notes box 3 got a title + 4 lines at the foot of p2; the key's
   practicebox got a title + 1 line; activity Tier A orphaned item 4 atop p2). **All four were free — no component gained a page.**

**Verified (Lesson 1.0):** `make -C unit01/lesson00 all` exits 0; warmup 1/1, notes 3/3, activity 2/2, exit_ticket 1/1, homework 2/2 —
**every component equals its key**; warm-up and exit ticket still 1 page on both sides; student and key packets both 14pp. Zero `\ans`
inside `$...$`, zero `teachernote` in a `_key`, zero overfull `\hbox > 15pt`, both convention scripts report clean/idempotent, all 12
`work` blocks confirmed byte-identical blank vs key by checksum, and `git status` shows only the 11 edited `.tex` files (nothing
compiled in place). Key pages spot-checked visually — red answers and work blocks render with no tofu.

**What landed.** `shared/linalg-boxes.sty` (all additions purely additive — nothing re-flows until a lesson actually uses them):
`\boxguard[n]` (default 16 lines, via `needspace`); the **`work` environment** — a worked-solution block authored *byte-identically*
in the blank and its key, shipped as a `\vphantom` under `-boxes` (exact height, no ink, nothing in the text layer) and printed in
`keyred` under `-key`, so the two can never drift; and **`teachernote`**, **moved here from `linalg-key.sty`** with an optional
component title (`\begin{teachernote}[Warm-Up]` → "Teacher Note: Warm-Up") — the lesson plan loads `-boxes`, not `-key`, and a bare
`\begin{teachernote}` still works, so the 196 files that carry one keep compiling untouched. `shared/linalg-key.sty` sets
`\la@workvisibletrue` and no longer defines `teachernote`. **Scripts** (copied from algebra_2, project-agnostic, both verified with
`--check` on `unit06/lesson00`): `scripts/namestrip.py` (strips `\namedateperiod`/`\namepartnerperiod` from every component + key,
skips `cover/`; `--check` exits 1 = review gate) and `scripts/movenotes.py` (lifts each `_key`'s teachernote into the lesson plan,
titled per component; refuses to run twice). **New lessons are born namestripped:** `new_lesson.py` + the worksheet skeletons no
longer emit a name row (cover and unit tests keep theirs — tests are taken in a testing setting). **Docs:** a new "The five
conventions" section in `references/conventions.md` (each rule, its fix, and the two known boxguard limits — inert inside a breakable
tcolorbox, use `\tcbbreak`; a guard that costs a page can often be bought back with mirrored spacing trims), a new "Reviewing or
revising a lesson" section in `SKILL.md` with the order + retrofit table, and `components.md` updated (no name rows on components,
`\par\vspace{2pt}` before the first vocab term, work blocks for solutions, no teachernote in a lesson-component key — unit tests and
`finals/` keys keep theirs, they are not page-matched into a packet).

**Verified:** full out-of-tree compile scan of every `main.tex` in `unit01`–`unit08` + `finals` — **569/569 OK, 0 failures**, and
`git status` clean afterward (nothing compiled in place); `make -C unit06/lesson00 all` clean; a purpose-built smoke doc proves the
`work` block reserves *identical* height blank vs key (98.74pt gap on both sides) and that the blank's PDF text layer contains none of
the solution; `\boxguard` demonstrated to push a box whole to the next page (box starts on p1 unguarded, p2 guarded, at 30 and 34
lines of preceding content); scaffolder output (`--unit 09 --lesson 01`) compiles — components carry no name row and the lesson plan
is born with five titled `teachernote` stubs.

**Note (2026-08-03):** the paragraph below counts *lessons* only. The Unit 1 and Unit 2 **tests** were retrofitted separately on
2026-08-03 (teachernote → work rule → boxguard) — see "Unit 1–2 test retrofit" at the top. The teachernote debt figure below
therefore no longer includes the 8 test keys, which now carry none.

**Current state of the conventions across the course — 10 of 41 lessons retrofitted; Units 1 and 2 are both complete**
(`unit01/lesson00` … `unit01/lesson04` and `unit02/lesson00` … `unit02/lesson04`; still no bulk sweep, by design — it would re-flow
the pagination of every verified lesson at once). Remaining debt: **142** files still carry a `teachernote` in a `_key`, **310**
component files still carry a name row, and `work`/`\boxguard` appear only in Lessons 1.0–1.4 and 2.0–2.4. vocabpar is unfixed
everywhere else — spot-checked `unit06/lesson00`, whose `vocabbox` still has the intro sentence colliding with the first term in
both `notes` and `notes_key`.

**Unit 2 proved a whole unit can be retrofitted in one run** (5 lessons, 55 files, ~2 hours of build/measure cycles) without the
lesson-by-lesson pacing costing anything — each lesson was still measured, guarded, and verified on its own before moving on. That
is the recommended shape for Units 3–8: take the unit as the unit of work, but keep the per-lesson measure/guard/verify loop.

**Next run:** start **Unit 3** — `/lesson-planning apply the retrofit to lessons 3.0 - 3.6` (Unit 3 has **7** lessons, the largest
in the course, so budget accordingly). Run the conventions in order per lesson. Finish each with the evidence: `make -C
unitXX/lessonYY all` exits 0, every component's page count equals its `_key`'s, and warm-up + exit ticket are still 1 page on both
sides. **Before touching a lesson, do the two cheap greps Unit 2 turned into standard practice:** diff `homework` against
`homework_key` item by item (the answers-in-the-prompt defect is 10 for 10, and Unit 2 had it in *two* items per lesson), and
`grep -n footnotesize` every `_key` (the key-only bracketed hint with no blank counterpart — 10 found in Unit 2).

**Also outstanding, from the 2026-08-03 test retrofit:** Units 3–8 tests still need the same pass (24 files), but each of those
units must first get a `unit_cover/` **and** a `unit_cover_key/` — that page 2 is now the only sanctioned home for a test key's
scoring notes. Copy `unit02/unit_cover/` (body + wrapper) as the model. Units 1 and 2 tests are done.

**What to expect on every retrofit — after ten lessons (Units 1 and 2):**

(a) **A `homework` 2pp blank / 1pp key baseline defect is uncommon** — only 1.0 and 1.1 had it; **1.2, 1.3, 1.4 and all five Unit 2
lessons opened fully aligned (8 of 10)**. Measure first; do not assume a mismatch exists, and do not assume there is none.
(b) **The `homework_key` answers-in-the-prompt defect appears in ALL TEN lessons** — 1.0/1.1/1.2 had item 2 with its prompts
*replaced* by the answers; 1.3, 1.4 and 2.3 had **item 1** with the answers folded into the stem; and **2.0, 2.1, 2.2 and 2.4 each
had it in TWO items** (2 and 4 / 1 and 2 / 1 and 3 / 1 and 4). Diff `homework` against `homework_key` item by item before anything
else — it is a content bug the page counts never reveal, and it moves between items and multiplies.
(h) **NEW in Unit 2 — the key-only `{\footnotesize (...)}` parenthetical.** A bracketed one-line hint appended after an answer with
no counterpart in the blank: the same "block in the key with no counterpart" problem as a `teachernote`, just smaller. **10 found
across Unit 2**, concentrated in the warm-ups. `grep -n footnotesize` every `_key` and convert each to a shared `work` block.
(i) **NEW in Unit 2 — check cross-lesson references.** When a lesson reuses a running example (2.2 and 2.3 both apply 2.1's *method*
to 2.2's *numbers*), the prose drifts a lesson behind the arithmetic: 2.2 credited 2.1 for three values that are 2.2's own, and 2.3
inherited the error. Grep each `notes` for references to a neighbouring lesson number and re-verify the cited value.
(c) **The work rule is where the real editing is** — hunt the `\vspace{Xcm}`-in-blank / `\ans`-or-`\ansline`-in-key pairs and the
hand-tuned `itemsep` differences (16/14, 12/10, 10/8, 6/5), since those are the same defect wearing two hats. When a prompt mixes
computation with interpretation, **split it**: `work` block for the computation, `\writeline`/`\ansline` for the prose.
(d) **namestrip may or may not open a new mismatch** — it did on 1.0 and 1.3, did not on 1.1, 1.2, 1.4, or **any of 2.0–2.4**
(7 of 10 free). Re-measure after step 3 either way; never carry a verdict forward. **When it does fire, suspect the `vocabbox`
first** (1.3): a multi-term box is ~10 lines taller in the blank than in the key, and the name row is often all that hides it. The
fix is a `work` block that lengthens *both* sides, not a guard. **But a multi-term vocab box does not guarantee it fires** — 1.4 and
every Unit 2 lesson have five-term boxes and namestrip stayed free. The height gap is always there; whether it surfaces depends on
where the page break happens to fall.
(g) **Size a `notes` boxguard against the KEY's free space, not the blank's** (new in 1.4, confirmed 5/5 in Unit 2). The same
vocabbox gap that hides from namestrip makes the key the *looser* side of a `notes` page, so a guard tuned to the blank can be inert
in the key and leave the two breaking at different points. **`\boxguard` before the `notes` `practicebox` is now the single most
reliable guard in the course — every Unit 2 lesson needed exactly it, at the default 16 lines.** Render both sides, take the larger
free-space figure, and set `\boxguard[n]` above it. **When measuring free space from a `pdftoppm -r 55` render, the page is 595 px
and the text block ~550 px, so ~110 px ≈ 12 lines** — an earlier 9-inch estimate halved every figure and made one guard inert.
(e) **Render and inspect the blank AND the key** (new in 1.2) — the two can carry *different* stubs in the same component, so a clean
blank does not certify the key. Aim for blank and key breaking at identical points.
(f) **Pick the right break tool for where the stub is** (new in 1.3). Stub *before* a box → `\boxguard` on the line above
`\begin{...}`. Stub *inside* a breakable box (an item splitting across the page) → **`\tcbbreak`** at the chosen split point;
`\boxguard` is inert in there. Either way, mirror it in the blank and the key and re-check both page counts.

**And from 1.1: a free guard can still be the wrong guard.** `\boxguard` before notes box 1 cost no page, so the page-count test
passed — but it left p1 40% empty and pushed box 3 into a fresh stub. **Judge a guard by re-rendering the pages, not only by the
page count.** Measure the overflow, look at both sides of every break, and decline guards that relocate a stub instead of removing it.

---

**Prior run (2026-08-01, earlier):** **Rebuilt the BUILD SYSTEM to match `~/Mathematics/algebra_2`. No lesson content changed.**
The old `student` / `full` packet pair is gone. Every lesson now produces **five work products** in `target/compiled/unitXX/`:
`lessonYY_plan.pdf` (the lesson plan alone), `lessonYY_slides.pdf` (the Beamer deck printed **3 slides per page**, thumbnails in the
left column and a ruled notes column beside each), `lessonYY_slides.pptx` (the same deck as one full-bleed page image per slide — the
projected form), `lessonYY_student.pdf` (cover + blank warmup/notes/activity/exit_ticket/homework) and `lessonYY_key.pdf` (cover + the
key version of each, same order). **Ported from algebra_2, byte-identical where possible:** `shared/lesson.mk` (identical), plus three
new files — `shared/handout.tex` (the 3-up printable pass; `algebra2-colors`→`linalg-colors`), `shared/paginate.tex` (packet-wide
pagination), and `shared/pdf2pptx.py` (dependency-free OOXML wrapper, poppler only, `PPTX_DPI` default 300). `shared/unit.mk` and
`shared/root.mk` were rewritten so the aggregated packets are now `unitXX_{student,key}.pdf` and `curriculum_{student,key}.pdf`;
`sample_test` merges into the unit **student** packet, `sample_test_key` into the unit **key** packet. Only the two packets aggregate —
plan/slides/pptx stay per-lesson. **New guarantees from `paginate.tex`:** page numbers run lesson-wide, every component starts on an
**odd (recto)** page, and the student and key packets are **page-for-page identical** (each component gets a `max(blank,key)`-rounded-to-even
slot, the shorter padded with numbered blank versos). **Verified:** `make -C unit01 student` + `key` → all 5 lessons build all five products;
lesson00–03 student=key=14pp, lesson04 student=key=12pp (all aligned); `unit01_student.pdf` 71pp vs `unit01_key.pdf` 70pp — expected, the
sample test (5pp) and its key (4pp) sit at the end and are the only unpaired pieces. Visually confirmed the 3-up handout and a
student/key page pair (both p5 = guided-notes p1). **Skill docs updated to match**: SKILL.md ("What a lesson is" product table, Step 5
commands), `references/build.md` (five-products section, the three passes, new commands + troubleshooting), and `scripts/new_lesson.py`
now defaults `--components` to include **`slides`** (every lesson ships a deck — it is the source of two of the five products).
**Next run:** nothing outstanding. Build with `make -C unitXX/lessonYY all`; after any lesson build, confirm student and key report the
same page count. Older narrative below still describes lesson/test *content* accurately; ignore any "full packet" wording in it.

---

**Prior run (2026-07-24):** **Authored & built a 50-question cumulative FINAL EXAM for the whole course, in a new
top-level `finals/` directory (parallel to the `unitXX/` dirs).** Per the user's request, `finals/` holds four flat
subdirs — `practice_final`, `practice_final_key`, `final`, `final_key` — mirroring the unit-test practice/actual pattern
but **without** any `sample_*` drop-in dirs (the user said samples need not be compiled/checked-in as PDFs, so there is no
`drop`/publish step). Added a **standalone `finals/Makefile`** (mirrors `shared/tests.mk`: globs `*/main.tex`, compiles each
to `target/finals/<name>/main.pdf` with `latexmk -xelatex`, `clean` target; **no** `shared/` files were modified) — build
with `make -C finals all`. **Blueprint (50 Q, 100 pts):** Part A Vocabulary = **16** items in two 8-term matching sets
(Set 1 Units 1–4, Set 2 Units 5–8; 2 terms/unit), 16 pts; Part B Multiple Choice = **12** items (~1–2/unit), 24 pts;
Part C Short Answer & Computation = **16** items = **2 per unit ×8 units**, 48 pts; Part D Extended Response = **6** synthesis
items (Units 1–3 rank / U4 least squares / U5–6 singular / U6 spectral theorem / U7 SVD-for-every-matrix / U8 whole-course
neural-net synthesis), 12 pts. **Same format kit as the unit tests:** `\parthead` burgundy `headlinebox` strips; practice
carries the `remindbox` "this is a practice final" banner, actual carries the plain **Instructions** line; keys swap `-boxes`→
`-key`, wrap answers in `\ans{}`, add `teachernote` scoring/answer-letter summaries. **Practice & actual are parallel forms**
(same structure/ideas, different numbers + reshuffled vocab letters). **All Part C arithmetic hand-verified in pure Python
(both forms) before authoring.** **Part C spine — practice / actual:** C1 $2\vv+\ww$ & perpendicular $(3,4)\!\perp\!(4,-3)$ /
$(5,12)\!\perp\!(12,-5)$; C2 rank-1 $A\vv$ $[[1,2],[2,4]](1,3){=}(7,14)$ / $[[1,3],[2,6]](2,1){=}(5,10)$; C3 elimination
$(1,2)$ / $(3,2)$; C4 inverse det-1 $[[2,1],[5,3]]^{-1}{=}[[3,-1],[-5,2]]$ / $[[3,1],[5,2]]^{-1}{=}[[2,-1],[-5,3]]$; C5 special
soln $(-2,1,0)$ / $(-3,1,0)$; C6 3×4 rank-2 four-subspace dims $2/2/2/1$ (both); C7 projection $\bb{=}(4,3)$ on $(1,2)\to\pp{=}(2,4),\ee{=}(2,-1)$ /
$\bb{=}(5,5)$ on $(1,3)\to\pp{=}(2,6),\ee{=}(3,-1)$; C8 best-fit line $b{=}5{-}3t$ / $b{=}1{+}3t$; C9 dets $10,7$ / $13,1$;
C10 area factor $6$ (×½→3) / $12$ (×2→24), orient preserved; C11 eig $[[2,1],[1,2]]\to3,1$ / $[[3,2],[2,3]]\to5,1$, vecs $(1,1)/(1,-1)$;
C12 diagonalize $[[4,1],[2,3]]\to\lambda5,2$ / $[[4,2],[1,3]]\to\lambda5,2$; C13 SVD via $A^\top A$: $[[2,2],[1,-2]]\to\sigma3,2$ /
$[[3,1],[-1,-3]]\to\sigma4,2$; C14 outer product + energy keep $64/68{\approx}94\%$ / $100/104{\approx}96\%$; C15 ReLU layer $\to(4,0)$ / $(0,4)$;
C16 covariance+PCA $(2,4),(4,2),(6,8),(8,6)\to V{=}[[5,3],[3,5]],\lambda8,2$,PC1 80% / $(1,2),(3,6),(5,4),(7,8)\to V{=}[[5,4],[4,5]],\lambda9,1$,PC1 90%.
Most C spines reuse the already-hand-verified Unit 7/8 test data. **Built `make -C finals all` → clean** (0 `^!`/file-line errors
across all 4 logs; 0 `\ans`-in-math; max overfull 10.77pt = the standard pageheader banner, <15pt). Page counts: blanks **5pp** each,
keys **4pp** each. Visually spot-checked practice-key p1 (both vocab matching sets — red letters C,E,F,A,B,D,G,H / E,A,C,F,B,H,D,G) & p3
(all Part C matrices/inverses/projections/eigen/SVD/PCA + Part D prose) and final-key p1 (actual-form vocab C,A,F,D,B,G,E,H / A,D,B,F,E,C,G,H
+ MC red arrows) — all render clean, no tofu. **`finals/` is complete and not merged into any packet** (standalone, like the actual unit
tests). **The Linear Algebra curriculum + a cumulative final are DONE.** No outstanding work; next run only on user request (revisions or
a new component). **Model:** the Unit 7/8 tests were the format template; `finals/` is now the model for any future exam-style deliverable.

---

**Prior run:** **Authored & built the Unit 8 summative tests — the course is now COMPLETE (lessons +
assessments, Units 1–8).** Filled all four skeletons: `tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`,
`test_keys/actual_test_key`, mirroring the Unit 7 test model (Parts A–D: Vocabulary 8 pts / Multiple Choice 12 pts / Short Answer &
Computation 35 pts / Extended Response 10 pts; `\parthead` burgundy `headlinebox` strips; practice test carries the `remindbox`
"this is a practice test" banner, actual test carries the plain **Instructions** line). Practice and actual are **parallel forms** —
same structure and ideas, different numbers and shuffled vocab letters. **Coverage spans all five lessons 8.0–8.4:** Part A vocab =
ReLU / layer / piecewise-linear / convolution filter / weight sharing / gradient descent / learning rate / covariance matrix; Part B
MC = ReLU value, layer formula, N folds→N+1 pieces, weight sharing, descent steps opposite the slope, covariance sign; Part C (7
items, 5 pts each) = evaluate a layer $\relu(A\vv+\bb)$, tent function $F=\relu(x)-2\relu(x-2)+\relu(x-4)$ (folds/peak), slide edge
filter $[-1,1]$ (feature map + edge), $3\times4$ convolution matrix + weight count (2 vs 12), gradient descent on a bowl (3 iterates +
losses + stop at slope 0), one two-weight $\nabla L$ step, and full mean/variance/covariance-matrix/PCA; Part D (2×5 pts) = "how a
network learns" synthesis (layer=weight/bias/ReLU → wider=more folds → gradient descent to slope 0) + "why the covariance matrix
unlocks PCA" (symmetric ⇒ real λ / ⊥ eigenvectors = principal components / trace = total variance = Σλ). **All arithmetic
hand-verified in pure Python** before authoring. **Spines — practice / actual:** layer $\to(4,0)$ / $(0,4)$; tent peak $(2,2)$ /
$(3,3)$; feature map $[0,0,4,0]$ / $[0,5,0,0]$; conv $[1,1,6,6]\to[0,5,0]$ / $[2,2,7,7]\to[0,5,0]$; descent from $0\to2\to3\to3.5$
(losses $16/4/1/0.25$) / from $8\to6\to5\to4.5$ (same losses), min $w=4$; $\nabla$ step $(0.5,1.5)$ toward $(1,3)$ / $(1,2.5)$ toward
$(2,5)$; PCA data $(2,4),(4,2),(6,8),(8,6)$ → $V=[[5,3],[3,5]]$, λ=8,2, PC1 80% / $(1,2),(3,6),(5,4),(7,8)$ → $V=[[5,4],[4,5]]$,
λ=9,1, PC1 90%. **Built `make -C unit08/tests all` + `make -C unit08/test_keys all` → clean** (0 `^!`/file-line errors across all 4
logs; 0 `\ans`-in-math; max overfull 10.77pt = the standard pageheader banner, <15pt). Page counts: practice/actual blank **3pp** each,
practice/actual key **3pp** each. `drop` published practice test → `unit08/sample_test/main.pdf` (merges into student + full packets)
and practice key → `unit08/sample_test_key/main.pdf` (full packet only); the actual test + key stay out of all packets. Visually
spot-checked both key pages — vocab matching (C,A,F,D,G,E,B,H), MC red-arrow marks, all Part C matrices/feature-maps/iterates/PCA
fractions, and both Part D responses render clean, no tofu. **Model:** the Unit 7 tests were the template; Unit 8's are now a second
model for the format. **The Linear Algebra curriculum is DONE** — core Units 1–6 + optional Units 7–8 lessons + every unit's practice
& actual summative assessment. No outstanding work; next run only if the user requests revisions or a new component.

---

**Prior run:** **Authored & built Unit 8 Lesson 8.4 — "Mean, Variance, and Covariance" (§8.4 — the shape of
the data itself, and the LAST lesson of the course).** Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket,
homework (+ the five keys) and the slides deck, mirroring Lesson 8.3's preamble/boxes/tone. **Content — center → spread → lean →
the matrix:** (1) **mean** $\mu=\frac1N\sum x_i$ = the center (balance point); subtracting it *centers* the data (the 7.3 move); light
mention of the probability-weighted **expected value** $E[x]=\sum p_i x_i$. (2) **variance** $\sigma^2=\frac1N\sum(x_i-\mu)^2$ = average
squared distance from the mean; square so $\pm$ gaps don't cancel (the Unit-4 least-squares echo); **standard deviation** $\sigma=\sqrt{\sigma^2}$;
honest $N$-vs-$(N{-}1)$ footnote (divide by $N$ = literal average, same directions). (3) **covariance** $\sigma_{xy}=\frac1N\sum(x_i-\mu_x)(y_i-\mu_y)$
= how two features move together; **sign is the whole story** ($+$ together / $-$ opposite / $0$ unrelated). (4) **covariance matrix**
$V=[[\sigma_x^2,\sigma_{xy}],[\sigma_{xy},\sigma_y^2]]$ — **symmetric** (Unit 6 ⇒ real $\lambda$, ⊥ eigenvectors) whose eigenvectors are the
**principal components** (Unit 7 PCA); total variance = **trace** = sum of eigenvalues; **finale punchline** data (U8) → symmetric matrix
(U6) → eigen-directions/PCA (U7), all from means/distances/dot products (U1/U4). **Single spine** = 4 students' two quiz scores
$(2,4),(4,2),(6,8),(8,6)$: means $(5,5)$, centered $x\,{:}\,{-}3,{-}1,1,3$ / $y\,{:}\,{-}1,{-}3,3,1$, $\sigma_x^2=\sigma_y^2=5$, $\sigma_{xy}=3$,
$V=[[5,3],[3,5]]$, $\lambda=8,2$, eigenvectors $(1,1)/(1,-1)$, PC1 holds $8/10=80\%$; also $V=\frac1N A^\top A$ ($A^\top A=[[20,12],[12,20]]$,
eig $32,8$ → /4 = the 7.3 spine). **Custom two-panel TikZ** (left: 1D number line of $2,4,6,8$ — royalblue dots, burgundy mean line, gold
deviation bars, "spread = avg squared distance"; right: 2D cloud, dashed centered axes, long burgundy PC1 $\lambda{=}8$ + short royalblue PC2
$\lambda{=}2$, "the cloud leans") on notes §3 + slides hook. **Warmup spirals the three moves** (mean of $2,4,6,8{=}5$ U1; sum of squared
deviations ${=}20$ → $/4$ = spread U4; eigenvalues of symmetric $[[5,3],[3,5]]$ via $\det(V-\lambda I){=}0\to8,2$ U6 — warmup answers = the
notes' covariance matrix + PCA punchline). **Activity/Exit/HW spines (all hand-verified pure Python):** Tier R single-var $[1,3,5,7]$ mean 4,
var 5, sd $\sqrt5$; Tier A **negative** covariance $(2,7),(4,9),(6,3),(8,5)$ means $(5,6)$, $\sigma_{xy}{=}{-}3$, $V{=}[[5,-3],[-3,5]]$ (trade-off
contrast); Tier E diagonalize notes' $V$ ($\lambda8,2$, PCs $(1,1)/(1,-1)$, PC1 80%, justify symmetric + trace=total var=sum eig). Exit:
mean/var of $[3,5,7,9]$ (6, 5); read $V{=}[[5,3],[3,5]]$ (variances 5, +cov=together, trace 10); justify symmetric. HW: same-mean/different-spread
$[4,6,8,10]$ var 5 vs $[1,5,9,13]$ var 20; covariance of $(1,2),(3,6),(5,4),(7,8)$ means $(4,5)$, $\sigma_{xy}{=}4$ (+); build $V{=}[[5,4],[4,5]]$;
PCA eig $9,1$ PC1 $(1,1)$ 90%; justify (square/negative/symmetric); extension $V{=}\frac1N A^\top A$ + expected value (spinner $1@\frac23,4@\frac13\to E{=}2$)
+ whole-course synthesis; **spiral box = course-completion celebration** (Units 1→8 arc). **Built `make -C unit08/lesson04 all` → clean**
(0 file-line/`^!` errors across all 13 logs; no `\ans`-in-math; 0 overfull >15pt — max 10.77pt is the standard pageheader banner). Page counts:
cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 5pp, lesson plan 3pp;
**student 10pp, full 18pp** (matches the 8.0–8.3 profile). Visually spot-checked notes_key p2 (two-panel figure — clean 1D spread + 2D cloud with
PC1/PC2 axes, no tofu; red answers $\mu{=}5$, $\sigma^2{=}5$, $\sigma_{xy}{=}3$, $V{=}[[5,3],[3,5]]$ correct) and the final slide (course-closer)
— clean. **Macros per file:** none beyond builtins (`\top` for transpose, `bmatrix`/`smallmatrix` for $V$; no `\vv`/`\relu` needed this data lesson).
**Unit 8 lessons 8.0–8.4 are now all authored & built — the course lesson content is COMPLETE.** The only remaining optional work is the Unit 8
summative tests (`tests/practice_test` + `actual_test`, `test_keys/`), which the user chose to scaffold but which may stay skeletons (Unit 8 is
"optional enrichment — not assessed" per the spec). **Next run (optional): author the Unit 8 tests** to fully close the unit, else the curriculum
(core Units 1–6 + optional Units 7–8 lessons) is done. Lessons 8.0/8.1/8.2/8.3/8.4 are the Unit 8 models.

**Prior run:** **Authored & built Unit 8 Lesson 8.3 — "Minimizing Loss by Gradient Descent" (§8.3 — now that
we can *build* networks, *choose* the weights by rolling downhill on the Unit-4 loss).** Filled every skeleton: lesson plan, cover,
warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 8.2's preamble/boxes/tone.
**Content — loss landscape → the update rule → the gradient:** (1) **learning = minimizing loss** — the loss $L$ is the Unit-4
sum of squared errors; for one weight it is a **bowl** (parabola), and the bottom is the best weight; can't eyeball it with millions
of weights, must *walk*. (2) **which way is downhill = the slope** — $L'(w)$ points *uphill*, so step the opposite way; slope is
**given** (no calculus); at the bottom slope $=0$. (3) **gradient descent** $w\leftarrow w-s\,L'(w)$ ($s$ = **learning rate**); the
bottom (slope $0$) is the stop signal. (4) **many weights = the gradient** $\nabla L$ (slopes for all weights at once), same rule
$\ww\leftarrow\ww-s\,\nabla L$; learning rate too small crawls / too big overshoots; **punchline** a net = Unit 1 (layers) + ReLU
(folds) + Unit 4 (loss) + gradient descent, no new machinery. **Single spine bowl** $L(w)=(w-4)^2$, slope $L'(w)=2w-8$, rate
$s=0.25$: iterates $0\to2\to3\to3.5\to\cdots\to4$ (gap halves), loss $16\to4\to1\to0.25$ — runs through *every* component.
**Custom two-panel TikZ** (left: royalblue bowl + burgundy ball + gold "step downhill" arrow + tangent, "bottom = best $w$"; right:
descent staircase $w_0,w_1,w_2$ dots marching to the minimum) via `plot coordinates` smooth (no pgfplots) on notes §2 + slides.
**Warmup spirals the three moves** (squared-error loss $[3,5]$ vs $[2,6]{=}2$ U4/8.0; slope sign $L'(2){=}{-}4$, $L'(6){=}4$ → which
way downhill; one update $2-0.25(-4){=}3$ U1) — warmup answers = notes opening. **Activity/Exit/HW spines (all hand-verified pure
Python):** Tier R fill update table $0\to2\to3$ + loss $16\to4\to1$; Tier A descend from other side $6\to5\to4.5$, slope $0$ at min
(stop), learning-rate Goldilocks ($s{=}0.5$ exact→4 vs $s{=}1$ overshoot→8); Tier E gradient of two weights $L{=}(w_1-1)^2+(w_2-3)^2$,
$(0,0)\to(0.5,1.5)\to(0.75,2.25)$ toward $(1,3)$ + justify step-against-gradient / slope-0-is-min. Exit: one step from $w{=}1$
($s{=}0.25$)→$2.5$, loss $9\to2.25$; slope $L'(4){=}0$ = stop + name "learning rate"; justify step-against-slope. HW: step both sides
($0\to2$, $8\to6$); loss falls $16\to4\to1$; learning-rate ($s{=}0.5$ exact, $s{=}1$ overshoot to 8); gradient $L{=}(w_1-2)^2+(w_2-5)^2$
$(0,0)\to(1,2.5)$ toward $(2,5)$; justify (against slope / slope-0-min / why iterate not solve); extension too-small rate ($s{=}0.05$→0.4,
safe-but-slow) + **whole-unit synthesis** (layers+ReLU+filters+gradient descent = a net that learns). **Built `make -C unit08/lesson03
all` → clean** (0 file-line/`^!` errors across all 13 logs; no `\ans`-in-math; 0 overfull >15pt — max 10.77pt is the standard
pageheader banner). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 2pp/2pp, homework
2pp/2pp, slides 5pp, lesson plan 3pp; **student 10pp, full 18pp** (matches the 8.0/8.1/8.2 profile). Visually spot-checked notes_key p2
(two-panel figure — clean royalblue bowl, burgundy ball, gold downhill arrow, descent staircase $w_0/w_1/w_2$, no tofu; red answers
$L'(0){=}{-}8$, $L'(4){=}0$, table $2/3/3.5$, gradient step $(0.5,1.5)$ all correct) — clean. **Macros per file:** `\vv,\bb,\ww,\zero,\relu`
(+ builtin `\nabla` for the gradient — no new package). Lessons 8.0/8.1/8.2/8.3 are now the Unit 8 models. **Next run: author Unit 8
Lesson 8.4** ("Mean, Variance, and Covariance", §8.4 — the shape of the data itself: how it centers, spreads, and how features move
together — the last lesson of the course), then the Unit 8 tests to complete the course.

**Prior run:** **Authored & built Unit 8 Lesson 8.2 — "Convolutional Neural Nets" (§8.2 — the same layer
$\relu(A\vv+\bb)$, but with weights *reused* across the input to scan for one pattern everywhere).** Filled every skeleton:
lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 8.1's
preamble/boxes/tone. **Content — from full layer to shared-weight filter:** (1) **too many weights** — a full layer gives every
connection its own weight ($\sim\!10^{12}$ for a megapixel image) and relearns the same edge everywhere; fix = a **small filter**
(kernel) **reused** at every position. (2) **Convolution = slide the filter**: filter $\ww=[-1,1]$ (output $-v_i+v_{i+1}$, "next
minus current") slid across $\vv=[2,2,2,6,6]$ gives the **feature map** $[0,0,4,0]$ — $0$ on flat parts, a **spike at the edge**;
an edge detector. (3) **It is a matrix** — sliding = $A\vv$ with $-1,1$ **repeated down the diagonals** (constant-diagonal
**convolution matrix**); **weight count** full $4\times5=20$ vs conv **2**; $1000\times1000$ image $\sim\!10^{12}$ vs a $3\times3$
filter's **9** (**weight sharing**). (4) **A conv layer is still $\relu(A\vv+\bb)$** — $A$ shared, $\bb$ a **threshold**: on
$[0,0,4,0]$ bias $-1\Rightarrow\relu([-1,-1,3,-1])=[0,0,3,0]$ (keep the strong response); payoff = **translation invariance** (one
reused filter fires wherever the pattern sits) + few enough weights to learn (8.3). **Custom two-panel TikZ** (left: royalblue step
signal $[2,2,2,6,6]$ + gold dashed sliding-filter window over the edge; gold "convolve" arrow; right: burgundy feature-map spike
$4$ at the edge, "fires at the edge") on notes §2 + slides. **Warmup spirals the three moves** (window dot products
$[-1,1]\cdot[2,2]{=}0$, $[-1,1]\cdot[2,6]{=}4$ U1/4; constant-diagonal $2\times3$ matrix×vector $[2,2,6]{\to}[0,4]$ U1; ReLU
entrywise $\relu([0,0,4,0])$ 8.0). **Activity/Exit/HW spines (all hand-verified pure Python):** Tier R edge filter $[-1,1]$ on
$[1,1,4,4]{\to}[0,3,0]$ (fire at edge) vs averaging $\tfrac12[1,1]{\to}[1,2.5,4]$ (smooth); Tier A build $4\times5$ conv matrix,
$A[3,3,3,8,8]{=}[0,0,5,0]$, count $20$ vs $2$, bias $-2\Rightarrow[0,0,3,0]$; Tier E translation invariance ($[3,9,9,9,9]{\to}
[6,0,0,0]$ vs $[3,3,3,3,9]{\to}[0,0,0,6]$ — same jump $6$, different place) + $10^{12}$-vs-$9$ param argument. Exit: slide $[-1,1]$
on $[2,2,7,7]{\to}[0,5,0]$, count $64$-vs-$3$ ("weight sharing"), justify detect-anywhere. HW: slide edge (flat $[4,4,4,4]{\to}
[0,0,0]$ never fires; $[1,1,6,6]{\to}[0,5,0]$); smoothing $[2,6,6,2]{\to}[4,6,4]$; build $3\times4$ conv matrix ($A[1,1,6,6]{=}
[0,5,0]$, repeated diagonal); weight count ($12$ vs $2$; $28\times28$ full $614{,}656$ vs $3\times3$ filter $9$); justify weight
sharing + bias-as-threshold; extension $5\times5$ filter $=25$ (fixed regardless of image size) + full pipeline
$\relu([-1,1]\ast[2,2,2,7,7]+(-3))=[0,0,2,0]$. **Built `make -C unit08/lesson02 all` → clean** (0 file-line/`^!` errors across all
13 logs; no `\ans`-in-math; 0 overfull >15pt — max 10.77pt is the standard pageheader banner). Page counts: cover/warmup/exit 1pp
(blank & key ✓ 1-page constraint), notes 3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 5pp, lesson plan 3pp; **student 10pp,
full 18pp** (matches the 8.0/8.1 profile). Visually spot-checked notes_key p2 (two-panel convolution figure — clean royalblue step
signal, gold dashed sliding window, "convolve" arrow, burgundy edge spike, no tofu; red answers $y{=}0,0,4,0$, $A\vv{=}[0,0,4,0]$,
weight count "2", ReLU $[0,0,3,0]$ all correct) — clean. **Gotcha (recurred):** `\bb` is a per-file macro — the warmup_key
teachernote used `$\relu(A\vv+\bb)$` but the blank warmup didn't, so the key preamble needed `\bb` added (define every math macro
the body uses, keys included, even when the blank doesn't; 1 build failure fixed). **Macros per file:** `\vv,\bb,\ww,\zero,\relu`
(added `\ww`=filter this lesson). Lessons 8.0/8.1/8.2 are now the Unit 8 models. **Next run: author Unit 8 Lesson 8.3**
("Minimizing Loss by Gradient Descent", §8.3 — now that we can *build* networks, *choose* the weights by rolling downhill on the
Unit-4 loss).

**Prior run:** **Authored & built Unit 8 Lesson 8.1 — "Piecewise Linear Learning Functions" (§8.1 — folding
shifted ReLUs into continuous piecewise-linear functions that bend to fit data).** Filled every skeleton: lesson plan, cover,
warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck, mirroring Lesson 8.0's preamble/boxes/tone.
**Content — the deep dive on the piecewise-linear structure 8.0 previewed:** (1) **one fold is not enough** — a line has one slope
forever, so bending data needs *folds*; build them by **adding shifted ReLUs** with two knobs: **shift $=$ where** ($\relu(x-s)$
slides the fold to $x=s$ — the bias) and **weight $=$ how steep** ($c\,\relu(x-s)$; $c<0$ bends down). (2) **The tent spine**
$F(x)=\relu(x)-2\relu(x-2)+\relu(x-4)$: turn on only ReLUs whose fold is left of $x$ ⇒ $F(0){=}0,F(2){=}2,F(4){=}0,F(6){=}0$ —
folds at $0,2,4$, peak $(2,2)$, a tent (up, down, flat). (3) **Read slopes as the running sum of switched-on weights**
$0\to1\to-1\to0$ (each fold adds its weight); **counting rule $N$ folds $\Rightarrow N+1$ pieces**. (4) **It is exactly a layer**
$\relu(A\vv+\bb)$: row $i$'s bias places fold $i$, its weight sets the slope; a *wider* $A$ = more folds = fits wigglier data;
choosing them to shrink the loss is learning (8.3). **Custom two-panel TikZ** (left: royalblue $\relu(x)$ + burgundy shifted
$\relu(x-2)$, gold "add" arrow, "the shift slides the fold"; right: burgundy tent, peak $(2,2)$, three fold markers) on notes §2 +
slides. **Warmup spirals the three build moves** (one ReLU = 1 fold, 8.0 recall; $\relu(x-2)$ slides fold to $x{=}2$; $\relu(x)+
\relu(x){=}2x$ doubles slope). **Activity/Exit/HW spines (all hand-verified pure Python):** Tier R shifted $\relu(x-2)$ fold +
ramp $\relu(x)-\relu(x-3)$ (folds 0,3, levels at 3); Tier A tent $\relu(x)-2\relu(x-3)+\relu(x-6)$ (peak $(3,3)$, slopes
$0,1,-1,0$), fold of $\relu(2x-6)$ from $2x-6{=}0\Rightarrow x{=}3$, count 5 ReLUs→6 pieces; Tier E pieces table $N{\to}N+1$,
2-turn wiggle needs 2 folds, why width=power. Exit: build tent $\relu(x)-2\relu(x-2)+\relu(x-4)$ ($0,2,0,0$, name shape), 4
ReLUs→5 pieces, justify folds-beat-a-line. HW: shifted ReLUs+folds; read $\relu(x)-\relu(x-2)+\relu(x-4)$ ($0,2,2,4$; slopes
$0,1,0,1$, a plateau); build tent $\relu(x)-2\relu(x-3)+\relu(x-6)$; **fit data + loss** $\relu(x)-\relu(x-2)$ preds $1,2,2$ vs
targets $1,2,3$ → loss 1 (fits first two exactly); justify bias-places-fold & width-adds-folds; extension 6 ReLUs→7 pieces + "one
fold per turn" (3 turns→3 folds). **Built `make -C unit08/lesson01 all` → clean** (0 `^!`/file-line errors across all 13 logs; no
`\ans`-in-math; 0 overfull >15pt after fixing 2: the notes §3 underbrace slope line → split into two `\[...\]`, and the slides tent
$F(x)$ def → moved full-width above the columns). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes
3pp/3pp, activity 2pp/2pp, homework 2pp/2pp, slides 5pp, lesson plan 3pp; **student 10pp, full 18pp** (matches the 8.0 profile).
Visually spot-checked notes_key p2 (two-panel tent figure — clean royalblue/burgundy ReLUs, gold "add" arrow, tent peak $(2,2)$,
three fold markers, no tofu; red answers $F$ values, slopes $1,-1,0$, count "4", $N$ all correct) and the slides tent frame — clean.
**Macros per file:** `\vv,\bb,\zero,\relu`. Lessons 8.0/8.1 are now the Unit 8 models. **Next run: author Unit 8 Lesson 8.2**
("Convolutional Neural Nets", §8.2 — the same layer $\relu(A\vv+\bb)$ but with weights *reused* across an image to scan for the same
pattern everywhere).

**Prior run:** **Authored & built Unit 8 Lesson 8.0 — "Setting Up --- Learning from Data" (the intro/spiral on-ramp for the final unit).**
Filled every skeleton: lesson plan, cover, warmup, notes, activity, exit_ticket, homework (+ the five keys) and the slides deck,
mirroring Lesson 7.0's preamble/boxes/tone. **Content — spiral + roadmap for Learning from Data:** (1) **learning = fitting a
function** to input–output examples; the simplest is the Unit-4 best-fit line $y=wx+b$ (two weights), but a line can't bend. (2)
**The one new ingredient — ReLU $=\max(0,x)$:** keeps positives, zeroes negatives — a single **fold**; add/shift a few and the
folds combine into a **piecewise-linear** function that bends to fit data (spine example $\relu(x)-\relu(x-2)$: ramps $0\to2$ over
$[0,2]$ then flat; $F(-1){=}0,F(1){=}1,F(3){=}2$). (3) **A layer is a matrix step** $\vv\mapsto\relu(A\vv+\bb)$ — linear step
(matrix×vector + bias, Unit 1) then ReLU per entry; spine $A=[[1,-1],[1,1]]$, $\vv=[1,2]\Rightarrow A\vv=[-1,3]\to\relu\to[0,3]$
(ReLU zeroes the negative); matrix multiplication does the heavy lifting, bias shifts the folds. (4) **How it learns + why it
matters** — score predictions with a **loss** = Unit-4 sum of squared errors (predict $3,5,4$ vs targets $2,5,6\Rightarrow$ loss
$1{+}0{+}4=5$); **learn** by rolling downhill = **gradient descent** (8.3); data's mean/variance/covariance (8.4); punchline: a
neural net is Unit 1 (matrix mult) + one bend (ReLU) + Unit 4 (least squares), no new machinery. **Custom two-panel ReLU TikZ**
(left: burgundy hockey-stick "one fold"; right: royalblue bent piecewise-linear fit through charcoal data dots, gold "combine"
arrow) on notes §2 + slides hook. **Warmup spirals the three pieces** (matrix×vector $[[1,-1],[1,1]][1,2]{=}[-1,3]$ Unit 1;
squared error $(4-6)^2{=}4$ Unit 4; $\max(0,\cdot)$ = ReLU in disguise, arithmetic). **Activity/Exit/HW spines (all hand-verified
pure Python):** Tier R ReLU eval + one layer $[[2,-1],[-1,2]][1,3]{=}[-1,5]\to[0,5]$; Tier A full layer w/ bias
$\relu([[1,2],[1,-1]][2,1]+[-5,0]){=}[0,1]$, bending $\relu(x)+\relu(x-2)$ (folds at 0,2; slopes 0/1/2), loss compare $5$ vs $1$;
Tier E **why ReLU is not optional** — two ReLU-less layers collapse to one matrix $A_2A_1=[[2,2],[1,2]]$ (verified $A_2(A_1\vv)=
(A_2A_1)\vv=[4,3]$). Exit: one layer $[[1,-2],[1,1]][3,2]{=}[-1,5]\to[0,5]$, loss $(2,5,3)$ vs $(3,5,1)=5$, justify why ReLU
needed. HW: ReLU eval (incl. decimal/0); layer w/ bias two inputs $[[1,-1],[2,1]]$,$\bb=[0,-3]$ ($[2,1]\to[1,2]$; $[1,3]\to[0,2]$);
$\relu(x)-\relu(x-3)$ (folds 0,3; levels at 3); loss compare $2$ vs $5$; justify engine/ReLU; extension collapse
$A_2A_1=[[3,2],[1,1]]$; preview 8.1. **Built `make -C unit08/lesson00 all` → clean** (0 `^!`/file-line errors across all 13 logs;
no `\ans`-in-math; 0 overfull >15pt). Page counts: cover/warmup/exit 1pp (blank & key ✓ 1-page constraint), notes 3pp/3pp,
activity 1pp/2pp, homework 2pp/2pp, slides 5pp, lesson plan 3pp; **student 9pp, full 18pp** (matches the 7.0/6.0 intro profile).
Visually spot-checked notes_key p2 (two-panel ReLU figure — clean burgundy fold + royalblue bent fit through data dots + gold
"combine" arrow, no tofu; red answers $\relu$ values, $F$ values, $A\vv{=}[-1,3]\to[0,3]$, loss $=5$, "matrix" fill all correct) —
clean. **Macros per file:** `\vv,\bb,\zero,\relu` (with `\relu`=`\mathrm{ReLU}`); no transpose needed this lesson. Lesson 8.0 is
now the Unit 8 model (mirrors 7.0/6.0/5.0/4.0). **Next run: author Unit 8 Lesson 8.1** ("Piecewise Linear Learning Functions",
§8.1 — folding many lines with ReLUs into a continuous piecewise-linear function that fits any data).

**Prior run:** **Scaffolded all of Unit 8 (Learning from Data), the final unit — skeletons only.**
Ran `new_lesson.py` for lessons 8.0–8.4 (component set: cover, warmup, notes, activity, exit_ticket, homework, slides
+ keys for the keyed components). The 8.0 run created the unit, so `unit08/tests/` (practice + actual),
`unit08/test_keys/` (both keys), `unit08/sample_test/`, `unit08/sample_test_key/`, `unit08/Makefile`, and the
thin-include test Makefiles were all auto-scaffolded too. **Confirmed lesson map (5 lessons; user chose 8.0 intro +
8.1–8.4):** 8.0 "Setting Up --- Learning from Data" (intro/spiral, mirrors 7.0/6.0/5.0/4.0) · 8.1 "Piecewise Linear
Learning Functions" (§8.1) · 8.2 "Convolutional Neural Nets" (§8.2) · 8.3 "Minimizing Loss by Gradient Descent" (§8.3) ·
8.4 "Mean, Variance, and Covariance" (§8.4) — matches `spec/linear_algebra_v2.md` §8.1–8.4 plus the customary `lesson00`
intro. **Unit 8 is "optional enrichment — not assessed" per the spec** ("no expectation of testing students"), but the
**user explicitly chose to scaffold the summative tests anyway** (in case they want the option to assess later — they may
stay skeletons); authored as an ordinary unit of lessons (same component set + down-leveling as 1–7). Verified all 5 lesson
dirs carry the identical 13-subdir component set (cover/warmup/notes/activity/exit_ticket/homework/slides + 5 keys + images),
and root + `unit08/` Makefiles exist. `sample_test`/`sample_test_key` PDFs are NOT yet populated (they come from `drop`
after the tests are authored). **Nothing is authored yet — every `main.tex` is a preambled skeleton.** Lessons 7.0–7.4 are
the newest model set (SVD unit, same structure); Lesson 4.0 remains the cross-unit intro-style model; Unit 4/5/6/7 tests are
the assessment-format model. **Next run: author Unit 8 Lesson 8.0** ("Setting Up --- Learning from Data") first as the Unit 8
model, then 8.1→8.4, then the Unit 8 tests — completing the course. The core sequence (Units 1–6) and optional Unit 7 are
already complete; Unit 8 is the final optional-enrichment extension.

**Prior run:** **Authored & built the Unit 7 summative tests — Unit 7 is now complete.**
Filled all four skeletons (`tests/practice_test`, `tests/actual_test`, `test_keys/practice_test_key`, `test_keys/actual_test_key`),
mirroring the Unit 4/5/6 test format (`shared/tests.mk` + `test_keys.mk`; `\parthead` burgundy strips; Part A vocab matching /
B multiple choice / C computation / D extended response; 8/12/35/10 pts = 65). **Blueprint spans the whole unit §7.0–7.4:** A
(8 terms — singular value, singular vectors, SVD, outer product, rank-one matrix, orthogonal matrix, principal component, energy),
B (6 MC — σ always ≥0 / use eigenvalues of $A\T A$ / σ=√λ / all stretching in Σ / orthogonal $Q\T Q=I\Rightarrow Q^{-1}=Q\T$ /
compress keeps biggest σ; actual variant: every matrix has an SVD / $\vv_i$ eigenvectors of $A\T A$ / $\uu_i=A\vv_i/\sigma_i$ /
outer product = rank-one / orthogonal preserves length / PC1 = greatest spread), C (7 items — read σ off diagonal + swap (7.0);
σ via $A\T A$ recipe (7.1); output $\uu_1=A\vv_1/\sigma_1$ + unit check (7.1); outer product + why rank-one (7.2); rank-1
approximation $A_1$ + energy fraction (7.2); orthogonal $Q\T Q=I$ + free inverse + length preserved (7.4); PCA center→$A\T A$→
eigenvalues→PC1 fraction (7.3)), D (2 items — why $A\T A$ symmetric ⇒ real λ≥0 + ⊥ eigenvectors ⇒ every matrix has σ=√λ (7.1);
rotate–stretch–rotate geometry + all stretch in Σ + $Q^{-1}=Q\T$ & length preservation (7.4)). **Practice vs. actual use
parallel-but-distinct numbers, all hand-verified in pure Python (no numpy):** practice C1 diag(3,4)→σ4,3 + swap $[[0,2],[1,0]]$→σ2,1;
C2 $A=[[2,2],[1,-2]]$→$A\T A=[[5,2],[2,8]]$→λ9,4→σ3,2; C3 $\vv_1=\tfrac1{\sqrt5}(1,2)$→$\uu_1=\tfrac1{\sqrt5}(2,-1)$; C4 outer
$(1,3)(2,1)\T=[[2,1],[6,3]]$; C5 $[[4,2],[2,4]]$ σ6,2 → $A_1=[[3,3],[3,3]]$ keeps 36/40=90%; C6 $Q=\tfrac15[[3,-4],[4,3]]$ (3-4-5),
$(5,0)\to(3,4)$ len5; C7 $(5,7),(7,5),(3,1),(1,3)$→mean(4,4)→$A\T A=[[20,12],[12,20]]$ λ32,8 PC1 80%. actual C1 diag(5,2)→σ5,2 +
swap $[[0,3],[2,0]]$→σ3,2; C2 $A=[[3,1],[-1,-3]]$→$A\T A=[[10,6],[6,10]]$→λ16,4→σ4,2; C3 $\vv_1=\tfrac1{\sqrt2}(1,1)$→$\uu_1=
\tfrac1{\sqrt2}(1,-1)$; C4 outer $(2,1)(1,3)\T=[[2,6],[1,3]]$; C5 $[[6,4],[4,6]]$ σ10,2 → $A_1=[[5,5],[5,5]]$ keeps 100/104≈96%;
C6 $Q=\tfrac15[[4,-3],[3,4]]$ (4-3-5), $(0,5)\to(-3,4)$ len5; C7 $(6,5),(5,6),(2,3),(3,2)$→mean(4,4)→$A\T A=[[10,8],[8,10]]$ λ18,2
PC1 90%. Built `make -C unit07/tests all` and `make -C unit07/test_keys all` → **clean** (0 `^!`/file-line errors across all 4
logs; no `\ans`-in-math; 0 overfull >15pt). Page counts: all four PDFs **3pp**; `drop` published `sample_test/main.pdf` (practice,
3pp) and `sample_test_key/main.pdf` (practice key, 3pp). Visually spot-checked the practice key Part C/D page (all matrices, red
answers, unit check ✓, $A\T A$/σ/PCA/orthogonal work, teachernotes) — clean, no tofu. **Unit 7 is now fully complete (lessons
7.0–7.4 + tests).** This completes the optional/advanced Unit 7. Next run: begin Unit 8 if desired (confirm the lesson map with the
user), else the course (core Units 1–6 + optional Unit 7) is done. Lessons 7.0–7.4 are the Unit 7 models; Unit 4/5/6 tests are the
assessment-format model.

**Prior run:** **Authored & built Unit 7 Lesson 7.4 — "The Victory of Orthogonality" (§7.4 — the
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
- `unit01/unit_cover/main.tex` — **authored ✅ & built (2026-08-02), the course's first unit cover.** 1pp; leads both
  `unit01_student.pdf` and `unit01_key.pdf`. See "Unit cover sheets" at the top of this log. (`unit02/unit_cover/main.tex`,
  2026-08-03, is now the better copy-from model — it carries the banner `\mbox` fix.)
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
- `unit02/unit_cover/main.tex` — **authored ✅ & built (2026-08-03), the course's second unit cover** and the model to copy from
  (it carries the banner `\mbox` fix). 1pp, zero over/underfull; leads both `unit02_student.pdf` and `unit02_key.pdf`, **74pp each
  — Unit 2 is aligned end to end.** See "Unit cover sheets" at the top of this log.

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
| 1 | Vectors and Matrices | 1.0 intro + 1.1–1.4 | ☑ all lessons + tests authored & built ✅ · **unit cover ☑** |
| 2 | Solving Linear Equations Ax = b | 2.0 intro + 2.1–2.4 | ☑ all lessons + tests authored & built ✅ |
| 3 | The Four Fundamental Subspaces | 3.0 intro + 3.1–3.5 + 3.6 capstone (FTLA) | ☑ all lessons + tests authored & built ✅ |
| 4 | Orthogonality | 4.0 intro + 4.1–4.4 | ☑ all lessons + tests authored & built ✅ |
| 5 | Determinants and Linear Transformations | 5.0 intro + 5.1–5.3 | ☑ all lessons + tests authored & built ✅ |
| 6 | Eigenvalues and Eigenvectors | 6.0 intro + 6.1–6.4 (§6.4 optional) | ☑ all lessons + tests authored & built ✅ |
| 7 | The Singular Value Decomposition *(optional/advanced)* | 7.0 intro + 7.1–7.4 | ☑ all lessons + tests authored & built ✅ |
| 8 | Learning from Data *(optional enrichment)* | 8.0 intro + 8.1–8.4 | ☑ all lessons **authored** (8.3, 8.4 confirmed on disk 2026-08-06 — this row previously said "skeletons" and was stale); tests authored (practice + actual + keys) |

**Unit covers:** Units 1 and 2 have the `unit_cover` / `unit_cover_key` pair. **Units 3–8 have none** and fall back to the
plain packet merge — this is the largest remaining gap.

**Full unit-and-lesson map:** `spec/course_breakdown.md` (added 2026-08-06) — all 41 lessons with a one-line "students can…"
per lesson, the `X.0` on-ramp and 3.6-capstone conventions, and the assessment map. That file is the *structural* reference;
this file stays the *build-state* log.

## Next steps

1. **Authoring is done course-wide.** All 41 lessons (Units 1–8), all 8 unit test pairs + keys, and the `finals/` deliverable
   are authored — verified file-by-file on disk 2026-08-06. **Build state was not re-verified that run** (`target/compiled/`
   held only unit01, unit02, unit06), so a `make` sweep is the honest next check: `make -C unitXX all` per unit, then confirm
   each component's page count equals its `_key`'s and that warm-ups / exit tickets are still 1pp on both sides.
2. **Unit covers for Units 3–8** — Units 1 and 2 have one. Copy `unit02/unit_cover/main.tex` per unit and swap the banner title,
   overview paragraph, lesson rows, big ideas, and LAfE chapter/sections; keep `\pagestyle{empty}`; `\mbox` any math in the banner
   title; re-verify 1 page with `pdfinfo` (Unit 3's 7 lessons will need tighter Focus cells). Ask the user first whether they want
   all six.
3. *(optional)* Rebuild the whole-course packets (`make -C unitXX student|full`, or `make student|full` at the root) to
   confirm every unit's `sample_test`/`sample_test_key` drop-ins (now incl. Unit 7) merge in as expected.

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
