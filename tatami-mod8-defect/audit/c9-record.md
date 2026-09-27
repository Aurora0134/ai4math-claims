# C9 novelty record — tatami-mod8-defect（全量查询记录，与源档案逐字一致）

> 本文件由两段源记录逐字拼接而成，未改写任何结论。
> 源 1：tasks/20260926-beian-select/candidates/01-tatami-defect-review.md（审题卡，含《底座核实记录》《新颖性自查说明》）
> 源 2：claims/tatami-mod8-defect/audit/c9-recheck/summary.md（2026-09-27 出包前独立补强复审，原始证据 14 件在同目录 c9-recheck/）

---

## 源 1 逐字全文：01-tatami-defect-review.md

# 审题卡 01：Tatami 铺法缺陷位形（角孔/边孔）计数 —— slug=tatami-defect

- 审卡人：选题院审题工人（行 01）
- 底座：OEIS A180970（已核实真身，见下）+ Erickson–Ruskey 系论文（arXiv:1110.5103、1103.3309、EJC 18(1) P109）
- 备案撞车栏口径：OEIS 零命中×2、其余 0；用户工作量估 2–3 周
- 消耗记账：llm-call **0 次**；编译 **2/2 轮**（gate-batch 两轮，第 2 轮全绿）；网络检索若干（不占预算类目）

---

## 人话区块

**1. 这题在证什么**

底座 A180970 = 「3×n 棋盘的 tatami 铺法数」（允许 1×1 单体与 1×2 二聚体，约束：任何网格点处不能有 4 块砖共角）。该数列满足 6 阶线性递推 a(n)=a(n−1)+2a(n−2)+2a(n−4)−a(n−5)−a(n−6)（n≥9，OEIS 记录在案）。
本卡把备案方向收窄为三个 conclusion-given 命题（形式化对象均为**递推定义版整数序列**，组合含义分层标注）：

- **P1（首选，冒烟轮已被 kernel 完整证明）**：A180970 的 mod-8 周期 4 定理——对所有 n≥4，a(n) mod 8 只由 n mod 4 决定：(4,2,4,6)。等价推论：a(n) 的 2-adic 赋值 v₂(a(n)) = 2（n 偶 ≥4）/ = 1（n 奇 ≥3）。
- **P2（备选，缺陷方向正身）**：角孔序列 b(n)（3×n 去掉一个角格后的 tatami 铺法数，递推定义版）对所有 n≥4 为奇数。
- **P3（备选 2）**：缺陷↔底座精确恒等式 20·b(n) = 4a(n)+33a(n−1)−9a(n−2)+8a(n−3)+a(n−4)−3a(n−5)（n≥10）。

**2. 值不值得做**

一行结论：P1 值得做且**几乎零边际成本**（冒烟轮已产出 0-sorry 完全证明）；P2/P3 是备案研究方向正身，但组合等同性只能到「探针 + 理论」猜想层。检索证据（不做断言）：
- mathlib（本机 rg）：tatami 0 命中、A180970 0 命中；compfiles 快照：tatami 0 命中；Lean 侧 OEIS 形式化项目 sequencelib（GitHub 全树 25970 文件）：A180970 / tatami 均无文件。
- OEIS A180970 记录（镜像修订 #32, 2026-05-26）公式栏只有母函数一条，**记录中未见** mod-8 周期性陈述（如实描述，不声称首创）。
- 缺陷序列（角孔 2,8,24,41,85,177,… / 短边孔 1,8,22,41,75,167,… / 长边孔 8,22,72,127,265,…）按备案口径 OEIS 零命中（本机无法直连 OEIS 复核，沿用备案撞车栏）。

**3. 档位与依据**

- 先验档：**挑战档**（题源：用户人工备案研究级方向，收窄后落「初等代数·递推数列性质」带，按 C1 该带首批挑战预算口径）。
- 修正档：**稳妥档**（冒烟结果：整条预期路线第 2 轮编译一次通过，且直接产出主定理完全证明——按 SOP 定档规则「整条预期路线一次编译过 → 降/定为稳妥档」）。
- 不一致原因：冒烟超出预期（real-01 同款先例：C8 冒烟直接出 0-sorry 证明）。

**4. 预期打法**

