# Zenodo deposit README — hosoya-split-identity (AI4Math claim-of-record artifact)

> AI-generated (2026-09-29). This package is an SOP 08b priority-claim deposit; the
> upload/publish/push (outbound acts) are the human author's own manual steps, see the
> source repository's `claims/hosoya-split-identity/UPLOAD.md` (not shipped in the
> package). This channel requires neither an arXiv account nor endorsement.
> The GitHub mirror push (Aurora0134/ai4math-claims) is ALSO an outbound act left to
> the author; this package ships the deposit tree the mirror would snapshot.

## Pre-publish check (read-only)

```bash
python claims/hosoya-split-identity/audit/sanitize-package.py --check-only
# three gates: FILE-MANIFEST matches disk / path-shaped promises reconcile / no machine paths
```

## DOI

- **Not reserved**: produced by the author's "Get a DOI now!" on the Zenodo upload page.
  This package contains no real DOI.
- Backfill points: this file + `claims/hosoya-split-identity/card.md` + `run-state.md`;
  the note's Data availability section is already phrased as "reserved at upload"
  (no placeholder string is carried).

## Reproduction

```bash
# pinned toolchain: see proofs/lean-toolchain (leanprover/lean4:v4.34.0)
# mathlib4 v4.34.0, rev 5ed29652 (mathlib cache: mathlib's own cache-get for that rev)
cd <project dir containing proofs/01-hosoya-split-proved.lean and its imports>
lake env lean proofs/01-hosoya-split-proved.lean
# expected: exit 0, empty output (strict compile, 0 sorry, 0 warning)
```

Axiom re-check (append to a copy of the proof file):

```
#print axioms hosoya_deleteEdge_split_pts
#print axioms hosoya_prism_split_spoke
# each line: [propext, Classical.choice, Quot.sound] (whitelist subset, no sorryAx)
# the shipped audit/axioms.out is a byte-exact re-run via the library import route
# (import Library.HosoyaPrismSplit), matching the audit department's kernel re-run.
```

## Page-count waiver note (SOP 08b, Known boundaries)

**20 pages** — beyond the 2–4-page claim-note baseline, the excess is entirely the
verbatim frozen artifacts: the whole 429-line proof file as a continuous lstlisting
(Section 3) and the C9 novelty-review record tables. Per the 2026-09-28 user
adjudication ("page counts are an explicit waiver, not a gate"), shortening the
note by deleting evidence is forbidden; this line is the waiver record.

## Contents

| Path | Content |
|---|---|
| `claim/claim.tex` | Claim note LaTeX source (English); two `% LEAN:` anchors (hosoya_deleteEdge_split_pts / hosoya_prism_split_spoke, grade = complete proof) |
| `claim/claim.pdf` | Compiled note (tectonic 0.17.0 / XeTeX, exit 0, `Missing character` 0, unresolved references 0, 20 pages). The preamble carries a rendering-only XeTeX patch: `\lccode` active chars for codepoints outside xeCJK's punctuation table (03B1, 03B2, 2081, 2082, 2115, 2124, 2190, 2191, 2192, 2194, 21A5, 2200, 2203, 2208, 2209, 2212, 2227, 2228, 2260, 2264, 2265, 22A2, 25A1, 25B8, 27E8, 27E9); 00B7/2014/CJK and fullwidth punctuation route through xeCJK + SimSun. Listing source bytes untouched. |
| `claim/lstlean.tex` | listings Lean language definition (single source of truth in `harness/templates/paper/`, copied per-package to make the deposit self-compiling) |
| `proofs/01-hosoya-split-statements.lean` | Frozen statement file (124 lines; the two bridge theorems are `sorry` placeholders — NOT part of this claim) sha256=`d186ff1651a4383e7e213b42ba4ec8c0171d9e7004231db2764370cd967ca39e` |
| `proofs/01-hosoya-split-proved.lean` | Final proof file (429 lines, 0 sorry) sha256=`d2efac514083c505b9fa14675e59a8009054e2063769c263e069d608f656b016` — byte-exact copy of the working-tree artifact (`attempts/phase0/r2/split-identity.lean`, CRLF on the working disk, autocrlf workspace; identical bytes confirmed by cmp) |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-01-hosoya-split.txt` | SOP 05 final audit adjudication (four checks passed; both theorems = complete proof; provenance tier fact preserved; out-of-scope declarations explicit) |
| `audit/statement-diff.out` | Theorem-head symmetric-difference record (IDENTICAL, whitespace-normalised byte comparison) |
| `audit/axioms.out` | `#print axioms` verbatim two lines (both `[propext, Classical.choice, Quot.sound]`, no sorryAx), obtained via the library-import route (import Library.HosoyaPrismSplit) |
| `audit/audit-axioms-sidecar.log` | the same two lines rebuilt with a provenance header (sanitize step) |
| `audit/audit-strict-compile.log` | strict re-compile record header (run's stdout is EMPTY by design: 0 error 0 warning; EXIT=0 carried by the audit re-run record) |
| `audit/audit-strict-compile.log`(body) | original stdout (empty) |
| `audit/c9-record.md` | C9 novelty-review record: verbatim byte-exact extracts from three sources — L14C dossier (192 lines), graph-side incremental C9 (177 lines), independent confirmation record (47 lines) — plus the packager's scope-correction pointer (supplementary 2026-09-29 arXiv sweeps covering the identity's own wording). Self-check: `python claims/hosoya-split-identity/audit/build-c9-record.py --check` → 7/7 verbatim PASS |
| `audit/lint.txt` / `audit/compile.txt` | This package's paper-lint (PASS, exit 0; three runs) and paper-compile (exit 0; the final run's full log) |
| `audit/*.log` (compile-run2..7) | the compile-run history of this packaging session (kept for the latex-round reconciliation) |
| `audit/listing-verify.txt` | byte-exact verification record of the note's three lstlisting ranges (3/3 PASS, two appended re-check runs) |
| `audit/inspect-tex.py` / `audit/build-c9-record.py` / `audit/sanitize-package.py` / `audit/make-zip.py` | assembly and self-check scripts: listing injection + byte-exact verify, non-ASCII egress check, C9-record build + self-check, package desensitisation + promise reconciliation + FILE-MANIFEST generation, zip build with entry-set assertion |
| `audit/claim-check.md` | The audit department's reduced claim-audit adjudication (quality gate ③; added after the adjudication returns; prerequisite for publication) |
| `metadata/zenodo.json` | Zenodo metadata (creators = Aurora0134, no orcid key per the signature policy; contributors keep the AI disclosure; related_identifiers.references = OEIS A102080, isIdenticalTo = the GitHub mirror repo) |
| `metadata/FILE-MANIFEST.txt` | sha256 + bytes + path per package file (re-hash this before any outbound act) |

## Working-repository originals NOT shipped

`tasks/20260929-l14c-graphside-pipeline/` (task card, budget ledger, attempts with
agent-call audit trails, the Phase-1/2 work in flight), the C9 raw query responses
under the two task directories, and `verify-proj/Library/HosoyaPrismSplit.lean`
(the library import; same bytes as the shipped proof file). The package carries
verbatim audits; originals stay in-repo.