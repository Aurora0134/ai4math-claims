# mossad42-01-half3 - claim of record (deposit README)

Priority claim deposited via the AI4Math pipeline (SOP 08b, priority-claim channel).
AI-generated content, adjudicated by the Lean 4 kernel; the human author reviewed and is
responsible for all content.

## What this is

A machine-checked result about the pure integer sequence b1(k) = 8^k * C(7k,k) on multiples of 8 and 0 elsewhere.

| Lean name | Grade | Content |
|---|---|---|
| `a1_mul_eight` | complete proof | a1(8k) = b1(k) (definitional unfolding lemma; low content) |
| `a1_eq_zero_of_not_dvd` | complete proof | 8 does not divide n implies a1(n) = 0 (definitional unfolding lemma; low content) |
| `a1_ne_zero_iff` | complete proof | MAIN: a1(n) != 0 iff 8 divides n |
| `b1_ratio` | complete proof | MAIN: rational ratio between consecutive non-zero terms |

## Scope fence (important)

The kernel proves **only** structural facts about the object above. The identification of that
object with a constrained domino-tiling count of the board is a **combinatorial semantics
bridge** that is **NOT proved here** and is stated only as a conjecture. Nothing in this
deposit should be read as a proved statement about tiling counts.

## Verification

- Lean `v4.34.0`, mathlib4 `v4.34.0` (rev `5ed29652`); pinned in `proofs/lean-toolchain`.
- Strict compilation exits 0; no `sorry`, no `admit`, no `sorryAx`.
- `#print axioms` (verbatim in `audit/final-t01.txt`):
  a1_mul_eight -> [propext, Classical.choice, Quot.sound]; a1_eq_zero_of_not_dvd -> [propext]; a1_ne_zero_iff -> [propext, Classical.choice, Quot.sound]; b1_ratio -> [propext, Classical.choice, Quot.sound].
  The axiom set is a subset of {propext, `Quot.sound`, `Classical.choice`}.
- Statement freeze: `proofs/01-half3-statements.lean`,
  sha256 `21ec4bd99fba4c9e1b3ef7ebb3df0489408d30a414ce12addf776e01897ee3c8` (62 lines).
- Final artifact: `proofs/01-half3-proved.lean`,
  sha256 `69375553c0f82ef5a983e46fab9bcb5060f5ecd2ac2fc4bf3ebf3f7941c596ae` (118 lines).
- Statement text was frozen before proving and compared byte-wise afterwards
  (`audit/statement-diff.md`): all definitions and theorems identical.
- Listing byte-exactness against the frozen sources: `audit/listing-verify.txt`.

## Novelty (C9 discipline)

Verdict: **no occupying record found**. Full query log, including every zero-hit query, is in
`audit/c9-record.md` (assembled verbatim from the screening batch and this batch's
supplementary search).

Two limitations are carried deliberately and must not be dropped from any restatement:

1. The **OpenAlex channel was unreachable** from the searching machine (Cloudflare-fronted
   hosts timed out; DNS resolution was verified correct, so this is not DNS poisoning).
   **Crossref was used as a substitute**, so literature coverage here is *lower* than in the
   screening batch. That is a channel gap, **not** strengthened evidence.
2. A **zero hit is not novelty.** The strongest claim licensed is that no record of this
   constrained-selection object was found in the channels queried. The phrases "new
   discovery" and "first proof" are **not** used and must not be introduced.

No moment/expectation novelty is claimed: mixed moments `E[V^a H^b]` for general `m x n`
boards are already occupied (Fibonacci Quarterly 2019, doi:10.1080/00150517.2019.12427625).
Objects of this family of different widths are m-dimensional variants and are not used as
independent novelty evidence for each other.

## Known presentation items

- **Length**: this note compiles to **9 pages**, above the "claim note, 2-4 pages"
  figure in the responsibilities section of `harness/departments/08b-claim.md`. The excess is
  entirely verbatim frozen listings (the statement snapshot and the complete proof, reproduced
  byte-exactly) plus the C9 search table. Under the **explicit waiver** recorded in SOP 08b
  (Known boundaries; user ruling 2026-09-28, "ratify the overshoot, convert to an explicit
  waiver") the note is **not** shortened: the only correct way to shrink it is to move the
  verbatim listings out of the body into `proofs/`, and deleting evidence or weakening the
  claim is forbidden. Package card: `claims/mossad42-01-half3/card.md`.
- **Listing rendering**: the frozen sources are Chinese-annotated and use Unicode math symbols.
  XeTeX does not apply the `listings` `literate` table to multi-byte characters, so the note
  maps every non-ASCII codepoint that occurs inside a listing to a math glyph through a
  per-codepoint active-character table (`\lccode` idiom) in the preamble. Codepoints added in
  the 2026-09-30 rework: U+220F, U+2260. Two machine checks guard this and both must hold:
  `tasks/20260930-mossad42-quad/claims/scan_listing_unicode.py` reports no `MISSING` codepoint,
  and the compile log contains **zero** `Missing character` warnings (a missing glyph is
  otherwise dropped silently while the `.tex` source stays byte-exact). Listing source bytes are
  never altered, so the byte-exactness checks are unaffected.

## Reproduction

    bash scripts/lean-verify proofs/01-half3-proved.lean      # strict mode; exit 0 expected

## DOI

- **Reserved (prereserved via API)**: `10.5281/zenodo.23078797` — reserved by `scripts/zenodo-deposit.py prepare` on 2026-10-01; **publish is pending and is the human author's own step** (the pipeline has no publish code path).
- Backfill points after publish: this file + `claims/mossad42-01-half3/card.md` + `run-state.md` (all in the source repository, not shipped in this package).
