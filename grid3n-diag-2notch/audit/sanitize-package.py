#!/usr/bin/env python3
# provenance: frozen byte-identical copy of scripts/sanitize-package.py (repository-level shared tool), copied 2026-09-28 by the claim packager; run as: python claims/grid3n-diag-2notch/audit/sanitize-package.py claims/grid3n-diag-2notch
"""sanitize-package.py — AI4Math 交付包机械对账门（仓库级共享工具）

为什么有这个脚本（2026-09-28，用户裁决「类型级：先停下补工具门」）：
占位通道 `claims/notchgrid-parity-mod` 的门③审计连出三轮同一族缺陷——
  F4  → 短笺写「证据原件已拷入本包 audit/」，原件其实没随包；
  N1  → 短笺写「see UPLOAD.md in this package」，UPLOAD.md 不在存缴树里；
  F-a → 随包转写件用裸 `audit/<file>` 指称不随包件，读者在包内找不到。
每一轮都是人工逐包复审抓出来的，而当时那道门（各包自带的
`claims/<slug>/audit/sanitize-package.py`）能力面有三处缺口，正是它没抓住的：
  缺口一（F-b）：门自己打印「扫描 N 件 + 跳过 M 件」，N+M 与存缴树实档数不符，
                 即「覆盖面自述失真」——读者据该清单会误以为全部随包文本已受检。
  缺口二（F-a）：规则只惩罚「in this package」邻近的裸文件名；对
                 「指向仓库路径但不随包」的指称完全不查。
  缺口三（ED-17/F-1）：批量改写交付件文本后没有结构后检——`\\ref` 里的 `\\r`
                 被转义成裸 CR、Data availability 少一只括号，都能一路绿灯出包。
本工具把这四条缺口做成硬门，任一不绿即 exit 2（不得出包 / 不得外发）。
门 6 专治缺口四：包内件的 locativity 声称（「在本目录」「从根件重拷」）与逐文件
行尾声称（点名某件 = LF / CRLF）必须实测成立，除非同段写明例外范围。

用法（在仓库根或任意位置都可跑，路径自己找）：
  python scripts/sanitize-package.py claims/<slug>            # 三门 + 结构后检
  python scripts/sanitize-package.py papers/<slug> --no-manifest   # 论文轨（SOP 08 未要求清单）
  python scripts/sanitize-package.py claims/<slug> --write-manifest  # 重新生成 FILE-MANIFEST.txt
  python scripts/sanitize-package.py --selftest                # 反证：坏样例必须被抓住
判决：exit 0 = 全绿；exit 2 = 有红灯（逐条打印定位）；exit 1 = 用法/路径错。

红线：本工具只读交付包；唯一写出物是 `--write-manifest` 生成的
`zenodo/metadata/FILE-MANIFEST.txt`。它不做任何外发动作（宪条 6），
也不替代 kernel 终裁、监察院主张审计（宪条 1、4）。
"""
import argparse
import hashlib
import io
import os
import re
import sys

EXTS_TEXT = ("tex", "md", "txt", "json", "lean", "log", "py", "sh", "out")
BIN_OK = ("pdf", "png", "zip")

# 邻近「随包」语义的定位短语 → 该文件名必须真的在存缴树里
CONTAIN_RX = re.compile(
    r"(in this package|inside this package|with(in)? this deposit|shipped (in|with)"
    r"|packed into|copied into|see .{0,40} in this package"
    r"|本包|随包|已入包|拷入)", re.I)
# 邻近「源仓」语义 → 允许指称不随包件，但仍须写明不可公开取回
REPO_RX = re.compile(
    r"(source repository|working repository|repository root|the repo|source tree|source task"
    r"|deliverable directory|not shipped|does not ship|not part of this (deposit|package)"
    r"|not (in|inside|within) this (package|deposit)|kept with the source task"
    r"|stay in the source|源仓|源任务目录|不随包|未随包|不在本包)", re.I)
FILE_RX = re.compile(r"(?:[A-Za-z0-9_.+-]+/)*[A-Za-z0-9_.+-]+\.(?:%s)" % "|".join(EXTS_TEXT + BIN_OK))
NEGATE_RX = re.compile(r"(not |no |never |without |deliberately|nevertheless|as if|would have|the wording under adjudication)", re.I)
# 规则 (c) 只在「指示读者去某个文件里看」的句子里开火；索引行、清单行、
# 以及冻结件头注释里的普通提及不算承诺（否则一上真包就误杀几百处）。
DIRECTION_RX = re.compile(
    r"(see |refer to|recorded in|quoted from|quoting|described in|listed in|details in"
    r"|the output (is )?in|as noted in|documented in|copy of|excerpt[s]? from|quoted in"
    r"|详见|参见|原文在|记录在|摘录自)", re.I)
