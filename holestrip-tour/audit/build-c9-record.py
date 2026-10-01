#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/holestrip-tour (SOP 08b step 4):
a provenance header plus VERBATIM contiguous extracts of the four C9
novelty-review records of the knight's-tour lineage, followed by a
byte-exactness self-check of the extracted body. Adapted from
claims/ladder-pend3-interleave/audit/build-c9-record.py.

The claim covers the 3xn holed-strip far-corner knight-tour existence
characterisation (pool-comb-11). Four source records document the C9
exclusivity discipline, none of them reworded:

1. tasks/20260928-knighttour-recon/recon.md: first-stage lineage recon
   (three-channel saturation survey: literature / OEIS / formalisation
   ecosystem; two kernel smokes).
2. tasks/20260928-knighttour-narrow/report.md: second-stage narrow-path deep
   dive - the three remaining clean faces of the lineage closed or collapsed;
   the holed-strip far-corner counting sequence identified as the only
   non-occupied candidate, gated on the C1 boundary ruling.
3. tasks/20260928-holestrip-tourcount/report.md: third-stage topic
   feasibility report - three blockers resolved; the existence
   characterisation identified as the provable core (counting only
   auxiliary, per the gate-one C1 ruling, option A); C9 round 4 upheld.
4. tasks/20260928-holestrip-tourcount/c9/literature-round4.md: fourth-round
   full-text exclusivity review - verdict no occupying record; nearest
   neighbours (Miller-Farnsworth 2013, Srichote et al. 2022, Bi et al. 2015)
   read at full-text level and delimited.

AI-generated 2026-09-30. Read-only with respect to tasks/.
"""
import hashlib
import io
import os
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
SOURCES = [
    ("tasks/20260928-knighttour-recon/recon.md",
     [(1, 71)],
     "first-stage lineage recon: three-channel saturation survey (literature / "
     "OEIS / formalisation ecosystem), two kernel smokes, mapping onto the "
     "pipeline criteria"),
    ("tasks/20260928-knighttour-narrow/report.md",
     [(1, 98)],
     "second-stage narrow-path deep dive: the three clean faces closed or "
     "collapsed; the holed-strip far-corner counting sequence isolated as the "
     "only non-occupied candidate (gated on the C1 boundary ruling)"),
    ("tasks/20260928-holestrip-tourcount/report.md",
     [(1, 105)],
     "third-stage feasibility report: three blockers resolved, existence "
     "characterisation as the provable core; C9 round 4 upheld"),
    ("tasks/20260928-holestrip-tourcount/c9/literature-round4.md",
     [(1, 203)],
     "fourth-round full-text exclusivity review: verdict no occupying record; "
     "nearest-neighbour literature read at full-text level and delimited; "
     "residual risks ledgered"),
]
OUT = "claims/holestrip-tour/zenodo/audit/c9-record.md"


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


HEADER = """> provenance note (added by the claim packager, 2026-09-30): this file is the
> full C9 novelty-review record for the 3xn holed-strip far-corner knight
> graph K_n (the 3xn chessboard with the two far corners (0,0) and (2,n-1)
> removed) and its open/closed tour existence characterisation (pool-comb-11),
> copied VERBATIM and byte-for-byte in contiguous line ranges from four
> records of the working repository:
>
>   1. `{src1}` ({n1} lines, sha256 {s1})
>      ranges {r1}: first-stage lineage recon - literature layer (Schwenk
>      1991, Cull-De Curtins 1978, Chia-Ong 2005, Watkins 1997-2004, McKay
>      1997, Miller-Farnsworth 2013, DeMaio-Hippchen 2009), OEIS layer
>      (saturated families and remaining gaps), formalisation layer (Isabelle
>      AFP Knights_Tour 2022, Lean KnightMove 2026, no deficient-board
>      content anywhere); two kernel smokes; verdict = lineage closed for
>      topic selection except three narrow paths.
>   2. `{src2}` ({n2} lines, sha256 {s2})
>      ranges {r2}: second-stage narrow-path deep dive - (1,3)/(2,4) leapers
>      plainly impossible and already published (Knuth 1994 Thm 1, Beluhov
>      2022, Chia-Ong 2005); general (a,b) open by common consent; multi-hole
>      boards: single-square-removed published, two-square 4xn solved by
>      Srichote et al. 2022, 3xn two-square ZERO published work; the
>      holed-strip far-corner counting sequence found non-trivial and
>      unregistered (OEIS six variants zero hits).
>   3. `{src3}` ({n3} lines, sha256 {s3})
>      ranges {r3}: third-stage feasibility report - blocker 2 (zero-value
>      structure) resolved by forced-edge certificates, blocker 3 (data
>      depth) resolved by the plug DP to n=220, blocker 1 (provable core)
>      resolved as the existence characterisation; C9 round 4 upheld; C1
>      boundary question stated (options A/B/C, no self-ruling).
>   4. `{src4}` ({n4} lines, sha256 {s4})
>      ranges {r4}: fourth-round full-text exclusivity review - Srichote
>      2022 read in full (4xn two-square closed tours only; no 3xn, no
>      counting); 3xn two-square existence and counting ZERO published
>      results across journals/theses/preprints/recreational sources; OEIS
>      zero hits over 50+ query strings across four rounds; no formalisation
>      in Isabelle/Lean/Coq/Mizar; residual risks ledgered.
>
> Nothing else was added; the record bodies are unmodified and their
> conclusions are not reworded. Raw query responses and downloaded texts
> remain in the working repository under the source task directories (kept
> in-repo, not shipped in this deposit).
>
> The C9 verdict carried into the claim note is: no occupying record found
> for the 3xn far-corner holed-strip knight-tour existence characterisation
> (both open and closed tours), four rounds of review consistent. The
> nearest published neighbours are Miller-Farnsworth 2013 (3xn, ONE square
> removed, closed tours), Srichote et al. 2022 (4xn, TWO squares removed,
> closed tours) and Bi et al. 2015 (the 4xn two-square question); none of
> them covers 3xn two-square tours, and none covers existence of open tours
> on deficient 3xn boards. Value tier: a small original classification
> theorem (not a first formalisation - there is no published theorem to
> formalise here; not a new sequence - no small recurrence exists for the
> counting companion).
"""

FOOTER = """
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
{table}

Recompute with: `python claims/holestrip-tour/audit/build-c9-record.py --check`
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