人话：把 a(n) 按「9 个初值 + n≥9 走递推」做结构递归定义；对 n≥4 用强归纳，n=4..9 六个基点直接展开数值验证；n≥10 时把递推改写一步，六项余数假设交给 omega 线性模算术收官。
冒烟状态：**通过（且完全证明已落盘记录）**——WELLDEF OK、8/8 裸探针 FAIL、6/6 #check OK、`#print axioms` = 恰 {propext, Classical.choice, Quot.sound}。

**5. 主要不确定性**

- 组合等同性缺口（如实标注）：形式化的是递推定义序列；「该递推序列 = A180970 = tatami 计数」对 P1 由 OEIS 记录 + Erickson–Ruskey 公开定理背书（可引用，不形式化）；对 P2/P3 的缺陷序列仅有本机探针（n≤20 精确枚举 + 同 signature 递推尾段验证）+ 转移矩阵一般理论（保证存在某终段线性递推）支撑——**论文中必须作为计算猜想层明确分级**，不能写成已证定理。
- 缺口具名（无）：P1 无 mathlib 缺口引理。预算预期：P1 ≤3 次（实际证明侧增量 ≈0，余 statement 冻结/roundtrip/终审）；P2 ≤3 次、P3 ≤3–4 次（骨架与 P1 同构，未冒烟）。

**6. 选题院建议**

**首选**（本行内选 P1）：它是本批备案行里罕见的「C8 冒烟直接出完全证明」候选，证据链（探针自检 + OEIS 交叉验证 + kernel）三层互证；缺陷方向（P2/P3）可作同一论文包的第二节与公开猜想，叙事完整且诚实分级。

---

## 技术证据区块

### 底座核实记录（禁止编造检索结果——以下为实取原文）

- **OEIS 直连不可达**：oeis.org / api.oeis.org 经本机代理（127.0.0.1:4180，代理本身正常，example.com 经代理 200）与直连均 HTTP 000；Wayback、DuckDuckGo、Wikipedia 同不可达。改道 **GitHub 官方镜像 `oeis/oeisdata`（jsdelivr CDN 可取）** 取得 `seq/A180/A180970.seq` 全文：
  - `%N`：Number of tatami tilings of a 3 X n grid (with monomers allowed).（Frank Ruskey, Sep 29 2010；offset 0,2）
  - 前 31 项：1, 3, 13, 22, 44, 90, 196, 406, 852, 1778, 3740, 7822, 16404, 34346, 72004, 150822, 316076, 662186, 1387596, 2907262, 6091780, 12763778, 26744268, 56036566, 117413804, 246015450, 515476036, 1080072022, 2263070868, 4741795442
  - 递推：Index entries signature **(1,2,0,2,−1,−1)**；Mathematica 程序显示递推从初值块 {22,44,90,196,406,852}=a(3..8) 起步生成（即对 n≥9 成立；a(6) 处不成立，本机已复核 196 ≠ 200）。
  - 母函数：(1+2x+8x²+3x³−6x⁴−3x⁵−4x⁶+2x⁷+x⁸) / (1−x−2x²−2x⁴+x⁵+x⁶)。
  - 文献链接行：Erickson–Ruskey–Schurch–Woodcock《Auspicious tatami mat arrangements》arXiv:1103.3309（see p.17）与 EJC 18(1) (2011) P109《Monomer-Dimer Tatami Tilings of Rectangular Regions》。
- **Erickson–Ruskey 论文核实**（arXiv 可达，摘要+PDF 已取）：arXiv:1110.5103（Erickson & Schurch）给出 n×n 方格闭式族：m 单体（m<n, 同奇偶）计数 = m·2^m+(m+1)·2^{m+1}；恰 n 单体 = n·2^{n−1}；全体合计 = 2^{n−1}(3n−4)+2。该闭式族属 n×n 方向（非本行 3×n 底座），仅作背景，不入候选命题。

### 数值探针记录（本机 Python 3.11.9，精确枚举；脚本与输出存 tasks/20260926-beian-select/tmp-probe/）

