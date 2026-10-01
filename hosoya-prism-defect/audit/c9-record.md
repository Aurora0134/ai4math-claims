# c9-record.md — 全量查新记录（三源逐字拼接；结论不改写，SOP 08b 工序 4）

> 拼接顺序与来源（逐字，byte-for-byte，仅文件间加分隔线）：
> ① tasks/20260929-preselect-deeprecheck-01/c9-recheck/L14C/dossier.md（sha256 e9734942f6cc914bde6941983f47b85316283856b42b33dafe6c486a2735ae49）
> ② tasks/20260929-l14c-graphside-deep/audit/c9-increment-graphside.md（sha256 686f28b234aafacf078a324075927d5a081411798fafa4ff142bd7867f319daf）
> ③ tasks/20260929-preselect-deeprecheck-01/audit/confirm-L14C.md（sha256 4f4f6866ed6c966e8a2fa7916381f991c0b122a3818a3d4a43ad3f01e8bc7113）

---

# L14C 命题级 C9 独立查新 dossier（#pre-lin-04 窄口 C：棱柱删 spoke / 删 rim 双切片）

- 日期：2026-09-29；执行体：选题院独立查新员（本会话）
- 命题：棱柱图 C_n□P_2 删一条 spoke（横档）与删一条 rim（周长边）两切片的全匹配数列 aspoke/arim 满足棱柱母体四阶递推 x(n+4)=2·x(n+3)+4·x(n+2)−x(n)，且各有 mod 2/4/8 精确残留样式（与恒偶的母体分叉）；两数列在 OEIS 与文献层查无挂名（新序列级；母体 A102080 已挂名不主张，mod 3 不主张）。
- 纪律声明：①本卡全部结论只依据本轮自跑检索；深挖卡 `tasks/20260928-lineage-recon-01/deep/L14-…md` 仅当查询线索，其零命中/占位/引句结论无一采信；②全部 curl 原始回包落 `raw/`（58 个文件）；③引句逐字带 URL；④零命中均有同批阳性对照支撑。
- 数值基线：送检串全部取自本批重算 `tasks/20260929-preselect-deeprecheck-01/compute/L14C/results.json`（三路异构一致），未用深挖卡旧串。

---

## §1 查询台账

### 通道 A：OEIS（14 串）

| # | 查询串 | 返回 | 裁决 |
|---|---|---|---|
| A-1 | 阳性对照：母体串 `32,108,342,1104,3544,11396`（`oeis.org/search?q=…&fmt=json`） | **命中 A102080**，name 逐字 `Number of matchings in the C_n X P_2 (n-prism) graph.`，data 首段 `2,12,32,108,342,1104,3544,…`（本批母体重算 32,108,342,1104,3544,11396 = A102080 a(3..8)，逐位对上） | **对照 PASS**；同时独立坐实母体挂名与重算正确性 |
| A-2 | aspoke 主串 `25,86,271,876,2811,9040` | `null` | 零命中（真） |
| A-3 | aspoke 去首1 `86,271,876,2811,9040,29053` | `null` | 零命中（真） |
| A-4 | aspoke 去首2 `271,876,2811,9040,29053,93390` | `null` | 零命中（真） |
| A-5 | arim 主串 `26,86,274,883,2836,9118` | `null` | 零命中（真） |
| A-6 | arim 去首1 `86,274,883,2836,9118,29306` | `null` | 零命中（真） |
| A-7 | arim 去首2 `274,883,2836,9118,29306,94201` | `null` | 零命中（真）——**深挖卡缺此形，本批补齐**（results.json notes 已记） |
| A-8 | 关键词 `mutilated prism matchings` | `null` | 零命中（真） |
| A-9 | 关键词 `defective prism matching` | `null` | 零命中（真） |
| A-10 | 关键词 `prism graph deleted edge matchings` | `null` | 零命中（真） |
| A-11 | 关键词 `Hosoya index prism rung` | `null` | 零命中（真） |
| A-12 | 关键词 `monomer dimer ladder deleted rung` | `null` | 零命中（真） |
| A-13 | 递推签名串 `2*a(n+3)+4*a(n+2)-a(n)` | 1 命中 **A88305**（name 逐字 `a(0) = 1, a(n) = Fibonacci(2*n). It has the property that a(n) = 1*a(n-1) + 2*a(n-2) + 3*a(n-3) + 4*a(n-4) + ...`） | 模糊关键词匹配的**无关对象**（Fibonacci 半行，非棱柱、非删边）；非同形命中，不构成占位 |
| A-14 | jsdelivr 单条核读 `cdn.jsdelivr.net/gh/oeis/oeisdata@main/seq/A102/A102080.seq` | 3,639 bytes，%N/%C/%F/%H 逐字到手（§2-Q1） | 单条通道本批**可用**（深挖卡记的 jsdelivr 受阻不复现）；母体 %F 栏含递推本体与 signature (2,4,0,-1) |

别名先行交代（纪律 4）：prism = n-prism = C_n□K_2 = cycle prism = circular ladder（2n 顶点口径）；spoke = rung（横档）；rim = perimeter/outer edge；matching = independent edge set = monomer-dimer covering；全匹配数 = Hosoya index = Z-index。A-8..A-12 五串按此别名集构造。

### 通道 B：文献层（arXiv 9 串 + Crossref 8 串 + MSE 7 串）

**arXiv export API（直连 https；本轮实测 `%20` 编码会被 API 丢弃、须用 `+`）**

| # | 查询串 | total | 裁决 |
|---|---|---|---|
| B-1 | 阳性对照 `id_list=2003.09602,1905.13165,2608.30601` | 3 entries，题名逐字正确 | **对照 PASS** |
| B-2 | `all:"prism graph" AND all:"number of matchings"` | 0 | 零命中（真） |
| B-3 | `all:"Hosoya index" AND all:prism` | 0 | 零命中（真） |
| B-4 | `all:"matching polynomial" AND all:prism` | 1 | 唯一命中 = Gaussian boson sampling 对偶（arXiv:1910.04022，量子计算框架，"graph matching polynomials" 指 GBS 位移多项式与图匹配多项式的对偶，与棱柱无关）→ 无关 |
| B-5 | `all:"monomer-dimer" AND all:prism` | 2 | 命中为水单体/二聚体振动谱（化学）→ 无关 |
| B-6 | `all:"deleted edge" AND all:matchings AND all:graph` | 15 | Top-10 全为动态图匹配算法/谱刻画类 CS 文献，无一为「固定图族删边匹配计数序列」→ 无同形 |
| B-7 | `all:prism AND all:matchings AND all:modulo` | 0 | **R-16 period/整除口径零命中（真）** |
| B-8 | `all:"Hosoya index" AND all:parity` | 0 | **R-16 整除/奇偶口径零命中（真）** |
| B-9 | `ti:"prism graph"` | 10 | 题名层全扫：Equitable Choosability / tropical plane curves / Radio numbers / 凸弱凸支配 / Effective Resistances+Kirchhoff / Coprime Labelings / edge geography / Metric Dimension / **PMH 性质（2411.09724，摘要逐字核读）** / **Exact Dominion（2601.03488，全文核读）**。除 2411.09724 与 2601.03488 外其余 8 条性质词（染色、 resistence、标号、维数）与匹配计数不相交。 |

**R-15 / Top-3 最小必核集（任务卡点名 3 篇 + 本轮自查新增 2 篇全文关闭）**

