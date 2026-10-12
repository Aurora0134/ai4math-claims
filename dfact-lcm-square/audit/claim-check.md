# Claim audit — verdict (final audit procedure, simplified claims audit)

**Audited object**: `claims/dfact-lcm-square/`
**Audit date**: 2026-10-07. **Auditor role**: the audit department (read-only).
**Method**: full-item static review with independent recomputation (sha256,
byte counts and line counts recomputed digit by digit, byte-for-byte diff, Lean
comment-stripped code-view comparison, generated-block reverse check, exemption
table hit test), plus two mechanical gates run directly. Two review passes were run: the
first returned nine findings, all fixed in the packaging step; the second
returned two (one fixed, one logged as a harness-side item). This file records
the conclusion after the first pass's fixes were verified.

## Gate readings

| gate | command | exit | reading |
|---|---|---|---|
| static | `bash scripts/paper-lint.sh claims/dfact-lcm-square/claim.tex` | 0 | `PASS: paper-lint all green` |
| mechanical reconciliation | `python scripts/sanitize-package.py claims/dfact-lcm-square` | 0 | `ALL GATES GREEN`; gates 2,3,5,6,7 PASS, **gate 4 SKIPPED**; 0 red items |

The wording is "both gates green, gate 4 skipped" — **not** "all six gates
green".

## Item-by-item (all PASS)

