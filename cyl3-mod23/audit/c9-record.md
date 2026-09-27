> provenance note (added by the claim packager, 2026-09-27): this file is a verbatim,
> byte-for-byte copy of the C9 novelty re-review record
> `tasks/20260926-beian-select/recheck/04-cylinder-3holes-exclusivity.md` (the package's
> full novelty query log). Only this header and the appendix table below were added;
> the record body is unmodified. Raw evidence files remain in the repository at
> `tasks/20260926-beian-select/recheck/04-cylinder-3holes/` (listed in the appendix;
> kept in-repo, not shipped in this deposit).

# 独占性复审报告：候选 04（带缺陷圆柱格 3×n 三种孔位覆盖计数）

- 复审时间：2026-09-26；执行：选题院独占性二审红队工人（subagent）；llm-call 0 次（全部检索为本机 curl 经代理 127.0.0.1:4180 + FetchURL + 本地 python/rg，不涉模型采样）；gate-batch 0 次。
- 复审对象：`candidates/04-cylinder-3holes-review.md` 的新颖性声明——一审对三族缺陷序列只引备案口径「OEIS 零命中×4」，自承未做知网侧与三通道（zbMATH/arXiv/OpenAlex）复测。备案自述撞车栏按 SOP 01-C9 降级为线索，全部结论由本机独立重取。
- 数值前置（防 08 式假阴性）：`04-cylinder-3holes/verify-seq.py` 用**与一审不同的实现**（顶点回溯+记忆化 DP，一审为转移矩阵 DP）独立重算，五族序列与卡面逐项全同：基线 4,32,228,1655,…（n=1 起）；row3 22,135,1006,7251,52538,380352,2753948,19939605（n=3 起）；diag3 13,83,615,4437,32144,232714,1684965,12199779（n=3 起）；tri3 3,19,141,1017,7368,53342,386223,2796399（n=2 起）；mixed 2,20,134,987,7118,51583,373406（n=2 起）。查询串本身可信。

## 别名清单（关键词检索前置，SOP 01-C9 纪律 4）

- 对象：3×n 横卷圆柱格 = C₃ □ Pₙ = **stacked prism graph**（MathWorld 名）= cylindrical grid graph = 3 × n cylinder。
- 计数：单体+二聚体覆盖数 = **monomer-dimer coverings/tilings** = 图的全部匹配数 = **Hosoya index（Z index）** = number of matchings。
- 缺陷：deleted vertices = vacancies = holes = fixed monomers；defective grid。
- 同余律话题：periods of linear recurrences mod m = Pisano(-like) periods。

## 逐通道结果

### 1. OEIS（26 次检索查询 + 2 次单条核读，四层）

| 层 | 查询 | 结果 |
|---|---|---|
| 校准 | 基线 8 项 1,4,32,228,1655,11978,86731,627960 | **命中 A033515**（"Number of matchings in graph C_{3} X P_{n}"，通道有效） |
| 精确 | row3/diag3/tri3 各 8 项原串 | 全部 null（零命中） |
| 前缀放宽 | 三族各去前 1 项、去前 2 项 | 全部 null |
| 中段放宽 | row3 严格中段 7251,52538,380352,2753948；diag3 4437,…,12199779；tri3 1017,…,2796399 | 全部 null |
| 简单变形 | 三族每项 +1 各一查（增长比 ~7.3 的计数序列，翻倍/减半无组合对应物，±1 为变形探针，如实记选择理由） | 全部 null |
| 附带 | mixed（移动端孔）2,20,134,987,7118,51583,373406 原串 + 去前 1 | 全部 null |
| 递推系数 | 文本查 "a(n) = 6*a(n-1) + 9*a(n-2) - a(n-4)" | 10 条命中全部无关（4ⁿ 族/其他递推）；无本签名匹配计数族 |
| 母函数 | "(1-2x-x²)/(1-6x-9x²+x⁴)" | null |
| 别名关键词×6 | cylinder matchings / monomer-dimer / Hosoya cylinder / matchings deleted vertex / C_3 X P_n / matchings grid holes | 逐条核读（kw-scan.out/scan2）：最相邻 = **A143659**（(2n+1)² 方板中心单孔的**完美匹配**数，对象不同：仅完美匹配、方板非圆柱、单孔非三固定孔）、A210662/A028420（整板族）、A260033–36（general monomer-dimer 2k×2n 整板）、A028484/86/87（C_m×P 完美匹配）、A338709 等（C₃×Pₙ 路径/圈/支配集，非同统计量）；**无任何缺陷圆柱全部匹配变体** |
| 单条核读 | A033515.seq + A287428.seq（jsdelivr） | A033515 交叉引用仅 "Row 3 of A287428"；A287428 = stacked prism graph C_m×P_n 无缺陷全匹配大表（行 2–13 已注册，Cf. A028420 整板/A270246 环面）——底座家族在册非新，缺陷变体无任何挂名 |

