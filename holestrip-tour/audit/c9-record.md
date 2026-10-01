> provenance note (added by the claim packager, 2026-09-30): this file is the
> full C9 novelty-review record for the 3xn holed-strip far-corner knight
> graph K_n (the 3xn chessboard with the two far corners (0,0) and (2,n-1)
> removed) and its open/closed tour existence characterisation (pool-comb-11),
> copied VERBATIM and byte-for-byte in contiguous line ranges from four
> records of the working repository:
>
>   1. `tasks/20260928-knighttour-recon/recon.md` (71 lines, sha256 30ae680cf87ca8db901767d50e92ae8c600b2c352b18388df129075ce1146b25)
>      ranges 1-71: first-stage lineage recon - literature layer (Schwenk
>      1991, Cull-De Curtins 1978, Chia-Ong 2005, Watkins 1997-2004, McKay
>      1997, Miller-Farnsworth 2013, DeMaio-Hippchen 2009), OEIS layer
>      (saturated families and remaining gaps), formalisation layer (Isabelle
>      AFP Knights_Tour 2022, Lean KnightMove 2026, no deficient-board
>      content anywhere); two kernel smokes; verdict = lineage closed for
>      topic selection except three narrow paths.
>   2. `tasks/20260928-knighttour-narrow/report.md` (98 lines, sha256 d485c3e9cc1fb9b8c944bb80b937350fe6a9c92e3a28145e2cfb661a982d0590)
>      ranges 1-98: second-stage narrow-path deep dive - (1,3)/(2,4) leapers
>      plainly impossible and already published (Knuth 1994 Thm 1, Beluhov
>      2022, Chia-Ong 2005); general (a,b) open by common consent; multi-hole
>      boards: single-square-removed published, two-square 4xn solved by
>      Srichote et al. 2022, 3xn two-square ZERO published work; the
>      holed-strip far-corner counting sequence found non-trivial and
>      unregistered (OEIS six variants zero hits).
>   3. `tasks/20260928-holestrip-tourcount/report.md` (105 lines, sha256 046a34c1a0888a63e4fa0b7028a78900c7ee3ab3479159d1a1adb7c242ea72b2)
>      ranges 1-105: third-stage feasibility report - blocker 2 (zero-value
>      structure) resolved by forced-edge certificates, blocker 3 (data
>      depth) resolved by the plug DP to n=220, blocker 1 (provable core)
>      resolved as the existence characterisation; C9 round 4 upheld; C1
>      boundary question stated (options A/B/C, no self-ruling).
>   4. `tasks/20260928-holestrip-tourcount/c9/literature-round4.md` (203 lines, sha256 d5d3a1a1b274f044c5be62246baa2705d92070a3d1c4e791596731a514ce5633)
>      ranges 1-203: fourth-round full-text exclusivity review - Srichote
>      2022 read in full (4xn two-square closed tours only; no 3xn, no
>      counting); 3xn two-square existence and counting ZERO published
>      results across journals/theses/preprints/recreational sources; OEIS
>      zero hits over 50+ query strings across four rounds; no formalisation
>      in Isabelle/Lean/Coq/Mizar; residual risks ledgered.
>
> Nothing else was added; the record bodies are unmodified and their
> conclusions are not reworded. Raw query responses and downloaded texts
> remain in the working repository under the source task directories (kept
> in-repo, not shipped in this deposit).
>
> The C9 verdict carried into the claim note is: no occupying record found
> for the 3xn far-corner holed-strip knight-tour existence characterisation
> (both open and closed tours), four rounds of review consistent. The
> nearest published neighbours are Miller-Farnsworth 2013 (3xn, ONE square
> removed, closed tours), Srichote et al. 2022 (4xn, TWO squares removed,
> closed tours) and Bi et al. 2015 (the 4xn two-square question); none of
> them covers 3xn two-square tours, and none covers existence of open tours
> on deficient 3xn boards. Value tier: a small original classification
> theorem (not a first formalisation - there is no published theorem to
> formalise here; not a new sequence - no small recurrence exists for the
> counting companion).
# 选题调研（recon）：棋盘骑士巡游 / knight's tour 谱系

> 2026-09-28，端点 zcode（L3a 进程链），节点 anthropic/stepfun/step-5-preview（model-detect L2 last* 回落）。
> 用户指令：「最近看到了一个有意思的方向：棋盘上的骑士巡游/广义骑士巡游问题，走 AI4Math 选题流程，先综合看此谱系的自动化证明难度，baseline/依赖完整度，谱系占位情况的饱和度，给出合适度判断和建议（不走完整流程）」。
> 本记录 = 只读取证 + 两个 kernel smoke；未走 SOP 01 全流程、未动题库/图谱机制层（机制性改动须先获批）。

## 结论（一句话）

**不作为选题主攻方向**：文献经典层全占位（Schwenk 1991 / Cull–De Curtins 1978 / Chia–Ong 2005 / Watkins 1997–2004 / McKay 1997 / Stertenbrink 2003），形式化层主存在性定理已被 Isabelle AFP 占位（2022），Lean 侧有 2026 年活跃专门仓（KnightMove）；计数层 OEIS 常规口径高度饱和，剩余窄口撞流水线「大规模有限枚举」排除线。**可作为练习靶素材**（两个 smoke 命题已 kernel 验证，见下）。

## 轴一：自动化证明难度（本机 kernel 实测，非文献数字）

两个 smoke 均编译通过（`scripts/lean-verify` exit 0、0 sorry、`#print axioms` 恰白名单 {propext, Classical.choice, Quot.sound}）：

| smoke | 命题 | 规模 | 编译轮次 | 文件 |
|---|---|---|---|---|
| 存在性 | 3×4 棋盘存在开巡游（显式见证，Python 回溯求得） | ~50 行 | 3（前两轮均为形式化 API 摩擦：自定义 Adj 的 Decidable 实例合成、Std.Symm class 字段 elaborates；改 `SimpleGraph.fromRel` 后通过） | `tmp-probe/knight-3x4-tour.lean` |
| 不可能性 | 2×4 棋盘不存在开巡游（列奇偶不变量 + 可达性归纳） | ~55 行 | 2（一轮修 obtain 分支深度 + head_induction_on 少绑参） | `tmp-probe/knight-2x4-impossible.lean` |

- 存在性证明本质是计算认证（每步邻接 `simp+decide`、`IsHamiltonian` 经 `isHamiltonian_iff_isPath_and_length_eq` + `isPath_def` + `decide`）→ C4 裸探针集含 `decide`，属退化高风险形态。
- 不可能性证明有真实数学结构（不变量 + `ReflTransGen.head_induction_on`），非退化；但小棋盘实例均为教科书练习级。
- 关键结论：**难度不是障碍**——两个方向都远在流水线能力面内；瓶颈在选题价值层（见轴三），不在证明层。

## 轴二：baseline / 依赖完整度（mathlib v4.34.0 rev 5ed29652，本地 rg 实测）

- **谓词层完备**：`Mathlib/Combinatorics/SimpleGraph/Hamiltonian.lean`（IsHamiltonian / IsHamiltonianCycle / SimpleGraph.IsHamiltonian + 必要条件族：`IsBridge.not_isHamiltonian`、`IsHamiltonian.connected`、card=1/2 情形、`length_eq`、`isHamiltonian_iff_isPath_and_length_eq`、transfer/rotate）。
- **构造子齐**：`SimpleGraph.fromRel`（自动对称化+无环，骑士图 ~10 行可定义）、`boxProd`（`SimpleGraph/Prod.lean`，网格图 = `pathGraph m □ pathGraph n`，`pathGraph` 在 `Hasse.lean:108`）、`circulantGraph`（`Circulant.lean:29`，环面骑士图 = `Z_m × Z_n` 上 `{±(1,2),±(2,1)}` 的 circulant，直接可写）。
- **对象层空白**：无 GridGraph / knightGraph / 棋盘任何定义（与 mossad 批「无 GridGraph」判例一致）；`Matching.lean` 仅谓词无计数。
- **缺口**：`Bipartite.lean` 的「IsBipartite ↔ 无奇圈」是库内 TODO（未证）——经典「奇×奇无闭巡游」论证需自建（或走 `IsBipartiteWith` + 度数和引理绕）。
- Walk API 厚（Basic/Paths/Decomp/Subwalks/Traversal）；`Reachable = Nonempty Walk`；`reachable_iff_reflTransGen` + `Relation.ReflTransGen.head_induction_on` 支撑不变量论证（smoke 2 已用）。

## 轴三：谱系占位饱和度（三通道外部查新：文献 / OEIS / 形式化生态）

### 文献层（arXiv API + Exa + 期刊直连；OpenAlex 全程限流不可用，已如实记）

**已死（完全占位）**：① 矩形闭巡游完整刻画 = Schwenk 1991（Math. Mag. 64(5):325–332，PDF 逐字取证：m<n 时除非 (a) m,n 均奇 (b) m∈{1,2,4} (c) m=3 且 n∈{4,6,8}）；② 矩形开巡游 = Cull–De Curtins 1978 / Conrad-Hindrichs-Morsy-Wegener 1994 / Chia–Ong 2005（DAM 150:80–98，一般矩形解）；③ 环面/圆柱/Möbius/Klein 存在性 = Watkins–Hoenigman 1997 + Watkins 2004 专著 + Forrest-Teehan 2015（arXiv:1507.02917）+ Forrest-Lague 2024（arXiv:2406.05226）；④ 8×8 计数 = McKay 1997（ANU TR-CS-97-03）；⑤ 8×8 magic/semimagic = Stertenbrink 项目 2003（140 semimagic、0 真 magic）；⑥ 3×n 删一格 = Miller–Farnsworth 2013；⑦ 最小删格函数 = DeMaio–Hippchen 2009。2020–2026 新论文全部转向别的对象（NP-hard 变体、whirling knights、fairy chess、Crazy Knight on torus 等），无本谱系经典层剩余空间。
**仍有干净面**：一般 (a,b)-骑士（Kamčev 2014 EJC #P1.31 明言 "We do not know what happens for general (a,b) knights"；(2,3) 仅 Chia–Ong 2005 Theorem 10 到 5k×n；**(1,3)、(2,4) 无专门刻画**）；多洞缺陷棋盘（删 ≥2 格无系统理论）；8×n 及以上矩形 magic 计数（Kumar 2018 只到 4×n/6×n）；9×9+ 大板计数与渐近（除 Knuth 3×n 外空白）；算法优化度量（turns/crossings，Besa-Johnson-Mamano 2019）。

