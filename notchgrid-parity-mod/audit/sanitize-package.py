#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Package reconciliation gate for the notchgrid-parity-mod claim deposit
(SOP 08b steps 4-5; the gate made mandatory by harness/departments/08b-claim.md
"已知边界": 出包前必跑 sanitize-package.py --check-only（或 --assert-promises）：
清单一致性、路径型承诺对账、无本机路径三项任一不绿即不得外发).

Derived from claims/pendant-ladder-interleave/audit/sanitize-package.py (itself derived
from claims/chorded-cycle-mod4/audit/sanitize-package.py), trimmed to this package: the
axiom printout, the key-line extracts and the C9 record already ship here as their own
files, so nothing is rebuilt -- this tool only AUDITS the tree and writes
zenodo/metadata/FILE-MANIFEST.txt when every gate is green.

Three gates, all reflected in the exit code:
  1. manifest consistency: zenodo/metadata/FILE-MANIFEST.txt lists every file of the
     deposit (its own line excepted) with the sha256 and byte size found on disk, and the
     totals declared in zenodo/metadata/README.md ("N 文件 / M 字节") agree;
  2. promise reconciliation: every PATH-shaped token in a claim surface resolves either
     inside the deposit or in the working repository, and every file name ATTACHED to a
     containment phrase ("in this package", "in the deposit", 本包, 包内) -- bare names
     included -- resolves INSIDE the deposit;
  3. no machine-local path: no home-directory path and no literal local username anywhere
     in the deposit.

THE BLIND SPOT FIXED HERE (root cause of finding N1 in audit/claim-recheck.md): the
inherited promises() loop skipped every token without a "/" --
    if "/" not in tok or " " in tok or tok.startswith("http"): continue
so a bare file name promised as being inside the deposit was never checked, and UPLOAD.md
(with budget.log and card.md) is not shipped. The PASS results recorded by the two
precedent packages carry the same blind spot. Rule (b) below is new: a file name attached
to a containment locator must ship.

Attachment is decided per clause (a clause is a run of text delimited by , ; : ( ) quotes,
a backtick, or a sentence end) and, inside a clause, by which locator is nearer to the
token: a containment locator ("in this package", 本包, 包内, "in the deposit") means the
deposit; a repository locator ("source repository", "deliverable directory", "the task
directory", 源仓, 源任务, "not publicly retrievable") means the working repository, and the
token then only has to resolve somewhere.

Known limits, stated rather than hidden (they bound what a PASS means):
  - negation guard: a clause that says the opposite ("does NOT ship", 不随包出, 不在本包)
    is reported as info, not as a failure. The guard exists because shipped records quote
    the very wording they adjudicate; the price is that a clause mixing a false promise
    with an unrelated negation can pass.
  - rule (a) only checks a path-shaped token when its first segment names a directory of
    this repository or of this deposit (REPO_SEGMENTS); a slashed name whose first segment
    is anything else -- the mathlib module path "SimpleGraph/Matching.lean", quoted in the
    note as something the library-layer search did NOT find -- is read as an identifier and
    printed as such, not silently dropped.
  - clause segmentation is punctuation-based, so a promise phrased without punctuation
    adjacency can escape attachment. The scanned surfaces and the checked counts are
    printed so a reviewer can re-read them by hand.
  - the verbatim evidence copies and the archival logs are excluded from the containment
    rule by design: they must stay byte-identical, and they contain the phrasings under
    adjudication. Concretely the exclusion covers the three gate-3 verdict copies
    (claim-check.md, claim-recheck.md, claim-recheck2.md, claim-recheck3.md), the C9 query record, the lint
    transcript, the nine raw tectonic logs (each of run2..run8 echoes the Data availability
    wording that finding N1 judged false -- twice, one per cross-reference pass), this
    tool's own source, the two Lean source artefacts, the toolchain pin, lstlean.tex, the
    rendered PDF and the generated manifest. The list and its reasons are printed by gate 2,
    and since finding F-b its COMPLETENESS is gated too: scanned + declared-not-scanned must
    equal the number of files on disk, otherwise gate 2 FAILS. That arithmetic is the fix;
    the logs themselves are not rewritten, because editing archive evidence would be worse
    than an honest gap.
  - still NOT in the rule's range (the residual hole finding F-a of audit/claim-recheck2.md
    describes): an imperative pointer of the shape "see audit/<file>" or "quoted from
    audit/<file>" that names a repository file which does not ship. Rule (a) lets it through
    because the path resolves somewhere in the working repository, and rule (b) never engages
    because such a clause carries no containment locator. F-a was closed by rewording the
    four occurrences to give the full repository path plus an explicit "not shipped with this
    deposit" note; converting that sentence shape into a machine rule is left as a proposal
    for the user, since a rule keyed on bare "see <path>" would also fire on legitimate
    pointers to files that genuinely ship.

