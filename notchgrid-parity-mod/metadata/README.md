# Zenodo 存缴包 README — notchgrid-parity-mod（占位通道 SOP 08b）

- **性质**：优先权存缴记录（claim of record），非完整论文。同成果的叙述性论文走 AI4Math
  SOP 08 慢车道（`papers/notchgrid-parity-mod/`），论文外发时其 Data availability 回本包
  DOI 转正。
- **DOI**：上传时按源仓 deliverable 目录的 `claims/notchgrid-parity-mod/UPLOAD.md` 第 1 步
  预留，然后回填 `claim/claim.tex` 的 Data availability 段并重编（包内当前措辞为
  「DOI to be reserved at upload」，正文无裸占位符）。注意：本包已用 10 个 LaTeX 编译轮（第 10 轮 = 2026-09-29 署名 errata，见下）；用户 2026-09-28 授权行
  `budget-auth-3` 曾把顶由 9 提到 **10**、专供该回填，2026-09-29 用户指令改将该轮用于署名 errata 并把顶提到 **11**（`budget-auth-4`），
  **第 11 轮专供 DOI 回填、尚未动用**
  （宪条 5 的卡面 + 账本双写在位）。未回填前保持预留措辞。
- **镜像**：脱敏 GitHub 快照仓已推送（用户 2026-09-28 指令「gh推送授权，全做」授权并执行；仅推本目录树）至 `https://github.com/Aurora0134/ai4math-claims` 的 `notchgrid-parity-mod/` 目录；commit 与时间戳见源仓 `claims/notchgrid-parity-mod/card.md`（不随包），本包 `metadata/zenodo.json` 的 related_identifiers[0] 已填该 URL。

## 包结构

- `claim/`：占位短笺 `claim.tex` + 编译产物 `claim.pdf`（tectonic/XeTeX，已用 10 轮、顶 11
  （第 10 轮 = 2026-09-29 署名 errata：作者栏填 `Aurora0134`；第 11 轮预留专供 DOI 回填、未动用），
  终轮 0 `Missing character` / 0 Overfull / 0 未解析引用，12 页；上限原为 6 轮，
  2026-09-28 用户指令追加至 9 轮用于门③返工，第 9 轮已用于包内承诺失实项 N1（见
  `audit/claim-recheck.md`），门③第 3 轮（`audit/claim-recheck2.md`）的 6 条发现全落在记账 /
  转写 / 指令文本层、以**零编译轮**完成；2026-09-29 用户指令把 budget-auth-3 预留的
  第 10 轮改用于署名 errata（作者栏占位符 → `Aurora0134`，订正随 batch 4 公开版本的
  内部口径不一致）并把顶提到 11，DOI 回填用第 11 轮）+ `lstlean.tex`
  （listing 着色与 literate 表，从 `harness/templates/paper/lstlean.tex` 逐字节拷入）。
  12 页超出 SOP 08b 的 2–4 页目标，超出部分是逐字 listing 与 C9 查新表，属该 SOP
  《已知边界》的显式页数豁免（用户 2026-09-28 裁可维持 12 页，不压版式、不删证据）。
- `proofs/`：
  - `01-notch-mods.lean` — 冻结 statement（69 行，sha256
    `9a787b6be05dc345343edf675d107801e674e3abae095356ace390fac8426fb8`）
  - `01-notch-proved.lean` — 终稿开发（621 行，sha256
    `6f1a7440f5830633e9309ab5629e16308928bb6421f64f4d4b1988b8929db4aa`）
  - `lean-toolchain` — 逐字节拷贝的工具链钉（`leanprover/lean4:v4.34.0`）
  三件均 `cmp` 实测与源任务文件逐字节一致。
