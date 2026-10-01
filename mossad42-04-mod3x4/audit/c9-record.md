# C9 查新全量记录（占位包新颖性证据主体）

> 本文件 = SOP 08b 工序 3《Novelty evidence》要求的「全量查询记录（含零命中）」。
> **装配规则：逐字拷入，禁止改写其结论**（SOP 08b 失败模式表「C9 记录缺失/改写」）。
> 生成方式：`tasks/20260930-mossad42-quad/claims/c9/build_c9_record.py`（机械拼接，零 LLM）；
> 每节头注明源路径，包内记录与源记录可逐字对账。
>
> **裁决摘要（照抄，不改写）**：四轨（pool-mossad42-01/-02/-03/-04）C9 裁决均 = **查无占位**
> （选题批折入 `clean`；本批补充文献通道查询后维持）。价值级 = **新序列（约束口径计数）**。
>
> **诚实边界（必须随包保留）**：
> 1. **OpenAlex 通道本批不可用**（网络层实测不可达，非 DNS 污染）→ 以 Crossref 替代，
>    文献层覆盖率**低于**选题批，属**通道缺项**，不构成「查无占位」的加强证据。
> 2. **零命中 ≠ 新颖**。措辞上限 = 「就本批所查通道，未见以该约束筛选口径为对象的
>    文献或序列记录」；**禁止**升级为「首次给出」「新发现」。
> 3. 四条**不得**主张任何矩/期望类新颖性（Fibonacci Quarterly 2019,
>    doi:10.1080/00150517.2019.12427625 已占位 E[V^a H^b]）。
> 4. -01 与 -03 互为 m 维变体、-02 与 -04 互为 m 维变体，
>    **不得互相充当对方的新颖性证据**。

---

# 第一部分 · 选题批 C9 裁决与候选级折叠（2026-09-28）
> 源文件（逐字拷入）：`tasks/20260928-mossad42-screen/c9-recheck/summary.md`

# c9-recheck/summary.md — mossad-42-screen 收口摘要（2026-09-28）

> 单写者：主代理。本文件 + state-archive.jsonl（357 行状态行全量归档）+ lane-c-literature.md（文献层查询台账）构成本批 C9 证据体。
> state/ 已按任务卡《用完即清》条款删除；删除前全量归档于此。

## 候选级折叠（优先级 kill > occupied > flag > clean > unknown）

| 组 | 候选 |
|---|---|
| kill | E02、E03、E04 |
| occupied | A17、A18、B01、B02、B03、B04、B06、B07、C04、C06、C07、C09、C10、C11、P03、P04、P05、R01、R02、S01、S02、S03、S04 |
| flag | A02、A03、D06、F01、F02、F03、F06、G01、G02、G03、G04、G05、P07 |
| clean | B05、B09、B10 |
| unknown |  |

## 裁决落点

- 入池 4：B04 / B05 / B09 / B10（水平砖约束筛选计数；Part A，均【待用】+ C8 冒烟已过）
- 退项 38：对象层文献占位 10（B1 矩族 6 + B2 违约点族 4）、OEIS 逐位 4（B03/P04/P05/C07）、Burnside 派生 7（A02/A03/G01-G05）、tatami 基础族 2（A17/A18）、数据不付番 3（E02-E04）、分拆邻域/巧合 7（C04/C06/C09/C10/C11/P03/P07）、Apéry 邻域 5（D06/F01/F02/F03/F06）

## 各轴证据指针

| 轴 | 产物 |
|---|---|
| Lane A 数值自证（暴力+DP/枚举双路） | work/W3/lane_a_tilings.result*.json、work/W3/lane_a_part2*.json |
| Lane A 加深（违约点分布扩展重算） | work/W12/viol-deep.json |
| Lane B OEIS（四通道脚本） | work/W4/oeis-*.json、work/W4/adjudication.json、work/W4/divergence.json |
| Lane B 加深（六变体 + 三角形 flat/row 层） | work/W10/triangle.json、work/W10/oeis-deep2.jsonl |
| Lane D 库层+生态层 | work/W6/lib-scan-raw.json、work/W6/keyword-scan.json |
| Lane C 文献层（四通道 + 全文层收口） | work/W11/lit-probe.jsonl、work/W11/lit_decisive.py 摘要、work/W11/lit_1311.py 全文 grep |
| C3/C8/C4 kernel | work/W8/base-B-stats-v4.lean、work/W8/gate-B-stats-v4.txt |

## 折叠规则限制留档（2026-09-28 收口）

- B04 的机械折叠仍读 occupied：早前 W4 原始扫描行（drop1 变体，6 个低熵深偏移巧合）在折叠优先级中压过后续 adjudication 的 flag 行。该原始行已被 work/W4/adjudication.json#B04（low_entropy=true、strong=false 全项）+ work/W10/oeis_ext17.py（17 项长串零命中）双重废止，本批按 clean 处置并入池（附查新力告诫）。
- 规则缺口：append-only 状态文件没有「supersede」语义，折叠优先级无法表达「后证伪前」。后续批次若要保留该协议，需要在折叠规则中引入 adjudication 行的取代权重。

---

# 第二部分 · 选题批文献层查询台账（四通道全量，2026-09-28）
> 源文件（逐字拷入）：`tasks/20260928-mossad42-screen/c9-recheck/lane-c-literature.md`

# c9-recheck/lane-c-literature.md — 文献层四通道查询台账（2026-09-28）

> 通道：arXiv API / OpenAlex API / StackExchange MSE API / zbMATH Open。查询串全量落卡（含零命中）。
> 通道纪律备注：① arXiv 短语查询（带引号/连字符）会退化为返回无关近期论文——本批已将此类结果判为**通道失效、不计证据**，仅采信其简单词项 AND 查询；② OpenAlex search= 为相关性排序，噪声率高，只在其标题与命题共享对象名+性质词时计入；③ MSE 与 zbMATH 为 AND 语义，零读数可信度最高。
> 别名集先行（纪律 4）：tatami tiling / tatami covering / windmill / vortex / bidimer / 4-tile meet / domino tiling / horizontal dominoes / refined enumeration / orbits / symmetry classes / bivariate generating function。
> 四等价口径（纪律 9，按对象性质调整）：原 valuation/zeros/period/divisibility 不适用于统计量对象，改取 ① 矩/期望 ② 分布/精细枚举 ③ 刻画（tatami ⟺ 无风车顶点）④ 曲面变体（torus/cylinder）；删除理由：本批对象为组合统计量而非估值/周期型序列。

