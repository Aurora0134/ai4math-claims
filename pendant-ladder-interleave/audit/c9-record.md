> provenance note (added by the claim packager, 2026-09-28): this file is the
> full C9 novelty-review record for MAT-PEND (pool-mossad-01), copied VERBATIM
> and byte-for-byte in four contiguous line ranges from
> `tasks/20260927-mossad-select/c9-recheck/chunk-F.md` (source file sha256
> 2067ce90a6d9305c9c5acfa08bd598b5aaeedf7c97e0e4835e410f3fe6aa61cf; 225 lines, LF):
>
>   lines 1-6      chunk header, query discipline and access channel
>   lines 8-13     the anchor self-proof that fixes what "zero hit" means
>   lines 17-94    the MAT-PEND entry in full: independent recomputation, the
>                  11 main-sequence + 6 odd-subsequence + 6 even-subsequence
>                  OEIS variant queries, the A386889 single-entry verification,
>                  literature/library/Lean-ecosystem layers, alias set, C9
>                  verdict, value tier, pool recommendation
>   lines 213-225  the block roll-up table, query statistics, the grey-zone
>                  memo that names MAT-PEND, and the chunk budget line
>
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses remain in the working repository under
> `tasks/20260927-mossad-select/` (kept in-repo, not shipped in this deposit).
> The exclusivity review was run by selection-department workers at 0 LLM calls.
>
> Packager's correction pointer (not part of the record body): the
> alternating-attachment invariance stated at source line 27 of the record
> (observed on the first-8 window) was later REFUTED by the task's Phase 0:
> alternating and uniform-side attachments differ from n=3 on
> (3,10,47,143,... vs 3,10,46,141,...; three independent methods agree, and the
> pool card was corrected accordingly). The combinatorial reading in the claim
> note is therefore fixed to the uniform-side convention. The refutation record
> lives in `tasks/20260927-mossad-pend/phase0/` and the task report; the record
> body below is left exactly as the review wrote it.
>
> The C9 verdict carried into the claim note is: no occupying record found for
> the main sequence; the odd-position subsequence is ALREADY OCCUPIED (OEIS
> A386889, Dresden and Demirkol, 2025-09-04); value tier "new sequence / new
> recurrence" with an occupancy warning.

# F C9 重裁记录（swarm 波次 2 匹配/递推/二项式/行列式族；工人独立查新，llm-call 0）

> 候选：MAT-PEND / MAT-PRISM / MAT-MOBLAD（mossad-full.txt L5812-5983 / L5984-6160 / L6161-6340）。
> 纪律依据：SOP 01《C9 文献独占性查新》（查询纪律 7 条 + OEIS 访问手册 + 题源自述处置 + 价值主张分级表）。
> 波次 1 教训执行：三个候选全部是计数型，均先用 Python 独立暴力重算前 3–6 项（实际算到 8–9 项并核到偏移级）后才做 OEIS 查新。
> 所有 OEIS 检索走 `curl -x http://127.0.0.1:4180 --ssl-no-revoke "https://oeis.org/search?q=...&fmt=json"`；单条核读走 jsdelivr 镜像。外部报告的一切结论仅作线索记录，不作为证据。

## 锚点自证

- OEIS `0,1,1,2,3,5,8,13` → **A000045**（Fibonacci numbers，%S 逐位一致）✓
- OEIS `1,3,13,22,44,90,196,406` → **A180970**（3×n tatami 铺砖含单体，%S 逐位一致）✓

两条锚点均本机实跑通过，OEIS 数据层本块判「可用」。外部报告用的锚点串 `3,,,1,3,,,2,2,,` 未使用（已知剥除缺陷）。

## MAT-PEND 每两列带一悬挂叶的梯子图匹配数

