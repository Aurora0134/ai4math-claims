# Zenodo deposit README — ladder-pend3-interleave (AI4Math claim-of-record artifact)

> AI-generated (2026-09-29). This package is an SOP 08b priority-claim deposit.
> Outbound acts: the GitHub mirror push (Aurora0134/ai4math-claims) was executed
> by the pipeline under the author's 2026-09-29 outbound authorisation (commit
> recorded in the source repository's `claims/ladder-pend3-interleave/card.md`);
> the Zenodo upload/publish has no machine credential on the pipeline host and
> remains the human author's own manual step, see the source repository's
> `claims/ladder-pend3-interleave/UPLOAD.md` (not shipped in the package).

## Pre-publish check (read-only)

```bash
python claims/ladder-pend3-interleave/audit/sanitize-package.py --check-only
# three gates: FILE-MANIFEST matches disk / path-shaped promises reconcile / no machine paths
```

## DOI

- **Not reserved**: produced by the author's "Get a DOI now!" on the Zenodo upload page.
  This package contains no real DOI.
- Backfill points: this file + `claims/ladder-pend3-interleave/card.md` + `run-state.md`;
  the note's Data availability section is already phrased as "reserved at upload"
  (no placeholder string is carried).

## Reproduction

```bash
# pinned toolchain: see proofs/lean-toolchain (leanprover/lean4:v4.34.0)
# mathlib4 v4.34.0, rev 5ed29652 (mathlib cache: mathlib's own cache-get for that rev)
cd <project dir containing proofs/01-comb10-ladder-pend3-proved.lean and its imports>
lake env lean proofs/01-comb10-ladder-pend3-proved.lean
# expected: exit 0, empty output (strict compile, 0 sorry, 0 warning)
```

Axiom re-check (append to a copy of the proof file):

```
#print axioms ap3_interleave
#print axioms ap3_mod2_period15
#print axioms ap3_mod4_period30
# expected lines (the shipped audit/axioms.out is a byte-faithful kernel re-run of
# 2026-09-29, exit 0):
'ap3_interleave' depends on axioms: [propext, Quot.sound]
'ap3_mod2_period15' depends on axioms: [propext, Classical.choice, Quot.sound]
'ap3_mod4_period30' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Page-count waiver note (SOP 08b, Known boundaries)

**Page count well above the 2-4-page claim-note baseline** — the excess is
entirely the verbatim frozen artifacts: the whole 440-line proof file as a
continuous lstlisting (Section 3), the three frozen statement excerpts with
their docstrings and the 30-entry pat30 table, and the two-stage C9
novelty-review record tables. Per the 2026-09-28 user adjudication ("page
counts are an explicit waiver, not a gate"), shortening them is forbidden
(the only admissible reduction would move verbatim listings out of the body
while keeping them in proofs/); no evidence was removed and no wording was
lowered to fit pages.

## Scope note (what this deposit is)

Kernel layer: three theorems about the recurrence-defined pure sequence ap3
(interlacing identity; explicit period-15 mod-2 table; explicit period-30
mod-4 table), 0 sorry, whitelist axioms. Conjecture layer (NOT kernel-proved,
NOT claimed as theorem): ap3 = matching count of the period-3 pendant ladder;
period minimality; period-39/60 laws; pure-period existence. Novelty: two-stage
C9 review, no occupying record; value tier new sequence / new recurrence.