| # | 查询串 | arXiv | OpenAlex | MSE | zbMATH |
|---|---|---|---|---|---|
| 1 | all:domino AND all:refined | ZERO(0) | - | - | - |
| 2 | domino tilings refined by number of horizontal dominoes | - | HIT(35) | ZERO(0) | - |
| 3 | domino tilings refined horizontal | - | - | - | ZERO(0) |
| 4 | all:domino AND all:distribution | ZERO(0) | - | - | - |
| 5 | distribution of the number of horizontal dominoes in domino tilings | - | HIT(145) | - | - |
| 6 | distribution number horizontal dominoes tiling | - | - | ZERO(0) | - |
| 7 | horizontal dominoes distribution | - | - | - | ZERO(0) |
| 8 | all:tilings AND all:enumerating | ZERO(0) | - | - | - |
| 9 | enumerating domino tilings by number of horizontal dominoes | - | HIT(201) | - | - |
| 10 | enumerate domino tilings number horizontal dominoes | - | - | ZERO(0) | - |
| 11 | enumerating domino tilings horizontal | - | - | - | ZERO(0) |
| 12 | all:domino AND all:parity | ZERO(0) | - | - | - |
| 13 | parity of the number of horizontal dominoes | - | HIT(202) | - | - |
| 14 | parity number horizontal dominoes tiling | - | - | ZERO(0) | - |
| 15 | parity horizontal dominoes | - | - | - | ZERO(0) |
| 16 | all:domino AND all:triangle | ZERO(0) | - | - | - |
| 17 | triangular array domino tilings horizontal count | - | HIT(101) | - | - |
| 18 | triangle domino tilings horizontal count | - | - | ZERO(0) | - |
| 19 | domino tilings triangle | - | - | - | HIT(9) |
| 20 | all:domino AND all:"transfer matrix" | HIT(25) | - | - | - |
| 21 | transfer matrix statistics domino tilings horizontal vertical count | - | HIT(136) | - | - |
| 22 | transfer matrix domino tilings statistics | - | - | ZERO(0) | - |
| 23 | transfer matrix domino tilings | - | - | - | HIT(2) |

## 决定性命中（全文层收口，纪律 8）

1. **arXiv:1311.6135**《Paving Rectangular Regions with Rectangular Tiles: Tatami and Non-Tatami Tilings》——全文 grep 实证 Definition 2 与 Tables 1-59：T_t(n,m) = 恰含 t 个 4 砖交点的铺法数，宽 m ≤ 9、1×2 多米诺。⇒ S03/S04 的 w 分布与 T_t(n,m) 同对象；R01/R02 为同统计量的环面变体（该文 torus 出现 0 次）。
2. **Fibonacci Quarterly 2019, doi:10.1080/00150517.2019.12427625**《Statistics of Domino Tilings on a Rectangular Board》——摘要实证对一般 m×n 板计算混合矩 E[V^a H^b]。⇒ B01/B02/B06/B07/S01/S02 为 T(m,n)·E[H^k] 一行导出。
3. **EJC 2009 doi:10.37236/215**《Counting Fixed-Height Tatami Tilings》与 **EJC 2011 doi:10.37236/596**《Monomer-Dimer Tatami Tilings of Rectangular Regions》——摘要实证只计 tatami（零违约点）覆盖，不覆盖违约点矩；确认 B2 族占位来自 1311.6135 而非这两篇。
4. **arXiv:1304.0070** 全文 grep：bidimers and vortices 为违约点结构在文献中的命名（vortex 出现 1 次、windmill 0 次、violation 0 次）——别名集据此补全。

---

# 第三部分 · 题库条目 C9 裁决与证据指针（Part A 四条）
> 源文件（逐字拷入）：`harness/selection-map/pools/mossad-42.md`

# pools/mossad-42.md — 外部调研资料《摩萨德-42题》复合筛选 + 深度复审落库（2026-09-28）

> 来源：外部流水线（ZCode「摩萨德技能包」）《摩萨德 · 42 个高难度选题的三层核验报告（加难版第二轮）》，AI4Math 选题院按 SOP 01 C1–C9 独立重裁（题源自述一律降级为线索）。
> 上游存档：preselect/mossad-42-pending.md（42 候选逐条存档）+ preselect/src/mossad-hard50-round2.pdf（sha256 2f80d894…，与交付件逐位一致）。
> 任务目录 tasks/20260928-mossad42-screen/（card.md / state/screen-state.jsonl 357 行状态行 / work/W3–W12 证据 / budget.log）。
> 预算：llm-call 0/0（R-04：本批无判断类 LLM 调用，检索与重算全部脚本执行体）；compile 5/12（轨1 C3 #check 0、轨2 C8 冒烟 5，含 2 次 kernel 诊断驱动的返工）；采样 0/16（headless 两波超时后机械轴改主代理 authored 脚本）。节点 stepfun/step-5-preview（用户 2026-09-28 显式指定，卡面 O-1 留档）。
> 单写者纪律：主代理合入。状态戳沿用 README：待用 / 已入批 / 已证 / 已退。
> 范围：42 候选 = 入池 4（Part A）+ 退项 38（Part B，全部【已退】，禁止复活——复活须用户裁决）。

---

## Part A · 入池条目（4 条；全部【待用】+ C8 冒烟已过）

> 共同口径 = 铺砖族「换统计口径」例外：pools/README《禁区速查》载明铺砖族基础族 21/21 已占位、该族不再送检，除非换统计口径/约束条件。本批四条即统计口径型——对象不是铺法总数，而是对水平多米洛计数施加约束后筛选出的铺法数（OEIS 与文献四通道均无同形对象）。
> 共同前置（C3）：mathlib Combinatorics/SimpleGraph/Matching.lean 仅有 IsMatching/IsPerfectMatching 谓词、无任何铺砖计数/网格图设施；compfiles 无同形；sequencelib 无对应条目——形式化侧须自建 Cells/RectAdj/Tilings/hCount/countBy 五件（冒烟基座即此五件）。
> 冒烟（C8）：work/W8/base-B-stats-v4.lean + work/W8/gate-B-stats-v4.txt → WELLDEF OK；6 个退化裸探针（norm_num / simp / ring / omega / decide / positivity）全部 FAIL（C4 通过：非单 tactic 可秒杀）；10 条预检引理 #check 全部 OK（C3 通过：Matrix.det_fin_two、Matrix.trace_fin_two、Matrix.det_diagonal、Finset.card_biUnion、Finset.sum_congr、Finset.sum_filter、Finset.filter_filter、Finset.prod_filter、Finset.sum_attach、Matrix.mulVec）。
> 冒烟基座命题：一条定理并列 9 个锚点值（B04 1 个 + B09 4 个 + B05 2 个 + B10 2 个），sorry 占位——冒烟只裁良定义与路线设施，不裁命题真值；真值由 work/W10/triangle.json 的 DP 双路 + work/W3 暴力枚举双路独立重算坐实。
> 共同的库补全边界（入库必读）：本族水平砖矩族（Σh·c(h)、Σh²·c(h)、Σh³·c(h) 等）已被文献占位——《Statistics of Domino Tilings on a Rectangular Board》（Fibonacci Quarterly 2019, DOI 10.1080/00150517.2019.12427625）对一般 m×n 板计算混合矩 E[V^a H^b]。故本四条不得用于主张任何「矩/期望」类新颖性；新颖性只限于「约束筛选计数」这一口径本身。

### pool-mossad42-01 · M-B04 3×n 铺砖「水平砖恰占一半」铺法数 【待用】