| 文献 | 本轮取证 | 判决 |
|---|---|---|
| ① Young arXiv:1905.13165 *Generating Functions for Domino Matchings in the 2×k Game of Memory* | ar5iv 全文 259,781 bytes（`ar5iv.labs.arxiv.org/html/1905.13165`）；口径句与 Concerned-with 栏逐字到手（§2-Q3） | **不同形**：对象 = 2×k grid（梯子），缺陷 = 删**顶点对**（含关联边）且**按所有删除方式聚合**；本命题 = 棱柱删**单条边、固定位置、逐位序列**。其聚合口径里甚至不含本命题的单独一项。不占位 |
| ② Lekshmi–West arXiv:2003.09602 *The Number of Perfect Matchings in Möbius Ladders and Prisms* | 摘要逐字（本批 arXiv API 自取，§2-Q2）；ar5iv = 5,786 bytes 桩页（与上批同码）→ **全文不可得，如实记** | **不同形**（摘要层）：统计量 = 母体**完美**匹配数（F_{n-1}+F_{n+1}(+2)），无删边缺陷、非全匹配/Hosoya。R-15 判定说明：该篇与命题**对象状态**（无缺陷母体）与**性质词**（perfect matchings ≠ 全匹配数）均不同，不满足 R-15「共享对象名+性质词」双条件，故不阻「查无占位」收口；残余敞口按「全文不可得」单独记档 |
| ③ Farrell 1983 *Forest decompositions of ladders* | Crossref DOI `10.1016/0012-365x(83)90190-5` 题录逐字核实（§2-Q4）：Discrete Mathematics, 1983, vol 44, pp 267–274；全文 ScienceDirect 付费墙不可得 | **对象 = ladders（梯子），不压棱柱侧**——任务卡要求的划分已由本轮独立核实（题名对象即 ladder，非 cycle×edge）。统计量 = 森林分解（不同族口径）。残余敞口如实记：全文未读 |
| ④ 附加：Agarwal–Basak arXiv:2608.30601（B-1 对照带入，同对象 circular ladder） | 摘要逐字（含 `determining` 刻画词 → 触发 R-15）+ ar5iv 全文 483,194 bytes 扫描：`Hosoya` 词频 **0**、`delet` 词频 3（样板级） | **不同形**：统计量 = 独立集/完美匹配**复形的同调型**（wedge of spheres），非匹配计数、无删边。不占位 |
| ⑤ 附加：arXiv:2601.03488 *Exact Dominion of the Prism Graph: Enumeration by Congruence Class via Cyclic Words*（B-9 扫出，2026-01 新文献，**深挖卡未覆盖**） | 摘要逐字（含 `explicit formulas` 刻画词 → 触发 R-15）+ ar5iv 全文 406,110 bytes 核读：定理清单全部为 dominion/支配（Theorem 3.1 "Exact dominion of the prism" 等 20+ 条），全文 `matching` 词频 **0** | **同对象（C_n□P_2）不同参数（支配/dominion，按 n mod 4 分层的显式公式）**；与匹配计数无交。不占位——此条同时演示了独立重跑的价值：题录级 sweep 会把它当「同对象同『精确枚举』词」高估，全文层一读即排除 |

**Crossref（走代理）**

| # | 查询串 | 返回 | 裁决 |
|---|---|---|---|
| B-10 | `matchings prism graph deleted` | total=415,046，Top5 无一相关 | 无同形 |
| B-11 | `Hosoya index prism graph` | total=1,420,809，Top5 = 别类图（非对称循环图/零因子图/四环图）的 Hosoya 指数论文 | 无「棱柱删边」同形 |
| B-12 | `number of matchings prism graph` | total=584,185，Top5 = theta 图/线图/Pfaffian 等它类 | 无同形 |
| B-13 | `monomer dimer prism lattice matching` | total=349,395，Top5 = 物理格点模型 | 无同形 |
| B-14 | `defective prism graph matching` | total=388,775，Top5 无关（含激光棱镜光谱仪咖啡豆分拣） | 无同形 |
| B-15 | DOI 复核 `10.1063/1.526778` | Hosoya–Motoyama 1985，J. Math. Phys. 26, 157–167，题录逐字（§2-Q5） | 母体侧挂名链闭环（A102080 %H 所引即此文） |
| B-16 | `Farrell Matchings in ladders 1978` | 1978 Ars. Combin. 原文**不在 Crossref**（Top5 无此条） | 该条记**未裁决**（梯子侧，不压本命题）；1983 篇已另证 ladder 对象 |

**MSE（api.stackexchange.com 2.3，走代理 --compressed）**

| # | 查询串 | 返回 | 裁决 |
|---|---|---|---|
| B-17 | 阳性对照 `q=Hosoya index` | 1 命中 = **3275954** "Proof for a recursive relation for counting matching in a graph" | **对照 PASS**；该帖同时是匹配计数**顶点分支装置**的教学层占位（装置级，非切片级，答案逐字见 §2-Q6） |
| B-18 | `q=number of matchings in the prism graph` | items=0 | 零命中（真） |
| B-19 | `q=mutilated prism matching` | items=0 | 零命中（真） |
| B-20 | `q=ladder graph matching deleted rung` | items=0 | 零命中（真） |
| B-21 | `q=matchings graph deleted edge recurrence` | items=0 | 零命中（真） |
| — | 取样瑕疵如实记：首跑 `prism graph matchings` 一串误把文件名后缀拼进查询词（`mse1`），已作废并用 B-18 干净串重跑；3275954 问答正文与两条答案已逐字核读（§2-Q6） | | |

### 通道 C：形式化生态层（gh 6 串 + 本地 rg 5 串）

| # | 查询串 | 返回 | 裁决 |
|---|---|---|---|
| C-1 | `gh api search/code q=hosoya+language:Lean` | total=**0** | 零命中（真） |
| C-2 | `q=matchingCount+language:Lean` | 命中 google-deepmind/formal-conjectures 的 LovaszPlummerConjecture.lean + 两个统计仓 | 疑似命中已逐文件核实：Lovász–Plummer **猜想形式化**（grep `prism|hosoya` = 0 次，§2-Q7），CausalSmith 两仓为统计代码 → 均非切片计数；无同形 |
| C-3 | `q=prism+matching+language:Lean` | 命中 kevinsullivan/fpConcepts FP_prism.lean + kakeya-3d 几何棱柱 | FP_prism.lean 逐字核实 = **函数式编程 optics**（"Prisms are optics that focus on one branch of a sum type"，§2-Q8），kakeya = ℝ³ 几何棱柱 → 均非图论棱柱；无同形 |
| C-4 | `q=deleteEdges+matching+language:Lean` | 命中 mathlib4 本体 Matching.lean + matroid 仓 | 库内既有文件，无切片计数内容 |
| C-5 | 阳性对照 `q=IsMatching+language:Lean` | 命中 leanprover-community/mathlib4 等 | **对照 PASS** |
| C-6 | `q="prism graph"+language:Lean` | total=**0** | 零命中（真） |
| C-7 | 本地 rg：`(?i)hosoya|matchingPolynomial|monomer|dimer|kekule` 于 verify-proj/.lake/packages/mathlib/Mathlib | **0 行**（二次复核 wc -l = 0） | 零命中（真） |
| C-8 | 本地 rg 阳性对照：`rg -l 'IsMatching' …/SimpleGraph` | 4 文件（Hall/Matching/UniversalVerts/Tutte） | 检索面有效 |
| C-9 | 本地 grep：Matching.lean 顶层声明计数 | 639 行 / 55 条顶层声明；含 count/card 的仅 parity 型（`IsMatching.even_card:247`、`IsPerfectMatching.even_card:265` 等） | **零计数定理**（与深挖卡"50 条/639 行"线数一致，声明计数差异为其 grep 模式不含 structure/abbrev 所致，非矛盾） |
| C-10 | 本地 rg：`def (prismGraph|ladderGraph|mobiusLadder)` | 0 | mathlib 无三专名图定义 |

---

## §2 命中逐字引句（URL + 原文）

