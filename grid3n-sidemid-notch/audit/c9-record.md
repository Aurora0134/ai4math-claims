> provenance note (added by the claim packager, 2026-09-28): this file is the
> C9 novelty-review record for the claim of this deposit (candidate comb-08,
> pool-comb-08; source task tasks/20260928-comb08-sidemid), copied VERBATIM and
> byte-for-byte from the pipeline's third-round deep exclusivity review:
>
>   source 1: `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-02.md` (46 lines, LF) -- sha256 79e7ee63f706d09c5fdcc5b4628a57f979869954865704a26cd34388e258df98
>             copied as a whole file
>   source 2: `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md` (158 lines, LF) -- sha256 d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f
>             excerpt: lines 131-137 (section 8 roll-up table)
>
> Nothing else was added; the record bodies are unmodified and their conclusions
> are not reworded. Raw query responses remain in the working repository under
> `tasks/20260928-comb0709-deeprecheck/recheck/` (kept in-repo, not shipped in
> this deposit). The exclusivity review was run by selection-department workers
> at 0 LLM calls; the C9 verdict carried into the claim note is "no occupying
> record found" (three rounds consistent) at the corrected value tier "new
> sequence" (the recurrence is not new -- same spectrum as A033506).

# C9 独占性深度复审（第三轮）裁决记录 — combm-02-grid-sidemid（pool-comb-08）

> 任务 `tasks/20260928-comb0709-deeprecheck` · 共享证据见 `recheck/deep-recheck-shared.md`。
> 前审：一审 `tasks/20260927-mapselect-01/c9/combm-02-grid-sidemid.md` + 红队二审 `c9/recheck-combm-02-grid-sidemid.md`（均「查无占位」；二审曾对 Oh 2019 做 ar5iv 全文关键词深读）。
> 命题（池条目 statementNL 逐字）：G_n = P₃□P_n（n≥1）删去右列中间顶点（第 2 行第 n 列）后全部匹配数；a(1..14) = 1, 8, 46, 295, 1814, 11306, 70161, 435986, 2708104, 16823455, 104507480, 649209736, 4032932785, 25052868880；猜想六阶递推 a(n) = 4a(n−1)+14a(n−2)−10a(n−4)+a(n−6)（n≥7）。

## 0. 裁决先行

**C9 四态：查无占位（三轮一致，本审支持前两审结论）。**
**价值分级：新序列——「新递推」主张经本审机器判定不成立（递推与已挂名的 A033506 同特征多项式），这是对前两审分级措辞的修正（收紧，不影响四态裁决）。**

## 1. 机器复算（三异构法，本审独立）

- 卡面 a(1..14) 逐位复现 ✓；B/C 两法交叉 ✓；外部锚点 PASS ✓（过程留痕：本审方法 A 两处 bug 均被异构交叉当场揭穿，见共享记录 §1）。
- 卡面六阶递推在本审自算 **50 项**上全部成立（前审最深 30 项）；有理域最小阶拟合**恰为 6 阶**，系数 (4,14,0,−10,0,1) 与卡面一致（≤5 阶无解）——候选卡不确定性①（六阶稀疏拟合的阶充分性）在本审口径下闭合（数值层面）。
- 特征多项式 x⁶−4x⁵−14x⁴+10x²−1；真母函数 (x+4x²−x⁴)/(1−4x−14x²+10x⁴−x⁶)（与一审推导逐字一致）；增长率 6.2121/列。
- PM ≡ 0：本审覆盖约束 DP n=1..12 全零 ✓（n 偶顶点数奇；n 奇洞色属少数类——经典残缺棋盘着色阻塞，教科书级 folklore，不作价值主张主体；前两审同判）。

## 2. 本审新增判定：六阶递推与 A033506 同谱（前两轮漏查）

