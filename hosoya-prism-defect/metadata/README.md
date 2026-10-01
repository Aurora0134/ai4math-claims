# hosoya-prism-defect — claim of record (deposit README)

Priority claim deposited via the AI4Math pipeline (SOP 08b, priority-claim channel).
AI-generated content, adjudicated by the Lean 4 kernel; the human author reviewed and is
responsible for all content.

## What this is

Two machine-checked bridge theorems, graph-side: for every $n \ge 3$, the number of matchings
(Hosoya sense, empty matching included) of the $n$-prism graph `C_n □ P_2`

| Lean name | Grade | Content |
|---|---|---|
| `hosoya_prism_del_spoke` | complete proof | with one spoke (rung) edge deleted, endpoints kept: `hosoya (prismDelSpoke n hn) = aspoke (n-3)` |
| `hosoya_prism_del_rim` | complete proof | with one rim (perimeter) edge deleted, endpoints kept: `hosoya (prismDelRim n hn) = arim (n-3)` |

`aspoke` / `arim` are frozen integer sequences (initial values 25, 86, 271, 876 and
26, 86, 274, 883; both satisfy the fourth-order recurrence
`a(n+4) = 2a(n+3) + 4a(n+2) - a(n)` of the prism's own matching sequence A102080 — same
signature, different initial values). Index 0 corresponds to graph-side n = 3.

## Scope fence (important)

Value tier is **new sequence**, never new mathematics and never a new recurrence: the
recurrence itself is the mother sequence A102080's registered formula (same spectrum,
different initial values), and no new-recurrence claim is made. The graph-side bridge is
graded **first formalisation (Lean three-layer zero same-form)** — that claim is scoped to
the Lean/formalisation-ecosystem layer. The six mod-2/4/8 congruence theorems of the parent
program are **not** part of this deposit.

## Verification

- Lean `v4.34.0` (`leanprover/lean4:v4.34.0`), mathlib4 `v4.34.0` (rev `5ed29652`); pinned in
  `proofs/lean-toolchain`.
- Strict compilation exits 0; no `sorry`, no `admit`, no `sorryAx`, no `native_decide` in the
  deposited proof.
- `#print axioms` (verbatim in `audit/axioms.out`, independent re-print 2026-10-01):
  `hosoya_prism_del_spoke` -> [propext, Classical.choice, Quot.sound];
  `hosoya_prism_del_rim` -> [propext, Classical.choice, Quot.sound]; the nine supporting
  declarations of the audit are likewise within the whitelist. The axiom set of every audited
  declaration is a subset of {propext, `Quot.sound`, `Classical.choice`}.
- Statement freeze: `proofs/statement.lean`, sha256
  `d186ff1651a4383e7e213b42ba4ec8c0171d9e7004231db2764370cd967ca39e` (124 lines, LF).
  The frozen file's two bridge-theorem proof bodies are `sorry` placeholders by design (the
  formalisation department freezes statements; the proving department replaces bodies); the
  deposited proof file carries the real, kernel-checked proofs.
- Final artifact: `proofs/bridge.lean`, sha256
  `399ee81fe363f639811a3408397b14259357ea1e5d195f3e916fd7b7c07af6c1` (1857 lines; CRLF on the
  working disk — shipped byte-exact; the claim note's listing is spliced LF-normalised per the
  chorded/ladder/hosoya precedent, disclosed in the note).
- Final adjudication (seven checks, all passed, 2026-10-01): `audit/final-phase2-r3.txt`.
- Listing byte-exactness against the frozen sources: `audit/listing-verify.txt`
  (`audit/inspect-tex.py --verify`).

## Novelty (C9 discipline)

Verdict: **no occupying record found (reachable-channel scope)**. Full query log, including
every zero-hit query, is in `audit/c9-record.md` — concatenated verbatim (byte-for-byte) from
three source records: the screening dossier (41 sequence-side queries), the graph-side
increment (31 queries over six channels, five positive controls all passing), and the
independent reviewer's confirmation. The strongest sequence-side evidence: the OEIS
linear-recurrence index page for signature (2,4,0,-1) holds exactly four registered sequences
(A102080 mother prism, A020877 Moebius-ladder matchings, two tiling/array families) and
neither slice is among them.

Recorded exposures, carried deliberately and not to be dropped from any restatement:

1. The Aldred–Plummer 2017 record (Matching extension in prism graphs, Discrete Applied
   Mathematics 221) is family-relevant but **structural** (n-extendability of matchings, not a
   counting result); its full text is behind a paywall and was **unread** — recorded as an
   exposure, not as evidence.
2. The ladder-side Farrell 1983 record concerns ladders, not prisms; also unread.
3. A **zero hit is not novelty.** The strongest claim licensed is that no record of this object
   was found in the channels queried. The phrases "new discovery" and "first proof" are not
   used and must not be introduced.

## Known presentation items

- **Length**: this note compiles to **53 pages**, above the "claim note, 2-4 pages" figure in
  the responsibilities section of `harness/departments/08b-claim.md`. The excess is entirely
  verbatim frozen listings (the statement snapshot lines 36–98 with three declared elisions,
  and the complete 1857-line proof file, reproduced byte-exactly) plus the C9 search table.
  Under the **explicit waiver** recorded in SOP 08b (Known boundaries; user ruling 2026-09-28,
  "ratify the overshoot, convert to an explicit waiver") the note is **not** shortened: the
  only correct way to shrink it is to move the verbatim listings out of the body into
  `proofs/`, and deleting evidence or weakening the claim is forbidden. Package card:
  `claims/hosoya-prism-defect/card.md`.
- **Listing rendering**: the frozen sources are Chinese-annotated and use Unicode math symbols.
  XeTeX does not apply the `listings` `literate` table to multi-byte characters, so the note
  maps every non-ASCII codepoint that occurs inside a listing to a math glyph through a
  per-codepoint active-character table (`\lccode` idiom) in the preamble, following the
  mossad42-01-half3 glyph-map precedent; codepoints outside that table route through xeCJK +
  SimSun. Two machine checks guard this and both must hold: `audit/tex-check.py` reports PASS,
  and the compile log contains **zero** `Missing character` warnings (a missing glyph is
  otherwise dropped silently while the `.tex` source stays byte-exact). Listing source bytes
  are never altered, so the byte-exactness checks are unaffected.
- **Line endings**: `proofs/bridge.lean` is CRLF on the working disk and ships byte-exact; the
  claim note's proof listing is spliced LF-normalised per the chorded/ladder/hosoya precedent,
  disclosed in the note's caption and header.

## Reproduction

    lake env lean proofs/bridge.lean      # with the pinned toolchain; exit 0 expected

## DOI

- **Reserved (prereserved via API)**: `10.5281/zenodo.23080411` — reserved by `scripts/zenodo-deposit.py prepare` on 2026-10-01; **publish is pending and is the human author's own step** (the pipeline has no publish code path).
- Backfill points after publish: this file + `claims/hosoya-prism-defect/card.md` + `run-state.md` (all in the source repository, not shipped in this package).
