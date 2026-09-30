#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""listing hygiene + splice + byte-exact verification for the
grid3n-colmid-indep claim (SOP 08b steps 3/5). Adapted from
claims/ladder-pend3-interleave/audit/inspect-tex.py (same mechanics,
this claim's paths and ranges).

Usage (from the repository root):
  python claims/grid3n-colmid-indep/audit/inspect-tex.py --scan  <file.tex>
  python claims/grid3n-colmid-indep/audit/inspect-tex.py --splice <file.tex>
  python claims/grid3n-colmid-indep/audit/inspect-tex.py --verify <file.tex>

--scan   : report non-ASCII characters outside lstlisting blocks and comments
           (the criterion scripts/paper-lint.sh applies).
--splice : replace @@Ln@@ marker lines with the verbatim line range of the frozen
           source named in MARKERS below, LF-normalised, no other byte touched.
--verify : re-extract each range and diff it against the block currently present
           in the .tex; append a PASS/FAIL record to audit/listing-verify.txt.

AI-generated 2026-09-30. Read-only with respect to tasks/: the frozen sources
are never written.
"""
import hashlib
import io
import os
import re
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
STMT = "tasks/20260930-comb12-grid-indep/formalized/statement.lean"
IFACE = "tasks/20260930-comb12-grid-indep/formalized/interface.lean"
FINAL = "tasks/20260930-comb12-grid-indep/attempts/final-c_z_rec.lean"

# marker -> (source file, first line, last line, label)
# The frozen statement file carries one literal 'sorry' (the theorem proof
# placeholder, line 49) and five 'native_decide' data-check lines (53-61);
# all lie outside the ranges below, as required by the paper-lint listing
# gate. The interface file's warning docstring (lines 164-177) mentions
# 'sorry'/'admit'/'native_decide' as banned words inside a comment, so the
# interface excerpt stops at line 163. Ranges are spliced LF-normalised
# regardless of the on-disk line endings (mixed in the final file:
# 1-485 and 953-1189 LF, 486-952 CRLF); byte-exact originals ship in proofs/.
MARKERS = {
    "L1": (STMT, 21, 48, "statement: base instances + defs holes/z + theorem head (the frozen file's proof body line 49 is a sorry placeholder, excluded; native_decide data-check lines 53-61 excluded)"),
    "L2": (IFACE, 18, 163, "interface: frozen statement segment + attack-interface defs + matrix certificates (roster/attack-notes docstrings excluded: they mention banned words in warning text)"),
    "L3": (FINAL, 1, 1188, "proof: whole final file (1188 numbered lines; the file ends with a newline, so split() yields 1189 chunks with a trailing empty one)"),
}


def read_lines(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        data = fh.read()
    lines = data.split(b"\n")
    # drop trailing empty chunk of a final newline; strip CR per the
    # LF-normalised splice convention (chorded/ladder precedent)
    if lines and lines[-1] == b"":
        lines = lines[:-1]
    return [l.rstrip(b"\r").decode("utf-8") for l in lines]


def splice_range(rel, first, last):
    lines = read_lines(rel)
    if first < 1 or last > len(lines):
        raise SystemExit("range %d-%d out of bounds for %s (%d lines)"
                         % (first, last, rel, len(lines)))
    return lines[first - 1:last]


def listing_blocks(text):
    """Yield [content lines] for each lstlisting block. The optional-argument
    block after \\begin{lstlisting} (captions) may span several lines, so the
    state switch tracks brace depth: lines belong to the block content only
    after the argument braces have closed, and content ends at \\end."""
    out = []
    depth = None
    cur = None
    for line in text.splitlines():
        if depth is None:
            if "\\begin{lstlisting}" in line:
                depth = line.count("{") - line.count("}")
                cur = []
            continue
        if depth > 0:
            depth += line.count("{") - line.count("}")
            continue
        if "\\end{lstlisting}" in line:
            out.append(cur)
            cur = None
            depth = None
        else:
            cur.append(line)
    return out


def block_marker(content):
    for ln in content:
        m = re.match(r"^@@(L\d+)@@\s*$", ln)
        if m:
            return m.group(1)
    return None


def cmd_scan(tex):
    data = io.open(tex, "rb").read().decode("utf-8")
    bad = 0
    in_listing = False
    for i, line in enumerate(data.splitlines(), 1):
        if "\\begin{lstlisting}" in line:
            in_listing = True
            continue
        if "\\end{lstlisting}" in line:
            in_listing = False
            continue
        if in_listing:
            continue
        stripped = re.sub(r"(?<!\\)%.*$", "", line)
        stripped = re.sub(r"\\lstinline\|[^|]*\|", "", stripped)
        if any(ord(c) > 127 for c in stripped):
            print("NON-ASCII outside listing/comment @%d: %s" % (i, line))
            bad += 1
    print("scan:", "PASS" if bad == 0 else "FAIL(%d)" % bad)
    return 0 if bad == 0 else 1


def cmd_splice(tex):
    with io.open(tex, "rb") as fh:
        data = fh.read().decode("utf-8")
    lines = data.split("\n")
    replaced = 0
    for i, line in enumerate(lines):
        m = re.match(r"^@@(L\d+)@@\s*$", line)
        if not m:
            continue
        src, first, last, _label = MARKERS[m.group(1)]
        chunk = splice_range(src, first, last)
        lines[i:i + 1] = chunk
        replaced += 1
    with io.open(tex, "wb") as fh:
        fh.write("\n".join(lines).encode("utf-8"))
    print("splice: %d marker(s) replaced" % replaced)
    return 0


def cmd_verify(tex):
    """Re-extract every MARKERS range and diff it, per block order, against
    the block currently present in the .tex. Post-splice there are no markers
    left, so blocks are matched by order: the first len(MARKERS) marked
    ranges appear in MARKERS insertion order, followed by any unmarked
    blocks (axiom output etc.), which are skipped. A block that matches NO
    remaining range is reported as UNMATCHED (hard fail) so an empty PASS
    can never occur."""
    with io.open(tex, "rb") as fh:
        data = fh.read().decode("utf-8")
    blocks = listing_blocks(data)
    records = []
    ok_all = True
    if len(blocks) < len(MARKERS):
        ok_all = False
        records.append("MISSING: %d marked range(s) but only %d block(s)"
                       % (len(MARKERS), len(blocks)))
    # blocks appear in MARKERS insertion order; trailing unmarked blocks
    # (axiom output etc.) are informational only
    for bi, (name, (src, first, last, label)) in enumerate(MARKERS.items(), 1):
        if bi > len(blocks):
            break
        expect = splice_range(src, first, last)
        got = blocks[bi - 1]
        if got == expect:
            records.append("block %d %s PASS (%s %d-%d, %d lines): %s"
                           % (bi, name, src, first, last, len(expect), label))
            continue
        ok_all = False
        records.append("block %d %s FAIL (%s %d-%d, %d lines expected, %d present): %s"
                       % (bi, name, src, first, last, len(expect), len(got), label))
        for j, (a, b) in enumerate(zip(expect, got)):
            if a != b:
                records.append("  first diff at block line %d:\n    expect: %r\n    got:    %r"
                               % (j + 1, a[:120], b[:120]))
                break
        else:
            records.append("  length differ: expect %d lines, got %d"
                           % (len(expect), len(got)))
    for bi in range(len(MARKERS) + 1, len(blocks) + 1):
        records.append("block %d (unmarked, not verified): %d lines"
                       % (bi, len(blocks[bi - 1])))
    rec = "listing-verify %s %s\n" % (os.path.basename(tex),
                                      "PASS" if ok_all else "FAIL")
    rec += "\n".join(records) + "\n"
    log = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "listing-verify.txt")
    with io.open(log, "a", encoding="utf-8") as fh:
        fh.write(rec)
    print(rec)
    return 0 if ok_all else 1


def main():
    argv = sys.argv[1:]
    if not argv or argv[0] not in ("--scan", "--splice", "--verify"):
        print(__doc__)
        return 2
    mode = argv[0]
    tex = argv[1]
    if mode == "--scan":
        return cmd_scan(tex)
    if mode == "--splice":
        return cmd_splice(tex)
    return cmd_verify(tex)


if __name__ == "__main__":
    sys.exit(main())
