# Novelty search — full query record (the package's novelty evidence)

Provenance note: this file concatenates the exclusivity-search records of the
source task (the deep-dig narrow-path layer, closing 2026-10-06, and the
independent exclusivity review layer, closing 2026-10-06). For publication the
text was translated to English and internal repository references were
generalized; **conclusions, query strings, hit lists, and all data are
unchanged**. The two source documents stay in the source repository and are not
shipped; the concatenation is reproducible by the deliverable-directory tooling
(not shipped).

> **2026-10-07 version note.** English cleaned edition for publication
> (translation + generalization of internal references); the record's content is
> otherwise verbatim.

===== begin full record =====

# Part 1: exclusivity search record (deep-dig narrow-path report, closing 2026-10-06)

**Four-state adjudication: no occupying record found.**

Strength labels as recorded by the search: OEIS value-column layer **strong**;
arXiv metadata layer recorded as "no same form at the metadata layer" (the
channel reaches metadata only); full-text layer (7 neighbouring papers read in
full) **strong**; public-ecosystem layer **strong**.

## 1.1 Anchor source layer (load-bearing, full-text level)

- **arXiv:2601.16757, read in full**: the self-reported open statement is in
  the final paragraph of §1, verbatim (LaTeX source form):
  > "We believe that finitely many solutions occur for `x^{2}=n!\cdot n\#` or
  > `x^{2}=n!!\cdot[1,...n]`, but at the moment we were not able to give an
  > argument."
  Context = the d ≤ r discussion paragraph (after listing `x²=Aⁿn!·Bᵐm!`,
  `x²=n!·m!!`, `x²=n#·m#`, `x²=n!·m#·l!` as all having infinitely many
  solutions). **The full text lists no other open item concerning this
  equation** (full-text scan for `believe`/`open`/`not able`: only this one
  occurrence points at this equation). Symbol confirmation: `[1,...,n] =
  ∏_{p≤n} p^{⌊log_p n⌋}` (verbatim inside the proof of Theorem 6) = lcm(1..n).
- **The author's 2025–2026 output, item by item in full text** (author search
  under both spellings `Novaković` / `Novakovic`, 40 hits each, 6
  mathematics-related items all read):

