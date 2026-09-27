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
