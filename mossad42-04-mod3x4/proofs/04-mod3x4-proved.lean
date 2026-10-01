/-
  AI4Math 流水线 · AI 生成 · 2026-09-30
  部门：02 形式化部（dept-formalize）
  任务线：mossad42-quad T4（pool-mossad42-04，4×n 铺砖「水平砖数 ≡ 0 (mod 3)」）
  来源卡：tasks/20260930-mossad42-quad/card.md（闸门一 2026-09-30）
  主张定稿：tasks/20260930-mossad42-quad/phase0/claims.md（§三、§四）
  数值出处：phase0/audit-def-forms.txt ②、claims-data.txt ③、final-phase0.txt

  口径（按任务卡锁定）：
  - 本层只使用「初值 + 整数系数递推定义的纯序列」语言（ℕ → ℤ），
    命题只谈序列的递推与模余数样式；组合对象语义一律不进本层。
  - 【命题须写明按水平多米洛计数取模】模 3 对象是**水平砖数 h 的同余类**下的铺法数之和，
    **不是**「铺法数 mod 3」；本层以「递推定义的序列 a4」承载，组合语义按下栏围栏降级。
  - 【卡面另注】本串**无交替零项**（4×n 奇 n 亦有铺法），与 3×n 口径的稀疏形态不同，
    故本文件**不套用** 3×n 的下标约定（无「奇位全 0」类命题）。
  - 【组合语义围栏】kernel 层不证「a4 n = 4×n 铺砖中水平砖数 ≡ 0 (mod 3) 的铺法数」。

  【占位围栏】本串 identity / even-idx / odd-idx / first-diff / partial-sums 全零命中
  （通道经正对照验证可用）；下游措辞不得写「新发现」。

  proof body 已按军政部攻证补全（形式化部只交付 statement；良定义门由宪兵 gate-batch 集中跑）。
-/

import Mathlib

/-- **T4 主序列 a4（order-12 递推）**。
初值 a4(0..11) = 1, 1, 1, 1, 10, 37, 110, 269, 701, 2000, 6020, 17495；
递推 a4(n) = 3·a4(n−1) − 3·a4(n−2) + a4(n−3) + 18·a4(n−4) − 9·a4(n−5) + 20·a4(n−6)
              + 15·a4(n−7) − 18·a4(n−8) + a4(n−9) + 9·a4(n−10) − a4(n−12)。 -/
def a4 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 1
  | 3 => 1
  | 4 => 10
  | 5 => 37
  | 6 => 110
  | 7 => 269
  | 8 => 701
  | 9 => 2000
  | 10 => 6020
  | 11 => 17495
  | n + 12 =>
      3 * a4 (n + 11) - 3 * a4 (n + 10) + a4 (n + 9) + 18 * a4 (n + 8)
        - 9 * a4 (n + 7) + 20 * a4 (n + 6) + 15 * a4 (n + 5) - 18 * a4 (n + 4)
        + a4 (n + 3) + 9 * a4 (n + 2) - a4 n

/-- **模 2 样式 pat2_15**（15 留数类 ↦ 余数）：
1,1,1,1,0,1,0,1,1,0,0,1,0,0,0。 -/
def pat2_15 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 1
  | 3 => 1
  | 4 => 0
  | 5 => 1
  | 6 => 0
  | 7 => 1
  | 8 => 1
  | 9 => 0
  | 10 => 0
  | 11 => 1
  | 12 => 0
  | 13 => 0
  | _ => 0

/-- **模 3 样式 pat3_30**（30 留数类 ↦ 余数）。 -/
def pat3_30 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 1
  | 3 => 1
  | 4 => 1
  | 5 => 1
  | 6 => 2
  | 7 => 2
  | 8 => 2
  | 9 => 2
  | 10 => 2
  | 11 => 2
  | 12 => 0
  | 13 => 0
  | 14 => 0
  | 15 => 2
  | 16 => 2
  | 17 => 2
  | 18 => 2
  | 19 => 2
  | 20 => 2
  | 21 => 1
  | 22 => 1
  | 23 => 1
  | 24 => 1
  | 25 => 1
  | 26 => 1
  | 27 => 0
  | 28 => 0
  | _ => 0

