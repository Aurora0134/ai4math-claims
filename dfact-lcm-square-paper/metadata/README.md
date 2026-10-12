# dfact-lcm-square — paper and artifact package

Paper under CC BY 4.0, code under MIT (the single `license` field of
`zenodo.json` is MIT; CC BY 4.0 is added through the Zenodo UI multi-licence
control).

## Contents

- `paper/` — `paper.tex`, `paper.pdf`, `lstlean.tex` (the paper; its Lean
  listings are byte-identical splices of the shipped proof files, see
  `audit/listing-verify.txt`; compiles with tectonic/XeLaTeX).
- `proofs/` — `dfact-lcm-square.statement.lean` (the frozen statement source;
  proof bodies are `sorry` placeholders by design, this file is the statement
  scaffold), `final-dfact-lcm-square.lean` (the final development, no
  placeholder; its size is given by the inventory block below), `lean-toolchain`
  (`leanprover/lean4:v4.34.0`). Comments were cleaned for publication: every
  comment span that carried pre-publication workflow narrative was blanked with
  line numbers preserved, and code bytes were never touched. Per file, the
  comment-free code view of the source and of the shipped copy are byte-for-byte
  equal (record: `audit/comment-elision-record.md`), so the statements and proof
  terms are exactly the frozen artifacts.
- `audit/` — verification evidence: `independent-verdict.txt` (the independent
  final audit's verdict: complete proof, with its signing qualifications
  attached),
  `strict-compile.txt` (strict-mode compilation log of the final file),
  `axioms.out` (the `#print axioms` outputs, twelve theorems, all on the
  whitelist), `statement-faithful.md` (the informal-to-formal correspondence
  table), `clean-copy-reverify.md` (re-verification of the shipped copies after
  comment cleaning: strict compile and axiom probe), `bib-verify.md`
  (bibliography existence checks), `novelty-record.md` (novelty search, full query
  log), `listing-verify.txt` (listing-to-source byte correspondence),
  `lean-idents.txt` (every named identifier used in the paper traced to the
  final file), `closure-manifest.txt` (the two library modules the final
  development imports, measured but not shipped — see "What this artifact
  proves" and the Limitations), `comment-elision-record.md`, `paper-check.md`
  (the claims audit of the paper text, with its two rounds), and this
  package's `lint.txt` / `compile-run.log` / `package-notes.md`. Audit
  documents are English cleaned editions of the historical records;
  conclusions and data unchanged.
- `metadata/` — `zenodo.json` (deposit metadata), this README.

## Version pins

- Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0 (rev
  `5ed29652`). No other dependencies.

## Reproduction

Kernel-side verification requires a Lean 4 + mathlib checkout at the pinned
versions, **plus** the two accompanying library modules named in
`audit/closure-manifest.txt` (they are imports of the final file and are not
part of this deposit). With those in place, the final file is compiled in
strict mode (errors rejected, plus a textual scan for `sorry`/`admit`); it
exits 0 with a single style-level deprecation warning. `#print axioms` on each
of the twelve theorems returns `[propext, Classical.choice, Quot.sound]`.

Paper: compile `paper/paper.tex` with a Unicode-capable engine (XeLaTeX; the
paper ships its rendering patch at the top of the file). `paper/paper.pdf` is
the reference rendering.

## What this artifact proves

Kernel layer: the three frozen statements — the complete solution set of
`x^2 = n!! * lcm(1..n)` in two forms (iff form: the product is a square iff
`n ∈ {0,1,2,5,7}`; existence-witness form: the equation is solvable iff the
same), and the valuation criterion they are built on — plus the five solution
witnesses, the six explicit non-square witnesses, the even exclusion arm
(Bertrand's postulate), the odd exclusion arm, and the interval-prime lemma for
`n ≥ 33` (a prime in `(n/4, n/3]`). All with no `sorry` and with `#print
axioms` inside the whitelist {propext, Quot.sound, Classical.choice}. Nothing
else is claimed at theorem level: the companion equation `x^2 = n! * n#` is
explicitly not claimed (it is settled in a separate deposit, cited in the
paper), and no OEIS registration is claimed or performed.

Dependency boundary: the final development imports two modules from an
accompanying library — the interval-prime lemma for `n ≥ 33`, and one bridge
used by the witness layer. Neither module ships in this deposit; their
identity (bytes, lines, sha256) and the declaration consumed from each is
recorded in `audit/closure-manifest.txt`, and the paper's Limitations state
the boundary. Re-verifying the odd arm from this deposit alone therefore
requires that library as well.

Novelty boundary, as the review states it: an exclusivity review found no
occupying record on the channels queried (closing dates 2026-10-06 deep-dig
layer and independent review layer); the problem is on record as open in the
source paper (author's self-report, quoted verbatim in the paper). No "first
formalization" statement is made. The full query log ships as
`audit/novelty-record.md` (English cleaned edition; conclusions and query data
unedited).

## Companion deposit

The same kernel result is deposited as a priority claim of record. The paper
cites that deposit; the DOI is reserved for it at upload time (the paper's Data
availability section carries the agreed placeholder until then), and the two
deposits are cross-linked through the Zenodo UI at upload time. The two
packages share the proof sources byte-for-byte at the code level and differ in
genre.

## Status

The arXiv submission is not part of this package and remains the author's own
manual step (endorsement lane pending); this package's `zenodo.json` therefore
carries no arXiv related-identifier. The upload checklist lives in the source
repository and is not shipped.

## Contact

Author: Aurora0134 (account name; contact via the GitHub account Aurora0134).
AI is not an author; the human author reviewed and is responsible for all
content.

## Package facts (generated blocks; values measured at packaging time)

The compiled page count of `paper/paper.pdf`:

<!-- FACTS-BEGIN fact name=pages src=paper/paper.pdf -->
@value 15
<!-- FACTS-END -->

Package structure (per-file byte counts measured, paths relative to the
deposit root):

<!-- FACTS-BEGIN inv scope=deposit -->
@row     1523  audit/axioms.out
@row     1914  audit/bib-verify.md
@row     2225  audit/clean-copy-reverify.md
@row     1097  audit/closure-manifest.txt
@row     1419  audit/comment-elision-record.md
@row     1460  audit/compile-run.log
@row    12934  audit/independent-verdict.txt
@row      615  audit/lean-idents.txt
@row     2090  audit/lint.txt
@row      561  audit/listing-verify.txt
@row    13026  audit/novelty-record.md
@row     5238  audit/package-notes.md
@row     7966  audit/paper-check.md
@row     4872  audit/statement-faithful.md
@row      364  audit/strict-compile.txt
@row     7596  metadata/README.md
@row     3054  metadata/zenodo.json
@row     7624  paper/lstlean.tex
@row   130690  paper/paper.pdf
@row    37960  paper/paper.tex
@row     2364  proofs/dfact-lcm-square.statement.lean
@row    17380  proofs/final-dfact-lcm-square.lean
@row       25  proofs/lean-toolchain
<!-- FACTS-END -->

## DOI

- **Concept DOI (citation entry)**: `10.5281/zenodo.23309983`; version DOI: v1.0.0 = `10.5281/zenodo.23309984`.
- Published 2026-10-12 by the author's authorized publication round (user instruction on record in the source repository's task archive; the pipeline tooling itself has no publish code path). Companion claim deposit: concept DOI `10.5281/zenodo.23309732`.
