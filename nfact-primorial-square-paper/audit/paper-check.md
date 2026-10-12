# Paper claim audit — nfact-primorial-square (papers track)

- Audit: independent read-only review, 2026-10-06, on the session model node
  (kimi-k3); the auditor did not modify any package file (all rulings rest on
  the auditor's own mechanical re-runs, not on the assembly track's reports).
- A fuller numeric version of this verdict is held in the source repository
  (batch audit records), not shipped.
- **Verdict: AUDIT PASS (five standard items + two batch-specific clauses,
  zero findings).**

> **2026-10-07 version note.** For publication the package texts were cleaned
> (disclosure section minimized to the fixed three-sentence form; comments
> and docstrings in the Lean sources translated to English; internal
> repository references generalized). Code regions, mathematical content, and
> all conclusions below are unchanged; see `audit/comment-cleanup-diff.md`
> for the Lean-side correspondence. The sha256 values and the `paper.tex`
> line numbers quoted below are the pre-cleanup values of record (the shipped
> `proofs/` copies differ only in the comment layer, and the paper text was
> re-assembled from its skeleton after the cleanup).

## Item-by-item rulings

1. **Anchors → frozen snapshot / grading / audit evidence: PASS.** All
   `% LEAN:` anchor declaration names (audited text lines 231/237/243/249/255/
   265/266/267) are verbatim the eight frozen statements, all graded complete
   proof, consistent with the final adjudication's grading line. The frozen
   snapshot's sha256 (`0b13d08d…f8ea48`) and the final file's
   (`276cb2e6…86070a`) were recomputed by the auditor and matched the values
   stated in the paper card and in the Verification section verbatim
   (pre-cleanup values; see the version note); the audit evidence (the
   well-definedness ruling / the final adjudication) was read and ships
   (normalized copy).
2. **Wording strength ≤ grading + the fenced obligations: PASS.** No
   overreach anywhere (no "we prove/we establish/novel/previously unknown"
   overclaims; every "first" is ordinal or negated). The fences are all
   discharged: the second equation is not claimed (Introduction +
   Limitations(b)); #399 is marked DISPROVED and used only as same-family
   adjacency (its counterexample figures recomputed by this audit, match);
   2602.09687 carries the restricted "its object of study does not contain
   n#" wording; the failure set {2,3,9,21} carries the domain convention
   n ≥ 2; the A055204 distinction is written; Nagura carries the
   "original text not obtained" qualifier; Berndt–Galway is background only,
   not load-bearing. Numeric spot checks (60²=3600, 6!·6#=21600,
   3·409609−1=1228826, the certificate-chain count) all matched.
3. **lstlisting byte-exactness: PASS (two channels).** The shipped listing
   checker was re-run: all five blocks (lst:stmt / lst:chain / lst:tail /
   lst:main / lst:axioms) MATCH; the auditor's own independent diffs of
   lst:stmt / lst:chain / lst:tail were empty. The deposit-tree copies'
   sha256 all matched their sources (the adjudication copy differs only by
   the disclosed path-prefix normalization). (After the 2026-10-07 cleanup
   the checker compares against the shipped comment-cleaned files; the
   code-region correspondence to the frozen sources is in
   `audit/comment-cleanup-diff.md`.)
4. **`\lean{}` identifiers exist: PASS.** Every `\lean{}` identifier named in
   the paper was extracted, deduplicated, and grep-checked against the final
   proof file: all present (list identical to the shipped
   `audit/lean-idents.txt`).
5. **Disclosure / authorship / PII: PASS (under the disclosure caliber then
   in force).** The four disclosure elements then required plus the
   CRediT-style section and Data availability were present; the author line
   is `Aurora0134` in both places; zenodo.json carries no orcid key; a
   whole-package PII scan found nothing. (Superseded on 2026-10-07 by the
   minimal-disclosure caliber: the paper now carries the fixed
   three-sentence disclosure, and the metadata carries no AI contributor
   entry.)
6. **Batch-specific clause A (roundtrip spot checks): consistent ×3.**
   (i) The prose on the iff/existence-witness double form in §Encoding
   decisions ↔ the frozen declarations (statement snapshot lines 41–42/46–47)
   plus the bridge lemma, item by item; (ii) §Background's
   "2p ≤ n < 3p ⟹ ν_p(n!) = 2 (p² > n kills the higher terms) + Lemma B
   existence" ↔ the frozen Lemma B plus the final file's assembly segment,
   consistent under the natural-number reading; (iii) Lemma A's prose ↔
   `isSquare_iff_all_factorization_odd (hn : 1 ≤ n)`, the unused `hn` already
   disclosed in Limitations(e) ("the criterion holds", not "requires n ≥ 1").
   All three semantically consistent.
7. **Batch-specific clause B (DOI wording): PASS.** No arXiv-number
   placeholder anywhere (UPLOAD.md carries only a negative note); Data
   availability cites the companion claim deposit's concept DOI
   `10.5281/zenodo.23177003` (paper text / bibitem / zenodo.json agree);
   zenodo.json carries no `<<>>` placeholder; the paper's own DOI was then
   phrased as reserved-at-upload with no fait-accompli wording. (The deposit
   was published later the same day; the DOI backfill since then is recorded
   in `metadata/README.md`.)

## Machine-gate recheck

Gate 1 (paper-lint) exit 0; gate 2 (tectonic) exit 0 with zero missing
characters, zero overfull hboxes, zero unresolved references; the mechanical
reconciliation gate green (its gates 4 and 1 SKIPPED per the papers-track
default invocation, not misreported). Independent re-scan of the final file:
zero hits for sorry/admit/axiom/unsafe/opaque/native_decide/implemented_by;
the shipped `audit/axioms.out` shows all eight entries exactly
[propext, Classical.choice, Quot.sound], no sorryAx.

## Observations (non-blocking, for the author's awareness before publish)

1. zenodo.json's single license field is MIT; the paper's CC BY 4.0 is added
   through the UI multi-licence control (disclosed in the README).
2. §sec:refuted (the refuted Bertrand-splice route) is presented as narrative
   with an explicit evidence-scope bound and occupies no theorem environment;
   Limitations(j) declares the layering of numeric evidence — within caliber;
   the author is aware before publishing that it is a method-level
   refutation, not a theorem.

## Qualifiers that must stay disclosed (do not dilute)

The second equation is not claimed / Nagura's original text was not obtained
/ Berndt–Galway is not load-bearing / the novelty review's zero hits mean
"no occupying record in the channels queried", not absolute novelty /
Lemma A's `hn` is unused / three docstrings carry comment-level additions /
no OEIS registration is claimed / no "first formalization" statement /
arXiv submission is not part of this batch.

## Final ruling

**AUDIT PASS (zero findings).** Quality-gate status: paper-lint exit 0;
paper-compile exit 0; this claim audit PASS.

## 2026-10-07 cleanup addendum

- Package texts cleaned for publication under the minimal-disclosure caliber:
  the paper's disclosure section replaced by the fixed three-sentence form
  (AI assistance + kernel verification + author responsibility; model name
  `kimi-k3` without prefixes); Lean comments/docstrings translated to
  English; audit documents translated and internal repository references
  generalized; metadata (zenodo.json) updated accordingly (no AI entry in
  contributors; no internal names in title/keywords/notes).
- Code regions of all Lean files unchanged (byte-identical to the frozen
  development; proof in `audit/comment-cleanup-diff.md`). All audit
  conclusions above stand unchanged.