/-! ## 段落 0：共用的算术工具

关键取向：分类**不作用在 `A` 上**。`A % 15 = j` 根本不决定 `A % 2`（15 是奇数，
`A` 与 `A + 15` 同留数类而异奇偶，`A = 17, j = 2` 即反例）。
分类只作用在**样式组合**（12 项 `pat2_15` 的线性组合）上——
由递推式把 `a4 n` 的 12 项线性组合化为「12 项样式组合 + 2×整数」，
再对样式组合做 15 类机械计算。下面两条工具把「同余 ⟺ 样式项 + 倍数×商」这一形态焊死。 -/

/-- 段落 0 工具 ①（模 2 款）：`2 * (x / 2) + x % 2 = x`，即 `x ≡ x % 2 (mod 2)`。 -/
private theorem int_two_mul_ediv_add_emod (x : ℤ) : 2 * (x / 2) + x % 2 = x := by
  have h := Int.emod_add_mul_ediv x 2
  omega

/-- 段落 0 工具 ②（模 3 款）：`3 * (x / 3) + x % 3 = x`，即 `x ≡ x % 3 (mod 3)`。 -/
private theorem int_three_mul_ediv_add_emod (x : ℤ) : 3 * (x / 3) + x % 3 = x := by
  have h := Int.emod_add_mul_ediv x 3
  omega

/-! ## 段落 1：模 2 的 15 个留数类机械计算（T4-A 的收口引理）

`j < 15` 前提不可省——`interval_cases` 靠它找上界。分类前提写成 `j : ℕ` 上界形式，
而不是「`A % 15 = j`」形态：后者是假命题。 -/

/-- **段落 1 分类引理**：12 项样式组合 mod 2 = `pat2_15 ((j + 12) % 15)`，`j < 15`。 -/
private theorem pat2_15_step (j : ℕ) (hj : j < 15) :
    (3 * pat2_15 ((j + 11) % 15) - 3 * pat2_15 ((j + 10) % 15) + pat2_15 ((j + 9) % 15)
      + 18 * pat2_15 ((j + 8) % 15) - 9 * pat2_15 ((j + 7) % 15) + 20 * pat2_15 ((j + 6) % 15)
      + 15 * pat2_15 ((j + 5) % 15) - 18 * pat2_15 ((j + 4) % 15) + pat2_15 ((j + 3) % 15)
      + 9 * pat2_15 ((j + 2) % 15) - pat2_15 (j % 15)) % 2 = pat2_15 ((j + 12) % 15) := by
  interval_cases j <;> decide

/-! ## 段落 2：T4-A 的归纳（`a4 n % 2` 只由 `n % 15` 决定）

强归纳。`n < 12` 走初值（`decide`）；`n ≥ 12` 写 `n = m + 12`，先由归纳假设得 12 条
`a4 (m+i) = pat2_15 ((m+i) % 15) + 2 * (a4 (m+i) / 2)`，代入递推式后把 `(m+i) % 15`
归一为 `(m % 15 + i) % 15`，再用 `ring` 把整条组合式拆成「样式组合 + 2×整数」，
最后 `Int.add_emod` 丢掉偶倍项、`simpa [Nat.mod_mod]` 对上 `pat2_15_step` 的形态。 -/

