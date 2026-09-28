#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Generate zenodo/metadata/FILE-MANIFEST.txt for claims/grid3n-sidemid-notch:
one row per deposit file (sha256, byte size, package-relative path), excluding
the manifest itself. Re-run after any package change, then re-run the gate:
  python claims/grid3n-sidemid-notch/audit/build-manifest.py
  python scripts/sanitize-package.py claims/grid3n-sidemid-notch

AI-generated 2026-09-28. Read-only with respect to everything else.
"""
import hashlib
import io
import os
import sys

ROOT = os.environ.get("AI4MATH_REPO", ".")
PKG = "claims/grid3n-sidemid-notch/zenodo"
MAN = os.path.join(PKG, "metadata", "FILE-MANIFEST.txt")


def sha(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for c in iter(lambda: fh.read(1 << 16), b""):
            h.update(c)
    return h.hexdigest()


def tree(pkg):
    out = []
    for dirpath, _dirs, files in os.walk(pkg):
        for f in files:
            out.append(os.path.relpath(os.path.join(dirpath, f), pkg).replace("\\", "/"))
    return sorted(out)


def main():
    pkg = os.path.join(ROOT, PKG)
    man = os.path.join(ROOT, MAN)
    files = tree(pkg)
    rows = []
    for rel in files:
        fp = os.path.join(pkg, rel)
        if os.path.abspath(fp) == os.path.abspath(man):
            continue
        rows.append((sha(fp), os.path.getsize(fp), rel))
    head = [
        "# FILE-MANIFEST.txt -- sha256  bytes  path (relative to this package root)",
        "# Generated 2026-09-28 by audit/build-manifest.py (AI-generated). Every file",
        "# of the deposit is listed except this manifest itself; a publication check",
        "# re-hashes this list before any outbound act. rows = %d ; deposit = %d files"
        % (len(rows), len(files)),
        "",
    ]
    body = ["%s  %8d  %s" % (s, n, rel) for s, n, rel in rows]
    io.open(man, "w", encoding="utf-8", newline="\n").write("\n".join(head + body) + "\n")
    print("written: %s (%d rows; deposit %d files incl. manifest)" % (MAN, len(rows), len(files)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
