#!/usr/bin/env python3
"""listing 与冻结产物逐字节核验（占位包/论文包共用工艺，血统 papers/*/audit/inspect-tex.py 与 claims/mossad42-01-half3/audit/inspect-tex.py）。

用法：
  python audit/inspect-tex.py --verify          # 逐块核验，退出码 0 = 全过
  python audit/inspect-tex.py --list            # 只列出块与行段

判据：
  块 0（statement 摘录）：tex 中 lstlisting 正文行是冻结 statement.lean
    L36..L98 的**按序子序列**，且被略去的行**恰**为显式声明的三行
    （L85 sorry 字样注释、L92/L98 两条 `  sorry` 占位 proof body）——
    其它任何缺行即 listing 漂移。
  块 1（proof 全文）：tex 中 lstlisting 正文行 = 冻结 bridge.lean 全文
    （LF 归一后）逐行相等。
  块 2（公理打印）：tex 中 lstlisting 正文行 = audit out 里含
    "depends on axioms" 的行（按序、逐字）。
"""
import io
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CLAIM = os.path.dirname(HERE)                 # claims/<slug>/
ROOT = os.environ.get("AI4MATH_REPO") or os.path.abspath(os.path.join(CLAIM, "..", ".."))

STMT_REL = "tasks/20260929-l14c-graphside-pipeline/formalized/statement.lean"
BRIDGE_REL = "tasks/20260929-l14c-graphside-pipeline/attempts/phase2/r3/bridge.lean"
AX_REL = "tasks/20260929-l14c-graphside-pipeline/audit/compile-debug/audit-p2r3-axioms.out"
STMT_LO, STMT_HI = 36, 98
STMT_EXCLUDE = {85, 92, 98}   # 1-based：注释 L85（含禁词）、占位 proof body L92/L98


def read_tex_blocks(path):
    with io.open(path, encoding="utf-8") as f:
        text = f.read()
    blocks = []
    pat = re.compile(r"\\begin\{lstlisting\}(?:\[(.*?)\])?\n(.*?)\\end\{lstlisting\}", re.S)
    for m in pat.finditer(text):
        blocks.append((m.group(1) or "", m.group(2).split("\n")))
    return blocks


def load_source(rel):
    p = os.path.join(ROOT, rel.replace("/", os.sep))
    raw = io.open(p, encoding="utf-8", newline="").read()
    return raw.replace("\r\n", "\n").split("\n")


def verify():
    blocks = read_tex_blocks(os.path.join(CLAIM, "claim.tex"))
    print("tex blocks found:", len(blocks))
    ok = len(blocks) == 3
    if not ok:
        print("[FAIL] expected 3 listing blocks (stmt / proof / axioms)")

    # ---- block 0: statement ordered-subsequence with declared elisions ----
    _, body0 = blocks[0]
    while body0 and body0[-1] == "":
        body0.pop()
    src = load_source(STMT_REL)
    window = src[STMT_LO - 1:STMT_HI]
    expected_missing = [window[i - STMT_LO] for i in STMT_EXCLUDE]
    j = 0
    miss = []
    for ln in body0:
        found = False
        while j < len(window):
            if window[j] == ln:
                found = True
                j += 1
                break
            j += 1
        if not found:
            miss.append(ln)
    # lines of the window not consumed by the tex block must be exactly the declared elisions
    consumed = set()
    jj = 0
    for ln in body0:
        while window[jj] != ln:
            jj += 1
        consumed.add(jj + STMT_LO)
        jj += 1
    leftover = [i for i in range(STMT_LO, STMT_HI + 1) if i not in consumed]
    if miss or leftover != sorted(STMT_EXCLUDE) or sorted(STMT_EXCLUDE) != sorted(STMT_EXCLUDE):
        ok = False
        print("[FAIL] statement 块：未在源窗口按序找到 %d 行；窗口内未消费行 = %s（声明省略 = %s）"
              % (len(miss), leftover, sorted(STMT_EXCLUDE)))
        for m0 in miss[:6]:
            print("   -", ascii(m0[:90]))
    else:
        print("[ OK ] statement 块：%d 行为冻结件 L%d..L%d 的按序子序列；"
              "显式省略恰 %d 行（L%s；规则见脚本 docstring）"
              % (len(body0), STMT_LO, STMT_HI, len(STMT_EXCLUDE),
                 "/L".join(str(i) for i in sorted(STMT_EXCLUDE))))
        for i in sorted(STMT_EXCLUDE):
            print("   elided L%d: %r" % (i, window[i - STMT_LO]))

    # ---- block 1: proof whole file, LF-normalised equality ----
    _, body1 = blocks[1]
    while body1 and body1[-1] == "":
        body1.pop()
    srcb = load_source(BRIDGE_REL)
    if srcb and srcb[-1] == "":
        srcb.pop()
    if body1 == srcb:
        print("[ OK ] proof 块：%d 行 = 冻结 bridge.lean 全文逐行相等（LF 归一口径）" % len(body1))
    else:
        ok = False
        diff = [i + 1 for i, (a, b) in enumerate(zip(body1, srcb)) if a != b]
        print("[FAIL] proof 块与冻结件不一致：tex %d 行 vs 源 %d 行；首个差异行 %s"
              % (len(body1), len(srcb), diff[:3]))

    # ---- block 2: axiom printout ----
    _, body2 = blocks[2]
    while body2 and body2[-1] == "":
        body2.pop()
    ax = io.open(os.path.join(ROOT, AX_REL.replace("/", os.sep)),
                 encoding="utf-8", errors="replace", newline="").read()
    ax_lines = [l for l in ax.split("\n") if "depends on axioms" in l]
    if body2 == ax_lines:
        print("[ OK ] axioms 块：%d 行 = audit out 中 depends-on-axioms 行逐字一致" % len(body2))
    else:
        ok = False
        print("[FAIL] axioms 块不一致：tex %d 行 vs 源 %d 行" % (len(body2), len(ax_lines)))

    # sorry/admit scan across all listing bodies (paper-lint criterion 3 mirror)
    banned = re.compile(r"(^|[^A-Za-z])(sorry|admit|sorryAx)([^A-Za-z]|$)")
    hits = [(i, l.strip()) for _, body in blocks for i, l in enumerate(body) if banned.search(l)]
    if hits:
        ok = False
        print("[FAIL] listing 内出现 sorry/admit：%d 处" % len(hits))
        for h in hits[:6]:
            print("   ", h)
    else:
        print("[ OK ] 全部 listing 内 0 sorry / 0 admit")

    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 2


def listing():
    for k, (cap, body) in enumerate(read_tex_blocks(os.path.join(CLAIM, "claim.tex"))):
        print("block %d: %d lines | caption head: %s"
              % (k, len(body), (cap or "")[:80].replace("\n", " ")))


if __name__ == "__main__":
    if "--list" in sys.argv:
        listing()
        sys.exit(0)
    sys.exit(verify())
