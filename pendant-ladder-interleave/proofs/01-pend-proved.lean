/-
  AI4Math 流水线 · AI 生成 · 2026-09-27（终稿生成 2026-09-28）
  部门：02 形式化部（dept-formalize）statement 冻结 + 04 军政部（dept-prove）proof body 终稿
  任务线：mossad-pend（pool-mossad-01，pool Part A；三线兄弟线之 pend 线）
  来源卡：tasks/20260927-mossad-pend/card.md（闸门一 2026-09-27 立项）
  主张定稿：tasks/20260927-mossad-pend/phase0/claims.md（T1 主攻 + T2/T3 伴随；T4 备选不进本批）
  初值数据出处：phase0/counts.txt（双算法互证 PASS）+ claims.md 主代理复核订正节
    （order-8 递推、两四阶子列递推、T1 交织恒等式、T2 样式在 n≤30 数据窗口全项 PASS）；
    本文件五条 def 的初值/系数/样式逐字照抄 claims.md Lean 草稿（T3 取订正后形态，
    格式上仅把每行多分枝改为每行一分枝，语义不变）。

  口径（按任务卡锁定）：本文件（含注释）只使用「初值 + 整数系数递推定义的纯序列」
  语言（ℕ → ℤ），命题只谈序列的交织/模余数性质；组合对象语义一律不进本层。
  索引口径（0-based Lean ↔ 1-based 计数）：
  apend n = a(n+1)；opend k = a(2k+1)（奇位侧）；epend k = a(2k+2)（偶位侧）。

  【占位围栏】opend 的数值 = OEIS A386889（Dresden & Demirkol，2025-09-04 挂名，
  已占位，数值核到 k=15）；本线新颖性主张严格限定「完整 order-8 递推 +
  偶数子列（epend 侧）」；禁止任何「新序列」泛写。statement 层仅为纯序列命题，
  占位状态不改变命题真伪，仅约束下游报告/论文措辞。

  proof body 由军政部完成；良定义门由宪兵 gate-batch 集中跑。
  （来源探针：T1=attempts/r6-t1.lean、T2=attempts/r5-t2.lean、
  T3o=attempts/r4-t3o.lean、T3e=attempts/r3-step-t3e.lean，均 EXIT=0 通过。）
-/

import Mathlib

/-- **序列 apend（主列，order-8 仅偶滞后递推）**。
初值 a(0..7) = 3, 10, 46, 141, 660, 2015, 9440, 28814；
递推 a(n+8) = 16·a(n+6) − 25·a(n+4) + 10·a(n+2) − a(n)（n ≥ 0）。 -/
def apend : ℕ → ℤ
  | 0 => 3
  | 1 => 10
  | 2 => 46
  | 3 => 141
  | 4 => 660
  | 5 => 2015
  | 6 => 9440
  | 7 => 28814
  | n + 8 =>
      16 * apend (n + 6) - 25 * apend (n + 4) + 10 * apend (n + 2) - apend n

/-- **序列 opend（奇位侧子列，四阶递推）**。
初值 o(0..3) = 3, 46, 660, 9440（= apend 在下标 0,2,4,6 处之值；
数值与 OEIS A386889 一致——该侧已占位，见文件头围栏）；
递推 o(k+4) = 16·o(k+3) − 25·o(k+2) + 10·o(k+1) − o(k)（k ≥ 0）。 -/
def opend : ℕ → ℤ
  | 0 => 3
  | 1 => 46
  | 2 => 660
  | 3 => 9440
  | k + 4 =>
      16 * opend (k + 3) - 25 * opend (k + 2) + 10 * opend (k + 1) - opend k

/-- **序列 epend（偶位侧子列，四阶递推）**。
初值 e(0..3) = 10, 141, 2015, 28814（= apend 在下标 1,3,5,7 处之值）；
递推 e(k+4) = 16·e(k+3) − 25·e(k+2) + 10·e(k+1) − e(k)（k ≥ 0）。 -/
def epend : ℕ → ℤ
  | 0 => 10
  | 1 => 141
  | 2 => 2015
  | 3 => 28814
  | k + 4 =>
      16 * epend (k + 3) - 25 * epend (k + 2) + 10 * epend (k + 1) - epend k