- 命题草图：设 a(n) 为每两列带一悬挂叶的梯子图匹配数；给出其递推或闭式。
- 送检数列（逐字抄录）：`3,10,46,141,660,2015,9440,28814,134997,412049,1930506,5892443`
- 外部报告原判（线索，非证据）：数据层「零命中（6 个变体查询全部 no-results）」；关键词层 zbMATH 404 / arXiv 空响应体（其自述不构成零文献证据）；OpenAlex 补充层命中量 10/11（其自称中等拥挤）；建议「可进下一阶段」。**注意：其 6 个变体全部是主数列变体，未查奇偶子序列。**

### 独立重算（计数型候选必做，先于查新）

- 方法：Python 暴力枚举全部匹配（按最小存活顶点分支 + 记忆化，精确计数）。图构造按题面重建：梯子图 L_n = P_n × K_2（n 列；每列一条横档 + 上/下两条轨），悬挂叶挂于每个奇数编号列（1,3,5,…）——即「每两列带一叶」的一对一读法。
- 结果：**a(1..8) = 3,10,46,141,660,2015,9440,28814，与送检数列前 8 项逐位一致** ✓（送检数列 = 命题真实计数，非 artifact）。另用周期 2 转移矩阵（列状态 ⊆{上,下}）生成 26 项，前 12 项与送检数列逐位一致（第 13 项起：27606911, 84263988, 394788456, 1205004409, 5645612584, …）。
- 挂法鲁棒性：叶挂上侧/下侧/上下交替（两种交替）共四种挂法，前 8 项计数全部相同（上/下由梯子反射对称等价；交替挂法前 8 项亦一致），故「每两列一叶」的挂侧歧义不影响送检数列。
- 递推（本工人拟合，26 项、≥2k 方程精确求解）：**a(n) = 16·a(n−2) − 25·a(n−4) + 10·a(n−6) − a(n−8)**（order 8、仅偶滞后项）；奇数/偶数子序列各自满足 **a(k) = 16·a(k−1) − 25·a(k−2) + 10·a(k−3) − a(k−4)**（特征多项式 x⁴−16x³+25x²−10x+1，ℚ 上无有理根、无整二次因子 → 不可约，**无 Binet 型初等闭式**，闭式只能是该四次根的 RootSum 型表达式）。
- 结构发现（重要）：奇数子序列 = 「3×(2n−1) 条带、顶行每隔一格去掉一格」缺口板用 1×1+1×2（任意方向）铺满的铺法数。本工人独立暴力核验：该板铺法数 n=1..5 = 3,46,660,9440,134997，与 PEND 奇数子序列逐位一致；两图度数序列 n=1..4 完全一致，n=2 给出显在双射（该缺口板与「叶挂奇数列的 L_{2n−1}」同构，匹配 ↔ 铺法是网格图标准对偶）。

### 我方查新记录

**OEIS**（查询串 → 返回，零命中也列）：