- NL：设 c(n, h) = 3×n 矩形多米洛铺砖中水平多米洛数恰为 h 的铺法数。a(n) = c(n, mn/4)（mn ≡ 0 mod 4 时；否则为 0）。命题：给出 a(n) 的递推/闭式。
- 送检数列（已独立重算核验，DP 转移矩阵路 work/W10/triangle.json + 暴力枚举路 work/W3/lane_a_tilings.py 双路一致；题源同）：1,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,5824,0,0（n = 0…18；非零项 n=8→56、n=16→5824）。
- C9 裁决：查无占位（附查新力告诫）——OEIS：identity / even-idx / odd-idx / partial-sums / first-diff 五变体零命中（nonzero-subcol 因非零项仅 2 个不构成有效查询，如实记）；文献四通道：zbMATH『domino tilings half horizontal』『horizontal dominoes distribution』『domino tilings refined horizontal』、arXiv『domino AND half』、MSE 全零直接命中，OpenAlex 仅相关性噪声（ASM/Aztec 等，无一共享对象名+性质词）；库层：mathlib/compfiles/5 个外部仓 7 快照数字串零命中。
- 告诫：本串非零项极稀（两项），OEIS 数值查新的统计力显著弱于其余三条——捞取入批前必须补算 n=20/22/24 三项并重跑五变体，否则不得以「查无占位」作强主张。
- 价值级：新序列（约束口径计数）。
- 入库条件：①主口径用「恰半」（h = mn/4），勿泛写「水平/垂直均衡」；②n 为奇数时 4∤mn，项为 0，卡面须写明该约定；③与 pool-mossad42-03（4×n 同口径）互为 m 维变体，不得互相充当对方的新颖性证据。
- 证据：work/W10/triangle.json（m3.h_exact_half）、work/W10/oeis-deep2.jsonl（B04 行）、work/W11/lit-probe.jsonl（queries3/4）、work/W6/keyword-scan.json、work/W8/gate-B-stats-v4.txt。

### pool-mossad42-02 · M-B05 3×n 铺砖「水平砖数 ≡ 0 (mod 3)」铺法数 【待用】

- NL：设 c(n, h) 同上。a(n) = Σ_{h ≡ 0 (mod 3)} c(n, h)。命题：给出 a(n) 的递推/闭式（预期路线：水平计数双变量母函数的单位根滤波）。
- 送检数列（双路一致）：1,0,1,0,1,0,9,0,57,0,225,0,737,0,2513,0,9521,0,37025（n = 0…18）。
- C9 裁决：查无占位——OEIS：identity / nonzero-subcol / even-idx / odd-idx / partial-sums / first-diff 六变体零命中；文献四通道：zbMATH『domino tilings horizontal count modulo』『parity horizontal dominoes』『bivariate generating function domino』、arXiv『domino AND modulo』、MSE『domino tiling horizontal dominoes divisible by 3』全零直接命中；OpenAlex 命中经核读均无关（2-adic 整除性论文 EJC 1997 论总数 2^n(2k+1)^2 形，非本对象）；库层零命中。
- 价值级：新序列（约束口径计数；单位根滤波型）。
- 入库条件：①命题须写明「按水平多米洛计数取模」，禁止缩写成「铺法数 mod 3」（那是总数的同余，另一对象）；②证明路线若走单位根滤波，须先形式化双变量母函数或转移矩阵——C3 预检清单已含 Matrix.det_fin_two / Finset.sum_filter 等可用件；③与 pool-mossad42-04（4×n 同口径）互为 m 维变体。
- 证据：work/W10/triangle.json（m3.h_mod3_0）、work/W10/oeis-deep2.jsonl（B05 行）、work/W11/lit-probe.jsonl + work/W11/lit_div.py（整除性论文摘要核读）、work/W8/gate-B-stats-v4.txt。

### pool-mossad42-03 · M-B09 4×n 铺砖「水平砖恰占一半」铺法数 【待用】

- NL：设 c(n, h) = 4×n 矩形多米洛铺砖中水平多米洛数恰为 h 的铺法数。a(n) = c(n, n)（4×n 板 mn = 4n，半数即 n）。命题：给出 a(n) 的递推/闭式。
- 送检数列（双路一致）：1,0,3,0,16,0,108,0,762,0,5493,0,40285,0,299253,0,2244206（n = 0…16）。
- C9 裁决：查无占位——OEIS 六变体零命中；文献四通道同 pool-mossad42-01 口径，零直接命中（OpenAlex『domino tilings equal number horizontal vertical』318 条经标题核读无一为本对象）；库层零命中。
- 价值级：新序列。
- 入库条件：①主口径用「水平砖恰占总砖数一半」，4×n 时即 h = n，卡面须写明该等式来源；②非零项仅偶 n，奇 n 项为 0（面积不满足 4∣mn）；③与 pool-mossad42-01 互为 m 维变体，与 pool-mossad42-02/04 的取模口径不得混用。
- 证据：work/W10/triangle.json（m4.h_exact_half）、work/W10/oeis-deep2.jsonl（B09 行）、work/W11/lit-probe.jsonl（queries3/4）、work/W8/gate-B-stats-v4.txt。

### pool-mossad42-04 · M-B10 4×n 铺砖「水平砖数 ≡ 0 (mod 3)」铺法数 【待用】

- NL：设 c(n, h) = 4×n 矩形多米洛铺砖中水平多米洛数恰为 h 的铺法数。a(n) = Σ_{h ≡ 0 (mod 3)} c(n, h)。命题：给出 a(n) 的递推/闭式。
- 送检数列（双路一致）：1,1,1,1,10,37,110,269,701,2000,6020,17495,49206,137226,388116,1108721,3166325（n = 0…16）。
- C9 裁决：查无占位——OEIS 六变体零命中；文献四通道零直接命中（同 pool-mossad42-02 口径）；库层零命中。
- 价值级：新序列。
- 入库条件：同 pool-mossad42-02（①模口径写全 ②单位根滤波路线 ③与 -02 互为 m 维变体）；另注：本串无交替零项（4×n 奇 n 亦有铺法），与 3×n 口径的稀疏形态不同，卡面勿套用 3×n 的下标约定。
- 证据：work/W10/triangle.json（m4.h_mod3_0）、work/W10/oeis-deep2.jsonl（B10 行）、work/W11/lit-probe.jsonl、work/W8/gate-B-stats-v4.txt。

---

## Part B · 已占位 / 已证伪退项记录（38 条；全部【已退】）

> 裁决口径：C9 四态 + 价值主张分级表；OEIS 逐位对齐或文献挂名即「已占位」；派生命题（Burnside 轨道、矩、统计变换）不因主命题未占位而自动获得新颖性。
> 本批新增两条对象层占位判例（2026-09-28 深度复审实证，捞取任何铺砖统计候选前必读）：
> 1. 违约点（4 砖交点 / windmill / vortex）统计族：arXiv:1311.6135《Paving Rectangular Regions with Rectangular Tiles: Tatami and Non-Tatami Tilings》Definition 2 明文「T_t(n,m) denotes the number of tilings which contain t points where 4 tiles meet」，并制表 Tables 1–59（宽 m ≤ 9、1×2 多米诺、n 沿行增）。凡「按违约点数精细枚举/矩」一律视为已占位。
> 2. 水平-垂直多米洛混合矩族：《Statistics of Domino Tilings on a Rectangular Board》（Fibonacci Quarterly 2019, DOI 10.1080/00150517.2019.12427625）对一般 m×n 板计算 E[V^a H^b]。凡「Σh^k·c(h)」一律视为已占位（= T(m,n)·E[H^k] 一行导出，T(m,n) 本身已挂名 A001835/A005178）。
> 检索证据（查询串全量落卡）：work/W4/（OEIS 四通道脚本产物）、work/W10/oeis-deep2.jsonl（加深：六变体 + 三角形 flat/row 层）、work/W11/lit-probe.jsonl（文献四通道 arXiv/OpenAlex/MSE/zbMATH + 别名集 + 全文层收口）、work/W12/viol-deep.json（违约点分布扩展重算）。

