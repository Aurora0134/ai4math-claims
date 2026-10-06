# nfact-primorial-square — paper source and artifact package (SOP 08 paper lane)

- **Type**: arXiv-level paper source plus the deposited artifact (SOP 08 paper lane).
- **Author**: Aurora0134 (account name, not PII; no real name, no ORCID value, no email).
- **Licence**: paper under CC BY 4.0, code under MIT (the single `license` field of
  `zenodo.json` is MIT; CC BY 4.0 is added through the UI multi-licence control before
  Publish).
- **arXiv**: NOT in this batch. The arXiv submission is the author's own manual step
  (endorsement lane pending; see `UPLOAD.md` in the source repository, not shipped).
  This package's `zenodo.json` therefore carries no arXiv related-identifier.
- **Companion claim of record**: the same kernel result is deposited by the pipeline's
  claim lane; concept DOI `10.5281/zenodo.23177003` (published 2026-10-06; version
  v1.0.1 = `10.5281/zenodo.23177585`, first version v1.0.0 = `10.5281/zenodo.23177004`).
  The paper cites the claim deposit; the two packages share the proof sources
  byte-for-byte and differ in genre.
- **DOI**: `10.5281/zenodo.23179326` — prereserved and **published on 2026-10-06** via
  the pipeline's mechanical prepare step (`python scripts/zenodo-deposit.py prepare
  papers/nfact-primorial-square`) followed by the API publish call, under the batch's
  per-package user authorization (batch card
  `tasks/20261006-paper-nfact-primorial/card.md`, rule-override record O-1, this paper
  only; the standing default "publish is the human's own UI step" was overridden for
  this package only).
- **Version pin**: Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0
  (revision `5ed29652`, see `proofs/lean-toolchain`), tectonic 0.17.0 (local build).
- **Page count**: see the generated block below — measured from the shipped PDF and
  re-measured by the mechanical reconciliation gate before every packaging run. This
  file must not restate a page count, a warning count or any fact-type figure in prose
  outside a generated block.

## Generated blocks (machine-rendered; do not hand-edit)

The figures below are rendered by `scripts/sanitize-package.py --emit-facts` from the
measured files; the reconciliation gate re-measures and compares them item by item
before a package may leave the lane.

- Page count of `paper/paper.pdf` in this package (counted by the number of `/Type
  /Page` objects; cross-checked against the `Output written on ...` line of the compile
  log at the deliverable root, which is not shipped; a mismatch is reported as
  *unmeasurable* rather than passed):

<!-- FACTS-BEGIN fact name=pages src=paper/paper.pdf -->
@value 29
<!-- FACTS-END -->

## Package structure (generated block: per-file byte counts, paths relative to `zenodo/`)

<!-- FACTS-BEGIN inv scope=deposit -->
@row      935  audit/axioms.out
@row     2826  audit/bib-verify.md
@row     6263  audit/c9-record.md
@row    22799  audit/compile-run.log
@row     6329  audit/faithful.md
@row    17566  audit/gate3-final-adjudication.txt
@row      726  audit/lean-idents.txt
@row       66  audit/lint.txt
@row      465  audit/listing-verify.txt
@row     5818  audit/package-notes.md
@row     4560  audit/paper-check.md
@row      180  audit/welldef-nfact-primorial-square.txt
@row     8867  metadata/README.md
@row     2541  metadata/zenodo.json
@row     7569  paper/lstlean.tex
@row   259590  paper/paper.pdf
@row    74307  paper/paper.tex
@row    62242  proofs/final-nfact-primorial-square.lean
@row       25  proofs/lean-toolchain
@row     4522  proofs/nfact-primorial-square.lean
@row     4747  proofs/nfact-primorial-square.statement.txt
<!-- FACTS-END -->

## Reproduction

With the pin above, from a checkout of the source repository (the scripts named below
live in the source repository and are not shipped; this package is self-contained as a
deposit, and reproduction happens in the source repository or an equivalent project):

```
# strict-mode compile (terminal criterion: exit 0 and no sorry/admit anywhere)
scripts/lean-verify proofs/final-nfact-primorial-square.lean

