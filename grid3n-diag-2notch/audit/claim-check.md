# 占位精简主张审计记录 claim-check.md — claims/grid3n-diag-2notch/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限），共三轮针对本包（首轮 + 改后复审 + 合并终验）；本文件由主代理按工人回交原文落盘。
> **状态：首轮 3 条 FINDINGS（全 low）→ 修复 → 复审抓 F-D（low，compile.txt 摘录块过期）→ 主代理机械修复 → 合并终验复算：派工修复本体全部通过、另抓 2 条同族残留（README Underfull/轮次自述）已由主代理随手修复（见第三节）。占位质检门三格全绿。**
> 审计自耗：各轮均 llm-call 0 / Lean 编译 0 / 写文件 0。端点 zcode（endpoint-detect 本 shell 实测 unknown，按卡面口径记入）；派发节点 model-detect 读数 `anthropic/stepfun/step-5-preview`（卡面记账节点 `anthropic/a6api-main/kimi-k3`，漂移已在卡面与短笺披露）。

## 一、第一轮 PASS 项（审计独立复算，未采信生成方自报件）

| 核对项 | 裁决 | 证据 |
|---|---|---|
| 四条 `% LEAN:` 锚点 → 声明名 / 分级 / 源任务 | PASS | `adiag_interleave` / `adiag_mod2_period12` / `onotch_mod2_period6` / `enotch_mod2_period6` 对应冻结 statement 真实 decl（源 93/115/135/141 行）；statement sha256 现算 `16744fd3…61aca`（143 行 LF）、final `51721e9e…7cb43`（433 行 LF）与卡面/短笺/包 proofs/ 一致；分级=完全证明，4/4 PASS 无脚手架；axioms-*.txt 四件与源逐字节一致 |
| listing 逐字节（11 块） | PASS | 自写 python 抽取器独立比对：statement 39-53/55-87/89-94/97-116/119-131/133-136/139-142 + final 147-172/179-190/215-229/320-334 全部逐字节一致，LF 口径无归一化；公理原文块 4 行与审计记录一致 |
| 措辞 ≤ 分级 且 ≤ C9 | PASS | 无 first/首创/新数学越级（grep 仅命中否定句）；novelty 裁决照抄（"no occupying record found (three consistent rounds), value tier new sequence / new recurrence"）且明写 "not new mathematics / not a first-discovery claim"；两条占位围栏在位（A061278 禁作新颖性主张，摘要/novelty/Scope(d)/书目四处；组合语义桥仅作 conjecture）；查新表数字与 shared §3 对得上（OpenAlex 7 / zbMATH 5 / arXiv 5 / Crossref 3 = 20 组；Oh 2019 全文；库层 total=0）；枚举窗口与 phase0/counts.txt §3 一致 |
| 预算数字 | PASS | 采样 11/20、llm-call 1/6 与源 budget.log（第 25 行累计、第 26 行机器对账）一致；本包 1 派发 / 0 llm-call / LaTeX 3/6（时点值）与包账本及卡面顶（≤4/≤4/≤6）一致 |
| 披露四要素 / 作者栏 / PII | PASS（除 F-A 书目） | 四要素齐；作者栏仅账号名 Aurora0134（ORCID 占位）；AI 未进作者栏；全包 0 邮箱/0 ORCID 实值/0 本机路径 |
| c9-record.md | PASS | Part 1 = deep-recheck-combm-01.md 整文件 49 行逐字（源 sha256 `9d8f7e0c…772e3` 现算一致，仅文件末换行被 part 2 分隔符取代、内容零差异）；Part 2 = shared.md 131-137 行逐字（586 B，`d5270429…`）；全量查询记录含零命中；结论句零改写；`--check` 2/2 PASS |
| sanitize 复跑 | PASS | 首轮即 ALL GATES GREEN（21 件 / 308,825 字节时点值） |
| 包体自我描述 | PASS（除 F-C） | FILE-MANIFEST 20 行复算正确、盘上 21 件无缺无余；zip 21 条目 = 存缴树；RESERVED-DOI 无尖括号占位串；GitHub 镜像全链路条件式；页数豁免三处记录 |
| 编译/质检证据 + 渲染层 | PASS | paper-lint 独立复跑 PASS；claim.log 实测 14 页 / Missing 0 / Overfull 0；pdftotext 抽关键句全部在案 |

## 二、发现与处置（首轮 3 条 + 复审 1 条 + 终验 2 条）

