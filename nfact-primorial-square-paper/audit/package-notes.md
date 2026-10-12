# Package self-description: what this package contains (and deliberately omits)

This note is written before packaging (not as an afterthought).

## What this package is

Artifact package accompanying the paper "The Diophantine equation
x^2 = n! * n#: the complete solution set, formalized and machine-checked in
Lean 4" — the complete solution set of `x^2 = n! * n#` (factorial times
primorial) over the naturals: exactly `n ∈ {0,1,2,3,4,5}` (with
`x = 1,1,2,6,12,60`), grading = complete proof. Contents: the paper (LaTeX
source + PDF), the Lean 4 proof sources (statement source + frozen statement
snapshot + final development + toolchain pin), and the verification evidence
(final adjudication, well-definedness gate output, axiom printout, listing
and named-identifier verification, bibliography verification, compile and
static-gate logs, roundtrip fidelity record, novelty-search record). A
companion claim of record for the same kernel result is deposited separately
(concept DOI 10.5281/zenodo.23177003).

## Package structure (generated block: per-file byte counts measured, paths relative to `zenodo/`)

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

## Deliberate omissions

- No internal repository working files (task cards, internal reports, process
  files): the package is self-contained.
- Raw retrieval captures (JSON / XML / HTML page snapshots) of the novelty
  search: bulky and largely third-party pages; the conclusions and the query
  strings are in `audit/c9-record.md` in full.
- The ecosystem mirror (the formal-conjectures tarball and its extraction):
  deleted after the search batch; the hit conclusions are in the record.
- Intermediate proof-search artifacts (per-stage proof files, prompts,
  diagnostics, handoff reports): process material of the source task; the
  refuted-route fact is disclosed in the paper's "A refuted route" section,
  nothing is hidden.
- The component-level files of the proof (Lemma A / witness layer / Lemma B
  chain and tail as separate developments): the final file is self-contained
  (imports only Mathlib) and subsumes all load-bearing content.
- Build-system files (lakefile, manifest, etc.): the package carries only
  `proofs/lean-toolchain` (the version pin), no build scripts.
- The gate probe files and scratch directories: the axiom probe was a
  verbatim copy of the final file plus a tail of `#print axioms` lines; the
  final file itself ships, the probe construction is in the adjudication's
  reproduction command list, and the load-bearing output (the eight
  depends-on-axioms lines) is verbatim in `audit/axioms.out`.
- The assembly tooling of the deliverable directory (the build/verify scripts
  and the skeleton): deliverable-directory working files, not part of the
  deposit; their verification outputs (listing-verify / lean-idents / lint /
  compile records) ship.
- The upload checklist (`UPLOAD.md`): an operations file for the author; it
  lives in the source repository and is not shipped.

## Mechanical processing of the shipped copies (disclosed item by item; no adjudication content altered)

| processing | files | content |
|---|---|---|
| path normalization | `audit/gate3-final-adjudication.txt` | machine-local path prefixes replaced by `<REPO-ROOT>`, dated task paths by `<source-task-id>`; verdict text and data unchanged |
| comment-layer cleanup (2026-10-07) | `proofs/final-nfact-primorial-square.lean`, `proofs/nfact-primorial-square.lean`, `proofs/nfact-primorial-square.statement.txt` | comments and docstrings translated to English for publication; code regions byte-identical to the frozen development (record: `audit/comment-cleanup-diff.md`) |
| English cleaned editions (2026-10-07) | `audit/c9-record.md`, `audit/faithful.md`, `audit/bib-verify.md`, `audit/paper-check.md`, `audit/gate3-final-adjudication.txt` | translated to English, internal references generalized; conclusions and data unchanged (each file carries a version note) |

The original files stay unmodified in the source repository; the package
contains copies.

## Pages and rendering

- The compiled page count is given by the generated block in
  `metadata/README.md` (measured from the shipped PDF; this file does not
  restate it).
- Rendering: the compile log's `Missing character` count is zero; the
  `Overfull \hbox` count is zero; unresolved `??` references are zero.

## External boundary

This package is upload-ready: the static gate and the hard compile were run,
and the repository's mechanical reconciliation gate is green at packaging
time. The claim audit (`audit/paper-check.md`) was added to the deposit after
its adjudication returned. The first version of this deposit was published on
2026-10-06 (DOI 10.5281/zenodo.23179326); publishing an updated version
(Zenodo UI New version → Publish) is the author's own action.
