#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/grid3n-diag-2notch (SOP 08b step 4):
a provenance header plus VERBATIM contiguous extracts of the C9 review record,
followed by a byte-exactness self-check of the extracted body.

Extracted:
  part 1  tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md
          -- the WHOLE file, verbatim (the candidate's own adjudication record:
          section 0 verdict, section 2 spectrum judgement, section 6 disposition)
  part 2  tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md
          lines 131-137 -- the section 8 roll-up table of the three candidates
          (the shared evidence sections 0-7 and 9-10 stay in the source
          repository; the candidate record carries its own pointers to them)

No conclusion sentence is reworded. Raw query responses remain in the working
repository under tasks/20260928-comb0709-deeprecheck/ (kept in-repo, not shipped
in this deposit).

AI-generated 2026-09-28. Read-only with respect to tasks/.
"""
import hashlib
import io
import os

def _find_root(start):
    d = start
    while True:
        if os.path.isdir(os.path.join(d, "harness")) and os.path.isdir(os.path.join(d, "scripts")):
            return d
        p = os.path.dirname(d)
        if p == d:
            return None
        d = p


# Repository root: AI4MATH_REPO env var, else derived from this file's location
# (claims/<slug>/audit/ -> repo root), else the working directory. No machine-local
# path is hard-coded, so the frozen copy of this script ships clean.
ROOT = os.environ.get("AI4MATH_REPO") or _find_root(os.path.dirname(os.path.abspath(__file__))) or os.getcwd()
SRC1 = "tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md"
SRC2 = "tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md"
OUT = "claims/grid3n-diag-2notch/zenodo/audit/c9-record.md"
RANGE2 = (131, 137)   # section 8 roll-up table (inclusive)

HEADER = """> provenance note (added by the claim packager, 2026-09-28): this file is the
> full C9 novelty-review record for the candidate comb-07 (pool-comb-07, the
> two-defect 3xn grid matching count), copied VERBATIM and byte-for-byte:
> part 1 is the ENTIRE candidate record
> `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md`
> (source file sha256 {src1_sha}; {n1} lines, LF), and part 2 is the section 8
> roll-up table of the shared evidence record
> `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md`
> (source file sha256 {src2_sha}; {n2} lines, LF), lines {a2}-{b2} verbatim.
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses, the shared evidence sections and the
> enumeration scripts remain in the working repository under
> `tasks/20260928-comb0709-deeprecheck/` (kept in-repo, not shipped in this
> deposit). The exclusivity review ran at 0 llm-call; the C9 verdict carried
> into the claim note is "no occupying record found" (three consistent rounds)
> at the value tier "new sequence / new recurrence".

"""

SEP = """

---

## part 2 -- section 8 roll-up table, verbatim lines {a}-{b} of `{src2}`

"""

FOOTER = """

## appendix: extraction self-check

| part | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
{table}

Recompute with: `python claims/grid3n-diag-2notch/audit/build-c9-record.py --check`
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
    ls1 = lines_of(SRC1)
    if ls1 and ls1[-1] == "":
        ls1 = ls1[:-1]          # trailing newline is not a line
    part1 = "\n".join(ls1)
    ls2 = lines_of(SRC2)
    if ls2 and ls2[-1] == "":
        ls2 = ls2[:-1]
    a, b = RANGE2
    part2 = "\n".join(ls2[a - 1:b])
    return part1, len(ls1), part2, len(ls2)


def build():
    part1, n1, part2, n2 = body()
    a, b = RANGE2
    table = "\n".join(
        "| %d | %s | %d | %s |" % (i + 1, rng, len(p.encode("utf-8")),
                                   hashlib.sha256(p.encode("utf-8")).hexdigest()[:16])
        for i, (rng, p) in enumerate([
            ("1-whole file", part1),
            ("%d-%d" % (a, b), part2)]))
    text = (HEADER.format(src1_sha=sha_file(SRC1), src2_sha=sha_file(SRC2),
                          n1=n1, n2=n2, a2=a, b2=b)
            + "## part 1 -- candidate record, verbatim whole file `" + SRC1 + "`\n\n"
            + part1
            + SEP.format(a=a, b=b, src2=SRC2)
            + part2
            + FOOTER.format(table=table))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("wrote %s (%d bytes)" % (OUT, len(text.encode("utf-8"))))
    return part1, part2


def check():
    part1, part2 = body()[0], body()[2]
    out = os.path.join(ROOT, OUT)
    text = open(out, encoding="utf-8").read()
    ok = True
    for name, p in (("part 1 whole file", part1), ("part 2 section 8", part2)):
        present = p in text
        print("%s %s (%d bytes)" % ("PASS" if present else "FAIL", name,
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
