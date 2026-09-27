<!-- C9 查新全量记录（本包新颖性证据主体）。出处注记：以下分隔线之间为 tasks/20260926-beian-extselect/recheck/03-exclusivity.md 的逐字全文（一处未改；核验：拆分本文件后 diff 为空，见 claims/edgemid-monomer-dimer/audit/listing-verify.txt 同级核验习惯，逐字比对为准）。分隔线之下为原始证据文件路径清单（相对仓库根，未拷入本包）。-->

===== 以下为源记录逐字全文（begin verbatim） =====
# 独占性复审报告：候选 03（3×n 边中孔单体—二聚体计数）

- 复审时间：2026-09-26；执行：main-agent（zcode 端点）；llm-call 0 次（全部检索为本机 curl 经代理 127.0.0.1:4180 + web_search，不涉模型采样）；gate-batch 0 次。
- 复审对象：`candidates/03-edgemid-monomer-dimer-review.md` 的新颖性声明与「局限如实记」节所列未复测项。
- 数值前置：`smoke-03/verify03.py` 复跑一致（六族序列 16 项与卡面全同；W/EB0 六阶移位形态全 n 成立、N1 例外 n=7、Nc/EBc 负结果复现）——检索所用序列项可靠。

## 逐通道结果

### 1. OEIS（主张①的复核；15 次查询，四层）

| 层 | 查询 | 结果 |
|---|---|---|
| 校准 | 基线 8 项 1,3,22,131,823,5096,31687,196785 | 命中 A033506（通道有效） |
| 精确 | W 8 项 / N1 8 项 / EB0 8 项 | 全部 null（零命中），复现卡面 |
| 放宽 | W/N1/EB0 各取中段 5 项（防偏移/截取漏检） | 全部 null |
| 对照 | 角孔 8 项 1,2,10,67,407,2546,15782,98104 | null（卡面未主张，本轮新增对照证据：连对照缺陷序列也不在册） |
| 全文 | monomer-dimer / "deleted vertex"+matchings / "grid graph"+matchings+deleted / "square removed"+"3 x n" / monomer+"3 x n" / matchings+"one vertex" | 命中均为整板族（A210662 三角阵、A28420、A260033–36、A99390、A278815）或 tatami（A180970 等，属 01 方向）；无任何 3×n 缺陷变体 |
| 交叉引用 | A033506 全文 | 仅指向 A210662（第 3 列）与 A100245（行和）；无缺陷变体交叉引用 |

证据文件：`recheck/03-exclusivity/calib.json, W.json, N1.json, EB0.json, corner.json, W5.json, N15.json, EB05.json, txt-*.json, A033506.txt`。

**结论：主张①（三缺陷族序列 OEIS 零命中）复现成立并加固**——由 8 项精确扩展为四层（校准/精确/放宽/全文+交叉引用）覆盖。

### 2. arXiv（卡面未复测通道，7 组查询 + 8 篇摘要语义核实 + 1 篇全文核查）

- 查询：monomer-dimer×strip、ti:"monomer-dimer"（30 条）、au:Lundow、matchings×grid graphs、domino tilings×missing square、monomer×"3×n"、monomer×defect×math.CO。
- **最相邻文献线（判定不占据，但论文写作须引用划界）**：
  - **arXiv:1901.07847**《State matrix recursion method and monomer-dimer problem》（已取 ar5iv 全文核查）：其「固定单个边界单体」枚举 = 删点图上**纯二聚体完全覆盖**（完美匹配）计数，且框架限奇×奇方板（Tzeng–Wu Temperley 双射、位置无关性）；本题计数 = 删点图**全部匹配**（任意大小的单体-二聚体铺法），且 3×n 全 n。对象不同、n 奇偶不限 → 不占据。
  - **Tzeng–Wu 2003**《Dimers on a simple-quartic net with a vacancy》(J. Stat. Phys. 110) 与 **Wu 2006**《Pfaffian solution of a dimer–monomer problem: Single monomer on the boundary》(PRE 74)：同上「完全匹配」语义（由 1901.07847 转述与题名支撑；原文 PDF 未取，证据等级：转述+摘要）。
- 其他研判：0304359（整板 M(m,n) 互反定理）、0711.4151（多面体/Gorenstein）、0708.1641（permanent 近似）、0709.1546（2×n 环面）、1410.8059 与 Kong 2006（奇×奇方板中心空位）、1202.1188/1405.2799（Aztec 矩形 gap，不同区域族）——均不占据；2106.09915/2609.27366（3×n 匹配复形拓扑）同图族不同问题；2406.05750（monopole-dimer 高维圆柱/Möbius/Klein）属 04/08 邻域。

**结论：arXiv 无占据；定位到最相邻文献线 1901.07847 + Tzeng–Wu 2003 + Wu 2006（完全匹配 vs 全匹配的语义边界）。**

