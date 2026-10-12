# nfact-primorial-square — paper and artifact package

Paper under CC BY 4.0, code under MIT (the single `license` field of
`zenodo.json` is MIT; CC BY 4.0 is added through the Zenodo UI multi-licence
control).

## Contents

- `paper/` — `paper.tex`, `paper.pdf`, `lstlean.tex` (the paper; its Lean
  listings are byte-identical splices of the shipped proof files, see
  `audit/listing-verify.txt`; compiles with tectonic/XeLaTeX).
- `proofs/` — `nfact-primorial-square.statement.txt` (the frozen statement
  snapshot of record), `nfact-primorial-square.lean` (the statement source,
  `sorry` placeholder bodies by design), `final-nfact-primorial-square.lean`
  (the final development, 0 sorry), `lean-toolchain`
  (`leanprover/lean4:v4.34.0`). Comments and docstrings were cleaned to
  English for publication; code regions are byte-identical to the frozen
  development (record: `audit/comment-cleanup-diff.md`).
- `audit/` — verification evidence: `gate3-final-adjudication.txt` (the final
  adjudication: statement comparison against the frozen snapshot, strict
  compile, sorry scan, axiom whitelist — all PASS; grading = complete proof),
  `welldef-nfact-primorial-square.txt` (well-definedness check: WELLDEF OK +
  all bare-tactic probes FAIL = non-degenerate), `axioms.out` (the `#print
  axioms` outputs), `faithful.md` (roundtrip faithfulness record),
  `bib-verify.md` (bibliography existence checks), `c9-record.md` (novelty
  search, full query log), `paper-check.md` (the claim audit of the paper
  text); this package's `lint.txt` / `compile-run.log` /
  `listing-verify.txt` / `lean-idents.txt`; `comment-cleanup-diff.md`;
  `kernel-rerun.txt` (post-cleanup kernel re-verification);
  `package-notes.md`. Audit documents are English cleaned editions of the
  historical records; conclusions and data unchanged.
- `metadata/` — `zenodo.json` (deposit metadata), this README.

## Version pins

- Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0 (rev
  `5ed29652`, see `proofs/lean-toolchain`). No other dependencies.

## Reproduction

Kernel-side verification of the proofs requires a Lean 4 + mathlib checkout
at the pinned versions:

```
# strict-mode compile (terminal criterion: exit 0 and no sorry/admit anywhere)
lake env lean proofs/final-nfact-primorial-square.lean

# axiom audit: append the eight `#print axioms NFactPrimorialSquare.<name>`
# lines (names in the frozen snapshot in proofs/) to a verbatim copy of the
# final file, re-run; expect every entry to be
# [propext, Classical.choice, Quot.sound]
```

The packaging track ran exactly this check on 2026-10-06 (probe = verbatim
copy of the final file plus the eight print lines; the prefix hash was
recomputed and matched); the verbatim printout is `audit/axioms.out`, and the
strict compile of the probe exited 0 with three non-rejectable
linter/deprecation warnings (recorded in the paper's verification section).
The same checks were re-run after the 2026-10-07 comment cleanup
(`audit/kernel-rerun.txt`).

Paper: compile `paper/paper.tex` with a Unicode-capable engine (XeLaTeX; the
paper ships its rendering patch at the top of the file). `paper/paper.pdf` is
the reference rendering.

## What this artifact proves

Kernel layer: the eight frozen statements — the complete solution set of
`x^2 = n! * n#` in two forms (iff form: `n! * n#` is a square iff `n <= 5`;
existence-witness form: solvable iff `n in {0,...,5}`), the valuation
criterion, the interval-prime lemma (for `n >= 22` a prime in `(n/3, n/2]`),
the six solution witnesses, and three auxiliary factorization statements —
all with no `sorry` and with `#print axioms` inside the whitelist {propext,
Quot.sound, Classical.choice}. Nothing else is claimed at theorem level: the
companion equation `x^2 = n!! * [1,...,n]` is explicitly not claimed, and no
OEIS registration is claimed or performed.

Novelty boundary, as the review states it: an exclusivity review found no
occupying record on the channels queried (closing dates 2026-10-05 deep-dig
layer, 2026-10-06 independent review layer); the problem is on record as open
in the source paper (author's self-report, quoted verbatim in the paper). No
"first formalization" statement is made. The full query log ships as
`audit/c9-record.md` (English cleaned edition; conclusions and query data
unedited).

## Companion deposit

The same kernel result is deposited as a priority claim of record; concept
DOI `10.5281/zenodo.23177003` (published 2026-10-06; v1.0.0 =
`10.5281/zenodo.23177004`, v1.0.1 = `10.5281/zenodo.23177585`). The paper
cites the claim deposit; the two packages share the proof sources
byte-for-byte at the code level and differ in genre.

## DOI

- Concept DOI (always resolves to the latest version):
  `10.5281/zenodo.23179325`.
- v1.0.0 (2026-10-06): `10.5281/zenodo.23179326` — first publication.
- v1.1.0 (content dated 2026-10-07; published 2026-10-12 as
  `10.5281/zenodo.23310695`): disclosure section minimized to the fixed
  three-sentence form; comments/docstrings in the Lean sources cleaned to
  English; audit documents cleaned to English editions; code regions and all
  conclusions unchanged (see `audit/comment-cleanup-diff.md`).

## Status

The arXiv submission is not part of this package and remains the author's own
manual step (endorsement lane pending); this package's `zenodo.json`
therefore carries no arXiv related-identifier. The upload checklist lives in
the source repository and is not shipped.

## Contact

Author: Aurora0134 (account name; contact via the GitHub account Aurora0134).
AI is not an author; the human author reviewed and is responsible for all
content.

## Package facts (generated blocks; values measured at packaging time)

The compiled page count of `paper/paper.pdf`:

<!-- FACTS-BEGIN fact name=pages src=paper/paper.pdf -->
@value 28
<!-- FACTS-END -->

Package structure (per-file byte counts measured, paths relative to the
deposit root):

<!-- FACTS-BEGIN inv scope=deposit -->
@row      935  audit/axioms.out
@row     3306  audit/bib-verify.md
@row     7320  audit/c9-record.md
@row     2050  audit/comment-cleanup-diff.md
@row    21724  audit/compile-run.log
@row     7120  audit/faithful.md
@row    18544  audit/gate3-final-adjudication.txt
@row     2928  audit/kernel-rerun.txt
@row      726  audit/lean-idents.txt
@row       66  audit/lint.txt
@row      465  audit/listing-verify.txt
@row     5751  audit/package-notes.md
@row     7738  audit/paper-check.md
@row      180  audit/welldef-nfact-primorial-square.txt
@row     6912  metadata/README.md
@row     2474  metadata/zenodo.json
@row     7557  paper/lstlean.tex
@row   225277  paper/paper.pdf
@row    71208  paper/paper.tex
@row    62026  proofs/final-nfact-primorial-square.lean
@row       25  proofs/lean-toolchain
@row     4131  proofs/nfact-primorial-square.lean
@row     4630  proofs/nfact-primorial-square.statement.txt
<!-- FACTS-END -->
