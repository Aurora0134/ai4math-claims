#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/grid3n-sidemid-notch (SOP 08b step 4):
a provenance header plus VERBATIM copies of the C9 review record, followed by a
byte-exactness self-check of the copied bodies.

Sources (both read-only, under tasks/):
  SRC1 tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-02.md
       the comb-08 (pool-comb-08) third-round deep-review verdict record, copied
       as a WHOLE FILE (every line, byte-for-byte; nothing dropped, nothing
       reworded -- its conclusions are the novelty evidence of this deposit).
  SRC2 tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md
       the shared evidence record of the same review; the excerpt shipped here
       is the section 8 roll-up table (lines 131-137), which carries the
       three-candidate verdict summary including the comb-08 row.

Only the provenance header and the closing self-check appendix are added by the
packager; the record bodies are unmodified.

AI-generated 2026-09-28. Read-only with respect to tasks/.
"""
import hashlib
import io
import os

ROOT = os.environ.get("AI4MATH_REPO", ".")
SRC1 = "tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-02.md"
SRC2 = "tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md"
OUT = "claims/grid3n-sidemid-notch/zenodo/audit/c9-record.md"
# (source, first line, last line or None for whole file, description)
RANGES = [
    (SRC1, None, None,
     "the comb-08 (pool-comb-08) third-round deep-review verdict record, "
     "copied as a whole file (all lines, verbatim)"),
    (SRC2, 131, 137,
     "the shared-evidence record, section 8 roll-up table (the three-candidate "
     "verdict summary; the comb-08 row carries the corrected value tier)"),
]

HEADER = """> provenance note (added by the claim packager, 2026-09-28): this file is the
> C9 novelty-review record for the claim of this deposit (candidate comb-08,
> pool-comb-08; source task tasks/20260928-comb08-sidemid), copied VERBATIM and
> byte-for-byte from the pipeline's third-round deep exclusivity review:
>
>   source 1: `{src1}` ({n1} lines, LF) -- sha256 {sha1}
>             copied as a whole file
>   source 2: `{src2}` ({n2} lines, LF) -- sha256 {sha2}
>             excerpt: lines {a2}-{b2} (section 8 roll-up table)
>
> Nothing else was added; the record bodies are unmodified and their conclusions
> are not reworded. Raw query responses remain in the working repository under
> `tasks/20260928-comb0709-deeprecheck/recheck/` (kept in-repo, not shipped in
> this deposit). The exclusivity review was run by selection-department workers
> at 0 LLM calls; the C9 verdict carried into the claim note is "no occupying
> record found" (three rounds consistent) at the corrected value tier "new
> sequence" (the recurrence is not new -- same spectrum as A033506).

"""

FOOTER = """
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
{table}

Recompute with: `python claims/grid3n-sidemid-notch/audit/build-c9-record.py --check`
"""


def lines_of(rel):
    with io.open(os.path.join(ROOT, rel), "r", encoding="utf-8", newline="") as fh:
        data = fh.read()
    assert "\r" not in data, "unexpected CR in source"
    return data.split("\n")


def sha_file(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def n_lines(ls):
    if ls and ls[-1] == "":
        return len(ls) - 1          # trailing newline is not a line
    return len(ls)


def body():
    parts = []
    for rel, a, b, _desc in RANGES:
        ls = lines_of(rel)
        if ls and ls[-1] == "":
            ls = ls[:-1]
        if a is None:
            parts.append(("\n".join(ls), rel, "whole file (%d lines)" % len(ls)))
        else:
            parts.append(("\n".join(ls[a - 1:b]), rel, "lines %d-%d" % (a, b)))
    return parts


def build():
    parts = body()
    ls2 = lines_of(SRC2)
    table = "\n".join(
        "| %d | `%s` | %s | %d | %s |" % (
            i + 1, rel, span, len(p.encode("utf-8")),
            hashlib.sha256(p.encode("utf-8")).hexdigest()[:16])
        for i, (p, rel, span) in enumerate(parts))
    text = (HEADER.format(src1=SRC1, n1=n_lines(lines_of(SRC1)),
                          sha1=sha_file(SRC1),
                          src2=SRC2, n2=n_lines(ls2),
                          sha2=sha_file(SRC2),
                          a2=RANGES[1][1], b2=RANGES[1][2])
            + "\n\n".join(p for p, _rel, _span in parts) + FOOTER.format(table=table))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("wrote %s (%d bytes)" % (OUT, len(text.encode("utf-8"))))
    return parts


def check():
    parts = body()
    out = os.path.join(ROOT, OUT)
    text = open(out, encoding="utf-8").read()
    ok = True
    for (p, rel, span) in parts:
        present = p in text
        print("%s %s %s (%d bytes)" % ("PASS" if present else "FAIL", rel, span,
                                       len(p.encode("utf-8"))))
        ok = ok and present
    print("source sha256 %s = %s" % (SRC1, sha_file(SRC1)))
    print("source sha256 %s = %s" % (SRC2, sha_file(SRC2)))
    return 0 if ok else 1


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "--check":
        raise SystemExit(check())
    build()
    raise SystemExit(check())