| # | 轮次 | 发现（审计实测） | 处置 |
|---|---|---|---|
| **F-A** | 首轮 | `\bibitem{lean4}`/`\bibitem{mathlib}` 无任何 cite（PDF References 渲染出两条 dangling），且 claim.tex 自述「only entries actually cited above are listed」失实 | Verification evidence 工具钉版句补 `\cite{lean4}`/`\cite{mathlib}`（claim.tex:440-442，与论文包 paper.tex:287-288 同构）；bibitem 保留。复审对账：cite 7 处 / bibitem 8 条，悬空 0、未引用 0；PDF 渲染 [1][2] 在工具链句 |
| **F-B** | 首轮 | (b) 节「all task-stage sampling ran on a single node」与源 budget.log 第 25 行（F1 闭环节复审 node=stepfun/step-5-preview）矛盾——「单一节点」定性断言越出账本 | claim.tex:596-606 补漂移限定句（one audit dispatch on 2026-09-28 carried a model-detection reading of stepfun/step-5-preview; the ledger's accounting node stayed kimi-k3 and the drift is disclosed rather than reconciled by substitution）；README.md:92 同句同步 |
| **F-C** | 首轮 | README.md:83 行尾说明把 claim/ 计为「三件」，实为两文本件 + claim.pdf 二进制 | 改「claim/ 两件文本件（另 claim.pdf 为二进制）……文本件合计 20 件，加 claim.pdf 共 21 件」；与盘上逐一吻合 |
| **F-D** | 复审 | compile.txt 摘录块过期：引 claim.log 中不存在的 3 行（simsun 警告 / Transcript written / note: Writing claim.pdf——后两者为 tectonic 控制台输出）、字节数 371356（实测 374700）、Underfull 记 8/2351（实测 9/10000）；两副本同病 | 主代理机械修复：摘录块按 claim.log 真实行重写（xeCJK Warning L536 / rerunfilecheck L610 / Output written L613，bytes 374700）、Underfull 订正 9/10000、块标题注明「tectonic 控制台行不入本块」；两副本同步；manifest 重算、zip 重建、sanitize 复跑 |
| **F-E/F-F** | 终验 | 同族残留：README.md:97「Underfull 8 处」未随 F-D 同步（compile.txt/budget.log 已 9/10000）；README.md:37 compile.txt 描述「两轮关键行摘录」而轮次台账实为 4 轮（README:92、UPLOAD:52 均 4/6） | 主代理顺手修复：README:97 改「Underfull 9 处（badness 最高 10000）」；README:37 改「四轮」；随 F-D 同批 manifest/zip/sanitize 重跑 |

## 三、合并终验（第三轮，只读独立复算）——两包派工修复本体全部通过

- **F-D 修复本体**：摘录块三行在 claim.log 真实存在且逐字节精确（536/610/613，Output written 全日志唯一）；字节数 374700 一致；Underfull 9 处（7×10000 + 1102 + 1668，最高 10000）与 compile.txt:35 一致；两副本 sha256 同 `8b79e0a4…`；FILE-MANIFEST compile.txt 行与盘上一致、全清单 20 行 0 mismatch；sanitize 复跑 ALL GATES GREEN（21 件 / 309,966 字节时点）；zip 21 条目 = 存缴树逐条目哈希一致。
- **F-A/F-B/F-C 在位无回退**：claim.tex:440-442 cite 在、bibitem 在 639/645；claim.tex:596-606 与 README:92 漂移句在；README:83 两文本件口径在；claim.tex 无 `<<`；listing 抽 2 块（statement 39-53 / proof 320-334）逐字节相同；无越级措辞。
- **F-E/F-F**（终验新抓 2 条同族残留）：已由主代理在本记录落盘前修复（见第二节表格），manifest/zip/sanitize 随末次刷新重跑。
- **终验另记**：源仓 `audit/sanitize-run.txt` 留档为装配轮旧值（21 件/310,204 字节），现值 309,966 字节；留档已随末次 sanitize 复跑刷新。门③书面闭环 = 本文件（落源仓 audit/ 并按 SOP 工序 4 入存缴树 audit/）。

## 四、门禁终态

- **占位质检门**：① paper-lint exit 0 PASS；② paper-compile exit 0（LaTeX 4/6，14 页 / Missing 0 / Overfull 0 / 未解引用 0，四轮均 exit 0 无失败轮）；③ 精简主张审计零遗留。sanitize 机械门 ALL GATES GREEN；zenodo-package.zip 21 条目。
- 观察项（不计发现）：「50+ independent strings」在包内自带证据中分解为 41+（源记录自身口径松散）；短笺照抄 C9 结论句符合「禁止改写 C9 记录」，建议记录属主补注，不由本包单方改数。
- **外发前必跑（只读）**：`python scripts/sanitize-package.py claims/grid3n-diag-2notch` 任一红灯即不得外发。
