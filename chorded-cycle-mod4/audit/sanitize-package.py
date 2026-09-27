#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Package sync + desensitisation for the chorded-cycle-mod4 deposits
(SOP 08 step 7 / SOP 08b step 4; audit findings F1/O1/N-1 of 2026-09-28).

What it does, per package (papers/ and claims/):
  1. rebuild zenodo/audit/audit-axioms-sidecar.log from the task's axiom output
     file, keeping ONLY the three "depends on axioms" lines (the raw sidecar log
     echoes the full compile path on every warning line);
  2. rebuild zenodo/audit/audit-strict-compile.log from the task's strict log with
     the machine's repository prefix replaced by <repo>/;
  3. ship the tooling scripts with the absolute repository root replaced by an
     environment lookup (AI4MATH_REPO, default ".");
  4. copy the phase0 enumeration/fitting evidence into zenodo/data/phase0/ (paper
     package) so that every "ships in this deposit" statement in the manuscript is
     backed by a real file;
  5. copy the C9 record into the paper package too;
  6. write zenodo/metadata/FILE-MANIFEST.txt (sha256 + bytes for every file in the
     package) and fail if any package file still contains the local username.

Usage:  python papers/chorded-cycle-mod4/audit/sanitize-package.py [--check-only]
AI-generated 2026-09-28. Writes only under the two zenodo/ trees.
"""
import hashlib
import io
import os
import re
import shutil
import sys

ROOT = os.environ.get("AI4MATH_REPO", os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")))
TASK = os.path.join(ROOT, "tasks", "20260927-mossad-cchord")
PAP = os.path.join(ROOT, "papers", "chorded-cycle-mod4")
CLA = os.path.join(ROOT, "claims", "chorded-cycle-mod4")
LOCAL = os.path.expanduser("~").replace("\\", "/")
LOCAL_USER = os.path.basename(LOCAL)   # scanned for, never written into a package file
USER_TAG = re.compile(r"C:[/\\\\]+Users", re.I)   # generic pattern only: the tool
# never carries a literal local path, so a copy of it cannot leak one.
PHASE0 = ["compute.py", "counts.py", "counts.txt", "compute.out",
          "fit.py", "fit.md", "fit.out", "claims.md", "verify_claims.out",
          "diag.py", "diag.out", "m3check.py", "precheck.md"]


def sha(path):
    with open(path, "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def w(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with io.open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print("  wrote %s (%d B)" % (os.path.relpath(path, ROOT), len(text.encode("utf-8"))))


def depath(text):
    """replace machine-local absolute prefixes with a neutral marker"""
    for pref in (ROOT.replace("\\", "/"), ROOT, os.path.expanduser("~"), LOCAL):
        if pref:
            text = text.replace(pref + "/", "<repo>/").replace(pref, "<repo>")
    return re.sub(r"[A-Za-z]:[/\\\\]+Users[/\\\\]+[^/\\\\\s]+", "<repo>", text)


def script_clean(src):
    text = open(src, encoding="utf-8").read()
    text = re.sub(r'ROOT = "C:/Users/[^"]*"',
                  'ROOT = os.environ.get("AI4MATH_REPO", ".")', text)
    return depath(text)


def build_artifacts(dst_audit):
    ax = open(os.path.join(TASK, "attempts", "final-axioms.out"),
              encoding="utf-8", errors="replace").read().split("\n")
    keep = [l for l in ax if "depends on axioms" in l]
    w(os.path.join(dst_audit, "audit-axioms-sidecar.log"),
      "# axiom printout (sidecar #print axioms for the three declarations).\n"
      "# Machine-local paths stripped by audit/sanitize-package.py; the full\n"
      "# compile echo of this run is in audit-strict-compile.log.\n"
      + "\n".join(keep) + "\n")
    strict = open(os.path.join(TASK, "attempts", "final-strict.out"),
                  encoding="utf-8", errors="replace").read()
    w(os.path.join(dst_audit, "audit-strict-compile.log"),
      "# strict re-compile of final/01-cchord-proved.lean (Lean v4.34.0 +\n"
      "# mathlib4 v4.34.0). Original run: 0 error, 68 if_neg/if_pos deprecation\n"
      "# warnings. The run did not echo an EXIT line; the re-computed EXIT=0\n"
      "# evidence is the audit department's independent re-run recorded in\n"
      "# final-01-cchord.txt (check 3).\n" + depath(strict))


def copy_scripts(pkg_audit, src_dir):
    for name in ("inspect-tex.py", "build-c9-record.py"):
        s = os.path.join(src_dir, name)
        if os.path.exists(s):
            w(os.path.join(pkg_audit, name), script_clean(s))


def sync_packages():
    # paper package: data/ + c9 record + scripts + logs
    pa = os.path.join(PAP, "zenodo")
    data = os.path.join(pa, "data", "phase0")
    os.makedirs(data, exist_ok=True)
    for f in PHASE0:
        s = os.path.join(TASK, "phase0", f)
        if os.path.exists(s):
            shutil.copy2(s, os.path.join(data, f))
            print("  data/phase0/%s" % f)
    src_c9 = os.path.join(CLA, "zenodo", "audit", "c9-record.md")
    if os.path.exists(src_c9):
        shutil.copy2(src_c9, os.path.join(pa, "audit", "c9-record.md"))
        print("  paper pkg <- audit/c9-record.md")
    # working copies of the two check docs get re-copied by the caller after edit
    for pkg, src in ((PAP, os.path.join(PAP, "audit")), (CLA, os.path.join(CLA, "audit"))):
        build_artifacts(os.path.join(pkg, "zenodo", "audit"))
        copy_scripts(os.path.join(pkg, "zenodo", "audit"), src)


def manifests():
    bad = []
    for pkg in (PAP, CLA):
        root = os.path.join(pkg, "zenodo")
        rows = []
        for dirpath, dirnames, filenames in os.walk(root):
            dirnames[:] = [d for d in dirnames]
            for fn in sorted(filenames):
                p = os.path.join(dirpath, fn)
                rel = os.path.relpath(p, root).replace("\\", "/")
                if fn == "FILE-MANIFEST.txt":
                    continue
                with open(p, encoding="utf-8", errors="replace") as fh:
                    body = fh.read()
                if LOCAL_USER in body:
                    bad.append(rel)
                rows.append("%s  %d  %s" % (sha(p), os.path.getsize(p), rel))
        rows.sort(key=lambda r: r.split("  ", 2)[2])
        text = ("# FILE-MANIFEST -- sha256  bytes  path (relative to this package root)\n"
                "# Generated 2026-09-28 by papers/chorded-cycle-mod4/audit/sanitize-package.py.\n"
                "# Every file of the deposit is listed; a publication check re-hashes this list.\n"
                + "\n".join(rows) + "\n")
        w(os.path.join(root, "metadata", "FILE-MANIFEST.txt"), text)
        print("  files in package: %d" % len(rows))
    if bad:
        print("FAIL: local username still present in: %s" % ", ".join(bad))
        return 1
    print("PASS: no machine-local user path in any package file")
    return 0


def check_only():
    return manifests()


if __name__ == "__main__":
    if "--check-only" in sys.argv:
        raise SystemExit(check_only())
    sync_packages()
    raise SystemExit(manifests())
