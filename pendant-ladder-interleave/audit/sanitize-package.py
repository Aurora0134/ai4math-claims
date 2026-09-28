#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Package sync, desensitisation and promise reconciliation for the
pendant-ladder-interleave claim deposit (SOP 08b steps 4-5). Adapted from
claims/chorded-cycle-mod4/audit/sanitize-package.py, trimmed to a single
claim-lane package (no papers/ side, no phase0 data dir: the note promises
scripts to remain in the working repository, not in the deposit).

Per package (claims/pendant-ladder-interleave):
  1. rebuild zenodo/audit/audit-axioms-sidecar.log from the task's axiom
     output (already clean: four "depends on axioms" lines, no machine paths);
  2. rebuild zenodo/audit/audit-strict-compile.log from the task's strict log
     (EMPTY by design: stdout of the strict re-compile is empty = 0 error
     0 warning; the EXIT=0 evidence is the final audit record), headed by a
     note saying so;
  3. ship the tooling scripts with the repository root read from the
     environment and no literal local path anywhere;
  4. write or verify zenodo/metadata/FILE-MANIFEST.txt (sha256 + bytes);
  5. reconcile every path-shaped promise made in the .tex and in the package
     README against the deposit and the working repository.

Usage (from anywhere):
  python .../sanitize-package.py                    # sync + write manifest + checks
  python .../sanitize-package.py --check-only       # READ-ONLY: verify manifest and
                                                    # promises; writes nothing
  python .../sanitize-package.py --assert-promises  # promise gate only
Exit 0 = every gate green. Run --check-only before any outbound act.

AI-generated 2026-09-28. Writes only under claims/pendant-ladder-interleave/zenodo/.
"""
import hashlib
import io
import os
import re
import sys

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
TASK = os.path.join(ROOT, "tasks", "20260927-mossad-pend")
CLA = os.path.join(ROOT, "claims", "pendant-ladder-interleave")
LOCAL = os.path.expanduser("~").replace("\\", "/")
LOCAL_USER = os.path.basename(LOCAL)   # scanned for, never written into a file
# generic detector for machine-local home paths; the tool itself carries no literal one
HOME_PATH_RX = re.compile(r"[A-Za-z]:[/\\]+Users[/\\]+[^/\\s]+", re.I)


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
    ax = open(os.path.join(TASK, "final", "axioms.out"),
              encoding="utf-8", errors="replace").read().split("\n")
    keep = [l for l in ax if "depends on axioms" in l]
    w(os.path.join(dst_audit, "audit-axioms-sidecar.log"),
      "# axiom printout (#print axioms for the four declarations): the complete\n"
      "# content of the task's final/axioms.out -- four lines, no machine paths.\n"
      "# The audit's independent re-run (audit/recheck/axioms-recheck.out, also\n"
      "# shipped here) is byte-identical to it (final-01-pend.txt, check 5).\n"
      + "\n".join(keep) + "\n")
    strict = open(os.path.join(TASK, "final", "strict.out"),
                  encoding="utf-8", errors="replace").read()
    w(os.path.join(dst_audit, "audit-strict-compile.log"),
      "# strict re-compile of final/01-pend-proved.lean (Lean v4.34.0 +\n"
      "# mathlib4 v4.34.0). The run's stdout is EMPTY (0 error, 0 warning) by\n"
      "# design -- the task's final/strict.out is a zero-byte file. The EXIT=0\n"
      "# evidence is the audit department's two independent re-runs recorded in\n"
      "# final-01-pend.txt (checks 4-5: 70.0s strict / 41.3s axioms, byte-\n"
      "# identical outputs).\n"
      "# --- original stdout (empty) follows ---\n" + depath(strict))


def copy_scripts(pkg_audit, src_dir):
    for name in ("inspect-tex.py", "build-c9-record.py", "sanitize-package.py",
                 "make-zip.py"):
        s = os.path.join(src_dir, name)
        if os.path.exists(s):
            w(os.path.join(pkg_audit, name), script_clean(s))


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
    rows, paths, basenames, bad = package_index(CLA)
    target = os.path.join(CLA, "zenodo", "metadata", "FILE-MANIFEST.txt")
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
    tex = os.path.join(pkg, "claim.tex")
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
            # relay wire-ids and toolchain/module paths are identifiers, not file promises
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


def check_only():
    rc = manifests(write_manifest=False)
    rc = promises(CLA) or rc
    return rc


if __name__ == "__main__":
    if "--check-only" in sys.argv:
        raise SystemExit(check_only())
    if "--assert-promises" in sys.argv:
        raise SystemExit(promises(CLA))
    build_artifacts(os.path.join(CLA, "zenodo", "audit"))
    copy_scripts(os.path.join(CLA, "zenodo", "audit"),
                 os.path.join(CLA, "audit"))
    raise SystemExit(manifests())