# 逐字源件目录：宪条 2 冻结件不可改，里面提到任何仓内路径都不算包内承诺缺陷
VERBATIM_DIRS = ("proofs/",)

# 门 6（第 6 轮 F-3 出口；用户 2026-09-28 批准的射程扩展）：
# (i) locativity——包内件声称「某某件就在这个目录里 / 每次返工从根件重拷」时，所指必须
#     真的在存缴树里（或确有同名根件），否则就是自述范围溢出；
# (ii) 逐文件行尾声称——散文点名「某个具名文件 = LF / CRLF / 混合」时，实测该文件比对。
LOCALITY_RX = re.compile(
    r"(in this directory|inside this directory|within this directory|from the root files?"
    r"|root <-> package|root <->|re-?taken from the root)", re.I)
SCOPE_EXCUSE_RX = re.compile(
    r"(no such root file|have no root|exist only inside the deposit|only inside the deposit"
    r"|no root counterpart|package-external|留在源仓|包外|不随包)", re.I)
LINECLAIM_RX = re.compile(r"(LF[ -]?only|with LF|LF endings|CRLF|mixed CRLF|line ending)", re.I)
LF_CLAIM_RX = re.compile(r"(LF[ -]?only|with LF\b|LF endings|written with LF|carried with LF)", re.I)
CRLF_CLAIM_RX = re.compile(r"(CRLF|mixed line ending)", re.I)

# 声明不扫描的默认策略：每条都给理由，覆盖面门才能被核对（F-b 族的正解）。
# 这些件要么逐字不可改（冻结件、审计留档、C9 记录、归档编译日志），要么是二进制/
# 生成物/工具自身——对它们跑散文承诺对账只会造出无法修的噪音。
NOT_SCANNED_WHY = (
    ("^proofs/", "verbatim frozen Lean source (constitution 2: may not be edited to satisfy a prose gate)"),
    ("^audit/compile-run.*\\.log$", "raw tectonic log: archival echo of the wording under adjudication, kept verbatim"),
    ("\\.(pdf|png)$", "binary rendering / raster evidence, no prose promises"),
    ("(check|recheck)\\d*\\.md$", "audit verdict copy, verbatim by user ruling; it quotes repository paths as instructions to the main agent"),
    ("sanitize-package(\\.py|\\.txt)$", "this gate's own source and run log"),
    ("FILE-MANIFEST\\.txt$", "generated inventory (rows, not prose)"),
    ("c9-record\\.md$", "verbatim C9 search record (SOP 08b: conclusions may not be rewritten)"),
)


def not_scanned_reason(rel):
    for pat, why in NOT_SCANNED_WHY:
        if re.search(pat, rel):
            return why
    return None
HOME_RX = re.compile(r"[A-Za-z]:[/\\\\]+Users[/\\\\]+[^/\\\\s]+", re.I)


def find_root(start):
    d = start
    while True:
        if os.path.isdir(os.path.join(d, "harness")) and os.path.isdir(os.path.join(d, "scripts")):
            return d
        p = os.path.dirname(d)
        if p == d:
            return None
        d = p


def read(path):
    try:
        return io.open(path, encoding="utf-8").read()
    except UnicodeDecodeError:
        return io.open(path, encoding="utf-8", errors="replace").read()


def tree(pkg):
    out = []
    for dirpath, _dirs, files in os.walk(pkg):
        for f in files:
            out.append(os.path.relpath(os.path.join(dirpath, f), pkg).replace("\\", "/"))
    return sorted(out)


def sha(p):
    h = hashlib.sha256()
    with open(p, "rb") as fh:
        for c in iter(lambda: fh.read(1 << 16), b""):
            h.update(c)
    return h.hexdigest()


