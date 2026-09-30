# L13C 命题级 C9 独立查新档案（预选库出库前深度复审）

- slot：L13C（#pre-lin-02 窄口 C，隔列挖中点三行带 z(n)）
- 复审命题：三行带网格 P_3□P_n 每隔一列挖去中行顶点（0 基 (1,1),(1,3),(1,5),…）所得图的独立集计数列 z(n) 满足六阶递推 z(n)+15·z(n−4)=12·z(n−2)+2·z(n−6)（n≥6，ℕ 无减法形），且该数列在 OEIS 与文献层查无挂名（新序列级；奇偶子列各有三阶结构、signature (12,−15,2)；与 A122011 逐位相同的子列判「数列撞名、对象不撞」，禁写「新递推」）。
- 检索执行日：2026-09-29；执行者 = 本查新员（独立于深挖卡作者的二次取证）。
- 数列基准 = 本批重算件 `tasks/20260929-preselect-deeprecheck-01/compute/L13C/results.json`（两路异构：2^m 顶点子集暴力 + 列状态转移 DP，z(0..20)），全部检索串取自该文件，未使用深挖卡旧串。
- 原始回包：本目录 `raw/`（文件名与 §1 台账行一一对应）。
- 纪律声明：①本档案一切占用/零命中结论只依据本表台账所列的本轮重跑检索；深挖卡 §1 窄口 C 行与 §2 仅作查询思路输入，其结论未直接采信（A122011 撞名判定、四串零命中、2507.04007 全文裁决均由本轮重跑独立重证）。②零命中行均标注同批阳性对照状态。③引句逐字并带 URL。④harness/ 与 tasks/20260928-* 只读；本档案只写 `c9-recheck/L13C/`。

---

## §1 查询台账

### 1.1 OEIS 数串检索（通道：oeis.org/search?fmt=json，代理 127.0.0.1:4180 + --ssl-no-revoke；同批阳性对照见首行）

| # | 查询串（重算件原文） | 原始回包 | 裁决 |
|---|---|---|---|
| PC | `5,17,63,227,827,2999`（阳性对照：3×n 母体切片，必命中 A051736） | `oeis_posctrl.json` → 命中数组，含 A051736 | **阳性对照命中**，OEIS 通道本轮有效 |
| S1 | 主串（z(1) 起 20 项）`5,13,47,141,491,1499,5197,15899,55093,168585,584143,1787533,6193715,18953419,65672621,200965203,696334013,2130856217,7383306271,22593703397` | `oeis_main.json` → `null` | 零命中（PC 有效） |
| S2 | 去首 1 项（z(2) 起 19 项） | `oeis_drop1.json` → `null` | 零命中 |
| S3 | 去首 2 项（z(3) 起 18 项） | `oeis_drop2.json` → `null` | 零命中 |
| S4 | 奇位子列（z(1),z(3),…）`5,47,491,5197,55093,584143,6193715,65672621,696334013,7383306271` | `oeis_oddsub.json` → `null` | 零命中 |
| S5 | 偶位子列（z(2),z(4),…）`13,141,1499,15899,168585,1787533,18953419,200965203,2130856217,22593703397` | `oeis_evensub.json` → 命中 **A122011**（data 逐位 `0,1,13,141,1499,15899,168585,1787533,18953419,200965203,2130856217,22593703397,…`） | **数列级命中**；单条核读见 §1.3，判定「数列撞名、对象不撞」 |
| S6 | 签名串 `12,-15,2`（纪律 3：递推系数） | `oeis_sig.json` → 10 条（A275870 可分拆计数、A115872、A121998 等） | 10 条逐名过目**全 off-target**；signature 本身非本对象独占 |
| S7 | 每项 +1 变体 `6,14,48,142,492,1500,5198,15900`（纪律 2） | `oeis_plus1.json` → `null` | 零命中 |
| S8 | 每项 −1 变体 `4,12,46,140,490,1498,5196,15898`（纪律 2） | `oeis_minus1.json` → `null` | 零命中 |

### 1.2 OEIS 关键词串（6 条 ≥3 义务）

