> provenance note (added by the claim packager, 2026-09-28): this file is the
> full C9 exclusivity-review record for the candidate behind this claim
> (pool-comb-09, the 4xn grid with two corner vertices of the last column
> removed), copied VERBATIM and byte-for-byte in two parts:
>
>   part 1 -- the whole of
>     `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-03.md`
>     (source file sha256 2348cef83f13413902162c9565352e6e104a872bea25a934191c21f57365c253; 47 lines, LF), unmodified;
>   part 2 -- section 8 (the three-candidate verdict roll-up table),
>     `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md`
>     lines 131-137 (source file sha256 d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f; 158 lines, LF), unmodified;
>     the comb-09 row of that table is the one that applies to this claim.
>
> Nothing else was added inside the record body; the C9 conclusion sentences
> are not reworded. Raw query responses remain in the working repository under
> `tasks/20260928-comb0709-deeprecheck/` (kept in-repo, not shipped in this
> deposit). The exclusivity review ran at 0 LLM calls; the verdict carried
> into the claim note is "no occupying record found" (three rounds
> consistent) at the value tier "new sequence".

## part 1 (verbatim): deep-recheck-combm-03.md, whole file

# C9 独占性深度复审（第三轮）裁决记录 — combm-03-grid-4n-twocorners-col（pool-comb-09）

> 任务 `tasks/20260928-comb0709-deeprecheck` · 共享证据见 `recheck/deep-recheck-shared.md`。
> 前审：一审 `tasks/20260927-mapselect-01/c9/combm-03-grid-4n-twocorners-col.md` + 红队二审 `c9/recheck-combm-03-grid-4n-twocorners-col.md`（均「查无占位」；一审已注与 A033507 同谱）。
> 命题（池条目 statementNL 逐字）：G_n = P₄□P_n（n≥1）删去右列上角（第 1 行第 n 列）与下角（第 4 行第 n 列）后全部匹配数；a(1..12) = 2, 15, 209, 2426, 29566, 355504, 4290501, 51728089, 623832332, 7522727192, 90717725366, 1093972462647；猜想九阶递推 a(n) = 9a(n−1)+41a(n−2)−41a(n−3)−111a(n−4)+91a(n−5)+29a(n−6)−23a(n−7)−a(n−8)+a(n−9)（n≥10）。

## 0. 裁决先行

**C9 四态：查无占位（三轮一致，本审支持前两审结论）。**
**价值分级：新序列**（九阶递推与已挂名的 A033507 完全同谱——前两审已注，本审机器确认；「新序列·新递推」措辞本审维持修正为「新序列」）。

## 1. 机器复算（三异构法，本审独立）

- 卡面 a(1..12) 逐位复现 ✓；B/C 两法交叉 ✓；外部锚点 PASS ✓。
- 卡面九阶递推在本审自算 **50 项**上全部成立（前审最深 40 项）；有理域最小阶拟合**恰为 9 阶**，系数与卡面一致（≤8 阶无解，与二审 8 阶排除独立互证）——候选卡不确定性①闭合。
- 特征多项式 x⁹−9x⁸−41x⁷+41x⁶+111x⁵−91x⁴−29x³+23x²+x−1；真母函数 (2−3x−8x²+12x³−4x⁵+x⁶)/(1−9x−41x²+41x³+111x⁴−91x⁵−29x⁶+23x⁷+x⁸−x⁹)——分子与二审修正后的正确分子（2,−3,−8,12,0,−4,1）逐字一致（一审错串系未翻号，二审已勘误）；增长率 12.0591/列。
- PM 子列 = 1,1,6,12,42,107,323,888,2568,7224,**20629,58429** = **A129113 已占位**（OEIS 挂名 + AMM Problem 11187 2007；本审新算的第 11/12 项 20629/58429 与 A129113 数据逐位对齐，占位证据扩展至第 12 项）——维持前两审处置：不得作新颖性主张。

## 2. 同谱关系机器确认（前审已注，本审加固）