# ---------------------------------------------------------------- gate 1 清单
def gate_manifest(pkg, rows_expect, want, report):
    man = os.path.join(pkg, "metadata", "FILE-MANIFEST.txt")
    if want and not os.path.isfile(man):
        report.append("RED[manifest] FILE-MANIFEST.txt 缺失（SOP 08b 要求的随包清单）: %s" % man)
        return False
    if not os.path.isfile(man):
        return True
    ok = True
    listed = []
    for line in read(man).splitlines():
        m = re.match(r"^\s*(?:[0-9a-f]{40,}\s+)?(\d+)\s+(\S+/\S+)", line)
        if m:
            listed.append((m.group(2), int(m.group(1))))
    names = set(n for n, _ in listed)
    disk = set(rows_expect)
    miss = sorted(disk - names)
    ghost = sorted(names - disk)
    if miss:
        ok = False
        report.append("RED[manifest] 盘上有、清单无（漏登记）: %s" % ", ".join(miss))
    if ghost:
        ok = False
        report.append("RED[manifest] 清单有、盘上无（幻影条目）: %s" % ", ".join(ghost))
    base = os.path.dirname(man)
    for name, size in listed:
        fp = os.path.join(pkg, name)
        if os.path.isfile(fp) and os.path.getsize(fp) != size:
            ok = False
            report.append("RED[manifest] 字节数过期: %s 清单 %d 实测 %d" % (name, size, os.path.getsize(fp)))
    _ = base
    return ok


# ---------------------------------------------------------- gate 2 指称对账
def gate_promises(pkg, scan_list, report):
    """规则 (b) 随包承诺 + 规则 (c) 不随包指称必须带明示（缺口二）。"""
    allf = tree(pkg)
    names = set(allf)
    basenames = set(os.path.basename(n) for n in allf)
    scan_list = [f for f in scan_list if not f.startswith(VERBATIM_DIRS)]
    ok = True
    hits = 0
    for rel in scan_list:
        text = read(os.path.join(pkg, rel))
        for raw in text.splitlines():
            line = raw.strip()
            if not line or line.startswith("#") and "sanitize" in line:
                continue
            for m in FILE_RX.finditer(line):
                tok = m.group(0)
                ctx_lo = max(0, m.start() - 90)
                clause = line[ctx_lo:m.start()] + line[m.end():m.end() + 90]
                stem = os.path.basename(tok)
                in_tree = tok in names or stem in basenames
                if CONTAIN_RX.search(clause) and not REPO_RX.search(clause) and not NEGATE_RX.search(clause) and not in_tree:
                    ok = False
                    hits += 1
                    report.append("RED[promise] %s: 承诺随包但树内没有 -> %s" % (rel, tok))
                elif (not in_tree) and DIRECTION_RX.search(clause):
                    # 规则 (c)：指示读者去看的仓内路径不随包，又没写明「源仓/不随包」（F-a 族）
                    if not REPO_RX.search(clause) and not NEGATE_RX.search(clause):
                        ok = False
                        hits += 1
                        report.append("RED[promise] %s: 指称不随包件 %s 而未写明「源仓/不随包」（F-a 族）" % (rel, tok))
    return ok, hits


# ------------------------------------------------------- gate 3 本机路径与 PII
def gate_localpaths(pkg, report):
    ok = True
    user = os.path.expanduser("~")
    uname = os.path.basename(user)
    for rel in tree(pkg):
        if not rel.endswith(EXTS_TEXT):
            continue
        text = read(os.path.join(pkg, rel))
        for m in HOME_RX.finditer(text):
            ok = False
            report.append("RED[localpath] %s: 本机路径 %s" % (rel, m.group(0)))
        if uname and uname not in ("", ) and re.search(r"(?<![A-Za-z0-9])%s(?![A-Za-z0-9])" % re.escape(uname), text):
            ok = False
            report.append("RED[localpath] %s: 出现本机用户名 %s" % (rel, uname))
        if re.search(r"[\w.+-]+@[\w-]+\.[A-Za-z]{2,}", text):
            for em in re.finditer(r"[\w.+-]+@[\w-]+\.[A-Za-z]{2,}", text):
                if not em.group(0).endswith((".edu", ".org")) and "example" not in em.group(0):
                    ok = False
                    report.append("RED[localpath] %s: 疑似真实邮箱 %s" % (rel, em.group(0)))
    return ok


