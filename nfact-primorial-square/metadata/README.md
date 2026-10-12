# nfact-primorial-square — priority claim artifact package

Note under CC BY 4.0, code under MIT.

## Contents

- `claim/` — `claim.tex`, `claim.pdf`, `lstlean.tex` (the claim note; its
  Lean listings are byte-identical splices of the shipped proof files, see
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
  search, full query log), `claim-check.md` (the claim audit); this package's
  `lint.txt` / `compile-run.log` / `listing-verify.txt`;
  `comment-cleanup-diff.md`; `kernel-rerun.txt` (post-cleanup kernel
  re-verification); `package-notes.md`. Audit documents are English cleaned
  editions of the historical records; conclusions and data unchanged.
- `metadata/` — `zenodo.json` (deposit metadata), `FILE-MANIFEST.txt`
  (per-file byte inventory, recomputed before upload), this README.

## Version pins

- Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0 (rev `5ed29652`).
- No other dependencies.

## Reproduction

Kernel-side verification of the proofs requires a Lean 4 + mathlib checkout
at the pinned versions. The exact reproduction command list is in
`audit/gate3-final-adjudication.txt` (sections R0–R4). Axiom outputs are
reproduced verbatim in `audit/axioms.out`: every entry is exactly
`[propext, Classical.choice, Quot.sound]` — the whitelist, no `sorryAx`.

The note PDF rebuild: `tectonic claim.tex` (or `latexmk -xelatex`) inside
`claim/`; `lstlean.tex` is included there.

## DOI

- Concept DOI (always resolves to the latest version):
  `10.5281/zenodo.23177003`.
- v1.0.0 (2026-10-06): `10.5281/zenodo.23177004` — first publication.
- v1.0.1 (2026-10-06): `10.5281/zenodo.23177585` — corrected only this
  README's DOI/publication-status wording; the note, proofs, and audit
  evidence were byte-identical to v1.0.0.
- v1.0.2 (content dated 2026-10-07; published 2026-10-12 as
  `10.5281/zenodo.23310591`): disclosure section minimized to the fixed
  three-sentence form; comments/docstrings in the Lean sources cleaned to
  English; audit documents cleaned to English editions; code regions and all
  conclusions unchanged (see `audit/comment-cleanup-diff.md`).

## Package facts (generated blocks; values measured at packaging time)

The compiled page count of `claim/claim.pdf`:

<!-- FACTS-BEGIN fact name=pages src=claim/claim.pdf -->
@value 23
<!-- FACTS-END -->

It exceeds the claim-note caliber of a short note; the excess is verbatim
snapshot/listing excerpts and the novelty-search table, kept deliberately.

Package structure (per-file byte counts measured, paths relative to the
deposit root):

<!-- FACTS-BEGIN inv scope=deposit -->
@row      935  audit/axioms.out
@row     2064  audit/bib-verify.md
@row     7320  audit/c9-record.md
@row     5925  audit/claim-check.md
@row     2021  audit/comment-cleanup-diff.md
@row    17409  audit/compile-run.log
@row     7120  audit/faithful.md
@row    18544  audit/gate3-final-adjudication.txt
@row     2928  audit/kernel-rerun.txt
@row       66  audit/lint.txt
@row      367  audit/listing-verify.txt
@row     5419  audit/package-notes.md
@row      180  audit/welldef-nfact-primorial-square.txt
@row   194719  claim/claim.pdf
@row    56772  claim/claim.tex
@row     7557  claim/lstlean.tex
@row     1192  metadata/FILE-MANIFEST.txt
@row     4560  metadata/README.md
@row     2169  metadata/zenodo.json
@row    62026  proofs/final-nfact-primorial-square.lean
@row       25  proofs/lean-toolchain
@row     4131  proofs/nfact-primorial-square.lean
@row     4630  proofs/nfact-primorial-square.statement.txt
<!-- FACTS-END -->
