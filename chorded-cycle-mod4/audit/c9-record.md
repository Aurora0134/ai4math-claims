> provenance note (added by the claim packager, 2026-09-28): this file is the full
> C9 novelty-review record for MAT-CCHORD (pool-mossad-04), copied VERBATIM and
> byte-for-byte in four contiguous line ranges from
> `tasks/20260927-mossad-select/c9-recheck/chunk-G.md` (source file sha256
> 364f5e6b1485d8fc51a488700d398d4e51477aba8cf9618c2308552db5f731e6; 122 lines, LF):
>
>   lines 1-11     chunk header and the anchor self-proof that fixes what "zero
>                  hit" means on each channel
>   lines 86-109   the MAT-CCHORD entry in full (queries, independent
>                  recomputation, alias set, C9 verdict, value tier, entry
>                  conditions)
>   lines 111-120  the block roll-up table and query statistics for the chunk
>   lines 121-122  the block-level channel-degradation memo, which names
>                  MAT-CCHORD and requires a re-sweep of the grey zones once
>                  OpenAlex recovers
>
> Nothing else was added; the record body is unmodified and its conclusions are
> not reworded. Raw query responses remain in the working repository under
> `tasks/20260927-mossad-select/` (kept in-repo, not shipped in this deposit).
> The exclusivity review was run by selection-department workers at 0 LLM calls;
> the C9 verdict carried into the claim note is "no occupying record found" at
> the value tier "new sequence / new recurrence".

# G C9 重裁记录（swarm 波次 2 匹配/递推/二项式/行列式族；工人独立查新，llm-call 0）

> 工人注记：本区块 4 候选全部为计数型，已按波次 1 教训先用 Python 暴力重算前 3–12 项（全匹配计数口径，含空匹配）并与送检数列逐位比对；查询串全量落卡（含零命中）。外部报告的一切结论仅作线索。

## 锚点自证

- OEIS `0,1,1,2,3,5,8,13` → **A000045**（Fibonacci numbers，%S 逐位对齐）✓
- OEIS `1,3,13,22,44,90,196,406` → **A180970**（tatami tilings of a 3×n grid，%S 逐位对齐）✓
- 外部报告锚点串 `3,,,1,3,,,2,2,,`（空字段剥除缺陷）按纪律未使用。
- 通道状态：OEIS 检索 + jsdelivr 镜像可用；zbMATH 可用（含干净零读数）；arXiv API 可用（精确短语口径，判别力弱）；MSE 可用；**OpenAlex 匿名检索全程 429 限流 → 判「未验证」**（不反复重试，不作零文献证据）；GitHub API 中途限流（repo search 已出读数）；Bing（cn.bing.com）可达但英文查询返回 SEO 噪声、DuckDuckGo 被 DNS 污染且本会话无 WebSearch 工具 → 网页检索层降级，文献层以 zbMATH 为主证据。


## MAT-CCHORD 圈加一组跨长三分之一周长弦的图匹配数