# axiom audit: append the eight `#print axioms NFactPrimorialSquare.<name>` lines
# (names in the frozen snapshot in proofs/) to a verbatim copy of the final file,
# re-run; expect every entry to be [propext, Classical.choice, Quot.sound]
```

The packaging track re-ran exactly this check on 2026-10-06 (probe = verbatim copy of
the final file plus the eight print lines; the prefix hash was recomputed and matched);
the verbatim printout is `audit/axioms.out`, and the strict compile of the probe exited
0 with three non-rejectable linter/deprecation warnings (recorded in the paper's
verification section).

Paper: compile `paper/paper.tex` with a Unicode-capable engine (XeLaTeX; the paper
ships its rendering patch at the top of the file). `paper/paper.pdf` is the reference
rendering produced in the pipeline.

## What this artifact proves

Kernel layer: the eight frozen statements of the source task — the complete solution
set of `x^2 = n! * n#` in two forms (iff form: `n! * n#` is a square iff `n <= 5`;
existence-witness form: solvable iff `n in {0,...,5}`), the valuation criterion, the
interval-prime lemma (for `n >= 22` a prime in `(n/3, n/2]`), the six solution
witnesses, and three auxiliary factorization statements — all with no `sorry` and with
`#print axioms` inside the whitelist {propext, Quot.sound, Classical.choice}. Nothing
else is claimed at theorem level: the companion equation `x^2 = n!! * [1,...,n]` is
explicitly not claimed, and no OEIS registration is claimed or performed.

Novelty boundary, as the review states it: the pipeline's exclusivity review (C9
discipline) found no occupying record on the channels queried (closing dates
2026-10-05 deep-dig layer, 2026-10-06 independent review layer); the problem is on
record as open in the source paper (author's self-report, quoted verbatim in the
paper). No "first formalization" statement is made. The full query log ships verbatim
as `audit/c9-record.md`.

## Audit evidence in this package

- `audit/gate3-final-adjudication.txt` — the source task's terminal adjudication
  (statement comparison under two whitespace conventions, strict compile, placeholder
  scan, axiom audit; grading: complete proof). Machine-local path prefixes are replaced
  by `<AI4MATH-REPO-ROOT>`; the verdict text is unchanged (disclosed in
  `audit/package-notes.md`).
- `audit/welldef-nfact-primorial-square.txt` — the well-definedness gate output,
  verbatim (WELLDEF OK; the degeneracy probes all fail).
- `audit/axioms.out` — the packaging track's own re-run of the axiom printout,
  verbatim (the wrapped entry is terminal formatting).
- `audit/listing-verify.txt` — per-listing byte comparison of the paper's code blocks
  against the frozen sources (independent checker, own range table).
- `audit/lean-idents.txt` — every `\lean{}` identifier named in the paper, checked
  present in the final proof file.
- `audit/bib-verify.md` — the live read-back record for every bibliography entry.
- `audit/c9-record.md` — the full exclusivity-review record, a verbatim splice from its
  sources (Chinese, conclusions unedited).
- `audit/faithful.md` — the semantic round-trip fidelity record of the formalization
  stage, verbatim copy.
- `audit/lint.txt` / `audit/compile-run.log` — the static gate output (exit 0) and the
  hard-compile console output (exit 0).
- `audit/package-notes.md` — the package's own self-description: what is here, and what
  is deliberately not.
- `audit/paper-check.md` — the claim audit of this package, run by the read-only audit
  department; added to the deposit tree after its adjudication (a packaging prerequisite).

## Status

Gate four (report sign-off) and gate five (paper sign-off) were exercised by the
author's instruction of 2026-10-06 to run the paper lane and the claim lane for this
result. The Zenodo publish of this package is executed by the pipeline's orchestrating
agent under that instruction's per-package authorization (batch card rule-override
record O-1, this paper only); the arXiv submission remains the author's own manual step
and is not part of this batch. See `UPLOAD.md` in the source repository (not shipped).

## DOI

- **Published**: `10.5281/zenodo.23179326` — prereserved by `scripts/zenodo-deposit.py prepare` and **published via the API on 2026-10-06**, under the batch's per-package user authorization (batch card `tasks/20261006-paper-nfact-primorial/card.md`, rule-override record O-1, this paper only). This tail section is the post-publish backfill annotation; the deposited copy of this README carries the at-publish snapshot (its DOI section above names the same DOI).
- Backfill after publish: this file + `papers/nfact-primorial-square/card.md` + `run-state.md` (the latter two live in the source repository, not shipped in this package).