| # | 查询串 | 原始回包 | 裁决 |
|---|---|---|---|
| K1 | `independent sets grid graph defect hole` | `oeis_kw1.json` → `null` | 零命中 |
| K2 | `hard square defect missing vertex` | `oeis_kw2.json` → `null` | 零命中 |
| K3 | `independent sets deleted vertices grid` | `oeis_kw3.json` → 10 条文本匹配（A1045 Jacobsthal、A2620 quarter-squares、A931 Padovan 等） | 全 off-target（纯词面匹配，无图计数对象） |
| K4 | `independent sets periodic modulo column` | `oeis_kw4.json` → 10 条（A2720、A110、A45 等） | 全 off-target |
| K5 | 短语 `"independent sets" "grid graph"` | `oeis_kw5.json` → 10 条 = A89980（完好网格独立集阵列）、A231882/84/86/87/88（极大侧）、A293177、A197054（极大侧）、A286513、A332347 | 逐名过目：全部为**完好**网格/类网格图或极大独立集家族，无一条含删点/缺陷形；z 非完好阵列的切片（母体完好 3×n = A051736 数值 5,17,63,227 ≠ z 5,13,47,141），阵列切片假阴性路径（A272472 判例）不适用于本对象 |
| K6 | `defective grid independent` | `oeis_kw6.json` → `null` | 零命中 |

### 1.3 OEIS 单条核读（jsdelivr 镜像，`raw/A122011.seq` 17 行、`raw/A051736.seq` 43 行全文已读）

**A122011（本命题点名的撞名对象，判定由本轮重核）**——`https://cdn.jsdelivr.net/gh/oeis/oeisdata@main/seq/A122/A122011.seq`：

- `%N A122011 G.f. x^2*(1+x)/(1-12*x+15*x^2-2*x^3).`
- `%S A122011 0,1,13,141,1499,15899,168585,1787533,18953419,200965203,2130856217,22593703397,239563527915,…`（%T/%U 至 340424149534129305）
- `%F A122011 a(n)= 12*a(n-1) -15*a(n-2) +2*a(n-3).`
- `%H A122011 <a href="/index/Rec#order_03">Index entries for linear recurrences with constant coefficients</a>, signature (12, -15, 2).`
- `%t A122011 M = {{1, 1, 1}, {1, 2, 4}, {1, 3, 9}} v[1] = {1, 0, 0} v[n_] := v[n] = M.v[n - 1] a1 = Table[v[n][[3]], {n, 1, 50}]`
- `%D A122011 "Linear Algebra, Examples and Applications" by Alain M. Robert, World Scientific, 2005, p. 58.`
- `%Y A122011 Cf. A122009, A122010`；`%A … _Roger L. Bagula_ and _Gary W. Adamson_, Sep 11 2006`；`%E … Definition replaced with generating function by the Assoc. Eds. of the OEIS, Mar 27 2010`

逐字判定：①全记录（17 行）**无任何图论/网格/独立集字样**，对象 = 3×3 矩阵幂第 3 分量的线性代数例题（%t 栏 + %D 引 Robert 2005 p.58）。②数列逐位对照：A122011(2..12) = 13,141,1499,15899,168585,1787533,18953419,200965203,2130856217,22593703397 = z(2),z(4),…,z(20)（重算件 `z_full_0_to_20` 逐位相同，11 项重叠窗口，无发散点）；且两侧同满足三阶递推 t(k)=12t(k−1)−15t(k−2)+2t(k−3)（重算件 checks：even subseq 7/7 pass；%F 同式）→ 同初值同递推，**两序列同一**。③结论 = **数列撞名、对象不撞**；其 signature (12,−15,2) 已挂 OEIS linear-recurrence 索引（%H 逐字）→ 对 z 的任何「新递推」主张不成立。

**A051736（阳性对照单条核读）**——`https://cdn.jsdelivr.net/gh/oeis/oeisdata@main/seq/A051/A051736.seq`：

- `%N A051736 Number of 3 X n (0,1)-matrices with no consecutive 1's in any row or column.`
- `%C A051736 Also the number of independent vertex sets and vertex covers in the 3 X n grid graph. - _Eric W. Weisstein_, Sep 21 2017`
- `%H … Index entries for linear recurrences with constant coefficients, signature (2, 6, 0, -1).`；`%Y A051736 Row 3 of A089934. Row sums of A371967.`
- 侧记：其 %C 无奇偶/整除/周期句（本轮 43 行全文目视；此项属窄口 E 的补查线索，非本 slot 义务）。