- `audit/`：`compile-log.txt`（闸门二/三关键行摘录，逐行标明所引源件；源件为中文，故其中
  英文行是**转写/翻译**而非逐字誊录，唯二逐字保留原字形的是分级标签「完全证明」与闸门二的
  `WELLDEF OK`，该件第 2 行已如此声明）、
  `axioms.txt`（公理打印原文四行，
  顺序未重排）、`diff-conclusion.txt`（冻结/对称差结论 + 本包机械核验清单 + 本包
  **不含**哪些原件）、`c9-record.md`（**C9 查新全量记录**，7 区块逐字拷贝，含零命中）、
  `c9-verify.txt`（c9-record 与源行段逐字节核验）、`listing-verify.txt`（7/7 字节全同）、
  `statement-vs-frozen.txt`（6/6 在冻结件逐字命中）、`listing-ranges.txt`、
  `lean-idents.txt`、`lint.txt`、`compile.txt`、`references-check.txt`、
  `numeric-recheck.txt`（四张余数表与周期的独立复算）、
  `rework-evidence.txt`（门③返工三条事实性更正 F1/F2/F3 与第 9 轮更正 N1 的机械复算依据）、
  `compile-run{1..10}.log`（十轮原始编译日志，第 10 件 = 2026-09-29 署名 errata 轮；各件里唯一的 "error" 串是便携版 tectonic 的
  `Fontconfig error: Cannot load default config file` 字体环境提示，非 LaTeX error，
  每轮 exit 0 与各件尾部的 "bytes written" 为证，见 `compile.txt` 轮次表。另须读清：轮 2 至
  轮 8 的日志会逐字回显第 9 轮之前那句 Data availability 表述——即被门③第 2 轮判为失实、
  已由第 9 轮改掉的「把上传清单说成本包随附文件」那句——每件事发 2 次（两趟交叉引用各一次，
  出现在 Underfull \hbox 诊断行内）。原始日志是归档证据，按纪律**保留编译当时原样、不回改**，
  更正只落在 `claim.tex`（第 9 轮）与 `compile.txt` 的读数说明里；`sanitize-package.py`
  已把这九件列进「不参与承诺扫描」清单并打印理由，其覆盖面算术（受扫 + 已声明不受扫 =
  树内全部文件）由门 2 自身核验，故此处回显不会被读成活着的承诺）、
  `claim-check.md`（**精简主张审计首轮裁决书**，门③监察院产出，本包逐字副本）、
  `claim-recheck.md`（**门③复审第 2 轮裁决书**，监察院产出，验收 F1–F5 全部通过并列出
  N1–N4 与中断遗留 L1–L6，本包逐字副本）、
  `claim-recheck2.md`（**门③第 3 轮裁决书**，监察院产出：判据红 0 条、六项判据整轮复跑全通过、
  三门复算全绿，另立 6 条发现 F-a～F-f，全部落在记账/转写/指令文本层、无一条需改
  `claim.tex`，因此本轮零编译轮；本包逐字副本。四份裁决书逐字副本同时随包，是设计意图——
  审计实物不修饰，首轮「不通过」的结论也照原样公开）、
  `claim-recheck3.md`（**门③第 4 轮裁决书**，监察院产出：判据红 0 条、六项判据整轮复跑全部通过、
  三门与 selftest 复算全绿，另立 5 条发现 G1–G5，全部落在记账/转写/指令文本层、无一条需改
  `claim.tex`，本轮零编译轮；本包逐字副本，与包外根件 `cmp` 全同）、
  `sanitize-package.py`（本包的清单一致性 / 承诺对账 / 无本机路径三门执行件，与源仓
  `claims/notchgrid-parity-mod/audit/` 下的同名件逐字节相同；其运行输出
  `sanitize-package.txt` 留在源仓 deliverable 目录、不随包出，因该转写记录逐字引用被扫句式，
  入包即自造命中）
  —— 注：闸门二/三**原件**（`tasks/20260927-mossad-notch/audit/final-01-notch.txt`、
  `welldef-verdict.md`、`gate-t{1..4}.txt`、`review-final-{strict,axioms}.out`）留在源任务
  目录，不在本包内；本包 `audit/` 所给为逐行摘录 + 占位轨自验件（见
  `diff-conclusion.txt` 末节与短笺 Verification evidence 节的同一口径）。
- `metadata/`：本文件 + `zenodo.json` + `FILE-MANIFEST.txt`（包内逐件 sha256 + 字节数清单，
  由 `audit/sanitize-package.py` 三门全绿后生成；清单逐件列出除清单自身以外的全部文件）

## 包体量（与盘上实测互洽；由 `audit/sanitize-package.py` 三门核对）

- 本目录树 **38 文件 / 571,428 字节**；`metadata/FILE-MANIFEST.txt` 逐件列出除自身以外的
  37 件（sha256 + 字节数），分目录：`audit/` 29 件 338,878 字节、`claim/` 3 件 167,536 字节、`metadata/` 3 件 21,569 字节、`proofs/` 3 件 43,400 字节。