- 从 A033506 OEIS 记录实读其「Index entries for linear recurrences, signature (4,14,0,-10,0,1)」——**与 comb-08 卡面猜想递推的签名逐字相同**；本机双向核验：comb-08 满足 A033506 的六阶递推 ✓，A033506 亦满足 ✓；两者主特征根同为 6.2121。
- **数学解释**（本审推导）：comb-08 的缺陷仅在右端一列，计数 = uᵀ·Tⁿ⁻²·v（T = 3 行内部列转移矩阵，与完整网格相同），故序列落在 T 的极小多项式给出的递推空间里——与完整网格序列（A033506）同阶同系数，差别只在初值。
- **含义（分级修正）**：comb-08 的「新递推」不成立——**阶与系数都已是 A033506 的挂名递推**；新的只是初值即序列本身。前两审「新序列·新递推」的措辞对 comb-08 越级，本审收紧为「新序列（递推与 A033506 同谱）」。（同谱情形在 comb-09 侧前两审已注，本审补齐 comb-08 侧——这本身是前两审的一个覆盖缺口。）

## 3. 第三轮 C9 取证增量（全部新轴）

- **OEIS**：10 个新串（a(0) 前插、前插零、全长 14 项串、中段 6 项窗、特征多项式裸串 `1,-4,-14,0,10,0,-1`、分子裸串、mod-3 余子列 ×3、尾段 7 项窗）**全部零命中**；仅分子短串 10 条泛命中（Jacobsthal 三角/Stieltjes 常数展开等，name 核读排除）。合并前两轮，主序列累计 **50+ 独立查询串零命中**。
- **文献**：四通道 20 组新别名查询零同形（含 Oh 本人术语「fixed monomer set」、punctured/holed/obstacle、acyclic polynomial、line graph 对偶等前两轮未用口径）；**Oh 2019 全文逐节通读**——Theorem 4（固定单体集）为方法通形，统计量口径（单体恰在 S）与本题（删 S 后全匹配）不同形，全文无本题数列（二审关键词 grep 的结论本审以全文通读加固）；参考文献链三篇最近邻摘要实读均为「单 vacancy + 完美匹配」口径；被引 12 篇后继无缺陷网格全匹配计数。
- **库层**：mathlib/compfiles 零同形；sequencelib 结构上不可能在场；公开 Lean 代码 gh CLI 对 4032932785 / 25052868880（前审已查）+ 本审新取的中间项复核 **total=0**。

## 4. 与 nt-03 失败模式的对照

同 comb-01 记录 §4：本审对最高危邻域（Oh 2019 Theorem 4）做全文层收口 + 参考文献回溯 + 被引后继核查，确认文献中存在的是**方法通形**而非**本题序列的陈述或等价刻画**——与 nt-03 的 Irmak Lemma 2.5（直接给出候选命题的 ≤2 步推论）有本质区别，故不触发「已占位」。

## 5. 残余风险

1. 通用搜索引擎层本环境不可达（共享记录 §7/§9）。
2. Lundow/Read 母族文献全文未读；Guichard 2008 全文未读（只可能触及 PM 面，而本题 PM≡0 真空）。
3. MSE 原生 API 约 7.5 h 后恢复可补检。
4. 六阶递推机器验证止于 50 项；数学证明义务在入闸后。

## 6. 裁决

- **C9 四态：查无占位**（证据链同共享记录 §8）。
- **价值分级：新序列**（递推非新——与 A033506 同谱；「新序列·新递推」措辞按本审修正）。派生 PM≡0 为经典着色阻塞实例，不构成占位亦不作价值主体。
- **处置**：维持「待用·未冒烟」；**池条目与候选卡的人话区块/价值表述须按本审修正**（「新递推」→「新序列，递推与 A033506 同谱」），立项/论文时禁对递推本身作新颖性主张。捞取入批时补 C8 冒烟 + #check 批核。

## 8. 三候选裁决（详见各自记录）

| 候选 | C9 四态 | 价值分级（本审口径） | 与 nt-03 情形的本质区别 |
|---|---|---|---|
| comb-07 | **查无占位（三轮一致）** | 新序列·新递推（七阶递推亦新） | 无等价刻画文献；Oh 2019 Theorem 4 仅为方法通形 |
| comb-08 | **查无占位（三轮一致）** | **新序列**（递推与 A033506 同谱，非新——本审修正前审「新递推」措辞） | 同上 |
| comb-09 | **查无占位（三轮一致）** | 新序列（递推与 A033507 同谱，前审已注） | 同上 |
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
| 1 | `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-02.md` | whole file (46 lines) | 5664 | df0c72d465ccee6b |
| 2 | `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-shared.md` | lines 131-137 | 586 | 2b7684f1b2a50760 |

Recompute with: `python claims/grid3n-sidemid-notch/audit/build-c9-record.py --check`