### 1.4 文献层 · arXiv（export.arxiv.org/api/query 直连 https；12 串 ≥5 义务；R-16 四口径逐条）

| # | 查询串 | 回包 | 裁决 |
|---|---|---|---|
| A1 | `all:"independent sets" AND all:"grid graph" AND all:defect` | `arxiv_defect.xml` → **0 entries** | 零命中 |
| A2 | `all:"independent sets" AND all:grid AND all:holes` | `arxiv_holes.xml` → 1 条 = 2608.20051（二部图 m-atomic 分解） | off-target |
| A3 | `all:"hard square" AND all:defect` | `arxiv_hardsquare.xml` → 2 条 = 1702.02332（临界参数估计）、2603.28609（圆内受限硬方） | 皆统计物理参数估计，无计数递推，off-target |
| A4 | `all:"vertex-deleted" AND all:"independent sets"` | `arxiv_vertexdeleted.xml` → 10 条 | 9 条 = 顶点删除参数复杂度/时间下界类，off-target；1 条 = 1401.1596（MS 线，见 §2） |
| A5 | `all:"independent sets" AND all:"transfer matrix" AND all:grid` | `arxiv_transfer.xml` → **0 entries** | 零命中 |
| A6 | `all:"number of independent sets" AND all:grid` | `arxiv_nis_grid.xml` → 1 条 = math/0701890（平方网格独立复形） | 进 Top-3 必核，见 §2 |
| A7 | `ti:"independent sets" AND abs:grid` | `arxiv_ti_grid.xml` → 10 条 | 3 条相关（2507.04007、2506.22317、1709.03678），余为机器人/MIS 近似算法类 off-target |
| A8（R-16 divisibility） | `all:"divisibility" AND all:"independent sets"` | `arxiv_divis.xml` → 10 条 | 逐名过目全 off-target（唯一极大独立集、随机正则图、land division、超图 k-IS 等） |
| A9（R-16 parity/valuation 邻接） | `all:"independent sets" AND all:parity AND all:grid` | `arxiv_parity.xml` → 4 条 | 2506.22317（极大侧，已核读 §2）、2507.04007（已核读 §2）、2304.04504（odd-minor 结构）、1901.06915（编码）→ 后两条 off-target |
| A10（R-16 period） | `all:"independent sets" AND all:periodic AND all:modulo` | `arxiv_period.xml` → 1 条 = 2608.30601（Möbius/环形复合同伦型） | off-target |
| A11（R-16 valuation/2-adic，上轮卡面 curl(28) 未决，本轮重跑） | `all:"2-adic" AND all:"independent sets"` | `arxiv_2adic.xml` → **0 entries** | **通道本轮存活 → 有效零命中**（上轮「未裁决」项就此清账） |
| A12（R-16 zeros/apparition） | — | — | **删除该口径并注明理由**：独立集恒含空集 ⇒ 计数 ≥1，「计数 = 0 / 首现」对本对象族无承载；其可承载的等价问题（删点轴）已由 A1/A2/A4/A6 覆盖 |

R-16 执行汇总：valuation ✓（A11 有效零）、zeros ✗（删除，理由如上，删点轴以 A1/A2/A4 替代覆盖）、period ✓（A10 off-target）、divisibility ✓（A8 off-target）；OEIS 层零命中不替代本轮文献层检索（R-16 要求的双层均实跑）。

### 1.5 文献层 · Crossref（api.crossref.org，3 检索串 + 1 bibliographic 详情串）