- `3,10,46,141,660,2015,9440,28814`（原串）→ ZERO-HIT
- `10,46,141,660,2015,9440,28814,134997`（去前 1）→ ZERO-HIT
- `46,141,660,2015,9440,28814,134997,412049`（去前 2）→ ZERO-HIT
- `660,2015,9440,28814,134997,412049,1930506,5892443`（去前 3）→ ZERO-HIT
- `2,9,45,140,659,2014,9439,28813`（每项 −1）→ ZERO-HIT
- `4,11,47,142,661,2016,9441,28815`（每项 +1）→ ZERO-HIT
- `9,45,140,659,2014,9439,28813,134996`（−1 再去 1）→ ZERO-HIT
- `11,47,142,661,2016,9441,28815,134998`（+1 再去 1）→ ZERO-HIT
- `1,8,44,139,658,2013,9438,28812`（每项 −2）→ ZERO-HIT
- `6,20,92,282,1320,4030,18880,57628`（×2）→ ZERO-HIT
- `20,92,282,1320,4030,18880,57628,269994`（×2 再去 1）→ ZERO-HIT
- 每项 ÷2：a(1)=3 为奇数，非整除 → 不适用（跳过并记录）
- 派生物·奇数子序列 `3,46,660,9440,134997,1930506` → **命中 A386889**
- `46,660,9440,134997,1930506` → A386889
- `3,46,660,9440,134997` → A386889
- 派生物·奇数子序列 −1 `2,45,659,9439,134996,1930505` → ZERO-HIT
- 派生物·奇数子序列 +1 `4,47,661,9441,134998,1930507` → ZERO-HIT
- 派生物·奇数子序列 ×2 `6,92,1320,18880,269994,3861012` → ZERO-HIT
- 派生物·偶数子序列 `10,141,2015,28814,412049,5892443` → ZERO-HIT
- `141,2015,28814,412049,5892443,84263988`（去 1）→ ZERO-HIT
- `10,141,2015,28814,412049,5892443,84263988,1205004409`（8 项）→ ZERO-HIT
- 派生物·偶数子序列 −1 `9,140,2014,28813,412048,5892442` → ZERO-HIT
- 派生物·偶数子序列 +1 `11,142,2016,28815,412050,5892444` → ZERO-HIT
- 派生物·偶数子序列 ×2 `20,282,4030,57628,824098,11784886` → ZERO-HIT
- 关键词 `pendant ladder graph matchings` → 仅无关噪声（A000045、A11973）
- 关键词 `ladder graph with pendant edges Hosoya` → 仅无关噪声（A000045）
- 关键词 `Hosoya index pendant` → 仅无关噪声（A000045）
- 关键词 `matching polynomial pendant ladder` → 仅无关噪声（A11973、A000045）

**A386889 单条核读**（jsdelivr `seq/A386/A386889.seq`）：%S = `0,3,46,660,9440,134997,1930506,27606911,394788456,5645612584,80734228548,1154527619817,16510147540756,236100866829567,…`；%N = "Number of ways to use 1 X 1 squares and 1 X 2 dominos (in any orientation) to tile a 3 X (2*n - 1) strip with every other cell in the top row removed"；%F signature **(16,-25,10,-1)**；%O 0,2；%A Greg Dresden and Derin Demirkol, 2025-09-04。**我方 PEND 奇数子序列 a(2n−1) = A386889(n)（n≥1），偏移对齐 13 项逐一核对成立**，且递推 signature 与本工人独立拟合的四次式完全一致（结构同构非巧合）。记录在案：该条目 %e 示例写 "a(4)=9940" 与 %S 的 9440 不符（OEIS 条目笔误）。

**文献层**：

- zbMATH `Hosoya index ladder graph pendant` → 404 no-results（通道可用的零读数）
- zbMATH `matchings ladder graph pendant vertices` → 404 no-results（通道可用的零读数）
- zbMATH `matchings in ladder graphs` → 17 hits：E. J. Farrell, **"Matchings in ladders"**, Ars Comb. 6, 153-161 (1978)（Zbl 0414.05042；短/长**普通**梯子匹配多项式母函数+递推+defect-d 匹配，**不含 pendant 结构**）；另有 "WITHDRAWN: The Number of Perfect Matchings in Möbius Ladders and Prisms"（已撤稿，不作证据）、"Matchings in square animals" 等
- zbMATH `matching polynomial ladder graph` → 9 hits（Farrell 1978 等，同上）
- zbMATH `pendant graph matching polynomial` → 15 hits（均为良覆盖树/独立多项式主题，无 pendant 梯子）
- zbMATH `ladder graph Hosoya index` → 1 hit：Sabzevari & Maimani, Iran. J. Math. Sci. Inform. 3 (2008) 41-48（K_2×H 的 Hosoya 指数，H=P_n/C_n/S_n——覆盖普通梯子与环梯，**不含 pendant**）
- OpenAlex `pendant ladder graph matchings` → meta.count = 235（全文检索噪声：首条为支配集专著，非本对象占位证据）
- OpenAlex `monomino domino tiling notched board` → meta.count = 0
- OpenAlex `Dresden Demirkol tiling deficient rectangles` → 429 / 未验证（按纪律记未验证，不重试）
- arXiv all:"Moebius ladder matchings" → totalResults 0；all:"prism graph matchings Hosoya" → 0；all:"pendant ladder matching" → 0（精确短语口径，判别力弱，仅辅助）
- arXiv au:Demirkol → 19 条（无铺砖相关）；au:Dresden_G → 0（A386889 的出处仅见 OEIS 条目本身，未找到单独论文/预印本）
- MSE `pendant ladder matching` → 0 items
- 网页检索：DDG（html/lite）经本地代理均返回空页；Bing 经代理返回 180 字节壳页、经 FetchURL 返回中文 locale 词典噪声（无数学文献命中）；Mojeek 经代理/FetchURL 均失败；grep.app 被 Vercel 安全检查点拦截 → **网页检索层记「未验证」，不作为零文献证据**（OEIS 数值层主证据不受影响）