### OEIS 层（代理 + jsdelivr 双通道全程可用）

**高度饱和**：条带 3×n–9×n（A070030/A169764/A175855/A175881/A193054/A193055/A391999 闭；A169696/A079137/A083386/A306281/A306283/A389760/A391009 开）、n×n（A001230 闭 / A308131 开）、k×n 全矩阵（A392000 闭 / A390833 开）、Knuth 2025 first-n/first-2n 族（A383660–A383664 / A389754–A389759）、对称类族（A169765–A169777、A328341 等）、magic 族（A309271/A309273/A328816/A329370/A329483/A330529/A330610/A330611/A328872/A330758/A331483）。
**空白窄口**：环面棋盘巡游计数（13 个查询变体全零）；有向闭巡游家族（仅 3×2n = A158074）；8×n/n×n magic 计数；起点+方向双区分开巡游（仅 4×n）；广义 (a,b)-leaper 计数。
**讹传更正**：流行数字「8×8 有向闭巡游 = 26,534,728,864」是丢位讹传（OEIS 三格式检索零命中）；正确有向值 = 26,534,728,821,064 = 2×无向 13,267,364,410,532（A001230，McKay 1997；Löbbing–Wegener 1996 EJC 的 33,439,123,484,294 被 OEIS 标注为错误值）。「Wegener 2000」实为 SIAM 专著 p.369。

### 形式化层（gh + Exa；Coq/Mizar/HOL Light/Agda 查无）

- **Isabelle AFP `Knights_Tour`（2022-01-04, Lukas Koller）**：Cull–De Curtins 定理全部形式化（min(n,m)≥5 存在开巡游；面积偶则有闭巡游），并更正了原论文两处非法预计算路径。→ 主存在性定理的「首个形式化」已被占位。
- **Lean 4**：mathlib 无巡游内容（gh code search 零命中）；`matheus-fsc/KnightMove`（2026-09-17 活跃，~25 文件，mathlib v4.16）形式化**循环空间 deficit 不变量 Q(n)=3**（n≥6，无 sorry，axioms 含 Lean.ofReduceBool 来自 native_decide），不含存在性定理；`aria1th/knuth-fasc8a-ex210-lean4` 形式化 Knuth TAOCP 8A 习题 210 生成函数猜想的**否证**（m=5 反例，kernel 检查通过）。→ Lean 生态在该谱系已有活跃占位者，且走的是「代数不变量 + native_decide」路线（与流水线 ZMod/native_decide 能力面匹配）。
- **Schwenk 完整刻画：所有系统均未形式化**（FormalConjectures 的 Harary–Schwenk 是另一定理且仍 sorry）。

## 对流水线判据的映射（若将来有人再提此方向）

- **C1**：巡游计数属 comb.excluded.graph-counting 排除线延伸（经典棋盘计数 OEIS 全挂名）；存在性/刻画命题不撞该排除线，但撞 C2/C9。
- **C2**：小棋盘存在性（见证可预给）合规；「哪些棋盘有巡游」类开放式存在性结论不可预给 → 排除；只能以「双向 iff（本机枚举定结论）+ 证明」形态入闸。
- **C4**：存在性-by-见证 = decide 主导 → 退化高风险；不可能性/不变量类非退化。
- **C9**：经典层全部已占位（含 AFP 形式化占位）；按价值分级表，「首个形式化」不单独立项 → 小棋盘实例最多练习靶。
- **C1 大规模有限枚举**：计数窄口（环面、(a,b)-leaper、8×n magic）都需先建枚举引擎并防 mossad-50 DEF 族式系统性 bug（须异构复算），成本结构不兼容。

## 建议（按优先级）

1. **不开题、不入库为选题**；本记录 + run-state 条目即为该方向的处置结论（避免重复调研）。
2. 两个 smoke 命题可作为**练习靶**留档（3×4 存在性 = 计算认证形态的冒烟靶；2×4 不可能性 = 非退化 tactic 密度靶）；若入库按「练习」级记，禁止单独立项（两者均为 Schwenk/Chia–Ong 已发表定理的实例）。
3. 若将来要在此谱系找可立项题，仅三条窄路且必须先过 C9 全文层复审（nt-03 判例的深度线纪律：题录层止步会翻车）：① 一般 (a,b)-骑士（(1,3)/(2,4)）条带/小矩形 iff 刻画——需先用 kernel 可验证枚举定结论；② 多孔缺陷棋盘（删 ≥2 格）小实例；③ 环面小棋盘计数（OEIS 空白，circulantGraph 可直接形式化，但存在性刻画已被 Watkins–Hoenigman 1997 占位，只剩计数且需枚举引擎）。
4. 引用纪律：8×8 巡游数以 OEIS A001230（无向 13,267,364,410,532）为准，禁用讹传数字。

## 过程产物

- `tmp-probe/knight-3x4-tour.lean`（存在性 smoke，exit 0 / 白名单公理 / 0 sorry）
- `tmp-probe/knight-2x4-impossible.lean`（不可能性 smoke，exit 0 / 白名单公理 / 0 sorry）
- 三路查新工人报告（文献 / OEIS / 形式化）由主代理汇总入本记录；检索原始证据在各工人会话内。
- 预算：llm-call 0、compile 4（smoke 四轮：2+2，其中 3 轮失败均为形式化 API 摩擦并已修复）。

# 窄路深挖报告：骑士巡游谱系有无开题方向（2026-09-28）

> 任务 `tasks/20260928-knighttour-narrow/`（端点 zcode，L3a 进程链；节点 anthropic/stepfun/step-5-preview，model-detect L2 last* 回落）。
> 用户指令：「在候选窄路中做深入调研，确认有无开题方向」。承接 `tasks/20260928-knighttour-recon/recon.md` 建议 3 的三条窄路。
> 性质：只读取证 + kernel 冒烟 + 本机枚举。未走 SOP 01 全流程、未动题库/图谱机制层。
> 预算：llm-call 0、agent-run（agent-call.py）0、compile 4 轮（≤8 上限内）；三路文献查新由只读研究子代理完成（Worker token ≈ 7.6M/13.0M/9.9M，C9 检索类目不占预算，口径同 comb0709/nt-03 先例）。

## 结论（一句话）

**无开题方向**：三条窄路的「白面」在全文层查新下全部闭合或塌缩——(1,3)/(2,4) 被已发表定理判死（本机 kernel 独立复证）、一般 (a,b) 是领域公认的硬开放题、(1,4) 留两个已发表开放族、多洞棋盘 4×n 删两格已被 Srichote 解决、环面存在性平凡且连通性闭式与 Cayley 哈密顿定理合起来把哈密顿性榨干；**唯一潜在候选 = 洞条带远端双角巡游计数新序列**（OEIS 六变体零命中、计数非平凡），但它卡在 C1 边界裁决（巡游计数 vs 已放行的匹配计数）与递推可证性未验，不构成「选定即可执行」的开题项。

## 窄路①：一般 (a,b)-leaper

### 1.1 (1,3)/(2,4)：上轮「无专门刻画」的干净面是假象——二者平凡不可能，且死法已发表

- **数学事实**：a+b 偶 ⇒ 每步保持 (x+y) 奇偶 ⇒ 棋盘两色皆非空（m≥2, n≥1）时 leaper 图不连通 ⇒ 无哈密顿路径。(1,3) 与 (2,4) 的 a+b 分别为 4、6，均偶。
- **本机 kernel 取证**（`tmp-probe/leaper-color-invariant.lean`，compile 4 轮后 exit 0 / 0 sorry / 公理恰 [propext, Quot.sound]）：一般引理「a ≡ b (mod 2) 且两色皆非空 ⇒ 无哈密顿路径」完全证明（`SimpleGraph.fromRel` 构造 + 每步奇偶 `omega` + `reachable_iff_reflTransGen` + `Relation.ReflTransGen.head_induction_on` 可达性归纳 + `Walk.takeUntil` 从见证反推连通），并实例化 (1,3)、(2,4) 于任意 m×n。**该引理是本次深挖唯一的正产出，但其陈述已占位**——
- **文献占位（全文层，五处）**：
  - Knuth 1994《Leaper Graphs》（Math. Gazette 78:274–297，arXiv:math/9411240）**Theorem 1** 给出更强形态（连通性充要条件）："The graph of an {r,s}-leaper on an m×n board … is connected if and only if (i) r+s is relatively prime to r−s; (ii) n ≥ 2s; (iii) m ≥ r+s." 其证明第 (i) 条即本题观察（"any common divisor d of r+s and r−s will be a divisor of x+y …"）。
  - Beluhov 2022《Leaper Tours》（Advances in Combinatorics 2022:4，arXiv:2104.13017）："When p+q is even, L cannot tour any board since it only visits cells of the same colour…"
  - Chia–Ong 2005 Theorem 2(i)：闭巡游必要条件 "a+b is odd"。
  - Kamčev 2014（EJC 21(1) #P1.31，arXiv:1311.4109）：(a,1) 情形 "for odd a this is plainly impossible since the graph has two connected components…"
  - 民间层：Jelliss（camel "confined to cells of one colour"）。
- **处置**：练习靶素材（一般引理形式化干净，可作回归测试）；不得单独立项（陈述已发表）。**方法教训**：leaper 候选捞取前必须先查 a+b 奇偶——偶者直接出局，「无专门刻画」不等于「有待刻画」。

### 1.2 一般 (a,b) 矩形刻画：领域公认未决且被判「大概率不可行」