### B1. 水平砖矩族（6 条，文献占位）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 1 | M-B01 | 3×n 水平砖一阶矩 Σh·c(h) | Fibonacci Quarterly 2019 E[V^a H^b]；T(3×n)=A001835 | ≤首个形式化 |
| 2 | M-B02 | 3×n 水平砖二阶矩 Σh²·c(h) | 同上 | ≤首个形式化 |
| 3 | M-B06 | 4×n 水平砖一阶矩 | 同上；T(4×n)=A005178 | ≤首个形式化 |
| 4 | M-B07 | 4×n 水平砖二阶矩 | 同上 | ≤首个形式化 |
| 5 | M-S01 | 3×n 水平砖三阶矩 | 同上 | ≤首个形式化 |
| 6 | M-S02 | 4×n 水平砖三阶矩 | 同上 | ≤首个形式化 |

### B2. 违约点（tatami 风车点）统计族（4 条，文献占位）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 7 | M-S03 | 3×n 违约点总数 Σw | arXiv:1311.6135 Def.2 + Tables 1–59（T_t(n,m)） | ≤首个形式化 |
| 8 | M-S04 | 4×n 违约点总数 Σw | 同上 | ≤首个形式化 |
| 9 | M-R01 | 3×(2k) 环面违约点总数 Σw | 统计口径已挂名（矩形侧）；环面变体 zbMATH 零命中 → 派生变体 | ≤首个形式化 |
| 10 | M-R02 | 3×(2k) 环面违约点平方和 Σw² | 同上 | ≤首个形式化 |

### B3. 带号和 / 移位同索引（4 条）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 11 | M-B03 | 3×n 水平砖带号和 Σ(-1)^h·c(h) | 本机独立复现：Σ(-1)^h = 0（n 奇）/ (-1)^{n/2}·T(3×n)（n 偶）→ 偶子列逐位对齐 A001835/A079935，题源 known 判定获证实 | 已知 |
| 12 | M-P04 | 互异分拆差 ≥ i+2 | OEIS A023797 移位 24/24 逐位 | ≤首个形式化 |
| 13 | M-P05 | 差≥2 分拆部分数一阶矩 | OEIS A268188 移位 24/24 逐位 | ≤首个形式化 |
| 14 | M-C07 | 差≥3 + 最小部分≥2 分拆 | OEIS A023797 同索引 24/24 逐位 | ≤首个形式化 |

### B4. 铺砖轨道数（D2 / Z_n）族（7 条，Burnside 派生）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 15 | M-A02 | 4×n D2 轨道数 | 基础族 A005178 占位 + Burnside 派生；另邻 L02 轨道先例 | 派生 |
| 16 | M-A03 | 5×n D2 轨道数 | 同上 | 派生 |
| 17 | M-G01 | 3×n 圆柱 Z_n 轨道数 | 基础族 A102091 占位（Narumi-Hosoya-Murakami 1991 等）+ Burnside 派生 | 派生 |
| 18 | M-G02 | 4×n 圆柱 Z_n 轨道数 | 基础族 A252054 占位 | 派生 |
| 19 | M-G03 | 2×n 环面 Z_n 轨道数 | 基础族 A068397 占位（Belcastro 2023） | 派生 |
| 20 | M-G04 | 3×n 环面 Z_n 轨道数 | 基础族 A231087 占位 | 派生 |
| 21 | M-G05 | 4×n 环面 Z_n 轨道数 | 基础族 A220864 占位（Butler-Osborne 2012） | 派生 |

> 注：G01–G05 另含题源数据缺陷——n=2 项题源值超出该口径铺法总数上界（内部不可能），本机修正值分别为 3 / 5 / 2 / 4 / 8（work/W3/lane_a_tilings.result.extra3.json）。

### B5. tatami 基础族与轨道（5 条）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 22 | M-A17 | 4×n tatami 铺砖数 | OEIS A068923 逐位 11/11（Mathar 挂名） | ≤首个形式化 |
| 23 | M-A18 | 5×n tatami 铺砖数 | 族先验占位（A180970/A272472 邻域） | ≤首个形式化 |
| 24 | M-E02 | 3×n tatami D2 轨道数 | 题源数据不付番（多口径不可复现 + 轨道数>总数上界） | 数据错 |
| 25 | M-E03 | 4×n tatami D2 轨道数 | 同上 | 数据错 |
| 26 | M-E04 | 5×n tatami D2 轨道数 | 同上 | 数据错 |

> E02–E04 补证：含单体（monomer-dimer）假设被奇数项零值否证；修正判据（单体格计入顶点交汇）后 3×n 计数与 OEIS A180970 逐位一致（1,3,13,22,44,90,196,406,852）——枚举器因此获外部验证，但题源送检串本身不可复现。

### B6. 限制分拆族（7 条，邻域占位 / 短窗巧合）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 27 | M-C04 | 差≥3 + 模3触发分拆 | A029111 15 项后分叉（独立复现，与题源自述一致）→ 巧合排除；邻域 RR 经典装置 | 巧合 |
| 28 | M-C06 | 差≥4 + 模4触发分拆 | parts≥k 家族 4 序列 12 项前缀后分叉；题源 B 级 | 巧合 |
| 29 | M-C09 | 差≥3+模3触发+禁3倍数 | A037810 低熵短窗巧合（distinct=3） | 巧合 |
| 30 | M-C10 | 差≥4+模4触发+全偶 | A355741 低熵短窗巧合 | 巧合 |
| 31 | M-C11 | 差≥2+模5触发（较大部分） | A108932 parts≡1,5,6 mod 8 10–12 项前缀后分叉 | 巧合 |
| 32 | M-P03 | 超互异分拆（差 ≥ i+1） | A003106 18 项前缀后分叉、A038736 13 项分叉 | 巧合 |
| 33 | M-P07 | 双色部分差≥3 加权 Σc^k | 约束修正后 OEIS 零命中，但 RR 邻域 + 2-color weighted partitions 邻域占位 | 邻域派生 |

### B7. 二项式与 Hankel 加权矩族（5 条，Apéry-like 邻域占位）

| # | 候选 | 题名 | 坐实证据 | 价值级 |
|---|---|---|---|---|
| 34 | M-D06 | 加权 B1 二阶矩 Σk²·C(n,k)²·C(2k,k) | Part B4 邻域占位（A002893/A081085/A005258/A201805/A046980）+ Zhu&Sun 2018 | ≤首个形式化 |
| 35 | M-F01 | 加权 B1 三阶矩 | 同上 | ≤首个形式化 |
| 36 | M-F02 | 加权 B1 四阶矩 | 同上 | ≤首个形式化 |
| 37 | M-F03 | 加权 B1 五阶矩 | 同上 | ≤首个形式化 |
| 38 | M-F06 | Apéry 型 B3 一阶加权 | B3=A005258 邻域 + Part B4 占位 | ≤首个形式化 |

> 说明：D06/F01/F02/F03/F06 的 OEIS 数据层为零命中（work/W4/oeis-*.json），退项依据是族先验 + 文献邻域占位（Apéry-like 加权矩为高频发表对象），非数据层命中；若日后要复活任一条，须先补 Zeilberger 式自动恒等式查新并交用户裁决。

---

## 附：本批对题源的质量告警（后续引用外部资料时参考）