- 自写 3×n tatami 枚举器（列前沿 DP；「无四点共角」= 每个内部网格点四格不属 4 块不同砖；支持任意空洞格）。**自检：n=0..15 输出与 A180970 前 16 项逐项一致**。
- 底座递推 (1,2,0,2,−1,−1) 对 n=9..20 全部成立（与 OEIS 互证）。
- 缺陷序列（精确枚举值）：
  - 角孔 b_c(n)（去格 (0,0)，n≥1）：2, 8, 24, 41, 85, 177, 381, 787, 1655, 3457, 7267, 15197, 31873, 66739, 139907, 293055, …
  - 短边孔 b_s(n)（去格 (1,0)，n≥1）：1, 8, 22, 41, 75, 167, 349, 737, 1523, 3215, 6717, 14105, 29499, 61879, 129573, 271609, …
  - 长边孔 b_l(n)（去格 (0,1)，n≥2）：8, 22, 72, 127, 265, 541, 1171, 2419, 5095, 10623, 22349, 46721, 98019, 205193, 430211, …
- **三个缺陷序列均满足与底座相同的 6 阶递推**：角孔/短边孔自 n=10 起、长边孔自 n=11 起（逐点验证至 n=20）——与转移矩阵理论预期一致（同分母、仅初值不同）。
- 角孔奇性：b_c(n) 对 4≤n≤20 全为奇数。底座 mod 8：a(n)%8=(4,2,4,6)[n%4] 对 4≤n≤20 全成立。
- 精确线性关系（尾段有理 span 拟合 + 全数据点复核零失配，n=10..20 / n=11..20）：
  - 20·b_c(n) = 4a(n) + 33a(n−1) − 9a(n−2) + 8a(n−3) + a(n−4) − 3a(n−5)
  - 10·b_s(n) = 9a(n) − 2a(n−1) + 6a(n−2) − 12a(n−3) + 6a(n−4) + 7a(n−5)
  - 4·b_l(n) = 3a(n) − 3a(n−1) + 18a(n−2) − 3a(n−3) + a(n−4) + 2a(n−5)
- 否定记录（如实）：缺陷序列与底座间**无**移位 ≤6 的整系数线性关系在全区段成立（首段不合）；缺陷序列无 ≤8 阶「从头成立」的线性递推（首段不规则，递推仅尾段成立，与底座同款现象）。

### 候选命题与证据等级

| # | 命题（人话） | 预计 Lean statement 草形 | 证据等级 |
|---|---|---|---|
| P1 | ∀n≥4，a(n) mod 8 = (4,2,4,6)[n mod 4]（a = A180970 递推定义版） | `theorem tatami_mod8_period4 (n r : ℕ) (hn : 4 ≤ n) (hr : n % 4 = r) : a180970 n % 8 = pat8 r`（冒烟已实现） | **kernel 完全证明**（冒烟轮 0-sorry、白名单公理）+ 探针 n≤20 + OEIS 递推互证 |
| P2 | ∀n≥4，角孔序列 b_c(n) 为奇数（b_c 递推定义版：初值 2,8,24,41,85,177,381,787,1655，n≥10 走同 signature 递推） | 同构：`def bcorner : ℕ → ℤ`（9 初值 + n+9 递推分支）+ `theorem bcorner_odd (n) (hn : 4 ≤ n) : bcorner n % 2 = 1` | 探针 n≤20（枚举直算 + 递推尾段验证）；Lean 骨架与 P1 同构（mod 2、五项 IH、omega），**未冒烟**（本工人编译额度 2/2 已用完） |
| P3 | 20·b_c(n) = 4a(n)+33a(n−1)−9a(n−2)+8a(n−3)+a(n−4)−3a(n−5)（n≥10，两递推定义序列间） | `theorem bcorner_eq (n) (hn : 10 ≤ n) : 20 * bcorner n = 4*a180970 n + 33*a180970 (n-1) - 9*a180970 (n-2) + 8*a180970 (n-3) + a180970 (n-4) - 3*a180970 (n-5)` | 探针 n=10..20 精确成立；证法 = 两侧同递推 + 6 基点 norm_num + 归纳 omega，**未冒烟**；系数不美观但恒等式为精确型 |

退化判断（C4）：P1 已由 kernel 裸探针 8/8 FAIL 实证非退化。P2/P3 同为「∀n 归纳型」命题，单 tactic 不可能闭合（无任何判定过程覆盖任意 n 的递推展开），判断非退化（待形式化部探针复跑确认）。

### C1–C8 逐条核对

