# C9 novelty record -- notchgrid-parity-mod (full query record)

> This file is the novelty-evidence body of the claim package. It is assembled by
> mechanical line-range extraction from the two source archives named below; nothing
> inside a block was edited, re-ordered or rewritten, and no conclusion was changed.
> Each block is verified byte-for-byte against its source range at packaging time
> (verification report: audit/c9-verify.txt of this package; assembly script:
> logs/notchgrid-claim-c9.py in the AI4Math repository).
>
> Sources:
>   S1 = tasks/20260927-mossad-select/c9-recheck/chunk-G.md (C9 re-adjudication, swarm wave 2)
>   S2 = harness/selection-map/pools/mossad-50.md (selection pool card, Part A)
>
> Block map (source : lines : content):
  B1 : chunk-G.md : 5-10 : C9 chunk-G -- anchor self-check and channel status (incl. the OpenAlex 429 degradation)
  B2 : chunk-G.md : 35-59 : C9 chunk-G -- MAT-3NOTCH: 3 x n grid with the top-right vertex deleted, full query record
  B3 : chunk-G.md : 61-84 : C9 chunk-G -- MAT-4NOTCH: 4 x n grid with the top-right vertex deleted, full query record
  B4 : chunk-G.md : 116-117 : C9 chunk-G -- block summary rows of the two candidates (verdict / value tier / pool advice)
  B5 : chunk-G.md : 122-122 : C9 chunk-G -- channel degradation memo
  B6 : mossad-50.md : 26-33 : pool card Part A -- pool-mossad-02 (3NOTCH) entry
  B7 : mossad-50.md : 35-42 : pool card Part A -- pool-mossad-03 (4NOTCH) entry

> Cited verdicts for the record (quoted from the blocks below, not restated):
> both main propositions adjudicate to the "no occupying record found" state at value
> tier "new sequence / new recurrence"; the derived perfect-matching sub-count of the
> 3 x n notch is occupied by OEIS A001353 with its own attribution, and the
> 4 x n perfect-matching direction is degenerate (4n-1 is odd). OpenAlex returned
> HTTP 429 throughout and the general web-search layer was degraded.

---

## B1 -- C9 chunk-G -- anchor self-check and channel status (incl. the OpenAlex 429 degradation)

source: `tasks/20260927-mossad-select/c9-recheck/chunk-G.md`, lines 5--10

## 锚点自证

- OEIS `0,1,1,2,3,5,8,13` → **A000045**（Fibonacci numbers，%S 逐位对齐）✓
- OEIS `1,3,13,22,44,90,196,406` → **A180970**（tatami tilings of a 3×n grid，%S 逐位对齐）✓
- 外部报告锚点串 `3,,,1,3,,,2,2,,`（空字段剥除缺陷）按纪律未使用。
- 通道状态：OEIS 检索 + jsdelivr 镜像可用；zbMATH 可用（含干净零读数）；arXiv API 可用（精确短语口径，判别力弱）；MSE 可用；**OpenAlex 匿名检索全程 429 限流 → 判「未验证」**（不反复重试，不作零文献证据）；GitHub API 中途限流（repo search 已出读数）；Bing（cn.bing.com）可达但英文查询返回 SEO 噪声、DuckDuckGo 被 DNS 污染且本会话无 WebSearch 工具 → 网页检索层降级，文献层以 zbMATH 为主证据。
---

## B2 -- C9 chunk-G -- MAT-3NOTCH: 3 x n grid with the top-right vertex deleted, full query record

source: `tasks/20260927-mossad-select/c9-recheck/chunk-G.md`, lines 35--59

## MAT-3NOTCH 3×n 网格图缺右上角一点的匹配数

