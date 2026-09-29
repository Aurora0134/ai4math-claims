#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/ladder-pend3-interleave
(SOP 08b step 4): a provenance header plus VERBATIM contiguous extracts of the
C9 novelty-review records, followed by a byte-exactness self-check of the
extracted body. Adapted from claims/hosoya-split-identity/audit/build-c9-record.py.

This claim has TWO source records (both required by the packager's check list;
neither is reworded; both are extracted in full):

1. tasks/20260927-mapselect-01/c9/combm-04-ladder-pend3.md (170 lines): the
   proposition-level C9 full review (first review) - six channels (OEIS 25
   query strings incl. prefix variants, transforms, the three mod-3
   subsequences, recurrence/characteristic-polynomial strings; arXiv; zbMATH;
   OpenAlex; MSE; WebSearch; local mathlib/compfiles/sequencelib layers) with
   positive controls and the single-entry reads of A030186 / A102435 /
   A102436 / A286945 / A386889; verdict = no occupying record found; value
   tier = new sequence / new recurrence.

2. tasks/20260927-mapselect-01/c9/recheck-combm-04-ladder-pend3.md (135
   lines): the exclusivity second review (red team, different query methods):
   an independent fourth matching-count implementation (structurally distinct
   column-transfer enumeration, 39/39 agreement), shifted-prefix/mid/deep/tail
   windows, subsequence late windows, MSE in-site direct search, MathOverflow,
   zbMATH record read of Farrell 1978 (an:0414.05042), OEIS reverse
   cross-reference hunting (A386889 has no reverse references; the A030186
   citing family has no period-3 member), Chinese-layer sweeps; verdict =
   supports the first review (no occupying record).

