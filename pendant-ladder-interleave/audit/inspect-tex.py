#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""listing hygiene + splice + byte-exact verification for the
pendant-ladder-interleave claim (SOP 08b steps 3/5). Adapted from
claims/chorded-cycle-mod4/audit/inspect-tex.py (same mechanics, pend paths and
ranges).

Usage (from the repository root):
  python claims/pendant-ladder-interleave/audit/inspect-tex.py --scan  <file.tex>
  python claims/pendant-ladder-interleave/audit/inspect-tex.py --splice <file.tex>
  python claims/pendant-ladder-interleave/audit/inspect-tex.py --verify <file.tex>

--scan   : report non-ASCII characters outside lstlisting blocks and comments
           (the criterion scripts/paper-lint.sh applies).
--splice : replace @@Ln@@ marker lines with the verbatim line range of the frozen
           source named in MARKERS below, LF-normalised, no other byte touched.
--verify : re-extract each range and diff it against the block currently present
           in the .tex; append a PASS/FAIL record to audit/listing-verify.txt.

AI-generated 2026-09-28. Read-only with respect to tasks/: the frozen sources
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
STMT = "tasks/20260927-mossad-pend/formalized/01-pend-statements.lean"
FINAL = "tasks/20260927-mossad-pend/final/01-pend-proved.lean"

# marker -> (source file, first line, last line, label)
MARKERS = {
    "@@L1@@": (STMT, 27, 68, "statement: apend/opend/epend defs + T1"),
    "@@L2@@": (STMT, 71, 89, "statement: pat2 def + T2"),
    "@@L3@@": (STMT, 92, 106, "statement: pat6 + pat3 defs + T3o"),
    "@@L4@@": (STMT, 109, 112, "statement: T3e"),
    "@@L5@@": (FINAL, 1, 259, "proof: whole final file"),
}


def read_lines(rel):
    with io.open(os.path.join(ROOT, rel), "r", encoding="utf-8", newline="") as fh:
        data = fh.read()
    if "\r" in data:
        raise SystemExit("FATAL: frozen source %s contains CR" % rel)
    return data.split("\n")


def rng(rel, a, b):
    lines = read_lines(rel)
    return "\n".join(lines[a - 1:b])


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
    with io.open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(tex)
    print("spliced %d marker(s) into %s" % (n, path))


def verify(path):
    tex = open(path, encoding="utf-8").read()
    out = []
    ok = True
    for marker, (rel, a, b, label) in MARKERS.items():
        want = rng(rel, a, b)
        if marker in tex:
            out.append("FAIL %s (%s): marker %s not spliced" % (label, rel, marker))
            ok = False
            continue
        m = re.search(r"lines\s+%d--%d" % (a, b), tex)
        if not m:
            out.append("SKIP %s: no 'lines %d--%d' caption found" % (label, a, b))
            ok = False
            continue
        start = tex.rindex("\\begin{lstlisting}", 0, m.start())
        opts_end = tex.index("]", start)
        body_start = tex.index("\n", opts_end) + 1
        body_end = tex.index("\\end{lstlisting}", body_start)
        got = tex[body_start:body_end].rstrip("\n")
        same = got == want
        ok = ok and same
        out.append("%s %s [%s lines %d-%d] bytes=%d sha256(body)=%s" % (
            "PASS" if same else "FAIL", label, os.path.basename(rel), a, b,
            len(want.encode("utf-8")),
            hashlib.sha256(want.encode("utf-8")).hexdigest()[:16]))
    src = ("source sha256: %s=%s  %s=%s\n" % (os.path.basename(STMT), sha(STMT),
                                              os.path.basename(FINAL), sha(FINAL)))
    text = "\n".join(out) + "\n"
    print(src + text)
    rec_dir = os.path.dirname(path)
    if not os.path.basename(rec_dir) == "audit":
        rec_dir = rec_dir + "/audit" if os.path.isdir(rec_dir + "/audit") else rec_dir
    rec = os.path.join(rec_dir, "listing-verify.txt")
    with io.open(rec, "a", encoding="utf-8", newline="\n") as fh:
        fh.write("== %s -- %s ==\n" % (os.path.basename(path), "2026-09-28"))
        fh.write(src)
        fh.write("note: each PASS line compares the lstlisting body currently in the "
                 ".tex with the verbatim contiguous range of the frozen artifact "
                 "(byte-for-byte, LF); 'lines a-b' is the source line range carried "
                 "in the listing caption.\n")
        fh.write(text)
    print("record appended -> %s" % rec)
    return 0 if ok else 1


def lean_ids(path):
    tex = open(path, encoding="utf-8").read()
    fin = open(os.path.join(ROOT, FINAL), encoding="utf-8").read()
    ids = sorted(set(re.findall(r"\\lean\{([^{}]*)\}", tex)))
    bad = []
    print("\\lean{} identifiers: %d" % len(ids))
    for i in ids:
        present = i in fin
        print("  %s %s" % ("OK  " if present else "MISS", i))
        if not present:
            bad.append(i)
    anchors = re.findall(r"^% LEAN: .*$", tex, re.M)
    print("%% LEAN anchors: %d" % len(anchors))
    for a in anchors:
        print("  " + a)
    print("MISSING: %s" % (bad if bad else "none"))
    return 1 if bad else 0


if __name__ == "__main__":
    mode, path = sys.argv[1], sys.argv[2]
    p = path if os.path.isabs(path) else os.path.join(ROOT, path)
    if mode == "--scan":
        sys.exit(scan(p))
    if mode == "--lean-ids":
        sys.exit(lean_ids(p))
    if mode == "--splice":
        splice(p)
        sys.exit(0)
    if mode == "--verify":
        sys.exit(verify(p))
    raise SystemExit("unknown mode")
