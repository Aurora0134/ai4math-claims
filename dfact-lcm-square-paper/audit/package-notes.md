# Package self-description: what this package contains (and deliberately omits)

This note is written before packaging (not as an afterthought).

## What this package is

Artifact package accompanying the paper "The Diophantine equation
x^2 = n!! * lcm(1..n): the complete solution set, formalized and
machine-checked in Lean 4" — the complete solution set of `x^2 = n!! *
lcm(1..n)` (double factorial times least common multiple) over the naturals:
exactly `n ∈ {0,1,2,5,7}` (with `x = 1,1,2,30,210`), grading = complete proof.
Contents: the paper (LaTeX source + PDF), the Lean 4 proof sources (statement
source + frozen statement snapshot + final development + toolchain pin), and
the verification evidence (independent final adjudication, axiom printout,
listing and named-identifier verification, bibliography verification, compile
and static-gate logs, roundtrip fidelity record, novelty-search record, import
closure manifest). A
companion priority claim of record for the same kernel result is deposited
separately and is cited in the paper.

## Package structure (generated block: per-file byte counts measured, paths relative to `zenodo/`)

<!-- FACTS-BEGIN inv scope=deposit -->
@row     1523  audit/axioms.out
@row     1914  audit/bib-verify.md
@row     2225  audit/clean-copy-reverify.md
@row     1097  audit/closure-manifest.txt
@row     1419  audit/comment-elision-record.md
@row     1460  audit/compile-run.log
@row    12934  audit/independent-verdict.txt
@row      615  audit/lean-idents.txt
@row     2090  audit/lint.txt
@row      561  audit/listing-verify.txt
@row    13026  audit/novelty-record.md
@row     5238  audit/package-notes.md
@row     7966  audit/paper-check.md
@row     4872  audit/statement-faithful.md
@row      364  audit/strict-compile.txt
@row     7596  metadata/README.md
@row     3054  metadata/zenodo.json
@row     7624  paper/lstlean.tex
@row   130690  paper/paper.pdf
@row    37960  paper/paper.tex
@row     2364  proofs/dfact-lcm-square.statement.lean
@row    17380  proofs/final-dfact-lcm-square.lean
@row       25  proofs/lean-toolchain
<!-- FACTS-END -->

## What this package deliberately omits

- The two imported library modules, which is the one dependency a reader must
  supply for themselves. The final development imports them: the interval-prime
  lemma for `n ≥ 33` (used by the odd exclusion arm) and one bridge used by the
  witness layer. Their measured identity and the declaration consumed from each
  ship as `audit/closure-manifest.txt`; the modules themselves do not, because
  each is a separate development of the same grade with its own final state.
  The paper's formalisation-setup and Limitations sections state the boundary,
  and the deposit's Reproduction section repeats it. This is the honest limit
  of "re-verify from the deposit alone": the frozen statements of Listing 1 and
  the shipped final development are complete, but a kernel compile needs those
  two modules beside them.
- The source-repository process files (the statement comparison script, the two
  solution-set perturbation probes, the numerical recomputation script, the
  axiom probe source). Their load-bearing outputs are quoted verbatim in
  `audit/independent-verdict.txt` and `audit/axioms.out`; the absence of the
  original process files is not a break in the evidence chain.
- The upload checklist and the batch card. Both live in the source repository
  and are not shipped.
- A DOI for the companion claim deposit. The paper cites the deposit and carries
  the agreed placeholder in its Data availability section; the DOI is filled in
  at upload time.

## Comment cleaning (what was changed in the shipped `.lean` files)

The two shipped `.lean` files are copies in which every comment span carrying
pre-publication workflow narrative was blanked, with line numbers preserved.
Code bytes — statements and proof terms — were never touched. Per file, the
comment-free code view of the source and of the shipped copy are byte-for-byte
equal, asserted by the generating script (record:
`audit/comment-elision-record.md`). The compile and axiom records shipped in
`audit/` were produced from the sources in their original, unblanked form; the
post-cleanup re-verification ships as `audit/clean-copy-reverify.md`.

## Rendering note (paper source)

`paper/paper.tex` carries, at its top, an active-character patch for XeTeX:
tectonic/XeLaTeX does not apply the listings package's `literate` table to
multi-byte characters, so each non-ASCII, non-CJK codepoint that occurs in this
paper's listings is mapped to a math glyph as an active character. The patch is
guarded by `\ifdefined\XeTeXversion`, so the pdflatex path is unchanged, and it
changes rendering only — the listing source bytes are untouched, so the
byte-exactness checks in `audit/listing-verify.txt` are unaffected.

## Static and mechanical gate readings

The paper passed the packaging track's static gate (all checks green, exit 0)
and compiled with exit 0 under tectonic/XeLaTeX, with no missing-character
warnings; the shipping logs are `audit/lint.txt` and
`audit/compile-run.log`. The package is zero external-send: no deposit was
prepared or published, and no submission was made on the author's behalf.
