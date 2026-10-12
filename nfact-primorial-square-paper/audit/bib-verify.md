# bib-verify.md — bibliography existence checks (assembly track, 2026-10-06)

Every bibliography entry of `paper.tex` was re-checked live before inclusion
(the re-run script lives in the deliverable directory of the source
repository, not shipped). Method per entry below; "read-back" means the named
field was read back from the live response and matched the entry. The
criterion is the read-back field, not the HTTP status. No entry is quoted
from memory.

> **2026-10-07 version note.** This is the English cleaned edition of the
> record; the checks and their outcomes are unchanged. The `claimdeposit`
> row's read-back title is shown as the deposit's current title: the
> companion deposit's title was shortened on 2026-10-07 (its v1.0.2,
> disclosure cleanup); the 2026-10-06 read-back confirmed the same resolution
> fact — the DOI resolves to the companion claim deposit.

| key | identifier | channel | read-back |
|---|---|---|---|
| lean4 | DOI 10.1007/978-3-030-79876-5_37 | Crossref API | title "The Lean 4 Theorem Prover and Programming Language", pp. 625-635 |
| mathlib | DOI 10.1145/3372885.3373824 | Crossref API | title "The lean mathematical library", pp. 367-381 |
| nagura1952 | DOI 10.3792/pja/1195570997 | Crossref API | title "On the interval containing at least one prime number", pp. ? |
| novakovic2026 | arXiv:2601.16757 | arxiv.org abs page meta | citation_title "The Diophantine equation $P(x)=\overset{r}{\underset{i=1}{\prod}}H_{n_i}$", date 2026/01/23 |
| novakovic2026b | arXiv:2602.09687 | arxiv.org abs page meta | citation_title "On a generalization of the Brocard--Ramanujan Diophantine equation", date 2026/02/10 |
| peixoto2026 | arXiv:2606.23485 | arxiv.org abs page meta | citation_title "The Brocard Problem: Structural Invariants, p-Adic Density, and the Generative Sieve", date 2026/06/22 |
| yudin2026 | arXiv:2610.01899 | arxiv.org abs page meta | citation_title "Square products of factorials and a conjecture of Erd\H{o}s and Graham", date 2026/10/01 |
| erdos399 | erdosproblems.com/399 | live page | reachable; status widget reads DISPROVED |
| oeisA055204 | OEIS A055204 | OEIS API | name "Squarefree part of n!: n! divided by its largest square divisor." |
| oeisA166968 | OEIS A166968 | OEIS API | name "Minimum k such that for all m >= k there is a prime p with m < p < m * (n+1)/n." |
| claimdeposit | DOI 10.5281/zenodo.23177003 | doi.org resolve | title "Priority claim: complete solution set of x^2 = n! * n# (exactly n in {0,...,5}) — Lean 4 formalized proof + claim note | Zenodo" (current title; see the version note) |

Notes:
- The arXiv MCP retrieval channel was not used; the four arXiv items were
  verified by direct HTTPS fetch of the abs pages, reading the citation
  metadata fields (same fallback as the companion claim package, recorded
  2026-10-06).
- Nagura 1952: existence and bibliographic data verified via Crossref/Project
  Euclid metadata; the original text was not obtained -- its statement is cited
  as corroborated by several OEIS entries (see the paper's related-work section).
- The J1 quotation (Novakovic's we-were-not-able sentence) was additionally
  re-checked verbatim against the archived raw text extraction of
  arXiv:2601.16757 (source task records, held in the source repository and
  not shipped).
