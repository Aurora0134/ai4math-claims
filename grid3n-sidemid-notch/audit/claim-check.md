# 占位精简主张审计记录 claim-check.md — claims/grid3n-sidemid-notch/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限），共三轮针对本包（首轮 + 改后复审 + 合并终验）；本文件由主代理按工人回交原文落盘。
> **状态：首轮 3 条 FINDINGS（1 medium + 2 low，均散文/元数据层，不涉冻结件）→ 修复 → 复审抓 F-4（low，轮次自述矛盾）→ 主代理机械修复 → 合并终验复算：派工修复本体全部通过、另记 2 条同族残留（sanitize 留档陈旧 / listing-verify 追加碎片）已由主代理清理。占位质检门三格全绿。**
> 审计自耗：各轮均 llm-call 0 / Lean 编译 0 / 写文件 0。端点 zcode（endpoint-detect 本 shell 实测 unknown，按卡面口径记入）；派发节点 model-detect 读数 `anthropic/stepfun/step-5-preview`（卡面记账节点 `anthropic/a6api-main/kimi-k3`，漂移已在卡面与短笺披露）。

## 一、第一轮 PASS 项（审计独立复算，未采信生成方自报件）

| 核对项 | 裁决 | 证据 |
|---|---|---|
| 三条 `% LEAN:` 锚点 | PASS | `asid_interleave` / `asid_mod2_period3` / `asid_mod4_period12` 均在源冻结件与终稿；grade=完全证明与 `audit/final-comb08-sidemid.txt` §五一致；statement sha256 现算 `5fe889d5…9e67`（源/包/`.statement.txt` 三处一致）、final `19b5c390…0821`；LF 无 CR；109/238 行；公理探针与源逐字节一致均 [propext, Quot.sound]；终稿 sorry/admit grep 零命中 |
| listing 逐字节（8 块） | PASS | 自写抽取器（非采信 listing-verify.txt）：8/8 与源文件精确字节段逐字节一致（455/1398/438/563/1655/1558/736/892 B）；与论文包 `papers/grid3n-sidemid-notch/paper.tex` 同批块完全相同；包内 claim.tex/lstlean.tex/claim.pdf 与交付根逐字节一致 |
| 预算数字 | PASS | 短笺披露 14/20、1/6、26/32、9/10 = 源 budget.log 第 61 行机器对账终值；zenodo.json 同；本包 budget.log（时点 LaTeX 3/6、采样 1/4、llm-call 0/4、Lean 0/0）在卡面顶内；源 report.md §三 12/22/0 为被第 61 行明示订正的过期旧值，短笺取订正终值正确 |
| 披露四要素 | PASS | (a) 环节枚举 (b) 模型-节点-预算（含同日双节点漂移披露、无跨节点）(c) kernel 终裁声明 (d) 作者负责声明齐备；作者栏仅账号名 Aurora0134，AI 未进作者栏、在 contributors；PII 扫描 0 命中；`<<` 在短笺 0（UPLOAD.md 1 处为红线自查文案）；RESERVED-DOI 为显式未填字段 |
| c9-record.md | PASS | 包内件 = deep-recheck-combm-02.md 整文件 46 行逐字（源 sha256 `79e7ee63…df98` 复算一致）+ shared.md §8 第 131–137 行逐字（586 B）；含零命中记录（OEIS 10 新串全零命中、库层 total=0）；结论句零改写 |
| sanitize 复跑 | PASS | ALL GATES GREEN（22 件 / 325,729 字节时点）；FILE-MANIFEST 21 行逐件复算 0 不符；zip 22 条目 = 清单 21 + 自身 |
| 编译/质检证据 | PASS | claim.log 实测 15 页 / Missing 0 / Overfull 0 / 无未解引用（唯一 SimSun 斜体观感告警），与 compile.txt、包 budget.log 三轮记录、README「15 页三轮全绿」逐项一致；PDF 渲染层 pdftotext 抽关键句全在（CJK 无 ToUnicode 映射致中文抽取为 0 属提取局限，源 tex 已逐字节核） |

## 二、发现与处置（首轮 3 条 + 复审 1 条 + 终验 2 条）