# ------------------------------------------------ gate 4 覆盖面自述与实档 1:1
def gate_coverage(pkg, scan_list, skip_list, report):
    """缺口一：扫描面 + 声明不扫描面 必须恰好等于存缴树，且声明清单里每件都要给理由。"""
    allf = tree(pkg)
    covered = set(scan_list) | set(skip_list)
    ok = True
    if len(scan_list) + len(skip_list) != len(allf):
        ok = False
        report.append("RED[coverage] 声明 %d 扫描 + %d 不扫描 = %d，与实档 %d 不符"
                      % (len(scan_list), len(skip_list), len(scan_list) + len(skip_list), len(allf)))
    unaccounted = sorted(set(allf) - covered)
    extra = sorted(covered - set(allf))
    if unaccounted:
        ok = False
        report.append("RED[coverage] 既未扫描也未声明不扫描（F-b 族）: %s" % ", ".join(unaccounted))
    if extra:
        ok = False
        report.append("RED[coverage] 声明清单里有幻影件: %s" % ", ".join(extra))
    return ok


# -------------------------------------------- gate 5 结构后检（控制字符 / 括号）
def gate_structure(pkg, report):
    """缺口三：裸 CR/TAB 普查 + 非 listing/非注释/非数学区括号深度归零。"""
    ok = True
    for rel in tree(pkg):
        if not rel.endswith(EXTS_TEXT):
            continue
        raw = io.open(os.path.join(pkg, rel), encoding="utf-8", errors="replace").read()
        if rel.endswith((".tex", ".md", ".txt", ".json")):
            ncr = sum(1 for i, c in enumerate(raw) if c == "\r" and (i + 1 >= len(raw) or raw[i + 1] != "\n"))
            ntab = raw.count("\t")
            if ncr:
                ok = False
                report.append("RED[structure] %s: 裸 CR %d 处（转义吞字，ED-17 族）" % (rel, ncr))
            if ntab and not rel.endswith((".py", ".sh")):
                ok = False
                report.append("RED[structure] %s: TAB %d 处（\\t 被转义吞字族）" % (rel, ntab))
        if rel.endswith(".tex"):
            ok = ok and tex_paren_balance(pkg, rel, report)
    return ok


def tex_paren_balance(pkg, rel, report):
    lines = read(os.path.join(pkg, rel)).splitlines()
    depth = 0
    in_lst = False
    bad = []
    for i, line in enumerate(lines, 1):
        s = line
        if "\\begin{lstlisting}" in s:
            in_lst = True
            continue
        if "\\end{lstlisting}" in s:
            in_lst = False
            continue
        if in_lst or s.lstrip().startswith("%"):
            continue
        s = re.sub(r"(?<!\\)%.*$", "", s)          # 去行尾注释
        s = re.sub(r"\\begin\{(array|tabular|align|equation|displaymath|math)\}.*?\\end\{\1\}", "", s, flags=re.S)
        s = re.sub(r"\$[^$]*\$", "", s)             # 去行内数学
        s = s.replace("\\(", "(").replace("\\)", ")").replace("\\{", "").replace("\\}", "")
        s = s.replace("\\%", "").replace("\\$", "")
        for ch in s:
            if ch == "(":
                depth += 1
            elif ch == ")":
                depth -= 1
                if depth < 0:
                    bad.append(i)
                    depth = 0
    if depth != 0 or bad:
        report.append("RED[structure] %s: 括号深度未归零（终值 %d，负深度行 %s）——F-1 族"
                      % (rel, depth, bad or "无"))
        return False
    return True


# --------------------------- gate 6 自述范围（locativity / 逐文件行尾声称，第 6 轮 F-3 出口）
def _expand_glob(tok):
    """compile-run1..9.log 这类区间写法展开为具体件名；普通名原样返回。"""
    m = re.match(r"^(.*?)(\d+)\.\.(\d+)(\.\w+)$", tok)
    if not m:
        return [tok]
    pre, a, z, suf = m.group(1), int(m.group(2)), int(m.group(3)), m.group(4)
    return ["%s%d%s" % (pre, i, suf) for i in range(a, z + 1)]


def _root_dirs(dl):
    """deliverable 目录里存缴树以外的地方（根件侧）。"""
    out = []
    for dirpath, _ds, fs in os.walk(dl):
        norm = dirpath.replace("\\", "/")
        if "/zenodo" in norm:
            continue
        out.append((dirpath, fs))
    return out