- Kamčev 2014 引言逐字："We do not know what happens for general (a, b) knights."（并附 EGG 猜想：gcd(a,b)=1 且 a,b 不全奇 ⇒ 充分大偶板 [n]^d 有巡游。）
- Beluhov 2022 将该完整刻画立为 Question D 并判断："The answer to Question D probably will not be tractable in the general case."
- 分族现状：**(2,3)**（zebra）5k×n 闭巡游完全刻画 = Chia–Ong 2005 Thm 10（全文级转述核证）+ 5p×n 开巡游完全刻画 = Yusof–Ong–Wong 2026（仅摘要级）；**(1,4)**（giraffe）Bullington–Eroh–Roth–Winters 2022（São Paulo J. Math. Sci. 16:893–914，Springer 全文实读）近完全分类，**留下两个已发表开放族**："it is still an open question whether the following boards have a {1,4}-leaper tour: (1) 5×n board, for n ≥ 18 with n even and n ≠ 24+8t …; and (2) 11×n board, for n ≥ 22 with n even and n ≠ 4t where t ≥ 6 and t ≠ 7, 11."；**(2,5)/(3,4)/(1,6)** 仅最小板/零星结果（Knuth {1,2k} 族定理、Dawson 方法、Jelliss、Kamčev 大板存在性、Beluhov Thm 2「两边偶且充分大 ⇒ 有巡游」）。
- **对流水线的含义**：(1,4) 的两个开放族是真开放题，但属研究级（90+ 格棋盘、C2 要求结论可机定、解答即新数学）——不是可开题项；其余均为 Beluhov Question D 难度的开放方向。

### 1.3 附：单色类 subtour 缝隙（camel 单色巡游）

- (1,3)/(2,4) 的**非平凡版本**（只在单色类上巡游）期刊层无完整刻画：Jelliss 民间结果（"On 5×n boards no camel tours are possible except for 5×5 and 5×7"）+ Dawson 45° 旋转归约（camel 单色图 ≅ 变换板上的 knight 图——坐标 (x,y)↦((x+y)/2,(x−y)/2) 把 {1,3} 步变成 {1,2} 步，但变换板是菱形而非矩形，Schwenk 不直接适用）。
- 判定：真空白但零起点、无机器可定结论，不开题。

## 窄路②：多洞缺陷棋盘（删 ≥2 格）

### 2.1 文献占位（全文层）

- **单删格已占位**：DeMaio–Hippchen 2009（Math. Mag. 82:219–225，全文）tour number T(m,n) = 最少删格数（T(4,n)=2 ∀n≥4；T(3,4)=T(3,8)=2；T(3,5)=3；T(3,6)=4；T(2,n)=2n−2），并明示位置无关性不是重点；Miller–Farnsworth 2013（OJDM 3:56–59，全文）3×n 删一格闭巡游完全分类（Lemma 1/2 逐格清单）。
- **删恰好两格：4×n 已占位**——Bi et al. 2015（Involve 8:615–627，全文）提出问题+猜想；**Srichote 2020（Chula 博士论文，摘要+Chapter I 级）与 Srichote–Boonklurb–Kaewwannarat–Singhun 2022（Thai J. Math. 20:64–81，zbMATH 评审级：'determines all positions of those two squares' 且 'solves Bi, Butler, DeGraaf and Doebel's conjecture'）已完全解决 4×n 删两格分类**。
- **其余多洞情形零发表**：3×n 删两格、5×n、m,n 皆奇、删 ≥3 格——无任何系统理论；OEIS 无任何删格巡游计数条目（连单删格也没有；本报告对具体序列又做了六变体核查，见 2.2）。
- **一般判定问题 NP-完全**：McGown–Leininger 2002（OSU REU 论文集，全文）"The knight's tour problem with holes is NP-complete"（归约自 Itai–Papadimitriou–Szwarcfiter 1982 网格图哈密顿性）。
- Chia & Ong 无 deficient boards 论文（上轮 recon 的猜测不成立，已证伪）。

### 2.2 本机枚举新发现：洞条带远端双角计数序列（未注册、非平凡）

用自写巡游计数器（先以无洞 3×n 开巡游对 OEIS A169696 做判别力校验：n=1..10 全部 10/10 一致，含 3×4=8、3×6=0、3×10=3048）：

**配置：3×n 删 (0,0) 与 (2,n−1)（远端双角）**

| n | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|
| 开巡游（无向） | 1 | 6 | 0 | 0 | 351 | 602 | 1536 | 6534 | 45619 |
| 闭巡游（无向） | 0 | 0 | 0 | 0 | 5 | 0 | 2 | 0 | 220 |

- 闭巡游仅偶数 n 非零（3n−2 偶 ⇔ n 偶，与二部约束一致）；开巡游在 n=6,7 为零（与无洞 3×n 的 a(6)=0 现象平行）。
- **OEIS 独占性**：序列 `1,6,0,0,351,602,1536,6534,45619` 及变体 `351,602,1536,6534,45619`、`1,6,351,602,1536,6534,45619`、奇数子列 `6,602,6534`、偶数子列 `1,351,1536,45619`、倒序——**六个查询全部零命中**（fmt=json 返回 null）。结合 2.1 的文献零发表，该计数序列**查无占位**。
- 其余三配置退化：删两端角 (0,0),(2,0) 仅 n=9(96), 11(880) 非零；删 (0,0),(0,2) 仅 n=9(4), 11(56)；删中行 (1,0),(1,2) 全零。
- 数据诚实边界：单实现枚举（计数器经 OEIS 10/10 校验，holes 只改点集）；n≥13（37 格）当前回溯枚举超时——若立项必须先换 DP 枚举器并做异构复算（mossad-50 DEF 族教训）。

### 2.3 该候选为何不构成「可开题项」

1. **C1 边界未裁**：2026-09-27 闸门一放行的是「缺陷/非常规参数图族**匹配**计数」；巡游计数（哈密顿圈计数）是另一族统计量，且经典棋盘巡游计数属排除区（OEIS 全挂名）。洞条带巡游计数是否可按挑战档条件放开，须用户/闸门一裁决——本报告不代为放开。
2. **递推可证性未验**：mossad 批的可立项形态是「枚举猜递推 + Lean 归纳证明」；巡游计数的递推证明需 transfer-matrix/extender 归纳论证（Miller–Farnsworth 的 3×4 extender 是存在性版的类似结构），工作量与可行性均未标定。
3. **数据深度不够**：猜递推需 n≥15~20 的项，当前枚举器到 n=12。

## 窄路③：环面

- **存在性：平凡且已占位**。Watkins–Hoenigman 1997（Math. Mag. 70(3):175–184，JSTOR 全文 OCR 实读）："THEOREM. On a torus, every rectangular chessboard has a knight's tour."——所有 (m,n) 无一例外；1×n/2×n 有显式构造。同伦类细化 = Forrest–Teehan 2015（arXiv:1507.02917，全文）；圆柱分类 = Watkins 2004 p.71（"unless m = 1 and n > 1, or m = 2 or 4 and n is even"）。
- **连通性：闭式已发表**。矩形版 = Knuth 1994 Thm 1；**环面版 = Seleznev 2026（TU Delft 学士论文，全文）Thm 5.10**：T_{p,q}^{m,n} 连通 ⟺ gcd(mn, np, nq, mp, mq, 2pq, q²−p², p²+q²) = 1（证明 = 周期格 ∧ 走法格的并 + Lemma 5.9 指数 = gcd|det|，即 Smith 标准形路线；查新工人用 BFS 对该判据做了数十组独立复算，零失配）。注意发表层级：学士论文未经同行评审，但公开存档可引、证明完整。
- **哈密顿性：免费塌缩**。「有限阿贝尔群上连通 Cayley 图（顶点数 ≥3）皆哈密顿」是**已发表定理**：Marušič 1983（Discrete Math. 46:49–54）；强化版 Chen–Quimpo 1981（LNM 884:23–34，价 ≥3 时强哈密顿）。环面 leaper 图 = Z_m×Z_n 上 Cayley 图 ⇒ **连通 + mn≥3 ⇒ 有哈密顿圈**（工人机器验证：(p,q) ∈ {(1,2),(1,3),(2,3),(1,4),(2,5),(3,4),(3,5)}、m,n ≤ 7 全部连通图零违反；唯一非哈密顿连通情形 mn=2 即 K₂）。故「环面 (a,b)-leaper 巡游存在性」= Seleznev 连通性判据 + 一行推论——**两个前提均已发表，该综合不构成开放题**（按 C9 纪律记「已占位（可推导）」）。Seleznev 文中「哈密顿性仍是开放方向」的表述因未引 Chen–Quimpo 而偏保守。
- **计数：真空白但撞 C1**。OEIS ~14 变体零命中、文献无系统枚举（唯一数据点 = Tylor 1982 Chessics #14：2×2 环面 17 条几何不同巡游；Jelliss 2012：4×4 环面无 magic）。空白是骑士图特有的——环面**网格图** C_n×C_n 的哈密顿圈计数已在 OEIS（A396483 等）。开工需先建枚举引擎，撞大规模有限枚举排除线。

## 对流水线判据的映射（汇总）

- **C9（独占性）**：三条窄路的可判定子问题全部「已占位」或「已占位（可推导）」；唯一「查无占位」= 洞条带远端双角计数序列（2.2）。
- **C1**：计数类候选（环面计数、洞条带计数）均触大规模枚举排除线的边界；2026-09-27 放行口径只覆盖匹配计数。
- **C2**：开放族（(1,4) 5×n/11×n、一般 (a,b)、多洞非 4×n）结论不可机定，排除；可机定的又都是已发表实例。
- **C4**：存在性-by-见证 = decide 主导（退化高风险）；不变量类（本次 smoke）非退化但陈述已发表。
- **价值分级**：保色引理 = 首个形式化级（不单独立项）；洞条带计数序列 = 若成立则「新序列」级（但前置条件未满足）。

## 建议（按优先级）

1. **不开题、不入库**：本报告 + run-state 条目即处置结论；三条窄路全部关闭，避免重复调研。
2. **唯一待观察候选（不获授权不开工）**：洞条带远端双角开巡游计数序列（2.2）。若将来要推进，前置义务按序：① 用户/闸门一裁 C1 边界（巡游计数是否可按挑战档放开）；② 换 DP 枚举器补 n=13..20 并做异构复算；③ 猜递推 + 评估 Lean 归纳证明工作量；④ 立项前按 nt-03 深度线纪律对该具体族做第四轮 C9 全文复审。
3. **练习靶留档**：`tmp-probe/leaper-color-invariant.lean`（一般保色引理，非退化 tactic 密度靶；陈述已发表，禁单独立项）；连同 recon 的两个 smoke（3×4 存在性 / 2×4 不可能性）共三个练习靶。
4. **查新纪律增量（建议入 SOP 01 查询纪律，待用户裁决）**：leaper 族候选捞取前必须先做 a+b 奇偶预检（偶 ⇒ 保色 ⇒ 已发表死判）；并先读 Beluhov 2022《Leaper Tours》（该族组织性综述，Questions A–D 框架）+ Knuth 1994《Leaper Graphs》（连通性/最小板通形）——本谱系 90% 的「白面」在这两篇里已有归属。