1. 3/42 送检数列数据不付番（E02/E03/E04）：多口径不可复现 + 轨道数超总数上界。
2. 5/42 题源判 new 被 OEIS 证伪（A17≡A068923、C07≡A023797、P04≡A023797 移位、P05≡A268188、B03 已知）。
3. 1/42 题源零命中被证伪（A17）。
4. 5/42 n=2 项为不可能值（G01–G05，已给修正值）。
5. 4/42 题源未列送检数列（B03/C04/C06/C10），本机重算建立。
6. 题源附录 A 锚点串有笔误（1,3,11,41,153,571,213 实为 …2131）。
7. 题源「三层零命中」声明普遍不成立：本批深度复审实证，题源标三层零命中的违约点族与矩族在文献层均有挂名（见 Part B 两条新增判例）。

---

# 第四部分 · 本批文献通道补查台账（2026-09-30，四通道）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/claims/c9/lit-probe.md`

# 四轨文献通道补查台账（2026-09-30）

> 通道：arXiv API / Crossref / MSE / zbMATH Open。查询串全量落卡（含零命中）。
> **OpenAlex 通道不可用（实测留痕）**：api.openalex.org 经 Cloudflare 前置，
> 两个 IPv4（104.20.26.229 / 172.66.159.136）自本机 curl http=000 连接超时、
> IPv6 立即失败；DNS 解析正确（已用 223.5.5.5 核对，非 DNS 污染）。
> 替代通道 = Crossref（同为 DOI 级书目索引，正对照实测可达 http=200）。
> 纪律：arXiv 仅采简单词项 AND（短语查询判通道失效）；
> Crossref/OpenAlex 相关性排序需标题共享对象名+性质词方计入；MSE/zbMATH 为 AND 语义。

## 一、正对照（通道可用性）

| 口径 | 通道 | 查询串 | 结果 | 证据态 |
|---|---|---|---|---|
| control-moments-FQ2019 | crossref | `Statistics of Domino Tilings on a Rectangular Board` | 命中 25 | **直接相关 8 条（需人工核读）** |
| control-tatami | arxiv | `tatami AND tilings` | 命中 7 | 命中 7（需人工核读） |
| control-total-3xn | zbmath | `domino tilings rectangular board` | 命中 3 | 命中 3（需人工核读） |
| control-mse-domino | mse | `domino tilings number of ways` | 命中 23 | 命中 23（需人工核读） |

## 二、四轨口径查询

| 口径 | 通道 | 查询串 | 结果 | 证据态 |
|---|---|---|---|---|
| 05-constraint | arxiv | `domino AND tiling AND horizontal AND divisible` | **零命中** | 零命中 |
| 05-constraint | mse | `domino tilings number of horizontal dominoes divisible by 3` | **零命中** | 零命中 |
| 05-constraint | zbmath | `domino tilings horizontal divisible` | **零命中** | 零命中 |
| 05-constraint | crossref | `domino tilings number horizontal dominoes mod 3` | 命中 25 | **直接相关 6 条（需人工核读）** |
| 05-constraint | arxiv | `domino AND tiling AND horizontal AND half` | **零命中** | 零命中 |
| 05-constraint | mse | `domino tilings exactly half horizontal dominoes` | **零命中** | 零命中 |
| 05-constraint | zbmath | `domino tilings half horizontal` | 命中 2 | 命中 2（需人工核读） |
| 05-constraint | crossref | `domino tilings equal number horizontal vertical` | 命中 25 | **直接相关 6 条（需人工核读）** |
| 02-distribution | arxiv | `domino AND tilings AND refined` | 命中 8 | 命中 8（需人工核读） |
| 02-distribution | zbmath | `domino tilings refined horizontal` | **零命中** | 零命中 |
| 02-distribution | crossref | `domino tilings refined by number of horizontal dominoes` | 命中 25 | **直接相关 6 条（需人工核读）** |
| 02-distribution | mse | `distribution number horizontal dominoes tiling` | **零命中** | 零命中 |
| 01-moments | arxiv | `domino AND tilings AND statistics` | 命中 25 | 命中 25（需人工核读） |
| 01-moments | zbmath | `statistics domino tilings rectangular board` | 命中 1 | 命中 1（需人工核读） |
| 01-moments | crossref | `statistics of domino tilings on a rectangular board` | 命中 25 | **直接相关 8 条（需人工核读）** |
| 01-moments | mse | `expected number horizontal dominoes tiling` | **零命中** | 零命中 |
| 03-characterization | arxiv | `domino AND tilings AND parity` | 命中 4 | 命中 4（需人工核读） |
| 03-characterization | zbmath | `parity number horizontal dominoes` | **零命中** | 零命中 |
| 03-characterization | crossref | `parity of the number of horizontal dominoes` | 命中 25 | 噪声（无直接相关标题，不计占位） |
| 03-characterization | mse | `parity number of horizontal dominoes domino tiling` | **零命中** | 零命中 |
| 04-surfaces | arxiv | `domino AND tilings AND cylinder` | 命中 11 | 命中 11（需人工核读） |
| 04-surfaces | zbmath | `domino tilings torus cylinder` | 命中 2 | 命中 2（需人工核读） |
| 04-surfaces | crossref | `domino tilings cylindrical region` | 命中 25 | **直接相关 6 条（需人工核读）** |
| 04-surfaces | mse | `domino tilings cylinder circumference` | **零命中** | 零命中 |
| 06-closed-form-T1 | arxiv | `binomial AND coefficient AND tiling AND closed` | **零命中** | 零命中 |
| 06-closed-form-T1 | zbmath | `central binomial coefficient combinatorial identity tiling` | **零命中** | 零命中 |
| 06-closed-form-T1 | crossref | `closed form domino tiling counting sequence` | 命中 25 | **直接相关 1 条（需人工核读）** |
| 06-closed-form-T1 | mse | `closed form domino tilings 3xn half horizontal` | **零命中** | 零命中 |
| 05-constraint | zbmath | `domino tilings finite state transfer matrix parity` | **零命中** | 零命中 |
| 05-constraint | mse | `3xn domino tilings horizontal dominoes half` | **零命中** | 零命中 |
| 99-channel-down-record | openalex | `domino tilings horizontal statistics` | 通道错误：CHANNEL-DOWN http=curl rc=28: curl: (28) Connection timed out after 20000 milliseconds (Cloudflare IP unreachable) | 无效（通道错误） |

## 三、Crossref 直接相关条目（逐条核读用）

> 纪律 ②：Crossref 相关性排序满页返回，**只有标题共享对象名+性质词才计入**。
> 下列为命中的直接相关条目；空 = 该查询无直接相关条目。

- **05-constraint** `domino tilings number horizontal dominoes mod 3` → 直接相关 6 / 返回 25
    - On 2-adic behavior of the number of domino tilings on torus — 10.55016/ojs/cdm.v14i1.62673
    - Horizontal runs in domino tilings — 10.13069/jacodesmath.09554
    - DOMINO TILINGS OF THE TORUS — 10.17771/pucrio.acad.26336
    - DOMINO TILINGS OF 3-DIMENSIONAL CYLINDERS — 10.17771/pucrio.acad.70231
    - DOMINO TILINGS OF 3D CYLINDERS AND REGULARITY OF DISKS — 10.17771/pucrio.acad.53188
    - Domino tilings of cylinders: the domino group and connected components under flips — 10.1512/iumj.2022.71.8880