**Q1（OEIS A102080，阳性对照兼母体挂名本体）**
URL: `https://cdn.jsdelivr.net/gh/oeis/oeisdata@main/seq/A102/A102080.seq`（3,639 bytes）
- %N：`Number of matchings in the C_n X P_2 (n-prism) graph.`
- %C：`Also the Hosoya index of the n-prism graph Y_n. - _Eric W. Weisstein_, Jul 11 2011`
- %F：`a(n) = 2*a(n-1) + 4*a(n-2) - a(n-4) for n>4.`（= 命题所用母体四阶递推本体；同条目 `%H` 侧栏 `Index entries for linear recurrences with constant coefficients, signature (2,4,0,-1).`）
- %H：`H. Hosoya and A. Motoyama, <a href="https://doi.org/10.1063/1.526778">An effective algorithm for obtaining polynomials for dimer statistics. Application of operator technique on the topological index to two- and three-dimensional rectangular and torus lattices</a>, J. Math. Physics 26 (1985) 157-167 (Eq. (23) and Table IV).`

**Q2（Lekshmi–West 摘要，本批自取）**
URL: `https://export.arxiv.org/api/query?id_list=2003.09602,1905.13165,2608.30601`（raw/arxiv_pc_ids.xml）
- `We give the exact formula for the number of perfect matchings in two families of $3$-regular graphs. In the graph consisting of a $2n$-cycle with diametric chords (also known as the Möbius ladder $M_n$ and a Harary graph) and in the cartesian product of the cycle $C_n$ with an edge (called the cycle prism), the number of matchings is the sum of the Fibonacci numbers $F_{n-1}$ and $F_{n+1}$, plus two more for the Möbius ladder when $n$ is odd and for the cycle prism when $n$ is even.`
- 判形依据：统计量 = **完美匹配**、对象 = **无缺陷母体**；命题 = 删边切片**全匹配**（Hosoya）。

**Q3（Young 全文口径句 + 关联序列栏）**
URL: `https://ar5iv.labs.arxiv.org/html/1905.13165`（259,781 bytes；raw/ar5iv_1905.13165.html）
- 引言逐字：`We may therefore compute the D_{k,v,h} by computing the matching numbers for the graphs which arise from removing v vertical, and h horizontal vertex pairs (and their incident edges), from the 2×k grid graph in all possible ways.`
- 文末逐字：`Concerned with sequences A000045, A046741, A055140, A079267, A178523, A265167, A318243, A318244, A318267, A318268, A318269, A318270, A325753, and A325754 )`——无本命题两切片（aspoke/arim 均不在册，OEIS 侧亦零，见 A-2..A-7）。
- 摘要逐字（arXiv API 自取）：`We consider the sum of matching numbers over the graphs obtained by deleting $h$ horizontal and $v$ vertical vertex pairs from the $2\times k$ grid graph in all possible ways, providing a generating function for these aggregate matching polynomials.`

**Q4（Farrell 1983 题录）**
URL: `https://api.crossref.org/works/10.1016/0012-365x(83)90190-5`（raw/crossref_farrell1983.json）
- 逐字字段：`title = Forest decompositions of ladders` | `container-title = Discrete Mathematics` | `issued = 1983` | `author family = Farrell` | `volume = 44` | `page = 267-274`。全文（Elsevier）不可得。

**Q5（Hosoya–Motoyama 1985 题录）**
URL: `https://api.crossref.org/works/10.1063/1.526778`（raw/crossref_hosoya1985.json）
- 逐字字段：`title = An effective algorithm for obtaining polynomials for dimer statistics. Application of operator technique on the topological index to two- and three-dimensional rectangular and torus lattices` | `Journal of Mathematical Physics` | `1985-01-01` | `['Hosoya','Motoyama']` | vol 26, 157–167。

**Q6（MSE 3275954，装置级占位证据）**
URL: `https://api.stackexchange.com/2.3/questions/3275954/answers?site=math&sort=votes&filter=withbody`（raw/mse_3275954_answers.json）
- 非采纳答案（answer_id 3276296）逐字：`Consider vertex number $n$. There are two cases. Either vertex $n$ is not matched with anything, in which case there are $M_{n-1}$ matchings on the remaining $n-1$ vertices, or vertex $n$ is matched with something. In the latter case, there are $n-1$ choices for the vertex that vertex $n$ is paired with, then $M_{n-2}$ ways to match the other $n-2$ vertices.`
- 定性：**一般图匹配计数递推装置**的教学层在场（对窄口 A 式底座构成占位）；与「棱柱删边切片序列的挂名」无涉——装置在册 ≠ 数列在册。

**Q7（Lovász–Plummer 猜想形式化排除）**
URL: `https://raw.githubusercontent.com/google-deepmind/formal-conjectures/main/FormalConjectures/Wikipedia/LovaszPlummerConjecture.lean`
- 本批核读：全文 grep `prism|hosoya` 计数 = 0；系猜想级形式化（3-正则图完美匹配数指数下界），非切片计数。

**Q8（fp_prism.lean 排除）**
URL: `https://raw.githubusercontent.com/kevinsullivan/fpConcepts/master/FPConcepts/FP_prism.lean`
- 文件头逐字：`Prisms are optics that focus on one branch of a sum type, allowing safe matching and construction.`——FP optics 语义，非图论棱柱。

**Q9（2601.03488 同对象不同参数）**
URL: `https://export.arxiv.org/api/query?search_query=ti:%22prism+graph%22`（摘要）；`https://ar5iv.labs.arxiv.org/html/2601.03488`（全文 406,110 bytes）
- 摘要逐字：`Let G_n = C_n square P_2 denote the prism (circular ladder) graph on 2n vertices. By encoding column configurations as cyclic words, domination is reduced to local Boolean constraints on adjacent factors. This framework yields explicit formulas for the dominion zeta(G_n), stratified by n mod 4, with the exceptional cases n in {3, 6} confirmed computationally.`
- 全文核读：节标题 `3 Main results: exact dominion formulas`；定理清单全为 dominion/支配（`Theorem 3.1 (Exact dominion of the prism)`、`Lemma 2.1 (Local domination constraints)` 等）；全文 `matching` 词频 = **0**。

**Q10（2608.30601 同调型排除）**
URL: `https://ar5iv.labs.arxiv.org/html/2608.30601`（483,194 bytes）
- 摘要逐字（节选）：`In this article, we determine the homotopy types of these complexes for the Möbius ladder graphs $M_{2n}$ and circular ladder graphs $\mathcal{C}_{2n}$.`…`with the numbers and dimensions of the spheres exhibiting periodic behavior according to $n$ modulo $4$.`
- 全文扫描：`Hosoya` = 0 次、`delet` = 3 次（样板级）→ 无删边匹配计数内容。

---

## §3 四态裁决

**裁决：查无占位（可达通道口径）。**

依据（三条通道均有同批阳性对照，零命中为真）：

