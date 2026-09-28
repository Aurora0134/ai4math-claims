# 占位精简主张审计记录 claim-check.md — claims/grid4n-col-2notch/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限），共两轮针对本包；本文件由主代理按工人回交原文落盘。
> **状态：第一轮 2 条 FINDINGS（均 medium，均为包体自我描述/指标失真类）→ 装配工人修复 → 改后复审 PASS（零遗留）。占位质检门三格全绿。**
> 审计自耗：两轮均 llm-call 0 / Lean 编译 0 / 写文件 0。端点 zcode（endpoint-detect 本 shell 实测 unknown，按卡面口径记入）；派发节点 model-detect 读数 `anthropic/stepfun/step-5-preview`（卡面记账节点 `anthropic/a6api-main/kimi-k3`，漂移已在卡面与短笺披露）。

## 一、第一轮 PASS 项（审计独立复算，未采信生成方自报件）

| 核对项 | 裁决 | 证据 |
|---|---|---|
| 三条 `% LEAN:` 锚点 → 声明名 / 分级 / 源任务 | PASS | `atc_interleave` / `atc_mod2_period5` / `atc_mod4_period10` 均在冻结 statement 出现 1 次；statement sha256 现算 `4cb10838…ce005`、final `f1aa7099…6f53f` 与卡面/短笺/README/manifest/audit 全一致；分级【完全证明】照抄 `audit/final-comb09-4ntwocorner.txt:48`；终稿 sorry/admit/sorryAx grep = 0 |
| listing 逐字节（9 块） | PASS | 自写抽取器逐块比对 9/9 与源行段逐字节一致（仅差 `\end{lstlisting}` 前 LaTeX 行终止符）；终稿 CRLF→LF 归一化、未改其他字节；caption 行段全部为真 |
| 公理原文块 | PASS | 与三件 `axioms-*.txt` 逐字一致（`atc_interleave` [propext, Classical.choice, Quot.sound]；另两条 [propext, Quot.sound]；白名单子集） |
| 措辞 ≤ 分级 且 ≤ C9 | PASS | 全文无 first/new-mathematics 越级；C9 裁决块与 `deep-recheck-combm-03.md` §0 逐字一致；两条占位围栏在位（A033507 同谱禁 novelty、A129113 已占位禁 novelty，与 `phase0/claims.md:6` 逐字）；组合语义桥由 Conjecture 承载并在 abstract/Statement/Scope(a) 三处明示未证 |
| 预算数字 | PASS | 源 budget.log 各行实计：采样 9（第 2/3/7/9/11/19/21/25/26 行）、llm-call 1（第 5 行）、Lean 编译 25（2+3+4+2+4+2+1+2+3+2）；与短笺 9/20、1/6、25/32 及 zenodo.json 一致 |
| 披露四要素 / 作者栏 / PII | PASS | 四要素 + CRediT 齐；作者仅账号名 Aurora0134、ORCID 占位；AI 仅在 contributors 且明示非作者；zenodo/ 全树与 PDF 明文 PII 扫描 0 命中 |
| c9-record.md | PASS | Part 1 = deep-recheck-combm-03.md 整文件逐字（47 行/5286 B）；Part 2 = shared.md 第 131–137 行逐字；两源 sha256 现算一致；零命中查询全量在内；`--check` 2/2 PASS |
| sanitize 复跑 | PASS | 默认跑法 + `--scanned/--skipped` 显式清单跑法各一次均 ALL GATES GREEN |
| 编译/质检证据 | PASS（除 F1 指标） | 17 页、Missing 0、终遍未解引用 0、exit 0、LaTeX 1/6、lint PASS exit 0 均为真 |

## 二、第一轮发现与处置