## 过程产物

- `tmp-probe/leaper-color-invariant.lean`（一般保色引理 smoke：exit 0 / 0 sorry / 公理 [propext, Quot.sound]）
- `enum/holed-tour-counts.txt`（四配置 × n=3..12 计数原始输出；计数器对 A169696 10/10 校验）
- `enum/tour_count.py`、`enum/holed_count.py`（枚举器与洞配置计数脚本）
- 三路文献查新工人的全文级证据在各工人会话内；关键逐字引文已转录入本报告。
- 通道挂账：arXiv API 两路工人均不可用（空 feed/429）；r.jina.ai 本环境不可达；ScienceDirect/Cambridge Core 403；Chia–Ong 2005 PDF 原文不可得（Exa 索引全文 + Singhun 2020 全文转述双源核证）；Srichote 期刊版全文不可得（zbMATH 评审级）；Beluhov 2022 仅摘要+前作片段。均不影响四态裁决（关键结论有全文或多源支撑）。

# 洞条带远端双角巡游：开题可能评估报告（2026-09-28）

> 任务 `tasks/20260928-holestrip-tourcount/`（端点 zcode，L3a 进程链；节点 model-detect L2 current* = `anthropic/a6api-main/kimi-k3`）。
> 用户指令：「展开挖掘你说的'潜在项'……继续挖掘开题可能」（承接 `tasks/20260928-knighttour-narrow/report.md` §2.2/§2.3 的唯一条件候选）。
> 性质：只读取证 + 本机枚举 + kernel 冒烟。未走 SOP 01 全流程、未动题库/图谱机制层、未做 C1 边界裁决（属用户/闸门一）。
> 预算实耗：llm-call 0、agent-run 0、compile **超支如实记**——卡面 ≤8，本冒烟跨两会话累计 ≥14 次调用（上轮 ≥10 + 本轮 4，其中本轮 3 次完成 + 1 次中断取消），根因是 Lean v4.34/mathlib v4.34 API 漂移调试（实例合成不展开常规 def、`notMem` 下划线改名、decide 引理形态变化）未进 ≤8 的设计面；冒烟终轮本身一次通过。明细见 `budget.log`。C9 第四轮由后台只读工人完成，检索类目不占预算（口径同 comb0709/nt-03 先例）。

## 结论（一句话）

**三个已知阻塞点，两个已解决、一个翻案为「可证核心转移」——候选从「卡住」变为「只剩用户一道 C1 裁决」**：枚举深度已解决（插头 DP + 异构复算，数据到 n=220）；递推可证性以负面方式解决（无 ≤38 阶线性递推 ⇒ mossad 式「猜递推 + Lean 归纳」形态不适用），可证核心转移为**存在性刻画**——开巡游存在 ⟺ n ∈ {4,5} ∪ {n≥8}，闭巡游存在 ⟺ n 偶 ≥ 8——且该核心的 kernel 可行性已由 Lean 冒烟实证（n=6 不可能性强迫边不变量的一个整子情形完全证明、公理恰白名单）；C9 第四轮全文层复审维持**查无占位**。唯一未决 = **C1 边界**（缺陷棋盘上的巡游存在性/计数能否按挑战档准入），属用户/闸门一裁决，本报告不代为放开：裁「放开」即可开题（立题形态见 §8 选项 A/B），裁「不放开」则维持窄路报告的关闭结论。

## §1 三个阻塞点的处置

| 窄路报告 §2.3 的阻塞 | 本次处置 | 状态 |
|---|---|---|
| ① C1 边界未裁 | 精化为可执行裁决问题（§8），**未代为放开** | **未决（等用户/闸门一）** |
| ② 递推可证性未验 | Hankel 逐阶求解 + 留出验证：开序列 77 项无 ≤38 阶、闭偶数子列 37 项无 ≤18 阶线性递推 ⇒ 无可猜递推；可证核心转移为存在性刻画，kernel 可行性已冒烟（§4–§5） | **已解决（负面+转移）** |
| ③ 枚举深度不够（回溯器 n≥13 超时） | 换插头 DP（断面包线/转移矩阵），OEIS 10/10 + 回溯器 20/20 双重判别力校验，数据到 n=220（§2） | **已解决** |

## §2 数据深度（阻塞③：已解决）

**枚举器**：自写插头 DP（`enum/plugdp.py`）——按列推进，维护 9 格断面前沿（列 c/c+1/c+2 × 3 行）上的插头与带符号连通分量标签（正 = 常规分量 2 开放端；负 = pe 分量 1 开放端 + 1 度 1 顶点），每条哈密顿路径/圈作为边集被恰好计数一次（无向、不分方向）。列型：T_first（列 0，洞 (0,0)）/ T_mid（列 1..n−4）/ T_mid_hole（列 n−3，禁连洞 (2,n−1)）/ T_penult（列 n−2）/ T_last（列 n−1，洞 (2,n−1)，最后非洞格为行 1）。

**数据可信链（三重独立佐证，mossad-50 DEF 教训口径）**：
1. **对 OEIS 判别力**：无洞 3×n 开巡游 vs A169696（offset 1）n=1..10 全部 10/10 一致（含 3×4=8、3×6=0、3×10=3048）。
2. **异构复算**：与独立回溯枚举器（`enum/holed_count.py`，不同算法）在洞配置 n=3..12 开+闭共 20/20 一致。
3. **状态图前向验证**：状态图可达性判据与计数 DP 的存在性模式逐 n 一致（PASS）。

**数据规模**：diag 配置（删 (0,0) 与 (2,n−1)）开巡游 n=4..220 共 **217 项**（n=4..80 见 `enum/diag-counts-n4-80.txt`，n=81..220 见 `enum/deep-open.txt`，140 项大整数）；闭巡游仅偶数 n 非零（n=4..220 共 109 项：n=4..80 在 `enum/diag-counts-n4-80.txt`，n=81..220 在 `enum/deep-closed.txt`）。前 27 项（n=4..30）：

```
开：1, 6, 0, 0, 351, 602, 1536, 6534, 45619, 105968, 449732, 1412744, 6864471,
    18811736, 81702132, 246547030, 1062396387, 3147044492, 13035207408, 39992893136,
    161950123967, 500445060460, 1980429246576, 6229007448334, 24185552967047,
    76874310140080, 293598163166548
闭（偶数 n）：n=8: 5, n=10: 2, n=12: 220, …（奇数 n 恒 0）
```

**六角配置对照**（`enum/diag-counts-n4-80.txt` 末节，n=4..30）：删上行两角 (0,0),(0,n−1) ≡ 删下行两角（行反射自同构，数据逐项相同）；删左列两角 (0,0),(2,0) ≡ 删右列两角（列反射），且仅奇数 n≥9 非零（两洞同色 ⇒ 色类不平衡 2）；删远端双角 (0,0),(2,n−1) ≡ 删另一对角 (0,n−1),(2,0)。**观察**：上行两角配置与 diag 配置在 n=10、11 计数恰好相同（1536、6534），其余 n 接近但不相等（如 n=8：348 vs 351；n=12：45614 vs 45619）——两洞集无图自同构关联（同行 vs 不同行），记为数值巧合，不作主张。

**增长常数（机器锁定）**：T_mid 转移状态图（可达集 R，2567 态）中「可达且可完成」子图 can = R ∩ Z\*（1956 态）的谱半径（幂迭代 + numpy 双算法）**ρ = 3.450592**，与观测 a(n+1)/a(n) = 3.4470–3.4554（n=81..86）吻合到小数点后两位。主控分量 = 511 态强连通分量（另三个非平凡 SCC：609/323/304 态，ρ = 3.119490/2.736300/3.119490；早期按大小误取 609 态分量，已由幂迭代判别性复算纠正，`enum/spectral2.py`、`spectral3.py`）。

## §3 存在性刻画（本次最重要的正产出）

**定理（机器双向验证：计数 DP + 状态图可达性，两法逐 n 一致）**：
- **开巡游存在 ⟺ n ∈ {4, 5} ∪ {n ≥ 8}**；
- **闭巡游存在 ⟺ n 偶且 n ≥ 8**。

- 闭的「仅偶数 n」有干净理论解释：骑士图二部（色 = (r+c) mod 2），洞 (0,0) 色 0、洞 (2,n−1) 色 (n+1) mod 2；n 偶 ⇒ 两洞异色 ⇒ 3n−2 顶点两类平衡（圈才可能）；n 奇 ⇒ 两洞同色 ⇒ 色类差 1 ⇒ 无哈密顿圈（路径仍可能）。
- 开巡游 n=6,7 为零是**非平凡**的：结构分析（`enum/struct_analysis.py`）显示 n≥5 图 2-连通、最小度 2——无桥、无割点、无度 1 顶点，一切标准不变量都不杀人，必须用强迫边级联（§4）。
- 小 n：n=3 图不连通（3 个连通分量，平凡无巡游）；n=4 连通但有桥/割点，且 (1,1)、(1,2) 两个度 1 顶点把唯一那条开巡游的两个端点钉死（这也解释了 n=4 闭巡游为 0：端点不相邻）。

## §4 零值结构与 kernel 冒烟（阻塞②的第一半；C4 可行性实证）

**n=6/7 不可能性证书（Python，机器可复算）**：固定端点集枚举 + 强迫边传播（R1 饱和：度达目标则禁其余；R2 强迫：缺口恰等于可用则全强迫；R3 缺口大于可用则死；R4 未完成即成环则死）——`enum/cert_n6.py` 对全部端点集（|E| ∈ {0,1,2}）穷举：n=6 证明树 137 节点、n=7 共 235 节点，无一幸存。证书形态 = 有限情形穷举 + 确定性传播，**可机械化**。

**Lean kernel 冒烟（`tmp-probe/holed3x6-forcing.lean`，终轮 exit 0 / 0 sorry / `#print axioms` = [propext, Classical.choice, Quot.sound] 恰白名单）**：证明了 n=6 不可能性的一个整子情形——

