#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/pendant-ladder-interleave
(SOP 08b step 4): a provenance header plus VERBATIM contiguous extracts of the
C9 review record, followed by a byte-exactness self-check of the extracted body.
Adapted from claims/chorded-cycle-mod4/audit/build-c9-record.py.

Extracted from tasks/20260927-mossad-select/c9-recheck/chunk-F.md:
  lines 1-6      chunk header + query discipline + access channel
  lines 8-13     anchor self-proof (defines what "zero hit" means)
  lines 17-94    the MAT-PEND section in full (the novelty evidence proper,
                 including the 11+6 OEIS variant queries and the A386889
                 occupancy verification)
  lines 213-225  block roll-up table, query statistics, the grey-zone memo that
                 names MAT-PEND, and the chunk budget line

AI-generated 2026-09-28. Read-only with respect to tasks/.
"""
import hashlib
import io
import os

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
SRC = "tasks/20260927-mossad-select/c9-recheck/chunk-F.md"
OUT = "claims/pendant-ladder-interleave/zenodo/audit/c9-record.md"
RANGES = [(1, 6), (8, 13), (17, 94), (213, 225)]

HEADER = """> provenance note (added by the claim packager, 2026-09-28): this file is the
> full C9 novelty-review record for MAT-PEND (pool-mossad-01), copied VERBATIM
> and byte-for-byte in four contiguous line ranges from
> `tasks/20260927-mossad-select/c9-recheck/chunk-F.md` (source file sha256
> {src_sha}; {n_src} lines, LF):
>
>   lines 1-6      chunk header, query discipline and access channel
>   lines 8-13     the anchor self-proof that fixes what "zero hit" means
>   lines 17-94    the MAT-PEND entry in full: independent recomputation, the
>                  11 main-sequence + 6 odd-subsequence + 6 even-subsequence
>                  OEIS variant queries, the A386889 single-entry verification,
>                  literature/library/Lean-ecosystem layers, alias set, C9
>                  verdict, value tier, pool recommendation
>   lines 213-225  the block roll-up table, query statistics, the grey-zone
>                  memo that names MAT-PEND, and the chunk budget line
>
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses remain in the working repository under
> `tasks/20260927-mossad-select/` (kept in-repo, not shipped in this deposit).
> The exclusivity review was run by selection-department workers at 0 LLM calls.
>
> Packager's correction pointer (not part of the record body): the
> alternating-attachment invariance stated at source line 27 of the record
> (observed on the first-8 window) was later REFUTED by the task's Phase 0:
> alternating and uniform-side attachments differ from n=3 on
> (3,10,47,143,... vs 3,10,46,141,...; three independent methods agree, and the
> pool card was corrected accordingly). The combinatorial reading in the claim
> note is therefore fixed to the uniform-side convention. The refutation record
> lives in `tasks/20260927-mossad-pend/phase0/` and the task report; the record
> body below is left exactly as the review wrote it.
>
> The C9 verdict carried into the claim note is: no occupying record found for
> the main sequence; the odd-position subsequence is ALREADY OCCUPIED (OEIS
> A386889, Dresden and Demirkol, 2025-09-04); value tier "new sequence / new
> recurrence" with an occupancy warning.

"""

FOOTER = """
## appendix: extraction self-check

| range | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
{table}

Recompute with: `python claims/pendant-ladder-interleave/audit/build-c9-record.py --check`
"""


def lines_of(rel):
    with io.open(os.path.join(ROOT, rel), "r", encoding="utf-8", newline="") as fh:
        data = fh.read()
    assert "\r" not in data, "unexpected CR in source"
    return data.split("\n")


def sha_file(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def body():
    ls = lines_of(SRC)
    if ls and ls[-1] == "":
        ls = ls[:-1]          # trailing newline is not a line
    parts = []
    for a, b in RANGES:
        parts.append("\n".join(ls[a - 1:b]))
    return parts, len(ls)


def build():
    parts, n_src = body()
    table = "\n".join(
        "| %d | %d-%d | %d | %s |" % (i + 1, a, b, len(p.encode("utf-8")),
                                      hashlib.sha256(p.encode("utf-8")).hexdigest()[:16])
        for i, ((a, b), p) in enumerate(zip(RANGES, parts)))
    text = (HEADER.format(src_sha=sha_file(SRC), n_src=n_src)
            + "\n\n".join(parts) + FOOTER.format(table=table))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("wrote %s (%d bytes)" % (OUT, len(text.encode("utf-8"))))
    return parts


def check():
    parts, _ = body()
    out = os.path.join(ROOT, OUT)
    text = open(out, encoding="utf-8").read()
    ok = True
    for (a, b), p in zip(RANGES, parts):
        present = p in text
        print("%s range %d-%d (%d bytes)" % ("PASS" if present else "FAIL", a, b,
                                             len(p.encode("utf-8"))))
        ok = ok and present
    print("source sha256 %s = %s" % (SRC, sha_file(SRC)))
    return 0 if ok else 1


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "--check":
        raise SystemExit(check())
    build()
    raise SystemExit(check())
