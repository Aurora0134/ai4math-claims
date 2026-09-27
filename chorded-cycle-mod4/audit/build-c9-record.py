#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/chorded-cycle-mod4 (SOP 08b step 4):
a provenance header plus VERBATIM contiguous extracts of the C9 review record,
followed by a byte-exactness self-check of the extracted body.

Extracted from tasks/20260927-mossad-select/c9-recheck/chunk-G.md:
  lines 1-11     chunk header + anchor self-proof (defines what "zero hit" means)
  lines 86-109   the MAT-CCHORD section in full (the novelty evidence proper)
  lines 111-120  block summary + statistics (carries the C9 verdict roll-up)
  lines 121-122  the block-level channel-degradation memo, which names
                 MAT-CCHORD and requires a re-sweep of the grey zones when
                 OpenAlex recovers (SOP 08b finding O1: without it the shipped
                 record would omit a limitation that applies to this candidate)

AI-generated 2026-09-28. Read-only with respect to tasks/.
"""
import hashlib
import io
import os

ROOT = os.environ.get("AI4MATH_REPO", ".")
SRC = "tasks/20260927-mossad-select/c9-recheck/chunk-G.md"
OUT = "claims/chorded-cycle-mod4/zenodo/audit/c9-record.md"
RANGES = [(1, 11), (86, 109), (111, 120), (121, 122)]

HEADER = """> provenance note (added by the claim packager, 2026-09-28): this file is the full
> C9 novelty-review record for MAT-CCHORD (pool-mossad-04), copied VERBATIM and
> byte-for-byte in four contiguous line ranges from
> `tasks/20260927-mossad-select/c9-recheck/chunk-G.md` (source file sha256
> {src_sha}; {n_src} lines, LF):
>
>   lines 1-11     chunk header and the anchor self-proof that fixes what "zero
>                  hit" means on each channel
>   lines 86-109   the MAT-CCHORD entry in full (queries, independent
>                  recomputation, alias set, C9 verdict, value tier, entry
>                  conditions)
>   lines 111-120  the block roll-up table and query statistics for the chunk
>   lines 121-122  the block-level channel-degradation memo, which names
>                  MAT-CCHORD and requires a re-sweep of the grey zones once
>                  OpenAlex recovers
>
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses remain in the working repository under
> `tasks/20260927-mossad-select/` (kept in-repo, not shipped in this deposit).
> The exclusivity review was run by selection-department workers at 0 LLM calls;
> the C9 verdict carried into the claim note is "no occupying record found" at
> the value tier "new sequence / new recurrence".

"""

FOOTER = """
## appendix: extraction self-check

| range | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
{table}

Recompute with: `python claims/chorded-cycle-mod4/audit/build-c9-record.py --check`
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