> 若三个度 2「帽顶点」(1,0)、(2,1)、(1,4) 均不是路径端点，则不存在哈密顿路径。

证明链：①`incCount_upper/lower`（哈密顿路径中顶点 v 的路径边数 + 端点修正 = 2·出现次数，路径结构归纳）；②`incCount_internal_two`（非端点恰 2 条路径边）；③`edges_nodup_of_hamiltonian`（哈密顿 ⇒ 边表无重）；④`force_edge`（度 2 内部顶点的两条邻居边必进边表，经 toFinset 基数 2 的集合论证）；⑤三个帽顶点各被迫用掉通往 (0,2) 的边 ⇒ (0,2) 路径边 ≥ 3，与上界 2 矛盾。

**意义（对开题决策）**：这证明了该族「零值证书」在 Lean 侧的证明机制跑得通（walk 边计数 + 强迫边 + 集合基数，全部 mathlib v4.34 原生 API），C4 非退化 tactic 密度真实存在（不是 decide 秒杀型）。**未覆盖部分（如实记）**：其余端点集情形（帽顶点做端点、n=7、n=4 闭巡游）目前只有 Python 证书，尚未 Lean 机械化。

## §5 周期性构造（阻塞②的第二半：n≥8 方向可证）

状态图分析（`enum/stategraph.py`）在「A 可达且 Z 可完成」子图 can（1956 态）中发现 **4 个 T_mid 自环状态 + 4 个非平凡强连通分量**（609/511/323/304 态）⇒ 存在经过中段列型环路的周期构造 ⇒ 所有充分大 n 的巡游存在性可由归纳证明（n 列巡游 + 固定延拓器 ⇒ n+k 列巡游）。见证巡游抽取（`enum/witness.py`）显示 n=8..12 的巡游共享前缀（位置 0..18 跨 n=9,11,12 相同），与「中段周期延拓」图像一致。

**未覆盖部分（如实记）**：周期构造目前是机器证据（环存在 + 见证存在），**尚未提炼成人类可读的固定延拓器（extender）并给出 gluing 归纳的 Lean 证明**——这是 §8 立题后的主要技术工作。

## §6 递推性（阻塞②：负面解决）

`enum/recurrence_solve.py`（Hankel 系统逐阶高斯消元 mod 2^61−1，通过全序列留出验证才认账）：开序列 77 项（n=4..80）**不存在 ≤38 阶**线性递推；闭偶数子列 37 项不存在 ≤18 阶。结合 §2 谱半径分析（主控 SCC 511 态、ρ = 3.450592），结论明确：**该序列是转移矩阵级统计量，不是小递推级**——mossad-50 批「枚举猜递推 + Lean 归纳证明」的可立项形态对本候选**不适用**。这推翻了窄路报告 §2.3 阻塞②背后隐含的立题形态，把可证核心转移到存在性刻画（§3–§5）。

## §7 C9 第四轮文献复审：维持查无占位

后台只读工人完成第四轮全文层查新（`c9/literature-round4.md`）：**3×n 删两格（任意两格）的巡游计数/存在性无任何发表工作**——Miller–Farnsworth 2013（OJDM 3:56–59）只到删 1 格；Srichote 2022（Thai J. Math. 20:64–81，全文实读）只解决 4×n 删恰好两格的闭巡游分类；Bi et al. 2015 是 4×n 两格的问题+猜想。OEIS 侧：开序列及奇/偶子列、倒序等变体零命中（延续前三轮，累计 50+ 独立查询串）。Lean/形式化侧：无同形定理。**四态裁决 = 查无占位**（维持前三轮）。

## §8 C1 边界：待用户/闸门一裁决的问题（本报告不代为放开）

2026-09-27 C1 精确化：排除 = 「已挂名经典图族**计数** + 双射构造」；缺陷/非常规参数图族**匹配**计数按挑战档**条件放开**。本候选落在缺口：

- 无洞 3×n 骑士巡游计数是挂名经典（OEIS A169696 等，排除区）；
- **删两角的缺陷变体既无挂名也无发表**（C9 四轮查无占位）——但它统计量族是「哈密顿路径/圈计数」，不是当时放行的「匹配计数」。

需要裁决的精确问题：**挑战档的条件放开是否扩展到「经典棋盘几何（骑士图）上的缺陷参数变体」的 (a) 存在性刻画 与 (b) 计数序列？** 三个选项（选定即可执行）：

- **选项 A（放开存在性、计数仅作辅助数据）**：立题 = §3 定理的完全 Lean 机械化。工作组件：n≤5 小情形（n=3 不连通、n=4 度 1 顶点钉端点 + 小穷举、n=5 见证）；n=6/7 强迫边证书全情形机械化（Python 证书 137/235 节点为蓝本，冒烟已证最难子情形）；n≥8 周期延拓器提炼 + gluing 归纳；闭巡游侧（二部不平衡 + n=4 单独 + 偶数 n≥8 闭周期构造）。粗估 500–1500 行 Lean，设计成本为主，属「小型分类定理」工作量（对标 Miller–Farnsworth / DeMaio–Hippchen 层级结果）。C2 满足（iff 结论可机定）；C4 混合——见证侧有 decide 成分，定理整体是真归纳非退化。
- **选项 B（存在性与计数都放开）**：在 A 之上追加计数序列主张（217 项新序列 + 谱半径 3.450592 的转移矩阵解释），需按 SOP 08b 路由评估 OEIS 提交路径（实名/署名策略冲突在案，同首批占位包遗留问题）。
- **选项 C（不放开）**：巡游族整体留在排除区（无论有无洞），本候选归档关闭，与窄路报告结论一致；本次全部产物（枚举器/数据/证书/冒烟）留档作将来复活素材，复活须用户显式指令。

## §9 价值评估（按宪条 4 措辞，不越级）

- **存在性刻画（若立项）**：一个新发表的有限分类定理（阈值结构 {4,5} ∪ {n≥8}），零值侧证明非平凡（2-连通图上强迫边级联），存在侧有周期构造——按 C9 四轮证据，该具体族无占位。价值级 = **小型原创分类结果**（非「首个形式化」级——没有已发表定理可形式化；也非「新序列·新递推」级——递推不存在）。
- **计数序列**：新序列级（查无占位、转移矩阵级增长），但**无小递推**使其不进入 mossad 批的双新档。
- **练习靶**：`tmp-probe/holed3x6-forcing.lean` 本身是非退化 tactic 密度靶（walk 边计数 + 强迫边不变量），可留档；连同窄路任务的三个 smoke 共四个练习靶。

## 过程产物

- `enum/plugdp.py`（插头 DP，含 validate）、`enum/diag-counts-n4-80.txt`（diag 配置 n=4..80 开/闭 + 六配置对照）、`enum/deep-open.txt` / `enum/deep-closed.txt`（n=81..220）
- `enum/struct_analysis.py`（桥/割点/度）、`enum/stategraph.py`（状态图 + SCC）、`enum/spectral.py` / `enum/spectral2.py` / `enum/spectral3.py`（谱半径：初版 + 幂迭代/Kosaraju 判别性复算）、`enum/cert_n6.py`（n=6/7 强迫边证书）、`enum/witness.py`（见证巡游）、`enum/recurrence_solve.py`（Hankel 递推探测；`recurrence.py`/`recurrence_fast.py` 为被取代的早期版本，留档）
- `c9/literature-round4.md`（第四轮全文层查新）
- `tmp-probe/holed3x6-forcing.lean`（kernel 冒烟：exit 0 / 0 sorry / 公理恰白名单）
- 预算与超支记账：`budget.log`（compile ≥14 次超卡面 ≤8，如实报告）
- 全部未 commit（遵用户规则）

# C9 第四轮独占性查新：3×n 删双远角棋盘骑士巡游（开=哈密顿路径、闭=哈密顿圈）计数与存在性

> 任务 `tasks/20260928-holestrip-tourcount/`（端点 zcode；节点 anthropic/a6api-main/kimi-k3，model-detect L2；本轮 llm-call 0 / agent-run 0 / compile 0，C9 检索不占预算）。
> 性质：只读取证（外网检索 + 全文抓取），未改任何仓库文件；本报告为唯一写盘产物。
> 承接：`tasks/20260928-knighttour-narrow/report.md` §2.1–2.3（前三轮：Srichote 2022 仅到 zbMATH 评审级、洞条带计数序列 OEIS 六变体零命中）。
> R-15 纪律执行情况：本轮把前三轮唯一的「评审级」最近邻（Srichote 2022）升级到**全文逐字级**；其余带 shifted/variant/deficient/removed 类变体词的命中（DeMaio–Hippchen、Miller–Farnsworth ×2、Bi et al.、Srichote 学位论文）全部抓全文或机构仓储页核到引言/结论/定理清单；参考文献最近邻（Miller–Farnsworth 2013 期刊版、Bi et al. 2015）本轮全文实读。

## 0. 结论摘要

**C9 四态裁决：查无占位**（文献层 + OEIS 层 + 形式化生态层三方零命中，且最相邻文献均已在全文层核清边界）。三条硬事实：

1. **Srichote 2022 全文到手并逐字核验：只覆盖 4×n 删两格闭巡游，全文仅两处出现「3 × n」（均为引用 Miller–Farnsworth 的单删格工作），结论章的 future work 是「广义 (a,b)-骑士步的删格版」，完全未提 3×n 双删格，也未提任何巡游计数。**
2. 3×n 删两格（含两角配置）的存在性刻画与巡游计数：期刊/会议/学位论文/预印本/竞赛/MSE/民间文献（Jelliss Knight's Tour Notes 全站索引 + 3×n/4×n/holey 各页）**零发表**。
3. OEIS 无任何删格巡游计数条目（15+ 查询 + 全部 knight tour 条目的关键词扫描），A169696/A169764/A070030 评论区无删格推广记载；Lean 4 / Isabelle AFP / Coq / Mizar 无 deficient board 骑士巡游形式化成果。

残余风险（不推翻裁决、但立项时须挂账）：Jelliss 2019《Knight's Tour Notes》12 卷专著与 Chessics 杂志未逐页检索（其网站镜像已核，无删格 3×n 内容）；Van Rees 1997/2007 3×n 课堂笔记仅题录级；StackExchange API 被 IP 限流未能穷举 MSE。