**库层**：

- mathlib `Hosoya|matching polynomial|matchingPolynomial` → 零命中；`prism|Möbius ladder` → 零命中（`Moebius` 命中全是数论 Möbius 函数/反演）；`Mathlib/Combinatorics/SimpleGraph/Matching.lean` 仅有 `IsMatching`（:67）/`IsPerfectMatching`（:236）谓词，**无任何匹配计数/Hosoya 指数/匹配多项式函数**
- compfiles `matching|prism|ladder|Moebius|Hosoya` → 7 文件命中全部无关（Imo1979P2 五角棱柱边染色、Usa2022P1 序列对齐、Usa2018P6 对合 maximal matching 注脚、Usa2020P2 长方体梁等）
- sequencelib（本地快照）→ 无 A386889/A102080/A020877 等条目文件；无 ladder/prism/Hosoya/matching 主题文件（`Moebius.lean` 是 Möbius 函数）

**Lean 生态**：GitHub repo search `lean hosoya` → 0；`lean matching polynomial` → 1（ElVec1o/rama-notes，d-matching polynomial 笔记，非本序列）；`lean sequencelib` → provables/sequencelib（本地快照已查，零命中）；agenticsnz/unsorry 全树 36957 blobs 扫描：prism/hosoya/moebius → 0 路径，match → 6 路径全为工具 fixture。

- 别名集：ladder graph = P_n × K_2 = open ladder（普通/开端梯子图）；pendant leaf/vertex（悬挂叶/悬挂点）；matching = independent edge set（独立边集）；Hosoya index（匹配总数/Hosoya 指数）；matching polynomial（匹配多项式）；monomer-dimer covering（单体-二聚体覆盖）；notched/deficient board tiling（缺口板/残缺板铺砖，仅奇数子序列的解释层）；d-matching（defect-d matching）

- **C9 裁决**：**查无占位（主数列）+ 派生命题（奇数子序列）已占位**。主数列及去 1/去 2/去 3、±1、±2、×2、×2去1 共 11 个变体零命中（÷2 因首项奇数不适用）；偶数子序列 6 个变体零命中；锚点自证可用 → 主数列按 SOP 01 判「查无占位」。但奇数子序列 **A386889**（OEIS，2025-09-04，Dresden & Demirkol）逐位对齐坐实，且与本命题同构（缺口板铺砖 ↔ 叶挂奇数列梯子匹配，本工人独立核验计数/度数序列/双射）——该子命题按「已占位」记录。外部报告 6 变体全零命中的数据层结论被我方复现，**但其变体集未含奇偶子序列，漏检了 A386889 这处占位**（SOP 01 纪律 6「派生命题独立查新」的又一实证）。文献层：pendant 专项 zbMATH 两查 404 零读数、MSE/arXiv 零命中，普通梯子匹配多项式有 Farrell 1978 挂名但结构不同 → 对象层无同命题挂名。
- **价值级**：**新序列/新递推**——主数列、偶数子序列、完整偶滞后递推在 OEIS 与对象层文献均无挂名；但奇数子序列已发表（含同款递推 signature），「全新」主张必须限定范围。灰区个案，按任务要求如实标注交主代理与闸门一。
- **题库建议**：**入池（附占位警示）**——候选卡须注明 A386889 先占奇数子列及其同构解释；建议命题表述为「完整递推 + 偶数子序列」而非泛泛「新序列」；入池条目按 pools 规程标「未冒烟」，捞取入批时补 C8。

