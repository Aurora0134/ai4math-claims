> provenance note (added by the claim packager, 2026-09-29): this file is the
> full C9 novelty-review record for the matching count sequence of the
> period-3 pendant ladder (pool-comb-10: the ladder graph P_n x K_2 with one
> pendant leaf attached to the upper-rail vertex of every column 3k+1), copied
> VERBATIM and byte-for-byte in contiguous line ranges from two records of
> the working repository:
>
>   1. `tasks/20260927-mapselect-01/c9/combm-04-ladder-pend3.md` (170 lines, sha256 c886e5715d23fd594fb5258edbad2c0127c41082c3cc0519a9a22bdc7ae476c4)
>      ranges 1-170: the proposition-level first review - alias set,
>      channel/anchor self-proofs, OEIS numeric tables (prefix variants,
>      x2/+1/-1 transforms, the three mod-3 subsequences in three window
>      forms each, recurrence/generating-function/characteristic-polynomial
>      strings in two typings), OEIS keyword tables, family single-entry
>      reads (A030186 plain ladder, A102435/A102436 corona, A286945 maximal
>      matchings, A386889 period-2 pendant), literature layer (arXiv /
>      zbMATH / OpenAlex / MSE / WebSearch), library layer (mathlib rg,
>      compfiles, sequencelib tree), verdict = no occupying record found,
>      value tier = new sequence / new recurrence.
>   2. `tasks/20260927-mapselect-01/c9/recheck-combm-04-ladder-pend3.md` (135 lines, sha256 bd203cb2615211432586b605d9fcf367f504b0dc7e1e04d54707af532b9b3b64)
>      ranges 1-135: the exclusivity second review (red team; query methods
>      deliberately NOT reused from the first review) - independent fourth
>      matching-count implementation (39/39 agreement with the deep-fit
>      log), shifted-prefix variants (a(0)=1 / a(0)=0), mid/deep/tail
>      windows, subsequence late windows, MSE in-site direct search (five
>      strings), MathOverflow, zbMATH new strings incl. the full-record read
>      of Farrell 1978 (an:0414.05042), OEIS reverse cross-reference hunting
>      (A386889 has no reverse references; the A030186 citing family has no
>      period-3 member), Chinese-layer sweeps; verdict = supports the first
>      review (no occupying record, consistent and strengthened).
>
> Nothing else was added; the record bodies are unmodified and their
> conclusions are not reworded. Raw query responses remain in the working
> repository under the source task directory (kept in-repo, not shipped in
> this deposit).
>
> The C9 verdict carried into the claim note is: no occupying record found
> for the period-3 pendant-ladder matching sequence, for its 12-order sparse
> recurrence, and for the three mod-3 subsequences (object level and
> proposition level, two independent reviews); the registered family members
> are the plain ladder A030186, the period-1 pendant (corona) A102436 and
> the period-2 pendant A386889 - all explicitly delimited, none of them is
> this object; the nearest literature neighbour (Farrell, "Matchings in
> ladders", Ars Combin. 6 (1978) 153-161) covers the plain ladder only.
> Value tier = new sequence / new recurrence (not new mathematics).
>
# C9 文献独占性查新记录 · combm-04-ladder-pend3

- **查新官**：查新-combm-04-ladder-pend3（动态工作流子代理，端点自查 = zcode，`bash scripts/endpoint-detect.sh` 实跑输出 `zcode`）
- **日期**：2026-09-28
- **性质**：粗筛后的**独立命题级 C9 全查新**（对象层初筛见候选卡 `tasks/20260927-mapselect-01/candidates/combm-04-ladder-pend3.md`；本轮查询方法与矿工轮不同——矿工只做 OEIS 数值 + 单关键词，本轮新增 zbMATH / OpenAlex / arXiv API / MSE / sequencelib 在线 / 递推系数串 / 母函数与特征多项式串 / 挖掘措辞族 / 加长子列串，兼作《独占性二审》的「不同查询方法独立复查」口径）
- **纪律遵守**：全程 0 次 `scripts/llm-call.py`；未改任何既有文件，仅新建本记录；卡面 39 项数值与本机深算日志 `tasks/20260927-mapselect-01/combm/deep-fit2.log:2`（P1 a(1..39)）逐位对照一致（a(1)=3、a(13)=14935761、a(14)=45552370、a(15)=148392273 等抽查核对；未重跑 DP，复算口径=日志对照）。

## 0. 对象与别名清单（纪律 4：别名先行）

对象：n 列梯子图 P_n □ K_2，在 1 基列号 3k+1 列的上轨顶点各挂一片悬挂叶，数全部匹配（含空匹配）；主数列 a(1..39) 见深算日志，猜想 a(n)=45a(n−3)+63a(n−6)+11a(n−9)−a(n−12)（三条 mod-3 子列同满足 b(k)=45b(k−1)+63b(k−2)+11b(k−3)−b(k−4)）。

| # | 别名/表述族 | 用在哪些查询 |
|---|---|---|
| A1 | ladder graph / P_n □ K_2 / 2×n ladder | OEIS K1/K4/P1、arXiv D2/D4、OpenAlex OA1/OA2、zbMATH ZB2 |
| A2 | pendant vertex / pendant edge / leaf / 悬挂叶 | OEIS K4/K8、arXiv D2/D4/D5/D6、OpenAlex OA1/OA4、WebSearch |
| A3 | Hosoya index / total number of matchings / Merrifield–Simmons 配对概念 | OEIS K2/K11、zbMATH ZB2/ZB4、OpenAlex OA-T1、WebSearch×2 |
| A4 | monomer-dimer / monomers as defects（单体-二聚体） | OEIS K3、arXiv D1/D5、zbMATH ZB3、OpenAlex OA3、WebSearch |
| A5 | corona（每顶点挂叶的上界对照构造）与 partial corona | OEIS K10、zbMATH ZB5、OpenAlex OA-T3 |
| A6 | tiling strip with removed cells（挖孔铺法措辞，A386889 原文措辞族） | OEIS K6/K7/K9、arXiv D3、WebSearch |
| A7 | polyphenylene chain（每列挂叶=梳状图的文献别名，周期 1 族成员判例） | pools/README.md B2 判例行引用，不属本对象（周期 3≠1） |
| A8 | 递推 signature 45,63,11,−1 及母函数分母 1−45x−63x²−11x³+x⁴ | OEIS E17–E25 |

## 1. 通道状态与锚点/阳性对照自证

| 通道 | 状态 | 自证证据 |
|---|---|---|
| OEIS search（`curl -x http://127.0.0.1:4180 --ssl-no-revoke "https://oeis.org/search?q=<URL编码>&fmt=json"`） | **PASS** | 锚点 `0,1,1,2,3,5,8,13` → 10 命中且 **A000045 首位**；家族阳性对照：`matchings of ladder graph` → 10 命中（A318243/A102436/A286945/A102435…）；措辞族阳性对照：`strip with every other cell in the top row removed` → 精确命中 A386889 |
| OEIS 单条核读（jsdelivr `oeis/oeisdata@main`） | **PASS** | 实读 A102436/A102435/A030186/A286945/A386889 五条 .seq 全文 |
| arXiv API | **PASS（修复后）** | `http://export.arxiv.org` 经代理 raw_len=0（通道故障）；改 `https://export.arxiv.org` 后 200。阳性对照：`id_list=1909.12419` → Counting Domineering Positions 1 条；`ti:"domino tiling"` → 5 条 |
| zbMATH Open API | **PASS** | `api.zbmath.org/v1/document/_search` 实通（每查返回 status 执行成功） |
| OpenAlex API | **PASS** | works search / title.search filter 实通 |
| MSE | **API 限流降级 → WebSearch 站内限定补跑** | StackExchange API 返回 error 1015（IP 限流）；WebSearch `site:math.stackexchange.com` 补跑 2 轮 |
| WebSearch | **PASS** | 3+ 轮（Z.ai web_search_prime） |
| 本机 mathlib/compfiles rg | **PASS** | verify-proj/.lake/packages/mathlib、downloads/compfiles-main 实跑 rg |
| sequencelib 在线 | **PASS** | GitHub API 实认 `provables/sequencelib`（"A platform for formalizing OEIS sequences in Lean 4"，21 stars）；default 分支树 26336 文件（25905 个 .lean）全量列出 |
| grep.app | **DEGRADED** | `api/search?q=` 返回 HTML（API 改版），零取证价值；本题源为研究级（自造研究命题），《练习级题源的最低查新》双通道非强制义务，且库层两通道（本机库+sequencelib）已跑通 |
| DNS 污染对策 | 按 AGENTS.md 执行 | `nslookup export.arxiv.org 223.5.5.5` → 199.232.115.42（fastly）；直连 --resolve 不通，最终以 https 形态经本地代理修复 |

## 2. OEIS 数值查询台账（含零命中逐条；通道=OEIS search fmt=json，下同不赘）

**前缀变体（≥3 纪律，实跑 4 条）**：
| # | 查询串 | 结果 |
|---|---|---|
| E1 | `3,10,32,150,457,1489,6948,21191,69032`（原串） | 零命中 |
| E2 | `10,32,150,457,1489,6948,21191,69032,322142`（去首项） | 零命中 |
| E3 | `32,150,457,1489,6948,21191,69032,322142,982496`（去前两项） | 零命中 |
| E4 | `150,457,1489,6948,21191,69032,322142,982496,3200598`（去前三项） | 零命中 |

**简单变形（±1/×2；减半不适用——a(1)=3 为奇，全串不可能为 2× 整数序列，如实记 N/A）**：
| # | 查询串 | 结果 |
|---|---|---|
| E5 | ×2：`6,20,64,300,914,2978,13896,42382,138064` | 零命中 |
| E6 | +1：`4,11,33,151,458,1490,6949,21192,69033` | 零命中 |
| E7 | −1：`2,9,31,149,456,1488,6947,21190,69031` | 零命中 |

**mod-3 子列（陷阱②「退化首项/插零整串假阴性→拆余拆子序列各查」的强制动作；子列取值来自深算日志 a(1..39)，每条含去首项变体与 6 项中长变体防大数截断假阴性）**：
| # | 查询串 | 结果 |
|---|---|---|
| E8 | r=1：`3,150,6948,322142,14935761,692480469,32106110662,1488565220566,69015722246574` | 零命中 |
| E9 | r=1 去首项：`150,6948,322142,14935761,692480469,32106110662,1488565220566,69015722246574` | 零命中 |
| E14 | r=1 六项：`3,150,6948,322142,14935761,692480469` | 零命中 |
| E10 | r=2：`10,457,21191,982496,45552370,2111986542,97919979965,4539954344145` | 零命中 |
| E11 | r=2 去首项：`457,21191,982496,45552370,2111986542,97919979965,4539954344145` | 零命中 |
| E15 | r=2 六项：`10,457,21191,982496,45552370,2111986542` | 零命中 |
| E12 | r=0：`32,1489,69032,3200598,148392273,6880047822,318986002735,14789442250266` | 零命中 |
| E13 | r=0 去首项：`1489,69032,3200598,148392273,6880047822,318986002735,14789442250266` | 零命中 |
| E16 | r=0 六项：`32,1489,69032,3200598,148392273,6880047822` | 零命中 |

**递推系数/母函数/特征多项式（纪律 3；排版变体各扫——纪律 7）**：
| # | 查询串 | 结果 |
|---|---|---|
| E17 | `45a(n-3)+63a(n-6)+11a(n-9)-a(n-12)` | 零命中 |
| E20 | `45a(n-3) + 63a(n-6) + 11a(n-9) - a(n-12)`（带空格） | 零命中 |
| E24 | `45, 63, 11, -1` | 零命中 |
| E25 | `1, -11, -63, -45`（反向系数） | 零命中 |
| E18 | `1-45*x-63*x^2-11*x^3+x^4`（子列母函数分母） | 零命中 |
| E21 | `(1 - 45*x - 63*x^2 - 11*x^3 + x^4)`（带空格） | 零命中 |
| E19 | `1-45*x^3-63*x^6-11*x^9+x^12`（全局 12 阶分母） | 零命中 |
| E22 | `x^4 - 45*x^3 - 63*x^2 - 11*x + 1`（特征多项式） | 零命中 |
| E23 | `x^4-45x^3-63x^2-11x+1`（无空格排版） | 零命中 |

## 3. OEIS 关键词台账（别名各一轮）

| # | 查询串 | 结果 |
|---|---|---|
| K1 | `ladder graph pendant matchings` | 2 命中：A000045、A011973——均非本对象（Fibonacci 因注释含 ladder 词而全文命中） |
| K2 | `Hosoya index ladder pendant` | 1 命中：A000045——非本对象 |
| K3 | `monomer dimer ladder pendant` | 零命中 |
| K4 | `ladder with pendant vertices` | 2 命中：A000045、A180576（Wiener index of n-web）——非本对象 |
| K5 | `periodic pendant ladder` | 1 命中：A000045——非本对象 |
| K6 | `tiling strip every third cell removed` | **零命中**（周期 3 挖孔措辞在 OEIS 全文索引缺席） |
| K7 | `strip with every other cell in the top row removed` | **1 命中：A386889**——周期 2 挖孔措辞精确命中（阳性对照兼家族挂名核查：措辞通道对同族有效，周期 3 无同措辞条目） |
| K8 | `pendant vertex attached to every third` | 3 命中：A000045、A197424、A363476——均非本对象 |
| K9 | `3 x n strip dominoes holes top row` | 1 命中：A001045（Jacobsthal）——非本对象 |
| K10 | `partial corona graph matchings` | 1 命中：A005425——非本对象 |
| K11 | `Hosoya index graph pendant vertices ladder` | 1 命中：A000045——非本对象 |
| P1 | `matchings of ladder graph`（家族阳性对照） | 10 命中：A318243、A102436、A286945、A102435、A308244、A318267…（全为普通梯/k 匹配三角形/极大匹配族，无一为本对象） |

## 4. 家族挂名核查（OEIS 单条核读，jsdelivr oeisdata 全文实读）

| 条目 | 名称/递推 | 与本对象关系 |
|---|---|---|
| A030186 | 普通梯 L_n=P_2×P_n 匹配总数，a(n)=3a(n−1)+a(n−2)−a(n−3) | 同族不同参（无挂叶）；非本对象 |
| A102435/A102436 | corona L'(n)（梯图每顶点挂 1 叶，2n 片）k 匹配三角形/总和，a(n)=6a(n−1)+4a(n−2)−a(n−3) | 挂叶密度不同（每顶点 vs 每 3 列 1 片）；非本对象 |
| A286945 | 梯图极大匹配数，a(n)=2a(n−1)+a(n−4)+a(n−5) | 统计量不同（maximal vs all）；非本对象 |
| A386889 | 3×(2n−1) 条带顶行隔格去格的 1×1+1×2 铺法数（=每两列挂叶梯，pool-mossad-01 奇子列判例），a(n)=16a(n−1)−25a(n−2)+10a(n−3)−a(n−4)，Dresden & Demirkol 2025-09-04 | **同族周期 2 成员；其 %Y 交叉引用仅 Cf. A030186、A033506，无任何周期 3 兄弟条目**；非本对象 |

家族图谱结论：普通梯（A030186）→ 周期 1 挂叶（corona，A102436；每列挂叶=梳状图另按 B2 判例为 A000129 offset+2）→ 周期 2 挂叶（A386889）均已被 OEIS 挂名，**周期 3 挂叶在 OEIS 无条目、无交叉引用、无同族措辞**。

## 5. 文献层台账

**arXiv API（https 修复后；阳性对照 PASS）**：
| # | 查询 | 结果 |
|---|---|---|
| D1 | `abs:"monomer-dimer" AND abs:"ladder"` | 0 条 |
| D2 | `abs:"pendant" AND abs:"ladder"` | 1 条：*Ladder and Subdivision of Ladder Graphs with Pendant Edges are Odd Graceful*——odd graceful 标号问题，非匹配计数，非本对象 |
| D3 | `abs:"tiling" AND abs:"holes" AND abs:"strip"` | 0 条 |
| D4 | `all:"ladder graph" AND all:"pendant vertex"` | 0 条 |
| D5 | `abs:"monomer-dimer" AND abs:"pendant"` | 0 条 |
| D6 | `abs:"Hosoya" AND abs:"pendant"` | 1 条：树距离矩阵不变量文——非本对象 |
| 对照 | `au:"Dresden" AND abs:"tiling"`（http 形态） | 0 条（该形态通道故障期数据，仅记录不采信） |

**zbMATH Open API**：
| # | 查询 | 结果 |
|---|---|---|
| ZB1 | `ladder graph pendant matching` | "No results found"（零命中） |
| ZB2 | `Hosoya index ladder` | 1 条：*Merrifield-Simmons indices and Hosoya indices of some classes of Cartesian graph products*（2008）——摘要核实：只算 K_2□H（H=P_n/C_n/S_n）即普通梯/棱柱/书图的指标，**无挂叶构造**；非本对象 |
| ZB3 | `monomer-dimer ladder` | 3 条，最近邻：*Thermodynamics and maximal entropy of a monomer-dimer system on a ladder geometry*（2025）——摘要核实：Grassmann 技巧、固定单体密度的统计力学（熵/比热/关联函数），**无具体周期挖孔图案的精确枚举**；非本对象 |
| ZB4 | `matching polynomial pendant vertices` | 5 条：树/单圈图 Laplacian 系数、well-covered 树等——非本对象 |
| ZB5 | `corona ladder matching` | 零命中 |

**OpenAlex API**：
| # | 查询 | 结果 |
|---|---|---|
| OA1 | search `ladder graph pendant vertices matchings`（96 条全文噪声） | 近邻无本对象 |
| OA2 | search `Hosoya index ladder graph`（123 条） | 近邻：*Computing the Schultz polynomials and indices for ladder related graphs*（2019，距离类指标非匹配）——非本对象 |
| OA3/OA4 | search `monomer-dimer ladder strip defects` / `matchings graph pendant vertices periodic` | 全文化学/物理噪声，无本对象 |
| OA-T1 | filter `title.search:hosoya ladder` | **0 条** |
| OA-T2 | filter `title.search:monomer-dimer`（2311 条） | 最近邻 Heilmann-Lieb *Theory of monomer-dimer systems*（1972）——通论，无周期挖孔梯枚举 |
| OA-T3 | filter `title.search:corona graph matching` | 2 条：分数匹配（2019）、corona 图对称簇（2025）——非本对象 |
| OA-AMALG | 标题直取 *Enumerating the number of k-matchings in successively amalgamated graphs*（2025） | 摘要核实：合并构造的传递矩阵通法（示例 benzenoid/octagonal 链）——方法学近邻，非本对象挂名 |

**MSE（API error 1015 限流 → WebSearch 站内限定补跑）**：`site:math.stackexchange.com ladder graph pendant vertices number of matchings` 及精炼变体——**无逐字/等价提问命中**（引擎明确报告无 ladder-with-pendant matchings 的 MSE 提问）。

**WebSearch 通名轮**：`"ladder graph" "pendant vertices" matchings Hosoya index count` 等——近邻为 line graph of subdivision、Halin 图独立集等，无本对象。

## 6. 库层台账

| 库 | 查询 | 结果 |
|---|---|---|
| mathlib（verify-proj/.lake/packages/mathlib，v4.34.0） | `rg -il "ladder"` | 7 文件命中，逐条定性：`Mathlib/RingTheory/Regular/RegularSequence.lean:558`、`Mathlib/Algebra/Homology/DerivedCategory/Ext/ExactSequences.lean:88` 等全部为同伦代数 ladder（`Exact.iff_of_ladder_linearEquiv`、`of_ladder_addEquiv_of_exact'`）——**非图论梯子，零图论命中** |
| mathlib | `rg -il "pendant"` | **0 命中** |
| mathlib | `Mathlib/Combinatorics/SimpleGraph/Matching.lean` 声明清单实读 | 仅 IsMatching/IsPerfectMatching 定义与 card 引理（:67、:236、:247 等），**无任何具体图族计数定理** |
| compfiles（downloads/compfiles-main） | `rg -il "ladder|pendant"` | **0 命中** |
| compfiles | `rg -il "matching"` | Imo1970P2/Imo2014P6/Imo2019P3/Usa2018P6/Usa2022P1——语境核查为匹配存在性引理（如 Imo2019P3.lean:836 `exists_matching_of_isAcyclic`）与对局「matches」，无梯图/挂叶枚举 |
| sequencelib 在线（provables/sequencelib，26336 文件树全量） | 路径关键词 `ladder/pendant/match/hosoya/A030186/A386889/A102436` | **0 命中** |
| grep.app | API 改版返回 HTML | 通道降级（见 §1）；研究级题源非强制通道 |

## 7. 禁区速查对照与派生命题

- `harness/selection-map/pools/README.md:41` 图匹配经典图族禁区：prism=A102080、Möbius ladder=A020877、梳状图=A000129 offset+2——**本对象（周期 3 挂叶梯）不在所列族**；同行的「干净面」口径（带缺陷/非常规参数网格与环图，MAT-PEND 已入池 Part A）与本对象定位一致。
- 泛化警示不适用：本卡无泛定理实例化灰区；非「带经典约束的分拆计数」；非铺砖族 B1（21/26 已占位口径针对铺法数条带——本对象为图匹配计数、且周期 3 挖孔经 §2/§3 实证缺席）。
- **派生命题**：三条 mod-3 子列已独立查新（E8–E16 各带去首项/中长变体）；PM（完美匹配）子命题按候选卡 :75 自述「非主攻、不足以有效检索、不得单独立项」，本轮未查新、如实继承该标注。
- 题源自述处置：候选卡 :9 的「OEIS 四类前缀变体、×2 变体、三条子列与关键词全部零命中」降级为线索，本轮 E1–E25/K1–K11 全部独立重取，结论一致。

## 8. 裁决

- **C9 四态：查无占位**。依据：主要通道全部跑通（OEIS 双通道锚点+家族阳性对照 PASS；arXiv 修复后双阳性对照 PASS；zbMATH/OpenAlex/MSE-补跑/WebSearch 实通；本机库+sequencelib 实跑），且别名穷尽（§0 八族）、变体覆盖完整（4 前缀 + ±1/×2 + 减半 N/A + 3 子列×3 形态 + 递推/母函数/特征多项式 9 串多排版）下**全部零命中**；同族周期 1/2 与普通梯均已挂名而周期 3 在 OEIS、文献、Lean 生态三层均无条目、无交叉引用、无同措辞。
- **价值级：新序列/新递推**。依据：OEIS 查无占位、对象层面无挂名（含子列层面——比 pool-mossad-01 的 A386889 子列占位警示更干净）；与同族判例 pool-mossad-01 的价值级口径一致（`pools/mossad-50.md:22`），按《价值主张分级表》「OEIS 查无占位、对象层面无挂名 → 可立项」；未达「新数学」级主张口径（同族 workspace 惯例：图族枚举+常系数递推按新序列/新递推记，不宣称整列全新数学）。
- 不一致原因：与候选卡对象层初筛结论一致（本卡为命题级全查新，通过）。

# C9 独占性二审（红队）记录 · combm-04-ladder-pend3

- **查新官**：二审-combm-04-ladder-pend3（动态工作流子代理，端点自查 = `bash scripts/endpoint-detect.sh` 实跑输出 `zcode`，stderr 取证 L3a 进程链命中）
- **日期**：2026-09-28
- **性质**：《SOP 01 独占性二审》定题前红队——对一审记录 `c9/combm-04-ladder-pend3.md`（2026-09-28，四态「查无占位」）用**不同查询方法独立复查**。全程未复用一审任何查询串；通道主力与一审错开。
- **纪律遵守**：0 次 `scripts/llm-call.py`；未改任何既有文件，仅新建本记录；二审与原审冲突时以二审取证重裁。

## 0. 与一审的方法错开对照（三条强制项逐一核销）

| 错开项 | 一审已用 | 本轮（二审）新用 |
|---|---|---|
| ①前缀变体集合 | a(1..12) 内 4 个前缀窗（E1–E4）+ ×2/+1/−1 变形（E5–E7）+ mod-3 子列 k=0/1 起头三形态（E8–E16） | **下标平移变体**：前置 a(0)=1 与 a(0)=0（N1/N2，一审未做）；**中段窗** a(8..15)（N3）、**深段窗** a(14..18)（N4）、**尾段窗** a(35..39)（N5）；mod-3 子列**晚窗 k=6..11**（N6/N7/N8）。取数基础=本轮独立异构重算（§1） |
| ②别名集 | A1–A8（ladder graph / pendant vertex-edge-leaf / Hosoya-Merrifield-Simmons / monomer-dimer / corona / tiling strip 挖孔措辞 / polyphenylene / 递推 signature） | 增量别名：**faulty ladder、defective ladder、dimer covering + monomers（物理措辞）、independent edge sets、ladder graph with leaves、every third pendant、2×n grid pendant、中文层（梯图·悬挂点·匹配数·Hosoya）**（W1–W8、X1） |
| ③通道/顺序 | 主力 OEIS search + WebSearch（MSE API 限流后替身）+ arXiv/zbMATH/OpenAlex 各一批 | 主力改 **MSE 站内直查（web_reader 破 Cloudflare，5 串实查——一审只到 WebSearch 站内限定）** + **MathOverflow（一审未查）** + zbMATH 新串 5 条（含 an 记录 API 核读）+ arXiv 新组合 4 条 + **OEIS 反向交叉引用狩猎（A386889/A030186 全文探测，一审未做）** + 中文层/site:oeis 措辞狩猎。grep.app v1、Superseeker、SE API 三通道本轮实灭（如实记 §7） |

排版变体错开（纪律 7）：一审用无星号两式（E17/E20、E18/E21、E19、E22/E23）；本轮统一用 **OEIS %F 原生星号式**（R1–R4），两轮合计 4 种排版覆盖同一递推/母函数/特征多项式。

## 1. 独立重算（本轮查询串取数基础）

- 方法：本轮新写**列转移枚举 DP**（对每列枚举局部边子集 {rung, pend, th, bh} 的相容组合，状态 = 下列顶/底轨顶点是否已被横边预匹配）——与一审所据矿工三法（列轮廓 rec DP / 记忆化删点分支 / 纯回溯）**结构异构的第四套实现**。
- 口径：1 基列号 3k+1 挂一片上轨悬挂叶；含空匹配。
- 结果：a(1..39) 与 `tasks/20260927-mapselect-01/combm/deep-fit2.log:2` **逐位一致（39/39）**；a(1..14) 与候选卡面一致；a(0)=1（空图含空匹配，自然外推值）。
- 过程记录：首版实现漏查 `rung` 与 `bh` 共用底轨顶点的冲突（a(2)=11≠10），修正后全对——本机数值经两套独立实现互证，排除单实现守卫盲区（PRE-09 判例口径）。
- PM 变体数值取证：`compute-p1.log:4` PM(1..14) = [0,0,0,1,1,2,0,0,0,2,2,4,0,0]——插零 + 非零段过短，不可有效检索（见 §8 派生处置）。

## 2. 通道状态与锚点自证

| 通道 | 状态 | 自证证据 |
|---|---|---|
| OEIS search（`curl -x http://127.0.0.1:4180 --ssl-no-revoke "https://oeis.org/search?q=...&fmt=json"`） | **PASS** | 锚点1 `0,1,1,2,3,5,8,13` → 10 命中且 **A000045 首位**；锚点2 `1,3,13,22,44,90,196,406` → **A180970**（pools/README.md:50 指定锚）；自拟家族关键词锚 `matchings in the ladder graph`（措辞与一审 P1 不同）→ 10 命中（A318243/A102436/A286945/A102435/A308244/A318267…） |
| MSE 站内直查（web_reader 取 `math.stackexchange.com/search?q=...`，绕过 curl 层 Cloudflare 403） | **PASS** | `matchings in ladder graph` → 4 条相关命中（含普通梯 k-匹配帖，引 MathWorld 梯图匹配多项式）——同站可检得梯图匹配内容，通道有效 |
| MathOverflow（WebSearch `site:mathoverflow.net`） | **PASS** | 返回 MO 相关帖（tatami monomer-dimer、Möbius ladder 定义）——通道可达且能检得同域内容 |
| zbMATH Open API | **PASS** | Z4/Z5 正常返回结果；Z1–Z3 返回 `status.status_code=404 "No results found"`（格式异于常规空结果，属明确零命中答复，非传输故障） |
| arXiv API（https 形态） | **PASS** | 对照组 `ti:"ladder graph"` → 8 条真实命中 |
| StackExchange API（api.stackexchange.com） | **灭（限流）** | HTTP 502 "too many requests from this IP, more requests available in 50624 seconds"（与一审 1015 同故障态）——由 MSE 站内直查通道补偿 |
| grep.app（api.grep.app/v1/search） | **灭** | HTTP 503 Service Temporarily Unavailable（两探针皆然；与一审「返回 HTML」不同轮故障，同样不可用） |
| OEIS Superseeker | **灭** | GET `superseeker?query=...` 返回 OEIS 首页 HTML（查询参数未被受理）；POST 表单 → HTTP 404。非强制补充通道，不阻塞裁决 |
| OpenAlex | **未复跑** | 一审已以 7 条查询实跑全零；本轮按「不同方法优先」原则未重复，如实记 |

## 3. OEIS 数值台账（全部零命中；数值来源 = §1 本轮独立重算）

| # | 查询串 | 结果 |
|---|---|---|
| N1 | `1,3,10,32,150,457,1489,6948`（**前置 a(0)=1 下标平移变体**，防 OEIS 以 a(0)=1 为 offset 的占位） | 零命中 |
| N2 | `0,3,10,32,150,457,1489`（前置 0 变体） | 零命中 |
| N3 | `21191,69032,322142,982496,3200598,14935761,45552370,148392273`（中段窗 a(8..15)，一审前缀窗仅覆盖 a(1..12)） | 零命中 |
| N4 | `45552370,148392273,692480469,2111986542,6880047822`（深段窗 a(14..18)） | 零命中 |
| N5 | `20978390404822880581,68339606497537531641,318910424116193016580,972640463015203269459,3168492206664265293316`（尾段窗 a(35..39)，深算段） | 零命中 |
| N6 | `32106110662,1488565220566,69015722246574,3199839584728301,148357113925623271`（r=1 子列晚窗 k=7..11，一审子列全部从 k=0/1 起） | 零命中 |
| N7 | `97919979965,4539954344145,210490090523912,9759146205050248,452472296508073246`（r=2 子列晚窗 k=6..10） | 零命中 |
| N8 | `6880047822,318986002735,14789442250266,685696551568044,31791581648311001`（r=0 子列晚窗 k=6..10） | 零命中 |

## 4. OEIS 递推/母函数/特征多项式台账（%F 星号式排版，与一审错开；全部零命中）

| # | 查询串 | 结果 |
|---|---|---|
| R1 | `a(n) = 45*a(n-3) + 63*a(n-6) + 11*a(n-9) - a(n-12)`（空格+星号） | 零命中 |
| R2 | `a(n)=45*a(n-3)+63*a(n-6)+11*a(n-9)-a(n-12)`（密排+星号） | 零命中 |
| R3 | `1 - 45*x^3 - 63*x^6 - 11*x^9 + x^12`（12 阶母函数分母，星号式；一审 E19 为无星号式） | 零命中 |
| R4 | `x^4 - 45*x^3 - 63*x^2 - 11*x + 1`（特征多项式，星号式；一审 E22/E23 为无星号两式） | 零命中 |

## 5. OEIS 关键词台账（新别名集）

| # | 查询串 | 结果 |
|---|---|---|
| W1 | `faulty ladder graph` | 零命中 |
| W2 | `defective ladder matchings` | 1 命中 A11973 = 二项式三角形 T(n,k)=C(n−k,k)（词条噪声），非本对象 |
| W3 | `dimer monomer ladder covering` | 1 命中 A210662 = n×k 板单体-二聚体铺法三角形（板铺法族，非本图），非本对象 |
| W4 | `independent edge sets ladder` | 10 命中：A20878（Möbius 阶梯**最大**匹配）、A286945（梯图**极大**匹配，一审已知）、A284710（Möbius 阶梯极大匹配）、A20877（Möbius 阶梯匹配）、A45/A244/A129/A1333/A6318（词条噪声）——无一为本对象 |
| W5 | `ladder graph with leaves` | 3 命中 A108/A1147/A6318（Catalan/双阶乘/Schröder，词条噪声），非本对象 |
| W6 | `ladder every third pendant` | 1 命中 A45（词条噪声），非本对象 |
| W7 | `monomer defects ladder dimer` | 零命中 |
| W8 | `2xn grid pendant matchings` | 零命中 |

## 6. MSE 站内直查 + MathOverflow（本轮主力通道）

| # | 通道/查询串 | 结果 |
|---|---|---|
| MS1 | MSE `ladder graph pendant matchings` | **0 results**（站内原话 "We couldn't find anything"） |
| MS2 | MSE `ladder pendant matching` | **0 results** |
| MS3 | MSE `matchings in ladder graph`（兼通道阳性对照） | 4 条：Franklin 图自同构群、permanent↔完美匹配矩阵证明、**seating couples 帖（=普通梯 k-匹配，引 MathWorld 梯图匹配多项式，即 A030186 族近邻）**、Hamiltonicity 杂帖——无挂叶梯提问 |
| MS4 | MSE `ladder graph with pendant` | **0 results** |
| MS5 | MSE `monomer dimer ladder` | **0 results** |
| MO1 | WebSearch `site:mathoverflow.net ladder graph pendant vertices matchings monomer dimer`（及两条放宽变体） | 无本对象提问；最近邻 = MO 103165（tatami monomer-dimer，B1 族成员）、MO 161892（Möbius ladder 定义）——非本对象 |

## 7. zbMATH 新串 + 记录核读

| # | 查询串 | 结果 |
|---|---|---|
| Z1 | `faulty ladder` | 404 "No results found"（零命中） |
| Z2 | `dimer covering ladder monomers` | 404 "No results found"（零命中） |
| Z3 | `matchings ladder leaves` | 404 "No results found"（零命中） |
| Z4 | `independent edge sets ladder` | 5 条：圆形梯容错度量维数、调和均值图、1-independent 随机图连通性、token-sliding 重构——非本对象 |
| Z5 | `matching generating polynomial ladder` | 3 条，首条 **"Matchings in ladders"，E. J. Farrell, Ars Combin. 6 (1978), 153–161**（an:0414.05042）→ 经 `/v1/document/_search?search_string=an:0414.05042` 核读全记录：MSC 05C99/05A15/05A99，无摘要无评论文本；WebSearch 复核 = Farrell 匹配多项式系列论文，对象为**标准梯**（双轨+横档）匹配，被其 1982 年梯图电路/特征多项式文引用。**家族文献近邻（普通梯匹配计数的专门文献），无挂叶构造证据，非本对象占位** |

## 8. arXiv 新组合（一审 D1–D6 未用搭配）

| # | 查询 | 结果 |
|---|---|---|
| AR1 | `abs:"Hosoya" AND abs:"ladder"` | 1 条：广义 Möbius 阶梯拓扑不变量——非本对象 |
| AR2 | `abs:"ladder graph" AND abs:"matching"` | 2 条：Möbius/圆形梯完美匹配复形同伦型（拓扑方向）、梯形需求图自调整网络——非本对象 |
| AR3 | `abs:"dimer" AND abs:"ladder"` | 8 条全为自旋梯/量子二聚体物理——同词异域，非本对象 |
| AR4 | `abs:"monomer" AND abs:"ladder"` | 7 条全为高分子/DNA 化学——非本对象 |
| 对照 | `ti:"ladder graph"` | 8 条（signed Roman domination、graceful coloring、arithmetical structures、percolation 等）——通道存活证明，同时亦无本对象 |

## 9. OEIS 反向交叉引用狩猎（一审未做）

- OEIS 全文搜 `A386889`（周期 2 挂叶判例条目）→ 仅返回自身 1 条：**无任何条目交叉引用它**（更无周期 3 兄弟）。
- OEIS 全文搜 `A030186`（普通梯匹配条目）→ 10 条，逐条定性：A30186 本体、A156096（逆二项变换）、A365967（A030186/A033505 交错）、A45、A46741（2×n 格哑铃摆放三角形）、A210662、A33505（1/(1−3x−x²+x³)）、A220621、**A33506（P₃×Pₙ 匹配）**、**A102436（corona 梯，周期 1 挂叶族）**——**全族无一为周期 3 挂叶形态**。

## 10. WebSearch 中文层与 OEIS 站外措辞狩猎

| # | 查询 | 结果 |
|---|---|---|
| X1 | `梯图 悬挂点 匹配数 递推 Hosoya 指标 悬挂边`（含两条中文变体） | 最近邻：Q 形图匹配能序与 Hosoya 排序（山东大学学报 2018）、哑铃双圈图匹配能量、玫瑰图 Hosoya、树 Hosoya 线性算法——皆为**其他图族的能量/排序问题**，无周期挂叶梯枚举；引擎明确报告未找到「梯图+悬挂点+匹配数递推」单一文献 |
| X2 | `site:oeis.org ladder pendant "every third" OR "third column" OR "3k+1" matchings` | **零结果** |

## 11. 陷阱防检核销

- **退化首项/下标平移**：N1/N2 前置 a(0)=1/0 双变体（一审未做的平移方向）；N3–N5 中深尾窗防首段截断假阴性。
- **插零**：主序列无插零（本机重算 39 项连续）；PM 派生序列为插零序列（`compute-p1.log:4`），按 §8 派生处置如实标注不可有效检索，不伪造查询结论。
- **按行存储**：不适用——本对象为 1 维计数列无表存储形态；mod-3 子列拆查（N6/N7/N8 晚窗）已覆盖列式切分风险。
- **排版变体**：R1–R4 星号式补齐一审无星号式的另一半（纪律 7 两轮合计 4 式覆盖）。

## 12. 禁区速查对照与派生命题处置

- `pools/README.md:41` 图匹配经典图族禁区（prism=A102080、Möbius ladder=A020877、梳状图=A000129 offset+2）：本轮 W4 命中的 Möbius 阶梯匹配族（A20877/A20878/A284710）恰为该禁区成员的扩展印证——本对象（周期 3 挂叶梯）不在禁区所列族。
- `pools/README.md:40` 铺砖族 26/26 枯竭：不适用（本对象为图匹配计数非铺法数条带）；Z5/W3 命中的板铺法/普通梯文献均为近邻非本族成员。
- 派生命题：PM（完美匹配）子命题维持候选卡 `candidates/combm-04-ladder-pend3.md:75` 与一审的处置——插零+非零段过短不可有效检索、**非主攻、不得单独立项**，本轮未查新、如实继承（本轮取证了其数值 log 行号）。

## 13. 二审裁决

- **C9 四态：查无占位**（**支持一审结论**）。依据：本轮全部存活通道带锚点/阳性对照跑通（OEIS 双锚+自拟家族锚、MSE 直查站内对照、MO 可达、zbMATH 状态明确、arXiv 对照 8 条），通道死者（SE API 限流、grep.app 503、Superseeker 不可用）均有补偿通道或非强制，**不构成「通道全灭」**；在前缀变体错开（平移/中深尾窗/子列晚窗 8 串）、别名增量 8 族、排版 4 式、反向交叉引用狩猎、中文层全部**零命中**；A386889 无反向引用、A030186 引用族无周期 3 成员。家族图谱：普通梯（A030186 + Farrell 1978 专文）→ 周期 1 挂叶（A102436 corona）→ 周期 2 挂叶（A386889）均占位，**周期 3 挂叶在 OEIS/文献/问答社区/中文层四层均无条目无挂名**。
- **价值级：新序列/新递推**（同一审）。OEIS 查无占位 + 对象层面（含子列层面）无挂名；文献层存在同族近邻（Farrell 1978 普通梯、corona 族）但无同形结果，不达「新数学」级主张口径，按工作区惯例记新序列/新递推。
- 与一审不一致点：无（方法错开充分，结论一致增强）。
## appendix: extraction self-check

| # | source | lines | bytes | sha256(body, first 16) |
|---|---|---|---|---|
| 1 | combm-04-ladder-pend3.md | 1-170 | 16983 | d6fef94f4e88ce65 |
| 2 | recheck-combm-04-ladder-pend3.md | 1-135 | 14938 | 8aee35f0f9cba9af |

Recompute with: `python claims/ladder-pend3-interleave/audit/build-c9-record.py --check`