1. **Anchor check.** The three `% LEAN:` anchor lines point at the source task.
   The source sha256 values were recomputed independently and all match:
   frozen statement `81e7f2cb…`, statement source `9baa672f…`, final file
   `1107cad4…`. Grade = complete proof (the independent final audit's verdict);
   the verdict file ships in `audit/`.
2. **Wording strength.** No over-reaching wording (no "first", "novel", "new
   result", "breakthrough"). The `Scope and limitations` section discloses the
   three boundaries: the interval-prime lemma is proved here rather than taken
   from a published interval theorem; `x = n#` is a numerical observation, not a
   formalized theorem; the intersection `{5,7}` with the Brocard solutions is a
   numerical coincidence.
3. **Listing byte-exactness.** Block 1 = 642 bytes, sha256 prefix
   `b33137b252c4d4a1`; block 2 = 245 bytes, `da53a72e2190d938`. Both match the
   corresponding line ranges of the shipped final file character for character.
4. **Identifier reality.** All twelve theorem names exist in the shipped final
   file; the four `DFactLcmSquare.*` axiom lines quoted in the note match
   `audit/axioms.out` character for character.
5. **Disclosure section.** The three-sentence fixed form is present (AI
   assistance, kernel final check, author responsibility); the model name is
   `kimi-k3` with no channel prefix, no resolution level and no capture time;
   the author line is the account name; the metadata carries no `contributors`
   entry; the whole note contains no mechanism self-description.
6. **In-package cleanliness.** A manual sweep of every text file in `zenodo/`
   (including the `.txt` / `.out` / `.json` / `.log` suffixes, which the
   mechanical gates do not scan) found: 4 CJK lines = the three `% LEAN:` anchor
   lines (the gates' only exemption) plus the manifest header; zero mechanism
   words; zero machine-local absolute paths.
7. **Novelty-record faithfulness.** The shipped record is byte-identical to its
   translation source. The Chinese-language query string is given as its code
   units and decodes without loss (10 CJK code units plus 2 spaces). Two wording
   corrections ("the accompanying library", "UTF-16 code units") are corrections
   of the source's own labels, not alterations of data.
8. **Citation reality.** All 9 bibliography entries correspond to the
   verification record; the two mandatory citations are present.
9. **Package structure.** The three inventories (FILE-MANIFEST, the README
   inventory block, the package-notes inventory block) agree with each other and
   with the disk; the `zenodo/claim/` mirror is byte-identical to the
   deliverable root; the two shipped `.lean` files have a comment-stripped code
   view byte-identical to their sources, with line numbers preserved. The file
   counts are given by the generated inventory blocks, not restated here.
10. **Upload-list consistency.** All 25 checklist items are unticked; no
    completed action is claimed anywhere.

## Verdict

**Zero findings** (after the round-1 fixes were verified; the round-2 finding
D-1 was fixed by shipping the lint record and re-rendering the generated blocks,
and D-2 is logged as a harness-side item, not a package defect). The package may
be packaged.

## Qualifications carried with this verdict

1. **Scaffolding qualification.** The "complete proof" grade here is a real
   proof: 12 theorems, 0 `sorry`, axiom set exactly on the whitelist, statements
   identical to the frozen file declaration by declaration. No scaffolding grade
   is involved.
2. **Mechanical-gate wording.** "paper-lint PASS (exit 0) + sanitize-package ALL
   GATES GREEN (exit 0, 0 red, gate 4 SKIPPED)" — **not** "all six gates green".
3. **Gate-coverage disclosure.** Neither mechanical gate scans
   `.txt` / `.out` / `.json` / `.log` files, and the containment check does not
   cover the "this package's `X`" phrasing. The in-package cleanliness
   conclusion above is therefore a **manual sweep**, not a machine-green. This
   is logged as a harness-side item; this package does not claim machine
   evidence for that layer.
4. **Shipped vs. source-repository boundary.** Four kinds of process files (the
   axiom probe, the statement comparison script, the two perturbation probes,
   the numerical recomputation script) do **not** ship; their load-bearing
   outputs are quoted verbatim in `audit/independent-verdict.txt`. The absence
   of the original process files is not a break in the evidence chain.
5. **External-sending qualification.** This package is zero external-send:
   Zenodo publish, mirror push, arXiv and OEIS submission are all the author's
   own actions, and none of the 25 steps in `UPLOAD.md` was carried out on the
   author's behalf. `RESERVED-DOI` is an agreed placeholder, to be filled per
   `UPLOAD.md` section 1.

## Addendum (2026-10-07, second audit round — disclosure and dependency surface)

A second audit round was run against the same package after the first round's
fixes. It returned five findings, all fixed in this packaging step; the
conclusions and data of the verdict above are unchanged, and this addendum
records what changed so the verdict stays readable against the shipped state.

1. **Internal lane name on the external surface (fixed).** The novelty-search
   record shipped as `audit/c9-record.md`; the lane name is internal, and the
   outbound gate's word list does not catch the lowercase form inside a path.
   The file now ships as `audit/novelty-record.md`, and every reference to it in
   the deposit tree was rewritten.
2. **Dispatch bookkeeping in the shipped verdict (fixed).** The independent
   verdict carried the audit lane's mission number, worktree name and branch
   name in its auditor line, and two mission numbers in its dependency
   qualification. Those four tokens are rewritten in the shipped copy; the
   checks and their outcomes, including the dependency qualification's content,
   are unchanged, and the working-tree original keeps its bookkeeping.
3. **A self-description that was tighter than the fact (fixed).** The claim
   note said the interval-prime lemma is "proved here"; it is proved in the
   accompanying library development and imported. The wording now says so in
   both places where the lemma is described, and the deposit's Reproduction
   section states that a kernel compile of the shipped final file needs those
   two library modules beside it.
4. **A library dependency a reader could not see (fixed).** The final
   development imports two library modules; neither ships. Their measured
   identity (bytes, lines, sha256) and the declaration consumed from each now
   ship as `audit/closure-manifest.txt`.
5. **A raw console capture carrying the working-language banner (fixed).** The
   shipped `audit/compile-run.log` was the raw capture of the compile gate. It
   is replaced by an English record of the same run (exit 0, no missing
   character, only hbox and deprecation warnings), which also states that the
   raw capture stays in the working repository.

The compiled page count and the inventory block in `metadata/README.md` were
re-measured after these edits, and the static gate and the hard compile were
re-run green before packaging.
