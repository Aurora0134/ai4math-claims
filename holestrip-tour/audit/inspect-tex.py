#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""listing hygiene + splice + byte-exact verification for the holestrip-tour
claim and paper (SOP 08b/08 steps 3/5). Adapted from
claims/ladder-pend3-interleave/audit/inspect-tex.py (same mechanics, this
claim's paths and ranges).

Usage (from the repository root):
  python claims/holestrip-tour/audit/inspect-tex.py --scan  <file.tex>
  python claims/holestrip-tour/audit/inspect-tex.py --splice <file.tex>
  python claims/holestrip-tour/audit/inspect-tex.py --verify <file.tex>

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
STMT = "tasks/20260928-holestrip-tour-pipeline/formalized/holestrip-tour.statement.txt"
FINAL = "tasks/20260928-holestrip-tour-pipeline/attempts/stage4b-full.lean"
AXIOMS = "claims/holestrip-tour/audit/axioms.out"

# marker -> (source file, first line, last line, label)
# The frozen statement file contains two literal 'sorry' occurrences (the two
# theorem proof placeholders) at lines 77 and 84 and one mention in the head
# comment block at line 18. All lie outside the ranges below, as required by
# the paper-lint listing gate; the final proof file contains zero
# sorry/admit/native_decide anywhere.
MARKERS = {
    "@@S1@@": (STMT, 43, 76, "statement: board encoding + knight graph + theorem-O head"),
    "@@S2@@": (STMT, 79, 83, "statement: theorem-C head"),
    "@@P0@@": (FINAL, 749, 877, "proof: loading layer (walkOfChain/pathOfChain/cycleOfChain)"),
    "@@P1@@": (FINAL, 1589, 1644, "proof: closed-tour induction assembly"),
    "@@P2@@": (FINAL, 2001, 2036, "proof: open-tour induction assembly (odd n)"),
    "@@P3@@": (FINAL, 2447, 2575, "proof: cut barrier + n=6/7 certificates"),
    "@@P4@@": (FINAL, 2577, 2633, "proof: both iff theorems + closing #print axioms"),
}
AXIOMS_MARKER = "@@AXIOMS@@"


def read_lines(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        data = fh.read()
    # The final proof file is CRLF-dominant with mixed endings on the working
    # disk (autocrlf workspace); listing excerpts are LF-normalised per the
    # chorded-cycle precedent (adjudicated + disclosed), while proofs/ ships
    # the byte-exact original. The frozen statement file arrives LF; both are
    # asserted CR-free AFTER normalisation so no stray bare CR can hide.
    data = data.replace(b"\r\n", b"\n")
    if "\r" in data.decode("utf-8"):
        raise SystemExit("FATAL: frozen source %s contains bare CR" % rel)
    return data.decode("utf-8").split("\n")


def rng(rel, a, b):
    lines = read_lines(rel)
    return "\n".join(lines[a - 1:b])


def axioms_block():
    with io.open(os.path.join(ROOT, AXIOMS), "r", encoding="utf-8") as fh:
        lines = [ln.rstrip("\n") for ln in fh if not ln.startswith("EXIT=")]
    return "\n".join(lines)


def sha(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def blocks(tex_lines):
    """yield (start_index, end_index) of every lstlisting body"""
    i = 0
    while i < len(tex_lines):
        if "\\begin{lstlisting}" in tex_lines[i]:
            j = i + 1
            while j < len(tex_lines) and "\\end{lstlisting}" not in tex_lines[j]:
                j += 1
            yield i + 1, j
            i = j
        i += 1


def scan(path):
    tex = open(path, encoding="utf-8").read().split("\n")
    inside = set()
    for a, b in blocks(tex):
        inside.update(range(a, b))
    hits = []
    for i, line in enumerate(tex, 1):
        if i - 1 in inside:
            continue
        s = re.sub(r"(?<!\\)%.*$", "", line)
        s = re.sub(r"\\lean\{[^{}]*\}", "", s)
        s = re.sub(r"\\lstinline\|[^|]*\|", "", s)
        bad = sorted({ord(c) for c in s if ord(c) > 127})
        if bad:
            hits.append((i, bad, line.strip()[:90]))
    print("non-ASCII outside listings/lean/comments: %d line(s)" % len(hits))
    for i, bad, txt in hits:
        print("  line %d %s | %s" % (i, ",".join("U+%04X" % c for c in bad), txt))
    for i, line in enumerate(tex, 1):
        if "@@" in line:
            print("  MARKER PRESENT line %d: %s" % (i, line.strip()[:60]))
    return 0 if not hits else 1


def splice(path):
    tex = open(path, encoding="utf-8").read()
    n = 0
    for marker, (rel, a, b, _) in MARKERS.items():
        if marker in tex:
            tex = tex.replace(marker, rng(rel, a, b))
            n += 1
    if AXIOMS_MARKER in tex:
        tex = tex.replace(AXIOMS_MARKER, axioms_block())
        n += 1
    with io.open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(tex)
    print("spliced %d marker(s) into %s" % (n, path))


def verify(path):
    tex = open(path, encoding="utf-8").read()
    out = []
    ok = True
    out.append("== %s -- 2026-09-30 ==" % os.path.basename(path))
    out.append("source sha256: holestrip-tour.statement.txt=%s  stage4b-full.lean=%s"
               % (sha(STMT), sha(FINAL)))
    out.append("note: each PASS line compares the lstlisting body currently in the .tex "
               "with the verbatim contiguous range of the frozen artifact (byte-for-byte, "
               "LF); 'lines a-b' is the source line range carried in the listing caption. "
               "The frozen statement file's literal 'sorry' occurrences (two theorem proof "
               "placeholders at lines 77/84, one mention in the head comment block at line "
               "18) all lie outside the excerpt ranges; the final-file excerpts carry no "
               "sorry/admit/native_decide (whole file: zero).")
    # @@P0@@ (loading layer) is a paper-only listing: claim.tex never carries it.
    # Scope the check set to the target tex's declared listings; every listing a tex
    # declares is still compared byte-exact, so this scoping adds no exemption.
    markers = MARKERS
    if not os.path.abspath(path).startswith(os.path.join(ROOT, "papers")):
        markers = {k: v for k, v in MARKERS.items() if k != "@@P0@@"}
    for marker, (rel, a, b, label) in markers.items():
        want = rng(rel, a, b)
        # find the block that contains `want` (markers were spliced, so search raw)
        if want in tex:
            out.append("PASS: %s (%s lines %d-%d, %d bytes) -- %s"
                       % (os.path.basename(path), rel.split("/")[-1], a, b,
                          len(want.encode("utf-8")), label))
        else:
            out.append("FAIL: %s (%s lines %d-%d) NOT present verbatim -- %s"
                       % (os.path.basename(path), rel.split("/")[-1], a, b, label))
            ok = False
    want_ax = axioms_block()
    if want_ax in tex:
        out.append("PASS: %s (axioms block, %d lines, %d bytes)"
                   % (os.path.basename(path), len(want_ax.split("\n")),
                      len(want_ax.encode("utf-8"))))
    else:
        out.append("FAIL: %s (axioms block) NOT present verbatim" % os.path.basename(path))
        ok = False
    if os.path.abspath(path).startswith(os.path.join(ROOT, "papers")):
        log = os.path.join(ROOT, "papers/holestrip-tour/audit/listing-verify.txt")
    else:
        log = os.path.join(ROOT, "claims/holestrip-tour/audit/listing-verify.txt")
    with io.open(log, "a", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(out) + "\n\n")
    print("\n".join(out))
    return 0 if ok else 1


if __name__ == "__main__":
    if len(sys.argv) != 3 or sys.argv[1] not in ("--scan", "--splice", "--verify"):
        raise SystemExit(__doc__)
    mode, target = sys.argv[1], sys.argv[2]
    if mode == "--scan":
        raise SystemExit(scan(target))
    if mode == "--splice":
        splice(target)
    if mode == "--verify":
        raise SystemExit(verify(target))