/-- **T1（主攻）**：主列 order-8 递推 = 两条同系数四阶子列的交织——
对一切 k，apend (2k) = opend k 且 apend (2k+1) = epend k。 -/
theorem apend_interleave (k : ℕ) :
    apend (2 * k) = opend k ∧ apend (2 * k + 1) = epend k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 4
    · interval_cases k <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, k = j + 4 := ⟨k - 4, by omega⟩
      constructor
      · have e8 : 2 * (j + 4) = (2 * j) + 8 := by ring
        rw [e8]
        simp only [apend, opend]
        rw [show 2 * j + 6 = 2 * (j + 3) by ring,
            show 2 * j + 4 = 2 * (j + 2) by ring,
            show 2 * j + 2 = 2 * (j + 1) by ring,
            (ih (j + 3) (by omega)).1, (ih (j + 2) (by omega)).1,
            (ih (j + 1) (by omega)).1, (ih j (by omega)).1]
      · have e9 : 2 * (j + 4) + 1 = (2 * j + 1) + 8 := by ring
        rw [e9]
        simp only [apend, epend]
        rw [show 2 * j + 1 + 6 = 2 * (j + 3) + 1 by ring,
            show 2 * j + 1 + 4 = 2 * (j + 2) + 1 by ring,
            show 2 * j + 1 + 2 = 2 * (j + 1) + 1 by ring,
            (ih (j + 3) (by omega)).2, (ih (j + 2) (by omega)).2,
            (ih (j + 1) (by omega)).2, (ih j (by omega)).2]

/-- **余数样式 pat2**（12 留数类 ↦ 余数）：
0↦1, 1↦0, 2↦0, 3↦1, 4↦0, 5↦1, 6↦0, 7↦0, 8↦1, 9↦1, 10↦0, 11↦1。 -/
def pat2 : ℕ → ℤ
  | 0 => 1
  | 1 => 0
  | 2 => 0
  | 3 => 1
  | 4 => 0
  | 5 => 1
  | 6 => 0
  | 7 => 0
  | 8 => 1
  | 9 => 1
  | 10 => 0
  | _ => 1

/-- **T2（伴随）**：apend 的 mod 2 余数仅依赖 n mod 12，样式为 pat2。 -/
theorem apend_mod2_period12 (n r : ℕ) (hr : n % 12 = r) :
    apend n % 2 = pat2 r := by
  have main : ∀ n : ℕ, apend n % 2 = pat2 (n % 12) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 8
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 8 := ⟨n - 8, by omega⟩
        have h1 : apend (j + 8) % 2 = (apend (j + 4) % 2 + apend j % 2) % 2 := by
          simp only [apend]
          omega
        rw [h1, ih (j + 4) (by omega), ih j (by omega)]
        mod_cases hj : j % 12
        · have hj0 : j % 12 = 0 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 4 := by omega
          have h8 : (j + 8) % 12 = 8 := by omega
          rw [hj0, h4, h8]; decide
        · have hj1 : j % 12 = 1 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 5 := by omega
          have h8 : (j + 8) % 12 = 9 := by omega
          rw [hj1, h4, h8]; decide
        · have hj2 : j % 12 = 2 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 6 := by omega
          have h8 : (j + 8) % 12 = 10 := by omega
          rw [hj2, h4, h8]; decide
        · have hj3 : j % 12 = 3 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 7 := by omega
          have h8 : (j + 8) % 12 = 11 := by omega
          rw [hj3, h4, h8]; decide
        · have hj4 : j % 12 = 4 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 8 := by omega
          have h8 : (j + 8) % 12 = 0 := by omega
          rw [hj4, h4, h8]; decide
        · have hj5 : j % 12 = 5 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 9 := by omega
          have h8 : (j + 8) % 12 = 1 := by omega
          rw [hj5, h4, h8]; decide
        · have hj6 : j % 12 = 6 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 10 := by omega
          have h8 : (j + 8) % 12 = 2 := by omega
          rw [hj6, h4, h8]; decide
        · have hj7 : j % 12 = 7 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 11 := by omega
          have h8 : (j + 8) % 12 = 3 := by omega
          rw [hj7, h4, h8]; decide
        · have hj8 : j % 12 = 8 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 0 := by omega
          have h8 : (j + 8) % 12 = 4 := by omega
          rw [hj8, h4, h8]; decide
        · have hj9 : j % 12 = 9 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 1 := by omega
          have h8 : (j + 8) % 12 = 5 := by omega
          rw [hj9, h4, h8]; decide
        · have hj10 : j % 12 = 10 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 2 := by omega
          have h8 : (j + 8) % 12 = 6 := by omega
          rw [hj10, h4, h8]; decide
        · have hj11 : j % 12 = 11 := by simpa [Nat.ModEq] using hj
          have h4 : (j + 4) % 12 = 3 := by omega
          have h8 : (j + 8) % 12 = 7 := by omega
          rw [hj11, h4, h8]; decide
  rw [← hr]; exact main n