- **05-constraint** `domino tilings equal number horizontal vertical` → 直接相关 6 / 返回 25
    - On 2-adic behavior of the number of domino tilings on torus — 10.55016/ojs/cdm.v14i1.62673
    - Horizontal runs in domino tilings — 10.13069/jacodesmath.09554
    - DOMINO TILINGS OF THE TORUS — 10.17771/pucrio.acad.26336
    - DOMINO TILINGS OF 3-DIMENSIONAL CYLINDERS — 10.17771/pucrio.acad.70231
    - DOMINO TILINGS OF 3D CYLINDERS AND REGULARITY OF DISKS — 10.17771/pucrio.acad.53188
    - Domino tilings of cylinders: the domino group and connected components under flips — 10.1512/iumj.2022.71.8880
- **02-distribution** `domino tilings refined by number of horizontal dominoes` → 直接相关 6 / 返回 25
    - On 2-adic behavior of the number of domino tilings on torus — 10.55016/ojs/cdm.v14i1.62673
    - Horizontal runs in domino tilings — 10.13069/jacodesmath.09554
    - DOMINO TILINGS OF THE TORUS — 10.17771/pucrio.acad.26336
    - DOMINO TILINGS OF 3-DIMENSIONAL CYLINDERS — 10.17771/pucrio.acad.70231
    - DOMINO TILINGS OF 3D CYLINDERS AND REGULARITY OF DISKS — 10.17771/pucrio.acad.53188
    - Domino tilings of cylinders: the domino group and connected components under flips — 10.1512/iumj.2022.71.8880
- **01-moments** `statistics of domino tilings on a rectangular board` → 直接相关 8 / 返回 25
    - Statistics of Domino Tilings on a Rectangular Board — 10.1080/00150517.2019.12427625
    - Asymptotics of random domino tilings of rectangular Aztec diamonds — 10.1214/17-aihp838
    - Local statistics for random domino tilings of the Aztec diamond — 10.1215/s0012-7094-96-08506-3
    - DOMINO TILINGS OF THE TORUS — 10.17771/pucrio.acad.26336
    - DOMINO TILINGS OF 3-DIMENSIONAL CYLINDERS — 10.17771/pucrio.acad.70231
    - An algorithm for counting domino tilings  of a rectangular chessboard — 10.13069/jacodesmath.v13i1.335
    - DOMINO TILINGS OF 3D CYLINDERS AND REGULARITY OF DISKS — 10.17771/pucrio.acad.53188
    - Domino tilings of cylinders: the domino group and connected components under flips — 10.1512/iumj.2022.71.8880
- **03-characterization** `parity of the number of horizontal dominoes` → 直接相关 0 / 返回 25
- **04-surfaces** `domino tilings cylindrical region` → 直接相关 6 / 返回 25
    - DOMINO TILINGS OF THE TORUS — 10.17771/pucrio.acad.26336
    - DOMINO TILINGS OF 3-DIMENSIONAL CYLINDERS — 10.17771/pucrio.acad.70231
    - DOMINO TILINGS OF 3D CYLINDERS AND REGULARITY OF DISKS — 10.17771/pucrio.acad.53188
    - Domino tilings of cylinders: the domino group and connected components under flips — 10.1512/iumj.2022.71.8880
    - On 2-adic behavior of the number of domino tilings on torus — 10.55016/ojs/cdm.v14i1.62673
    - Enumeration of Hybrid Domino-Lozenge Tilings II: Quasi-Octagonal Regions — 10.37236/4669
- **06-closed-form-T1** `closed form domino tiling counting sequence` → 直接相关 1 / 返回 25
    - Domino Tiling Congruence Modulo 4 — 10.1007/s00373-009-0865-5

---

# 第五部分 · 本批文献通道补查结论（消解 Phase 0 未验证项）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/claims/c9/c9-literature-verdict.md`

# C9 文献通道补查结论（2026-09-30）——消解 Phase 0「arXiv 超时未验证」项

> 用途：本文件是 `claims/<slug>/zenodo/audit/c9-record.md` 的**文献层主体**（占位通道工序 3
> 《Novelty evidence》要求「全量查询记录（含零命中）」，SOP 08b）。
> 上游素材：`tasks/20260928-mossad42-screen/c9-recheck/`（选题批 C9）+ 本目录 `lit-probe.*`（本批补查）。
> 生成方式：`lit_probe_quad.py` 脚本执行体，零 LLM；查询串与回包摘要逐条落 `lit-probe.jsonl`。

## 〇、结论

**四条轨道（-01/-02/-03/-04）在本次文献四通道补查下均无直接命中占位；Phase 0 挂账的
「T1 闭式是否已有文献给出」一项，本次**已获证据**，结论 = 未查到给出该闭式的文献。**

**同时如实记录两条边界（不得省略）：**

1. **OpenAlex 通道在本机不可用**（网络层实测不可达，非 DNS 污染）→ 本批以 **Crossref** 替代。
   这使文献层覆盖率**低于**选题批（选题批四通道齐全），属**通道缺项**，不是「查无占位」的加强证据。
2. **Crossref 为相关性排序、满页返回**，裸命中数**不构成占位证据**；本批只采信
   「标题共享对象名 + 性质词」的直接相关条目，已逐条人工核读（见 §三）。

## 一、通道可用性（先证通道能命中，再读零命中）

| 正对照 | 通道 | 结果 | 判定 |
|---|---|---|---|
| `Statistics of Domino Tilings on a Rectangular Board` | crossref | 命中 25，直接相关 8 | 通道可用 ✔ |
| `tatami AND tilings` | arxiv | 命中 7（含 1311.6135） | 通道可用 ✔ |
| `domino tilings rectangular board` | zbmath | 命中 3 | 通道可用 ✔ |
| `domino tilings number of ways` | mse | 命中 23 | 通道可用 ✔ |
| `domino tilings horizontal statistics` | openalex | **curl http=000 / 连接超时** | **通道不可用 ✘** |

OpenAlex 不可达取证：`api.openalex.org` 经 Cloudflare 前置，DNS 正确解析到
`104.20.26.229` / `172.66.159.136`（已按 AGENTS.md 用 `223.5.5.5` 核对，**排除 DNS 污染**），
但 curl 直连与 `--resolve` 直连**全部超时**（http=000，20–30s）；IPv6 两个地址立即失败。
同时刻 `api.crossref.org` http=200 ⇒ 非全局限网故障，系该域名自本机不可达。

## 二、四通道零命中记录（本批新颖性口径 = 约束筛选计数）

| 口径 | 查询串 | arXiv | MSE | zbMATH |
|---|---|---|---|---|
| 约束计数（mod 3） | `domino tiling horizontal divisible` / `…divisible by 3` / `…horizontal divisible` | **0** | **0** | **0** |
| 约束计数（恰半） | `domino tiling horizontal half` / `…exactly half horizontal dominoes` | **0** | **0** | 2（核读：见 §三） |
| 分布/精细枚举 | `domino tilings refined` / `…refined horizontal` | 8（核读：无关） | **0** | **0** |
| 刻画（奇偶） | `domino tilings parity` / `parity number horizontal dominoes` | 4（核读：无关） | **0** | **0** |
| 曲面变体 | `domino tilings cylinder` / `…torus cylinder` | 11（核读：无关） | **0** | 2（核读：无关） |
| **闭式（T1 专属）** | `binomial coefficient tiling closed` / `central binomial coefficient combinatorial identity tiling` | **0** | **0** | **0** |
| DP/状态递推 | `domino tilings finite state transfer matrix parity` / `3xn …half` | — | **0** | **0** |