Usage (from anywhere; run from the repository root for the recorded output):
  python claims/notchgrid-parity-mod/audit/sanitize-package.py          # gates + write manifest
  python claims/notchgrid-parity-mod/audit/sanitize-package.py --check-only
        # READ-ONLY: all three gates against the tree as it stands; writes nothing
  python claims/notchgrid-parity-mod/audit/sanitize-package.py --assert-promises
        # gate 2 only
  python claims/notchgrid-parity-mod/audit/sanitize-package.py --selftest
        # proves rule (b) bites: the pre-fix N1 sentence must FAIL the rule and the
        # replaced sentence, and a true containment promise, must pass
Exit 0 = every gate green. Run --check-only before any outbound act, and regenerate the
manifest whenever any shipped file changes.

AI-generated 2026-09-28 (claim lane, dept-paper). No literal machine-local path is written
anywhere in this file: the repository root is discovered by walking up from this script and
the home path is computed at run time, so the copy shipped under zenodo/audit/ is
byte-identical to this one.
"""
import hashlib
import io
import os
import re
import sys

EXTS = ("tex", "pdf", "md", "txt", "json", "lean", "out", "log", "py", "zip", "sh",
        "bib", "bbl", "cls", "sty", "clo", "fls", "aux")
# identifiers that look like paths but are not file promises
IDENT_PREFIX = ("anthropic/", "stepfun/", "leanprover/", "Mathlib/", "openai/", "http")
# first path segments that make a path-shaped token a promise about this repository or
# about this deposit; anything else with a slash is an identifier (a mathlib module path
# quoted as a search string, a tool module path), printed and not existence-checked
REPO_SEGMENTS = ("audit", "claim", "claims", "metadata", "proofs", "papers", "tasks",
                 "formalized", "final", "attempts", "harness", "scripts", "logs", "docs",
                 "phase0", "zenodo", "verify-proj", "candidates", "dag", "c9-recheck",
                 "Library")
# first path segments that make a path-shaped token a promise about THIS repository or
# THIS deposit. Anything else with a slash (a mathlib module path quoted as a search
# string, e.g. "SimpleGraph/Matching.lean", or a tool module path) is an identifier and is
# not checked for existence: the note cites it as something searched for, not as something
# it ships. Rule (b) is unaffected: it looks at file names, wherever they sit.
REPO_SEGMENTS = ("audit", "claim", "claims", "metadata", "proofs", "papers", "tasks",
                 "formalized", "final", "attempts", "harness", "scripts", "logs", "docs",
                 "phase0", "zenodo", "verify-proj", "candidates", "dag", "report.md",
                 "c9-recheck", "Library")
CONTAIN_RX = re.compile(r"(in this package|inside this package|kept in this package"
                        r"|shipped in full in this package|in this bundle|in the deposit"
                        r"|本包|包内)", re.I)
REPO_RX = re.compile(r"(source repository|working repository|repository root|the repo"
                     r"|deliverable director|source task|task directory|not publicly"
                     r"|not retrievable|in the ai4math repository|源仓|源任务|仓库根"
                     r"|deliverable 目录)", re.I)
NEGATE_RX = re.compile(r"(not ship|does not|do not|not part of|not among|not one of"
                       r"|not copied|no part of|不在本包|不随包|未随包|留在源|不含)", re.I)
# a period ends a clause unless it is the dot of a file name
_NOT_FILE_DOT = "".join("(?<!\\.%s)" % e for e in EXTS)
CLAUSE_SPLIT_RX = re.compile(r"[,;:()、，；：（）。！？]|" + _NOT_FILE_DOT + r"\.(?=\s)")
FILE_RX = re.compile(r"[A-Za-z0-9_.+-]+\.(?:%s)" % "|".join(EXTS))

def find_root(here):
    d = os.path.abspath(here)
    while True:
        if os.path.isdir(os.path.join(d, "scripts")) and os.path.isdir(os.path.join(d, "claims")):
            return d
        up = os.path.dirname(d)
        if up == d:
            return os.path.abspath(".")
        d = up


ROOT = os.environ.get("AI4MATH_REPO") or find_root(os.path.dirname(os.path.abspath(__file__)))
TASK = os.path.join(ROOT, "tasks", "20260927-mossad-notch")
SELECT = os.path.join(ROOT, "tasks", "20260927-mossad-select")
CLA = os.path.join(ROOT, "claims", "notchgrid-parity-mod")
ZROOT = os.path.join(CLA, "zenodo")
MANIFEST = os.path.join(ZROOT, "metadata", "FILE-MANIFEST.txt")
README = os.path.join(ZROOT, "metadata", "README.md")
NOTE_TEX = os.path.join(ZROOT, "claim", "claim.tex")
NOTE_JSON = os.path.join(ZROOT, "metadata", "zenodo.json")

LOCAL = os.path.expanduser("~").replace("\\", "/")
LOCAL_USER = os.path.basename(LOCAL)          # scanned for, never written into a file
HOME_PATH_RX = re.compile(r"[A-Za-z]:[/\\]+Users[/\\]+[^/\\s]+", re.I)

# files deliberately NOT scanned for containment promises (reason printed, and the
# completeness of this list is itself gated -- see the coverage accounting in
# gate_promises, added after finding F-b of audit/claim-recheck2.md: the list used to
# under-report, printing 15 scanned + 10 skipped against a 35-file tree, because the nine
# raw compile logs and this tool's own source were neither scanned nor declared)
SKIP_SCAN = {
    "audit/c9-record.md": "C9 query record: verbatim source text, quoted wordings included",
    "audit/claim-check.md": "gate-3 first-round verdict: verbatim auditor copy (user ruling: unaltered)",
    "audit/claim-recheck.md": "gate-3 second-round verdict: verbatim auditor copy, quotes the N1 wording",
    "audit/claim-recheck2.md": "gate-3 third-round verdict: verbatim auditor copy, quotes the F-a and F-b wordings it adjudicates",
    "audit/claim-recheck3.md": "gate-3 fourth-round verdict: verbatim auditor copy, quotes the G1 wordings it adjudicates",
    "audit/lint.txt": "static-gate transcript: echoes lines of the file it scanned",
    "audit/sanitize-package.py": "this gate's own source, kept byte-identical to the repository copy; scanning the scanner would be self-reference",
    "claim/claim.pdf": "rendered binary",
    "claim/lstlean.tex": "byte copy of harness/templates/paper/lstlean.tex",
    "metadata/FILE-MANIFEST.txt": "generated inventory",
    "proofs/01-notch-mods.lean": "frozen Lean statement, verbatim source artefact",
    "proofs/01-notch-proved.lean": "final Lean development, verbatim source artefact",
    "proofs/lean-toolchain": "toolchain pin",
}
# the ten raw tectonic logs: a typesetter echoes the .tex it compiles, so each log replays
# the Data availability sentence of its own round -- and for rounds 2-8 that replay IS the
# wording finding N1 adjudicated false. Measured 2026-09-28: every one of run2..run8 carries
# the echo twice (one per cross-reference pass, inside Underfull \hbox diagnostics), while
# run1 predates the sentence (0 hits) and run9 postdates the fix (0 hits). Archival logs are
# evidence and are not written back over; the fix is to declare them here, not to edit them.
# Recorded in audit/compile.txt's reading note and in zenodo/metadata/README.md.
_COMPILE_LOG_WHY = ("raw tectonic log of compile round %d: verbatim typesetter echo of that "
                    "round's .tex; %s; archival logs are not written back over, so they are "
                    "declared out of scope here rather than corrected -- see the reading note "
                    "in audit/compile.txt")
_ECHO_YES = ("it replays the Data availability wording that finding N1 judged false, twice "
             "(one echo per cross-reference pass, inside an Underfull \\hbox diagnostic)")
_ECHO_NO = ("it carries 0 replays of that wording -- round 1 predates the sentence, round 9 "
            "postdates the correction (both measured 2026-09-28), round 10 (2026-09-29) "
            "re-measured 0 as well (the corrected wording persisted)")
for _r in range(1, 11):
    SKIP_SCAN["audit/compile-run%d.log" % _r] = _COMPILE_LOG_WHY % (_r,
                                                                   _ECHO_YES if 2 <= _r <= 8
                                                                   else _ECHO_NO)


def sha(path):
    with open(path, "rb") as fh:
        return hashlib.sha256(fh.read()).hexdigest()


def read(path):
    with io.open(path, encoding="utf-8", errors="replace") as fh:
        return fh.read()


def package_index():
    rows, paths, basenames, bad = [], set(), set(), []
    for dirpath, _dirnames, filenames in os.walk(ZROOT):
        for fn in sorted(filenames):
            p = os.path.join(dirpath, fn)
            rel = os.path.relpath(p, ZROOT).replace("\\", "/")
            if rel == "metadata/FILE-MANIFEST.txt":
                continue
            body = read(p)
            if (LOCAL_USER and LOCAL_USER in body) or HOME_PATH_RX.search(body):
                bad.append(rel)
            paths.add(rel)
            basenames.add(fn)
            rows.append("%s  %d  %s" % (sha(p), os.path.getsize(p), rel))
    rows.sort(key=lambda r: r.split("  ", 2)[2])
    return rows, paths, basenames, bad


def totals():
    n = nb = 0
    for dirpath, _d, filenames in os.walk(ZROOT):
        for fn in filenames:
            n += 1
            nb += os.path.getsize(os.path.join(dirpath, fn))
    return n, nb


def package_files():
    """Every file of the deposit tree, this manifest included (package_index() excludes the
    manifest because a manifest cannot hash itself). Used by the coverage accounting of
    gate 2, which makes the gate's own surface list verifiable: finding F-b of
    audit/claim-recheck2.md was that the printed "scanned / not scanned" report described
    25 of 35 files, so a reader could mistake a partial scan for a complete one."""
    rels = set()
    for dirpath, _d, filenames in os.walk(ZROOT):
        for fn in filenames:
            rels.add(os.path.relpath(os.path.join(dirpath, fn), ZROOT).replace("\\", "/"))
    return rels


def render_manifest(rows, n, nb):
    return ("# FILE-MANIFEST -- sha256  bytes  path (relative to this package root)\n"
            "# Generated 2026-09-28 by audit/sanitize-package.py (AI-generated) after the\n"
            "# three reconciliation gates (manifest consistency / promise reconciliation /\n"
            "# no machine-local path) reported PASS. Regenerate this file whenever any\n"
            "# shipped file changes; a publication check re-hashes this list first.\n"
            "# The deposit tree holds %d files and %d bytes, this manifest included; the\n"
            "# %d rows below list every other file (a manifest cannot hash itself), so the\n"
            "# two views reconcile by adding this file's own size.\n"
            % (n, nb, len(rows))
            + "\n".join(rows) + "\n")


def build_manifest_text():
    """fixed point on the manifest's own size: the tree totals it declares have to
    include the manifest, which is not one of the rows it lists"""
    rows, _p, _b, _bad = package_index()
    b0 = 0
    for r in rows:
        b0 += int(r.split("  ")[1])
    n = len(rows) + 1
    size = 4096
    text = ""
    for _ in range(8):
        text = render_manifest(rows, n, b0 + size)
        new = len(text.encode("utf-8"))
        if new == size:
            break
        size = new
    return text, n, b0 + size


def gate_manifest(write=True):
    if write:
        text, wn, wnb = build_manifest_text()
        os.makedirs(os.path.dirname(MANIFEST), exist_ok=True)
        with io.open(MANIFEST, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(text)
        nrows = len([l for l in text.split("\n") if l and not l.startswith("#")])
        print("  wrote %s (%d B, %d rows)"
              % (os.path.relpath(MANIFEST, ROOT).replace("\\", "/"),
                 len(text.encode("utf-8")), nrows))
        print("  totals to declare in the live records: %d files / %s bytes"
              % (wn, format(wnb, ",")))
        return 0
    rows, _paths, _basenames, _bad = package_index()
    n, nb = totals()
    rc = 0
    current = read(MANIFEST) if os.path.exists(MANIFEST) else ""
    if not current:
        print("FAIL: FILE-MANIFEST.txt missing")
        return 1
    want_paths = [r.split("  ", 2)[2] for r in rows]
    have_paths = [l.split("  ", 2)[2] for l in current.split("\n")
                  if l and not l.startswith("#")]
    want_line = dict((r.split("  ", 2)[2], r) for r in rows)
    missing = [p for p in want_paths if p not in have_paths]
    extra = [p for p in have_paths if p not in want_paths]
    stale = []
    for line in current.split("\n"):
        if not line or line.startswith("#"):
            continue
        parts = line.split("  ")
        if len(parts) == 3 and parts[2] in want_line and want_line[parts[2]] != line:
            stale.append(parts[2])
    print("  manifest rows on disk: %d ; files now in deposit (self excluded): %d"
          % (len(have_paths), len(want_paths)))
    for label, items in (("missing from manifest", missing), ("phantom in manifest", extra),
                         ("stale hash/size in manifest", stale)):
        if items:
            print("FAIL: %s: %s" % (label, ", ".join(sorted(items))))
            rc = 1
    m = re.search(r"(\d+)\s*个?文件\s*/\s*([\d,]+)\s*字节", read(README))
    if not m:
        print("FAIL: README declares no package totals (N 文件 / M 字节)")
        rc = 1
    else:
        rn, rb = int(m.group(1)), int(m.group(2).replace(",", ""))
        if (rn, rb) != (n, nb):
            print("FAIL: README totals %d files / %d bytes != actual %d files / %d bytes"
                  % (rn, rb, n, nb))
            rc = 1
        else:
            print("  README totals match the tree: %d files / %d bytes" % (n, nb))
    if rc == 0:
        print("PASS: FILE-MANIFEST.txt matches the deposit tree and the README totals")
    return rc


def gate_machine_paths():
    _rows, _paths, _basenames, bad = package_index()
    if bad:
        print("FAIL: machine-local path or username present in: %s" % ", ".join(sorted(set(bad))))
        return 1
    print("PASS: no machine-local user path in any package file")
    return 0


def shaped(tok):
    t = tok.strip("/ ().,;:`'\"")
    if not t or " " in t or "{" in t or "}" in t or chr(92) in t or "%" in t \
            or t.startswith("http"):
        return None
    if any(t.startswith(p) for p in IDENT_PREFIX):
        return None
    return t


def resolves(t, basenames):
    base = t.split("/")[-1]
    if base in basenames:
        return "deposit"
    for c in (os.path.join(ZROOT, t), os.path.join(CLA, t), os.path.join(ROOT, t),
              os.path.join(TASK, t), os.path.join(SELECT, t)):
        if os.path.exists(c) or os.path.isdir(c):
            if os.path.abspath(c).startswith(os.path.abspath(ZROOT)):
                return "deposit"
            return "repository"
    return None


def clauses(text):
    return [c for c in CLAUSE_SPLIT_RX.split(text) if c and c.strip()]


def nearest(rx, clause, start):
    best = None
    for m in rx.finditer(clause):
        d = abs(m.start() - start)
        if best is None or d < best:
            best = d
    return best


def expectation(clause, start):
    """'deposit' when a containment locator is nearer than any repository locator"""
    dc = nearest(CONTAIN_RX, clause, start)
    if dc is None:
        return "any"
    dr = nearest(REPO_RX, clause, start)
    if dr is not None and dr < dc:
        return "any"
    return "deposit"


def containment_hits(text, path_tokens, basenames):
    """rule (b): a file name attached to a containment locator must resolve in the deposit.
    Returns (need, info, n): need = [(token, where_it_actually_resolves)] failures,
    info = the same shape for clauses that negate the containment (quoted findings),
    n = how many token/clause pairs were put to the deposit test."""
    need, info, n = [], [], 0
    for cl in clauses(text):
        if not CONTAIN_RX.search(cl):
            continue
        neg = bool(NEGATE_RX.search(cl))
        cands = {}
        for m in FILE_RX.finditer(cl):
            if m.start() > 0 and cl[m.start() - 1] == "/":
                continue          # tail of a path-shaped token, not a separate promise
            t = shaped(m.group(0))
            if t:
                cands.setdefault(t, m.start())
        for t in path_tokens:
            i = cl.find(t)
            if i >= 0 and (t not in cands or i < cands[t]):
                cands[t] = i
        for t, pos in sorted(cands.items(), key=lambda kv: kv[1]):
            if expectation(cl, pos) != "deposit":
                continue
            n += 1
            where = resolves(t, basenames)
            if where == "deposit":
                continue
            phrase = CONTAIN_RX.search(cl).group(0)
            (info if neg else need).append((t, where, phrase))
    return need, info, n


def selftest():
    """the blind-spot fix has to be demonstrable: the wording that finding N1 caught must
    FAIL the rule, and the wording that replaced it must pass"""
    _r, _p, basenames, _b = package_index()
    old = ("Artifact package: Zenodo deposit (DOI to be reserved at upload; see "
           "\\texttt{UPLOAD.md} in this package) containing this note")
    new = ("Artifact package: Zenodo deposit (DOI to be reserved at upload; see "
           "\\texttt{UPLOAD.md} in the source repository) containing this note")
    truth = ("The complete development is shipped in full in this package at "
             "\\texttt{proofs/01-notch-proved.lean}")
    zh_old = ("逐项见 `audit/compile-log.txt` 与本包 "
              "`budget.log` 口径")
    zh_new = ("逐项见 `audit/compile-log.txt` 与源仓 deliverable "
              "目录 `claims/notchgrid-parity-mod/budget.log` 口径")
    cases = [("N1 wording before the fix (must FAIL)", old, 1),
             ("N1 wording after the fix (must pass)", new, 0),
             ("a containment promise that is true (must pass)", truth, 0),
             ("README containment(zh) + budget.log (must FAIL)", zh_old, 1),
             ("README repo-locator(zh) + full path (must pass)", zh_new, 0)]
    rc = 0
    for label, text, expect in cases:
        need, info, n = containment_hits(text, set(), basenames)
        got = 1 if need else 0
        print("  selftest %-46s tested=%d hits=%d (expected %s) %s"
              % (label, n, len(need), "fail" if expect else "pass",
                 "OK" if got == expect else "MISMATCH"))
        if got != expect:
            rc = 1
        for t, where, phrase in need:
            print("      would fail on: %s (locator: %s, resolves: %s)"
                  % (t, phrase, where or "nowhere"))
    return rc


def tex_tokens(text):
    """\\texttt spans with allowbreak joins undone and TeX end-of-line comments removed"""
    t = text.replace("%\n", "").replace("}\\allowbreak\\texttt{", "")
    return re.findall(r"\\texttt\{([^{}]*)\}", t) + re.findall(r"\\nolinkurl\{([^{}]*)\}", t)


def md_tokens(text):
    return re.findall(r"`([^`\n]*)`", text) + \
        re.findall(r"/?[A-Za-z0-9_.+-]+\.(?:%s)\b" % "|".join(EXTS), text)


def gate_promises():
    _rows, paths, basenames, _bad = package_index()
    surfaces = [p for p in (NOTE_TEX, README, NOTE_JSON) if os.path.exists(p)]
    for rel in sorted(paths):
        if rel.startswith("audit/") and rel.endswith(".txt") and rel not in SKIP_SCAN:
            surfaces.append(os.path.join(ZROOT, rel))
    rc = 0
    checked = contained = 0
    bad = []
    infos = []
    skipped = []
    detail = []
    for src in surfaces:
        rel_src = os.path.relpath(src, ROOT).replace("\\", "/")
        text = read(src)
        if src.endswith(".tex"):
            toks = tex_tokens(text)
        elif src.endswith(".md"):
            toks = md_tokens(text)
        else:
            toks = FILE_RX.findall(text)
        seen = set()
        for raw in toks:
            t = shaped(raw)
            # rule (a) is the inherited one and stays path-shaped only: a bare word like
            # \texttt{sorry} or \texttt{Int.ModEq} is a Lean token, not a file promise.
            if not t or "/" not in t or t in seen:
                continue
            seen.add(t)
            if t.split("/")[0] not in REPO_SEGMENTS:
                skipped.append(t)
                continue
            checked += 1
            if resolves(t, basenames) is None:
                bad.append("[unresolved] %s: %s" % (rel_src, t))
        # rule (b): a token attached to a containment locator must resolve in the deposit
        need, info, n = containment_hits(text, set(seen), basenames)
        contained += n
        hits = len(CONTAIN_RX.findall(text))
        detail.append("%s: %d containment phrase(s), %d name(s) put to the deposit test"
                      % (rel_src, hits, n))
        for t, where, phrase in need:
            bad.append("[containment] %s: %s promised inside the deposit (locator: %s),"
                       " resolves: %s" % (rel_src, t, phrase, where or "nowhere"))
        for t, where, phrase in info:
            infos.append("[negated containment] %s: %s -> %s (locator: %s)"
                         % (rel_src, t, where or "nowhere", phrase))
    print("promise reconciliation: %d path-shaped token(s) checked for resolvability,"
          " %d file name(s) checked against a containment locator" % (checked, contained))
    if skipped:
        print("  path-shaped tokens treated as identifiers, not file promises (%d): %s"
              % (len(set(skipped)), ", ".join(sorted(set(skipped)))))
    print("  scanned surfaces (%d):" % len(surfaces))
    for d in detail:
        print("    - %s" % d)
    print("  not scanned as promise surfaces (verbatim evidence / binaries / generated"
          " inventory / archival compile logs / this tool), %d file(s):" % len(SKIP_SCAN))
    for rel, why in sorted(SKIP_SCAN.items()):
        print("    - %s : %s" % (rel, why))
    # coverage accounting, added after finding F-b of audit/claim-recheck2.md: the two lists
    # printed above have to describe EVERY file of the tree. Before the fix they described
    # 25 of 35, and a reader who trusted the print would have taken a partial scan for a
    # complete one. The arithmetic is now part of the gate's verdict, not a comment.
    tree = package_files()
    scanned = set(os.path.relpath(s, ZROOT).replace("\\", "/") for s in surfaces)
    undeclared = sorted((tree - scanned) - set(SKIP_SCAN))
    misdeclared = sorted(scanned & set(SKIP_SCAN))
    stale = sorted(set(SKIP_SCAN) - tree)
    print("  coverage accounting: %d scanned + %d declared not scanned = %d ; the deposit"
          " tree holds %d files" % (len(scanned), len(SKIP_SCAN),
                                    len(scanned) + len(SKIP_SCAN), len(tree)))
    if undeclared:
        print("FAIL: coverage self-report incomplete -- in the tree, neither scanned nor"
              " declared skipped: %s" % ", ".join(undeclared))
        rc = 1
    if misdeclared:
        print("FAIL: declared as not scanned but actually scanned: %s" % ", ".join(misdeclared))
        rc = 1
    if stale:
        print("FAIL: declared as not scanned but not on disk: %s" % ", ".join(stale))
        rc = 1
    for i in sorted(set(infos)):
        print("  info: %s" % i)
    if bad:
        print("FAIL: unresolved or mis-promised file reference(s):")
        for b in sorted(set(bad)):
            print("   ", b)
        rc = 1
    if rc == 0:
        print("PASS: every file-shaped promise resolves in the deposit or the repository,"
              " and every containment promise ships")
    return rc


def main():
    try:                        # deterministic output regardless of console code page
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    if "--selftest" in sys.argv:
        print("== containment-rule selftest (the N1 blind spot) ==")
        return selftest()
    if "--assert-promises" in sys.argv:
        return gate_promises()
    check_only = "--check-only" in sys.argv
    print("== gate 2: promise reconciliation ==")
    rc2 = gate_promises()
    print("== gate 3: no machine-local path ==")
    rc3 = gate_machine_paths()
    print("== gate 1: manifest consistency ==")
    if check_only:
        rc1 = gate_manifest(write=False)
    elif rc2 | rc3:
        print("SKIP: FILE-MANIFEST.txt not written, gates 2/3 are not green (SOP 08b:"
              " 三项任一不绿即不得外发)")
        rc1 = 1
    else:
        rc1 = gate_manifest(write=True)
    rc = rc1 | rc2 | rc3
    if rc:
        print("GATE NOT GREEN -> the deposit must not be sent out (SOP 08b 已知边界)")
        return rc
    n, nb = totals()
    print("ALL THREE GATES GREEN: deposit = %d files / %s bytes" % (n, format(nb, ",")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