1. **OEIS 层**：两切片六形送检串（含深挖卡缺的 arim 去首 2 形）全 `null`；5 条别名关键词串全 `null`；递推签名串仅无关命中 A88305。阳性对照 A-1 命中 A102080 且母体重算串逐位对上 A102080 a(3..8)——传输与解析有效，零命中可信。
2. **文献层（可达面 = arXiv/Crossref/MSE）**：21 串查询，相关度最高命中逐一经全文/题录级核读并判不同形：Young（梯子删顶点对聚合）、Lekshmi–West（母体完美匹配）、Farrell 1983（ladder 对象，题录核实）、2601.03488（同对象但参数 = dominion，全文 `matching` 词频 0）、2608.30601（同调型）、2411.09724（PMH 哈密顿性质）。R-16 四口径交代：period/整除口径已查（B-7、B-8 双零）；**valuation 删除**——理由：命题主张面是 mod 2/4/8 精确残留样式本身，非「v_p 完全刻画」形态，且该面经 B-3/B-8（Hosoya×prism、Hosoya×parity）间接覆盖为零；**zeros/apparition 删除**——理由：两序列为正计数序列，无零点面，「a(n)≡0 (mod m) 的 n 集」读法已被残留样式主张（命题本体）覆盖。
3. **形式化生态层**：gh code search 六串（hosoya=0、"prism graph"=0、三条疑似命中逐文件排除）、本地 mathlib rg 五串（hosoya 词族 0 行、Matching.lean 零计数定理、无棱柱/梯子专名定义）；IsMatching 对照双通过。
4. **残余敞口（如实记，不翻案理由）**：期刊全文层（OpenAlex/zbMATH/出版社直查/CNKI 中文层）本环境不可达。但已核实全部受阻件的对象面均与本命题主张面（**棱柱删单边的全匹配序列 + mod 2/4/8 残留样式**）不相交：Farrell 1978/1983 = ladders（题名对象，本轮 Crossref 独立核实），Lekshmi–West 全文不可得但其摘要口径 = 无缺陷母体完美匹配，且母体侧已由 A102080 %H→Hosoya–Motoyama 1985 链闭环。因此本批四态收「查无占位」，**带「可达通道口径」限定词**；若期刊直查通道恢复，升格「新数学」前须补 Farrell 两篇全文核读。
5. **与深挖卡线索的关系**：全部结论本轮自取。差异三处：①补齐 arim 去首 2 形送检（卡面缺）；②新抓到并全文关闭 arXiv:2601.03488（2026-01 文献，卡面 Crossref 通道天然漏 arXiv-only 新文献）；③深挖卡记的 jsdelivr 单条通道受阻本批不复现（A102080.seq 3,639 bytes 正常）。

---

## §4 价值级建议（按 SOP 01《价值主张分级表》2026-09-26 原文，2026-09-29 复核维持）

**价值级 = 新序列/新递推（第二级）→ 可立项。**

- 依据行：`新序列/新递推 | OEIS 查无占位、对象层面无挂名 | 可立项`——本轮 OEIS 六形零命中 + 可达文献层/形式化生态层无挂名，两条前半句证据齐备。
- **不越级主张「新数学」**：新数学级要求「文献层（arXiv/专著）无同形结果」的全称断言，而期刊直查通道不可达、Farrell 1983 全文未读——全称断言超出本轮可达证据面，禁止。
- 不主张项（命题自带，本轮复核维持）：母体 A102080 挂名（%N/%F 逐字在册，Q1）；mod 3 一律不主张（母体与切片同属一 26-循环的实测分叉 absent，Klaška 泛初值口径规避）。

**措辞约束建议**（外交部/报告签发侧执行）：

1. 允许的表述形：「两条删边切片序列在 OEIS 六形（原串/去首 1/去首 2 × 2 切片）检索与可达文献层（arXiv export API / Crossref / MathOverflow·MSE API）查无挂名（2026-09-29 本机复核，阳性对照 A102080 命中）」。
2. 禁止的表述形：「文献中不存在棱柱删边匹配计数的研究」「首次研究缺陷棱柱匹配」——全称断言；正确措辞见上条，主语是「查无挂名」不是「无人研究」。
3. 递推主张措辞：写「两切片序列与母体 A102080 **同谱**（signature (2,4,0,−1) 四阶递推）而初值不同」，**禁止写「新递推」**（A102080 %F 栏 `a(n) = 2*a(n-1) + 4*a(n-2) - a(n-4) for n>4.` 逐字在册，递推本体已挂名）。
4. 同余主张措辞：写「mod 2/4/8 精确残留样式，与恒偶母体分叉（母体 mod 2 ≡ 0；aspoke 周期 2 ⟨1,0⟩；arim 周期 4 ⟨0,0,0,1⟩）」，数据面 k=0..70 验证 + Lean 终态证明双轨表述；mod 3 不出现。
5. 「首个形式化」表述不适用于本命题价值级（那是文献已占位情形的级名）；本命题按第二级走，Lean 侧三层零同形的事实可如实并列陈述（gh 六串 + mathlib rg 五串 + 对照有效），但不作为级名。
6. 残余敞口须在报告附一行：「期刊全文层（OpenAlex/zbMATH/出版社直查）本环境不可达；受阻件（Farrell 1978/1983、Lekshmi–West 全文）经题名/摘要核实对象面与命题不相交」——不隐瞒、不放大。
7. 立项形态仍照深挖卡窄口 C（形态甲：纯同余刻画三定理 ×2 切片，序列由递推定义、前置成本 ≈0）；C1「删边型缺陷是否在 2026-09-27 放行句内」归闸门一裁，本 dossier 不代裁。

---

## 附：raw 回包索引（同目录 `raw/`，58 文件）

- OEIS：`pc_parent.json`、`oeis_aspoke_{orig,drop1,drop2}.json`（均 null）、`oeis_arim_{orig,drop1,drop2}.json`（均 null）、`oeis_k_*.json`（5 串 null）、`oeis_k_recurrence_sig.json`（A88305）、`a102080.seq`
- arXiv：`arxiv_pc_ids.xml`、`arxiv_ax_*.xml` ×9、`dbg1.xml`/`dbg2.xml`（编码调试取证）、`ar5iv_1905.13165.html`、`ar5iv_2003.09602.html`（桩页）、`ar5iv_2601.03488.html`、`ar5iv_2608.30601.html`
- Crossref：`crossref_cr_*.json` ×5、`crossref_farrell1983.json`、`crossref_hosoya1985.json`、`crossref_farrell1978.json`
- MSE：`mse_pc_hosoya.json`、`mse2_*.json`、`mse_mutilated.json`、`mse_delrec.json`、`mse_prism_match.json`（作废串留痕）、`mse_3275954_answers.json`
- gh：`gh_*.json/.err` ×6、`fp_prism.lean`、`lovasz_plummer.lean`

---

# C9 增量查新台账：L14C 图侧陈述（棱柱删边匹配计数的图侧命题）

- 日期：2026-09-29；执行体：会话侧 C9 检索子代理（官方直连会话派发，非 relay；按 budget.log 口径不入采样栏，收口披露计数 = 本子代理 1 次、零 LLM 调用、零 compile）
- **对象（图侧命题）**：棱柱图 C_n □ P_2 删一条边（spoke 或 rim，两端点保留）的匹配数（Hosoya 指标）满足四阶递推 x(n+4) = 2·x(n+3) + 4·x(n+2) − x(n)，初值 25,86,271,876（spoke 切片）/ 26,86,274,883（rim 切片）；下标 0 对应图侧 n=3（数据锚：prismDelSpoke 3=25 / 4=86、prismDelRim 3=26 / 4=86，已由本任务 `smoke/graphside-statability-v3.lean` native_decide 实证）
- **增量口径**：只查「以图侧定理形式陈述的棱柱删边匹配计数」在文献层 / 形式化生态层是否占位。序列侧（六形 OEIS 零挂名、别名关键词零、A88305 模糊命中等）继承 `tasks/20260929-preselect-deeprecheck-01/c9-recheck/L14C/dossier.md`，**不重跑**（41 条在案）。
- **端点实况**：`scripts/endpoint-detect.sh` 开工实测 L4 unknown（卡面 O-1 留档，用户 2026-09-29 指令在案）；本批为零 LLM 调用检索（curl / gh / rg 直取），无节点路由风险。
- **纪律声明**：① 全部回包落 `c9-graphside-raw/`（29 文件）；② 判「不同形」均附逐字证据；③ 零命中均有同批阳性对照；④ 通道不可达只记「未裁决」，禁写零命中。

---

## §1 增量结论

**裁决：查无占位（可达通道口径）。**

