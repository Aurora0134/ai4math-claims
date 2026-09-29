#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build zenodo/audit/c9-record.md for claims/hosoya-split-identity
(SOP 08b step 4): a provenance header plus VERBATIM contiguous extracts of the
C9 novelty-review records, followed by a byte-exactness self-check of the
extracted body. Adapted from claims/pendant-ladder-interleave/audit/build-c9-record.py.

This claim has TWO source records (both required by the packager's check list;
neither is reworded):

1. tasks/20260929-preselect-deeprecheck-01/c9-recheck/L14C/dossier.md (192
   lines): the命题级 C9 dossier of the L14C narrow mouth - 41 substantive
   queries over six channels (OEIS 14 strings, arXiv 9, Crossref 7, MSE 5,
   GitHub 6, local rg 5) with 4 positive controls, covering the sequence side
   of the two defective-prism slices.
   Extracted: lines 1-16 (header, discipline, object), 17-23 (boundary
   notes), 26-96 (the six-channel query table + verdicts), 98-192 (verbatim
   evidence excerpts, verdict, tier).

2. tasks/20260929-l14c-graphside-deep/audit/c9-increment-graphside.md (177
   lines): the graph-side incremental C9 review that ran at the deep-dive
   stage - 31 new queries including the OEIS signature (2,4,0,-1) index-page
   sweep, full-text reads of the nearest arXiv neighbours (PH-property in
   graph prisms, maritime-navigation keyword collision), Crossref/MS-layer
   probes, GitHub code searches, and the mathlib rg layer (zero graph-prism
   definition, zero Hosoya word family).
   Extracted: lines 1-17 (object + increment discipline), 18-66 (query table
   incl. AX/CR/MS/GH rows + verdict), 67-177 (verbatim evidence + OEIS sweep
   + mother-entry check + tier).

3. tasks/20260929-preselect-deeprecheck-01/audit/confirm-L14C.md (47 lines):
   the independent reviewer's confirmation record of the L14C review
   (overall = confirmed, 7/7), included in full.

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
    ("tasks/20260929-preselect-deeprecheck-01/c9-recheck/L14C/dossier.md",
     [(1, 26), (27, 96), (97, 192)],
     "L14C dossier (preselect-deeprecheck-01): six-channel query table with "
     "4 positive controls, verdict = no occupying record (reachable-channel "
     "scope), value tier"),
    ("tasks/20260929-l14c-graphside-deep/audit/c9-increment-graphside.md",
     [(1, 17), (18, 66), (67, 177)],
     "graph-side incremental C9 (l14c-graphside-deep): 31 new queries incl. "
     "OEIS signature (2,4,0,-1) index sweep, full-text reads of nearest "
     "neighbours, mathlib rg layer"),
    ("tasks/20260929-preselect-deeprecheck-01/audit/confirm-L14C.md",
     [(1, 47)],
     "independent reviewer's confirmation record of the L14C review "
     "(overall = confirmed)"),
]
OUT = "claims/hosoya-split-identity/zenodo/audit/c9-record.md"


def lines_of(rel):
    with io.open(os.path.join(ROOT, rel), "r", encoding="utf-8", newline="") as fh:
        data = fh.read()
    assert "\r" not in data, "unexpected CR in source"
    return data.split("\n")