/-- **T4-A 归纳辅助**：`a4` 的 mod 2 余数只由 `n % 15` 决定。 -/
private theorem a4_aux15 : ∀ n : ℕ, a4 n % 2 = pat2_15 (n % 15) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.lt_or_ge n 12 with hn | hn
    · interval_cases n <;> decide
    · obtain ⟨m, rfl⟩ : ∃ m, n = m + 12 := ⟨n - 12, by omega⟩
      -- 递推式展开（`a4` 的 `n + 12` 分支）
      have hrec : a4 (m + 12) = 3 * a4 (m + 11) - 3 * a4 (m + 10) + a4 (m + 9)
          + 18 * a4 (m + 8) - 9 * a4 (m + 7) + 20 * a4 (m + 6) + 15 * a4 (m + 5)
          - 18 * a4 (m + 4) + a4 (m + 3) + 9 * a4 (m + 2) - a4 m := by
        rw [a4]
      -- 12 条「样式项 + 2×商」（归纳假设 + `Int.emod_add_mul_ediv`）
      have h0 : a4 m = pat2_15 (m % 15) + 2 * (a4 m / 2) := by
        have h := ih m (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 m)
        omega
      have h2 : a4 (m + 2) = pat2_15 ((m + 2) % 15) + 2 * (a4 (m + 2) / 2) := by
        have h := ih (m + 2) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 2))
        omega
      have h3 : a4 (m + 3) = pat2_15 ((m + 3) % 15) + 2 * (a4 (m + 3) / 2) := by
        have h := ih (m + 3) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 3))
        omega
      have h4 : a4 (m + 4) = pat2_15 ((m + 4) % 15) + 2 * (a4 (m + 4) / 2) := by
        have h := ih (m + 4) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 4))
        omega
      have h5 : a4 (m + 5) = pat2_15 ((m + 5) % 15) + 2 * (a4 (m + 5) / 2) := by
        have h := ih (m + 5) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 5))
        omega
      have h6 : a4 (m + 6) = pat2_15 ((m + 6) % 15) + 2 * (a4 (m + 6) / 2) := by
        have h := ih (m + 6) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 6))
        omega
      have h7 : a4 (m + 7) = pat2_15 ((m + 7) % 15) + 2 * (a4 (m + 7) / 2) := by
        have h := ih (m + 7) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 7))
        omega
      have h8 : a4 (m + 8) = pat2_15 ((m + 8) % 15) + 2 * (a4 (m + 8) / 2) := by
        have h := ih (m + 8) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 8))
        omega
      have h9 : a4 (m + 9) = pat2_15 ((m + 9) % 15) + 2 * (a4 (m + 9) / 2) := by
        have h := ih (m + 9) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 9))
        omega
      have h10 : a4 (m + 10) = pat2_15 ((m + 10) % 15) + 2 * (a4 (m + 10) / 2) := by
        have h := ih (m + 10) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 10))
        omega
      have h11 : a4 (m + 11) = pat2_15 ((m + 11) % 15) + 2 * (a4 (m + 11) / 2) := by
        have h := ih (m + 11) (by omega)
        have h2 := int_two_mul_ediv_add_emod (a4 (m + 11))
        omega
      -- ① 代入 12 条；② 把残留的 `(m+i) % 15` 归一（`i = 0` 项不需要）
      rw [hrec, h0, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11]
      rw [show (m + 11) % 15 = (m % 15 + 11) % 15 by omega,
          show (m + 10) % 15 = (m % 15 + 10) % 15 by omega,
          show (m + 9) % 15 = (m % 15 + 9) % 15 by omega,
          show (m + 8) % 15 = (m % 15 + 8) % 15 by omega,
          show (m + 7) % 15 = (m % 15 + 7) % 15 by omega,
          show (m + 6) % 15 = (m % 15 + 6) % 15 by omega,
          show (m + 5) % 15 = (m % 15 + 5) % 15 by omega,
          show (m + 4) % 15 = (m % 15 + 4) % 15 by omega,
          show (m + 3) % 15 = (m % 15 + 3) % 15 by omega,
          show (m + 2) % 15 = (m % 15 + 2) % 15 by omega]
      -- ③ 组合式 = 样式组合 + 2×整数（纯 `ring`）
      have key : (3 * (pat2_15 ((m % 15 + 11) % 15) + 2 * (a4 (m + 11) / 2))
          - 3 * (pat2_15 ((m % 15 + 10) % 15) + 2 * (a4 (m + 10) / 2))
          + (pat2_15 ((m % 15 + 9) % 15) + 2 * (a4 (m + 9) / 2))
          + 18 * (pat2_15 ((m % 15 + 8) % 15) + 2 * (a4 (m + 8) / 2))
          - 9 * (pat2_15 ((m % 15 + 7) % 15) + 2 * (a4 (m + 7) / 2))
          + 20 * (pat2_15 ((m % 15 + 6) % 15) + 2 * (a4 (m + 6) / 2))
          + 15 * (pat2_15 ((m % 15 + 5) % 15) + 2 * (a4 (m + 5) / 2))
          - 18 * (pat2_15 ((m % 15 + 4) % 15) + 2 * (a4 (m + 4) / 2))
          + (pat2_15 ((m % 15 + 3) % 15) + 2 * (a4 (m + 3) / 2))
          + 9 * (pat2_15 ((m % 15 + 2) % 15) + 2 * (a4 (m + 2) / 2))
          - (pat2_15 (m % 15) + 2 * (a4 m / 2)) : ℤ)
          = (3 * pat2_15 ((m % 15 + 11) % 15) - 3 * pat2_15 ((m % 15 + 10) % 15)
            + pat2_15 ((m % 15 + 9) % 15) + 18 * pat2_15 ((m % 15 + 8) % 15)
            - 9 * pat2_15 ((m % 15 + 7) % 15) + 20 * pat2_15 ((m % 15 + 6) % 15)
            + 15 * pat2_15 ((m % 15 + 5) % 15) - 18 * pat2_15 ((m % 15 + 4) % 15)
            + pat2_15 ((m % 15 + 3) % 15) + 9 * pat2_15 ((m % 15 + 2) % 15)
            - pat2_15 (m % 15))
          + 2 * (3 * (a4 (m + 11) / 2) - 3 * (a4 (m + 10) / 2) + (a4 (m + 9) / 2)
            + 18 * (a4 (m + 8) / 2) - 9 * (a4 (m + 7) / 2) + 20 * (a4 (m + 6) / 2)
            + 15 * (a4 (m + 5) / 2) - 18 * (a4 (m + 4) / 2) + (a4 (m + 3) / 2)
            + 9 * (a4 (m + 2) / 2) - (a4 m / 2)) := by
        ring
      rw [key]
      rw [Int.add_emod]
      rw [show (2 * (3 * (a4 (m + 11) / 2) - 3 * (a4 (m + 10) / 2) + (a4 (m + 9) / 2)
            + 18 * (a4 (m + 8) / 2) - 9 * (a4 (m + 7) / 2) + 20 * (a4 (m + 6) / 2)
            + 15 * (a4 (m + 5) / 2) - 18 * (a4 (m + 4) / 2) + (a4 (m + 3) / 2)
            + 9 * (a4 (m + 2) / 2) - (a4 m / 2))) % 2 = 0 by omega]
      rw [Int.add_zero]
      -- ④ 形态差（`m % 15 % 15`、外层 `% 2 % 2`）用 `simpa`，不能用 `exact`
      simpa [Nat.mod_mod] using pat2_15_step (m % 15) (Nat.mod_lt _ (by norm_num))

