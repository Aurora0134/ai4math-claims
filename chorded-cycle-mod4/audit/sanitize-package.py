#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Package sync, desensitisation and promise reconciliation for the
chorded-cycle-mod4 deposits (SOP 08 step 7 / SOP 08b step 4-5).

Why this tool exists: two audit rounds kept finding the same class of defect --
prose that promises something the deposit does not contain (SOP 08 finding F3,
recurring as N-1; SOP 08b findings F1/F2/F5/F6). Rewording alone cannot close
that class, so the check is mechanised here.

Per package (papers/ and claims/):
  1. rebuild zenodo/audit/audit-axioms-sidecar.log from the task's axiom output,
     keeping ONLY the three "depends on axioms" lines (the raw sidecar echoes the
     full machine path on every warning line);
  2. rebuild zenodo/audit/audit-strict-compile.log from the task's strict log with
     machine-local path prefixes replaced by <repo>/, headed by a note that the
     run did not echo EXIT and that the EXIT=0 evidence is the final audit record;
  3. ship the tooling scripts with the absolute repository root replaced by an
     environment lookup, and with no literal local path anywhere;
  4. copy the phase0 enumeration/fitting evidence into zenodo/data/phase0/ and the
     C9 record into zenodo/audit/, so that every "ships in this deposit" statement
     in the manuscript is backed by a real file;
  5. write or verify zenodo/metadata/FILE-MANIFEST.txt (sha256 + bytes per file);
  6. reconcile every path-shaped promise made in the .tex and in the package README
     against the deposit and the working repository.

Usage (from anywhere):
  python .../sanitize-package.py                    # sync + write manifest + checks
  python .../sanitize-package.py --check-only       # READ-ONLY: verify manifest and
                                                    # promises; writes nothing
  python .../sanitize-package.py --assert-promises  # promise gate only
  python .../sanitize-package.py --check-zip        # READ-ONLY zip-vs-manifest check
Exit 0 = every gate green. Run --check-only before any outbound act.