- 门③第 4 轮（2026-09-28，**零编译轮**）把第 4 份裁决书的逐字副本 `audit/claim-recheck3.md` 入包，并把 G4（`audit/listing-ranges.txt` 由 CRLF 规范为 LF）、G5（六件转写件共八处「来源标注句式」指称补「留在源仓、不随包」明示）、G1（本 README、`metadata/zenodo.json`、`audit/compile.txt`、`audit/compile-log.txt` 四处预算顶现状改口为「顶 10、已用 9、第 10 轮预留未动用」）与件数口径（三份 → 四份）同批落地；该轮同样没有改动短笺本身。上一轮（门③第 3 轮，**零编译轮**）把第 3 份裁决书的逐字副本 `audit/claim-recheck2.md` 入包，件数因此由 35 增至 36。**署名 errata（2026-09-29，编译第 10 轮，用户指令）**：作者栏占位符 → `Aurora0134`（订正随 batch 4 公开版本的包内口径不一致；batch 4 推送时的那对文件 = 第 9 轮 artefact，tex `1287ae80…c7d7dc` / pdf `babece73…dcf7a8` / 128,188 字节，已被取代并按 append-only 留档于 `audit/compile.txt` 的 Superseded pairs），同时把披露句轮次实况与 `metadata/zenodo.json` notes 同批改口（顶 11、已用 10、第 11 轮预留专供 DOI 回填）；listing 七段字节复验 7/7 全同。现随包 pair = 编译第 10 轮交付：`claim/claim.tex`
  sha256 `ee6a7b59e5d4c8afe00d8fd4c9c01ce2ea8939fc1f695741d010c62afb20e663`、
  `claim/claim.pdf` `9531f4f201ec84bd7bbdb67174f5d5806470f01312ef0eda2d5e1097ba11699f`
  （128,545 字节 / 12 页），paper-lint 第 13 跑对此复跑 PASS exit 0（`audit/lint.txt`；run 11、12 的历史块按 append-only 不回改，run 11 括注里「顶 9、未授权第 10 轮」是其书写当时实况，已被 `budget-auth-3` 与 `budget-auth-4` 先后取代并在 run 12、13 块公开声明）。
- 上述数字是本 README 定稿时的实测；发布前请重跑
  `python claims/notchgrid-parity-mod/audit/sanitize-package.py --check-only`
  （源仓路径，不在本目录树内），它会重算并逐件比对，任一项不绿即不得外发。改过**任何**一个
  随包件，都必须：重跑该门 → 用无参数运行重新生成 `FILE-MANIFEST.txt`（旧清单的逐件 sha256
  会立刻过期）→ 按清单打印的 totals 回写上面这组数字。本清单也哈希 README 自身，所以收敛
  顺序是「README 先定稿、清单后生成」，若定稿后体量又变则整条链重来，直到「README 声明 =
  实测」与「清单逐件 = 盘上」同时为真。

## 复现

环境：Lean v4.34.0 + mathlib4 v4.34.0（rev `5ed29652`），工具链钉版见
`proofs/lean-toolchain`。

```
# 在装有 mathlib v4.34.0 的 Lean 工程根目录（本包两件 .lean 需能 import Mathlib）：
lake env lean proofs/01-notch-proved.lean      # 终态严格编译：0 error、0 sorry
# 公理审计：把下面四行追加到副本文件末尾再跑一次，应与 audit/axioms.txt 逐字一致
#   #print axioms a3_odd_iff
#   #print axioms a3_mod8_periodic
#   #print axioms a4_odd_iff
#   #print axioms a4_mod4_eq2_iff
# 产物字节核验：
sha256sum proofs/01-notch-mods.lean proofs/01-notch-proved.lean
```

短笺本身（可选）：`tectonic claim/claim.tex`（或 `pdflatex` + `bibtex`-free 流程；
`claim.tex` 只用 `thebibliography`）。注意 `claim.tex` 的 XeTeX 渲染补丁段仅在
`\ifdefined\XeTeXversion` 下生效，pdflatex 路径行为与模板一致。

## 许可

短笺文本 CC BY 4.0；Lean 源码 MIT。Zenodo UI 对「文本 + 代码」双许可有原生多许可控件
（`zenodo.json` 单字段故写 MIT，上传时按源仓 `claims/notchgrid-parity-mod/UPLOAD.md`
第 2 步补 CC BY 4.0）。

## 披露

命题生成 / 形式化 / 证明搜索 / 审计复跑 / 本短笺草稿由 AI4Math 流水线（LLM）承担；
数学内容采样节点 `anthropic/a6api-main/kimi-k3`（源任务 llm-call 2/8、Lean compile
17/24，逐项见 `audit/compile-log.txt` 与源仓 deliverable 目录
`claims/notchgrid-parity-mod/budget.log` 口径）；一切「成立/通过」断言
以 Lean 4 kernel 编译与 paper-lint/tectonic 硬裁决为准。作者本人终审并对全部内容负责，
AI 不列为作者。**本包为 AI 生成产物。**
