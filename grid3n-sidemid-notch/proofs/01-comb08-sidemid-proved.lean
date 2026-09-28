/-
  AI4Math 流水线 · AI 生成 · 2026-09-28
  部门：02 形式化部 statement 冻结 + 04 军政部 proof body 终稿合并
  任务线：comb08-sidemid（pool-comb-08；3×n 网格删右列中点全匹配数，六阶稀疏递推）
  来源卡：tasks/20260928-comb08-sidemid/card.md（闸门一 2026-09-28 立项）
  主张定稿：tasks/20260928-comb08-sidemid/phase0/claims.md（T1 主攻 + T2/T3 伴随）
  初值数据出处：phase0/counts.txt + phase0/modscan.txt（三法互证/双窗口各 PASS）
  本文件 = attempts/final-asid_interleave.lean、final-asid_mod2_period3.lean、
  final-asid_mod4_period12.lean 三个单独严格模式验证通过的 proof 逐字合并
  （五条 def 一份 + 辅助引理 asid_shift/asid_evenlag12 + 三条定理）。
  statement 与冻结快照 formalized/01-comb08-sidemid-statements.statement.txt 逐字一致。
-/
import Mathlib

/-- **序列 asid（主列，六阶稀疏递推）**。
初值 a(0..5) = 1, 8, 46, 295, 1814, 11306；
递推 a(n+6) = 4·a(n+5) + 14·a(n+4) − 10·a(n+2) + a(n)（n ≥ 0；
递推签名 (4,14,0,−10,0,1)，系数为 0 的滞后项按主列 def 口径省略不写）。 -/
def asid : ℕ → ℤ
  | 0 => 1
  | 1 => 8
  | 2 => 46
  | 3 => 295
  | 4 => 1814
  | 5 => 11306
  | n + 6 => 4 * asid (n + 5) + 14 * asid (n + 4) - 10 * asid (n + 2) + asid n

/-- **序列 osid（1-based 奇位子列，六阶递推）**。
初值 o(0..5) = 1, 46, 1814, 70161, 2708104, 104507480
（= asid 在下标 0,2,4,6,8,10 处之值，即 a(1),a(3),a(5),a(7),a(9),a(11)）；
递推 o(k+6) = 44·o(k+5) − 216·o(k+4) + 282·o(k+3) − 128·o(k+2) + 20·o(k+1) − o(k)（k ≥ 0）。 -/
def osid : ℕ → ℤ
  | 0 => 1
  | 1 => 46
  | 2 => 1814
  | 3 => 70161
  | 4 => 2708104
  | 5 => 104507480
  | k + 6 =>
      44 * osid (k + 5) - 216 * osid (k + 4) + 282 * osid (k + 3)
        - 128 * osid (k + 2) + 20 * osid (k + 1) - osid k

/-- **序列 esid（1-based 偶位子列，六阶递推）**。
初值 e(0..5) = 8, 295, 11306, 435986, 16823455, 649209736
（= asid 在下标 1,3,5,7,9,11 处之值，即 a(2),a(4),a(6),a(8),a(10),a(12)）；
递推 e(k+6) = 44·e(k+5) − 216·e(k+4) + 282·e(k+3) − 128·e(k+2) + 20·e(k+1) − e(k)（k ≥ 0）。 -/
def esid : ℕ → ℤ
  | 0 => 8
  | 1 => 295
  | 2 => 11306
  | 3 => 435986
  | 4 => 16823455
  | 5 => 649209736
  | k + 6 =>
      44 * esid (k + 5) - 216 * esid (k + 4) + 282 * esid (k + 3)
        - 128 * esid (k + 2) + 20 * esid (k + 1) - esid k

/-- **余数样式 pat3**：0↦1，其余↦0
（mod 2 余数 0-based 口径：asid n 为奇 ⟺ n ≡ 0 (mod 3)）。 -/
def pat3 : ℕ → ℤ
  | 0 => 1
  | _ => 0

/-- **余数样式 pat12**（12 留数类 ↦ mod 4 余数）：
0↦1, 1↦0, 2↦2, 3↦3, 4↦2, 5↦2, 6↦1, 7↦2, 8↦0, 9↦3, 10↦0, 11↦0。 -/
def pat12 : ℕ → ℤ
  | 0 => 1
  | 1 => 0
  | 2 => 2
  | 3 => 3
  | 4 => 2
  | 5 => 2
  | 6 => 1
  | 7 => 2
  | 8 => 0
  | 9 => 3
  | 10 => 0
  | _ => 0

