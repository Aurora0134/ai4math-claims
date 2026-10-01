# Zenodo deposit README — holestrip-tour (AI4Math claim-of-record artifact)

> AI-generated (2026-09-30). This package is an SOP 08b priority-claim deposit.
> Outbound acts: NONE were taken by this batch. The author's instruction of
> 2026-09-30 ("complete the paper lane for the knight-tour direction and run
> the fast claim channel") did not name any outbound act, so the GitHub mirror
> push, the Zenodo upload/publish and the arXiv submission all remain the human
> author's own manual steps — see the source repository's
> `claims/holestrip-tour/UPLOAD.md` (not shipped in the package).

## Pre-publish check (read-only)

```bash
python claims/holestrip-tour/audit/sanitize-package.py --check-only
# gates: FILE-MANIFEST matches disk / path-shaped promises reconcile / no machine paths
```

## DOI

- **Reserved (prereserved via API)**: `10.5281/zenodo.23078819` — reserved by `scripts/zenodo-deposit.py prepare` on 2026-10-01; **publish is pending and is the human author's own step** (the pipeline has no publish code path).
- Backfill points after publish: this file + `claims/holestrip-tour/card.md` + `run-state.md` (all in the source repository, not shipped in this package).
## Reproduction

```bash
# pinned toolchain: see proofs/lean-toolchain (leanprover/lean4:v4.34.0)
# mathlib4 v4.34.0, rev 5ed29652
cd <project dir containing proofs/01-holestrip-tour-proved.lean>
lake env lean proofs/01-holestrip-tour-proved.lean
# expected: exit 0 (the file closes with the two #print axioms commands; the
# axiom lines printed are reproduced verbatim in audit/axioms.out)
```

Axiom re-check (already appended at the end of the shipped proof file):

```
#print axioms exists_hamiltonian_path_iff
#print axioms exists_hamiltonian_cycle_iff
# expected lines (the shipped audit/axioms.out is a byte-faithful kernel re-run
# of 2026-09-30, exit 0; all 19 printed declarations are whitelist subsets):
'exists_hamiltonian_path_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'exists_hamiltonian_cycle_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Page-count waiver note (SOP 08b, Known boundaries)

**Page count (17 pages) is well above the 2-4-page claim-note baseline** — the
excess is entirely the verbatim frozen artifacts: four contiguous excerpts of
the 2,633-line final proof file (the closed-tour induction assembly, the
open-tour induction assembly, the cut barrier with the n=6/7 certificates, and
the two iff assemblies), the frozen statement excerpts, and the four-source C9
novelty-review record (assembled in full in `audit/c9-record.md`). Per the
2026-09-28 user adjudication ("page counts are an explicit waiver, not a
gate"), shortening them is forbidden (the only admissible reduction would move
verbatim listings out of the body while keeping them in `proofs/`); no evidence
was removed and no wording was lowered to fit pages.

## Scope note (what this deposit is)

Kernel layer: two theorems about the knight graph of the 3 x n board with the
two far corners removed — `exists_hamiltonian_path_iff` (open tours exist iff
n = 1, 4, 5, or n >= 8) and `exists_hamiltonian_cycle_iff` (closed tours exist
iff n is even and n >= 8), 0 sorry, whitelist axioms. Not claimed: the counting
companion of the same family (the number of tours), which is auxiliary
computational data of the source task; periodicity or asymptotics of that
count; anything beyond the two theorem statements. Novelty: four-round C9
review, no occupying record; value tier a small original classification
theorem. The narrative paper of this result is prepared separately under the
pipeline's paper lane (`papers/holestrip-tour/` in the source repository) and
will reference this DOI.