/-- **T4-A（模 2 周期 15 样式）**：`a4 n` 的 mod 2 余数仅依赖 `n % 15`，样式为 `pat2_15`。 -/
theorem a4_mod2_period15 (n r : ℕ) (hr : n % 15 = r) : a4 n % 2 = pat2_15 r := by
  rw [← hr]
  exact a4_aux15 n

/-! ## 段落 3：模 3 的 30 个留数类机械计算（T4-B 的收口引理）

与段落 1 完全同型，只是周期 30、模 3。`j < 30` 前提同样不可省。 -/

/-- **段落 3 分类引理**：12 项样式组合 mod 3 = `pat3_30 ((j + 12) % 30)`，`j < 30`。 -/
private theorem pat3_30_step (j : ℕ) (hj : j < 30) :
    (3 * pat3_30 ((j + 11) % 30) - 3 * pat3_30 ((j + 10) % 30) + pat3_30 ((j + 9) % 30)
      + 18 * pat3_30 ((j + 8) % 30) - 9 * pat3_30 ((j + 7) % 30) + 20 * pat3_30 ((j + 6) % 30)
      + 15 * pat3_30 ((j + 5) % 30) - 18 * pat3_30 ((j + 4) % 30) + pat3_30 ((j + 3) % 30)
      + 9 * pat3_30 ((j + 2) % 30) - pat3_30 (j % 30)) % 3 = pat3_30 ((j + 12) % 30) := by
  interval_cases j <;> decide

