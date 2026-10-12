# dfact-lcm-square — priority claim artifact package

Note under CC BY 4.0, code under MIT.

## Contents

- `claim/` — `claim.tex`, `claim.pdf`, `lstlean.tex` (the claim note; its
  Lean listings are verbatim splices of the shipped proof files, see
  `audit/listing-verify.txt`; compiles with tectonic/XeLaTeX). `lstlean.tex`
  carries one added entry in its `literate` table, mapping the double-factorial
  sign to the two ASCII characters `!!`; the shipped Lean sources are
  unchanged.
- `proofs/` — `dfact-lcm-square.statement.lean` (the frozen statement source;
  proof bodies are `sorry` placeholders by design, this file is the statement
  scaffold), `final-dfact-lcm-square.lean` (the final development, 0 sorry,
  12 theorems; its size is given by the inventory block below), `lean-toolchain`
  (`leanprover/lean4:v4.34.0`). Comments were cleaned for publication: every
  comment span that carried pre-publication workflow narrative was blanked with
  line numbers preserved, and code bytes were never touched. Per file, the
  comment-free code view of the source and of the shipped copy are byte-for-byte
  equal (record: `audit/comment-elision-record.md`), so the statements and proof
  terms are exactly the frozen artifacts.
- `audit/` — verification evidence: `independent-verdict.txt` (the independent
  final audit's verdict: complete proof, with its nine signing qualifications),
  `strict-compile.txt` (strict-mode compilation log of the final file),
  `axioms.out` (the `#print axioms` outputs, twelve theorems, all on the
  whitelist), `statement-faithful.md` (the informal-to-formal correspondence
  table), `clean-copy-reverify.md` (re-verification of the shipped copies after
  comment cleaning: strict compile and axiom probe), `bib-verify.md`
  (bibliography existence checks), `novelty-record.md` (novelty search, full query
  log), `listing-verify.txt` (listing-to-source correspondence),
  `closure-manifest.txt` (the two library modules the final development
  imports, measured but not shipped — see Version pins), and this package's
  `lint.txt` / `compile-run.log`. Audit documents are English cleaned editions
  of the historical records; conclusions and data unchanged.
- `metadata/` — `zenodo.json` (deposit metadata), this README.

## Version pins

- Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0 (rev `5ed29652`).
- The final development imports `Mathlib` and two library modules that are
  **not** part of this deposit (`Library.NFactPrimorialSquare`,
  `Library.IntervalPrimeQuarter`); the interval-prime lemma used by the odd arm
  is proved in those modules as a finite certificate chain plus a tail
  estimate, not taken from a published interval theorem. Their measured
  identity and the declaration consumed from each ship as
  `audit/closure-manifest.txt`.

## Reproduction

Kernel-side verification requires a Lean 4 + mathlib checkout at the pinned
versions **plus** the two library modules named in `audit/closure-manifest.txt`
(they are imports of the final file and are not part of this deposit). With
those in place, the final file is compiled in strict mode (errors rejected, plus a
textual scan for `sorry`/`admit`); it exits 0 with a single style-level
deprecation warning. `#print axioms` on each of the twelve theorems returns
`[propext, Classical.choice, Quot.sound]`.

## Compiled note

<!-- FACTS-BEGIN fact name=pages src=claim/claim.pdf -->
@value 7
<!-- FACTS-END -->

## Deposit inventory

<!-- FACTS-BEGIN inv scope=deposit -->
@row     1523  audit/axioms.out
@row     1914  audit/bib-verify.md
@row     8476  audit/claim-check.md
@row     2225  audit/clean-copy-reverify.md
@row     1097  audit/closure-manifest.txt
@row     1419  audit/comment-elision-record.md
@row     1361  audit/compile-run.log
@row    12934  audit/independent-verdict.txt
@row     2090  audit/lint.txt
@row      237  audit/listing-verify.txt
@row    13026  audit/novelty-record.md
@row     6200  audit/package-notes.md
@row     4872  audit/statement-faithful.md
@row      364  audit/strict-compile.txt
@row    85315  claim/claim.pdf
@row    15228  claim/claim.tex
@row     7624  claim/lstlean.tex
@row     1175  metadata/FILE-MANIFEST.txt
@row     4747  metadata/README.md
@row     2309  metadata/zenodo.json
@row     2364  proofs/dfact-lcm-square.statement.lean
@row    17380  proofs/final-dfact-lcm-square.lean
@row       25  proofs/lean-toolchain
<!-- FACTS-END -->

## DOI

- **Concept DOI (citation entry)**: `10.5281/zenodo.23309732`; version DOI: v1.0.0 = `10.5281/zenodo.23309733`.
- Published 2026-10-12 by the author's authorized publication round (user instruction on record in the source repository's task archive; the pipeline tooling itself has no publish code path).