def gate_scope(dl, pkg, scan_list, report):
    """门 6：包内件的「所在目录」声称与「逐文件行尾」声称都必须实测成立。

    判据按「最近声称优先」：一个文件名同时被 LF 与 CRLF 措辞环绕时，取距离最近的那个
    作为它的声称（否则一句里同时提到两种行尾就永远判不出来）。"""
    ok = True
    hits = 0
    allf = tree(pkg)
    names = set(os.path.basename(f) for f in allf)
    root_files = set()
    if dl:
        for dirpath, fs in _root_dirs(dl):
            root_files.update(fs)
    for rel in scan_list:
        if rel.startswith(VERBATIM_DIRS):
            continue
        p = os.path.join(pkg, rel)
        if not os.path.isfile(p):
            continue
        text = read(p)
        own_dir = os.path.dirname(p)
        for m in FILE_RX.finditer(text):
            tok = m.group(0)
            if "/" in tok:
                continue
            window = text[max(0, m.start() - 160):m.end() + 160]
            # ---- (ii) 逐文件行尾声称（最近声称优先）
            cands = []
            for mm in LF_CLAIM_RX.finditer(text):
                d = min(abs(mm.start() - m.end()), abs(mm.end() - m.start()))
                if d <= 60:
                    cands.append((d, "LF"))
            for mm in CRLF_CLAIM_RX.finditer(text):
                d = min(abs(mm.start() - m.end()), abs(mm.end() - m.start()))
                if d <= 60:
                    cands.append((d, "CRLF"))
            if cands:
                cands.sort()
                claim = cands[0][1]
                cand = [f for f in allf if os.path.basename(f) == tok]
                target = os.path.join(own_dir, tok) if os.path.isfile(os.path.join(own_dir, tok)) else (
                    os.path.join(pkg, cand[0]) if cand else None)
                side = "存缴"
                if target is None and dl and tok in root_files:
                    r = [d for d, fs in _root_dirs(dl) if tok in fs]
                    target, side = os.path.join(r[0], tok), "包外"
                if target:
                    cr = open(target, "rb").read().count(bytes([13]))
                    if claim == "LF" and cr:
                        ok = False
                        hits += 1
                        report.append("RED[scope] %s: 声称 %s 为 LF，实测 %s 侧 CR=%d" % (rel, tok, side, cr))
                    elif claim == "CRLF" and not cr:
                        ok = False
                        hits += 1
                        report.append("RED[scope] %s: 声称 %s 含 CRLF/混合行尾，实测 %s 侧 CR=0" % (rel, tok, side))
            # ---- (i) locativity 声称
            loc = LOCALITY_RX.search(window)
            if not loc:
                continue
            if SCOPE_EXCUSE_RX.search(window):
                continue
            low = window.lower()
            if "in this directory" in low or "inside this directory" in low or "within this directory" in low:
                if not os.path.isfile(os.path.join(own_dir, tok)):
                    ok = False
                    hits += 1
                    report.append("RED[scope] %s: 声称 %s 就在本目录，实测存缴该目录内没有此件" % (rel, tok))
            elif tok not in root_files:
                ok = False
                hits += 1
                report.append("RED[scope] %s: 声称从根件重拷 / 根包逐字节相同，但 %s 在 deliverable 侧无同名件（须写明例外范围）"
                              % (rel, tok))
    return ok, hits