证据：`04-cylinder-3holes/oeis-*.json, A033515.seq, A287428.seq, kw-scan*.out`。

**结论：三族缺陷序列 OEIS 零命中经四层 19 个序列形态查询 + 6 组关键词独立复现并加固**（一审只有备案口径一句话，本次为首次本机实测）。

### 2. arXiv（一审未测通道；https + UA 后 8 组查询，前 3 组 http 空返回为通道试错如实记）

- 查询：all:"monomer-dimer" AND cylinder（5 条）、abs:"number of matchings" AND cylinder（0）、"stacked prism" AND matchings（0）、Hosoya AND cylinder（0）、"monopole-dimer"（4 条）、matchings AND "deleted vertices"（5 条）、matchings AND vacancy AND lattice（15 条）、au:Lundow（15 条，全 Ising 物理，匹配枚举报告 1996/98 早于 arXiv 未收录）。
- **最相邻文献线（判定不占据）**，摘要已逐篇核读（ax-abstracts.out）：
  - **arXiv:2109.12716**《Disordered Monomer-Dimer model on Cylinder graphs》：随机权重 Gibbs 测度/自由能极限/CLT，非精确枚举、无缺陷计数序列、无递推同余结果。
  - **arXiv:cond-mat/0611449**：n×∞ 半无穷板自由能渐近展开，非有限 C₃×Pₙ 缺陷精确计数。
  - **arXiv:2406.05750**《The monopole-dimer model on high-dimensional cylindrical, toroidal, Möbius and Klein grids》（zbMATH 同现）：带号变体的配分函数乘积公式，**完整网格、无删点、无 C₃×Pₙ 缺陷序列**——03 方向复审已定位的同一邻域线，本题立项后论文亦应引用划界。
- 其余命中（Two-Hole Problem=完美匹配存在性、forcing number=完美匹配性质、材料学 vacancy 噪声）均无关。

**结论：arXiv 无占据。**

### 3. OpenAlex（一审未测通道；泛检索 5 组 + 标题精确 3 组）

