# 闸门三终态审计（监察院）— tasks/20260926-edgemid-pipeline · final/03-proof-complete.lean

- 签发：2026-09-26T23:33（dept-audit 监察院，dynamic-workflow 子代理；node=anthropic/S3AI-Grok/grok-4.7，记账见 budget.log 本步行）。
- 判据：`harness/departments/05-audit-final.md`（SOP 05）+ 宪条 1/2/3/4。本岗只读裁决，不重跑 kernel 编译；kernel 独立复验由脚本实跑（第 1 轮 ask 转述）：**strict exit=0**；P1 `WELLDEF OK / AXIOMS [propext, Quot.sound]`，P2 `WELLDEF OK / AXIOMS [propext, Classical.choice, Quot.sound]`（落盘原文 `audit/final-axioms-p1.txt`、`final-axioms-p2.txt`，本岗已核读）。kernel 脚本侧编译累计 9/24（ask 口径）。
- 审计对象：`final/03-proof-complete.lean`（2861 B，UTF-8，两冻结件 import 面并集，无 namespace）。产出：本文件 + LF 归一化后的 final 文件 + budget.log 记账。

## ① statement 对称差（宪条 2）——**零差异**

| 定理头 | 冻结快照行段 | final 行段 | 比对命令 | 结果 |
|---|---|---|---|---|
| P1 `edgemid_master`（docstring+head，至 `:= by`） | `formalized/edgemid-p1-statement.lean:12-17` | `final/03-proof-complete.lean:15-20` | `diff <(sed -n '12,17p' …p1-statement.lean) <(sed -n '15,20p' …03-proof-complete.lean)` | **diff 空（逐字节一致）** |
| P2 `edgemid_matrix_family`（docstring+head，至 `:= by`） | `formalized/edgemid-p2-statement.lean:14-22` | `final/03-proof-complete.lean:44-52` | `diff <(sed -n '14,22p' …p2-statement.lean) <(sed -n '44,52p' …03-proof-complete.lean)` | **diff 空（逐字节一致）** |

- 三文件均经 `file` 确认 UTF-8、无 CRLF（CR 计数见 ②），比对在相同行尾基线上进行，无行尾噪声。
- 冻结件尾部的 `  sorry`（p1:18、p2:23）属 proof body 脚手架，不在定理头行段内；final 以真实证明体替换之，系宪条 2 许可的唯一改动面。
- 证明侧只改 proof body：final 全文件恰两条 `theorem`（:18、:46），无 `axiom/def/lemma/namespace/macro/notation/instance` 附加声明（grep 实测零命中），imports = 两冻结件 import 并集（`Mathlib.Data.Int.ModEq` + `Mathlib.Data.Matrix.Mul`），与 final 头注自述一致。
- **对称差 = 0，无 statement 篡改。**

## ② LF 归一化 + sha256

- 归一化前：`tr -cd '\r' < final/03-proof-complete.lean | wc -c` → **0**（本就纯 LF）。
- 归一化命令（字面执行）：`tr -d '\r' < final/03-proof-complete.lean > final/03-proof-complete.lean.lfnorm && mv -f final/03-proof-complete.lean.lfnorm final/03-proof-complete.lean`。
- 归一化后：`sha256sum final/03-proof-complete.lean` → **`1124e6a53b6ec70fee5c964490fa4f407a23ab03b1557d3f7d214b0c20572c1d`**（2861 B；与归一化前同值，文件字节未变）。
- 归一化后的编译复核由脚本下一轮执行（ask 明示），非本岗动作。

## ③ 终态审计（宪条 3）

1. **0 sorry**：`grep -n -E 'sorry|admit' final/03-proof-complete.lean` → **无匹配（exit 1）**；与 kernel strict exit=0（严格准则内含无 sorry/admit）双证一致（SOP 05 动作 3 双保险）。
2. **公理白名单**：`audit/final-axioms-p1.txt` = `WELLDEF OK` + `AXIOMS edgemid_master [propext, Quot.sound]`；`audit/final-axioms-p2.txt` = `WELLDEF OK` + `AXIOMS edgemid_matrix_family [propext, Classical.choice, Quot.sound]`。两清单均 ⊆ {propext, Quot.sound, Classical.choice}，**无 sorryAx**。文件内容与 ask 转述的 kernel 复验逐字一致。
3. **结构完整性（附加走查）**：无 `sorryAx/native_decide/axiom` 字样（grep exit 1）；无 namespace（card.md:31 硬约束）。
4. **口径注记**：ask 转述 kernel 复验行含 `PROBE FAIL 0/0; CHECK OK 0/0`——final 闸门批次仅含 WELLDEF+AXIOMS 两段（`audit/.gate-batch.map` 仅两行，探针/check 段不属终态闸门；探针非退化 7/7 FAIL 已由闸门二裁决卡 `audit/welldef-verdict.md` §0 记录在案）。该形态与 22:10 report.md:88 记录的 CWD 空输出失败签名（`WELLDEF FAIL; …; AXIOMS []`）可区分：本次 `WELLDEF OK` 且 AXIOMS 带实定理名与公理清单。