> 说明：MSE 与 zbMATH 为 AND 语义，零读数可信度最高（沿用 lane-c 纪律 ③）。
> zbMATH 的「零命中」在 API 层表现为 **http=404 + `"internal_code":"successful access.
> No results found."`** —— 本批首版脚本误判为通道故障（会把真实零命中抹掉），已修正。

## 三、直接相关条目逐条核读（决定性命中）

Crossref 报直接相关的条目全部核读，**无一与四轨命题同对象**：

| 条目 | DOI | 对象 | 与四轨的关系 |
|---|---|---|---|
| Horizontal runs in domino tilings（2014） | 10.13069/jacodesmath.09554 | **n×2** 网格上「最长水平连续段」的母函数与渐近 | 对象为 n×2（非 3×n/4×n），统计量为「最长段」非「计数取模/恰半」⇒ **不同对象** |
| Domino Tiling Congruence Modulo 4（2009） | 10.1007/s00373-009-0865-5 | 铺法**总数** mod 4 的同余 | 对象是总数同余，非「按水平砖计数筛选」⇒ **不同对象** |
| On 2-adic behavior of the number of domino tilings on torus（2019） | 10.55016/ojs/cdm.v14i1.62673 | **环面** 2-adic 行为 | 曲面变体且为总数 2-adic ⇒ **不同对象** |
| DOMINO TILINGS OF THE TORUS / 3-DIMENSIONAL CYLINDERS 系列 | 10.17771/pucrio.acad.26336 等 | 环面/柱面铺法**总数**与 flip 连通性 | 曲面变体、总数为对象 ⇒ **不同对象** |
| Statistics of Domino Tilings on a Rectangular Board（2019） | 10.1080/00150517.2019.12427625 | 一般 m×n 板 E[V^a H^b] **混合矩** | 题库已判：**矩族占位**（本批四条不得主张矩类新颖性，并不冲突） |
| An algorithm for counting domino tilings of a rectangular chessboard | 10.13069/jacodesmath.v13i1.335 | 矩形铺法**计数算法** | 总数为对象 ⇒ **不同对象** |
| Asymptotics / Local statistics for random domino tilings of Aztec diamond 等 | 10.1214/17-aihp838 等 | Aztec diamond 随机铺法的局部统计与极限形状 | 概率极限形状，非小参数计数 ⇒ **不同对象** |
| Enumeration of Hybrid Domino-Lozenge Tilings II | 10.37236/4669 | 混合 domino-lozenge 区域枚举 | 不同族 ⇒ **不同对象** |

zbMATH 命中 2 条（`domino tilings half horizontal`、`domino tilings torus cylinder`）经核读
同为曲面变体/总数对象，**无一以「恰半」或「按水平砖计数取模」为对象**。

**arXiv 各口径命中经逐条标题核读**（`domino AND tilings AND refined` 8 条、`…statistics` 25 条、
`…parity` 4 条、`…cylinder` 11 条）：全部落在 Aztec diamond 局部统计 / 二十顶点模型 /
柱面-环面 flip 连通性 / 铺砖奇偶与空洞解等方向，**无一以本批四条命题为对象**。

## 四、对 Phase 0 未验证项的处置

- **消解**：Phase 0 `claims.md` §五 第 5 条「是否已有文献给出该闭式」记为**未验证**，
  本次经 arXiv + zbMATH + MSE 三通道对口径 ⑥ 查询**全部零命中**，Crossref 直接相关 1 条
  （`Domino Tiling Congruence Modulo 4`）核读为不同对象 ⇒ **升级为「已查，未查到」**。
- **仍未消解的边界**：OpenAlex 缺项（§一）。因此表述上限仍是：
  **「就本批所查通道，未见以该约束筛选口径为对象的文献或序列记录」**，
  **不得**升级为「首次给出」「新发现」——占位围栏（卡面《主口径》第 3 条）继续生效。
- **C9 裁决态**：四条均 = **查无占位**（沿用选题批 `clean` 折叠 + 本批补查）。
  该态满足 SOP 08b 收入门槛第 3 条（`∈ {查无占位, 已知未形式化}`）。

---

# 第六部分 · 本批 OEIS 补查：T1 六变体（含 n=20/22/24 补算）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-recheck-01.md`

# pool-mossad42-01 OEIS 补查（n=20/22/24 补算后，六变体）

## identity
- 查询串：`1,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,5824,0,0,0,0,0,0,0,680960`
- 结果：**zero-hit**

## nonzero-subcol
- 查询串：`1,56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,42595823942074`
- 结果：**zero-hit**

## even-idx
- 查询串：`1,0,0,0,56,0,0,0,5824,0,0,0,680960`
- 结果：**zero-hit**

## odd-idx
- 查询串：`0,0,0,0,0,0,0,0,0,0,0,0`
- 结果：**hit**（10 命中）
    - 10054 — a(n) = 1 if n is a triangular number, otherwise 0.
    - 10815 — From Euler's Pentagonal Theorem: coefficient of q^n in Product_{m>=1} (1 - q^m).
    - 122 — Expansion of Jacobi theta function theta_3(x) = Sum_{m =-oo..oo} x^(m^2) (number of integer solutions to k^2 = n).
    - 121373 — Expansion of f(x) = f(x, -x^2) in powers of x where f(, ) is Ramanujan's general theta function.
    - 7 — The characteristic function of {0}: a(n) = 0^n.

## first-diff
- 查询串：`-1,0,0,0,0,0,0,56,-56,0,0,0,0,0,0,5824,-5824,0,0,0,0,0,0,680960`
- 结果：**zero-hit**

## partial-sums
- 查询串：`1,1,1,1,1,1,1,1,57,57,57,57,57,57,57,57,5881,5881,5881,5881,5881,5881,5881,5881,686841`
- 结果：**zero-hit**

---

# 第七部分 · 本批 OEIS 补查：四轨逐轨变体
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-quad.md`

# 四轨 OEIS 补查（本机独立重算数列；2026-09-30）

## T1 · 3×n 恰半
- identity：**零命中**
- nonzero-subcol：**零命中**
- even-idx：**零命中**
- first-diff：**零命中**

## T2 · 3×n mod3
- identity：**零命中**
- even-idx：**零命中**
- odd-idx：**命中 10**
    - 7 — The characteristic function of {0}: a(n) = 0^n.
    - 4 — The zero sequence.
    - 209229 — Characteristic function of powers of 2, cf. A000079.
    - 63524 — Characteristic function of 1.
    - 19590 — Fermat's Last Theorem: a(n) = 1 if x^n + y^n = z^n has a nontrivial solution in integers, otherwise a(n) = 0.
- first-diff：**零命中**
- partial-sums：**零命中**

## T3 · 4×n 恰半
- identity：**零命中**
- nonzero-subcol：**零命中**
- even-idx：**零命中**
- first-diff：**零命中**

## T4 · 4×n mod3
- identity：**零命中**
- even-idx：**零命中**
- odd-idx：**零命中**
- first-diff：**零命中**
- partial-sums：**零命中**

---

# 第八部分 · 本批 OEIS 闭式专查：T1 闭式 5 条互异查询串
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-closed.md`