---

## 1. Q1：Srichote 2022 全文到底覆盖什么（最高优先级，已答）

### 1.1 文献定位（全文层）

- Srichote, W.; Boonklurb, R.; Kaewwannarat, T.; Singhun, S. **Closed Knight's Tours on 4 × n Chessboards with Two Squares Removed**. *Thai Journal of Mathematics*, Special Issue (2022): Annual Meeting in Mathematics 2021, pp. 64–81, published 2022-01-31.
- 文章页（含 PDF  galley）：https://thaijmath.com/index.php/thaijmath/article/view/1274 ；PDF 直链：https://thaijmath.com/index.php/thaijmath/article/download/1274/1285 （6.9 MB，8 页，本轮已下载并逐页提取文本）。
- zbMATH：Zbl 1538.05160（https://zbmath.org/7732586），MSC 05C45/05C90。
- 注：旧刊址 thaijmath.in.cmu.ac.th 已 301 至 thaijmath2.in.cmu.ac.th 且全站 404（见 §5 通道清单）；thaijmath.com 为现行站点，检索 "Srichote" 得两篇（本篇 + 2020 ringboards 篇），确认无第三篇删格论文。

### 1.2 全文逐字证据

**范围声明（引言， reconstructed quote；该 PDF 字体 ToUnicode 映射部分损坏，引文为人工复原，数学符号与数字可靠）：**

> "Consequently, in 2013, Miller and Farnsworth (9) determined the exact position of the one square to be removed from CB(3 × n) where n ≠ 5 so that a CKT exists. While, in 2016 [sic — Bi et al. 为 2015 年刊出，原文如此], Bi et al. (2) determined the exact position of the one square to be removed from CB(m × n) where m, n ≥ 3 are odd and (m, n) ≠ (3, 5) so that a CKT exists. In (2), they also tried to consider the exact positions of two squares be removed from CB(4 × n), where n ≥ 3. […] Therefore, the aim of this article is to prove the Conjecture 1 in Section 3 and also determine the exact pair of squares removed from CB(4 × n) for 3 ≤ n ≤ 6 in Section 4."

**结论与展望（§8 Conclusion and Discussion，reconstructed quote）：**

> "The main result of this paper is to find all positions of 2 squares on CB(4 × n) so that after deleting these squares, then there exists a CKT on the deficient board. This result for n ≥ 7 proves the Conjecture 1. However, this CKT is constructed using the knight's move. In 2005, Chia and Ong (6) defined the generalized knight move or (a,b)-knight move […] Therefore, as a future research, if we consider some CB(m × n) for which a CKT from the generalized knight move does not exist, then we can investigate the minimum number of squares to be removed and a CKT from the generalized knight move exists on the deficient board as well as the exact positions of these squares to be removed."

**机械化核验（对全文提取文本做 grep，防漏读）：**

- 「3 ×」在全文出现 **2 次**：引言引用 Miller–Farnsworth 一处 + 参考文献清单一处。其余 "(3, …)" 均为 4×n 棋盘内的行坐标（第 3/4 行），非 3×n 棋盘。
- 全文无 "enumerate/count/number of/how many" 任何计数词汇——该文是纯存在性分类。
- 主定理（Theorem 2.1，reconstructed）：n ≥ 7 时，任取一黑一白且均不在中间两行的格子对 A ∈ S_n，CB(4×n)−A 有闭巡游；3 ≤ n ≤ 6 的精确可删格对在 §4 逐个列出。引理 1.4 给出通用必要条件：ω(G−S) > |S| ⇒ 无哈密顿圈；ω(G−S) > |S|+1 ⇒ 无哈密顿路径。

**结论（Q1）**：Srichote 2022 = **4×n 删两格、闭巡游、全部位置分类**，全文层坐实。3×n 双删格既不在其范围内、也未列为 open/future work（其 future work 是 (a,b)-leaper 的删格版）；巡游计数完全不在其议题内。前三轮「zbMATH 评审级」的挂账项据此关闭。

### 1.3 佐证：Srichote 2020 博士论文（Chula ETD 383）

- 题录与摘要、目录、第一章引言（Exa 抓取层）：https://digital.car.chula.ac.th/chulaetd/383/ ，DOI 10.58837/CHULA.THE.2020.300。
- 目录（逐字）："3.3 CKTs on CB(4 × n)-A … 3.3.1 CKTs on CB(4 × n)-A where 3 ≤ n ≤ 6 … 3.3.2 CKTs on CB(4 × n)-A where n ≥ 7 … IV CONCLUSION AND DISCUSSION … 70"——删两格部分同样只到 4×n；第二章 2.3 是 CB(m×n) 删**一格**的开巡游。
- 引言（逐字）："the second goal of this dissertation is to prove the Conjecture 1 in Section 3.3.2 of Chapter III and also determine the exact pair of squares removal from CB(4 × n) for 3 ≤ n ≤ 6 in Section 3.3.1 of Chapter III."
- 挂账：论文 PDF（https://digital.car.chula.ac.th/cgi/viewcontent.cgi?article=1382&context=chulaetd）被 Cloudflare 挑战拦截（403），**Chapter IV 结论章未读到**；但期刊版全文结论章已到手且范围一致，该挂账不影响裁决。

---

## 2. Q2：3×n 删两格（尤其删两角）有无已发表结果——零命中

### 2.1 检索通道与查询（全部实做，返回逐字可查）

| 通道 | 查询/动作 | 结果 |
|---|---|---|
| Exa web_search | "3xn board two squares removed existence classification"、"deficient chessboard knight tour 3×n two squares"、""3 x n" chessboard "two squares" removed knight tour"、""deficient 3 x n chessboard" OR "3 x n chessboard with two squares removed" OR "knight tour with two holes""、knight tour deficient board holes 3 by n、math stackexchange knight tour 3xn two squares removed、knight tour corners removed board recreational、knight tour graph theory bulletin ICA two vertices deleted、Chinese "骑士巡游 3乘n 棋盘 删除 两个方格"、Putnam/IMO knight tour removed squares 等 ~15 组 | 全部只返回已知最近邻（下表），无本族命中 |
| OEIS JSON API（本地代理） | 序列 1,6,0,0,351,602,1536,6534,45619 及子列/倒序；闭巡游变体 0,0,0,0,5,0,2,0,220；关键词 deficient chessboard knight / knight tour board squares removed / knight tour holes / 3xn board two squares removed / chessboard with two squares removed / board with holes knight / knight tour two cells removed / removing squares chessboard tour / knight tour one square removed / deficient board tour / knight tour deficient | 序列查询全部返回字面 `null`；关键词查询仅一条无关命中（A006067 = n×n 棋盘四分拆，非巡游） |
| OEIS 全条目扫描 | 取 "knight tour" 检索命中的全部条目（A001230/70030/140519/140521/165134/186441/297666/368499/289204/366778/169696/169764/169777/169770-772/118067/79137/306281/306283/328909…），对 name+comment 做 removed/hole/deficien/missing/punctur 关键词扫描 | **零条目**涉及删格巡游 |
| A169696 / A169764 / A070030 评论区 | 逐条读 comment | 只引 Knuth "Long and skinny knight's tours"、Jelliss、Kraitchik、Elkies；**无任何删格推广记载** |
| zbMATH Open API | an:1538.05160、Srichote knight、Closed knight's tours on 4 x n chessboards… | 仅得既有 3 篇（ringboards、rectangular tubes、4×n 删两格），无 3×n 删两格条目 |
| Crossref API | Srichote 2022、3×n circuits、minimal square removal | 仅定位到已知文献（Thai J Math 未被 Crossref 收录；Miller–Farnsworth 两篇、DeMaio–Hippchen、Bullington 等） |
| thaijmath.com 站内检索 | "Srichote" / "removed" / "deficient" / "knight" | "deficient" 零命中；"removed" 仅 Srichote 2022 一篇巡游文 |
| tci-thaijo（MJMATh）站内检索 | "knight" | 仅 (2,b)-knight 与 ring board (n,n,1) 等已知文，无删两格 3×n |
| Jelliss mayhematics.com | 索引 t.htm 全量链接清单 + oa.htm（3×n 开巡游）+ ob.htm（3×n 闭巡游）+ sr.htm（holey boards 对称性）+ oc.htm（4×n）+ p.htm（出版物索引） | 全站无删格 3×n 内容；oa/ob 只有整板 3×n 定理与计数；holey 页只讲 16–196 格方形/近方形带洞板的对称巡游 |
| Semantic Scholar API / ResearchGate / StackExchange API / MO 直连 | 同上主题 | 429 / 403 / IP 限流（见 §5），经 Exa 侧证补位 |

### 2.2 全部命中即下列已知文献（最近邻全集，均已核到全文或机构仓储级）