- **C1 领域白名单**：方向本体（缺陷铺法计数）= 组合枚举，白名单七类之外（「大规模有限枚举」维持排除项的近邻——但本卡形式化不做枚举）。收窄后形式化命题 = 整数递推数列的同余/线性恒等性质，落「初等代数·递推数列」带（挑战档口径）。按任务口径：人工备案题源 C1 不命中不自动淘汰；**若立项需用户知悉并认可两点**：①组合计数本体（=tatami 铺法数）不形式化，只形式化递推层；②缺陷序列的组合含义在论文中只能按计算猜想分级。P1 的形式化内容本身不需白名单豁免。
- **C2 形态**：conclusion-given、单概念 ✓。新定义 `a180970`（及 P2 的 `bcorner`）按 2026-09-26 放宽②单列为辅助 def，须经 roundtrip 核验；P1 的 def 已经 kernel 编译验证（冒烟轮）。
- **C3 预检清单**（具名 + 文件:行号 + #check 结果，全部 OK）：
  1. `Nat.strong_induction_on` — Mathlib/Data/Nat/Init.lean:258（#check OK；用法先例 Mathlib/Combinatorics/SimpleGraph/Connectivity/Subgraph.lean:477）
  2. `Nat.mod_lt` — Lean core Init/Prelude.lean（rg 本体见 Prelude；#check OK）
  3. `Nat.reduceAdd` / 4. `Nat.reduceMod` — Lean core simproc 引理（#check OK）
  5. `lt_or_ge` — Mathlib Order（#check OK）
  6. `Nat.strongRecOn`（备选）— Lean core（#check OK）
  tactic 级依赖（非引理，随包可用）：omega、norm_num、interval_cases、simp only（结构递归方程引理由定义自动生成）。
- **C4 非退化**：✓ kernel 实证——裸探针 nlinarith / norm_num / simp / ring_nf / positivity / omega / linarith / decide **8/8 全 FAIL**（gate-batch 报告 tmp-probe/gate-tatami-r2.txt）。
- **C5 非复述**：✓ mathlib rg `tatami`=0、`A180970`=0；compfiles rg `tatami`=0；sequencelib 全树无 A180970/tatami 文件。非任何现有定理的特例/改写。
- **C6 形式化可行性**：✓ 序列统一走 **ℤ**（递推含负系数，已避开 ℕ 减法陷阱）；无 ℕ 除法闭式、无 min/max、无分段函数。结构递归定义 kernel 编译通过。
- **C7 预算预期**：P1 ≤3 次采样（证明侧增量 ≈0：statement 冻结 → roundtrip → 严格终审复跑）；P2 ≤3、P3 ≤3–4（未冒烟，按骨架同构估）。符合稳妥档 ≤3 / 挑战档 ≤6 上限。
- **C8 路线冒烟**：**通过**（gate-batch 两轮：r1 断点唯一 = 多余 `intro` 一行，r2 全绿）。且直接产出主定理完全证明（0 sorry、`#print axioms` = {propext, Classical.choice, Quot.sound}）。修正档定为稳妥档即据此。

### 路线冒烟记录（gate-batch 输出摘要）

- r1（tmp-probe/gate-tatami.txt）：WELLDEF FAIL（唯一报错：`| _ n ih =>` 后多写 `intro r hn hr`——Lean4 induction 自动重引入被 revert 的假设）；#check 6/6 OK；探针 8/8 FAIL。
- r2（tmp-probe/gate-tatami-r2.txt）：**WELLDEF OK / PROBE 8×FAIL / CHECK 6×OK / AXIOMS tatami_mod8_period4 = [propext, Classical.choice, Quot.sound]**。临时源文件 verify-proj/GateSmokeTatami.lean 已按纪律删除（证明文本完整保留在本卡 tmp-probe 旁的冒烟记录与 r2 报告中；若定题，形式化部按本卡 C2 口径重建 statement 并冻结）。

### 新颖性自查说明

仅列检索证据：mathlib/compfiles/sequencelib 三处零命中（见 C5）；OEIS 记录公式栏无 mod-8 周期陈述（镜像修订 #32 实读）；缺陷三序列按备案撞车栏 OEIS 零命中（本机 OEIS 不可达，未独立复核）。不做「首次发现/首创」断言。

### 形式化可行性评级