- 命题草图：设 a(n) 为 3×n 网格图（P_3×P_n）删去右上角顶点后的匹配数（全匹配，含空匹配）；给出递推或闭式。
- 送检数列（逐字抄录）：`2,10,67,407,2546,15782,98104,609304,3785279,23513959,146071248,907403160`
- 外部报告原判（线索，非证据）：数据层 6 变体零命中；zbMATH/arXiv 通道不可用；OpenAlex 补充层命中量 1/0；判「可进下一阶段」。
- 独立重算（Python 暴力枚举全匹配，删顶点 (0,n-1) 后重编号）：n=1..8 得 `[2,10,67,407,2546,15782,98104,609304]`，**与送检数列逐位一致**（n=9..12 项过大未重算，前 8 项一致 + 外部 DP 与暴力互证）。送检数列 = 命题真实计数。
- 我方查新记录：
  - OEIS：`2,10,67,407,2546,15782,98104,609304` → zero-hit（null）
  - OEIS：`10,67,407,2546,15782,98104,609304`（去前 1）→ zero-hit
  - OEIS：`67,407,2546,15782,98104,609304`（去前 2）→ zero-hit
  - OEIS：`4,20,134,814,5092,31564,196208,1218608`（×2）→ zero-hit
  - OEIS：`3,11,68,408,2547,15783,98105,609305`（+1）→ zero-hit
  - OEIS：÷2 不适用（奇偶混合）
  - OEIS 关键词：`Hosoya index grid graph` → 3 命中（A143945 Wiener index、A228313/4 超 Wiener 三角形等，均非缺角匹配计数）；`monomer dimer grid` → 10 命中（A210662 完整 n×k 板单体-二聚体三角形、A180970 tatami 等，无缺角条目）
  - 三角形列核验（纪律第 8 条）：取 A210662 %e/数据手工切行列——T(3,·)=3,22,131（完整 3×n 板）、T(n,3)=131,823,5096,…（完整 3 列板），均不含 2,10,67,407,2546；**非已知三角形行/列**。
  - 派生命题独立查新（纪律第 7 条）：
    - 完美匹配子计数（仅 n 奇时非零）：n=1,3,5,7,9,11,13 → `1,4,15,56,209,780,2911`；OEIS `1,4,15,56` → **A001353**（a(n)=4a(n-1)-a(n-2)，0,1,4,15,56,209,780,2911）逐位对齐（offset +1）；OEIS `4,15,56` → A001353（同）。jsdelivr 核读 A001353.seq：%C 有 Joshua Zucker 与 Castilleja School Math Club（2003-10-28）注释「3×(2n-1) 矩形末端加贴一格的骨牌打包数」——**该派生命题已被 OEIS 挂名**。我方数值核验：Zucker 形状（3×(2n-1)+角贴格）PM = 1,4,15,56,209,780,2911，与我方缺角图形（3×(2k-1) 缺一角）PM 在 k≤7 完全一致（两形状计数值恒等，至少前 7 项实证）。
    - 近完美匹配子计数（n 偶）：n=2,4,6,8 → `4,29,161,798`；OEIS `4,29,161,798` → zero-hit。
  - 文献层：zbMATH `monomer dimer grid` → 12 命中（熵/独立集方向，如 6668924 *Enumerating independent vertex sets in grid graphs*、2212821 单体-二聚体熵，无缺角网格匹配计数）；zbMATH `matching polynomial grid graph` → 90 命中（7008782 *Forcing and anti-forcing polynomials of perfect matchings for some rectangle grids* 等矩形网格完美匹配方向，非缺角全匹配）；zbMATH `matchings grid graph corner` → 1 命中（7554449 方格-六方格点阵随机完美匹配，不相关）；zbMATH `deficient graph matchings` → 2 命中（3-图/3-部图完美匹配谱阈值，不相关）；zbMATH `monomer dimer lattice vacancy` → 1 命中（900188958 *Packing dimers on (2p+1)×(2q+1) lattices*，奇×奇格整体格，非 3×n/4×n 缺角）；MSE `number of matchings grid graph` → 6 条无同命题；arXiv `monomer dimer grid graph` → 0；OpenAlex → 429 未验证。
  - 库层：mathlib 无 GridGraph 定义（rg `GridGraph|gridGraph` 于 SimpleGraph 目录零命中）、Matching.lean 无计数定理；compfiles → 0；sequencelib → 0（无对应 A 号文件）。
  - Lean 生态：GitHub repo search 无 lean+图匹配仓；unsorry 树遍历被限流无证据；drhodes/pb100、zhuanhao-wu/18.100a 与本命题无关（未逐文件核，如实记）。
- 别名集：matching = Hosoya index = monomer-dimer covering；grid graph = lattice graph = P_m×P_n；notched = deficient = with hole；perfect matching = 1-factor = dimer covering。
- **C9 裁决**：**查无占位**（主命题：OEIS 5 变体 + 关键词 + 文献层 + 库层 + Lean 生态层全查无命中，各通道经锚点/读数确认可用；唯一降级通道 OpenAlex 429 记「未验证」，不构成零文献证据但不影响四通道互证格局）——**但派生 PM 子命题已占位 A001353（带 Zucker/Math Club 挂名注释），立项时不得将 PM 子计数作为新颖性主张**。
- **价值级**：**新序列/新递推**（主命题 OEIS 查无占位、对象层无挂名；mathlib 无网格图定义、无匹配计数基础设施，形式化工作量为从头建定义）。
- **题库建议**：**入池**——主命题数据层与对象层双查无占位；附条件：①命题表述用「全匹配计数」主口径；②PM 子命题已占位（A001353）须在卡上注明、不得主张新颖；③mathlib 无 GridGraph，形式化需先自建 3×n/4×n 网格图定义（C3 预检清单须含此项）。
---