1. **Miller–Farnsworth 2013**（OJDM 3:56–59, doi:10.4236/ojdm.2013.31012，全文实读）：3×n 删**一格**、**闭**巡游完全分类（Lemma 1 不可删清单 / Lemma 2 可删清单；3×3 仅中心、3×7 仅 (2,2)(2,6)、3×9 六格、n≥11 奇数时六格禁删+其余同色可删）。存在性，无计数；单删格，非双删格。
2. **Miller–Farnsworth 2013**（Ars Combinatoria 108:327–340，RIT 仓储页题录级）：圆柱/环面删**一格**。
3. **Bi–Butler–DeGraaf–Doebel 2015**（Involve 8(4):615–627，msp.org PDF 全文）：奇 m×n 删一格分类（Theorem 2：3×3 中心、3×5 无、3×7 两格…）；结论章仅对 **4×n 删两格**立问（Question + Conjecture），逐字结尾 "We look forward to seeing the next move in this area."——未提 3×n 双删格。
4. **Srichote et al. 2022**（§1，全文）：4×n 删两格闭巡游全分类。
5. **DeMaio–Hippchen 2009**（Math. Mag. 82(3):219–225, doi:10.4169/193009809X468869，Kennesaw 仓储 PDF 全文经 Exa 抓取）：tour number T(m,n)（最少删格数）；T(3,3)=1、T(3,5)=3、T(3,n)=1 (n≡3 mod 4, n≠5)、T(2,n)=2n−2；只给最小删格数与构造，不给位置分类、不给 3×n 双删格。
6. **Boonklurb–Sapworarit–Srichote 2019**（MJMATh 64(699):64–79）：ring board (n,n,1)/(m,m+4k,1)（中心挖 1×1）闭巡游。
7. **Srichote–Boonklurb–Singhun 2020**（Symmetry 12(8):1217, doi:10.3390/sym12081217；证据层级 = Exa 索引 highlights 级，MDPI 全文未逐页读）：(m,n,r)-ringboard 闭巡游分类；文中复述 "Let m ≤ 4 and n ≥ m. Then, a CB(m × n) contains an OKT from (m, 1) to (2, n − 1) if and only if m = 3 and n ≥ 7."（**整板** 3×n 的角到远角开巡游存在性——与本族共享 "3×n + 远角端点" 两个对象名，但对象是整板非删格板，边界划分见 §8）。
8. **Eraudilo–Singhun–Boonklurb 2020**（Thai J Math Special Issue 2020, 133–145）：禁形矩形板 + 广义骑士步。
9. **Van Rees 1997/2007**（"Knight's Tours and Circuits on the 3×n Chessboard", Classroom Notes, Univ. of Manitoba；题录/摘要级，Scribd/RG 副本未取到）：3×n **整板**开/闭巡游课堂笔记（RG 摘要片段提及 "the 3 × n chessboard admits an open [tour]…"）。无删格内容迹象，但证据仅题录级，挂账。
10. **McGown–Leininger 2002**（OSU REU 论文集，前轮全文）：带洞棋盘巡游判定 NP-完全（Itai–Papadimitriou–Szwarcfiter 归约）——一般判定 hardness，不构成本族（定宽条带，转移矩阵多项式时间）的占位。

### 2.3 结论（Q2）

**3×n 删两格（含两角、含远端对角两角）的存在性刻画与计数：查无已发表结果**。证据层级：最近邻三篇（Miller–Farnsworth、Bi et al.、Srichote 2022）均全文核读，无一提及 3×n 双删格或把它列为 open；三篇的 future work 表述（Bi "next move"、Srichote "(a,b)-leaper 删格版"、Miller–Farnsworth 转向圆柱/环面单删格）均不指向本族。按 R-15，全文级零命中可以写「查无占位」（非「零命中」措辞——最近邻存在且已核边界）。

---

## 3. Q3：3×n 删两角的存在性刻画——无任何发表结论

- 期刊/学位论文/预印本层：零（同 §2）。
- 民间文献总汇（George Jelliss, Knight's Tour Notes, www.mayhematics.com）：
  - 3×n 开巡游页（https://www.mayhematics.com/t/oa.htm）：Theorem 3.3 逐字 "Open knight's tours exist on all 3×n boards except 3×3, 3×5 and 3×6."——**整板**；Theorem 3.4 对称版。无删格内容。
  - 3×n 闭巡游页（https://www.mayhematics.com/t/ob.htm）：Theorem 3.5 逐字 "Closed knight's tours exist on all boards 3×2k except 3×4, 3×6 and 3×8."——整板。
  - holey 板页（https://www.mayhematics.com/t/sr.htm）：只处理 16–196 格方形/近方形带洞板的双旋转对称巡游，明确 "the smallest board that admits a tour with birotary symmetry is of 16 cells"；无条带、无 3×n、无计数。
  - 全站索引（t.htm）与出版物索引（p.htm，含 2019 年 12 卷 Knight's Tour Notes 专著目录、Chessics 30 期含 #22 Notes on Knight's Tours）：无删格 3×n 条目。链接页（1l.htm）未收录 DeMaio/Miller/Srichote 等删格论文——民间总汇与学术删格文献线基本无交集。
- Colin Rose（tri.org.au，A169696 评论引用的民间计数源）：本机连接失败（HTTP 000），挂账；其内容经 OEIS 评论转述为整板 3×m 计数。
- 竞赛层：Putnam/IMO 无删格棋盘巡游题（检索 + PCMI/Stanford PUTNAM 讲义命中均为 mutilated chessboard 多米诺类，非骑士巡游）。
- Math StackExchange 高票回答：API 限流未能穷举；Exa 侧证无相关高票问答（唯一 "Holey Knight's Tour" 为 codegolf 编程题，非数学结果）。

**结论（Q3）**：对「3×n 删两角，哪些 n 有开/闭巡游」这一问题，**无任何已发表的存在/不存在列举或刻画**，连小 n 的个例声明都没有。本机枚举（开巡游 n=4..12 为 1,6,0,0,351,602,1536,6534,45619，n=6,7 为零；闭巡游仅偶 n 非零且 n=8,10,12 为 5,2,220）是仓内单实现数据（`enum/holed_count.py`），非文献，且按 mossad-50 教训须异构复算后方可作为结论依据——与 C9 裁决无关，仅记于此备查。

---

## 4. Q4：OEIS——无任何删格棋盘巡游计数条目

- 序列独占性（本轮独立复算，字面返回 `null`）：`1,6,0,0,351,602,1536,6534,45619`（开巡游全列）、`351,602,1536,6534,45619`（偶数/去零子列查询亦 null）、`0,0,0,0,5,0,2,0,220`（闭巡游变体）。
- 关键词层（全部 null 或无关）：deficient chessboard knight / knight tour board squares removed / knight tour holes / 3xn board two squares removed / chessboard with two squares removed（唯一命中 A006067 = 棋盘四分拆问题，对象不同）/ board with holes knight / knight tour two cells removed / removing squares chessboard tour / knight tour one square removed / deficient board tour / knight tour deficient。
- 条目层：A169696（3×n 无洞开巡游，含 Knuth 引用与渐近 0.02789·3.45059^n）、A169764/A070030（3×n 无洞闭巡游）、A118067、A169770–772、A169777、A079137（4×n 开路径）、A001230（2n×2n 闭巡游，9862@6×6）、A165134、A306281/306283、A389756/757 等——全部为整板条目；对全部 "knight tour" 命中条目做 removed/hole/deficien/missing/punctur 扫描，**零删格条目**。
- 评论区：A169696 唯一长评论（Charland 2011）讨论无洞口径（undirected vs open）；A070030 评论讲 Euler/Bergholt/Kraitchik/Knuth-Elkies 转移矩阵法。**均无删格推广线索**。

**结论（Q4）**：OEIS 对「删格棋盘巡游计数」完全空白（单删格也没有），本族计数序列查无占位。

---

## 5. Q5：形式化生态——deficient board 骑士巡游无任何形式化成果

| 系统 | 成果 | 边界核验 | 证据层级 |
|---|---|---|---|
| Isabelle AFP | **Knight's Tour Revisited Revisited**（Lukas Koller, 2022-01-04, entry `Knights_Tour`，BSD）：形式化 Cull–De Curtins——"existence of a Knight's path for arbitrary n × m-boards with min(n,m) ≥ 5"；单理论文件 `KnightsTour.thy`（repo: kollerlukas/knights_tour） | 全文层：`board` 定义为**任意格子集合**（"A board is represented as a set of squares… allows boards to have an arbitrary shape"），通用路径/圈引理对任意 board set 成立——**删格板可表达但无任何删格定理被证**；全部实例化均为标准矩形 | 全文（AFP 条目页 + 理论页 + repo 文件清单） |
| Lean 4 | **matheus-fsc/KnightMove**（2025-09-14 建，2026-09-17 仍活跃）：形式化 Hamilton-space deficit **Q(n)=3 与 Q(n,m)=3（整板，min(n,m)≥6，无 sorry，`Q_abstract_eq_three`）+ bulk 连通性**；`Punc n` = 删去全部角关联边（角孤立）的技术图，**不是删格棋盘** | 全文层（repo README/prior-art/paper-status/wiki）：其「局部性定理」`Q(G_T \ S) = 3 ⟺ W_corners ⊆ S`、`Q = max(0, k_deg2 − 1)` 确实面向**顶点删除（deficient）图**，但 (a) 仅计算验证于 n ∈ {6,8,10} 方形板，未形式化；(b) Q 是圈空间余维（代数不变量），**不是巡游存在性/计数**；(c) 论文 `knight_tour_tightness` v5（2026-08-15）在手稿状态未发表；(d) 3×n 条带不在其验证范围（min 维 ≥6） | 全文（GitHub raw 文档 + Lean 文件清单） |
| Lean 4 | aria1th/knuth-fasc8a-ex210-lean4、kylekaba/knuth-fasc8a-ex210（2026-06/07，LLM 辅助）：形式化 Knuth TAOCP 4A PreFasc 8A **习题 2.10**——骑士巡游生成函数猜想 Q_m(z)^3 ∣ Q_m^+(z)（m≥5）在 **m=5 被反例推翻**的代数证明核 | 整板生成函数框架（转移矩阵口径），与将来「猜递推」工作流同源；**非删格**；非同行评审 | 全文（repo README） |
| Coq | 无任何骑士巡游形式化命中 | Exa 多查询 | 题录级零命中 |
| Mizar | 仅 "The Mutilated Chessboard Problem - checked by Mizar"（**多米诺骨牌**覆盖问题，非骑士巡游） | Exa | 题录级 |
| mathlib4 | `Mathlib/Combinatorics/SimpleGraph/Hamiltonian.lean` 提供 Hamilton 路径/圈基础设施（前轮 recon 已核：完全藏 + fromRel + boxProd 等）；无 knightGraph/deficient board 对象 | 前轮 + 本轮确认 | 题录/前轮全文 |

**结论（Q5）**：deficient board 骑士巡游在四大证明助手生态零形式化；最接近的结构性结果（KnightMove 的顶点删除 Q 不变量）是另一类不变量、未发表、未覆盖 3×n，且与存在性/计数正交。AFP 的 `board` 集合式表达意味着「3×n 删两角」在 Isabelle 侧**表达零成本**，缺的是数学内容而非基础设施。

---

## 6. C9 四态裁决与理由

**族定义**：3×n 棋盘删掉 (0,0) 与 (2,n−1)（远端对角两角）后的骑士巡游——开巡游（哈密顿路径）与闭巡游（哈密顿圈）的**存在性与计数**。

### 裁决：**查无占位**

理由（三条独立证据线，均达全文/机械核验级）：