| item | date | full-text conclusion |
|---|---|---|
| 2510.24312 (double-factorial Diophantine equations) | 2025-10-28 | objects = the `(k!!)ⁿ±kⁿ` family and ABC-side `∏ Aᵢⁿⁱ nᵢ!!`; **`[1,…,n]`/lcm object: 0 hits** |
| 2602.09687 (Brocard–Ramanujan generalization) | 2026-02 | object = `∏ Qᵢ(Aᵢⁿⁱ nᵢ!)` = homogeneous f; `!!` occurs only in the reference list; **does not contain this equation** |
| 2602.23838 (factorial products = factorial products) | 2026-02-27 | object = `∏ aᵢ! = ∏ nⱼ!`; `[1,…,n]`/lcm: 0 hits |
| 2604.09730 (n!! = a₁!!⋯a_t!!) | 2026-04-09 | double-factorial decomposition equation; `[1,…,n]`/lcm/x² forms: 0 hits |
| 2610.01899 (Yudin, factorial square products × Erdős–Graham) | 2026-10-01 | object = square products of distinct factorials (D_k(X)); `n!!`: 0 hits in the full text; `lcm` appears only as an appendix construction parameter L_R = lcm(1,…,R); **does not contain this equation** |
| 2606.23485 (Peixoto, Brocard structural invariants) | 2026-06 | `!!`: 0 hits in the full text; no lcm/`[1,…,n]` object; **does not contain this equation** (this capture's table of contents differs from the one cited in the review batch, suspected revision; the relevant claim — it does not cover n!!·lcm — holds in both versions) |

## 1.2 OEIS layer (value columns = computed first, then searched)

| query string (prefix variants) | returned | adjudication |
|---|---|---|
| solution n-column: `0,1,2,5,7` / `1,2,5,7` / `2,5,7` | 10 hits each, all pentagonal-number / decimal-expansion **irrelevant noise** | no object-level registration (weak hit = noise) |
| solution-root x-column: `1,1,2,30,210` / `1,2,30,210` | **null × 2** | strong zero hit |
| x-column minus first two: `2,30,210` | 2 hits: A278250 (Wedderburn–Etherington prime signature), A306745 — both **irrelevant** | noise |
| object value column a(n)=n!!·lcm(1..n): `1,1,4,18,96,900` / `1,4,18,96,900` / `4,18,96,900,2880` / `18,96,900,2880,44100` | **null × 4** | **strong zero hit** |
| square value column: `1,4,900,44100` null; `900,44100` | 4 hits: **A061742 = (p_n#)²** (entered precisely because x = n#, not a registration of this equation), A329964 = (n!/⌊(1+n/2)⌋!)² (irrelevant), 2 further irrelevant | no object-level registration |
| sf(n!!) column: `1,1,2,3,2,15,3,105` null; `2,3,2,15,3,105,6,105` | 1 hit A299700 = sf(1!·2!···n!) (**different object**) | sf(n!!) column unregistered |
| sf(lcm(1..n)) column: `1,2,6,3,15,15,105,210,70` and 1 further variant | **A056839 "Squarefree part of lcm(1,...,n)" is registered** (%F: a(n) = A007913(A003418(n)) = lcm/lcm(⌊√n⌋)²; xref 1 entry; **no mention of double factorial anywhere in the entry**) | **the L(n) side is occupied at the sequence level**; the characterizing equation (the solution set) has no registration of any kind |
| keywords: `"double factorial" "least common multiple"` null; `"semifactorial"` null; `"squarefree part" "double factorial"` null; `"double factorial" "square"` 10 hits (A001818 = (n!!)² etc., all irrelevant); `"double factorial" "primorial"` 4 hits (all irrelevant) | — | keyword layer: no same form |

## 1.3 arXiv metadata layer (the channel reaches metadata only; a zero hit is
recorded as "no same form at the metadata layer")

Positive control `all:"double factorial"` = 34 hits (including 2510.24312)
⟹ channel live. Load-bearing queries:
`"double factorial"∧"least common multiple"∧square` = 0; `∧"lcm"` = 0;
`∧"perfect square"` = 0; `∧"perfect power"` = 0; `∧quadratic` = 1 (irrelevant
p-adic L-function); `∧square` = 2 (both irrelevant); `∧"diophantine"` = 1
(= 2510.24312 itself, read in full); `∧Brocard` (quoted/unquoted) = 0;
`"primorial"∧"double factorial"∧square` = 0; `"factorial"∧"least common
multiple"∧"perfect square"` = 0; `"least common multiple"∧"factorial"∧"diophantine"`
= 0; `all:semifactorial` = 0. **No same form at the metadata layer.**

## 1.4 "Confirm still open" evidence

- **Semantic Scholar citation graph (channel recovered on 2026-10-06)**:
  `paper/arXiv:2601.16757/citations` = **0 citations**. (The interface then
  turned to 429; the first load-bearing query had already succeeded, later
  rate-limiting recorded as such.)
- **The author's three follow-up items of the same period** (2602.09687 /
  2602.23838 / 2604.09730, 2026-02 to 04) **do not return to this equation**
  (full text, §1.1 table) — the author has not closed it himself.
- OpenAlex: title search "double factorial" = 49 items, none is this equation
  in the full listing; the anchor itself was not indexed under title search
  ⟹ OpenAlex's citation layer recorded **undecided** (not used as a zero-hit
  evidence).
- zbMATH: query form returned "successful access. No results found" (weak
  channel, recorded as such, not load-bearing).

## 1.5 Public Lean ecosystem layer + mathlib library layer (content level)

- **Public-conjectures mirror**: `doubleFactorial` occurs in exactly 1 file in
  the whole repository = `OEIS/1818.lean` (A001818 = the (2n−1)!! square value
  column, **a different object**); `lcm×range` occurs in 3 files = ErdosProblems
  269/873/1063 (all irrelevant objects). **This equation's statement layer:
  zero registration**, no external `formal_proof` link to follow.
- **mathlib** (ripgrep `--follow`; positive control `Nat.Prime` = 21 files ⟹
  channel live): `doubleFactorial` occurs in only 4 files
  (DoubleFactorial.lean itself + GaussianIntegral/Multinomial/Hermite — none in
  a number-theoretic square context); `lcmUpto` occurs only in Chebyshev.lean.
  **The object itself: no same form** (library layer); **the two objects never
  co-occur.**

---

# Part 2: independent exclusivity review record (closing 2026-10-06)

**Verdict: maintained** (all load-bearing claims of Part 1 survive; three
first-pass evidence defects are recorded and do not change the verdict).