| # | 查询串 | 回包 | 裁决 |
|---|---|---|---|
| C1 | `independent sets grid graph deleted vertices` | `cr_defect.json` → 8 条 | 1 条高相关（De Ita et al. 2024，见 §2）；余 off-target |
| C2 | `independent sets 3 xn grid recurrence` | `cr_rec.json` → 8 条 | "Counting Rules…"（=C1 同条）、"Counting maximal distance-independent sets in grid graphs"（距离-独立集，异对象）、"A Branch and Bound Algorithm…"（完好网格算法）、"Proof Without Words…"（完好网格双射）、"On the Sizes of Maximal Independent Sets of Cylindrical Grid Graphs"（极大+柱面）、"Maximal independent sets in grid graphs"（极大侧）→ 无缺陷形计数列 |
| C3 | `hard square lattice independent sets defect` | `cr_hs.json` → 8 条 | 统计物理论文族（Hard-Square Lattice Gas 等）+ 1 条光学晶格孤子，off-target |
| C4 | `query.bibliographic` 详情（4 条题名） | `s2_deita.json` + Crossref 元数据 | 取得 De Ita et al. 2024 完整摘要与 DOI |

### 1.6 文献层 · MSE（api.stackexchange.com/2.3，通道存活）

| # | 查询串 | 回包 | 裁决 |
|---|---|---|---|
| M1 | `q="independent sets grid graph deleted"&answers=1` | `mse1.json` → 0 items，quota 216 | 有效零命中（社区层佐证） |
| M2 | `q="recurrence independent sets 3 xn grid"&answers=1` | `mse2.json` → 0 items，quota 216 | 有效零命中 |

### 1.7 形式化生态层 · GitHub code search（gh api，6 串 ≥3 义务）

| # | 查询串 | 回包 | 裁决 |
|---|---|---|---|
| G1 | `indepSetCount language:lean` | total_count **0** | 零命中 |
| G2 | `"IsIndepSet" "boxProd" language:lean` | total_count 1 = `google-deepmind/formal-conjectures:FormalConjecturesForMathlib/Combinatorics/SimpleGraph/Domination.lean` | 支配侧定义件（`computable_dom_num` 以 `[DecidableRel G.Adj]` 为前提），无网格独立集计数递推 → 非本对象占位 |
| G3 | `"indepCountHoles" language:lean` | total_count **0** | 零命中 |
| G4 | `"IsIndepSet" grid recurrence language:lean` | total_count **0** | 零命中 |
| G5 | `"IsIndepSet" deleted language:lean` | total_count 1 = `RamazanKara/erdos-617-r5-formal-verification:formal/lean/Erdos617/AlphaTwoLarge.lean` | 已取文件全文分类：Erdős 617 独立数=2 的补图论证（`Gᶜ.IsIndepSet`），无网格、无计数递推 → off-target |
| G6 | `"IsIndepSet" "pathGraph" language:lean` | total_count **0** | 零命中 |

### 1.8 形式化生态层 · 本地 mathlib rg（verify-proj/.lake/packages/mathlib 快照）

| # | 检索 | 结果 | 裁决 |
|---|---|---|---|
| L1 | `rg -i 'indepSetCount|indepCountHoles|independenceNumber|independencePoly' Mathlib/` | **0 命中** | mathlib 无独立集计数函数/定理本体 |
| L2 | `rg 'instance…DecidableRel…(Adj|adj)'` 于 `Hasse.lean`、`Prod.lean` | **0 命中** | `pathGraph`（`Hasse.lean:108` def 本体在）与 boxProd（`Prod.lean`）均无可判定实例，缺口复核成立 |
| L3 | `rg 'IsIndepSet|isIndepSet_induce|indepNum'` 于 `Clique.lean` | `IsIndepSet:907`、`isIndepSet_iff:910`、`isIndepSet_induce:953`、`Decidable (G.IsIndepSet s):926` 等 | 谓词/实例在库，**计数递推定理不在库** |
| L4 | `rg -i 'independent.*(grid|boxProd)|(grid|boxProd).*independent' Mathlib/` | **0 命中** | 库内无网格×独立集计数件 |

### 1.9 通道受阻清单（如实记录，禁写零命中）

- OpenAlex、zbMATH、通用搜索引擎：任务卡实况不可达，本轮未跑 → 期刊层（J. Integer Seq. / SIAM J. Discrete Math. 等）未能整库扫描，本档案的文献层零命中**限定于 arXiv + Crossref + MSE 三源**。
- MDPI 出版社 PDF 直链（`www.mdpi.com/2227-7390/12/6/922/pdf`）：代理下 Access Denied（bot 拦截，`deita2024.pdf` 411 B HTML）→ 改经出版社 HTML 页全文核读成功（§2），不构成受阻遗留项。
- 本轮无 curl 超时/SSL 失败项（上轮卡面的 `2-adic` 串超时已由 A11 本轮补跑清账）。