# ------------------------------------------------------------------ selftest
def selftest(tmp):
    """反证：坏样例必须被抓住，好样例必须放过。返回 (通过数, 总数)。"""
    cases = []
    mk = lambda name, body: os.path.join(name, body)

    def build(slug, files):
        d = os.path.join(tmp, slug)
        for rel, body in files.items():
            fp = os.path.join(d, rel)
            os.makedirs(os.path.dirname(fp), exist_ok=True)
            io.open(fp, "w", encoding="utf-8", newline="\n").write(body)
        return d

    good = build("good", {
        "claim/claim.tex": "See \\texttt{UPLOAD.md} in the source repository; it is not shipped with this deposit.\n",
        "claim/claim.pdf": "x",
        "metadata/README.md": "- 2 files\n",
        "metadata/FILE-MANIFEST.txt": "     111 claim/claim.tex\n",
        "audit/evidence.txt": "full text \\texttt{tasks/x/audit/final.txt} stays in the source task directory, not shipped.\n",
    })
    bad_promise = build("bad1", {
        "claim/claim.tex": "See \\texttt{UPLOAD.md} in this package for the upload steps.\n",
        "metadata/README.md": "- 2 files\n",
        "metadata/FILE-MANIFEST.txt": "      60 claim/claim.tex\n",
    })
    bad_ref = build("bad2", {
        "audit/x.txt": "The command output is recorded in audit/selfcheck.md for reference.\n",
        "metadata/FILE-MANIFEST.txt": "      70 audit/x.txt\n",
        "metadata/README.md": "- 1 files\n",
    })
    bad_paren = build("bad3", {
        "claim/claim.tex": "The extracts (compile log, the reports (one per round, each verbatim).\n",
        "metadata/FILE-MANIFEST.txt": "      90 claim/claim.tex\n",
        "metadata/README.md": "- 1 files\n",
    })
    bad_cover = build("bad4", {
        "claim/claim.tex": "ok\n",
        "audit/undeclared.txt": "this file is in neither scanned nor skipped list\n",
        "metadata/FILE-MANIFEST.txt": "      4 claim/claim.tex\n",
        "metadata/README.md": "- 2 files\n",
    })
    for d in (good, bad_promise, bad_ref, bad_paren, bad_cover):
        os.makedirs(os.path.join(d, "metadata"), exist_ok=True)
    os.makedirs(os.path.join(bad_promise, "claim"), exist_ok=True)
    os.makedirs(os.path.join(bad_promise, "metadata"), exist_ok=True)
    os.makedirs(os.path.join(bad_ref, "audit"), exist_ok=True)
    os.makedirs(os.path.join(bad_ref, "metadata"), exist_ok=True)
    os.makedirs(os.path.join(bad_paren, "claim"), exist_ok=True)
    os.makedirs(os.path.join(bad_paren, "metadata"), exist_ok=True)
    os.makedirs(os.path.join(bad_cover, "claim"), exist_ok=True)
    os.makedirs(os.path.join(bad_cover, "audit"), exist_ok=True)
    os.makedirs(os.path.join(bad_cover, "metadata"), exist_ok=True)

    def build_dl(slug, pkg_files, root_files=None):
        d = os.path.join(tmp, slug)
        for rel, body in pkg_files.items():
            fp = os.path.join(d, "zenodo", rel)
            os.makedirs(os.path.dirname(fp), exist_ok=True)
            io.open(fp, "w", encoding="utf-8", newline="\n").write(body)
        for rel, body in (root_files or {}).items():
            fp = os.path.join(d, rel)
            os.makedirs(os.path.dirname(fp), exist_ok=True)
            with io.open(fp, "wb") as fh:
                fh.write(body.replace("\n", "\r\n").encode("utf-8") if body.startswith("@CRLF@")
                         else body.encode("utf-8"))
        return d

    good_scope = build_dl("good5", {
        "audit/summary.txt": ("raw logs compile-run1.log live in the deliverable's audit/ directory in the\n"
                             "  source repository (package-external, not shipped). lint-output.txt was\n"
                             "  re-emitted with LF-only endings during the last rework; the copy is re-taken\n"
                             "  from the root files, so root <-> package stay byte-identical.\n"),
        "audit/lint-output.txt": "static gate run 1\nstatic gate run 2\n",
        "metadata/FILE-MANIFEST.txt": "     256 audit/summary.txt\n",
        "metadata/README.md": "- ok\n",
    }, {"audit/compile-run1.log": "@CRLF@raw log line 1\nraw log line 2\n",
        "audit/summary.txt": ("raw logs compile-run1.log live in the deliverable's audit/ directory in the\n"
                              "  source repository (package-external, not shipped). lint-output.txt was\n"
                              "  re-emitted with LF-only endings during the last rework; the copy is re-taken\n"
                              "  from the root files, so root <-> package stay byte-identical.\n"),
        "audit/lint-output.txt": "static gate run 1\nstatic gate run 2\n"})

    bad_lfclaim = build_dl("bad5", {
        "audit/summary.txt": "lint-output.txt keep the mixed CRLF/LF endings that a redirect produced.\n",
        "audit/lint-output.txt": "all LF here\n",
        "metadata/FILE-MANIFEST.txt": "      60 audit/summary.txt\n",
        "metadata/README.md": "- ok\n",
    }, {"audit/lint-output.txt": "all LF here\n"})

    bad_thisdir = build_dl("bad6", {
        "audit/summary.txt": "raw per-round logs are compile-run1.log ... compile-run3.log in this directory.\n",
        "metadata/FILE-MANIFEST.txt": "      66 audit/summary.txt\n",
        "metadata/README.md": "- ok\n",
    }, {"audit/compile-run1.log": "@CRLF@log\n", "audit/compile-run2.log": "@CRLF@log\n",
        "audit/compile-run3.log": "@CRLF@log\n"})

    SUMTXT = ("Package copies of the audit extracts are re-taken from the root files after\n"
              "  each rework, so root <-> package stay byte-identical: see orphan-note.txt.\n")
    bad_rootclaim = build_dl("bad7", {
        "audit/summary.txt": SUMTXT,
        "audit/orphan-note.txt": "this file has no counterpart outside the deposit\n",
        "metadata/FILE-MANIFEST.txt": "     137 audit/summary.txt\n",
        "metadata/README.md": "- ok\n",
    }, {"audit/summary.txt": SUMTXT})

    def run(d, explicit=False):
        rep = []
        dl = d if os.path.isdir(os.path.join(d, "zenodo")) else None
        pkg = os.path.join(d, "zenodo") if dl else d
        files = tree(pkg)
        scan = [f for f in files if f.endswith(EXTS_TEXT)]
        skip = [f for f in files if f not in scan]
        if explicit:
            scan = [f for f in files if f != "audit/undeclared.txt"]
            skip = []
        g2 = gate_promises(pkg, scan, rep)[0]
        g5 = gate_structure(pkg, rep)
        g4 = gate_coverage(pkg, scan, skip, rep) if explicit else True
        g6 = gate_scope(dl, pkg, scan, rep)[0]
        return rep, (g2 and g5 and g4 and g6)

    n_ok = 0
    rep, res = run(good)
    passed = res and not rep
    print("  selftest good package (must pass) ..................... %s" % ("OK" if passed else "FAIL " + str(rep)))
    n_ok += 1 if passed else 0
    rep, res = run(good_scope)
    passed = res and not rep
    print("  selftest good scope claims (must pass) ................ %s" % ("OK" if passed else "FAIL " + str(rep)))
    n_ok += 1 if passed else 0
    for name, d in (("bad1 promise in-this-package", bad_promise),
                    ("bad2 unshipped reference", bad_ref),
                    ("bad3 unbalanced paren", bad_paren),
                    ("bad4 coverage mismatch", bad_cover),
                    ("bad5 false per-file LF claim", bad_lfclaim),
                    ("bad6 \"in this directory\" off-tree", bad_thisdir),
                    ("bad7 root-counterpart claim without a root file", bad_rootclaim)):
        rep, res = run(d, explicit=(d == bad_cover))
        caught = (not res) or rep
        print("  selftest %s (must FAIL) ............. %s" % (name, "OK" if caught else "MISS " + str(rep)))
        n_ok += 1 if caught else 0
    return n_ok, 9