/-- **余数样式 pat6**：0↦1, 4↦1，其余↦0（订正后口径：奇 ⟺ k ≡ 0 或 4 (mod 6)）。 -/
def pat6 : ℕ → ℤ
  | 0 => 1
  | 4 => 1
  | _ => 0

/-- **余数样式 pat3**：0↦0，其余↦1（订正后口径：偶 ⟺ k ≡ 0 (mod 3)）。 -/
def pat3 : ℕ → ℤ
  | 0 => 0
  | _ => 1

/-- **T3 之 opend（伴随）**：opend k 的 mod 2 余数仅依赖 k mod 6，样式为 pat6
（即 opend k 为奇 ⟺ k ≡ 0 或 4 (mod 6)）。 -/
theorem opend_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    opend k % 2 = pat6 r := by
  have main : ∀ k : ℕ, opend k % 2 = pat6 (k % 6) := by
    intro k
    induction k using Nat.strong_induction_on with
    | h k ih =>
      by_cases hk : k < 4
      · interval_cases k <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, k = j + 4 := ⟨k - 4, by omega⟩
        have h1 : opend (j + 4) % 2 = (opend (j + 2) % 2 + opend j % 2) % 2 := by
          simp only [opend]
          omega
        rw [h1, ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 6
        · have hj0 : j % 6 = 0 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 2 := by omega
          have h4 : (j + 4) % 6 = 4 := by omega
          rw [hj0, h2, h4]; decide
        · have hj1 : j % 6 = 1 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 3 := by omega
          have h4 : (j + 4) % 6 = 5 := by omega
          rw [hj1, h2, h4]; decide
        · have hj2 : j % 6 = 2 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 4 := by omega
          have h4 : (j + 4) % 6 = 0 := by omega
          rw [hj2, h2, h4]; decide
        · have hj3 : j % 6 = 3 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 5 := by omega
          have h4 : (j + 4) % 6 = 1 := by omega
          rw [hj3, h2, h4]; decide
        · have hj4 : j % 6 = 4 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 0 := by omega
          have h4 : (j + 4) % 6 = 2 := by omega
          rw [hj4, h2, h4]; decide
        · have hj5 : j % 6 = 5 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 6 = 1 := by omega
          have h4 : (j + 4) % 6 = 3 := by omega
          rw [hj5, h2, h4]; decide
  rw [← hr]; exact main k

/-- **T3 之 epend（伴随）**：epend k 的 mod 2 余数仅依赖 k mod 3，样式为 pat3
（即 epend k 为偶 ⟺ k ≡ 0 (mod 3)）。 -/
theorem epend_mod2_period3 (k r : ℕ) (hr : k % 3 = r) :
    epend k % 2 = pat3 r := by
  have main : ∀ k : ℕ, epend k % 2 = pat3 (k % 3) := by
    intro k
    induction k using Nat.strong_induction_on with
    | h k ih =>
      by_cases hk : k < 4
      · interval_cases k <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, k = j + 4 := ⟨k - 4, by omega⟩
        have h1 : epend (j + 4) % 2 = (epend (j + 2) % 2 + epend j % 2) % 2 := by
          simp only [epend]
          omega
        rw [h1, ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 3
        · have hj0 : j % 3 = 0 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 3 = 2 := by omega
          have h4 : (j + 4) % 3 = 1 := by omega
          rw [hj0, h2, h4]
          decide
        · have hj1 : j % 3 = 1 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 3 = 0 := by omega
          have h4 : (j + 4) % 3 = 2 := by omega
          rw [hj1, h2, h4]
          decide
        · have hj2 : j % 3 = 2 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 3 = 1 := by omega
          have h4 : (j + 4) % 3 = 0 := by omega
          rw [hj2, h2, h4]
          decide
  rw [← hr]; exact main k