- A033507（无缺陷 4×n 全匹配）OEIS 记录实读：%F 九阶递推与卡面猜想**逐字相同**，签名 (9,41,−41,−111,91,29,−23,−1,1)；本机双向核验：comb-09 与 A033507 均满足该九阶递推，主特征根同为 12.0591。
- 数学解释同 comb-08：缺陷仅在右端一列 → 计数 = uᵀ·Tⁿ⁻²·v，与完整网格共享 T 的极小多项式。
- **含义**：九阶递推非新（A033507 在册）；新的只是初值即序列。价值分级按「新序列」（前两审「新序列·新递推」措辞越级处，本审与 comb-08 一并修正）。

## 3. 第三轮 C9 取证增量（全部新轴）

- **OEIS**：9 个新串（a(0) 前插 `1,2,15,209,2426,29566,355504`、前插零、中段 6 项窗、特征多项式裸串 `1,-9,-41,41,111,-91,-29,23,1,-1`、分子裸串 `2,-3,-8,12,0,-4,1`、**mod-3 余子列 ×3**（前两轮只拆过奇偶）、尾段 7 项窗、差分窗）**全部零命中**。合并前两轮，主序列累计 **40+ 独立查询串零命中**。
- **文献**：四通道 20 组新别名查询零同形；**Oh 2019 全文逐节通读**（Theorem 4 固定单体集 = 方法通形，统计量口径不同形；全文无本题数列）；参考文献链三篇最近邻摘要实读均为「单 vacancy + 完美匹配」口径；被引 12 篇后继无缺陷网格全匹配计数；arXiv `all:"monomer-dimer" AND all:"punctured"` 与 `all:"acyclic polynomial" AND all:"grid"` 均 total=0（通道正控同时通过）。
- **OEIS 记录全栏深读**：A033507 的 reference/link 全栏确认母族文献（Hosoya–Motoyama 1985、Lundow polygraphs）只处理完整网格；A033507 的 %F 实读是同谱判定的一手来源。
- **库层**：mathlib/compfiles 零同形；sequencelib 结构上不可能在场；公开 Lean 代码 gh CLI 对本审新取大项（13192325177001 / 159087517952550 / 90717725366 / 1093972462647）**total=0**。

## 4. 与 nt-03 失败模式的对照

同 comb-01 记录 §4。补一点本候选特有的对照：一审曾把母族同谱事实（A033507）误写为「A33507」并经收口员勘误——本审对 A033507 做 `q=id:` 全栏实读，九阶递推与签名为一手确认，不再依赖转录。

## 5. 残余风险

1. 通用搜索引擎层本环境不可达（共享记录 §7/§9）。
2. Lundow/Read 母族文献全文未读；Guichard 2008 全文未读（只可能触及已被 A129113 占位的 PM 面）。
3. MSE 原生 API 约 7.5 h 后恢复可补检。
4. 九阶递推机器验证止于 50 项；数学证明义务在入闸后（候选卡已列断点预期）。

## 6. 裁决

- **C9 四态：查无占位**（证据链同共享记录 §8）。
- **价值分级：新序列**（递推与 A033507 同谱，非新）。PM 派生（A129113）已占位，禁作新颖性主张。
- **处置**：维持「待用·未冒烟」；池条目与候选卡价值表述按本审修正（「新序列·新递推」→「新序列，递推与 A033507 同谱」）。捞取入批时补 C8 冒烟 + #check 批核。

---

## part 2 (verbatim): shared record, section 8 roll-up table

> source: `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md`
> lines 131-137 (sha256 d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f); copied byte-for-byte.

## 8. 三候选裁决（详见各自记录）

| 候选 | C9 四态 | 价值分级（本审口径） | 与 nt-03 情形的本质区别 |
|---|---|---|---|
| comb-07 | **查无占位（三轮一致）** | 新序列·新递推（七阶递推亦新） | 无等价刻画文献；Oh 2019 Theorem 4 仅为方法通形 |
| comb-08 | **查无占位（三轮一致）** | **新序列**（递推与 A033506 同谱，非新——本审修正前审「新递推」措辞） | 同上 |
| comb-09 | **查无占位（三轮一致）** | 新序列（递推与 A033507 同谱，前审已注） | 同上 |

## appendix: extraction self-check

| part | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
| 1 | deep-recheck-combm-03.md | 1-47 | 5286 | 31b7a378de9f88a0 |
| 2 | deep-recheck-shared.md | 131-137 | 586 | 2b7684f1b2a50760 |

Recompute with: `python claims/grid4n-col-2notch/audit/build-c9-record.py --check`