Method: the review re-searched along four offset dimensions — different prefix
variants (full column / drop first 4 / alternating-parity sub-column /
duplicate-including n-index column, all cuts unused in the first pass);
different alias sets (`doublefactorial` as one word / "least common multiple of
the first" / semifactorial×square / "double factorial"×Chebyshev / cofinite
primorial / primorial quotient / primorial divisor / Chinese-language layer);
different access channels (Crossref API / OpenAlex with ≥12 s spacing / DOI
direct publisher pages / erdosproblems.com site layer / oeis.org fmt=text
search and single-entry reads); different depth line (all 17 references of
2601.16757 checked one by one + second-level full-text retrieval of the
load-bearing cited items).

## 2.1 OEIS value-column layer (new prefix variants, oeis.org/search fmt=text)

| review variant (unused in the first pass) | returned | adjudication | strength |
|---|---|---|---|
| full 8-term object column `1,1,4,18,96,900,2880,44100` | no %I line (null) | zero hit | strong |
| drop first 4 `96,900,2880,44100,322560` | null | zero hit | strong |
| even-n alternating sub-column `1,4,96,2880,322560,9676800` | null | zero hit | strong |
| odd-n alternating sub-column `1,18,900,44100,2381400` | null | zero hit | strong |
| square column minus first `4,900,44100` / full `1,1,4,900,44100` | null ×2 | zero hit | strong |
| sf(n!!) minus first 3 `3,2,15,3,105,6,105,15` | 1 hit A299700 = sf(1!·2!···n!) | **different object** (same item the first pass recorded) | — |
| sf(n!!) odd-n sub-column `1,3,15,105,105,1155` | null | zero hit | strong |

## 2.2 New alias layer (OEIS fmt=text + Crossref + OpenAlex)

- OEIS: `doublefactorial` (one word) → 10+ hits, all bare double-factorial
  objects (A001147/A006882/A000165/A001818/A007749 etc., %N checked one by
  one, none is this equation); `"least common multiple of the first" factorial
  square` → null; `semifactorial square` → null; `"double factorial"
  Chebyshev` → 2 hits (A344678 Hermite coefficients / A000984 central binomial
  coefficient, both irrelevant). Strength: medium.
- Crossref: `query=double factorial least common multiple square` (top-15 all
  LCM pedagogy items); `query.bibliographic=double factorial least common
  multiple` (same); `semifactorial square diophantine` (top-15 all irrelevant);
  `Novakovic Diophantine equation factorial` (top-15 none is this equation);
  Chinese-language layer (query string, UTF-8 code units: \u53cc\u9636\u4e58\u0020\u6700\u5c0f\u516c\u500d\u6570\u0020\u5e73\u65b9) -> total=0. **Crossref is a
  relevance-ranked channel and only supports "no strongly related title"**
  here. Strength: weak-to-medium (recorded as such, not load-bearing).
- OpenAlex: `search="double factorial" "least common multiple"` (phrase level,
  covering title/abstract/full text) → **exactly 5 items, all irrelevant**
  (a Maeda conjecture, two dictionaries, an involution decomposition, lattice
  SIVP) — **zero same form for this equation's object (strong, new channel,
  load-bearing)**; `title.search:double factorial lcm` → 0; `semifactorial
  square` → 63 items, relevant top = known neighbours (2604.09730, Glasnik
  2023/2025), none is this equation.

## 2.3 "Confirm still open" citation axis (independent channel)

- First pass: Semantic Scholar `paper/arXiv:2601.16757/citations` = 0.
- Review: the anchor is reachable in OpenAlex **via arXiv DOI routing**
  `W7125688237` (the first pass reported "not indexed" from a title search;
  the more accurate statement is "indexed but not recalled by title search;
  reachable by DOI routing"), **cited_by_count = 0** (the `cites` filter
  count = 0). **Consistent with Semantic Scholar across two independent
  channels.**
- erdosproblems.com site layer: `double factorial` / `semifactorial` /
  `Novakovic` / `n!!` all **No results found**; `factorial` / `primorial` /
  `lcm` / `least common multiple` return entries, none has this equation's
  object. Strength: medium (the site search's semantics are opaque, recorded
  as such).

## 2.4 Depth line: the 17 references of 2601.16757, checked one by one

All 17 reference entries of the anchor were checked, and the second-level
full texts of the load-bearing cited items were retrieved: none treats
`x² = n!!·lcm(1..n)`; the self-reported open sentence was re-confirmed
against the PDF text layer as well (independent of the HTML capture used in
the first pass).

**Review verdict: maintained.** The three first-pass evidence defects recorded
by the review (OpenAlex indexing status of the anchor; the erdosproblems site
layer's semantic limits; the Crossref channel's relevance-ranking nature) are
documentation-precision items and do not change the four-state adjudication.

===== end full record =====