/-! ## 段落 4：T4-B 的归纳（`a4 n % 3` 只由 `n % 30` 决定）

与段落 2 同型，差别只有三点：周期 30、模 3、以及 12 条 `a4 (m+i)` 分解成
`pat3_30 ((m+i) % 30) + 3 * (a4 (m+i) / 3)`（丢的是 `3 * X` 而不是 `2 * X`）。 -/

/-- **T4-B 归纳辅助**：`a4` 的 mod 3 余数只由 `n % 30` 决定。 -/
private theorem a4_aux30 : ∀ n : ℕ, a4 n % 3 = pat3_30 (n % 30) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases Nat.lt_or_ge n 12 with hn | hn
    · interval_cases n <;> decide
    · obtain ⟨m, rfl⟩ : ∃ m, n = m + 12 := ⟨n - 12, by omega⟩
      have hrec : a4 (m + 12) = 3 * a4 (m + 11) - 3 * a4 (m + 10) + a4 (m + 9)
          + 18 * a4 (m + 8) - 9 * a4 (m + 7) + 20 * a4 (m + 6) + 15 * a4 (m + 5)
          - 18 * a4 (m + 4) + a4 (m + 3) + 9 * a4 (m + 2) - a4 m := by
        rw [a4]
      have hk0 : a4 m = pat3_30 (m % 30) + 3 * (a4 m / 3) := by
        have h := ih m (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 m)
        omega
      have hk2 : a4 (m + 2) = pat3_30 ((m + 2) % 30) + 3 * (a4 (m + 2) / 3) := by
        have h := ih (m + 2) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 2))
        omega
      have hk3 : a4 (m + 3) = pat3_30 ((m + 3) % 30) + 3 * (a4 (m + 3) / 3) := by
        have h := ih (m + 3) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 3))
        omega
      have hk4 : a4 (m + 4) = pat3_30 ((m + 4) % 30) + 3 * (a4 (m + 4) / 3) := by
        have h := ih (m + 4) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 4))
        omega
      have hk5 : a4 (m + 5) = pat3_30 ((m + 5) % 30) + 3 * (a4 (m + 5) / 3) := by
        have h := ih (m + 5) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 5))
        omega
      have hk6 : a4 (m + 6) = pat3_30 ((m + 6) % 30) + 3 * (a4 (m + 6) / 3) := by
        have h := ih (m + 6) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 6))
        omega
      have hk7 : a4 (m + 7) = pat3_30 ((m + 7) % 30) + 3 * (a4 (m + 7) / 3) := by
        have h := ih (m + 7) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 7))
        omega
      have hk8 : a4 (m + 8) = pat3_30 ((m + 8) % 30) + 3 * (a4 (m + 8) / 3) := by
        have h := ih (m + 8) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 8))
        omega
      have hk9 : a4 (m + 9) = pat3_30 ((m + 9) % 30) + 3 * (a4 (m + 9) / 3) := by
        have h := ih (m + 9) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 9))
        omega
      have hk10 : a4 (m + 10) = pat3_30 ((m + 10) % 30) + 3 * (a4 (m + 10) / 3) := by
        have h := ih (m + 10) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 10))
        omega
      have hk11 : a4 (m + 11) = pat3_30 ((m + 11) % 30) + 3 * (a4 (m + 11) / 3) := by
        have h := ih (m + 11) (by omega)
        have h2 := int_three_mul_ediv_add_emod (a4 (m + 11))
        omega
      rw [hrec, hk0, hk2, hk3, hk4, hk5, hk6, hk7, hk8, hk9, hk10, hk11]
      rw [show (m + 11) % 30 = (m % 30 + 11) % 30 by omega,
          show (m + 10) % 30 = (m % 30 + 10) % 30 by omega,
          show (m + 9) % 30 = (m % 30 + 9) % 30 by omega,
          show (m + 8) % 30 = (m % 30 + 8) % 30 by omega,
          show (m + 7) % 30 = (m % 30 + 7) % 30 by omega,
          show (m + 6) % 30 = (m % 30 + 6) % 30 by omega,
          show (m + 5) % 30 = (m % 30 + 5) % 30 by omega,
          show (m + 4) % 30 = (m % 30 + 4) % 30 by omega,
          show (m + 3) % 30 = (m % 30 + 3) % 30 by omega,
          show (m + 2) % 30 = (m % 30 + 2) % 30 by omega]
      have key : (3 * (pat3_30 ((m % 30 + 11) % 30) + 3 * (a4 (m + 11) / 3))
          - 3 * (pat3_30 ((m % 30 + 10) % 30) + 3 * (a4 (m + 10) / 3))
          + (pat3_30 ((m % 30 + 9) % 30) + 3 * (a4 (m + 9) / 3))
          + 18 * (pat3_30 ((m % 30 + 8) % 30) + 3 * (a4 (m + 8) / 3))
          - 9 * (pat3_30 ((m % 30 + 7) % 30) + 3 * (a4 (m + 7) / 3))
          + 20 * (pat3_30 ((m % 30 + 6) % 30) + 3 * (a4 (m + 6) / 3))
          + 15 * (pat3_30 ((m % 30 + 5) % 30) + 3 * (a4 (m + 5) / 3))
          - 18 * (pat3_30 ((m % 30 + 4) % 30) + 3 * (a4 (m + 4) / 3))
          + (pat3_30 ((m % 30 + 3) % 30) + 3 * (a4 (m + 3) / 3))
          + 9 * (pat3_30 ((m % 30 + 2) % 30) + 3 * (a4 (m + 2) / 3))
          - (pat3_30 (m % 30) + 3 * (a4 m / 3)) : ℤ)
          = (3 * pat3_30 ((m % 30 + 11) % 30) - 3 * pat3_30 ((m % 30 + 10) % 30)
            + pat3_30 ((m % 30 + 9) % 30) + 18 * pat3_30 ((m % 30 + 8) % 30)
            - 9 * pat3_30 ((m % 30 + 7) % 30) + 20 * pat3_30 ((m % 30 + 6) % 30)
            + 15 * pat3_30 ((m % 30 + 5) % 30) - 18 * pat3_30 ((m % 30 + 4) % 30)
            + pat3_30 ((m % 30 + 3) % 30) + 9 * pat3_30 ((m % 30 + 2) % 30)
            - pat3_30 (m % 30))
          + 3 * (3 * (a4 (m + 11) / 3) - 3 * (a4 (m + 10) / 3) + (a4 (m + 9) / 3)
            + 18 * (a4 (m + 8) / 3) - 9 * (a4 (m + 7) / 3) + 20 * (a4 (m + 6) / 3)
            + 15 * (a4 (m + 5) / 3) - 18 * (a4 (m + 4) / 3) + (a4 (m + 3) / 3)
            + 9 * (a4 (m + 2) / 3) - (a4 m / 3)) := by
        ring
      rw [key]
      rw [Int.add_emod]
      rw [show (3 * (3 * (a4 (m + 11) / 3) - 3 * (a4 (m + 10) / 3) + (a4 (m + 9) / 3)
            + 18 * (a4 (m + 8) / 3) - 9 * (a4 (m + 7) / 3) + 20 * (a4 (m + 6) / 3)
            + 15 * (a4 (m + 5) / 3) - 18 * (a4 (m + 4) / 3) + (a4 (m + 3) / 3)
            + 9 * (a4 (m + 2) / 3) - (a4 m / 3))) % 3 = 0 by omega]
      rw [Int.add_zero]
      simpa [Nat.mod_mod] using pat3_30_step (m % 30) (Nat.mod_lt _ (by norm_num))

/-- **T4-B（模 3 周期 30 样式）**：`a4 n` 的 mod 3 余数仅依赖 `n % 30`，样式为 `pat3_30`。 -/
theorem a4_mod3_period30 (n r : ℕ) (hr : n % 30 = r) : a4 n % 3 = pat3_30 r := by
  rw [← hr]
  exact a4_aux30 n
