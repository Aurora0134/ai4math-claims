# Bibliography verification record

Every `\bibitem` in the two deposit packages was verified against the arXiv API
(`https://export.arxiv.org/api/query?id_list=<id>`) on 2026-10-07. Titles below are
the API's own title strings; authors and dates are the API's `published` values.
The retrieval was made with `--resolve export.arxiv.org:443:146.75.47.42` because the
local resolver returns a loopback address for this host.

| key | arXiv id | title (API, verbatim) | authors | published |
|---|---|---|---|---|
| novakovic2026 | 2601.16757 | The Diophantine equation $P(x)=\overset{r}{\underset{i=1}{\prod}}H_{n_i}$ | Saša Novaković | 2026-01-23 |
| novakovic2025 | 2510.24312 | Diophantine equations involving double factorials | Saša Novaković | 2025-10-28 |
| novakovic2026b | 2602.09687 | On a generalization of the Brocard--Ramanujan Diophantine equation | Saša Novaković | 2026-02-10 |
| novakovic2026c | 2602.23838 | Products of factorials which are products of factorials | Saša Novaković | 2026-02-27 |
| novakovic2026d | 2604.09730 | A comment on the equation $n!!=a_1!!\cdots a_t!!$ | Saša Novaković | 2026-04-09 |
| yudin2026 | 2610.01899 | Square products of factorials and a conjecture of Erdős and Graham | Fedir Yudin | 2026-10-01 |
| peixoto2026 | 2606.23485 | The Brocard Problem: Structural Invariants, p-Adic Density, and the Generative Sieve | Leandro Vieira Peixoto | 2026-06-22 |

Two further items are the standard Lean/mathlib citations, already present in the
sources the author's packages are generated from; their DOIs were verified when
those sources were adopted, and are re-verified here:

| key | item |
|---|---|
| lean4 | L. de Moura and S. Ullrich, *The Lean 4 theorem prover and programming language*, CADE-28, 2021, doi:10.1007/978-3-030-79876-5_37 |
| mathlib | The mathlib Community, *The Lean mathematical library*, CPP 2020, 2020, doi:10.1145/3372885.3373824 |
