# Claim-note claim audit — nfact-primorial-square

- Audit: independent read-only review, 2026-10-06, on the session model node
  (kimi-k3); the auditor did not modify any package file (recomputation ran
  from patched copies in a scratch directory).
- **Verdict: AUDIT PASS (five items + the batch-specific clause, zero
  findings)**; two observations (O1/O2), both disposed.
- Quality-gate snapshot at audit time: (1) paper-lint exit 0
  (`audit/lint.txt`); (2) tectonic compile exit 0, 0 missing characters, 0
  overfull hboxes (`audit/compile-run.log`); (3) this audit PASS.

> **2026-10-07 version note.** For publication the package texts were cleaned
> (disclosure section minimized; comments/docstrings in the Lean sources
> translated to English; internal repository references generalized). Code
> regions, mathematical content, and all conclusions below are unchanged; see
> `audit/comment-cleanup-diff.md` for the Lean-side correspondence. The
> sha256 values quoted below are the pre-cleanup values of the frozen files
> of record; the shipped proofs/ copies differ only in the comment layer.

## Item-by-item rulings

1. **Anchors → frozen snapshot / grading / audit evidence: PASS.** All
   `% LEAN:` anchor declaration names really occur in the final file
   (ripgrep hits); sha256 recomputed by the auditor for the three files
   (statement snapshot `0b13d08d…f8ea48`, statement source
   `63806420…451a8f`, final file `276cb2e6…86070a`) matched the package's
   declared values verbatim, and the `zenodo/proofs/` copies had the same
   hashes (pre-cleanup values, see the version note); grading = complete
   proof (the final adjudication's four checks all PASS, zero sorry, axioms
   exactly the whitelist); audit evidence shipped (the adjudication copy /
   the well-definedness ruling / axioms.out, all whitelist).
2. **Wording ≤ grading ∧ ≤ the novelty adjudication: PASS.** The second
   equation of the pair is explicitly not claimed; #399 is written DISPROVED
   and used only as same-family adjacency; 2602.09687 carries the restricted
   "its object of study does not contain n#" wording; the failure set
   {2,3,9,21} carries the domain convention n ≥ 2; the A055204 distinction
   is written; the novelty section's adjudication matches the source record;
   the "a zero hit is not novelty" self-cap is in place; Lemma A's unused
   hypothesis, the non-reliance on the Berndt–Galway computational bound,
   and the absence of any OEIS-registration claim are all in place, item by
   item.
3. **lstlisting byte-exactness: PASS.** The listing checker was re-run (a
   patched copy): lst:stmt (the snapshot's lean fence, whole), lst:chain,
   lst:tail, lst:main all MATCH byte-identical (ranges and byte counts in
   the shipped `audit/listing-verify.txt`), and the recomputed output was
   byte-identical to that file. (After the 2026-10-07 cleanup the checker
   compares against the shipped comment-cleaned files; the code-region
   correspondence to the frozen sources is in `audit/comment-cleanup-diff.md`.)
4. **Disclosure / authorship / PII: PASS (under the disclosure caliber then
   in force).** Author line `Aurora0134` consistent in both places
   (claim.tex `\author{}` and zenodo.json creators[0].name); no orcid key;
   the four disclosure elements then required were present; no machine-local
   user paths and no e-mail addresses in the whole tree. (Superseded on
   2026-10-07 by the minimal-disclosure caliber: the note now carries the
   fixed three-sentence disclosure, and the metadata carries no AI
   contributor entry.)
5. **c9-record.md verbatim consistency: PASS (at audit time).** The
   concatenation generator was re-run: Part 1 = lines 113–138 of the
   deep-dig draft card, Part 2 = lines 61–68 of the review-batch report;
   both parts were verbatim-identical to the then-shipped file. (The shipped
   file is now the English cleaned edition; see the version note.)
6. **Batch-specific clause (DOI-reserved wording, at audit time): PASS.** At
   audit time the package contained no concrete DOI number; the README used
   the reserved wording; no "already published" wording appeared as a fait
   accompli. (The deposit was published later the same day; the DOI backfill
   since then is recorded in `metadata/README.md`.)

## Observations (non-blocking; both disposed)

- **O1**: the claim.tex header comment's `lst:tail` range was off by one
  (735-768 → 735-767). **Fixed** (2026-10-06, comment level; no frozen
  artifact and no listing bytes touched).
- **O2**: the concatenation generator's header note was out of sync with the
  shipped c9-record.md. **Fixed** (generator re-run; the shipped file of
  that day = the generator's output, byte-reproducible at the time).

## Final ruling

**AUDIT PASS (five items + the batch-specific clause, zero findings).**
Grading cap: all of the note's claims are capped at "complete proof (kernel
level, the eight frozen statements) + no occupying record found (strong)";
neither wording cap is exceeded.

## 2026-10-07 cleanup addendum

- Package texts cleaned for publication under the minimal-disclosure caliber:
  the note's disclosure section replaced by the fixed three-sentence form
  (AI assistance + kernel verification + author responsibility; model name
  `kimi-k3` without prefixes); Lean comments/docstrings translated to
  English; audit documents translated and internal repository references
  generalized; metadata (zenodo.json) updated accordingly (no AI entry in
  contributors; no internal names in title/keywords/notes).
- Code regions of all Lean files unchanged (byte-identical to the frozen
  development; proof in `audit/comment-cleanup-diff.md`). All audit
  conclusions above stand unchanged. Since the audit date the deposit was
  published (concept DOI 10.5281/zenodo.23177003) and the note now cites the
  concept DOI; that backfill does not alter any audited claim.
