# Priority claim of record — the Diophantine equation x² = n!·n# has exactly the solutions n ∈ {0,…,5}

- **类型**：占位短笺 + 存缴包（SOP 08b 快速优先权存缴）
- **作者**：Aurora0134（账号名，非 PII；不含真实姓名 / ORCID 实号 / 邮箱）
- **许可**：正文 CC BY 4.0 / 代码 MIT（Zenodo API 单 license 字段填 MIT；本批发布经 API 直接执行
  ——用户对本篇的显式外发授权，批次卡 O-1——CC-BY-4.0 的 UI 多许可补加留作者顺手核对）
- **DOI**：本版（v1.0.1）`10.5281/zenodo.23177585`；概念 DOI（恒解析到最新版）`10.5281/zenodo.23177003`；
  首版 v1.0.0 = `10.5281/zenodo.23177004`（同日发布，仅本 README 的 DOI/发布状态段措辞过时，v1.0.1 予以更正，
  短笺正文 / 证明 / 审计证据无任何改动）
- **版本钉**：Lean v4.34.0（`leanprover/lean4:v4.34.0`）/ mathlib4 v4.34.0（rev `5ed29652`，
  见 `proofs/lean-toolchain`）/ tectonic 0.17.0（本机编译）
- **编译页数**：见下「包体自述生成块」——按随包 PDF 实测渲染，门 7「自述 ↔ 实档」每次出包前重新
  测量并逐条比对；**本件块外不得手写页数 / 警告数**（门 7 机械禁止）。超出 SOP 08b 职责节
  「claim note，2–4 页」口径的部分，全部是逐字冻结快照 / 终件 listing 摘录与 C9 查新表，按该
  SOP《已知边界》页数口径条的显式豁免执行。

## 包体自述生成块（机器渲染，勿手改）

以下数字由 `scripts/sanitize-package.py --emit-facts` 按实测渲染；门 7 每次出包前重新测量并逐条
比对。本件**块外不得手写**页数、警告数——手写数字在返工后必然陈旧。

- 本包内 `claim/claim.pdf` 的实测页数（按 `/Type /Page` 对象数；与交付目录根编译日志
  `claim.log` 的 `Output written on … (N pages)` 交叉核对——该日志在源仓、**不随包**；
  两侧不一致即判为**不可测量**，门 7 不以「不可判」充当绿灯）：

<!-- FACTS-BEGIN fact name=pages src=claim/claim.pdf -->
@value 22
<!-- FACTS-END -->

## 包内结构（生成块：逐件字节数按实测渲染，路径相对 `zenodo/`）

<!-- FACTS-BEGIN inv scope=deposit -->
@row      935  audit/axioms.out
@row     2076  audit/bib-verify.md
@row     6263  audit/c9-record.md
@row     3089  audit/claim-check.md
@row    19202  audit/compile-run.log
@row     6329  audit/faithful.md
@row    17566  audit/gate3-final-adjudication.txt
@row       66  audit/lint.txt
@row      358  audit/listing-verify.txt
@row     5870  audit/package-notes.md
@row      180  audit/welldef-nfact-primorial-square.txt
@row   224738  claim/claim.pdf
@row    56913  claim/claim.tex
@row     7569  claim/lstlean.tex
@row      951  metadata/FILE-MANIFEST.txt
@row     8354  metadata/README.md
@row     2335  metadata/zenodo.json
@row    62242  proofs/final-nfact-primorial-square.lean
@row       25  proofs/lean-toolchain
@row     4522  proofs/nfact-primorial-square.lean
@row     4747  proofs/nfact-primorial-square.statement.txt
<!-- FACTS-END -->

## 复现命令

本包全部结论可由以下命令链在装有 Lean v4.34.0 + mathlib4 v4.34.0（rev 5ed29652）的机器上复算
（命令中的脚本路径指源仓，**不随包**；本包是自包含存缴件，复算在源仓或等价工程内进行）：

```bash
# 1. 严格模式编译（终审准则：exit 0 且文件内无 sorry/admit 占位）
scripts/lean-verify proofs/final-nfact-primorial-square.lean

# 2. 公理审计（八条冻结定理逐条打印依赖公理；白名单 = propext, Quot.sound, Classical.choice）
cp proofs/final-nfact-primorial-square.lean /tmp/ax.lean
# 尾部追加八行：#print axioms NFactPrimorialSquare.<定理名>（定理名见 proofs/ 内冻结快照）
scripts/lean-verify /tmp/ax.lean

# 3. statement 未篡改（声明头部去空白逐字节比对；比对基准 = proofs/ 内冻结快照与 statement 源）
```