# ------------------------------------------------------------------------ main
def main(argv=None):
    ap = argparse.ArgumentParser(description="AI4Math 交付包机械对账门")
    ap.add_argument("deliverable", nargs="?", help="papers/<slug> 或 claims/<slug>")
    ap.add_argument("--no-manifest", action="store_true", help="不要求 FILE-MANIFEST.txt（论文轨）")
    ap.add_argument("--write-manifest", action="store_true", help="重新生成随包清单")
    ap.add_argument("--selftest", action="store_true", help="反证：坏样例必须被抓住")
    ap.add_argument("--scanned", default=None, help="扫描面清单文件（每行一个相对路径）；缺省=全部文本件")
    ap.add_argument("--skipped", default=None, help="声明不扫描清单文件（每行一个相对路径 + 理由）")
    a = ap.parse_args(argv)

    here = os.path.dirname(os.path.abspath(__file__))
    root = os.environ.get("AI4MATH_REPO") or find_root(os.path.dirname(here)) or find_root(here)
    if a.selftest:
        tmp = os.path.join(root or here, "logs", "sanitize-selftest")
        if os.path.isdir(tmp):
            import shutil
            shutil.rmtree(tmp)
        os.makedirs(tmp, exist_ok=True)
        print("== selftest ==")
        n, total = selftest(tmp)
        print("selftest: %d/%d OK" % (n, total))
        return 0 if n == total else 2

    if not a.deliverable:
        print("用法: sanitize-package.py <papers|claims>/<slug> [--no-manifest|--write-manifest|--selftest]")
        return 1
    dl = a.deliverable if os.path.isabs(a.deliverable) else os.path.join(root, a.deliverable)
    pkg = os.path.join(dl, "zenodo")
    if not os.path.isdir(pkg):
        print("RED: 找不到存缴包目录 %s" % pkg)
        return 1

    allf = tree(pkg)
    if a.write_manifest:
        man = os.path.join(pkg, "metadata", "FILE-MANIFEST.txt")
        rows = []
        for rel in allf:
            if os.path.abspath(os.path.join(pkg, rel)) == os.path.abspath(man):
                continue
            fp = os.path.join(pkg, rel)
            rows.append("%10d  %s" % (os.path.getsize(fp), rel))
        head = ["# FILE-MANIFEST.txt — 随包清单（本工具生成，自件除外；sha256 见逐件复算要求）",
                "# generated by scripts/sanitize-package.py --write-manifest",
                "# rows = %d ; deposit = %d files (manifest self included)" % (len(rows), len(allf)), ""]
        io.open(man, "w", encoding="utf-8", newline="\n").write("\n".join(head + rows) + "\n")
        print("written: %s (%d rows)" % (man, len(rows)))
        allf = tree(pkg)

    report = []
    scan = [] if a.scanned else [f for f in allf if f.endswith(EXTS_TEXT)
                                 and not f.startswith(VERBATIM_DIRS)
                                 and not_scanned_reason(f) is None]
    if a.scanned:
        scan = [x.strip() for x in read(os.path.join(root, a.scanned)).splitlines() if x.strip() and not x.startswith("#")]
    if a.skipped:
        skip = [x.split()[0] for x in read(os.path.join(root, a.skipped)).splitlines() if x.strip() and not x.startswith("#")]
    else:
        skip = [f for f in allf if f not in scan]
        print("  (default split: verbatim source artefacts under %s are declared not-scanned"
              " -- they are frozen by constitution 2 and must not be edited to satisfy a prose gate)"
              % ",".join(VERBATIM_DIRS))

    print("== gate 4: coverage self-description vs deposit ==")
    if a.scanned or a.skipped:
        cov_ok = gate_coverage(pkg, scan, skip, report)
        print("  scanned %d + declared not-scanned %d = %d ; deposit = %d files -> %s"
              % (len(scan), len(skip), len(scan) + len(skip), len(allf), "OK" if cov_ok else "MISMATCH"))
    else:
        cov_ok = True
        print("  SKIPPED: 未给 --scanned/--skipped 显式清单，覆盖面门不作无根据的绿（F-b 族要求声明可核对）")
    print("== gate 2: promise reconciliation (containment + unshipped references) ==")
    p_ok, p_hits = gate_promises(pkg, scan, report)
    print("  %s (%d violation(s))" % ("PASS" if p_ok else "FAIL", p_hits))
    print("== gate 6: self-description scope (locativity + per-file line endings) ==")
    sc_ok, sc_hits = gate_scope(dl, pkg, scan, report)
    print("  %s (%d violation(s))" % ("PASS" if sc_ok else "FAIL", sc_hits))
    print("== gate 3: no machine-local path ==")
    l_ok = gate_localpaths(pkg, report)
    print("  %s" % ("PASS" if l_ok else "FAIL"))
    print("== gate 5: structural post-check (bare CR/TAB, tex paren balance) ==")
    s_ok = gate_structure(pkg, report)
    print("  %s" % ("PASS" if s_ok else "FAIL"))
    print("== gate 1: manifest consistency ==")
    rows_expect = [f for f in allf if os.path.basename(f) != "FILE-MANIFEST.txt"]
    m_ok = gate_manifest(pkg, rows_expect, not a.no_manifest, report)
    if a.no_manifest:
        print("  SKIPPED (--no-manifest)")
    else:
        print("  %s" % ("PASS" if m_ok else "FAIL"))

    print("\n== totals ==")
    print("  deposit: %d files / %d bytes" % (len(allf), sum(os.path.getsize(os.path.join(pkg, f)) for f in allf)))
    if report:
        print("\n".join(report))
        print("\nFAIL: %d red item(s) — 不得出包 / 不得外发（逐条定位见上）" % len(report))
        return 2
    print("\nALL GATES GREEN")
    return 0


if __name__ == "__main__":
    sys.exit(main())