一句判据：本批 31 条查询（arXiv 6 / Crossref 4 / MSE 4 / GitHub Lean 8 / 本地 mathlib 3 / OEIS 6，阳性对照 5 个全过）中，全部同族命中经题录或摘要层逐字核判为**不同形**——六类：完美匹配结构性质（PMH/PH）、匹配可扩展性、支配数（dominion/全支配）、删顶点对聚合（Young）、删边及端点（A318243，继承）、关键词撞车（GBS 对偶 / marine navigation / 化学装配 / 社媒书名）；无任何命中以图侧定理形式陈述「棱柱删单边（端点保留）的匹配数满足四阶递推、初值 25,86,271,876 / 26,86,274,883」。

边界交代（继承 + 本批新增）：母体棱柱全匹配 = A102080 在册（不主张）；Möbius 梯子全匹配 = A020877 在册（不同对象）；删边及两端点 = A318243（不同形）；梯子删顶点对聚合 = Young arXiv:1905.13165（不同形）；棱柱完美匹配数 = Lekshmi–West arXiv:2003.09602（不同形）；梯子森林分解 = Farrell 1978/1983（对象是梯子非棱柱，1983 题录已核、1978 未裁决）。

**新增证据强度说明**：本批把 OEIS 侧从「六形字符串零命中」升级为「signature (2,4,0,−1) 全库递推索引页穷举 = 4 条在册，两切片均不在册」——这是比 L14C 更强的序列侧闭环；图侧命题层面则新增 arXiv / Crossref / GitHub / 本地 mathlib 四通道共 22 条图侧口径查询，全部无同形。

---

## §2 查询台账（31 条 + 补充取证）

### 通道 1：arXiv export API（直连 https，6 条 = 5 目标 + 1 阳性对照）

| # | 查询串 | total | 裁决 |
|---|---|---|---|
| AX-0 | 阳性对照 `all:"matching polynomial"` | **107** | **对照 PASS**（通道非空） |
| AX-1 | `all:"prism graph" AND all:matching` | 2 | 两条同族均为完美匹配**结构性质**：2411.09724（PMH：完美匹配并成哈密顿圈，L14C 已全文关闭）与 **2307.04545（PH-property，本批新命中，L14C 题名 sweep `ti:"prism graph"` 漏掉——其题名为 "graph prisms"）**；均无匹配**计数**、无删边 → 不同形（逐字见 §3-Q1/Q2） |
| AX-2 | `all:"Hosoya index" AND all:prism` | 0 | 零命中（真） |
| AX-3 | `all:"matching polynomial" AND all:prism` | 1 | 唯一命中 = 1910.04022 Gaussian boson sampling 对偶（L14C B-4 已判无关；"matching polynomial" 指 GBS 位移多项式与图匹配多项式的对偶）→ 不同形 |
| AX-4 | `abs:defective AND abs:prism AND abs:matching` | 1 | 唯一命中 = 2202.03268 海事导航信息融合，"prism with three edges" 为比喻（三路传感融合）→ 关键词撞车，不同形 |
| AX-5 | `all:"delete edge" AND all:"matching count" AND all:recurrence` | 0 | **图侧命题最贴口的三词交集零命中（真）**——「删边 + 匹配计数 + 递推」无任何 arXiv 文献 |

### 通道 2：Crossref（走本机代理，4 条 = 3 目标 + 1 命中核实）

| # | 查询串 | total-results | 裁决 |
|---|---|---|---|
| CR-1 | `query.bibliographic=Hosoya+index+prism+graph+delete+edge` | 1,663,659 | Top5 全噪声（棱柱优雅标号 / 社媒书名 *Breaking the Social Media Prism* / 图网络遗忘学习）→ 无同形 |
| CR-2 | `query.bibliographic=matching+count+prism+recurrence` | 301,288 | Top5 噪声中浮出**唯一同族相关**：**Aldred–Plummer, "Matching extension in prism graphs", Discrete Applied Mathematics 221 (2017) 25–32, DOI 10.1016/j.dam.2016.12.017**（CR-2a 逐字题录核实，无摘要字段，Elsevier 全文付费墙不可得）→ 题录层判**不同形**：matching extension = n-可扩展性结构性质（完美匹配包含关系），非删边匹配**计数**、无递推；残余敞口记「全文未读」 |
| CR-3 | `query.bibliographic=defective+prism+matching` | 176,609 | Top5 全噪声（咖啡豆分拣激光棱镜 / 忽视综合征光学棱镜 / PRISM 分类学 / Aldred 同上）→ 无同形 |

### 通道 3：Math StackExchange（api.stackexchange.com 2.3 走代理，4 条 = 3 目标 + 1 阳性对照）

| # | 查询串 | items | 裁决 |
|---|---|---|---|
| MS-0 | 阳性对照 `Hosoya index` | 1（3275954，与 L14C B-17 同帖） | **对照 PASS** |
| MS-1 | `prism graph matching delete edge recurrence` | 0 | 零命中（真） |
| MS-2 | `Hosoya index prism spoke` | 0 | 零命中（真） |
| MS-3 | `matching polynomial prism graph` | 0 | 零命中（真） |

### 通道 4：GitHub Lean 生态（gh api search/code，GET 查询串形态；`-f q=` 形态本批返回 Not Found，已换 GET，8 条 = 4 任务指定 + 3 交集收敛 + 1 阳性对照）

| # | 查询串 | total | 裁决 |
|---|---|---|---|
| GH-1 | `prismGraph language:Lean` | **0** | 零命中（真）——无任何 Lean 代码含 prismGraph 标识符 |
| GH-2 | `hosoya language:Lean` | **0** | 零命中（真） |
| GH-3 | `matchingCount language:Lean` | 6 | Lovász–Plummer 猜想形式化（L14C C-2/Q7 已排除：全文 grep prism\|hosoya = 0）+ CausalSmith 统计仓 ×3 + konard/p-vs-np 尝试/反驳 ×2；交集 `matchingCount+prism+language:Lean` = **0** → 无同形 |
| GH-4 | `prism matching Lean mathlib`（松散四词） | 1008 | 需交集收敛：`prism+matching+language:Lean` = 82，distinct repos = **6**（kakeya-3d / 3d-sticky-kakeya / wang_zahl_kakeya_dimH = ℝ³ Kakeya 几何棱柱；sphere-six-complex = 拓扑奇异仿射棱柱；fpConcepts = FP optics 棱柱，L14C Q8 逐字排除；drichardson/examples = Lean 入门教程）→ 无图论棱柱匹配计数 |
| GH-5 | `prism+hosoya+language:Lean` | **0** | 交集零命中（真） |
| GH-6 | `matchingCount+prism+language:Lean` | **0** | 交集零命中（真） |
| GH-7 | 阳性对照 `IsMatching language:Lean in:file` | 106（含 leanprover-community/mathlib4） | **对照 PASS**（检索面有效） |
| GH-8 | 补充取证：GH-4 松散命中中唯一图论向线索 `5124053z-pixel/graph-conjectures` 的 `prism.tex`（main 分支 404，master 分支取到 20,265 bytes 全文核读） | — | **不同形**：对象 = G ⊠ K₂ 的一般棱柱，命题 = 全支配数 = 二部双覆盖支配数（Azarija–Henning–Klavžar 2017 定理去二部假设 + TxGraffiti H=K₂ 情形），Lean 4 sorry-free 形式化；统计量 = 支配数，非匹配计数、无删边（逐字见 §3-Q6） |

### 通道 5：本地 mathlib（rg，3 条 = 1 目标 + 2 对照）