- 泛检索噪声大但无占据信号；相邻命中《A Reciprocity Theorem for Monomer-Dimer Coverings》(2003，整板互反)、《Vacancy localization in the square dimer model》(2007，完美匹配） 均不占据。
- 标题精确：title:"monomer-dimer"（2311 条，top 全为 Heilmann–Lieb 1972、Jerrum 1987、化学同名词，无圆柱缺陷计数）；title:matchings AND cylinder（204 条全为工程"圆柱匹配"噪声）；title:Hosoya AND cylinder → 唯一命中《The polygonal cylinder and its Hosoya polynomial》(2020)——注意 **Hosoya 多项式是距离多项式（Wiener 系），非 Hosoya 匹配指数**，不占据，特此记档防混淆。

**结论：OpenAlex 无占据。**

### 4. zbMATH（一审未测通道；开放 API 4 组）

- monomer-dimer cylinder → 3 条（2109.12716 系两篇已研判 + Laughlin 无关）；matchings cylindrical grid → forcing number（完美匹配性质）、加权匹配比（非计数）、2406.05750（已研判）；Hosoya index cylinder → **0 条**；Pisano period linear recurrence → 3 条但 zbMATH 开放 API 对这三条记录返回"contents unavailable due to conflicting licenses"占位（标题被掩码，无法研判，如实记为残余缺口；该查询用于 P1 文献层背景，见结论 3）。

**结论：zbMATH 无占据；1 组查询受许可掩码限制记残余。**

### 5. Semantic Scholar（1 次查询）

- monomer-dimer cylinder matchings enumeration → **HTTP 429 未认证限流**，按纪律如实记，未重试（curl 预算尽；OpenAlex/arXiv/zbMATH 三通道覆盖与之重叠）。记残余缺口。

### 6. 通用搜索层（FetchURL×3 + curl×2，通道降级如实记）

- Bing EN×2（不同措辞）：返回均被必应词典/本地化部件污染（"monomer"被当词典查询），无有效结果。
- Bing CN×1（"圆柱 棋盘 铺法 计数 递推 骨牌 缺口"）：顶部结果全为几何圆柱体积词条，无组合铺法内容浮现。
- DuckDuckGo HTML：FetchURL 路由被本机 DNS 污染阻断（解析 127.0.0.1）；curl 经代理 2 次均 http=000 连接失败。
- **通用 web 层未能获得有效检索证据，记残余缺口**；反向信号（任何渠道浮现缺陷圆柱计数已发表结果）亦未出现。

### 7. 知网

- 站内需登录不可查。**「知网侧未测」残余声明维持**，不编造检索结果；通用中文搜索未浮现相关条目（通道降级见上节）。

### 8. 形式化三层（本地 rg + sequencelib）

- mathlib（verify-proj/.lake/packages/mathlib）：精确探针 `Hosoya|monomer|dimer|033515|matching(s) (polynomial|count|number)` = **0 命中**（"cylinder" 命中全为测度论同名词，已排除）；`Pisano` 及 `periodic+ModEq/linearRecurrence` 组合探针 = 0 命中。卡面 C5 记录复现成立。
- compfiles（downloads/compfiles-main）：同探针仅 5 处自然语言注释（存在性语义），无计数内容，零占据。
- sequencelib（provables/sequencelib，Lean 4 形式化 OEIS 项目，GitHub 全树 26336 条目完整拉取无截断）：**A033515 缺席**；邻族 A033506/A287428/A028420/A210662/A270246 全部缺席。底座及缺陷族在 sequencelib 均无形式化挂名。

## 复审结论（逐命题四态裁决）

1. **主张 A（三族固定孔位缺陷序列 OEIS 零命中）：查无占位，成立并加固。** 一审仅引备案口径（程序性不足，09 式风险），本审以独立重算序列 + 19 序列形态查询 + 6 关键词组 + 5 外部文献通道独立复现。一审结论对、取证方式不合 C9 纪律——结论经二审取证重裁为成立。
2. **P1（递推签名 (6,9,0,−1) 族的 mod 2 周期 6 / mod 3 反周期统一律）：查无占位。** 文献层无该签名同形定理的任何通道信号（OEIS 递推文本查无、arXiv/OpenAlex/zbMATH 关键词无）；形式化层 mathlib/compfiles/sequencelib rg 零命中。背景说明：线性递推模周期的一般理论是经典领域（Pisano 型），P1 是该一般理论在具体签名上的初等实例，卡面亦未做"新数学"越级主张；按 2026-09-26 价值分级表，P1 的合理定位 = 伴随三族新序列的同余律观察（新序列级），非独立"新数学"。
3. **P2（矩阵泛函继承零化多项式递推）：查无占位。** 任何通道无信号（本质为 Cayley–Hamilton 直接推论，文献层不存在"占位"形态）；mathlib 具备全部构件但无此打包引理。定位 = 库引理级首个形式化，不单独立项依据充分（与卡面"备选"一致）。
4. **P3（C₃×Pₙ 匹配计数完整组合语义）：已知未形式化。** 文献层已被占位——Lundow 1996/1998（A033515 参考条）+ OEIS A033515/A287428（无缺陷族全表在册）；形式化层（mathlib/compfiles/sequencelib）查无挂名。与卡面"不建议立项"一致，且命中用户 2026-09-26 裁决「首个形式化不单独立项」。
5. **收窄变体 mixed（移动端孔六阶递推观察）：查无占位**（2 个序列形态查询零命中）；卡面本就列为探针记录而非贡献主张，维持记录级。
6. **同列三孔 = 基线移位（平凡）：已占位**（A033515 本体），非贡献主张，卡面已标平凡，无误。

**一审无占位结论全部维持；未发现 08/09 式占位翻车。** 底座 A033515/A287428 在册非新（卡面已如实声明），缺陷三族 + 统一同余律的独占性主张经独立二审成立。

## 残余缺口（如实）

1. 知网站内未查（需登录，合规边界）；维持"知网侧未测"声明。
2. Semantic Scholar 1 次查询 429 未完成（未重试，curl 预算尽；三通道重叠覆盖作部分对冲）。
3. zbMATH "Pisano period linear recurrence" 3 条记录被许可掩码，标题不可研判（P1 文献层背景项，不影响主裁决——主裁决通道均无信号）。
4. 通用 web 层（Bing/DDG）通道降级：Bing 返回本地化/词典污染，DDG 被 DNS 污染 + 代理连接失败，未获有效证据；中英文通用搜索层覆盖弱于 03 方向复审。
5. 一审冒烟声明的 kernel 闭合（P1 已编译通过）不在本审职责内，未复验；本审仅裁文献/序列/形式化库三层独占性。

## 附：检索量记账

curl 合计 **60 次（=预算顶，未超）**：OEIS 检索 26（校准 1 + 序列形态 17 + 递推/母函数 2 + 关键词 6）+ jsdelivr 单条 2 + arXiv 11（含 http 试错 3）+ OpenAlex 8 + zbMATH 4 + Semantic Scholar 1（429）+ GitHub API 5（含 404 试错 3）+ DuckDuckGo 2（000 失败）；FetchURL 3 次（Bing，不计 curl）；本地 python 重算 1 次 + 本地扫描/解析脚本 6 次；rg 3 组（mathlib×2、compfiles×1）；llm-call 0；gate-batch 0。证据目录：`tasks/20260926-beian-select/recheck/04-cylinder-3holes/`。


---

## Appendix (added by the claim packager): raw evidence file list

Repository directory `tasks/20260926-beian-select/recheck/04-cylinder-3holes/` (58 files, in-repo, not shipped):

- `04-cylinder-3holes/A033515.seq`
- `04-cylinder-3holes/A287428.seq`
- `04-cylinder-3holes/ax-abstracts.out`
- `04-cylinder-3holes/ax-delvert.xml`
- `04-cylinder-3holes/ax-hosoya-cyl.xml`
- `04-cylinder-3holes/ax-lundow.xml`
- `04-cylinder-3holes/ax-matchings-cyl.xml`
- `04-cylinder-3holes/ax-md-cyl.xml`
- `04-cylinder-3holes/ax-monopole.xml`
- `04-cylinder-3holes/ax-stacked-prism.xml`
- `04-cylinder-3holes/ax-vacancy.xml`
- `04-cylinder-3holes/gh-repo.json`
- `04-cylinder-3holes/gh-search.json`
- `04-cylinder-3holes/kw-scan.out`
- `04-cylinder-3holes/kw-scan2.out`
- `04-cylinder-3holes/oa-defect.json`
- `04-cylinder-3holes/oa-hosoya.json`
- `04-cylinder-3holes/oa-match-cyl.json`
- `04-cylinder-3holes/oa-md-cyl.json`
- `04-cylinder-3holes/oa-prism.json`
- `04-cylinder-3holes/oa-t-hosoya-cyl.json`
- `04-cylinder-3holes/oa-t-match-cyl.json`
- `04-cylinder-3holes/oa-t-monomerdimer.json`
- `04-cylinder-3holes/oeis-A-drop1.json`
- `04-cylinder-3holes/oeis-A-drop2.json`
- `04-cylinder-3holes/oeis-A-full.json`
- `04-cylinder-3holes/oeis-A-mid.json`
- `04-cylinder-3holes/oeis-A-midinner.json`
- `04-cylinder-3holes/oeis-A-plus1.json`
- `04-cylinder-3holes/oeis-B-drop1.json`
- `04-cylinder-3holes/oeis-B-drop2.json`
- `04-cylinder-3holes/oeis-B-full.json`
- `04-cylinder-3holes/oeis-B-mid.json`
- `04-cylinder-3holes/oeis-B-plus1.json`
- `04-cylinder-3holes/oeis-C-drop1.json`
- `04-cylinder-3holes/oeis-C-drop2.json`
- `04-cylinder-3holes/oeis-C-full.json`
- `04-cylinder-3holes/oeis-C-mid.json`
- `04-cylinder-3holes/oeis-C-plus1.json`
- `04-cylinder-3holes/oeis-M-drop1.json`
- `04-cylinder-3holes/oeis-M-full.json`
- `04-cylinder-3holes/oeis-calib.json`
- `04-cylinder-3holes/oeis-gf.json`
- `04-cylinder-3holes/oeis-kw-c3pn.json`
- `04-cylinder-3holes/oeis-kw-cylmatch.json`
- `04-cylinder-3holes/oeis-kw-deleted.json`
- `04-cylinder-3holes/oeis-kw-holes.json`
- `04-cylinder-3holes/oeis-kw-hosoya.json`
- `04-cylinder-3holes/oeis-kw-monomerdimer.json`
- `04-cylinder-3holes/oeis-rec.json`
- `04-cylinder-3holes/s2-md-cyl.json`
- `04-cylinder-3holes/sequencelib-tree.json`
- `04-cylinder-3holes/verify-seq.out`
- `04-cylinder-3holes/verify-seq.py`
- `04-cylinder-3holes/zb-hosoya.json`
- `04-cylinder-3holes/zb-match-cyl.json`
- `04-cylinder-3holes/zb-md-cyl.json`
- `04-cylinder-3holes/zb-pisano.json`
