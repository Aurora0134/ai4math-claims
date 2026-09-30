# Zenodo deposit README — grid3n-colmid-indep (AI4Math claim-of-record artifact)

> AI-generated (2026-09-30). This package is an SOP 08b priority-claim deposit.
> Outbound acts: the GitHub mirror push (Aurora0134/ai4math-claims) was executed
> by the pipeline under the author's 2026-09-30 outbound authorisation for
> GitHub (commit recorded in the source repository's
> `claims/grid3n-colmid-indep/card.md`); the Zenodo upload/publish has no
> machine credential on the pipeline host and remains the human author's own
> manual step, see the source repository's
> `claims/grid3n-colmid-indep/UPLOAD.md` (not shipped in the package).

## Pre-publish check (read-only)

```bash
python claims/grid3n-colmid-indep/audit/sanitize-package.py --check-only
# three gates: FILE-MANIFEST matches disk / path-shaped promises reconcile / no machine paths
```

## DOI

- **Not reserved**: produced by the author's "Get a DOI now!" on the Zenodo
  upload page. This package contains no real DOI.
- Backfill points: this file + `claims/grid3n-colmid-indep/card.md` +
  `run-state.md`; the note's Data availability section is already phrased as
  "reserved at upload" (no placeholder string is carried).

## Reproduction

```bash
# pinned toolchain: see proofs/lean-toolchain (leanprover/lean4:v4.34.0)
# mathlib4 v4.34.0, rev 5ed29652 (mathlib cache: mathlib's own cache-get for that rev)
cd <project dir containing proofs/02-grid3n-colmid-indep-proved.lean and its imports>
lake env lean proofs/02-grid3n-colmid-indep-proved.lean
# expected: exit 0, empty output (strict compile, 0 sorry, 0 warning; the
# roster #check echoes of the frozen interface are part of the file by design)
```

Axiom re-check (append to a copy of the proof file):

```
#print axioms c_z_rec
# expected line (the shipped audit/axioms.out is a byte-faithful kernel
# re-run of 2026-09-30, exit 0):
'c_z_rec' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Page-count waiver note (SOP 08b, Known boundaries)

**Page count well above the 2-4-page claim-note baseline** (40 pages) — the
excess is entirely the verbatim frozen artifacts: the whole 1188-line proof
file as a continuous lstlisting (Section 3, no excerpting), the frozen
statement excerpt and the 146-line frozen-interface excerpt (Section 2),
and the full C9 novelty-review dossier (audit/c9-record.md, ~220 lines).
Per the 2026-09-28 user adjudication ("page counts are an explicit waiver,
not a gate"), shortening them is forbidden (the only admissible reduction
would move verbatim listings out of the body while keeping them in
proofs/); no evidence was removed and no wording was lowered to fit pages.

## Scope note (what this deposit is)

Kernel layer: one theorem, c_z_rec — the sixth-order recurrence
z(n) + 15 z(n-4) = 12 z(n-2) + 2 z(n-6) (n >= 6) for the independent-set
counting sequence of the three-row strip with every odd column's middle
vertex deleted; 0 sorry; axioms exactly the whitelist. The proof route
(bridge bijection, transfer matrix, certificate polynomial) is part of the
deposited proof file. Novelty: proposition-level C9 review, no occupying
record; value tier new sequence (lower tier); the even-indexed subsequence
is term-by-term the registered A122011 (different object: a 3x3 matrix-power
example) and the recurrence signature (12,-15,2) is already indexed — no
new-recurrence and no new-mathematics claim. Not claimed: recurrence
minimality, closed forms, asymptotics.