**高**——P1 已被 kernel 完整证明（冒烟轮直出）；P2 与 P1 同构（mod 2 五项归纳）；P3 为纯线性恒等归纳。唯一真正的科学风险在「递推定义版 ↔ 枚举计数版」等同性（超出本次预算，按猜想层分级处理）。

### 选题院建议

**首选（P1）**——一句话理由：C8 冒烟直接产出 0-sorry 完全证明、三层证据互证（探针自检 × OEIS 互证 × kernel），是本行备案收窄后唯一「已证成」的候选；P2/P3 作论文内第二节与公开猜想，诚实分级、叙事完整。

---

## 源 2 逐字全文：c9-recheck/summary.md

# C9 补充查新记录（占位通道立项补强）— tatami-mod8-defect

- 执行：主代理（kimi 端点），2026-09-27；llm-call 0；全部为本机 curl（经代理 127.0.0.1:4180 + `--ssl-no-revoke`）。
- 动因：候选 01 审题卡（2026-09-26 上午）的缺陷序列 OEIS 零命中沿用了备案撞车栏口径（当时本机 OEIS 不可达，未独立复核），早于 C9 硬化纪律（2026-09-26 晚）。出占位包前按现行纪律独立补查。

## OEIS 序列层（`oeis.org/search?fmt=json`，返回 null = 零命中）

| 查询串 | 结果 |
|---|---|
| 角孔 b_c 原串 `2,8,24,41,85,177,381,787` | null（corner-orig.json） |
| 角孔去前 1 `8,24,41,85,177,381,787,1655` | null（corner-drop1.json） |
| 角孔去前 2 `24,41,85,177,381,787,1655,3457` | null（corner-drop2.json） |
| 短边孔 b_s 原串 `1,8,22,41,75,167,349,737` | null（short-orig.json） |
| 短边孔去前 1 `8,22,41,75,167,349,737,1523` | null（short-drop1.json） |
| 短边孔去前 2 `22,41,75,167,349,737,1523,3215` | null（short-drop2.json） |
| 长边孔 b_l 原串 `8,22,72,127,265,541,1171,2419` | null（long-orig.json） |
| 长边孔去前 1 `22,72,127,265,541,1171,2419,5095` | null（long-drop1.json） |
| 长边孔去前 2 `72,127,265,541,1171,2419,5095,10623` | null（long-drop2.json） |
| 阳性对照 `22,44,90,196,406,852` | **命中 A180970**（"Number of tatami tilings of a 3 X n grid (with monomers allowed)"）——通道有效 |

## OEIS 记录层

- A180970 全记录经 jsdelivr 镜像重取（A180970.seq，2771 B）：`mod|period|congru`（大小写不敏感）**零命中**——记录中无 mod-8 周期性陈述（与 2026-09-26 审题卡实读结论一致，独立重取复核）。

## 文献层（arXiv API：https 重试成功；http 空返回为通道试错如实记）

- `all:"tatami"`（40 条，按相关度）：命中均为已知 tatami 文献（Auspicious / EJC monomer-dimer tatami / square regions / domino tatami NP-complete / 枚举方法类）与噪声（柔道、物理），**无** A180970 mod-8 周期性、角孔缺陷序列奇性、缺陷↔底座线性恒等式相关条目。
- `abs:"tatami" AND abs:"congruence"`：**0 条**。
- OpenAlex `tatami tilings`（10 条）：首位 = Erickson–Ruskey–Woodcock–Schurch《Monomer-Dimer Tatami Tilings of Rectangular Regions》（已在引用清单）；无新占据信号。

## 裁决

P1（mod-8 周期 4）/ P2（角孔序列全奇）/ P3（缺陷↔底座恒等式）三层证据（OEIS 序列层 + OEIS 记录层 + 文献层）均无占据 → **维持「查无占位」**；库层（mathlib/compfiles/sequencelib 三处零命中）沿用审题卡 C5 本机 rg 实证。

## 残余缺口（如实）

- 知网站内未查（需登录，合规边界）；Semantic Scholar 未复测。
- 教学文献层未系统扫（研究级命题，低相关，如实声明）。
- 本记录只覆盖「命题层独占性」，不声称组合计数本体（= tatami 铺法数）的形式化——组合语义桥仍按 OEIS + Erickson–Ruskey 文献背书层与计算猜想层分级。