| # | 查询串 | 命中 | 裁决 |
|---|---|---|---|
| RG-1 | `(?i)prismGraph\|prism.*matching\|hosoya\|matchingPolynomial` 于 `verify-proj/.lake/packages/mathlib/Mathlib` `*.lean` | **0 行** | 零命中（真）——mathlib 无棱柱图定义、无 Hosoya/匹配多项式任何词族 |
| RG-2 | 对照 `rg -l 'IsMatching' …/SimpleGraph` | 4 文件（Matching/Hall/Tutte/UniversalVerts） | 检索面有效（与 L14C C-8 一致） |
| RG-3 | 对照 Matching.lean 顶层声明计数 | 55 条 | 与 L14C C-9 的 55 条一致 → **零计数定理**现状无变化（继承结论维持） |

### 通道 6：OEIS 复核一击（走本机代理，6 条 = 1 送检 + 1 signature 索引 + 1 阳性 + 2 在册复核 + 1 边界）

| # | 查询串 | 返回 | 裁决 |
|---|---|---|---|
| OE-1 | 送检串 `25,86,271,876`（aspoke 主形） | `null` | 零命中（真）——继承结论「切片六形 null」抽样复核无变化 |
| OE-2 | **递推 signature 索引页** `"signature (2,4,0,-1)"` | **4 条**：A102080（棱柱全匹配，母体）、A020877（Möbius 梯子全匹配）、A316726（2×(n+2) 条带方砖/矩形铺砌）、A220563（2×n 阵列互链） | **本批最强新增证据**：signature (2,4,0,−1) 全库在册仅 4 条，**aspoke/arim 均不在册**；且四条无一为删边切片。母体挂名（A102080）独立坐实，Klaška 泛初值口径下「切片 = 同谱不同初值新序列」的 OEIS 侧封闭 |
| OE-3 | 阳性对照 `1,2,4,8,16,32`（trivial 串） | 10 条（A000079 Powers of 2 居首） | **对照 PASS** |
| OE-4 | 阳性对照（任务书指定）`2,4,12,32,88,240` | 3 条 = **A028860 / A029307 / A152035**（均为 g.f. 1/(1−2x−2x²) Pell 族：a(n+2)=2a(n+1)+2a(n)） | **事实订正**：该串**不命中 A102080**（A102080 真实数据 = 2,12,32,108,342,1104,3544,11396,36626…，见 OE-5 逐字）；它也不满足本命题四阶递推（验算：2·32+4·12−2=110≠88）。任务书「母体串须命中 A102080 附近」的预期与 OEIS 实况不符，通道有效性由 OE-3（trivial 串 10 命中）与 OE-5（id 查询精确命中）独立证明，不受影响 |
| OE-5 | 在册复核 `id:A102080` | 1 条 | 逐字：%N `Number of matchings in the C_n X P_2 (n-prism) graph.`；data `2,12,32,108,342,1104,3544,11396,36626,117732,378424,…`；%F `a(n) = 2*a(n-1) + 4*a(n-2) - a(n-4) for n>4.` → **母体在册、递推本体已挂名（不主张「新递推」，措辞约束继承 L14C §4）** |
| OE-6 | 边界 `id:A020877` | 1 条 | 逐字：%N `Number of matchings in Moebius ladder M_n.`；data `10,34,106,344,1102,3546,11394,36628,…` → Möbius 梯子**全匹配**在册（与棱柱母体数值 ±2 相邻但不同对象）；本命题切片亦不涉 Möbius 梯子 |

### 通道 7：阳性对照汇总（5 个，全过）

| 通道 | 对照串 | 结果 |
|---|---|---|
| arXiv | `all:"matching polynomial"` | 107 命中，非空 |
| MSE | `Hosoya index` | 1 命中（3275954） |
| GitHub | `IsMatching language:Lean in:file` | 106 命中（含 mathlib4） |
| 本地 rg | `IsMatching` + Matching.lean 声明计数 | 4 文件 / 55 条 |
| OEIS | `1,2,4,8,16,32` + `id:A102080` | 10 命中 / 精确 1 命中 |

（OEIS 任务书指定对照 `2,4,12,32,88,240` 的结果见 OE-4 事实订正：命中 A028860 族而非 A102080，不构成通道失效，但订正记录在案。）

---

## §3 命中逐字引句

**Q1（arXiv:2307.04545，本批新命中，PH-property）**
URL: `https://export.arxiv.org/api/query?search_query=all:%22prism+graph%22+AND+all:matching`（raw/ax1_prism_matching.xml）
- 题名逐字：`The Pairing-Hamiltonian property in graph prisms`
- 摘要逐字（判形依据段）：`In this paper we extend Fink's result by proving that given a graph $G$ having the PH-property, the prism graph $\mathcal{P}(G)$ of $G$ has the PH-property as well.`
- 判形：统计量 = 配对/完美匹配的哈密顿结构性质（存在性、保持性），非匹配数枚举、无删边 → 不同形。L14C 题名层 sweep（`ti:"prism graph"`）因题名用 "graph prisms" 未覆盖此条，本批以 `all:` 字段查询补捕——增量查新的独立价值实例。

**Q2（arXiv:2411.09724，L14C 已全文关闭，本批复核命中）**
- 题名逐字：`The Perfect Matching Hamiltonian property in Prism and Crossed Prism graphs`
- 摘要逐字：`we show that \emph{Prism graphs} $\cP_n$ are not $PMH$, except for the $Cube\ graph` → 结构性质判定，非计数、无删边 → 不同形。

**Q3（Crossref Aldred–Plummer 2017 题录，本批新命中）**
URL: `https://api.crossref.org/works/10.1016/j.dam.2016.12.017`（raw/cr_aldred2017.json）
- 逐字字段：`title = Matching extension in prism graphs` | `container-title = Discrete Applied Mathematics` | `issued = 2017-04` | `volume = 221` | `page = 25-32` | `author = R.E.L. Aldred, Michael D. Plummer`
- 判形：matching extension（匹配可扩展性，Plummer 学派 n-extendability 传统）= 结构性质；题录层无计数/递推口径。全文 Elsevier 付费墙不可得 → 记「题录层不同形 + 全文未读」残余敞口。

**Q4（arXiv:1910.04022 与 2202.03268，关键词撞车排除）**
- 1910.04022 摘要逐字：`we study the intimate relation between distributions defined over classes of samples from a GBS device with graph matching polynomials` → GBS 量子计算框架，"matching polynomial" 为对偶工具，与棱柱删边无关。
- 2202.03268 摘要逐字：`This paper scrutinizes cyber-resilience properties of marine navigation through a prism with three edges` → "prism with three edges" 为三路信息融合比喻，非图论棱柱。

**Q5（OEIS signature 索引页，本批核心新增）**
URL: `https://oeis.org/search?q=%22signature+%282%2C4%2C0%2C-1%29%22&fmt=json`（raw/oeis_sig.json）
- 逐字 4 条：`102080 | Number of matchings in the C_n X P_2 (n-prism) graph.`；`20877 | Number of matchings in Moebius ladder M_n.`；`316726 | The number of ways to tile (with squares and rectangles) a 2 X (n+2) strip with the upper...`；`220563 | Number of ways to reciprocally link elements of an 2 X n array either to themselves or to...`
- 判形：signature (2,4,0,−1) 在册全集 = 母体棱柱 + Möbius 梯子 + 两条组合等价族；**aspoke（25,86,271,876,…）/ arim（26,86,274,883,…）均不在列** → 切片序列在 OEIS 递推索引层零占位（比 L14C 的字符串六形更强的覆盖：索引页按 signature 归类，绕开送检串偏移/去首形态的穷举问题）。