- 命题草图：设 a(n) 为圈 C_n 加上连接 i 与 i+⌊n/3⌋ 的所有弦（mod n）所得图的匹配数（全匹配，含空匹配）；给出递推或闭式。
- 送检数列（逐字抄录）：`2,2,4,7,11,51,99,191,382,780`（外部仅给 10 项）
- 外部报告原判（线索，非证据）：数据层 6 变体零命中；zbMATH `cycle with chords matchings` 命中 5（WITHDRAWN: The Number of Perfect Matchings in Möbius Ladders and Prism）；OpenAlex 96/32；建议窄化切口。
- 独立重算（Python 暴力枚举全匹配，弦 = {(i, i+⌊n/3⌋ mod n) ∀i}）：n=3..15 得 `4,7,11,51,99,191,382,780,1475,2743,5591,10615,19907`。**送检数列 ≠ 命题真实计数**：其前两项 `2,2` 为 n=1,2 退化情形（自环/重边）的 artifact，真实数列自第 3 项起与送检第 3–10 项一致。按纪律两种数列分别查新（真实数列为主，送检数列留档）。
- 我方查新记录：
  - OEIS（送检数列）：`2,2,4,7,11,51,99,191,382,780` → zero-hit；`2,4,7,11,51,99,191,382,780`（去前 1）→ zero-hit；`4,7,11,51,99,191,382,780`（去前 2）→ zero-hit
  - OEIS（真实数列）：`4,7,11,51,99,191,382,780,1475,2743` → zero-hit；`7,11,51,99,191,382,780,1475,2743`（去前 1）→ zero-hit；`11,51,99,191,382,780,1475,2743`（去前 2）→ zero-hit
  - OEIS（变形）：`8,14,22,102,198,382,764,1560,2950,5486`（×2）→ zero-hit；`5,8,12,52,100,192,383,781,1476,2744`（+1）→ zero-hit；÷2 不适用（奇偶混合）
  - OEIS（尾段）：`780,1475,2743,5591,10615,19907` → zero-hit
  - OEIS 关键词：`matchings circulant graph` → 10 命中（A323709 跳 1,2,3 circulant 完美匹配等，非本族）；`chorded cycle matchings` → 10 命中（A383733 chorded cycle 着色、A1006 Motzkin 弦图等，非匹配计数）
  - 派生命题独立查新（纪律第 7 条，按 n mod 3 子序列——跳步 ⌊n/3⌋ 每 3 项换档，子序列即「固定跳步 k 的 C_{3k+r}(1,k)」族）：
    - n=3k 子列：`4,51,382,2743` → zero-hit
    - n=3k+1 子列：`7,99,780,5591` → zero-hit
    - n=3k+2 子列：`11,191,1475,10615` → zero-hit
    - 完美匹配子计数（n 偶）：n=4,6,8,10,12,14 → `2,8,14,44,44,86`；OEIS → zero-hit；去前 1 `8,14,44,44,86` → zero-hit
  - 文献层：zbMATH `Hosoya index circulant graph` → **0 命中（干净零读数）**；zbMATH `matchings circulant graph` → 4 命中（6377053 *The Pfaffian property of circulant graphs* 等，无本族计数）；zbMATH `chorded cycle graph` → 44 命中（7625282 *Results and problems on chorded cycles: a survey*、6674429 *Chorded cycles* 等，全部 pancyclicity/Hamilton 方向，无匹配计数）；zbMATH `matching polynomial circulant` → 20 命中（无本族计数）；MSE `matchings circulant graph` → 0 条；arXiv `circulant graph matching polynomial` → 0；OpenAlex → 429 未验证。
  - 库层：mathlib `Combinatorics/SimpleGraph/Circulant.lean` **有 `circulantGraph` 定义**（本候选的图 = Z/nZ 上跳步 {1, ⌊n/3⌋} 的 circulant，对象层可定义）但无匹配计数定理；无 chorded-cycle 专用定义；compfiles → 0；sequencelib → 0（无对应 A 号）。
  - Lean 生态：GitHub repo search `lean hosoya` → 0、`lean4 graph matching` → 0；unsorry 仓存在（raw README 200，任务注记「上轮 404」与事实不符，如实更正）但树遍历被 GitHub API 限流、无其图匹配形式化证据；mathlib4 上游目录列举被 API 限流未核，库层证据以本地 v4.34.0 钉死快照为准。
- 别名集：chorded cycle = cycle with chords；circulant graph = C_n(1,k) = jumps {±1,±k} on Z/nZ；matching = Hosoya index = monomer-dimer covering；Möbius ladder = C_{2n} + 对径弦（本候选 n≡0 mod 3 且跳步 = n/3 时的近亲，但非同一对象）。
- **C9 裁决**：**查无占位**（真实数列与送检数列共 9 个 OEIS 序列查询 + 3 个子序列 + 2 个 PM 查询 + 关键词层全零命中；zbMATH 干净零读数 + 44 条 chorded cycle 文献均为其他方向；库层/生态层无同形；OpenAlex 429 记未验证）。
- **价值级**：**新序列/新递推**（OEIS 查无占位、对象层无挂名；mathlib 已有 circulantGraph 定义可复用，形式化难度低于两个 NOTCH 候选）。
- **题库建议**：**入池（附形态收窄条件）**——①送检数列前两项系外部管线退化 artifact，**不得直接送检**，卡上须以真实数列 n≥3 起；②命题「给出递推或闭式」对整族存疑：跳步 ⌊n/3⌋ 随 n 每 3 项换档，预期无统一低阶常系数递推（增长呈周期 3 分段），建议改写为「按 n mod 3 分子族各给递推/转移矩阵」或「固定 k 的 C_{3k}(1,k) 匹配数」再入闸；③mathlib Circulant 定义可复用（C3 正面证据）。

