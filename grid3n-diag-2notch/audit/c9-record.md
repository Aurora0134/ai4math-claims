> provenance note (added by the claim packager, 2026-09-28): this file is the
> full C9 novelty-review record for the candidate comb-07 (pool-comb-07, the
> two-defect 3xn grid matching count), copied VERBATIM and byte-for-byte:
> part 1 is the ENTIRE candidate record
> `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md`
> (source file sha256 9d8f7e0c6698896a87f1f1c91eb7ba2337ed62a77160fc1d14fad4c3179772e3; 49 lines, LF), and part 2 is the section 8
> roll-up table of the shared evidence record
> `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md`
> (source file sha256 d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f; 158 lines, LF), lines 131-137 verbatim.
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses, the shared evidence sections and the
> enumeration scripts remain in the working repository under
> `tasks/20260928-comb0709-deeprecheck/` (kept in-repo, not shipped in this
> deposit). The exclusivity review ran at 0 llm-call; the C9 verdict carried
> into the claim note is "no occupying record found" (three consistent rounds)
> at the value tier "new sequence / new recurrence".

## part 1 -- candidate record, verbatim whole file `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md`

# C9 独占性深度复审（第三轮）裁决记录 — combm-01-grid-diag-2notch（pool-comb-07）

> 任务 `tasks/20260928-comb0709-deeprecheck` · 共享证据（机器复算/OEIS/文献/库层台账）见 `recheck/deep-recheck-shared.md`，本记录只收本候选的裁决与候选特有事实。
> 前审：一审 `tasks/20260927-mapselect-01/c9/combm-01-grid-diag-2notch.md` + 红队二审 `c9/recheck-combm-01-grid-diag-2notch.md`（均「查无占位」）。
> 命题（池条目 statementNL 逐字）：G_n = P₃□P_n（n≥1）删去右上角（第 1 行第 n 列）与左下角（第 3 行第 n 列）后全部匹配数；a(1..14) = 1, 5, 33, 204, 1266, 7873, 48882, 303723, 1886600, 11720017, 72804880, 452270456, 2809532937, 17453021829；猜想七阶递推 a(n) = 4a(n−1)+15a(n−2)−5a(n−3)−19a(n−4)+9a(n−5)+2a(n−6)−a(n−7)（n≥8）。

## 0. 裁决先行

**C9 四态：查无占位（三轮一致，本审支持并加固前两审结论）。**
**价值分级：新序列·新递推**——且经本审机器判定，其七阶递推**亦是新的**（与无缺陷母族 A033506 的六阶递推互不覆盖，见 §2），是三候选中唯一「序列与递推双新」的一条。

## 1. 机器复算（三异构法，本审独立）

- 卡面 a(1..14) 逐位复现 ✓；方法 B（边序回溯，n≤8）/ 方法 C（全边子集暴力，n≤4）与列 DP 逐位一致 ✓；外部锚点（A033506/A033507/A030186）PASS ✓。
- 卡面七阶递推在本审自算 **50 项**上全部成立（前审最深 30 项）；有理域最小阶拟合**恰为 7 阶**，系数与卡面逐字一致（≤6 阶无解）——候选卡不确定性①（拟合≠证明、阶可能偏低）在本审 50 项 + 精确拟合口径下进一步收敛（仍未证明，证明义务在入闸后）。
- 特征多项式 x⁷−4x⁶−15x⁵+5x⁴+19x³−9x²−2x+1；真母函数 (1+x−2x²+2x³−x⁴)/(1−4x−15x²+5x³+19x⁴−9x⁵−2x⁶+x⁷)（分子与二审推导逐字一致）；增长率 6.2121/列。
- PM 偶 n 子列 = 1,5,20,76,285,1065 = **A061278 已占位**（OEIS 挂名 + sequencelib 0-sorry 定义级）——维持前两审处置：不得作新颖性主张，主命题新颖性只落在全匹配主数列 + 七阶递推。

## 2. 本审新增判定：七阶递推与母族不同谱（前两轮未查）

- A033506（无缺陷 3×n 全匹配，OEIS 签名 (4,14,0,−10,0,1)）**不满足** comb-07 的七阶递推（以七阶递推推 A033506 的 a(8) = 1222548 ≠ 实际 1222550）；
- comb-07 **亦不满足** A033506 的六阶递推（以六阶递推推 comb-07 的 a(7) = 305421 ≠ 实际 303723）；
- 精确分解（本机多项式除法，余式为零）：**comb-07 特征多项式 = (x²+x−1)·Q₅，A033506 特征多项式 = (x+1)·Q₅，共享同一个五次因子 Q₅(x) = x⁵−5x⁴−9x³+9x²+x−1**（Q₅ 即 A033506 母函数分母中五次部分的倒数多项式）；差别仅在余因子 (x²+x−1)（根 −φ、1/φ）vs (x+1)（根 −1）。两者主特征根同为 6.2121（同宽度 3 转移矩阵的谱半径，数学上预期）。
- **含义**：comb-07 的递推不是「完整网格递推的换初值变体」——双缺陷（对角两端）使特征多项式在共享五次因子外多出 (x²+x−1) 因子（而非 (x+1)），阶数由 6 升 7。这使「新递推」主张成立（对比 comb-08/09 的完全同谱情形，见各自记录）。

