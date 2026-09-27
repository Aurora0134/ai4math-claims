# edgemid-monomer-dimer — priority claim artifact package (SOP 08b)

AI-generated 2026-09-27 by the AI4Math paper department (claim lane); human-audited.
Note under CC BY 4.0, code under MIT.

## Contents

- `claim/` — `claim.tex`, `claim.pdf`, `lstlean.tex` (the claim note; listings are
  byte-exact mechanical splices of the frozen Lean artifacts, see
  `audit/listing-verify.txt`; the note compiles with tectonic/XeLaTeX,
  xeCJK + SimSun for the frozen Chinese docstrings).
- `proofs/` — `edgemid-p1-statement.lean`, `edgemid-p2-statement.lean`
  (frozen statements, sha256 `f964ce71...27b27c56` / `cf9e379a...99b6d5`),
  `03-proof-complete.lean` (final development, 66 lines, 0 sorry,
  sha256 `1124e6a5...72c1d`), `lean-toolchain` (`leanprover/lean4:v4.34.0`).
- `audit/` — gate evidence: `final-audit.md` (symmetric difference zero,
  grading = complete proof), `final-axioms-p1.txt` / `final-axioms-p2.txt`
  (`#print axioms` outputs), `welldef-p1.txt` / `welldef-p2.txt`
  (well-definedness gates, 7/7 bare-tactic probes FAIL = non-degenerate),
  `evidence-pack.md`, `roundtrip.md` (faithfulness record); this package's
  `lint.txt` / `compile.txt` / `listing-verify.txt`; and `c9-record.md`
  (novelty-review full query log, copied verbatim from the source record).
- `metadata/` — `zenodo.json` (deposit metadata), this README.

## Version pins

- Lean v4.34.0 (`leanprover/lean4:v4.34.0`), mathlib4 v4.34.0 (rev `5ed29652`).
- No other dependencies.

## Reproduction

Kernel-side verification of the proofs requires the pipeline repository
(verify-proj with the pinned mathlib cache; scripts `lean-verify` /
`gate-batch`). Pointers and the exact reproduction command list are in
`audit/final-audit.md` (section「复现命令清单」). Axiom outputs are
reproduced verbatim in `audit/final-axioms-p1.txt` / `final-axioms-p2.txt`:
`edgemid_master [propext, Quot.sound]`,
`edgemid_matrix_family [propext, Classical.choice, Quot.sound]`
— both subsets of the whitelist, no `sorryAx`.

The note PDF rebuild: `tectonic claim.tex` (or `latexmk -xelatex`) inside
`claim/`; `lstlean.tex` is included there.

## DOI

To be reserved at Zenodo upload (see `../../UPLOAD.md` step 1); the note's
Data availability section reads "DOI to be reserved at upload". Public mirror:
<https://github.com/Aurora0134/ai4math-claims>.
