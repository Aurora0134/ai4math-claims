# Package self-description: what this package contains (and deliberately omits)

This note is written before packaging (not as an afterthought).

## What this package is

Priority claim of record for the complete solution set of the Diophantine
equation `x^2 = n!! * lcm(1..n)` (double factorial times least common multiple):
for natural `n` the product is a perfect square exactly for
`n ∈ {0,1,2,5,7}` (with square roots `x = 1,1,2,30,210`), grading = complete
proof. Contents: the claim note (LaTeX source + PDF), the Lean 4 proof sources
(frozen statement source + final development + toolchain pin), and the
verification evidence (independent final audit verdict, strict compile log,
axiom printouts, statement correspondence table, clean-copy reverification,
bibliography checks, listing verification, novelty search record).

## Package structure (generated block: per-file byte counts measured, paths relative to `zenodo/`)

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

## Deliberate omissions

- The two imported library modules (the interval-prime lemma used by the odd
  arm, and one bridge used by the witness layer). The final development imports
  them; neither ships here, because each is a separate development of the same
  grade with its own final state. Their measured identity and the declaration
  consumed from each ship as `audit/closure-manifest.txt`, and the deposit's
  Reproduction section states that a kernel compile of the shipped final file
  needs those modules beside it.
- No internal repository working files (task cards, internal reports, process
  files): the package is self-contained.
- Raw retrieval captures (JSON / XML / HTML page snapshots) of the novelty
  search: bulky and largely third-party pages; the conclusions and the query
  strings are in `audit/novelty-record.md` in full, and the Chinese-language query
  string is given there as its UTF-16 code units so the data stays recoverable.
- The ecosystem mirror used for the public-ecosystem layer: the hit
  conclusions are in the record.
- Intermediate proof-search artifacts (per-stage proof files, prompts,
  diagnostics, handoff reports): process material of the source task.
- The axiom probe file, the statement symmetric-difference comparison script,
  the two solution-set perturbation probe files, and the independent numerical
  recomputation script: all stay in the source repository. Their load-bearing
  outputs are quoted verbatim in `audit/independent-verdict.txt`, which states
  for each which files ship and which do not.
- Build-system files (lakefile, manifest, etc.): the package carries only
  `proofs/lean-toolchain` (the version pin), no build scripts.
- The packaging track's tooling (the clean-copy generator, the listing
  verifier, the path normalizer): deliverable-directory working files, not part
  of the deposit; their outputs (`comment-elision-record.md`,
  `listing-verify.txt`, the normalized evidence files) ship.

## Mechanical processing of the shipped copies (disclosed item by item; no adjudication content altered)

| processing | files | content |
|---|---|---|
| comment blanking (2026-10-07) | `proofs/dfact-lcm-square.statement.lean`, `proofs/final-dfact-lcm-square.lean` | every comment span carrying Chinese text or pre-publication workflow narrative was blanked with line numbers preserved; code bytes never touched. Per file, the comment-free code view of the source and of the copy are byte-for-byte equal (record: `audit/comment-elision-record.md`), so the statements and proof terms are exactly the frozen artifacts |
| path normalization (2026-10-07) | `audit/strict-compile.txt`, `audit/axioms.out`, `audit/independent-verdict.txt` | machine-local path prefixes replaced by `<source-task>/`; exit codes, error locations, byte counts, sha256 values and axiom sets unchanged |
| English cleaned editions (2026-10-07) | `audit/independent-verdict.txt`, `audit/statement-faithful.md`, `audit/novelty-record.md`, `audit/clean-copy-reverify.md`, `audit/bib-verify.md`, `audit/comment-elision-record.md` | translated to English, internal references generalized; conclusions and data unchanged (each file carries a version note where applicable) |
| listing-glyph mapping (2026-10-07) | `claim/lstlean.tex` | one entry added to the `literate` table, mapping the double-factorial sign to the two ASCII characters `!!`. Rendering only; the shipped Lean sources are unchanged |

The original files stay unmodified in the source repository; the package
contains copies.

## Pages and rendering

- The compiled page count is given by the generated block in
  `metadata/README.md` (measured from the shipped PDF; this file does not
  restate it). The note is a claim of record rather than a survey paper, and
  its length comes from the verbatim statement listing, the proof excerpt and
  the novelty-evidence itemization, all kept deliberately.
- Rendering: the compile log's `Missing character` count is zero.

## External boundary

This package is upload-ready: the static gate and the hard compile were run,
and the repository's mechanical reconciliation gate is green at packaging time.
Publication itself (Zenodo publish, mirror push) is the author's own action --
no step in this package's `UPLOAD.md` was executed on the author's behalf.