## B3 -- C9 chunk-G -- MAT-4NOTCH: 4 x n grid with the top-right vertex deleted, full query record

source: `tasks/20260927-mossad-select/c9-recheck/chunk-G.md`, lines 61--84

## MAT-4NOTCH 4×n 网格图缺右上角一点的匹配数

- 命题草图：设 a(n) 为 4×n 网格图（P_4×P_n）删去右上角顶点后的匹配数（全匹配，含空匹配）；给出递推或闭式。
- 送检数列（逐字抄录）：`3,32,407,4840,58608,705949,8515850,102684287,1238310540,14932804736,180076488943,2171558769120`
- 外部报告原判（线索，非证据）：数据层 6 变体零命中；关键词层不可用；判「可进下一阶段」。
- 独立重算（Python 暴力枚举全匹配，删顶点 (0,n-1)）：n=1..6 得 `[3,32,407,4840,58608,705949]`，**与送检数列逐位一致**。送检数列 = 命题真实计数。
- 我方查新记录：
  - OEIS：`3,32,407,4840,58608,705949` → zero-hit
  - OEIS：`32,407,4840,58608,705949`（去前 1）→ zero-hit
  - OEIS：`407,4840,58608,705949`（去前 2）→ zero-hit
  - OEIS：`6,64,814,9680,117216,1411898`（×2）→ zero-hit
  - OEIS：`4,33,408,4841,58609,705950`（+1）→ zero-hit
  - OEIS：÷2 不适用（首项 3 为奇）
  - OEIS 关键词：`Hosoya index grid graph` / `monomer dimer grid`（同 MAT-3NOTCH 记录）无 4×n 缺角条目；A210662 切列核验：完整 4×n 板行 T(4,·)=5,71,823,10012 不含 3,32,407,4840。
  - 派生命题独立查新：
    - 完美匹配子计数：4n−1 为奇 → **恒 0（退化空命题）**（n=1..6 实测全 0，与波次 1「按奇偶性恒零」教训同型，如实记：该方向无独立查新价值）。
    - 近完美匹配子计数（最大尺寸匹配，2n−1 条边）：n=1..5 → `2,7,29,88,288`；OEIS `2,7,29,88,288` → zero-hit；`7,29,88,288`（去前 1）→ zero-hit。
  - 文献层：同 MAT-3NOTCH 各 zbMATH 查询（`monomer dimer grid` 12 / `matching polynomial grid graph` 90 / `matchings grid graph corner` 1 不相关 / `deficient graph matchings` 2 不相关 / `monomer dimer lattice vacancy` 1 不相关）；MSE → 无同命题；arXiv `monomer dimer grid graph` → 0；OpenAlex → 429 未验证。
  - 库层：mathlib 无 GridGraph、无匹配计数定理；compfiles → 0；sequencelib → 0。
  - Lean 生态：同 MAT-3NOTCH（GitHub repo search 零命中；unsorry 限流无证据）。
- 别名集：matching = Hosoya index = monomer-dimer covering；grid graph = lattice graph = P_4×P_n；notched = deficient = with hole；near-perfect matching = maximum matching。
- **C9 裁决**：**查无占位**（主命题与近完美子命题 OEIS 全变体零命中；文献层四通道（zbMATH/MSE/arXiv/OEIS）可用且无同命题；OpenAlex 429 记未验证；PM 子命题退化恒零不构成占位）。
- **价值级**：**新序列/新递推**（主命题 OEIS 查无占位、对象层无挂名；mathlib 无网格图定义，形式化需从头建）。
- **题库建议**：**入池**——数据层/对象层双查无占位；附条件同 MAT-3NOTCH（全匹配主口径；须自建 GridGraph 定义进 C3 清单）。
---

## B4 -- C9 chunk-G -- block summary rows of the two candidates (verdict / value tier / pool advice)