### 3. OpenAlex（卡面未复测通道，6 组查询）

- 泛检索 3 组 + 标题精确 3 组（monomer-dimer tiling / matchings grid graph / domino tilings deficient）。
- 无占据。值得记档的相邻命中：《Perfect Matchings in Grid Graphs after Vertex Deletions》(2011) 与《Perfect matchings after vertex deletions》(2007，zbMATH 同现)——删点后**完美匹配的存在性/算法复杂性**文献，非计数序列。

### 4. zbMATH（卡面未复测通道，5 组查询，开放 API 实测可达）

- monomer-dimer strip boundary monomer → 1 条（2406.05750，已研判）；matchings grid deleted vertex → 上条算法文献；domino tilings missing square → **零结果**；monomer-dimer model strip lattice enumeration → 零结果；Hosoya index grid lattice → 1 条无关（纳米材料拓扑指数综述）。

### 5. Semantic Scholar（1 组成功；2 次未认证限流 429 如实记）

- 9 条结果全部为已研判项或无关（monopole-dimer、tatami、自由能/密度极限方向）。

### 6. web_search 通用层（3 组，含中文侧）

- 英文：仅整板经典结果（3×2n 递推 aₙ=4aₙ₋₁−aₙ₋₂）、Tromino 缺陷板（arXiv:1409.6614，不同瓦片）、方法综述；无 3×n 缺格计数公式文献。
- 中文：命中全部为 OI/算法教程（轮廓线 DP、插头 DP、POJ 2411、SPOJ M3TILE、LeetCode 790、UVA 11270）与知乎/CSDN 讲解——**方法层公共知识，无缺陷族序列或同余定理的已发表结果**。
- 知网：站内需登录未入（合规边界，不做登录态交互）；通用搜索未浮现 CNKI 相关条目。**「知网侧未测」残余声明维持**，且未出现反向信号。

### 7. 本地 C5 复现（主张②的前提）

- mathlib rg `monomer|dimer` = 0 文件；ModEq+periodic 组合检索无内容级命中（仅 Mathlib.lean 索引文件的跨模块伪命中）——卡面 C5 记录复现。

## 复审结论

1. **主张①（序列独占）复核成立**：W/N1/EB0 三序列（+角孔对照）在 OEIS 四层检索零命中；arXiv/OpenAlex/zbMATH/S2/通用+中文侧未发现占据文献。
2. **语义边界已具名**：最相邻文献线（1901.07847、Tzeng–Wu 2003、Wu 2006）做的是「删点图完美匹配（纯二聚体）」且（前两者）限奇×奇板；本题是「删点图全部匹配（单体-二聚体任意铺法）」且全 n。**不占据，但这是 03 立项后论文必须引用并划界的一线文献**；若立项，建议把该语义区分写进任务卡，防后续证明/论文阶段误读撞线。
3. **主张②③④不涉外部占据风险**：②为 kernel/形式化层（mathlib rg 复现零命中）；③④为数值观察与族对比，卡面本就未作对外独占主张。
4. **残余未覆盖（如实）**：知网站内（未登录不可达）；Semantic Scholar 2 次查询因限流未完成（已 1 次成功补位）；Tzeng–Wu 2003 / Wu 2006 原文 PDF 未取（判定依据为转述+摘要，证据等级中等）。
5. **对闸门一的影响**：03+04 打包立项所依赖的「独占性前提」经本轮复审维持成立；「首选（与 04 并列，需用户豁免 C1）」的选题院建议不变。

## 附：检索量记账

curl 合计约 40 次（OEIS 15 / arXiv 10 / OpenAlex 6 / zbMATH 5 / Semantic Scholar 4 / ar5iv 等 5）+ web_search 3 次 + 本机 Python 复算 1 次 + 本地 rg 2 组；llm-call 0；gate-batch 0。

===== 源记录逐字全文结束（end verbatim） =====

## 附：原始证据文件路径清单（tasks/20260926-beian-extselect/recheck/03-exclusivity/ 下，未拷入本包）

 - tasks/20260926-beian-extselect/recheck/03-exclusivity/A033506.txt
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/EB0.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/EB05.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/N1.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/N15.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/W.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/W5.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ar5iv-1901.html
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-abs.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-abs2.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-dom-miss.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-lundow.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-m-3xn.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-m-defect.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-match-grid.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-md-strip.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/ax-md-ti.xml
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/calib.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/corner.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa-del.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa-dom.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa-md.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa2-dom.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa2-mdt.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/oa2-mgg.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/s2-1.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/s2-2.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/s2-3.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/s2-4.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-1v.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-delvert.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-grid.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-m3.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-monomer.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/txt-rem.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/zb-1.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/zb-2.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/zb-3.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/zb-4.json
 - tasks/20260926-beian-extselect/recheck/03-exclusivity/zb-5.json