def sha_file(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def collect():
    """returns list of (rel, n_src, [(a, b, text)]) and the header/footer"""
    blocks_all = []
    hdr_rows = []
    for i, (rel, ranges, _) in enumerate(SOURCES, 1):
        ls = lines_of(rel)
        if ls and ls[-1] == "":
            ls = ls[:-1]
        parts = []
        for a, b in ranges:
            parts.append((a, b, "\n".join(ls[a - 1:b])))
        blocks_all.append((rel, len(ls), parts))
    return blocks_all


HEADER = """> provenance note (added by the claim packager, 2026-09-29): this file is the
> full C9 novelty-review record for the two defective-prism matching slices of
> pool-comb-13 (narrow mouth L14C) and their graph-side statement upgrade,
> copied VERBATIM and byte-for-byte in contiguous line ranges from three
> records of the working repository:
>
>   1. `{src1}` ({n1} lines, sha256 {s1})
>      ranges {r1}: review header and discipline; object; boundary notes
>      against the mother sequence A102080, Moebius ladders A020877, and the
>      nearest published neighbours; the six-channel query table (OEIS /
>      arXiv / Crossref / MSE / GitHub / local rg) with positive controls;
>      verbatim evidence, verdict = no occupying record found (reachable-
>      channel scope), value tier.
>   2. `{src2}` ({n2} lines, sha256 {s2})
>      ranges {r2}: the graph-side incremental C9 review (31 new queries):
>      arXiv all-field sweeps that captured a title-sweep miss, Crossref,
>      MSE, GitHub code searches, the OEIS recurrence-signature (2,4,0,-1)
>      index-page sweep (only 4 entries registered, neither slice among
>      them), the mother entry A102080 verification, and the mathlib rg
>      layer (zero prism/Hosoya word family).
>   3. `{src3}` ({n3} lines, sha256 {s3})
>      ranges {r3}: the independent reviewer's confirmation of that review
>      (overall = confirmed, 7/7; two non-load-bearing ledger blemishes are
>      recorded in its errata section).
>
> Nothing else was added; the record bodies are unmodified and their
> conclusions are not reworded. Raw query responses remain in the working
> repository under the two task directories (kept in-repo, not shipped in
> this deposit).
>
> The C9 verdict carried into the claim note is: no occupying record found
> (reachable-channel scope) for both defective-prism slices and for the
> edge-deletion matching-split identity as a Lean proposition; the C9 verdict
> does NOT adjudicate the prose identity's presence in human literature
> (it is classical there); value tier of the parent topic = new sequence,
> with the graph-side bridge graded first-formalisation.
>
> Scope correction pointer (added by the packager, not part of the record
> body): the queries in records 1-2 were scoped to the defective-prism
> matching SLICES and the graph-side bridge. For the present deposit's
> central theorem - the general edge-deletion matching-split identity - the
> packager ran a supplementary arXiv sweep on 2026-09-29
> (all:"Hosoya index" AND all:prism = 0 entries; abs:"Hosoya index" AND
> abs:"deleted"/"edge deletion" = 0 entries) and confirms the mathlib v4.34.0
> rg layer has no matching-count API at all; the three-tier zero-same-form
> conclusion of the record body therefore extends to the identity itself
> (reachable-channel scope). As a human-maths tool the identity is classical
> (used wherever matching counts are split per edge; cf. the mother entry
> A102080's computational provenance), so the claim note asserts first
> Lean formalisation, never new mathematics.
>
"""

FOOTER = """
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
{table}

Recompute with: `python claims/hosoya-split-identity/audit/build-c9-record.py --check`
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
    names = []
    for i, (rel, n_src, parts) in enumerate(blocks_all, 1):
        params["src%d" % i] = rel
        params["n%d" % i] = n_src
        params["s%d" % i] = sha_file(rel)
        params["r%d" % i] = ", ".join("%d-%d" % (a, b) for a, b, _ in parts)
        names.append(rel)
    table = "\n".join(rows)
    text = (HEADER.format(**params) + "\n\n".join(body_parts)
            + FOOTER.format(table=table))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("wrote %s (%d bytes; sources: %s)" % (OUT, len(text.encode("utf-8")),
                                                "; ".join(names)))
    return text


def check():
    blocks_all = collect()
    text = open(os.path.join(ROOT, OUT), encoding="utf-8").read()
    body_parts = []
    ok = True
    idx = 0
    for rel, n_src, parts in blocks_all:
        for a, b, want in parts:
            idx += 1
            body_parts.append(want)
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