/-- 辅助：asid 单步展开（t+6 形）。 -/
theorem asid_shift (t : ℕ) :
    asid (t + 6) = 4 * asid (t + 5) + 14 * asid (t + 4) - 10 * asid (t + 2) + asid t := by
  simp only [asid]

/-- 辅助：12 阶偶滞后恒等式 asid(m+12) = 44·asid(m+10) − 216·asid(m+8) + 282·asid(m+6)
− 128·asid(m+4) + 20·asid(m+2) − asid(m)。全级联展开到基 asid(m..m+5) 后 ring 闭合。 -/
theorem asid_evenlag12 (m : ℕ) :
    asid (m + 12) = 44 * asid (m + 10) - 216 * asid (m + 8) + 282 * asid (m + 6)
      - 128 * asid (m + 4) + 20 * asid (m + 2) - asid m := by
  rw [show m + 12 = (m + 6) + 6 by ring, asid_shift (m + 6),
      show m + 6 + 5 = m + 11 by ring,
      show m + 6 + 4 = m + 10 by ring,
      show m + 6 + 2 = m + 8 by ring]
  rw [show m + 11 = (m + 5) + 6 by ring, asid_shift (m + 5),
      show m + 5 + 5 = m + 10 by ring,
      show m + 5 + 4 = m + 9 by ring,
      show m + 5 + 2 = m + 7 by ring]
  rw [show m + 10 = (m + 4) + 6 by ring, asid_shift (m + 4),
      show m + 4 + 5 = m + 9 by ring,
      show m + 4 + 4 = m + 8 by ring,
      show m + 4 + 2 = m + 6 by ring]
  rw [show m + 9 = (m + 3) + 6 by ring, asid_shift (m + 3),
      show m + 3 + 5 = m + 8 by ring,
      show m + 3 + 4 = m + 7 by ring,
      show m + 3 + 2 = m + 5 by ring]
  rw [show m + 8 = (m + 2) + 6 by ring, asid_shift (m + 2),
      show m + 2 + 5 = m + 7 by ring,
      show m + 2 + 4 = m + 6 by ring,
      show m + 2 + 2 = m + 4 by ring]
  rw [show m + 7 = (m + 1) + 6 by ring, asid_shift (m + 1),
      show m + 1 + 5 = m + 6 by ring,
      show m + 1 + 4 = m + 5 by ring,
      show m + 1 + 2 = m + 3 by ring]
  rw [asid_shift m]
  ring

/-- **T1（主攻）**：主列六阶递推 = 两条同系数六阶子列的交织——
对一切 k，asid (2k) = osid k 且 asid (2k+1) = esid k。 -/
theorem asid_interleave (k : ℕ) :
    asid (2 * k) = osid k ∧ asid (2 * k + 1) = esid k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 6
    · interval_cases k <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, k = j + 6 := ⟨k - 6, by omega⟩
      constructor
      · rw [show 2 * (j + 6) = (2 * j) + 12 by ring, asid_evenlag12 (2 * j)]
        simp only [osid]
        rw [show 2 * j + 10 = 2 * (j + 5) by ring, (ih (j + 5) (by omega)).1,
            show 2 * j + 8 = 2 * (j + 4) by ring, (ih (j + 4) (by omega)).1,
            show 2 * j + 6 = 2 * (j + 3) by ring, (ih (j + 3) (by omega)).1,
            show 2 * j + 4 = 2 * (j + 2) by ring, (ih (j + 2) (by omega)).1,
            show 2 * j + 2 = 2 * (j + 1) by ring, (ih (j + 1) (by omega)).1,
            (ih j (by omega)).1]
      · rw [show 2 * (j + 6) + 1 = (2 * j + 1) + 12 by ring, asid_evenlag12 (2 * j + 1)]
        simp only [esid]
        rw [show 2 * j + 1 + 10 = 2 * (j + 5) + 1 by ring, (ih (j + 5) (by omega)).2,
            show 2 * j + 1 + 8 = 2 * (j + 4) + 1 by ring, (ih (j + 4) (by omega)).2,
            show 2 * j + 1 + 6 = 2 * (j + 3) + 1 by ring, (ih (j + 3) (by omega)).2,
            show 2 * j + 1 + 4 = 2 * (j + 2) + 1 by ring, (ih (j + 2) (by omega)).2,
            show 2 * j + 1 + 2 = 2 * (j + 1) + 1 by ring, (ih (j + 1) (by omega)).2,
            (ih j (by omega)).2]

