#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""statement-diff.py — statement symmetric-difference re-run for the
ladder-pend3-interleave claim package (SOP 08b step 4 audit evidence).
Replicates the method recorded in the audit department's final adjudication
(tasks/20260929-comb10-ladder-pend3/audit/final-comb10-ladder-pend3.txt §1):

  strip block comments /- -/ (incl. docstrings) and line comments --;
  split top-level def/theorem declarations; defs compare full block
  (whitespace-collapsed); theorems compare up to ':=' with set_option
  resource-decoration lines ignored.

Inputs (read-only):
  frozen : tasks/20260929-comb10-ladder-pend3/formalized/comb10-ladder-pend3.statement.txt
  final  : tasks/20260929-comb10-ladder-pend3/final/comb10-ladder-pend3-proved.lean
Output: claims/ladder-pend3-interleave/audit/statement-diff.out

AI-generated 2026-09-29.
"""
import hashlib
import io
import os
import re
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
FROZEN = "tasks/20260929-comb10-ladder-pend3/formalized/comb10-ladder-pend3.statement.txt"
FINAL = "tasks/20260929-comb10-ladder-pend3/final/comb10-ladder-pend3-proved.lean"
OUT = "claims/ladder-pend3-interleave/audit/statement-diff.out"

FROZEN_DEFS = ["ap3", "bp0", "bp1", "bp2", "pat15", "pat30"]
FROZEN_THMS = ["ap3_interleave", "ap3_mod2_period15", "ap3_mod4_period30"]


def read(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return fh.read().replace(b"\r\n", b"\n").decode("utf-8")


def strip_comments(src):
    # block comments /- ... -/ (non-nested use in these files), then line comments
    src = re.sub(r"/-.*?-/", "", src, flags=re.S)
    src = re.sub(r"--[^\n]*", "", src)
    return src


def split_decls(src):
    """return dict name -> (kind, full_text) for top-level def/theorem blocks."""
    decls = {}
    pat = re.compile(r"^(def|theorem)\s+([A-Za-z0-9_']+)", re.M)
    matches = list(pat.finditer(src))
    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(src)
        # ignore set_option decoration lines inside a block
        body = "\n".join(
            ln for ln in src[start:end].split("\n")
            if not ln.strip().startswith("set_option"))
        decls[m.group(2)] = (m.group(1), body)
    return decls


def collapse(s):
    return re.sub(r"\s+", " ", s).strip()


def thm_head(s):
    idx = s.find(":=")
    return s[:idx] if idx >= 0 else s


def sha_file(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def main():
    fz = split_decls(strip_comments(read(FROZEN)))
    fn = split_decls(strip_comments(read(FINAL)))
    lines = []
    lines.append("statement symmetric-difference re-run (claim packager, 2026-09-29)")
    lines.append("method: strip comments -> split top-level def/theorem -> "
                 "defs full-block whitespace-collapsed compare; theorems compare "
                 "up to ':=' ignoring set_option lines (audit-dept method, "
                 "final-comb10-ladder-pend3.txt section 1)")
    lines.append("frozen sha256: %s" % sha_file(FROZEN))
    lines.append("final  sha256: %s" % sha_file(FINAL))
    ok = True
    for name in FROZEN_DEFS + FROZEN_THMS:
        if name not in fz or name not in fn:
            lines.append("MISSING %s (frozen=%s final=%s)" % (
                name, name in fz, name in fn))
            ok = False
            continue
        kf, bf = fz[name]
        k2, b2 = fn[name]
        if name in FROZEN_DEFS:
            same = collapse(bf) == collapse(b2)
        else:
            same = collapse(thm_head(bf)) == collapse(thm_head(b2))
        lines.append("[%s] %s (%s)" % ("header-identical" if same else "DIFFERS",
                                       name, kf))
        ok = ok and same
    extra = sorted(set(fn) - set(fz))
    lines.append("final-only declarations (proof-body scaffolding, expected): %s"
                 % (", ".join(extra)))
    lines.append("frozen-only declarations: %s"
                 % (", ".join(sorted(set(fz) - set(fn))) or "none"))
    lines.append("RESULT: SYMMETRIC-DIFF %s (9/9 frozen declarations compared)"
                 % ("PASS" if ok else "FAIL"))
    out = os.path.join(ROOT, OUT)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(lines) + "\n")
    print("\n".join(lines))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
