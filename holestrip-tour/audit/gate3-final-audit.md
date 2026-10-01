# 闸门三终态审计 · holestrip-tour-pipeline（监察院 dept-audit，2026-09-29 夜）

## 终审结论：签发 ✅　分级 = 完全证明（宪条 4 第一级）

三项硬条件：① 0 sorry（全文零命中，含注释一刀切）② 全部 20 条 #print axioms ⊆ {propext, Classical.choice, Quot.sound}（no_open_tour_0/no_closed_tour_0 为真子集 [propext, Quot.sound]；两主定理恰三件）③ statement 对称差 8/8 SAME（6 定义 + 2 iff，冻结件 proof sorry → 实证明属宪条 2 允许的只改 proof body）。无额外假设、无命题降级、无 sorry 引理 → 排除条件证明与弱化后证明。

## 独立复核（不采信主代理取证，全部重做）

- 对称差：审计员自写提取器，冻结件 vs 最终件 statement 逐字比对 8/8 SAME（stage4b-full.lean:26,29,33,40,47,50,2580,2608）。
- 独立重编译：scripts/lean-verify 于 verify-proj，86.7s EXIT=0，0 error；主代理 s4b-v18-mainchain.log 声称逐项属实。
- 后门扫描：axiom / implemented_by / unsafe / extern / opaque 零命中。
- 抽查：cut_card_bound（2449-2497 四分支闭合）、cut_bound/no_hamiltonian_of_cut（2499-2539 证书编码方向正确）、双 iff（2580-2630 分支覆盖无缺口、结论无弱化）、cutS6/cutLab6/cutS7/cutLab7（2542-2575 证书形态与声称一致：n=6 六格 8 块>7、n=7 五格 7 块>6，穷举委托 kernel decide）。

## 非否决级发现（5 项）

1. cut_bound 的 hSnd 冗余假设未用（linter 已警）；2. §15 前 set_option maxHeartbeats 4M / maxRecDepth 8k 资源放宽；3. 尾部内嵌 20 条 #print axioms 取证命令；4. 25 条 linter 风格警告（SOP 明文不否决）；5. 主代理三声称（exit=0 / SYMDIFF PASS / 0 sorry）经独立复核全部属实。

## 报告义务限定语（移交外交部）

完全证明 + 脚手架轮标注（§15 = 工人起草+主代理合稿修复 4 处集成级错误；§16 = 主代理承制）+ n=1 开侧真值来自冻结前修正 F0b + n=6/7 负结果走割集证书+kernel decide（DFS 路线作废留档）+ 资源放宽与内嵌取证命令声明 + linter 警告存留声明。

**预算注记**：本次终审独立编译 = 第 49 次主链编译（仍在 56 顶内），已嘱主代理补账。