AI-generated 2026-09-29. Read-only with respect to tasks/.
"""
import hashlib
import io
import os
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
SOURCES = [
    ("tasks/20260927-mapselect-01/c9/combm-04-ladder-pend3.md",
     [(1, 170)],
     "first review (proposition-level C9, mapselect-01): six-channel query "
     "tables with positive controls and single-entry reads; verdict = no "
     "occupying record found; value tier = new sequence / new recurrence"),
    ("tasks/20260927-mapselect-01/c9/recheck-combm-04-ladder-pend3.md",
     [(1, 135)],
     "second review (exclusivity red team): independent fourth counting "
     "implementation, shifted/deep/tail windows, MSE in-site + MathOverflow + "
     "zbMATH record read, OEIS reverse cross-reference hunting; verdict = "
     "supports the first review"),
]
OUT = "claims/ladder-pend3-interleave/zenodo/audit/c9-record.md"


def lines_of(rel):
    with io.open(os.path.join(ROOT, rel), "r", encoding="utf-8", newline="") as fh:
        data = fh.read()
    assert "\r" not in data, "unexpected CR in source"
    return data.split("\n")


def sha_file(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def collect():
    blocks_all = []
    for rel, ranges, _ in SOURCES:
        ls = lines_of(rel)
        if ls and ls[-1] == "":
            ls = ls[:-1]
        parts = []
        for a, b in ranges:
            parts.append((a, b, "\n".join(ls[a - 1:b])))
        blocks_all.append((rel, len(ls), parts))
    return blocks_all


HEADER = """> provenance note (added by the claim packager, 2026-09-29): this file is the
> full C9 novelty-review record for the matching count sequence of the
> period-3 pendant ladder (pool-comb-10: the ladder graph P_n x K_2 with one
> pendant leaf attached to the upper-rail vertex of every column 3k+1), copied
> VERBATIM and byte-for-byte in contiguous line ranges from two records of
> the working repository:
>
>   1. `{src1}` ({n1} lines, sha256 {s1})
>      ranges {r1}: the proposition-level first review - alias set,
>      channel/anchor self-proofs, OEIS numeric tables (prefix variants,
>      x2/+1/-1 transforms, the three mod-3 subsequences in three window
>      forms each, recurrence/generating-function/characteristic-polynomial
>      strings in two typings), OEIS keyword tables, family single-entry
>      reads (A030186 plain ladder, A102435/A102436 corona, A286945 maximal
>      matchings, A386889 period-2 pendant), literature layer (arXiv /
>      zbMATH / OpenAlex / MSE / WebSearch), library layer (mathlib rg,
>      compfiles, sequencelib tree), verdict = no occupying record found,
>      value tier = new sequence / new recurrence.
>   2. `{src2}` ({n2} lines, sha256 {s2})
>      ranges {r2}: the exclusivity second review (red team; query methods
>      deliberately NOT reused from the first review) - independent fourth
>      matching-count implementation (39/39 agreement with the deep-fit
>      log), shifted-prefix variants (a(0)=1 / a(0)=0), mid/deep/tail
>      windows, subsequence late windows, MSE in-site direct search (five
>      strings), MathOverflow, zbMATH new strings incl. the full-record read
>      of Farrell 1978 (an:0414.05042), OEIS reverse cross-reference hunting
>      (A386889 has no reverse references; the A030186 citing family has no
>      period-3 member), Chinese-layer sweeps; verdict = supports the first
>      review (no occupying record, consistent and strengthened).
>
> Nothing else was added; the record bodies are unmodified and their
> conclusions are not reworded. Raw query responses remain in the working
> repository under the source task directory (kept in-repo, not shipped in
> this deposit).
>
> The C9 verdict carried into the claim note is: no occupying record found
> for the period-3 pendant-ladder matching sequence, for its 12-order sparse
> recurrence, and for the three mod-3 subsequences (object level and
> proposition level, two independent reviews); the registered family members
> are the plain ladder A030186, the period-1 pendant (corona) A102436 and
> the period-2 pendant A386889 - all explicitly delimited, none of them is
> this object; the nearest literature neighbour (Farrell, "Matchings in
> ladders", Ars Combin. 6 (1978) 153-161) covers the plain ladder only.
> Value tier = new sequence / new recurrence (not new mathematics).
>
"""

FOOTER = """
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
{table}

Recompute with: `python claims/ladder-pend3-interleave/audit/build-c9-record.py --check`
"""


def build():
    blocks_all = collect()
    rows = []
    body_parts = []
    idx = 0
    for rel, n_src, parts in blocks_all:
        for a, b, text in parts:
            idx += 1
            rows.append("| %d | %s | %d-%d | %d | %s |" % (
                idx, rel.split("/")[-1], a, b, len(text.encode("utf-8")),
                hashlib.sha256(text.encode("utf-8")).hexdigest()[:16]))
            body_parts.append(text)
    params = {}
    for i, (rel, n_src, parts) in enumerate(blocks_all, 1):
        params["src%d" % i] = rel
        params["n%d" % i] = n_src
        params["s%d" % i] = sha_file(rel)
        params["r%d" % i] = ", ".join("%d-%d" % (a, b) for a, b, _ in parts)
    table = "\n".join(rows)
    text = (HEADER.format(**params) + "\n\n".join(body_parts)
            + FOOTER.format(table=table))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("wrote %s (%d bytes)" % (OUT, len(text.encode("utf-8"))))
    return text


def check():
    blocks_all = collect()
    text = open(os.path.join(ROOT, OUT), encoding="utf-8").read()
    ok = True
    idx = 0
    for rel, n_src, parts in blocks_all:
        for a, b, want in parts:
            idx += 1
            if want in text:
                print("PASS %d: %s lines %d-%d verbatim present" % (idx, rel, a, b))
            else:
                print("FAIL %d: %s lines %d-%d NOT verbatim present" % (idx, rel, a, b))
                ok = False
    return 0 if ok else 1


if __name__ == "__main__":
    if "--check" in sys.argv:
        raise SystemExit(check())
    build()