**Q6（GitHub prism.tex，本批新命中，同「prism」词不同参数）**
URL: `https://raw.githubusercontent.com/5124053z-pixel/graph-conjectures/master/prism.tex`（20,265 bytes，raw/gh_prism_tex.txt）
- 摘要逐字：`For \emph{every} finite simple graph $G$ --- with no connectedness, bipartiteness or any other hypothesis --- the total domination number of the prism $G \prism \KT$ equals the domination number of the bipartite double cover $G \dprod \KT$.`…`The main theorem is formalised in Lean~4 with no \texttt{sorry}.`
- keywords 逐字：`total domination, domination, prism, Cartesian product, direct product, bipartite double cover, formal verification, Lean`
- 判形：对象词共享 "prism"（但为一般图 G⊠K₂ 口径），统计量 = 支配数族、无匹配计数、无删边；其 Lean 形式化是支配定理非匹配计数定理 → 不同形。此条同时确认：Lean 生态存在棱柱相关 sorry-free 形式化先例（方法论在场），但不构成本命题占位。

---

## §4 与 L14C dossier 的继承关系

**继承（不重跑，仍构成本批结论的底座）**：
1. OEIS 序列侧：六形送检串 null（A-2..A-7）、5 条别名关键词 null（A-8..A-12）、递推签名模糊串仅 A88305 无关命中（A-13）、jsdelivr A102080.seq 单条通道（A-14）。
2. 文献侧 R-15 最小必核集 5 篇的全部判决：Young 1905.13165（梯子删**顶点对**聚合）、Lekshmi–West 2003.09602（母体**完美**匹配）、Farrell 1983（**梯子**森林分解，题录核实）、2601.03488（同对象不同参数 = dominion，全文 `matching` 词频 0）、2608.30601（匹配复形同调型）。
3. A318243 边界（删边**及**两端点 ≠ 本命题删边端点保留）。
4. 形式化生态：gh 六串（C-1..C-6）、本地 rg 五串（C-7..C-10）、Matching.lean 零计数定理。
5. MSE B-17..B-21（含 3275954 装置级占位的定性：一般图匹配递推装置在教学层在场，装置在册 ≠ 切片数列在册）。
6. L14C §4 全部措辞约束（禁「新递推」措辞、禁全称断言、残余敞口附行句式）。

**本批新增（L14C 未覆盖）**：
1. 图侧口径的 22 条查询（arXiv 5 / Crossref 3 / MSE 3 / GitHub 8 / rg 1 / OEIS 2——其中 AX-5「delete edge × matching count × recurrence」三词交集、GH-1/GH-2 专名标识符、OE-2 signature 索引页均为图侧/生态层新角度）。
2. 三个新命中核判：arXiv:2307.04545（PH-property，题名层 sweep 漏捕案例）、Aldred–Plummer 2017（matching extension in prism graphs，Crossref 新查询浮出）、`5124053z-pixel/graph-conjectures` prism.tex（G⊠K₂ 全支配数 + Lean sorry-free 形式化）。
3. OEIS signature 索引页穷举（4 条在册、切片不在册）——序列侧证据从「字符串六形」升级为「递推签名全库索引」。
4. 任务书阳性对照串 `2,4,12,32,88,240` 的事实订正（实为 A028860/A029307/A152035 Pell 族，非 A102080；A102080 真实前缀 2,12,32,108,342,1104）。
5. A020877（Möbius 梯子全匹配）在册事实——补全「同递推签名邻域」的对象版图。

**结论兼容性**：本批「查无占位」与 L14C 同向且更强（图侧命题层无同形 + 递推签名索引层零切片）；两批合并后，「棱柱删边匹配计数」在可达通道的序列层、递推签名层、图侧命题层、Lean 生态层四层均零占位。

---

## §5 通道可达性实况

| 通道 | 状态 | 备注 |
|---|---|---|
| arXiv export API | **可达**（直连 https） | `%20` 编码被 API 丢弃、须 `+`（L14C 经验复现） |
| Crossref | **可达**（须走本机代理 127.0.0.1:4180 --ssl-no-revoke） | 3 查询 + 1 DOI 记录全部成功 |
| MSE API | **可达**（走代理 --compressed） | quota_remaining 211+，4 查询成功 |
| GitHub（gh） | **可达**（已认证 Aurora0134） | `gh api "search/code?q=…"` GET 形态可用；`gh api search/code -f q=…` 形态返回 Not Found（形态差异，非认证问题）；code search 仅覆盖已索引公开仓（结构性限制：私有/未索引仓不可见） |
| 本地 mathlib | **可达** | rg 0 命中 + 双对照有效 |
| OEIS | **可达**（走代理） | search API + fmt=json 正常；jsdelivr 未用（id 查询已足够） |
| 期刊全文层（Elsevier / zbMATH / OpenAlex / 出版社直查 / CNKI） | **未触达（继承 L14C 的既有敞口）** | Aldred–Plummer 2017 与 Farrell 1983 全文付费墙；本批不展开，按「题录层判决 + 残余敞口留档」处置 |

**未裁决项（如实记）**：① Aldred–Plummer 2017 全文未读（题录层判不同形：matching extension 为结构性质）；② Farrell 1978（Ars Comb）题录不在 Crossref（对象 = 梯子，不压棱柱侧）；③ GitHub 未索引/私有仓不可见（通道结构性限制）。

---

## 附：raw 回包索引（同目录 `c9-graphside-raw/`，29 文件）

- arXiv：`ax_pc_broad.xml`（阳性对照 107）、`ax1_prism_matching.xml`（2）、`ax2_hosoya_prism.xml`（0）、`ax3_mp_prism.xml`（1）、`ax4_defective_prism.xml`（1）、`ax5_deledge_mc_rec.xml`（0）
- Crossref：`cr1_hosoya_deledge.json`、`cr2_mc_prism_rec.json`、`cr3_defective_prism.json`、`cr_aldred2017.json`
- MSE：`mse1_prism_deledge_rec.json`（0）、`mse2_hosoya_spoke.json`（0）、`mse3_mp_prism.json`（0）、`mse_pc_hosoya.json`（1）
- GitHub：`gh_prismGraph.json`（0）、`gh_hosoya`（GET 首跑 stdout，0）、`gh_matchingCount.json`（6）、`gh_prism_mathlib.json`（1008）、`gh_prism_hosoya.json`（0）、`gh_prism_matching_and.json`（82）、`gh_mc_prism.json`（0）、`gh_pc_control.json`（106）、`gh_pc_ismatching.json`（0）、`gh_prism_tex.txt`（prism.tex 全文 20,265 bytes）
- 本地 rg：无回包文件（终端输出，0 行 / 4 文件 / 55 条声明）
- OEIS：`oeis_aspoke.json`（null）、`oeis_parent_task.json`（3 = A028860/A029307/A152035）、`oeis_trivial.json`（10）、`oeis_sig.json`（4）、`oeis_a102080.json`（1）、`oeis_a020877.json`（1）

---

# L14C 独立复核记录（confirm-L14C）

- 日期：2026-09-29；复核员：独立复核 agent（未参与本批查新与裁决）
- 纪律执行：①逐条独立重证，未采信 dossier 结论作证据；②OEIS 重查全部带同批阳性对照（A102080 命中才有效）；③只读复核，未编译 Lean（kernel 证据只读 manifest / post / own-smoke）；④差异如实记录（见下）。
- 网络通道：全部经本地代理 127.0.0.1:4180（curl -x --ssl-no-revoke），OEIS 用 fmt=json。

## 逐条复核

### 1. OEIS 两切片六形送检串零命中（同批阳性对照） — **confirmed**
本批同批重跑六串：aspoke `25,86,271,876,2811,9040` / `86,271,876,2811,9040,29053` / `271,876,2811,9040,29053,93390`，arim `26,86,274,883,2836,9118` / `86,274,883,2836,9118,29306` / `274,883,2836,9118,29306,94201` —— 全部 `null`（零命中）。同批阳性对照 `32,108,342,1104,3544,11396` 恰命中 1 条 = A102080（name 逐字 `Number of matchings in the C_n X P_2 (n-prism) graph.`），传输与解析有效性成立。抽查关键词串 `mutilated prism matchings` 复跑 0 命中。dossier raw/ 下 `pc_parent.json`（A102080）、`oeis_aspoke_orig.json`（null）、`oeis_arim_drop2.json`（null）与台账记录一致；raw 文件计数 58 与 dossier 声明相符。