| # | 工序 | 发现（审计实测） | 处置 |
|---|---|---|---|
| **F1（中）指标失实** | 4 | 5 处自述「Overfull \hbox 0」为假：claim.log 实测 9 处，最大 199.66289pt（主递推显示式 199.66 / 59.83 / 8.03，两条 64 位 sha256 `\texttt` 157.56 / 142.54 / 160.35，路径 9.11 / 38.22 / 158.70）。位置：`zenodo/audit/compile.txt:8`、`zenodo/metadata/README.md:28`、`:98`、`budget.log`、`UPLOAD.md:53` | **F1-a 渲染修复**：主递推显示式改 `align` 两行可断；两条 sha256 拆两段加 `\allowbreak`；长 `\texttt` 路径三段拆分；同族修复 statement/final 路径与初值内联列表（逐数 `$…$`）。**F1-b 指标订正**：重编译（LaTeX 2/6→3/6）后按实测订正全部 5 处——终轮 Overfull **5 处：31.59 / 8.03 / 38.34 / 9.11 / 38.22pt，最大 38.34pt**（三处目标溢出 199.66/160.35/158.70 全部消除）；Underfull 19 观感；pymupdf 全页右缘扫描最大 522.65pt < 612pt、**0 块越页**。budget.log 按追加订正纪律：原假行保留不修饰、订正行点名判假并给实测值 |
| **F2（中）卡面页数** | 1/4 | card.md「页数口径」节只记「预期约 10 页」未记实际 17 页，却自称「本卡与 README 各记一行实际页数」；`README.md:97` 把卡面没有的句子归给它 | card.md 补「**实测：17 页**（超出构成＝九处逐字 listing 共 234 行 + C9 查新表 + 两条逐字裁决/围栏块）+ 豁免出处（SOP 08b《已知边界》页数豁免条款，用户 2026-09-28 追认）」一行；README.md:97 改为与卡面一致的引述 |
| **观察 5** | — | 首轮审计员复跑 listing 核验时脚本追加写盘，致源仓 `audit/listing-verify.txt` 多出追加段（随包件未受影响） | 追加段移除，修版后复跑 `--verify`（9/9 PASS，body 哈希与修前逐位一致），恢复单段 12 行；两副本同哈希 |

## 三、改后复审（第二轮，只读独立复算）——PASS 零遗留

F1-a / F1-b / F2 / 观察 5 四项均已修复且全部回归项复算通过；工人自报与实测全部相符：

- **F1-a**：claim.tex 三处断行在位（align 多行 / sha256 两段 / 路径三段）；claim.pdf 与修版 tex 对应（pymupdf 实测 17 页、全页右缘最大 522.65pt、0 块越页；PDF 文本层含断行后片段证明非旧 PDF）；listing 源字节未动（抽 L1/L6/L9 三块逐字节 PASS，body 哈希与 listing-verify.txt 一致）。
- **F1-b**：claim.log 实测 Overfull 恰 5 处（31.59418 / 8.02603 / 38.33876 / 9.11327 / 38.21832pt）、Underfull 19、17 页、Missing 0、未解引用 0——与 compile.txt 指标头、README:28/98、UPLOAD:53、budget.log:9 全部吻合；全包 grep「Overfull 0」现存 5 处均处「明示为假」语境（原假行按订正纪律保留 + 订正行点名），无任何活口径再当事实。README:98「31.59/8.03 与论文包同显示式同值」经 paper.log 复核属实。
- **F2**：card.md:87 实测页数行在位；README:97 引述与卡面实际文字一致。
- **观察 5**：listing-verify.txt 单段 12 行，与 3 块独立复验一致。
- **回归**：FILE-MANIFEST 18 行逐件复算 0 mismatch、盘上无缺无余（含清单 19 件）；zip 19 条目 = 存缴树逐字节一致（CRLF 终稿过 zip 仍 CR=420）；sanitize 两种跑法 ALL GATES GREEN（19 件 / 357,755 字节）；paper-lint PASS exit 0；`<<` 0 处；轮次 3/6 与件数 19 口径全件一致；两条占位围栏逐字在位；c9-record.md `--check` 2/2 PASS。
- **越级**：修复引入文本均为数字订正与页数记述，无分级措辞；价值级仅 new sequence（claim.tex 明示修正早前「new sequence and new recurrence」并声明非首创）。

## 四、门禁终态与非阻断备注

- **占位质检门**：① paper-lint exit 0 PASS；② paper-compile exit 0（LaTeX 4/6，17 页 / Missing 0 / Overfull 5 处最大 38.34pt / 未解引用 0——第 4 轮为镜像推送轮：镜像句条件式改事实陈述，纯散文层、listing 源字节零改动、指标与第 3 轮逐项一致）；③ 精简主张审计零遗留。sanitize 机械门 ALL GATES GREEN（20 件 / 366,459 字节）；zenodo-package.zip 20 条目。
- 非阻断备注 1：修版 zip 重建与 budget.log 一次重建记录间差一次重建，zip 已实测与修版存缴树逐字节一致，无内容风险（重建记账见本包 budget.log 末行）。
- 非阻断备注 2：card.md 第二条围栏较源文多「（完美匹配）」gloss（第一条为逐字），含义未越；随包短笺 claim.tex:641 为源文逐字，不受影响。
- **外发前必跑（只读）**：`python scripts/sanitize-package.py claims/grid4n-col-2notch` 任一红灯即不得外发（SOP 08b《已知边界》）。