# 闭式与关键子列 OEIS 定向复查（2026-09-30，零预算）

## T1-closed 8^k*C(7k,k) [k>=1]（12 项）
- 查询串：`56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,5739`
- 结果：**零命中**

## T1-closed [k>=0]（13 项）
- 查询串：`1,56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,57`
- 结果：**零命中**

## T3 压缩 k=n/2 前 14 项（14 项）
- 查询串：`1,3,16,108,762,5493,40285,299253,2244206,16953894,128827701,983588334,7539313191,57982424958`
- 结果：**零命中**

## T3 原串 n=0..28（29 项）
- 查询串：`1,0,3,0,16,0,108,0,762,0,5493,0,40285,0,299253,0,2244206,0,16953894,0,128827701,0,983588334,0,7539313191,0,57982424958,0,447195350`
- 结果：**零命中**

## T4 原串 n=0..20（21 项）
- 查询串：`1,1,1,1,10,37,110,269,701,2000,6020,17495,49206,137226,388116,1108721,3166325,8995427,25493465,72315824,205483841`
- 结果：**零命中**

## T2 压缩 k=n/2 前 14 项（14 项）
- 查询串：`1,1,1,9,57,225,737,2513,9521,37025,139937,517337,1913193,7136577`
- 结果：**零命中**

---

# 第九部分 · 本批 OEIS 短串专查（T3 短窗巧合排除）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-short.md`

# OEIS 最短串定向查（2026-09-30）

## T1 闭式 3 项：`56,5824,680960`
- **零命中**

## T1 闭式 4 项：`1,56,5824,680960`
- **零命中**

## T1 闭式 5 项：`1,56,5824,680960,83865600`
- **零命中**

## T3 压缩 3 项：`3,16,108`
- **命中 2**
    - 220379 — G.f. satisfies: A(x) = x + (1-x)*A(A(x))^2.
    - 292752 — Dimensions of centralizer algebras of groups associated with Z_4-codes.

## T3 压缩 4 项：`1,3,16,108`
- **命中 2**
    - 220379 — G.f. satisfies: A(x) = x + (1-x)*A(A(x))^2.
    - 292752 — Dimensions of centralizer algebras of groups associated with Z_4-codes.

## T3 压缩 5 项：`1,3,16,108,762`
- **零命中**

---

# 第十部分 · 本批 OEIS 通道正对照（先证通道可用，再读零命中）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-control.md`

# OEIS 通道正对照 + 闭式定向查新（2026-09-30）

> 正对照用途：证明本通道对**已知序列**能命中；正对照全中 ⇒ 下列零命中可信。

## 一、正对照（必须命中）
### 正对照 A001835 (3×n 铺砖总数偶下标)（9 项）
- 查询串：`1,3,11,41,153,571,2131,7953,29681`
- 结果：**命中 2**
    - 1835 — a(n) = 4*a(n-1) - a(n-2), with a(0) = 1, a(1) = 1.
    - 79935 — a(n) = 4*a(n-1) - a(n-2) with a(1) = 1, a(2) = 3.

### 正对照 A005178 (4×n 铺砖总数)（10 项）
- 查询串：`1,1,5,11,36,95,281,781,2245,6336`
- 结果：**命中 1**
    - 5178 — Number of domino tilings of 4 X (n-1) board.

### 正对照 A000045 (Fibonacci)（10 项）
- 查询串：`0,1,1,2,3,5,8,13,21,34`
- 结果：**命中 10**
    - 45 — Fibonacci numbers: F(n) = F(n-1) + F(n-2) with F(0) = 0 and F(1) = 1.
    - 212804 — Expansion of (1 - x)/(1 - x - x^2).
    - 105471 — a(n) = Fibonacci(n) mod 100.
    - 261575 — Table of Fibonacci numbers in base-60 representation: row n contains the sexagesimal digits of A000045(n) in reversed order.
    - 147316 — Fibonacci numbers (A000045) starting at offset -20.
    - 261587 — Sum of sexagesimal digits of Fibonacci numbers in base-60 representation.

### 正对照 C(7k,k)=A062994 类（6 项）
- 查询串：`1,7,91,1330,20349,324632`
- 结果：**零命中**

## 二、待查序列
### T1 闭式 8^k·C(7k,k)，k≥0（12 项）
- 查询串：`56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,5739`
- 结果：**零命中**

### T1 闭式 8^k·C(7k,k)，k≥1（11 项）
- 查询串：`5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,5739525`
- 结果：**零命中**

### T1 闭式 前 4 项（最小查询）（4 项）
- 查询串：`56,5824,680960,83865600`
- 结果：**零命中**

### T1 非零子列含首 1（13 项）（13 项）
- 查询串：`1,56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,57`
- 结果：**零命中**

### T2 压缩 k=n/2（16 项）（16 项）
- 查询串：`1,1,1,9,57,225,737,2513,9521,37025,139937,517337,1913193,7136577,26720577,99886753`
- 结果：**零命中**

### T3 压缩 k=n/2（16 项）（16 项）
- 查询串：`1,3,16,108,762,5493,40285,299253,2244206,16953894,128827701,983588334,7539313191,57982424958,447195350597,3457539815508`
- 结果：**零命中**

### T4 整串（18 项）（18 项）
- 查询串：`1,1,1,1,10,37,110,269,701,2000,6020,17495,49206,137226,388116,1108721,3166325,8995427`
- 结果：**零命中**

---

# 第十一部分 · 本批 OEIS 正对照订正（查询串笔误修正）
> 源文件（逐字拷入）：`tasks/20260930-mossad42-quad/phase0/oeis-control2.md`

# OEIS 修正正对照 + 相关族查新（2026-09-30）

## 修正正对照 C(7k,k)（11 项）
- 查询串：`1,7,91,1330,20475,324632,5245786,85900584,1420494075,23667689815,396704524216`
- 结果：**命中 1**
    - 4368 — Binomial coefficient C(7n,n).
        data: 1,7,91,1330,20475,324632,5245786,85900584,1420494075,23667689815,39670

## 修正正对照 C(2k,k) (A000984)（11 项）
- 查询串：`1,2,6,20,70,252,924,3432,12870,48620,184756`
- 结果：**命中 1**
    - 984 — Central binomial coefficients: binomial(2*n,n) = (2*n)!/(n!)^2.
        data: 1,2,6,20,70,252,924,3432,12870,48620,184756,705432,2704156,10400600,40

## T1 闭式 8^k·C(7k,k)（12 项）（12 项）
- 查询串：`1,56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,573952551507`
- 结果：**零命中**

## T1 闭式去掉公因子：2^{3k}C(7k,k) 同串（12 项）
- 查询串：`1,56,5824,680960,83865600,10637541376,1375151325184,180146581536768,23831935922995200,3176623553978040320,425958239420740009984,573952551507`
- 结果：**零命中**

## T3 压缩更长窗口（20 项）（20 项）
- 查询串：`1,3,16,108,762,5493,40285,299253,2244206,16953894,128827701,983588334,7539313191,57982424958,447195350597,3457539815508,26789868419766,20796`
- 结果：**零命中**

## T2 压缩更长窗口（20 项）（20 项）
- 查询串：`1,1,1,9,57,225,737,2513,9521,37025,139937,517337,1913193,7136577,26720577,99886753,372602209,1389401281,5184301249,19352535721`
- 结果：**零命中**