AI-generated 2026-09-28. Writes only under the two zenodo/ trees.
"""
import hashlib
import io
import os
import re
import shutil
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
TASK = os.path.join(ROOT, "tasks", "20260927-mossad-cchord")
PAP = os.path.join(ROOT, "papers", "chorded-cycle-mod4")
CLA = os.path.join(ROOT, "claims", "chorded-cycle-mod4")
LOCAL = os.path.expanduser("~").replace("\\", "/")
LOCAL_USER = os.path.basename(LOCAL)   # scanned for, never written into a file
# generic detector for machine-local home paths; the tool itself carries no literal one
HOME_PATH_RX = re.compile(r"[A-Za-z]:[/\\]+Users[/\\]+[^/\\s]+", re.I)
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
    for pref in (ROOT.replace("\\", "/"), ROOT, LOCAL, os.path.expanduser("~")):
        if pref:
            text = text.replace(pref + "/", "<repo>/").replace(pref, "<repo>")
    return HOME_PATH_RX.sub("<repo>", text)


def script_clean(src):
    text = open(src, encoding="utf-8").read()
    text = re.sub(r'ROOT = os\.environ\.get\("AI4MATH_REPO",[^)\n]*\)\)',
                  'ROOT = os.environ.get("AI4MATH_REPO", ".")', text)
    text = re.sub(r'ROOT = os.environ.get("AI4MATH_REPO", ".")\n]*"',
                  'ROOT = os.environ.get("AI4MATH_REPO", ".")', text)
    return depath(text)


def build_artifacts(dst_audit):
    ax = open(os.path.join(TASK, "attempts", "final-axioms.out"),
              encoding="utf-8", errors="replace").read().split("\n")
    keep = [l for l in ax if "depends on axioms" in l]
    w(os.path.join(dst_audit, "audit-axioms-sidecar.log"),
      "# axiom printout (#print axioms for the three declarations).\n"
      "# Machine-local paths stripped by audit/sanitize-package.py; only the\n"
      "# three printout lines are kept -- the full compile echo is in\n"
      "# audit-strict-compile.log.\n" + "\n".join(keep) + "\n")
    strict = open(os.path.join(TASK, "attempts", "final-strict.out"),
                  encoding="utf-8", errors="replace").read()
    w(os.path.join(dst_audit, "audit-strict-compile.log"),
      "# strict re-compile of final/01-cchord-proved.lean (Lean v4.34.0 +\n"
      "# mathlib4 v4.34.0). Original run: 0 error, 68 if_neg/if_pos deprecation\n"
      "# warnings. The run did not echo an EXIT line; the re-computed EXIT=0\n"
      "# evidence is the audit department's independent re-run recorded in\n"
      "# final-01-cchord.txt (check 3).\n" + depath(strict))


def copy_scripts(pkg_audit, src_dir):
    for name in ("inspect-tex.py", "build-c9-record.py", "sanitize-package.py",
                 "make-zip.py"):
        s = os.path.join(src_dir, name)
        if os.path.exists(s):
            w(os.path.join(pkg_audit, name), script_clean(s))


def sync_packages():
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
    for pkg, src in ((PAP, os.path.join(PAP, "audit")),
                     (CLA, os.path.join(CLA, "audit"))):
        build_artifacts(os.path.join(pkg, "zenodo", "audit"))
        copy_scripts(os.path.join(pkg, "zenodo", "audit"), src)


def package_index(pkg):
    """manifest rows plus the sets of package paths and basenames"""
    zroot = os.path.join(pkg, "zenodo")
    rows, paths, basenames, bad = [], set(), set(), []
    for dirpath, dirnames, filenames in os.walk(zroot):
        for fn in sorted(filenames):
            p = os.path.join(dirpath, fn)
            rel = os.path.relpath(p, zroot).replace("\\", "/")
            if fn == "FILE-MANIFEST.txt":
                continue
            with io.open(p, encoding="utf-8", errors="replace") as fh:
                body = fh.read()
            if LOCAL_USER in body or HOME_PATH_RX.search(body):
                bad.append(rel)
            paths.add(rel)
            basenames.add(fn)
            rows.append("%s  %d  %s" % (sha(p), os.path.getsize(p), rel))
    rows.sort(key=lambda r: r.split("  ", 2)[2])
    return rows, paths, basenames, bad


def render_manifest(rows):
    return ("# FILE-MANIFEST -- sha256  bytes  path (relative to this package root)\n"
            "# Generated 2026-09-28 by audit/sanitize-package.py (AI-generated).\n"
            "# Every file of the deposit is listed except this manifest itself; a\n"
            "# publication check re-hashes this list before any outbound act.\n"
            + "\n".join(rows) + "\n")


def manifests(write_manifest=True):
    rc = 0
    for pkg in (PAP, CLA):
        rows, paths, basenames, bad = package_index(pkg)
        target = os.path.join(pkg, "zenodo", "metadata", "FILE-MANIFEST.txt")
        text = render_manifest(rows)
        if write_manifest:
            w(target, text)
        else:
            current = (open(target, encoding="utf-8").read()
                       if os.path.exists(target) else "")
            print("  manifest check: %d files, deposit %s FILE-MANIFEST.txt"
                  % (len(rows), "MATCHES" if current == text else "DOES NOT MATCH"))
            if current != text:
                rc = 1
        if bad:
            print("FAIL: machine-local path present in: %s" % ", ".join(bad))
            rc = 1
    if rc == 0:
        print("PASS: no machine-local user path in any package file")
    return rc


def promises(pkg):
    """every path-shaped token promised in the .tex and in the package README must
    resolve either inside the deposit or in the working repository"""
    zroot = os.path.join(pkg, "zenodo")
    rows, paths, basenames, _ = package_index(pkg)
    tex = os.path.join(pkg, "paper.tex" if "papers" in pkg else "claim.tex")
    readme = os.path.join(zroot, "metadata", "README.md")
    checked, bad = 0, []
    for src, rx in ((tex, re.compile(r"\\texttt\{([^{}]+)\}")),
                    (readme, re.compile(r"\|\s*`([^`|]+)`"))):
        if not os.path.exists(src):
            continue
        text = open(src, encoding="utf-8", errors="replace").read()
        for tok in sorted(set(rx.findall(text))):
            tok = tok.strip("/ ")
            if "/" not in tok or " " in tok or tok.startswith("http"):
                continue
            # relay wire-ids and mathlib module paths are identifiers, not file promises
            if tok.startswith(("anthropic/", "stepfun/", "leanprover/", "Mathlib/")):
                continue
            checked += 1
            base = tok.split("/")[-1]
            ok = (tok in paths or base in basenames
                  or os.path.exists(os.path.join(TASK, tok))
                  or os.path.exists(os.path.join(ROOT, tok))
                  or os.path.isdir(os.path.join(ROOT, tok))
                  or os.path.exists(os.path.join(pkg, tok))
                  or os.path.exists(os.path.join(zroot, tok)))
            if not ok:
                bad.append("%s: %s" % (os.path.basename(src), tok))
    print("promise reconciliation [%s]: %d path-shaped token(s) checked"
          % (os.path.relpath(pkg, ROOT), checked))
    if bad:
        print("FAIL: unresolved promise(s):")
        for b in bad:
            print("   ", b)
        return 1
    print("PASS: every path-shaped promise resolves in the package or repository")
    return 0


def check_zip():
    """READ-ONLY: verify each package zip exists and carries exactly the
    manifest file set (nothing is rebuilt or written; audit round-4 gap)."""
    import zipfile
    rc = 0
    for pkg in (PAP, CLA):
        zpath = os.path.join(pkg, "zenodo-package.zip")
        man = os.path.join(pkg, "zenodo", "metadata", "FILE-MANIFEST.txt")
        if not (os.path.exists(zpath) and os.path.exists(man)):
            print("FAIL: zip or manifest missing for %s" % os.path.relpath(pkg, ROOT))
            rc = 1
            continue
        want = set()
        with io.open(man, encoding="utf-8") as fh:
            for line in fh:
                if line.startswith("#") or not line.strip():
                    continue
                parts = line.rstrip().split("  ")
                if len(parts) == 3:
                    want.add(parts[2])
        want.add("metadata/FILE-MANIFEST.txt")
        with zipfile.ZipFile(zpath) as z:
            got = set(z.namelist())
            drift = sorted(got ^ want)
            bad = []
            for rel in sorted(got & want):
                body = z.read(rel)
                if LOCAL_USER.encode() in body or HOME_PATH_RX.search(body.decode("utf-8", "replace")):
                    bad.append(rel)
        print("zip check [%s]: entries=%d manifest=%d set-diff=%s local-path-hits=%s"
              % (os.path.relpath(pkg, ROOT), len(got), len(want),
                 drift if drift else "NONE", bad if bad else "none"))
        if drift or bad:
            rc = 1
    if rc == 0:
        print("PASS: zips match their manifests and carry no machine-local path")
    return rc


def check_only():
    rc = manifests(write_manifest=False)
    for pkg in (PAP, CLA):
        rc = promises(pkg) or rc
    return rc


if __name__ == "__main__":
    if "--check-only" in sys.argv:
        raise SystemExit(check_only())
    if "--assert-promises" in sys.argv:
        raise SystemExit(promises(PAP) or promises(CLA))
    if "--check-zip" in sys.argv:        # READ-ONLY zip verification
        raise SystemExit(check_zip())
    sync_packages()
    raise SystemExit(manifests())