## 区块小结

| 候选 | C9 裁决 | 价值级 | 题库建议 | 关键证据 |
|---|---|---|---|---|
| MAT-PEND | 查无占位（主数列）；派生物奇数子序列已占位 | 新序列/新递推（附占位警示） | 入池（须注明 A386889） | 主数列 11 变体 + 偶数子列 6 变体零命中；a(2n−1)=A386889（13 项对齐 + 同构核验）；递推 a(n)=16a(n−2)−25a(n−4)+10a(n−6)−a(n−8) |
| MAT-PRISM | 已占位 | 首个形式化 | 不入池 | A102080 逐位命中（偏移 1）；Hosoya-Motoyama 1985 / Sabzevari-Maimani 2008 / Farrell 1978；派生 A068397/A102079/A287428 |
| MAT-MOBLAD | 已占位 | 首个形式化 | 不入池 | 去首项命中 A020877（偏移 2，退化首项 4 为约定值）；McSorley 1998 Discrete Math；派生 A020878/A302232 |

**统计**：本块 OEIS 查询 **59 条**（2 锚点 + 47 条数列变体 + 9 条关键词；其中零命中 35 条、非空返回 24 条——15 条为真实坐实/锚点命中、9 条为关键词噪声，全部逐条落卡）；zbMATH 16 条（含 4 次单条记录核读）；OpenAlex 3 条（1 条 429 未验证）；arXiv 5 条；MSE 3 条；GitHub 6 条；jsdelivr 单条核读 8 条；网页检索 13 次尝试全部未验证（DDG/Bing/Mojeek/grep.app 通道失效，已如实记录）。**可用查询合计 ≈100 条；坐实撞车：主序列层 2 处（A102080、A020877）+ 派生物层多处（A386889、A068397、A020878、A102079、A302232、A287428、A284703、A284710、A293126、A297476）；主数列查无占位 1 处（MAT-PEND）；未裁决 0 处**（网页层未验证不影响本块任何候选的裁决：PRISM/MOBLAD 有 OEIS+期刊双层坐实，PEND 的 OEIS 数值层经锚点自证可用）。

**给主代理/闸门一的灰区提示**：MAT-PEND 是唯一候选——主数列查无占位、可过池门槛，但其奇数子列已在 OEIS（A386889，2025-09）并与缺口板铺砖同构、连递推 signature 都已发表；「全新序列」的营销式表述不成立，入库命题须限定为「完整递推/偶数子列」并在卡上带 A386889 警示。另注：外部报告对本候选的 6 变体查询复现为零命中属实，但漏检奇偶子序列占位——建议主代理在汇总裁决时把「派生物查新覆盖度」列为外部资料采信红线。

**预算**：llm-call 0/4（未调用 scripts/llm-call.py；本工人推理不计入）。Lean compile 0/0（本批无 C3/C8 义务）。
## appendix: extraction self-check

| range | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
| 1 | 1-6 | 757 | 021d249d55916e93 |
| 2 | 8-13 | 363 | e9476db28c55235e |
| 3 | 17-94 | 10661 | 7a85dbaf96de5f81 |
| 4 | 213-225 | 2448 | 87890cc5c650c501 |

Recompute with: `python claims/pendant-ladder-interleave/audit/build-c9-record.py --check`