---

## §2 命中逐字引句（URL + 原文）

### 2.1 OEIS A122011 ——「数列撞名、对象不撞」的重核依据

URL：`https://oeis.org/A122011`（本轮经 jsdelivr 单条核读，`raw/A122011.seq`）

> `%N A122011 G.f. x^2*(1+x)/(1-12*x+15*x^2-2*x^3).`

> `%S A122011 0,1,13,141,1499,15899,168585,1787533,18953419,200965203,2130856217, 22593703397,239563527915,2540118496459,26933156445577, 285575226955869,3027985613779691,32106065273909411,340424149534129305`

> `%t A122011 M = {{1, 1, 1}, {1, 2, 4}, {1, 3, 9}} v[1] = {1, 0, 0} v[n_] := v[n] = M.v[n - 1] a1 = Table[v[n][[3]], {n, 1, 50}]`

> `%D A122011 "Linear Algebra, Examples and Applications" by Alain M. Robert, World Scientific, 2005, p. 58.`

> `%H A122011 <a href="/index/Rec#order_03">Index entries for linear recurrences with constant coefficients</a>, signature (12, -15, 2).`

裁决重述：对象为矩阵幂线性代数例题（%t + %D），全记录无图论字样；%S 与重算件偶位子列 11 项重叠窗口逐位相同且同 %F 三阶递推 → 数列同一、对象不同。**禁写「新递推」**（signature 已在索引），数列层挂名事实对偶位子列成立。

### 2.2 Top-3 最小必核集（按「共享对象名 + 共享性质词」相关度；三篇均达全文级核读）

**① arXiv:2507.04007**（Liang, *Independent Set Enumeration and Estimation of Related Constants of Grid Graphs and Their Variants*, v2；题名带 Variants → R-15 强制触发）
URL：`https://arxiv.org/abs/2507.04007`（全文 PDF `raw/liang2507.04007v2.pdf`，437,125 B / 26 页 / 抽文 59,508 字符，`raw/liang2507.txt`）

> "Additionally, we conducted corresponding calculations and analyses for triangular grid graphs, king graph, and cylindrical grid graph. We computed and analyzed their associated constants and compared how different adjacency and boundary conditions affect these constants."

> "Our computational results have contributed substantial new terms to the OEIS sequence A089980, A027740, A219741, A226444, A245013 and A286513."

词表实测（本轮 pypdf 抽文 + 计数）：`defect=0, vacanc=0, hole=0, missing=0, removed=0, deleted=0, characterized=0, closed form=0, exact formula=0, determining=0`；`period` 8 处全部指 periodic boundary conditions（柱面边界），例证引句：

> "We denote the enumeration of independent sets on an m×n cylindrical grid graph (with periodic boundary conditions in the horizontal direction) as N_C(m,n)."

裁决：其「variants」= 邻接变体（三角格/king）+ 边界变体（柱面），**无删点/缺陷轴**；无「completely characterized/described by」句式 → 参考文献回溯义务未被触发。**不占位。**

**② De Ita–Bello López–Marcial-Romero 2024**（*Counting Rules for Computing the Number of Independent Sets of a Grid Graph*, Mathematics 12(6):922；Crossref 两轮检索共现的最高相关期刊件，深挖卡未载，本轮新增必核）
URL：`https://doi.org/10.3390/math12060922`（出版社 HTML 页全文核读；PDF 直链 bot 拦截，见 §1.9）

> "The proposed algorithm is based on the 'branch-and-bound' technique and is applied to compute i(Gm,n) for a square grid formed by m rows and n columns."

> "the vertex division: let v∈V(G), i(G)=i(G−v)+i(G−(N[v]))"

> "the algorithm is applied to compute i(G) of Gm,n and of the Aztec diamond graph AZm,n of order m. Additionally, the method is extended to compute i(G) of instances of benzenoid systems and of (m×n)-polygonal mesh graphs."

