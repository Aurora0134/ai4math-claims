#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""statement-diff.py -- statement symmetric-difference re-run for the
holestrip-tour claim/paper packages (SOP 08b/08 step 4 audit evidence).
Replicates the method recorded in the audit department's final adjudication
(tasks/20260928-holestrip-tour-pipeline/audit/gate3-final-audit.md):

  strip block comments /- -/ (incl. docstrings) and line comments --;
  split top-level abbrev/def/instance/theorem declarations; abbrev/def
  compare full block (whitespace-collapsed); theorems compare up to ':=' with
  set_option resource-decoration lines ignored.

Inputs (read-only):
  frozen : tasks/20260928-holestrip-tour-pipeline/formalized/holestrip-tour.statement.txt
  final  : tasks/20260928-holestrip-tour-pipeline/attempts/stage4b-full.lean
Output: claims/holestrip-tour/audit/statement-diff.out (and papers/ copy)

AI-generated 2026-09-30.
"""
import hashlib
import io
import os
import re
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
FROZEN = "tasks/20260928-holestrip-tour-pipeline/formalized/holestrip-tour.statement.txt"
FINAL = "tasks/20260928-holestrip-tour-pipeline/attempts/stage4b-full.lean"
OUTS = ["claims/holestrip-tour/audit/statement-diff.out",
        "papers/holestrip-tour/audit/statement-diff.out"]

FROZEN_DEFS = ["Cell", "IsCell", "V", "leap", "leap8", "knightGraph"]
FROZEN_THMS = ["exists_hamiltonian_path_iff", "exists_hamiltonian_cycle_iff"]


def read(rel):
    with io.open(os.path.join(ROOT, rel), "rb") as fh:
        return fh.read().replace(b"\r\n", b"\n").decode("utf-8")


def strip_comments(src):
    src = re.sub(r"/-.*?-/", "", src, flags=re.S)
    src = re.sub(r"--[^\n]*", "", src)
    return src


def split_decls(src):
    """return dict name -> (kind, full_text) for top-level declarations."""
    decls = {}
    pat = re.compile(r"^(abbrev|def|theorem|instance)\s+([A-Za-z0-9_']*)", re.M)
    matches = list(pat.finditer(src))
    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(src)
        body = "\n".join(
            ln for ln in src[start:end].split("\n")
            if not ln.strip().startswith("set_option"))
        key = m.group(2) or "(instance)"
        decls[key] = (m.group(1), body)
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
    lines.append("statement symmetric-difference re-run (claim packager, 2026-09-30)")
    lines.append("method: strip comments -> split top-level abbrev/def/theorem -> "
                 "defs full-block whitespace-collapsed compare; theorems compare "
                 "up to ':=' ignoring set_option lines (audit-dept method, "
                 "gate3-final-audit.md)")
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
    lines.append("final-only declarations (proof-body scaffolding, expected): "
                 "%d, e.g. %s" % (len(extra), ", ".join(extra[:8])))
    lines.append("frozen-only declarations: %s"
                 % (", ".join(sorted(set(fz) - set(fn))) or "none"))
    lines.append("RESULT: SYMMETRIC-DIFF %s (%d frozen declarations compared)"
                 % ("PASS" if ok else "FAIL", len(FROZEN_DEFS) + len(FROZEN_THMS)))
    for out_rel in OUTS:
        out = os.path.join(ROOT, out_rel)
        os.makedirs(os.path.dirname(out), exist_ok=True)
        with io.open(out, "w", encoding="utf-8", newline="\n") as fh:
            fh.write("\n".join(lines) + "\n")
    print("\n".join(lines))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