## 区块小结

| 候选 | C9 裁决 | 价值级 | 题库建议 | 关键证据 |
|---|---|---|---|---|
| MAT-COMB 梳状图匹配数 | 已占位 | 首个形式化 | 不入池 | OEIS A000129 逐位对齐（offset +2）；polyphenylene chain（=梳状图）Hosoya 文献（zbMATH 6620842/6986947）；sequencelib A000129.lean 已形式化 |
| MAT-3NOTCH 3×n 缺右上角匹配数 | 查无占位（主命题；派生 PM 子命题已占位 A001353） | 新序列/新递推 | 入池（附条件：全匹配主口径；PM 子命题占位须注明；须自建 GridGraph） | Python 重算 8 项吻合送检；OEIS 5 变体+关键词零命中；文献四通道无同命题；zbMATH `matchings grid graph corner` 仅 1 条不相关 |
| MAT-4NOTCH 4×n 缺右上角匹配数 | 查无占位 | 新序列/新递推 | 入池（附条件同 3NOTCH） | Python 重算 6 项吻合送检；OEIS 5 变体+派生近完美序列零命中；PM 恒 0 退化（4n−1 奇） |
| MAT-CCHORD 圈加 1/3 周长弦匹配数 | 查无占位 | 新序列/新递推 | 入池（附条件：真实数列 n≥3；命题按 n mod 3 收窄） | 送检数列前 2 项为退化 artifact；真实数列 4,7,11,51,99,191,382,780,1475,2743,5591,10615,19907 全变体+子序列+PM 派生 OEIS 零命中；zbMATH `Hosoya index circulant graph` 干净零读数；chorded cycle 文献 44 条均非匹配计数方向 |

统计：外部查询共 **77 条**（OEIS 44 含锚点 2 与 A210662 列核验 1、zbMATH 15、OpenAlex 3 全 429 未验证、arXiv 3、MSE 3、Bing 3、GitHub 4、jsdelivr 2），另有 Python 独立重算 5 轮；**撞车 3 处**（MAT-COMB 主序列 A000129、MAT-3NOTCH 派生 PM A001353、及 A001353 的 Zucker/Math Club 挂名注释）；**查无占位 3 处**（3NOTCH 主命题、4NOTCH、CCHORD）；未裁决 0 处。llm-call 0/4。


通道降级备忘：OpenAlex 全程 429（未验证）；本会话无 WebSearch 工具且 DuckDuckGo DNS 污染、Bing CN 英文查询 SEO 噪声 → 网页检索层未取得可用读数，文献层结论以 zbMATH 为主；此降级对 3 个「查无占位」候选的影响：zbMATH/MSE/arXiv/OEIS 四通道均可用且零命中，OpenAlex 单通道缺失不改变四态，但若后续 OpenAlex 恢复出现强命中，应按灰区回扫（尤其 MAT-CCHORD 的 chorded cycle 方向文献密集）。
## appendix: extraction self-check

| range | source lines | bytes | sha256(body, first 16) |
|---|---|---|---|
| 1 | 1-11 | 1207 | 84009889a40463eb |
| 2 | 86-109 | 4910 | 3eda915cefdb708b |
| 3 | 111-120 | 1818 | 56445fa019119396 |
| 4 | 121-122 | 504 | c067fe3e655fa125 |

Recompute with: `python claims/chorded-cycle-mod4/audit/build-c9-record.py --check`
