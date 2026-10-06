# bib-verify.md — bibliography existence checks (assembly track, 2026-10-06)

Every bibliography entry of `claim/claim.tex` was re-checked live before
inclusion. Method per entry below; "read-back" means the named field was read
back from the live response and matched the entry. No entry is quoted from
memory.

| key | identifier | channel | read-back |
|---|---|---|---|
| lean4 | DOI 10.1007/978-3-030-79876-5_37 | Crossref API | title "The Lean 4 Theorem Prover and Programming Language", pp. 625-635 |
| mathlib | DOI 10.1145/3372885.3373824 | Crossref API | title "The lean mathematical library", pp. 367-381 |
| novakovic2026 | arXiv:2601.16757 | arxiv.org abs page meta | citation_title "The Diophantine equation P(x)=...", author Novaković, date 2026/01/23 |
| novakovic2026b | arXiv:2602.09687 | arxiv.org abs page meta | citation_title "On a generalization of the Brocard--Ramanujan Diophantine equation", date 2026/02/10 |
| peixoto2026 | arXiv:2606.23485 | arxiv.org abs page meta | citation_title "The Brocard Problem: Structural Invariants, p-Adic Density, and the Generative Sieve", date 2026/06/22 |
| yudin2026 | arXiv:2610.01899 | arxiv.org abs page meta | citation_title "Square products of factorials and a conjecture of Erdős and Graham", author Yudin, date 2026/10/01 |
| erdos399 | erdosproblems.com/399 | live page | reachable; status widget reads DISPROVED |
| oeisA055204 | OEIS A055204 | OEIS API | name "Squarefree part of n!: n! divided by its largest square divisor." |
| oeisA166968 | OEIS A166968 | OEIS API | name "Minimum k such that for all m >= k there is a prime p with m < p < m * (n+1)/n." |

Notes:
- The pipeline's arxiv-mcp channel was unreachable at assembly time (port
  parse error); the four arXiv items were verified by direct HTTPS fetch of
  the abs pages instead, reading the citation metadata fields.
- The J1 quotation inside the note (Novaković's we-were-not-able sentence) was
  additionally re-checked verbatim against the pipeline's archived raw text
  extraction of the paper (source task records, not shipped).