裁决：对象 = **完好**方格网格（及 Aztec 菱形/苯环系/网格面片图）的分支限界计数算法；G−v 仅作分解规则在算法内部出现，非带周期删点的缺陷网格族计数列，全文无 z(n) 型切片、无任何删列/隔列删点形。**不占位。**（该文引言引 Golin–Leung–Wang–Yong 2005 transfer-matrix 综述，对象同为完好网格/柱面/环面，未涉缺陷切片。）

**③ arXiv:math/0701890**（Jonsson, *On the independence complex of square grids*, v2）
URL：`https://arxiv.org/abs/math/0701890`（全文 PDF `raw/jonsson0701890v2.pdf`，394,807 B / 25 页 / 抽文 138,160 字符）

> "Here we produce other families of grid graphs, with open or cylindric boundary conditions, for which similar properties hold without any size restriction: the number of independent sets of even and odd cardinality always differ by 0, 1,−1, or, in the cylindric case, by some power of 2."

裁决：对象为**完好**网格（toric/open/cylindric 边界）的偶奇计数差与独立复形同伦型；defect 词表（defect/vacanc/hole/missing/removed/delet）抽文实测 **全 0**。**不占位。**

### 2.3 次级必核件（相关度紧随其后，均全文或摘要级）

- **arXiv:2506.22317**（*Statistics of maximal independent sets in grid-like graphs*；全文 PDF `raw/mis2506.22317v1.pdf`，24 页 / 58,819 字符）
  > "We study the properties of MIS's in various types of grid-like graphs, in particular determining parity of the set of MIS's, average size of MIS's, and number of pairwise non-isomorphic MIS's in various grid-like graphs."
  R-15 触发（"determining"）已全文核读：对象为**极大**独立集且图族为完好 grid-like 曲面（torus/Möbius）；"every other" 唯一一处为自同构语境（"the image of (1,1) determines the images of every other vertex under ξ"），非隔列删点。**不占位。**
- **arXiv:1006.4253**（Trinks, *The Merrifield-Simmons conjecture holds for bipartite graphs*, v2；全文 PDF `raw/trinks1006.4253v2.pdf`，8 页 / 14,563 字符）
  > "By G−W we denote the graph G where all vertices v ∈ W are deleted, that means these vertices and their incident edges are removed."
  > "We prove that the conjecture holds for bipartite graphs by considering a generalization of the term, where vertex subsets instead of vertices are deleted."
  裁决：「删点（含删点集）图的独立集数 σ(G−W)」作为**量**在文献在场（结论为符号关系，非计数列）→ 措辞约束载体，非本对象占位。
- **arXiv:1401.1596**（Trinks, *The Merrifield-Simmons conjecture also holds for parity graphs*；摘要级，`raw/arxiv_top3_abs.xml`）
  > "The Merrifield-Simmons conjectures states a relation between the distance of vertices in a simple graph G and the number of independent sets, denoted as σ(G), in vertex-deleted subgraphs."
  裁决：奇偶关系结论、无网格对象 → 非占位。
- **arXiv:1709.03678**（*Maximal independent sets on a grid graph*；摘要级）——极大侧 + 完好网格 + 熵常数，非本对象。
- **gh 命中二件**：`google-deepmind/formal-conjectures …/Domination.lean`（支配侧定义件）；`RamazanKara/erdos-617-r5-formal-verification formal/lean/Erdos617/AlphaTwoLarge.lean`（Erdős 617，`Gᶜ.IsIndepSet` 补图论证）。均非网格独立集计数递推件。

---

## §3 四态裁决与依据

**裁决：查无占位。**

依据链（全部为本轮自取证据）：