/-- **T2（伴随）**：asid 的 mod 2 余数仅依赖 n mod 3，样式为 pat3
（即 asid n 为奇 ⟺ n ≡ 0 (mod 3)；1-based 口径 = a(n) 为奇 ⟺ n ≡ 1 (mod 3)）。 -/
theorem asid_mod2_period3 (n r : ℕ) (hr : n % 3 = r) :
    asid n % 2 = pat3 r := by
  have main : ∀ n : ℕ, asid n % 2 = pat3 (n % 3) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 6
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 6 := ⟨n - 6, by omega⟩
        have h1 : asid (j + 6) % 2 = asid j % 2 := by
          simp only [asid]
          omega
        rw [h1, ih j (by omega), show (j + 6) % 3 = j % 3 by omega]
  rw [← hr]; exact main n

/-- **T3（伴随）**：asid 的 mod 4 余数仅依赖 n mod 12，样式为 pat12
（蕴含 T2：奇值恰在 n%12 ∈ {0,3,6,9} ⟺ n ≡ 0 (mod 3)）。 -/
theorem asid_mod4_period12 (n r : ℕ) (hr : n % 12 = r) :
    asid n % 4 = pat12 r := by
  have main : ∀ n : ℕ, asid n % 4 = pat12 (n % 12) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 6
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 6 := ⟨n - 6, by omega⟩
        have h1 : asid (j + 6) % 4
            = (2 * (asid (j + 4) % 4) + 2 * (asid (j + 2) % 4) + asid j % 4) % 4 := by
          simp only [asid]
          omega
        rw [h1, ih (j + 4) (by omega), ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 12
        · have hj0 : j % 12 = 0 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 2 := by omega
          have h4 : (j + 4) % 12 = 4 := by omega
          have h6 : (j + 6) % 12 = 6 := by omega
          rw [hj0, h2, h4, h6]; decide
        · have hj1 : j % 12 = 1 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 3 := by omega
          have h4 : (j + 4) % 12 = 5 := by omega
          have h6 : (j + 6) % 12 = 7 := by omega
          rw [hj1, h2, h4, h6]; decide
        · have hj2 : j % 12 = 2 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 4 := by omega
          have h4 : (j + 4) % 12 = 6 := by omega
          have h6 : (j + 6) % 12 = 8 := by omega
          rw [hj2, h2, h4, h6]; decide
        · have hj3 : j % 12 = 3 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 5 := by omega
          have h4 : (j + 4) % 12 = 7 := by omega
          have h6 : (j + 6) % 12 = 9 := by omega
          rw [hj3, h2, h4, h6]; decide
        · have hj4 : j % 12 = 4 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 6 := by omega
          have h4 : (j + 4) % 12 = 8 := by omega
          have h6 : (j + 6) % 12 = 10 := by omega
          rw [hj4, h2, h4, h6]; decide
        · have hj5 : j % 12 = 5 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 7 := by omega
          have h4 : (j + 4) % 12 = 9 := by omega
          have h6 : (j + 6) % 12 = 11 := by omega
          rw [hj5, h2, h4, h6]; decide
        · have hj6 : j % 12 = 6 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 8 := by omega
          have h4 : (j + 4) % 12 = 10 := by omega
          have h6 : (j + 6) % 12 = 0 := by omega
          rw [hj6, h2, h4, h6]; decide
        · have hj7 : j % 12 = 7 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 9 := by omega
          have h4 : (j + 4) % 12 = 11 := by omega
          have h6 : (j + 6) % 12 = 1 := by omega
          rw [hj7, h2, h4, h6]; decide
        · have hj8 : j % 12 = 8 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 10 := by omega
          have h4 : (j + 4) % 12 = 0 := by omega
          have h6 : (j + 6) % 12 = 2 := by omega
          rw [hj8, h2, h4, h6]; decide
        · have hj9 : j % 12 = 9 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 11 := by omega
          have h4 : (j + 4) % 12 = 1 := by omega
          have h6 : (j + 6) % 12 = 3 := by omega
          rw [hj9, h2, h4, h6]; decide
        · have hj10 : j % 12 = 10 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 0 := by omega
          have h4 : (j + 4) % 12 = 2 := by omega
          have h6 : (j + 6) % 12 = 4 := by omega
          rw [hj10, h2, h4, h6]; decide
        · have hj11 : j % 12 = 11 := by simpa [Nat.ModEq] using hj
          have h2 : (j + 2) % 12 = 1 := by omega
          have h4 : (j + 4) % 12 = 3 := by omega
          have h6 : (j + 6) % 12 = 5 := by omega
          rw [hj11, h2, h4, h6]; decide
  rw [← hr]; exact main n