source: `tasks/20260927-mossad-select/c9-recheck/chunk-G.md`, lines 116--117

| MAT-3NOTCH 3×n 缺右上角匹配数 | 查无占位（主命题；派生 PM 子命题已占位 A001353） | 新序列/新递推 | 入池（附条件：全匹配主口径；PM 子命题占位须注明；须自建 GridGraph） | Python 重算 8 项吻合送检；OEIS 5 变体+关键词零命中；文献四通道无同命题；zbMATH `matchings grid graph corner` 仅 1 条不相关 |
| MAT-4NOTCH 4×n 缺右上角匹配数 | 查无占位 | 新序列/新递推 | 入池（附条件同 3NOTCH） | Python 重算 6 项吻合送检；OEIS 5 变体+派生近完美序列零命中；PM 恒 0 退化（4n−1 奇） |
---

## B5 -- C9 chunk-G -- channel degradation memo

source: `tasks/20260927-mossad-select/c9-recheck/chunk-G.md`, lines 122--122

通道降级备忘：OpenAlex 全程 429（未验证）；本会话无 WebSearch 工具且 DuckDuckGo DNS 污染、Bing CN 英文查询 SEO 噪声 → 网页检索层未取得可用读数，文献层结论以 zbMATH 为主；此降级对 3 个「查无占位」候选的影响：zbMATH/MSE/arXiv/OEIS 四通道均可用且零命中，OpenAlex 单通道缺失不改变四态，但若后续 OpenAlex 恢复出现强命中，应按灰区回扫（尤其 MAT-CCHORD 的 chorded cycle 方向文献密集）。
---

## B6 -- pool card Part A -- pool-mossad-02 (3NOTCH) entry

source: `harness/selection-map/pools/mossad-50.md`, lines 26--33

### pool-mossad-02 · MAT-3NOTCH 3×n 网格图缺右上角一点的匹配数 【已证】（2026-09-27 mossad-notch 线：T1/T3 完全证明，kernel 终审+监察院核查全过；report.md 待闸门四人工签发；任务目录 tasks/20260927-mossad-notch/）

- NL：设 G_n = P_3 × P_n（3×n 网格图）删去右上角顶点。a(n) = 全部匹配数（含空匹配）。命题：给出递推/闭式。
- 送检数列（已独立重算核验）：`2,10,67,407,2546,15782,98104,609304`（前 8 项暴力枚举逐位一致）。
- **C9 裁决：查无占位**——OEIS 5 变体 + 关键词 + A210662 三角形切列核验（非已知三角形行/列）+ 文献层 zbMATH 5 组/MSE/arXiv 无同命题；锚点自证通过；OpenAlex 429 记未验证（不影响四通道互证格局）。
- **价值级：新序列/新递推**。
- **入库条件**：①主口径用「全匹配计数」；②派生 PM 子命题（n 奇）已占位 **A001353**（带 Zucker/Castilleja Math Club 挂名注释，数值核验恒等至 k=7）——不得作新颖性主张；③mathlib 无 GridGraph 定义，C3 预检清单须含「自建 3×n/4×n 网格图定义」。
- 证据：`tasks/20260927-mossad-select/c9-recheck/chunk-G.md`。
---

## B7 -- pool card Part A -- pool-mossad-03 (4NOTCH) entry

source: `harness/selection-map/pools/mossad-50.md`, lines 35--42

### pool-mossad-03 · MAT-4NOTCH 4×n 网格图缺右上角一点的匹配数 【已证】（2026-09-27 mossad-notch 线：T2/T4 完全证明，kernel 终审+监察院核查全过；report.md 待闸门四人工签发；任务目录 tasks/20260927-mossad-notch/）

- NL：设 G_n = P_4 × P_n 删去右上角顶点。a(n) = 全部匹配数（含空匹配）。命题：给出递推/闭式。
- 送检数列（已独立重算核验）：`3,32,407,4840,58608,705949`（前 6 项暴力枚举逐位一致）。
- **C9 裁决：查无占位**——OEIS 5 变体 + 派生近完美匹配序列（`2,7,29,88,288`）零命中；文献层同 3NOTCH 五组 zbMATH 无同命题；PM 子命题 4n−1 恒奇 → 恒 0（退化空命题，不构成占位）。
- **价值级：新序列/新递推**。
- **入库条件**：同 pool-mossad-02（全匹配主口径；须自建 GridGraph 进 C3 清单）。
- 证据：`tasks/20260927-mossad-select/c9-recheck/chunk-G.md`。