### 2. A102080 母体挂名与递推 signature (2,4,0,−1) — **confirmed**
jsdelivr 单条重抓 `seq/A102/A102080.seq` = 3,639 bytes（与 dossier 记录字节数一致）。逐字到手：`%N …Number of matchings in the C_n X P_2 (n-prism) graph.`；`%F a(n) = 2*a(n-1) + 4*a(n-2) - a(n-4) for n>4.`（递推本体在册）；`%H …Index entries for linear recurrences with constant coefficients, signature (2,4,0,-1)`；`%H` Hosoya–Motoyama 链（DOI 10.1063/1.526778）；`%C Also the Hosoya index of the n-prism graph Y_n.`。`%S 2,12,32,108,342,1104,3544,11396,…` 配 `%O 1,1` → 母体重算串 32,108,342,1104,3544,11396 = A102080 a(3..8) 逐位对上。**「递推本体已挂名、valueLevel 非新递推」的判定成立。**

### 3. A-13 递推签名串无关命中（非同形占位） — **confirmed**（带差异记录）
dossier raw 文件 `oeis_k_recurrence_sig.json` 首位确为 A88305（name 逐字相符：Fibonacci(2n) 半行）——dossier 引句真实；该文件实为 10 命中（台账「1 命中」措辞不准，应为「首位无关命中」）。本批复跑同串仅得 1 命中 **A208227**（非线性递推 `a(n)=(a(n-1)^2*a(n-3)^4+a(n-2))/a(n-4)`，同样与棱柱/删边匹配无关）——OEIS 关键词检索排序时变所致。**两轮命中集均无同形（棱柱删边匹配计数）对象，承重结论「不构成占位」成立**；差异不翻案，但外交部引用时建议改写为「签名串检索仅无关对象命中（A88305/A208227，时变）」。

### 4. Farrell 1983 对象 = ladders 划分（题录层） — **confirmed**
Crossref 重抓 `10.1016/0012-365x(83)90190-5`：title=`Forest decompositions of ladders`、container=`Discrete Mathematics`、issued=1983、volume=44、page=267-274、author Farrell E.J. —— 全部逐字相符。题名对象 = ladders（非 cycle×edge 棱柱），任务卡要求的划分在题名层成立；全文付费墙不可得、dossier §3.4 已如实记残余敞口（升格「新数学」前须补全文核读——本批复核维持该限定）。

### 5. Young arXiv:1905.13165 删顶点对聚合口径不同形 — **confirmed**
ar5iv 重抓 = 259,781 bytes（与 dossier 记录字节数一致）。承重片段逐字在文：`vertex pairs (and their incident edges)`、`by computing the matching numbers for the graphs which arise from removing`、`in all possible ways`（`2×k` 连续串因 MathML 标记不连续，属排版层，非内容差异）。文末 `Concerned with sequences A000045, A046741, A055140, A079267, A178523, A265167, A318243, A318244, A318267, A318268, A318269, A318270, A325753, and A325754` 逐字一致，**无 aspoke/arim**。arXiv API 摘要句逐字到手（`…sum of matching numbers over the graphs obtained by deleting $h$ horizontal and $v$ vertical vertex pairs from the $2\times k$ grid graph in all possible ways, providing a generating function for these aggregate matching polynomials.`）→ 对象 = 2×k grid 删**顶点对**（含关联边）、按所有删除方式**聚合**；本命题 = 棱柱删**单条边、固定位置、逐位序列**——不同形判定成立，且顶点对删除型图与「棱柱减一条边（端点保留）」不是同一张图，聚合和中不含本命题单独一项。同批 B-1 三 id（2003.09602 / 1905.13165 / 2608.30601）题名对照复现（3 entries，题名逐字）。

### 6. 重算抽检：独立复算 aspoke(3)、aspoke(7) — **confirmed**
复核员自写三套独立实现（从定义建图：顶点 (i,j)→2i+j，n 条 spoke + n 条 top rim + n 条 bottom rim 环绕）：
- 方法 A：纯暴力枚举（无记忆化，n=3..6 锚点）；
- 方法 B：记忆化分支递推 count(G)=count(G−e)+count(G−{u,v})（列交错边序）；
- 方法 C：环列转移 DP（枚举 wrap 边纳入态 w∈{0..3}，列内合法组合 {无/spoke/rimT/rimB/rimT+rimB}）。

过程诚实记录：C 首版有 bug（嵌套循环漏禁 spoke+rimT 共端点组合，系统性多计），被 n=3..6 锚点暴力对拍当场抓出、自纠后三法逐位一致。结果：
- n=3..6 锚点：parent/aspoke/arim 三法逐位一致（32/108/342/1104；25/86/271/876；26/86/274/883）；
- k=0..7（n=3..10）：24 值 memo == DP == results.json 全对上；
- **aspoke(3) = Prism(6) 删一条 spoke = 876（brute+memo+DP 三证）；aspoke(7) = Prism(10) 删一条 spoke = 93390（memo+DP，锚点暴力背书）** —— 与 results.json 一致；
- 我方序列自洽：四阶递推 x(k+4)=2x(k+3)+4x(k+2)−x(k) 在自算序列上成立；恒等式 parent−aspoke=matchings(ladder(n−1)) 于 n=3..10 全成立（7,22,71,228,733,2356,7573,24342）；mod 2 样式前 8 项复现（aspoke ⟨1,0⟩、arim ⟨0,0,0,1⟩、母体恒偶）。

### 7. statement kernel 证据核验（未编译，只读既有文件） — **confirmed**
- manifest（statement.lean.transcript.jsonl.manifest.json）：postcondition `scripts/lean-verify --allow-sorry …/statement.lean` **rc=0**，verdict=ok，artifact_ok=true，endpoint=kimi、node_id=anthropic/stepfun/step-5-preview（宪条 7 快照在卡）。
- post 文件：盘面实存 `.post0.txt`（复核任务指针写 `.post1.txt`，**指针笔误，不影响证据面**）——内容 = 该命令 rc=0 + 6 处 `declaration uses 'sorry'` 警告（127/131/135/140/144/148 行 = 6 个 pat* 同余定理，statement 侧脚手架，中间轮合规）。
- audit/L14C-own-smoke.log：同 6 行警告，与 post0 一致。
- statement.lean 与 results.json 逐项核对：初值 aspoke 25/86/271/876、arim 26/86/274/883 一致；6 个样式数组（pat4a、pat8a、pat2b、pat4b、pat8b 及 aspoke mod2 条件式）与 results.json claimed_pattern 逐项相等；文件头明示「不主张递推本身的新颖性（同谱不同初值，非新递推）」与裁决 valueLevel 一致；两例 native_decide 数据点手算复核成立（aspoke 4 = 2·876+4·271−25 = 2811；arim 4 = 2·883+4·274−26 = 2836）。

## 其他核对
- dossier 声称 raw 回包 58 文件 —— 实数 58，相符。
- 裁决 c1Points（「删边、两端点保留」是否在 2026-09-27 放行句内）为闸门一人工裁点，dossier §4.7 明确不代裁——复核确认其未越权代裁，该点不在证据复核范围。

## 总评
**overall = confirmed**：7 条复核全部 confirmed（其中第 3 条带 A-13 命中号时变差异记录、第 7 条带 post0/post1 指针笔误记录，均不动摇裁决）。「查无占位（可达通道口径）」与「新序列（非新递推）」两项裁决的承重证据独立重证成立。
