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

  形式化部只交付 statement（proof body 原为占位）；良定义门由宪兵 gate-batch 集中跑。
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

/-! ## 证明辅助（军政部 T3 添加，不改动上方冻结 statement） -/

/-- 列表 `map f` 之和非零 ⇒ 某个被映射元素的值非零。 -/
private lemma map_sum_ne_zero_of_mem {α : Type*} (f : α → ℕ) (l : List α) {a : α}
    (ha : a ∈ l) (hfa : f a ≠ 0) : (l.map f).sum ≠ 0 := by
  intro h0
  exact hfa (List.sum_eq_zero_iff.mp h0 (f a) (List.mem_map.mpr ⟨a, ha, rfl⟩))

/-- `map f` 之和非零 ⇒ 存在一项其值非零。 -/
private lemma exists_of_sum_ne_zero {α : Type*} (f : α → ℕ) (l : List α)
    (h : (l.map f).sum ≠ 0) : ∃ a ∈ l, f a ≠ 0 := by
  by_contra hc
  simp only [not_exists, not_and, not_not] at hc
  exact h (List.sum_eq_zero_iff.mpr fun x hx => by
    obtain ⟨a, ha, rfl⟩ := List.mem_map.mp hx
    exact hc a ha)

/-- `steps4` 的转移恒等式（`decide` 穷举 29 条全验）：列格数偶 + 出掩码位数 = 伸出砖数。 -/
private lemma steps4_guard {occ mask j : ℕ} (ht : (occ, mask, j) ∈ steps4) :
    2 ∣ (pc occ + j) ∧ pc mask = j := by
  have hall : steps4.all
      (fun t => decide (2 ∣ (pc t.1 + t.2.2) ∧ pc t.2.1 = t.2.2)) = true := by decide
  exact of_decide_eq_true (List.all_eq_true.mp hall (occ, mask, j) ht)

/-- **I1 ∧ I2（互归纳的合并不变量）**：可达状态的累计水平砖数与掩码位数均为偶。 -/
private lemma D4_inv (n : ℕ) :
    ∀ mask h : ℕ, D4 n mask h ≠ 0 → 2 ∣ h ∧ 2 ∣ pc mask := by
  induction n with
  | zero =>
    intro mask h hh
    by_cases hc : mask = 0 ∧ h = 0
    · obtain ⟨rfl, rfl⟩ := hc; decide
    · exact absurd (by simp [D4, hc]) hh
  | succ n ih =>
    intro mask h hh
    have hh' : ((steps4.filter (fun t => t.2.1 = mask ∧ t.2.2 ≤ h)).map
        (fun t => D4 n t.1 (h - t.2.2))).sum ≠ 0 := hh
    obtain ⟨t, htmem, htne⟩ := exists_of_sum_ne_zero (fun t => D4 n t.1 (h - t.2.2))
      (steps4.filter (fun t => t.2.1 = mask ∧ t.2.2 ≤ h)) hh'
    obtain ⟨htsteps, htp⟩ := List.mem_filter.mp htmem
    obtain ⟨hocc, hjle⟩ := of_decide_eq_true htp
    obtain ⟨ihh, ihpc⟩ := ih t.1 (h - t.2.2) htne
    obtain ⟨hg1, hg2⟩ := steps4_guard htsteps
    have hdj : 2 ∣ t.2.2 := by
      have h := Nat.dvd_sub hg1 ihpc
      rwa [Nat.add_sub_cancel_left] at h
    have hdh : 2 ∣ h := by
      have h := Nat.dvd_add ihh hdj
      rwa [Nat.sub_add_cancel hjle] at h
    exact ⟨hdh, by rw [← hocc, hg2]; exact hdj⟩

/-- **T3-N 的构造步**：两步环 `(0,12,2)` → `(12,0,0)` 把非零走法升 2 列、加 2 砖。 -/
private lemma D4_step2 (n h : ℕ) (hh : D4 n 0 h ≠ 0) : D4 (n + 2) 0 (h + 2) ≠ 0 := by
  have h1 : D4 (n + 1) 12 (h + 2) ≠ 0 := by
    refine map_sum_ne_zero_of_mem (f := fun t => D4 n t.1 (h + 2 - t.2.2))
      (l := steps4.filter (fun t => t.2.1 = 12 ∧ t.2.2 ≤ h + 2)) (a := (0, 12, 2)) ?_ ?_
    · apply List.mem_filter.mpr
      exact ⟨by decide, by simp⟩
    · simpa using hh
  refine map_sum_ne_zero_of_mem (f := fun t => D4 (n + 1) t.1 (h + 2 - t.2.2))
    (l := steps4.filter (fun t => t.2.1 = 0 ∧ t.2.2 ≤ h + 2)) (a := (12, 0, 0)) ?_ ?_
  · apply List.mem_filter.mpr
    exact ⟨by decide, by simp⟩
  · simpa using h1

/-- **T3-支撑引理（I2）**：可达状态的掩码位数为偶（`pc mask ≡ 4·n ≡ 0 (mod 2)`）。 -/
theorem D4_pc_even (n mask h : ℕ) (hh : D4 n mask h ≠ 0) : 2 ∣ pc mask :=
  (D4_inv n mask h hh).2

/-- **T3-支撑引理（I1）**：可达状态的累计水平砖数恒为偶。 -/
theorem D4_h_even (n mask h : ℕ) (hh : D4 n mask h ≠ 0) : 2 ∣ h :=
  (D4_inv n mask h hh).1

/-- **T3-Z（零方向）**：`n` 为奇数时主序列取值为 0。 -/
theorem a3_odd_eq_zero (n : ℕ) (hn : n % 2 = 1) : a3 n = 0 := by
  by_contra hc
  have h2 : 2 ∣ n := D4_h_even n 0 n (by simpa [a3] using hc)
  rw [Nat.dvd_iff_mod_eq_zero] at h2
  omega

/-- **T3-N（非零方向）**：`n` 为偶数时主序列取值非零（4×2 块拼接构造）。 -/
theorem a3_even_ne_zero (k : ℕ) : a3 (2 * k) ≠ 0 := by
  induction k with
  | zero => decide
  | succ k ih =>
    exact D4_step2 (2 * k) (2 * k) (by simpa [a3] using ih)

/-- **T3-I（支撑刻画，主定理）**：`a3 n` 非零当且仅当 `n` 为偶数。 -/
theorem a3_ne_zero_iff (n : ℕ) : a3 n ≠ 0 ↔ n % 2 = 0 := by
  constructor
  · intro h
    by_contra hodd
    have : n % 2 = 1 := by omega
    exact h (a3_odd_eq_zero n this)
  · intro h
    have hn : n = 2 * (n / 2) := by omega
    rw [hn]
    exact a3_even_ne_zero (n / 2)