1. **通道有效性三重坐实**：OEIS 阳性对照 A051736 命中（`oeis_posctrl.json` + 单条核读）；arXiv 通道 12 串全回包（含 0-entry 回包），无 curl 失败项；Crossref `status ok`、MSE `quota_remaining=216` 回包正常。三通道无「全灭」情形，不落入未裁决。
2. **OEIS 层**：数串 5 条（主串/去首 1/去首 2/奇位/偶位）中 4 条 null 零命中；偶位子列命中 A122011，经单条核读判「数列撞名、对象不撞」（§2.1）——**数列层挂名对偶位子列成立，对象层（隔列挖点三行带独立集计数）无挂名**。±1 变体与签名串均无本对象。判例路径（退化首项、插零、按行存储切片）已由前缀三变体 + 双子列分查覆盖。
3. **文献层**：R-16 四口径逐条执行（zeros 口径删除已注理由）；12 条 arXiv 串 + 3 条 Crossref 串 + 2 条 MSE 串中，全部「共享对象名×性质词」命中（2507.04007、De Ita 2024、math/0701890、2506.22317、1006.4253/1401.1596、1709.03678）经全文或摘要级核读均为完好网格/极大侧/符号关系形态，无一含隔列删点缺陷族的计数列或递推。Top-3 最小必核集足额（3/3 全文级）。
4. **形式化生态层**：mathlib rg 四检索（计数本体 0、可判定实例缺口复核成立、谓词在库、网格×独立集定理 0）+ gh 六串（4 零命中、2 命中均分类 off-target）→ 三个 Lean 层（mathlib / compfiles 引深挖卡粗筛面 / 公开仓）无同形。
5. **措辞面既有约束的边界确认**：删点图独立集数作为量在文献在场（Trinks G−W；De Ita i(G−v) 分解规则），故本命题的占位判断**只覆盖**「该具体缺陷切片计数列 = 该六阶递推数列」这一形态，不覆盖「删点网格独立集计数」这一题材。

与深挖卡窄口 C 行结论的关系：四态（查无占位）与价值级（新序列级、「新递推」关闭）**独立重跑后一致**；本轮新增证据 = Crossref 期刊层命中 De Ita et al. 2024（深挖卡未载，全文核读后不改变结论，但补上了期刊通道的一块此前缺失面）、2-adic 串有效零命中（清上轮未决账）、A051736 %C 无奇偶句侧记（利于窄口 E 后续补查）。

## §4 价值级建议与措辞约束

**价值级（按 SOP 01《价值主张分级表》2026-09-29 现行文本）：新序列/新递推级——其中「新序列」半档成立、「新递推」半档不成立，落新序列级下沿。**

- 「新序列」侧：z(n) 本体（隔列挖点交错列）OEIS 五串查无挂名、对象层面无挂名 → 满足「OEIS 查无占位、对象层面无挂名」，**可立项**。
- 「新递推」侧关闭：signature (12,−15,2) 已挂 OEIS 线性递推索引（A122011 %H 逐字），且偶位子列与 A122011 数列同一 → 递推本身不新，可主张的只有「该未挂名缺陷网格计数列满足此已知签名递推 + 该列的新组合解释」。
- 不构成「新数学」（文献层有同题材在场：删点图 σ 量、完好网格计数算法、独立复形），亦不落入「首个形式化」（文献未占位本对象）；不落入「练习」（mathlib/compfiles/公开仓均无同形）。

**措辞约束建议（对本命题对外表述的硬约束）**：

1. 禁写「新递推」——signature (12,−15,2) 已在 OEIS 索引（A122011 %H）；禁写「全新递推/首个发现该递推」。
2. 禁写「无人研究过删点网格的独立集计数」——σ(G−W) 作为量在 Merrifield–Simmons 线（arXiv:1006.4253）与分支限界算法文献（De Ita 2024 的 i(G)=i(G−v)+i(G−N[v]) 分解）在场；只可主张「该具体缺陷切片（每隔一列挖中行顶点）的独立集计数列未被挂名/未被作为研究对象」。
3. 提及偶位子列时必须同句披露「与 OEIS A122011 数列逐位相同、对象不同（矩阵幂线性代数例题）」；奇位子列披露为「OEIS 查无挂名」。
4. 递推主张的限定语：六阶形 z(n)+15z(n−4)=12z(n−2)+2z(n−6)（n≥6，ℕ 无减法）作为 z(n) 的**刻画**成立；不主张该递推本身为新。
5. 价值级表述用「新序列级（下沿：未挂名数列 + 新组合解释）」，禁越级至「新数学」。

**遗留/移交**：①文献层零命中限定于 arXiv + Crossref + MSE 三源，OpenAlex/zbMATH 通道恢复后无需重跑本 slot 主结论（本对象在可及三源已充分收口），但如需期刊层整库扫描（J. Integer Seq. 侧网格计数列专项）可补一轮；②statement 冒烟（lean-verify --allow-sorry，主代理自证 exit 0）不在本查新员职责面，未复验。
