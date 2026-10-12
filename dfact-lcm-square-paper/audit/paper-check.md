# Claims audit verdict — papers/dfact-lcm-square

**Audited object**: `papers/dfact-lcm-square/` (the paper and its artifact
package).
**Audit date**: 2026-10-07. **Auditor role**: a separate read-only reviewer
(the final-audit role of the author's working process).
**Method**: full-item static review with independent recomputation — sha256
values, byte counts and line counts recomputed from the shipped files, the six
`lstlisting` bodies re-derived with an independent slicer (the package's own
verifier was read only afterwards, for cross-reference), the numeric
self-description blocks measured against the disk tree, and the whole deposit
tree swept by hand for the outbound-cleanliness criteria, including the
`.txt` / `.out` / `.json` / `.log` suffixes that the mechanical gates do not
scan. Two mechanical gates were re-run directly.

## Gate readings

| gate | command | exit | reading |
|---|---|---|---|
| static | `bash scripts/paper-lint.sh papers/dfact-lcm-square/paper.tex` | 0 | all static checks green |
| hard compile | `bash scripts/paper-compile.sh papers/dfact-lcm-square/paper.tex` | 0 | PDF written; zero "Missing character" |
| mechanical reconciliation | `python scripts/sanitize-package.py papers/dfact-lcm-square --no-manifest` | 0 | ALL GATES GREEN (gates 2, 3, 5, 6, 7 PASS; gate 1 and gate 4 SKIPPED) |

The wording is "both gates plus reconciliation green, gates 1 and 4 skipped" —
**not** "all six gates green".

## Item-by-item

1. **Anchors and grade — PASS.** The four `% LEAN:` anchor lines point at the
   source task, which exists; each declared name is at theorem position in the
   shipped final development; the grade field on all four is *complete proof*,
   matching the source task's grading and the independent final audit's verdict.
   No wording in the body or the Limitations exceeds "complete proof".
2. **Listing byte-exactness — PASS (independently recomputed).** All six
   listing bodies compare byte-identical to the shipped package sources under
   an independent slicing, and the deliverable-root copies equal the deposit-tree
   copies byte for byte.
3. **Numeric self-description closure — PASS.** Every fact-type figure in the
   prose files comes from a generated block or is registered in
   `audit/fact-exempt.txt`; both inventory blocks match the disk tree exactly,
   and the page-count block matches the compile log.
4. **Citation obligations — PASS.** Both mandatory citations are present and
   cited in the body; the Erd\H{o}s problem \#399 is written as disproved and
   used only as a same-family adjacency; the OEIS A055204 distinction is stated;
   the Brocard intersection is called a numerical coincidence; the
   interval-prime lemma is written as proved in the accompanying library
   development rather than cited from a published interval theorem, with the
   explicit "not an application of Nagura's bound" disclaimer; the $x = n\#$
   observation is written as a numerical observation, not a theorem; the first
   case $x^2 = n! \cdot n\#$ is not claimed and is attributed to the separate
   deposit.
5. **Mathematical content spot-check — PASS.** The three paper theorem
   statements correspond term by term to the shipped statement file. The
   witness squares, the quoted factorizations, the primorial-coincidence
   observation and the numerical scan range were recomputed independently and
   are exact. The interval-prime lemma was spot-checked numerically over
   $n \in [33, 50000]$ with no counterexample. The narrative proof structure
   matches the listing code: valuation criterion bridge, even arm via
   Bertrand's postulate, odd arm via the generic mechanism plus the
   interval-prime lemma, middle band closed by the six explicit witnesses,
   reverse direction by the witness layer. Limitations (a)–(j) each stand and
   none contradicts the upstream record.
6. **Disclosure section — PASS.** The fixed three sentences are present, the
   only model name is a bare wire-id segment with no channel prefix, resolution
   level or capture time, and the deposit metadata carries the account name as
   sole creator with no contributors entry.

## Findings from the first pass, and what changed

The first pass returned five findings, all on the disclosure and
self-description surface; none was a grade overstatement, a statement
tampering, a placeholder leak into a listing, or an external send. All were
fixed in the packaging step that produced the shipped state:

1. **Internal lane name on the deposited surface.** The novelty-search record
   shipped as `audit/c9-record.md`; the lane name is internal, and neither
   mechanical gate catches the lowercase form inside a path. The file now
   ships as `audit/novelty-record.md`, and every reference to it in the
   deposit tree was rewritten.
2. **Dispatch bookkeeping in the shipped verdict.** The independent verdict's
   auditor line and dependency qualification carried the audit lane's mission
   numbers, worktree name and branch name. Those bookkeeping tokens are
   rewritten in the shipped copy; the checks, their outcomes and the
   dependency qualification's content are unchanged, and the working-tree
   original keeps its bookkeeping.
3. **A self-description tighter than the fact.** The paper said the
   interval-prime lemma is "proved here"; it is proved in the accompanying
   library development and imported. The wording now says so where the lemma
   is described, and the formalisation-setup section names the two imported
   modules.
4. **A dependency a reader could not see.** The final development imports two
   library modules and neither ships. Their measured identity (bytes, lines,
   sha256) and the declaration consumed from each now ship as
   `audit/closure-manifest.txt`, and the paper's Limitations (b) and the
   deposit's Reproduction section both state the boundary.
5. **Raw console captures on the deposited surface.** The shipped
   `audit/compile-run.log` was the raw capture of the compile gate, whose
   leading banner carries the working language of the author's repository. It
   is replaced by an English record of the same run that also states where the
   raw capture lives.

## Verdict

**Zero findings** against the shipped state (after the first pass's five
findings were fixed and verified). The package may be packaged.

## Qualifications carried with this verdict

1. **A library dependency is inherited, not re-established.** The final
   development imports two modules that are not part of this deposit; each has
   its own separately checked final state. A reader who wants to re-verify the
   odd arm from this deposit alone must supply those modules — recorded in
   `audit/closure-manifest.txt`, in the paper's Limitations (b) and in the
   deposit's Reproduction section.
2. **Mechanical-gate coverage.** The outbound-cleanliness gate covers
   `$TEX + lstlean.tex + zenodo/proofs/*.lean + zenodo/audit/*.md` and does
   **not** cover `.txt` / `.out` / `.json` / `.log`. Those suffixes were
   swept by hand for this audit; any later re-packaging that adds such files
   needs the same manual sweep.
3. **Deliverable directory vs deposit tree.** The deliverable root carries the
   assembler, the skeleton, the independent verifiers and the raw gate captures;
   the deposit tree carries the packages and the evidence. Statements about
   "this package" are against the deposit tree.
4. **External sending.** This package is zero external-send: no deposit was
   prepared or published, no mirror was pushed and no submission was made on
   the author's behalf. `RESERVED-DOI` is an agreed placeholder, to be filled
   per `UPLOAD.md` section A.
5. **Machine-record wording.** The shipped gate records (`lint.txt`,
   `compile-run.log`) are English renderings of the same runs; the raw console
   output stays with the working record of the author's repository. The
   readings quoted are the run's own, and each record says so.
