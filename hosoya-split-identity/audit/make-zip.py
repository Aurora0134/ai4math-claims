#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Build claims/hosoya-split-identity/zenodo-package.zip from the zenodo/
tree and assert the entry set equals FILE-MANIFEST.txt (SOP 08b step 4).

AI-generated 2026-09-29.
"""
import io
import os
import sys
import zipfile

ROOT = os.environ.get("AI4MATH_REPO",
                      os.path.abspath(os.path.join(os.path.dirname(__file__),
                                                   os.pardir, os.pardir, os.pardir)))
CLA = os.path.join(ROOT, "claims", "hosoya-split-identity")
ZROOT = os.path.join(CLA, "zenodo")
ZIP = os.path.join(CLA, "zenodo-package.zip")
MAN = os.path.join(ZROOT, "metadata", "FILE-MANIFEST.txt")


def files():
    out = []
    for dirpath, dirnames, filenames in os.walk(ZROOT):
        for fn in sorted(filenames):
            p = os.path.join(dirpath, fn)
            out.append(os.path.relpath(p, ZROOT).replace("\\", "/"))
    return sorted(out)


def manifest_set():
    rows = set()
    with io.open(MAN, encoding="utf-8") as fh:
        for line in fh:
            line = line.rstrip("\n")
            if not line or line.startswith("#"):
                continue
            rows.add(line.split("  ", 2)[2])
    return rows


def main():
    fs = files()                      # includes FILE-MANIFEST.txt itself
    mset = manifest_set()             # excludes it by construction
    expect = set(mset) | {"metadata/FILE-MANIFEST.txt"}
    if set(fs) != expect:
        print("FAIL: disk set != manifest set + manifest")
        print("  only on disk:", sorted(set(fs) - expect))
        print("  only promised:", sorted(expect - set(fs)))
        return 1
    if os.path.exists(ZIP):
        os.remove(ZIP)
    with zipfile.ZipFile(ZIP, "w", zipfile.ZIP_DEFLATED) as z:
        for rel in fs:
            z.write(os.path.join(ZROOT, rel), rel)
    with zipfile.ZipFile(ZIP) as z:
        names = sorted(z.namelist())
    assert names == fs, "zip entry set mismatch"
    print("PASS: %s (%d entries, == manifest set + manifest)"
          % (os.path.relpath(ZIP, ROOT), len(names)))
    return 0


if __name__ == "__main__":
    sys.exit(main())