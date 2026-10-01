/-
  AI4Math 流水线 · AI 生成 · 2026-09-30
  部门：02 形式化部（dept-formalize）
  任务线：mossad42-quad T3（pool-mossad42-03，4×n 铺砖「水平砖恰占一半」）
  来源卡：tasks/20260930-mossad42-quad/card.md（闸门一 2026-09-30；定义层经用户裁决 O-2）
  主张定稿：tasks/20260930-mossad42-quad/phase0/claims.md（§六 9/11、§七 路 B）
  数值出处：phase0/audit-invariant-form.txt、audit-def-forms.txt、audit-statement-sim.txt

  口径（按任务卡锁定 + 用户裁决 O-2）：
  - 本层是**有限状态整数递推（DP 层）**：状态 = 列掩码（ℕ，取值 0..15），
    递推只涉及掩码与整数计数，**不出现铺砖 / 多米洛 / 计数对象等组合语义**。
    O-2 逐字留档见 card.md《规则覆盖事件留档》（被覆盖原文 + 用户指令原话 + 本批处置）。
  - 【组合语义围栏】kernel 层不证「a3 n = 4×n 铺砖中水平砖恰占一半的铺法数」——
    该等同是组合语义桥，按 OEIS/文献背书 + 本机数值探针的**猜想层降级声明**处理。

  支撑引理（本批 T3 的证明骨架，已数值穷举验证 n≤22）：
    (I1) D4 n mask h ≠ 0 ⇒ h ≡ m·n(n−1)/2 + pc mask (mod 2)，其中 m = 4
    (I2) D4 n mask h ≠ 0 ⇒ pc mask ≡ m·n (mod 2)
  两者互归纳（I1 的归纳步要 I2，I2 的归纳步用转移恒等式 m ≡ pc occ + j）。
  由 I2 代入 I1 得 **D4 n mask h ≠ 0 ⇒ Even h**（m = 4 时 m·n(n−1)/2 = 2n(n−1) 恒偶）。

  【占位围栏】本串在 OEIS 上 identity / 压缩子列 / even-idx / first-diff 全零命中；
  压缩子列**短串**（前 3/4 项 3,16,108 / 1,3,16,108）命中 A220379 与 A292752，
  第 5 项起零命中 ⇒ 属**短窗巧合**，不构成占位，也不得引用为相关文献。
  下游措辞不得写「新发现」。

  proof body 全部 `sorry` 占位（形式化部只交付 statement；良定义门由宪兵 gate-batch 集中跑）。
-/

import Mathlib

/-- **m=4 的列填充转移表**：`(occ, next, j)` 表示「入掩码 → 出掩码，该列伸出的水平砖数」。
穷举自 4 行的列填充递归（`phase0/audit-lean-steps.py` 生成，非手抄）。 -/
def steps4 : List (ℕ × ℕ × ℕ) :=
  [(0, 0, 0), (0, 12, 2), (0, 9, 2), (0, 3, 2), (0, 15, 4),
   (1, 8, 1), (1, 2, 1), (1, 14, 3),
   (2, 1, 1), (2, 13, 3),
   (3, 0, 0), (3, 12, 2),
   (4, 8, 1), (4, 11, 3),
   (5, 10, 2),
   (6, 9, 2),
   (7, 8, 1),
   (8, 4, 1), (8, 1, 1), (8, 7, 3),
   (9, 0, 0), (9, 6, 2),
   (10, 5, 2),
   (11, 4, 1),
   (12, 0, 0), (12, 3, 2),
   (13, 2, 1),
   (14, 1, 1),
   (15, 0, 0)]

/-- **掩码位数 `pc`（0..15 上的 popcount）**：显式列举（避免依赖额外位运算 API）。 -/
def pc : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | 3 => 2
  | 4 => 1
  | 5 => 2
  | 6 => 2
  | 7 => 3
  | 8 => 1
  | 9 => 2
  | 10 => 2
  | 11 => 3
  | 12 => 2
  | 13 => 3
  | 14 => 3
  | 15 => 4
  | _ => 0

/-- **T3 的有限状态整数递推 `D4`**：
`D4 n mask h` = 填满前 n 列、出掩码 = mask、累计水平砖数 = h 的走法数。

注意 `j ≤ h` 保护不可省：ℕ 减法截断会污染计数（Phase 0 实测偏离，见
`phase0/audit-invariant-form.txt` 结论节）。 -/
def D4 : ℕ → ℕ → ℕ → ℕ
  | 0, mask, h => if mask = 0 ∧ h = 0 then 1 else 0
  | n + 1, mask, h =>
      (steps4.filter (fun t => t.2.1 = mask ∧ t.2.2 ≤ h)).map
        (fun t => D4 n t.1 (h - t.2.2)) |>.sum

/-- **T3 主序列 a3**：4×n 的「恰半」（累计水平砖 = n）走法数 = `D4 n 0 n`。 -/
def a3 (n : ℕ) : ℕ := D4 n 0 n

/-- **T3-支撑引理（I2）**：可达状态的掩码位数为偶（`pc mask ≡ 4·n ≡ 0 (mod 2)`）。 -/
theorem D4_pc_even (n mask h : ℕ) (hh : D4 n mask h ≠ 0) : 2 ∣ pc mask := by
  sorry

/-- **T3-支撑引理（I1）**：可达状态的累计水平砖数恒为偶。 -/
theorem D4_h_even (n mask h : ℕ) (hh : D4 n mask h ≠ 0) : 2 ∣ h := by
  sorry

/-- **T3-Z（零方向）**：`n` 为奇数时主序列取值为 0。 -/
theorem a3_odd_eq_zero (n : ℕ) (hn : n % 2 = 1) : a3 n = 0 := by
  sorry

/-- **T3-N（非零方向）**：`n` 为偶数时主序列取值非零（4×2 块拼接构造）。 -/
theorem a3_even_ne_zero (k : ℕ) : a3 (2 * k) ≠ 0 := by
  sorry

/-- **T3-I（支撑刻画，主定理）**：`a3 n` 非零当且仅当 `n` 为偶数。 -/
theorem a3_ne_zero_iff (n : ℕ) : a3 n ≠ 0 ↔ n % 2 = 0 := by
  sorry