| # | 轮次 | 发现（审计实测） | 处置 |
|---|---|---|---|
| **F-1（中）** | 首轮 | novelty 节把 A129113 误述为「偶 n 完美匹配子列」（继承 A061278 的 even-n 限定）；源记录：A061278 = comb-07 偶 n PM 子列（shared:44 + combm-01:14/150），A129113 = comb-09 连续 n PM 子列（combm-03:17「PM 子列 = 1,1,6,12,…」，一审核读 A129113 数据 0,0,0,1,1,6,12,… 去前三零逐位一致，pm(1)=1≠0 绝非仅偶 n）；书目 `oeis-a129113` 自身只写「the perfect-matching subsequence」，正文与书目自相矛盾 | claim.tex:529-535 改为「…is A061278, and the perfect-matching subsequence of another neighbouring defect configuration is A129113」；even-n 限定只留 A061278；书目原句不动。复审核源 combm-03:17 + shared:44 逐字吻合，旧错措辞 PDF 零残留 |
| **F-2（低）** | 首轮 | sequence-search 行「$60+$ across the batch」超出包内证据：随包 c9-record.md（combm-02 整文件）明文本序列累计 50+；60+ 出自未随包的 shared.md:68（三候选批级汇总）——包内读者只能核到 50+ | claim.tex:463-466 改「$50+$ independent strings for this sequence across rounds; $60+$ across the three-candidate batch per the shared record, not shipped in this deposit」；zenodo.json description 同句同步（防 R-1 式「正文改、元数据漏改」） |
| **F-3（低）** | 首轮 | 关键词行「four short-string generic hits」把「4 组」误述为 4 条（shared.md:65：4 组各约 10/10/3/3 条，逐条核读排除；combm-02 §3 亦为「短串 10 条泛命中」），少报约一个量级已读噪声 | claim.tex:470-471 改「four groups of short-string generic hits, read entry by entry and excluded」 |
| **F-4（低）** | 复审 | README.md:31 自述「三轮」与同件第 23 行「四轮」、UPLOAD.md:52「四轮编译全绿 4/6」、compile.txt Round 4 段矛盾；compile.txt 头 "Rounds: 3" 追加 Round 4 段后过期 | 主代理机械修复：README.md:31 改「四轮」；compile.txt 两份副本头改 "Rounds: 4 (all exit 0; no failed round)"；manifest 重算、zip 重建、sanitize 复跑 |
| **F-5/F-6** | 终验 | 同族残留：源仓 `audit/sanitize-run.txt` 留档为装配轮旧值（22 件/328,262 字节，现值 328,229）；`audit/listing-verify.txt`（及存缴副本）第 11-13 行残留脚本追加碎片（record appended 行 / 裸哈希行 / 重复 PASS 行），不影响 8/8 PASS 结论 | 主代理清理：listing-verify 保留完整自含的第二段记录（含头/注/8 行 PASS，11 行），去掉旧段与碎片、两副本同步；sanitize-run.txt 随末次复跑刷新 |

## 三、改后复审与合并终验（只读独立复算）

- **复审（第二轮）**：F-1/F-2/F-3 三条均已修复且逐项回归 PASS——claim.tex 新文本与 zenodo/claim/ 副本逐字节一致、PDF 渲染层同句实测在位、旧错措辞零残留；50+/60+ 口径经核包内 c9-record.md:45（50+）与未随包 shared.md:68（60+，"not shipped in this deposit" 属实）；「four groups」与 shared.md:65「4 组、逐条核读」逐字口径一致。回归：compile.txt 与 claim.log 一致（15 页/Missing 0/Overfull 0/exit 0/轮次 4/6）；FILE-MANIFEST 21 行 0 mismatch；zip 22 条目 = 存缴树；sanitize ALL GATES GREEN；listing 8 块逐字节未动；渲染层关键句全在；「递推非新」围栏四处仍在；novelty 结论仍为 "negative-search evidence, not a first-discovery assertion"。
- **合并终验（第三轮）**：F-4 修复本体通过——README:31「四轮」与同件:23、UPLOAD:52、compile.txt Round 4 段一致；compile.txt 两副本头均 "Rounds: 4"；终轮指标与 claim.log 一致（15 页、Missing 0、Overfull 0、Output written 409,440 字节）；F-1/F-2/F-3 在位无回退；FILE-MANIFEST 0 mismatch；sanitize ALL GATES GREEN（22 件 / 328,229 字节）；zip 22 条目逐条目哈希一致；listing 抽 2 块逐字节相同；无越级（价值级仅 new sequence、递推非新已明示）。
- 非阻断备注（终验）：F-3 所在表行行头 "OEIS, keyword" 而源记录 4 组中 2 组实为序列检索分子串泛命中——新句本身未声称四组均属关键词，行结构为修复前既有，后续润色可分行归属，不影响本包主张。

## 四、门禁终态

- **占位质检门**：① paper-lint exit 0 PASS；② paper-compile exit 0（LaTeX 5/6，15 页 / Missing 0 / Overfull 0 / 未解引用 0，五轮均 exit 0——第 5 轮为镜像推送轮：镜像句条件式改事实陈述，纯散文层、listing 源字节零改动、指标与此前逐项一致）；③ 精简主张审计零遗留。sanitize 机械门 ALL GATES GREEN（23 件 / 336,274 字节）；zenodo-package.zip 23 条目。
- **外发前必跑（只读）**：`python scripts/sanitize-package.py claims/grid3n-sidemid-notch` 任一红灯即不得外发。