第 1、2 步在本包装配时已由打包轨对源任务终件独立重跑（探针 = 终件逐字拷贝 + 尾部八行
`#print axioms`，前缀 sha256 复算一致），实录见 `audit/axioms.out`；源任务监察院的终裁书规范化
副本见 `audit/gate3-final-adjudication.txt`。

## 证据链一览

| 主张 | 包内证据 |
|---|---|
| 全部冻结定理「完全证明」 | `audit/gate3-final-adjudication.txt`（源任务监察院终裁书的规范化副本，规范化动作见 `audit/package-notes.md`） |
| 严格编译 exit 0、零 error | 同上（终裁书检查二）+ `audit/axioms.out`（打包轨独立重跑的探针实录） |
| 零占位符（0 sorry / 0 admit） | 同上（终裁书检查三，全文含注释 grep 零命中） |
| 公理 ⊆ 白名单 | `audit/axioms.out`（逐字；第四条的折行为终端排版）+ 终裁书检查四 |
| statement 未篡改 | 终裁书检查一/二（双口径）+ `proofs/` 内冻结快照与终件并置 |
| listing 与冻结产物逐字节一致 | `audit/listing-verify.txt`（装配轨核验记录，随本包） |
| 闸门二良定义与退化探针 | `audit/welldef-nfact-primorial-square.txt`（机器输出逐字副本：WELLDEF OK + 九探针全 FAIL） |
| 参考文献逐条存在 | `audit/bib-verify.md`（逐条给出核验通道与回读字段） |
| 新颖性裁决与全量查询串 | `audit/c9-record.md`（逐字拼接件；结论禁改写） |
| 质检门①静态检查 | `audit/lint.txt`（paper-lint 输出，exit 0） |
| 质检门②硬编译 | `audit/compile-run.log`（tectonic 控制台输出，exit 0） |
| 精简主张审计（质检门③） | `audit/claim-check.md`——由监察院裁决后补入存缴树；裁决前的修订中该件 not shipped |

## 已知呈现面事项（Known presentation items）

- **页数**：见上「包体自述生成块」（生成块，按随包 PDF 实测）。该页数超出 SOP 08b 职责节
  「claim note，2–4 页」口径；豁免依据：超出部分全部是逐字冻结快照 / 终件 listing 摘录与
  C9 查新表（禁止为凑页数删证据或降口径）。卡面同记一行。
- **渲染**：编译日志 `Missing character` 计数为零（CJK 与数学符号经导言区 lccode 映射 + xeCJK
  渲染）；`Overfull \hbox` 计数为零。
- **Docstring 追加句**：终件三条 docstring 较快照各追加一句解释性文字（注释级差异，按「忽略空白与
  注释」口径不入 statement 裁决；终裁书检查一已如实记录）。
- **编译诊断三条**（终件层，均非否决项）：`18^100000` 的 elaborator 指数阈值提示、`push_neg`
  弃用别名提示、一条未用变量 linter 提示——终裁书检查二逐条登记。

## 包体自我描述的一致性

出包前跑 `python scripts/sanitize-package.py claims/nfact-primorial-square`（仓库级机械对账门，共七门：
清单一致性 / 路径型承诺对账 / 无本机路径 / 覆盖面自述 / 结构后检 / 自述范围 / 自述 ↔ 实档）。
**默认调用下第四门（覆盖面自述）因未给 `--scanned/--skipped` 显式清单而 SKIPPED**，故本包实测为
「六门跑、一门跳过」——本件不写「六门全绿」。自述层的页数 / 件清单由生成块给出，门 7 每次出包前
重新测量并逐条比对。**特意不入包**的项与**包内副本的机械处理**（本机路径前缀剥离）逐条列明于随包件
`audit/package-notes.md`。

## DOI

- **This version (v1.0.1)**: `10.5281/zenodo.23177585` — published 2026-10-06. **Concept DOI (always resolves to the latest version)**: `10.5281/zenodo.23177003`.
- Version history: v1.0.0 = `10.5281/zenodo.23177004` (same day); v1.0.1 corrects only this README's DOI/publication-status wording (v1's file wrongly said "publish is pending"); the claim note, proofs, and audit evidence are byte-identical to v1.0.0.
- The publish step was executed by the pipeline via the Zenodo API under the human author's explicit per-package authorization (batch `tasks/20261006-paper-nfact-primorial/`, rule-override record O-1; the standing default "publish is the human's own UI step" was overridden for this package only).
- Backfill after publish: this file + `claims/nfact-primorial-square/card.md` + `run-state.md` (the latter two live in the source repository, not shipped in this package).
