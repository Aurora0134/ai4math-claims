# c9-record.md — C9 独占性查新全量记录（逐字拼接件）

> 本件由论文部占位通道工人于 2026-10-06 机械拼接（装配注记），两部分均为源记录**逐字副本**，结论一字未改（SOP 08b 工序 3：禁止改写 C9 结论）。
> - Part 1 源：`tasks/20261005-dig-lin14-brocard/deep/draft-cards/d2-novakovic-open-case-nfact-primorial.md`《C9 独占性查新记录》节（该文件第 113–138 行，逐字）。
> - Part 2 源：`tasks/20261006-review-lin14-brocard/report.md`《五、深挖查漏（子代理 B 在线补查 + 复核补做）》节（该文件第 61–68 行，逐字；独立复核批的补查记录，2026-10-06）。
> 两份源文件留在源仓任务目录，不随本包；拼接动作可由交付目录侧的 `audit/build-c9-record.py`（不随包）重放复算。

---

# Part 1：深挖草案卡《C9 独占性查新记录》（2026-10-05 收口层，逐字）

### C9 独占性查新记录

**四态裁决：查无占位（检索强度标签 = 强）。**

| 通道 | 查询串 | 返回 | 落盘 |
|---|---|---|---|
| **文献（作者自陈）** | 2601.16757 正文逐字 | 「We believe that finitely many solutions occur for `x² = n!·n#` or `x² = n!!·[1,…n]`, **but at the moment we were not able to give an argument**」 | `raw-brocard-deep/txt-2601.16757.txt:160`（引用二审 raw） |
| arXiv 元数据 | `all:"primorial" AND all:"factorial" AND all:"perfect square"` | **totalResults = 0** | `raw-n6/arxiv-primorial-factorial-square.xml` |
| arXiv 元数据 | `all:"primorial" AND all:"factorial" AND all:"square"` | **totalResults = 0** | `raw-n6/arxiv-primorial-square-factorial2.xml` |
| arXiv 元数据 | `all:"double factorial" AND all:"least common multiple"` | **totalResults = 0**（第二条缝） | `raw-n6/arxiv-doublefactorial-lcm.xml` |
| arXiv 元数据 | `all:"squarefree part" AND all:"factorial"` | **totalResults = 0** | `raw-n6/arxiv-squarefree-part-factorial.xml` |
| arXiv 元数据 | `all:"Brocard" AND all:"primorial"` | totalResults = 1（2606.23485 = 机制邻压，**不覆盖本缝**） | `raw-n6/arxiv-primorial-brocard.xml` |
| OpenAlex 全文 | `searrocard primorial square factorial` | count = 2（2606.23485；Marius Coman 2013 科普百科） | `raw-n6/oa-brocard-primorial.json` |
| OpenAlex 全文 | `search=k-free Brocard Ramanujan finitely many solutions` | count = 16，含 2601.16757 / 2602.09687 | `raw-n6/oa-kfree-naciri-effective.json` |
| OEIS 关键词 | `n! primorial square` | 10 命中，**无同形**（A145781 对象不同） | `raw-n6/oeis-kw-nfact-primorial-square.json` |
| OEIS 关键词 | `factorial times primorial is a square` | 7 命中，**无同形** | `raw-n6/oeis-kw-factorial-square-primorial.json` |
| OEIS 关键词 | `double factorial lcm square` | **`null`（零命中）** | `raw-n6/oeis-kw-doublefactorial-lcm-square.json` |
| OEIS 关键词 | `Novakovic factorial` | **`null`** | `raw-n6/oeis-kw-novakovic.json` |
| FC tarball 内容级 | `primorial` | 3 文件（FortuneConjecture.lean / OEIS/38771 / OEIS/80326），**无本域件** | 镜像 `eco/formal-conjectures-main/` |
| FC tarball 内容级 | `doubleFactorial` / `double_factorial` | **0 / 0** | 同上 |
| 通道有效性前置 | mathlib rg `--follow` + 阳控 `Nat.Prime` = 138 文件 | 通道有效 | `deep/raw-main/mathlib-rg.txt` |

**锚点指针与首提年份**：Novaković 2026-01-23（arXiv:2601.16757，正文 Remark，**本缝的首提**）；`n!·n#` 为平方的小值（`5!·5# = 3600 = 60²`）见 A055204/A002110 语境。
**纪律 13（编号/人名错配必回原文状态条）**：本卡**不把 erdosproblems #399 当作本缝的编号**——#399 的对象是 `n! = x^k ± y^k`（FC `ErdosProblems/399.lean` 已核，其 `erdos_399.variants.sum_two_squares` 的对象是 `n! = x²+y²`），与本缝（`x² = n!·n#`）**不同物**；#399 只作**同族邻接锚点**记录。本缝的直接锚点 = **文献自陈未解**。
**通道状态**：全部可用。
**题源自述处置**：本件为文献缝延伸（非「自造」标签免检）；C5 + C9 已全跑。

---

# Part 2：复核批《深挖查漏》补查记录（2026-10-06 复核层，逐字）

## 五、深挖查漏（子代理 B 在线补查 + 复核补做）

1. **N5 缺口（最大缺口）已补**：2606.23485 全文逐节核查——**不处理** x²=n!·n#（其 §5.3.1「primorial 核 Pell」X²−DZ²=1、D=p_n#、Z²=n!/p_n# 与 D2 对象相邻但仅给 n=5 示例，从未刻画哪些 n 使 n!·n# 为平方），**不处理**连续移位对（全文 (n+1)! 零命中）⟹ **D2 与 N7-B 均不撞车，N5 未回交不藏雷**。义务：D2 候选卡相关工作节须引该文 §5.3.1。
2. **新漏检 1 件**：**arXiv:2610.01899**（2026-10-01，阶乘平方积与 Erdős–Graham 猜想，D_k(X) 增长阶）——同族文献，提交仅比批次早 4 天，批次未引。与 D2 对象不同、不撞车，但 D2 卡面有引用义务。
3. **#399 状态翻案**：`n!=x^k±y^k` 已 **DISPROVED (Lean)**（2026-02-04，反例 10!=48⁴−36⁴；FC 399.lean 主定理已证成、无 sorry）。批次仅在候选 1 判定行把 #399 作「同族邻接」且明写「逐字区分对象」，未称 open，**未违规**；但下游卡面不得把 #399 当开放锚点。其 FC 变体 `sum_two_squares`（n!=x²+y² 唯一解 6!=12²+24²，带 sorry）与 Dąbrowski 的 n!+1=x²+y² 确为不同对象——N6 报告此点正确。
4. **Kurepa 侧补查**：2604.09714（KBW 同余，商层级）为「!p 新同余」型公开先行件——N4 路已收口 0 件，无影响；若日后重开 Kurepa 侧须与之差异化。2509.06077（划分函数侧）不撞车。2609.28805（2026-09-23，Kurepa 变体并行搜索）不撞车。
5. **撞车再确认（全部零命中）**：D2 的 x 值列 1,1,2,6,12,60 与 x² 值列 1,4,36,144,3600 在 OEIS 无对象登记；N7-B 三条 k 值列（1,76,505 / 241,505,2089,5209,22081 / 436,1044,2529,5364）全 null；N7-A 的 N_k 值列全 null + arXiv「Legendre symbol × factorial × prime gap」零条。⟹ 批次的核心新颖性结论本轮未被推翻。
6. **#398 仍 open**（2026-04-01 编辑，新增 Naciri Integers 2025 A71 条目——批次已持有该件，非漏检）。