### 结论分级（宪条 4，按实际最低级）

**分级 = 完全证明（P1 与 P2 各自成立）。** 三要件齐备：0 sorry（③.1）；公理仅白名单子集（③.2）；statement 未动（①对称差 0）。无额外假设、无降级引理、无 sorry 脚手架残留，无更低级适用。

**kernel 主张范围（不得越级外推）**：两定理即其 Lean 陈述本身——P1 =「六阶线性递推 ⇒ 模 2 周期 6 + n%6 刻画」（任意满足假设的整数序列）；P2 =「矩阵泛函层的统一递推定理」（任意被 x⁶−4x⁵−14x⁴+10x²−1 零化的 8×8 整矩阵的 mulVec 泛函）。组合语义（铺法计数）解读见 ④ 降级声明，不属 kernel 主张。

## ④ 组合语义桥降级声明核验——**通过**

- **主张限定在档**：「kernel 主张 = 矩阵泛函层的统一递推定理」逐字见 `formalized/roundtrip.md:80`（具名缺口节）、`report.md:75`（§⑥）、`formalized/evidence-pack.md:65`（§⑤1）；冻结 P2 文件头注释（`edgemid-p2-statement.lean:10-11`）自带降级声明。
- **桥不在 Lean 具名在档**：roundtrip.md:76-79——statement 中 T 只是任意零化矩阵，既无「T = 某 3×n 棋盘转移矩阵」构造，也无「`(T^n).mulVec v i` = 缺陷匹配计数」等式桥；成因（mathlib 无 monomer/dimer/匹配计数 API、完整组合形式化触 C1）同节记录。
- **缺口正面清单在档**（ask 指定证据包）：`formalized/evidence-pack.md` §④（:52-61）共 8 条 rg 实证——monomer/dimer 0 命中、domino 0 命中、匹配 API 仅 Prop 级谓词无计数（`SimpleGraph.Subgraph.IsMatching`，Matching.lean:67）、P₃×Pₙ 网格图对象缺位、Tile.lean 抽象铺盖不可复用、LinearRecurrence 模块无模周期内容、charpoly 实例化层缺位、C5 复述核对。与 roundtrip.md 具名缺口互证一致。
- **措辞红线在档**：「（含各固定孔位缺陷计数）」为动机层措辞非 kernel 主张（roundtrip.md:82-84 docstring 边界注记；evidence-pack §⑤1；report.md:79）；下游不得写「证明了铺法计数满足递推」。
- 本核验系文档层比对（roundtrip/evidence-pack/report/冻结件四处在档互证），不涉及 kernel 编译。

## 具名问题（交脚本调度，非闸门三阻断项）

1. **`report.md` 为过期阶段签发稿（22:10），与终态事实不符，需外交部按终态重签（闸门四人工签发前必须完成）**。被后续落盘推翻的表述：`report.md:4`「终态 0-sorry 编译验证未达成（final/ 产物不存在）」（今 final 在档且 strict exit 0）；`report.md:22` 分级=失败（今按宪条 4 实际最低级=完全证明）；`report.md:47-51` final/attempts/证据包/axioms 文件「不存在」（今分别在 23:20/23/27/22:48 落盘）；`report.md:78`「证据包本轮未产出…本声明为唯一在档记录」（今 evidence-pack.md §④ 在档，声明依据更完备）。该稿系闸门二受阻期的诚实阶段快照（低报不越级，不构成宪条 4 违规），但其后流水线已续走（budget.log 22:24 根因修复→23:16 闸门二通过→23:26 final 组装→kernel 复验），report 未随之更新。本岗权限限于 audit/ 目录，不代改。
2. 无其他问题。军政部 23:26 行自报的 r3 逐字节 proof body 溯源属 kernel 职权（宪条 1），本岗未复验也不需复验——strict exit=0 与公理审计已覆盖证明有效性。

## 复现命令清单

```bash
cd tasks/20260926-edgemid-pipeline
# ① 对称差
diff <(sed -n '12,17p' formalized/edgemid-p1-statement.lean) <(sed -n '15,20p' final/03-proof-complete.lean)
diff <(sed -n '14,22p' formalized/edgemid-p2-statement.lean) <(sed -n '44,52p' final/03-proof-complete.lean)
# ② 行尾与哈希
tr -cd '\r' < final/03-proof-complete.lean | wc -c
sha256sum final/03-proof-complete.lean
# ③ sorry / 结构 / 公理
grep -n -E 'sorry|admit' final/03-proof-complete.lean
grep -n -E '^(theorem|lemma|def|axiom|namespace|macro|notation|instance|structure|class|abbrev)\b' final/03-proof-complete.lean
tr -d '\r' < audit/final-axioms-p1.txt; tr -d '\r' < audit/final-axioms-p2.txt
# kernel 侧（脚本已实跑）：scripts/lean-verify 严格模式 + gate-batch --base final --axioms（strict exit=0）
```

**终审结论：verdict = pass；symdiffZero = true；grading = 完全证明；sha256 = `1124e6a53b6ec70fee5c964490fa4f407a23ab03b1557d3f7d214b0c20572c1d`。**