## 3. 第三轮 C9 取证增量（全部新轴，台账见共享记录 §2–§6）

- **OEIS**：10 个新串（a(0) 前插 `1,1,5,33,204,1266,7873,48882`、前插零、全长 14 项串、中段 6 项窗、特征多项式裸串 `1,-4,-15,5,19,-9,-2,1`、分子裸串、mod-3 余子列 ×3、尾段 7 项窗）**全部零命中**；仅分子短串 10 条泛命中（Kolakoski 差分/McKay-Thompson 等，name 核读排除）。合并前两轮，主序列累计 23+（一审 12）+ 8（二审）+ 10（本审）= **50+ 独立查询串零命中**。
- **文献**：四通道 20 组新别名查询零同形；**Oh 2019 全文逐节通读**（含 §2 Theorem 4「固定单体集」一般公式与 §7 证明全文）：该定理给出任意固定缺陷集的**方法**，但统计量是「单体恰在 S」（单体数=|S| 固定），与本题「删 S 后全部匹配」（单体数任意 = Σ_{T⊇S} g(T)）不同形；全文无本题数列/递推实例（我方大项全文逐字搜索零命中，`OEIS` 字样 0 次）。参考文献链三篇最近邻（Kong 2006 / Tzeng–Wu 2003 / Wu 2006）摘要实读，全部为「单 vacancy/单边界单体 + 完美匹配」口径。Oh 2019 被引 12 篇后继逐条读题，无缺陷网格全匹配计数。
- **OEIS 记录全栏深读**：A033506/A033507 的 reference/link 全栏确认母族文献底座（Lundow polygraphs、Read 1982、Hosoya–Motoyama 1985）只处理完整网格；A033506 签名栏实读是同谱判定来源。
- **库层**：mathlib/compfiles 零同形（同前审）；sequencelib 结构上不可能在场（无 A 号）；公开 Lean 代码 gh CLI 对本审新取大项（72804880 / 2809532937 / 17453021829）**total=0**。

## 4. 与 nt-03 失败模式的对照（本审为何未重蹈）

nt-03 的翻案链是「摘要级命中 → 见标题 shifted 收线 → 漏追参考文献 [17] → 实则 Lemma 2.5 已给出等价刻画」。本候选的最接近结构是 Oh 2019 Theorem 4（固定单体集通形），本审的差异化处置：①不满足于摘要/关键词 grep，全文逐节读并确认其统计量口径与本题不同形；②回溯参考文献链读三篇最近邻摘要；③核被引后继；④对 OEIS 母族记录做全栏（含递推签名栏）深读——同谱判定正来源于此。**若存在等价刻画文献，按 nt-03 判例它必须直接给出本题序列或「≤2 步推论」的刻画；Oh 2019 只给出方法，不给出陈述，故不构成占位。**

## 5. 残余风险

1. 通用搜索引擎层本环境不可达（共享记录 §7/§9）：文献层证词由四结构化通道 + 前两轮引擎侧证词承载。
2. Lundow 1996/1998、Read 1982 全文未读（母族奠基文献，A033506/A033507 全栏未显示含缺陷变体）。
3. Guichard 2008 全文未读（付费墙；摘要级已证存在性口径，且只可能触及已占位的 PM 面）。
4. MSE 原生 API 约 7.5 h 后恢复，可补站内逐字检索。
5. 七阶递推的机器验证止于 50 项数值自洽（极小阶恰 7 的精确拟合），**数学证明义务在入闸后**（递推归纳路线，候选卡已列断点预期）。

## 6. 裁决

- **C9 四态：查无占位**（OEIS 50+ 串零命中 + 四通道文献零同形 + Oh 2019 全文层收口 + 库层四层零在场）。
- **价值分级：新序列·新递推**（七阶递推经机器判定与母族不同谱，双新成立；不授「新数学」：方法学（转移矩阵/状态矩阵递推）文献成熟，Oh 2019 Theorem 4 可平凡产出本序列）。
- **处置**：维持「待用·未冒烟」，捞取入批时按 pools/README 规程补 C8 冒烟 + #check 批核；PM 派生（A061278）占位警示保留在条目。用户闸门一定题前无需再跑 C9（三轮一致），但冒烟与形式化部前置义务不变。

---

## part 2 -- section 8 roll-up table, verbatim lines 131-137 of `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md`

## 8. 三候选裁决（详见各自记录）

| 候选 | C9 四态 | 价值分级（本审口径） | 与 nt-03 情形的本质区别 |
|---|---|---|---|
| comb-07 | **查无占位（三轮一致）** | 新序列·新递推（七阶递推亦新） | 无等价刻画文献；Oh 2019 Theorem 4 仅为方法通形 |
| comb-08 | **查无占位（三轮一致）** | **新序列**（递推与 A033506 同谱，非新——本审修正前审「新递推」措辞） | 同上 |
| comb-09 | **查无占位（三轮一致）** | 新序列（递推与 A033507 同谱，前审已注） | 同上 |

## appendix: extraction self-check

| part | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
| 1 | 1-whole file | 7252 | d037577684bddc38 |
| 2 | 131-137 | 586 | 2b7684f1b2a50760 |

Recompute with: `python claims/grid3n-diag-2notch/audit/build-c9-record.py --check`
