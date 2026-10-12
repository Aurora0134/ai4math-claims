# Novelty search — full query record (the package's novelty evidence)

Provenance note: this file concatenates the two exclusivity-search records of
the source task (the deep-dig layer, closing 2026-10-05, and the independent
review layer, closing 2026-10-06). For publication the text was translated to
English and internal repository references were generalized; **conclusions,
query strings, hit lists, and all data are unchanged**. The two source
documents stay in the source repository and are not shipped; the
concatenation is reproducible by the deliverable-directory tooling (not
shipped).

> **2026-10-07 version note.** English cleaned edition for publication
> (translation + generalization of internal references); the record's
> content is otherwise verbatim.

===== begin full record =====

# Part 1: exclusivity search record (deep-dig draft card, closing 2026-10-05)

**Four-state adjudication: no occupying record found (search-strength label: strong).**

| channel | query string | returned | evidence file (source repository, not shipped) |
|---|---|---|---|
| literature (author self-report) | 2601.16757 body text, verbatim | "We believe that finitely many solutions occur for `x² = n!·n#` or `x² = n!!·[1,…n]`, **but at the moment we were not able to give an argument**" | `raw-brocard-deep/txt-2601.16757.txt:160` (quoting the second review's raw capture) |
| arXiv metadata | `all:"primorial" AND all:"factorial" AND all:"perfect square"` | **totalResults = 0** | `raw-n6/arxiv-primorial-factorial-square.xml` |
| arXiv metadata | `all:"primorial" AND all:"factorial" AND all:"square"` | **totalResults = 0** | `raw-n6/arxiv-primorial-square-factorial2.xml` |
| arXiv metadata | `all:"double factorial" AND all:"least common multiple"` | **totalResults = 0** (the second equation of the pair) | `raw-n6/arxiv-doublefactorial-lcm.xml` |
| arXiv metadata | `all:"squarefree part" AND all:"factorial"` | **totalResults = 0** | `raw-n6/arxiv-squarefree-part-factorial.xml` |
| arXiv metadata | `all:"Brocard" AND all:"primorial"` | totalResults = 1 (2606.23485 = adjacent by mechanism, **does not cover this equation**) | `raw-n6/arxiv-primorial-brocard.xml` |
| OpenAlex full text | `searrocard primorial square factorial` | count = 2 (2606.23485; Marius Coman 2013 popular encyclopedia) | `raw-n6/oa-brocard-primorial.json` |
| OpenAlex full text | `search=k-free Brocard Ramanujan finitely many solutions` | count = 16, including 2601.16757 / 2602.09687 | `raw-n6/oa-kfree-naciri-effective.json` |
| OEIS keyword | `n! primorial square` | 10 hits, **no same-form** (A145781 is a different object) | `raw-n6/oeis-kw-nfact-primorial-square.json` |
| OEIS keyword | `factorial times primorial is a square` | 7 hits, **no same-form** | `raw-n6/oeis-kw-factorial-square-primorial.json` |
| OEIS keyword | `double factorial lcm square` | **`null` (zero hits)** | `raw-n6/oeis-kw-doublefactorial-lcm-square.json` |
| OEIS keyword | `Novakovic factorial` | **`null`** | `raw-n6/oeis-kw-novakovic.json` |
| public Lean ecosystem tarball, content level | `primorial` | 3 files (FortuneConjecture.lean / OEIS/38771 / OEIS/80326), **no item in this domain** | mirror `eco/formal-conjectures-main/` (source-repository mirror; deleted after the batch) |
| public Lean ecosystem tarball, content level | `doubleFactorial` / `double_factorial` | **0 / 0** | same as above |
| channel-validity precheck | mathlib ripgrep `--follow` + positive control `Nat.Prime` = 138 files | channel live | `deep/raw-main/mathlib-rg.txt` |

**Anchor pointer and first-appearance year**: Novaković 2026-01-23
(arXiv:2601.16757, body-text Remark, **the first appearance of this
equation**); small values with `n!·n#` square (`5!·5# = 3600 = 60²`) appear in
the context of A055204/A002110.
**Identifier/name-mismatch discipline**: this record does **not** treat
erdosproblems #399 as this equation's number — the object of #399 is
`n! = x^k ± y^k` (checked in the ecosystem file `ErdosProblems/399.lean`; its
`erdos_399.variants.sum_two_squares` has object `n! = x²+y²`), **a different
object** from this equation (`x² = n!·n#`); #399 is recorded only as a
same-family adjacency anchor. The direct anchor for this equation = **the
author's self-reported open case**.
**Channel status**: all channels usable.
**Topic-provenance handling**: this item is a literature-gap extension (no
"self-made" label exemption claimed); the full check battery was run.

---

# Part 2: review-layer supplementary search record (independent re-review batch, closing 2026-10-06)

1. **The largest residual gap is closed**: 2606.23485 was checked section by
   section in full text — it does **not** treat `x² = n!·n#` (its §5.3.1
   "primorial-core Pell" `X²−DZ²=1`, `D=p_n#`, `Z²=n!/p_n#` is adjacent to
   this candidate's object but gives only the `n=5` example and never
   characterizes which `n` make `n!·n#` a square), and it does **not** treat
   consecutive shifted pairs (zero occurrences of `(n+1)!` in the full text)
   ⟹ **no collision with this candidate or with the sibling candidate, and
   the unreturned item hides no mine**. Obligation: this candidate's
   related-work wording must cite that paper's §5.3.1.
2. **One newly found missed item**: **arXiv:2610.01899** (2026-10-01, square
   products of factorials and the Erdős–Graham conjecture, growth order of
   `D_k(X)`) — same-family literature, submitted only 4 days before the
   batch and uncited by it. A different object from this candidate's, no
   collision, but a citation duty is recorded on the candidate card.
3. **#399 status reversal**: `n! = x^k ± y^k` is **DISPROVED (Lean)**
   (2026-02-04, counterexample `10! = 48⁴ − 36⁴`; the ecosystem file
   `399.lean` has its main theorem proved, no sorry). The batch used #399
   only as "same-family adjacency" in one ruling line, with the objects
   explicitly distinguished, and never called it open — **no violation**;
   but downstream cards must not use #399 as an open anchor. Its ecosystem
   variant `sum_two_squares` (`n! = x²+y²`, unique solution `6! = 12²+24²`,
   carrying a sorry) and Dąbrowski's `n!+1 = x²+y²` are indeed different
   objects — the earlier report is correct on this point.
4. **Kurepa-side supplementary check**: 2604.09714 (KBW congruence, quotient
   level) is a public prior item of the "new `!p` congruence" type — the
   Kurepa route had already closed with 0 items, so no impact; any future
   reopening of the Kurepa side must differentiate from it. 2509.06077
   (partition-function side): no collision. 2609.28805 (2026-09-23,
   Kurepa-variant parallel search): no collision.
5. **Collision re-confirmation (all zero hits)**: this candidate's x-value
   column 1,1,2,6,12,60 and x²-value column 1,4,36,144,3600 have no object
   registration in OEIS; the sibling candidates' three k-value columns
   (1,76,505 / 241,505,2089,5209,22081 / 436,1044,2529,5364) are all null;
   the other sibling's N_k value column is all null, and arXiv "Legendre
   symbol × factorial × prime gap" returns zero hits. ⟹ The batch's core
   novelty conclusions were not overturned in this round.
6. **#398 remains open** (2026-04-01 edit, with a new Naciri Integers 2025
   A71 entry — the batch already holds that item; not a miss).
