/-
  AI4Math 流水线 · AI 生成 · 2026-09-30
  部门：02 形式化部（dept-formalize）
  任务线：mossad42-quad T1（pool-mossad42-01，3×n 铺砖「水平砖恰占一半」）
  来源卡：tasks/20260930-mossad42-quad/card.md（闸门一 2026-09-30；定义层经用户裁决 O-1）
  主张定稿：tasks/20260930-mossad42-quad/phase0/claims.md（§三 递推形态 / §四 可证目标 / §六 新增证据）
  数值出处：phase0/audit-closed.json（comp1，151 项）+ audit-holdout.txt（留出验证）
           + audit-final.txt（暴力枚举独立互证 n=8/16）+ audit-congruence.txt ④（k≤300 逐位）

  口径（按任务卡锁定 + 用户裁决 O-1）：
  - 本文件（含注释）只使用「闭式 / 纯序列」语言（ℕ → ℕ），命题只谈序列的取值、
    支撑与相邻项关系；组合对象语义一律不进本层。
  - **O-1（规则覆盖事件留档见 card.md）**：T1 的 def 取**闭式直接定义**（原卡面字面为
    「初值 + 整数系数递推」，经用户 2026-09-30 裁决改为闭式），理由见 card.md《四轨定义层》。

  【组合语义围栏】kernel 层不证「a1 n = 3×n 铺砖中水平砖恰占一半的铺法数」——
  该等同是组合语义桥，按 OEIS/文献背书 + 本机数值探针的**猜想层降级声明**处理
  （先例：mossad-pend / comb-07 同口径）。占位状态不改变命题真伪，仅约束下游措辞。

  【占位围栏】本串（含闭式书写 8^k·C(7k,k)）在 OEIS 上 5 条互异查询串全部零命中
  （通道经正对照验证可用：A001835/A005178/A000045/C(7k,k)=A004368/C(2k,k)=A000984 均命中）；
  但**零命中 ≠ 新颖**，文献通道本轮未验证（arXiv 超时），下游措辞禁止写「新发现」。

  proof body 全部 `sorry` 占位（形式化部只交付 statement；良定义门由宪兵 gate-batch 集中跑）。
-/

import Mathlib

/-- **T1 压缩子列 b1**：第 k 个 8 的倍数处的取值，闭式 `b1 k = 8^k · C(7k, k)`。 -/
def b1 (k : ℕ) : ℕ := 8 ^ k * Nat.choose (7 * k) k

/-- **T1 主序列 a1**：`n` 为 8 的倍数时取 `b1 (n / 8)`，否则为 0。 -/
def a1 (n : ℕ) : ℕ := if 8 ∣ n then b1 (n / 8) else 0

/-- **T1-A（闭式，定义展开引理）**：在 8 的倍数处，主序列取值即闭式 `b1`。

> **内容标注（闸门二自查，2026-09-30）**：本条是 `a1` 定义的直接展开
> （`simp [a1]` 即可闭合，见 `audit/probe-hints.lean` 的 H1）。闸门二的**裸探针**
> （不带 hint 的单 tactic）未能闭合，故按 SOP 03 判据**非退化**；但其数学内容仅为
> 「定义代入 + `Nat.mul_div_cancel_left`」，**不是本轨的主结果**。本轨主结果是
> T1-C（支撑刻画）与 T1-D（二项式比关系）。 -/
theorem a1_mul_eight (k : ℕ) : a1 (8 * k) = b1 k := by
  sorry

/-- **T1-B（零方向，定义展开引理）**：`n` 不是 8 的倍数时取值为 0。

> **内容标注**：同 T1-A——是 `a1` 定义的 `else` 分支展开（`simp [a1, h]`，见 H2），
> 裸探针未闭合故非退化，但内容低。 -/
theorem a1_eq_zero_of_not_dvd (n : ℕ) (h : ¬ 8 ∣ n) : a1 n = 0 := by
  sorry

/-- **T1-C（支撑刻画，主定理）**：`a1 n` 非零当且仅当 `8 ∣ n`。 -/
theorem a1_ne_zero_iff (n : ℕ) : a1 n ≠ 0 ↔ 8 ∣ n := by
  sorry

/-- **T1-D（一阶超几何关系 / 二项式恒等式）**：
`8 · ∏_{i=1..7}(7k+i) · b1 k = (k+1) · ∏_{i=1..6}(6k+i) · b1 (k+1)`。
等价于相邻项之比为有理函数 `b1(k+1)/b1(k) = 8·∏(7k+i) / [(k+1)·∏(6k+i)]`。 -/
theorem b1_ratio (k : ℕ) :
    8 * (Finset.prod (Finset.range 7) (fun i => (7 * k + i + 1))) * b1 k
      = (k + 1) * (Finset.prod (Finset.range 6) (fun i => (6 * k + i + 1))) * b1 (k + 1) := by
  sorry