1. **文献线**：与本族共享「对象名 + 性质词」的最近邻三篇（3×n 单删格闭巡游分类、4×n 双删格闭巡游分类、奇板单删格 + 4×n 双删格之问）全部全文核读，无一提及 3×n 双删格、两角配置、或删格巡游**计数**；三篇的 future work 均不指向本族。tour number 线（DeMaio–Hippchen）只给最小删格数。其余 ~15 组查询（含精确短语、中文、竞赛、民间、Thai 期刊）零命中。
2. **OEIS 线**：序列层（含闭巡游变体、子列、倒序共 8+ 查询）与条目层（全 knight tour 条目关键词扫描）双零。
3. **形式化生态线**：Isabelle/Lean/Coq/Mizar 无 deficient board 巡游成果；Lean 侧最近的顶点删除结果是不同不变量、未发表、不含 3×n。

与四态定义的对表：不属「已占位」（无挂名结果）；不属「已知未形式化」（文献层没有可形式化的结果）；不属「未裁决」（三条线均有实取证，无通道全灭——受限通道均已用替代通道补位并挂账）。故为「查无占位」。

### 残余风险（立项时 C9 记录须随附）

1. **Jelliss 2019《Knight's Tour Notes》12 卷专著与 Chessics 杂志（含 #22 "Notes on Knight's Tours" 专号）未逐页检索**——已核其网站全量索引与 3×n/4×n/holey 页无删格条带内容，但专著/杂志实体可能有网站未收录的短篇。风险等级：低（该站是民间文献总汇，删格学术线完全未入其链接页）。
2. **Van Rees 3×n 课堂笔记仅题录级**（1997/2007 两个日期记录不一致，Scribd/RG 副本未取到）。风险等级：低（课堂笔记对象为整板 3×n）。
3. **StackExchange API IP 限流**（剩 ~3.5 小时），MSE/MO 未能穷举；经 Exa 侧证未见相关高票回答。风险等级：低-中（ MSE 上可能有零散讨论，但「高票回答」级未发现；零散讨论不构成 C9 占位，仅影响「最相邻文献线」的民间段）。
4. **泰语文献**：Srichote 学位论文泰文摘要经核为 4×n；Thai J Math/MJMATh 站内检索无其他删格巡游文。风险等级：低。
5. **本族枚举数据本身未经异构复算**（单实现回溯枚举到 n=12；DP 枚举器与 n≥13 数据属本任务并行工作流）。此点不影响 C9 文献裁决，但影响「计数序列」作为立项主张的强度——若立项，序列本身必须先过异构复算关。

---

## 7. 通道失败与降级处置清单（如实挂账）

| 通道 | 故障 | 处置 |
|---|---|---|
| thaijmath.in.cmu.ac.th（旧刊址） | 301 → thaijmath2.in.cmu.ac.th → 全站 404 | 改道现行站点 thaijmath.com，站内检索 "Srichote" 定位文章并下载全文 PDF（成功） |
| digital.car.chula.ac.th 论文 PDF | Cloudflare 挑战（403，curl/Exa 双试） | 用 Exa 抓取 ETD 落地页 + 期刊版全文替代；Chapter IV 结论章挂账（不影响裁决） |
| web.archive.org | 直连与代理均 HTTP 000（不可达） | 放弃 wayback 路线；mayhematics.com 直连（不经代理）成功 |
| Semantic Scholar API | 全部请求 429 | 放弃；zbMATH Open API + Crossref API + Exa 补位 |
| StackExchange API（api.stackexchange.com） | throttle_violation（IP 限流 ~3.5h） | Exa 侧证 + 站点直连（MO 403）补位；MSE 穷举挂账 |
| ResearchGate | 403 | 仅用其搜索摘要片段作题录级线索（Van Rees） |
| tri.org.au（Colin Rose） | HTTP 000 连接失败 | OEIS A169696 评论转述其内容替代；挂账 |
| arXiv API / r.jina.ai / 通用搜索引擎（Bing/DDG/Mojeek/Brave） | 本环境不可达（沿用前轮挂账，本轮未依赖） | 本轮未使用；如需 arXiv 侧查新另轮处理 |
| Exa web_fetch_exa（旧 thaijmath URL） | CRAWL_NOT_FOUND | 换新站点解决 |
| SciRP/RIT/digitalcommons PDF | Cloudflare 403（curl） | 经 Exa web_fetch_exa 成功抓取 Miller–Farnsworth 与 DeMaio–Hippchen 全文文本 |

---

## 8. 最相邻文献线与边界划分（将来立项时 C9 记录用）

按「共享对象名 × 共享性质词」相关度排序的已发表工作线：

1. **Miller–Farnsworth 2013（OJDM 3:56–59）**：3×n + 删格 + 闭巡游 + 完全分类。与本族共享 3×n/删格/巡游存在性；差在**删一格 vs 删两格**、**闭巡游**、**无计数**。→ 本族是其「两格 + 开巡游 + 计数」的三重外推，两格外推无任何发表占位。
2. **Srichote–Boonklurb–Kaewwannarat–Singhun 2022（Thai J Math 20 Spec:64–81）**：删两格 + 完全位置分类 + 闭巡游。与本族共享删两格/分类；差在 **4×n vs 3×n**、**闭巡游**、**无计数**。→ 4×n 的答案不能平移到 3×n（3×n 的强制边/短回路结构完全不同，Miller–Farnsworth 的 3×n 分析即靠 forced cycle 论证），但它是「删两格条带」最近的方法论先例。
3. **Bi–Butler–DeGraaf–Doebel 2015（Involve 8:615–627）**：立问者。其 Question 仅覆盖 4×n；3×n 双删格从未被任何文献立为问题。
4. **DeMaio–Hippchen 2009（Math. Mag. 82:219–225）**：删格函数 T(m,n)。只答「最少删几格」，不答「删哪些/有多少巡游」。
5. **Knuth 的 3×n 整板计数线**（A169696/A169764/A070030 + "Long and skinny knight's tours"，transfer-matrix 方法；Elkies–Stanley 2003 Math. Intelligencer "The mathematical knight"）：本族是这条计数线的**删格模拟**——整板 3×n 的转移矩阵计数已被 Knuth/Elkies 做完（含闭式渐近），删两角 3×n 的同类计数零发表。这也是「递推可证性」工作流的最近邻：定宽条带计数必为矩阵幂序列（递推存在性有保证），Knuth TAOCP PreFasc 8A 习题 2.10（生成函数分母整除性，两个 2026 年 LLM 辅助 Lean 仓库已形式化其代数核）给出整板版的开/闭生成函数关系先例。
6. **Jelliss Knight's Tour Notes（民间层）**：3×n 整板存在性定理（Thm 3.3/3.5）与枚举分类（按端点分离），是 3×n 结构直觉的最近民间源；无删格内容。
7. **KnightMove（Lean 4，未发表手稿）**：顶点删除骑士图的 Hamilton-space deficit 局部性（Q(G\S)=3 ⟺ 删完全部四角；Q=max(0,k_deg2−1)）——唯一触及 deficient knight graph 的结构性结果，但 (a) 是圈空间余维非存在性/计数，(b) 仅方形板计算验证，(c) 未发表。对本族的可能用法：若其公式外延到 3×n 条带（删两角后 k_deg2=2 ⇒ Q=1），只说明删两角后 deficit 从 3 降到 1，**不构成**巡游存在性或计数的任何结论；引用时须注明未发表 + 计算验证级。

**边界一句话**：已发表工作的边界 = 「删格巡游的存在性分类，止步于 4×n 删两格（闭）」+「3×n 删一格（闭）」+「整板 3×n/4×n 计数」；本族（3×n 删两角、开+闭、计数）在三个维度（板宽、洞数、存在性→计数）上都越过了这条线，且线上三篇最近邻均全文核读无遗漏声明。

---

## 9. 本轮查询台账（节选，全部可复现）

- OEIS：`1,6,0,0,351,602,1536,6534,45619`→null；`351,602,1536,6534,45619`→null；`0,0,0,0,5,0,2,0,220`→null；`deficient+chessboard+knight`→null；`knight+tour+board+squares+removed`→null；`knight+tour+holes`→null；`3xn+board+two+squares+removed`→null；`board+with+holes+knight`→null；`knight+tour+two+cells+removed`→无关；`removing+squares+chessboard+tour`→null；`knight+tour+one+square+removed`→无关；`deficient+board+tour`→null；`knight+tour+deficient`→null；`knight+tour`→10 条（全整板）。
- zbMATH API：`an:1538.05160`（Srichote 2022 评审）；`Srichote+knight`（3 篇）。
- thaijmath.com 站内检索：`Srichote`（2 篇）、`removed`、`deficient`（0）、`knight`（3 篇）。
- mayhematics.com：t.htm / oa.htm / ob.htm / oc.htm / sr.htm / p.htm / 1l.htm 全量抓取。
- Exa：~15 组 web_search + 4 次 web_fetch_exa（Miller–Farnsworth 全文、DeMaio–Hippchen 全文、RIT 仓储页、Chula ETD 页、Bi et al. 全文经搜索结果 highlights）。
- 直接下载：Srichote 2022 PDF（thaijmath.com，6.9 MB，pdftotext + pymupdf 双提取，grep 全文）。

## 10. 过程产物

- 本报告：`tasks/20260928-holestrip-tourcount/c9/literature-round4.md`
- 抓取物（仓外临时目录 /tmp/c9r4，未入仓库）：`srichote2022.pdf`（期刊全文）、`srichote2022_mupdf.txt` / `srichote2022.txt`（双提取文本）、`oa.htm`/`ob.htm`/`sr.htm`/`t.htm`/`p.htm`/`1l.htm`（Jelliss 站）、`a1274.htm`/`i70-73.htm`（Thai J Math 页）、`dh.txt`（DeMaio–Hippchen 部分全文）。
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
| 1 | recon.md | 1-71 | 10066 | eea474ea639f0202 |
| 2 | report.md | 1-98 | 14269 | 6df417909506abe8 |
| 3 | report.md | 1-105 | 14566 | da82e1613be9f741 |
| 4 | literature-round4.md | 1-203 | 29126 | a0116004e77407f2 |

Recompute with: `python claims/holestrip-tour/audit/build-c9-record.py --check`
