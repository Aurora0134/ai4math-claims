/-
  AI4Math 流水线 · AI 生成 · 2026-09-28
  部门：04 军政部 proof body 终稿组装（zcode 端点 agent-call 拒派 exit 2，按 SOP 兜底
    走主会话派发；本文件为已证定理合并稿）
  任务线：comb-07（pool-comb-07 · 3×n 网格删两对角角的全匹配数 · 七阶递推线）
  statement 逐字冻结自 tasks/20260928-comb07-diagnotch/formalized/01-comb07-diagnotch-statements.lean
    （快照 sha256=317ed6b1b963077f1e140f47ff7c2483767f1215b0366bbe2d5a1210ddcb0bcb；
    本文件四条定理 statement 与该快照逐字一致，proof body 为军政部产物）

  本线已证四定理（每条 proof 从对应 attempts/final-<名>.lean 逐字合并）：
    1. adiag_interleave      —— attempts/final-adiag_interleave.lean
    2. adiag_mod2_period12   —— attempts/final-adiag_mod2_period12.lean
    3. onotch_mod2_period6   —— attempts/final-onotch_mod2_period6.lean
    4. enotch_mod2_period6   —— attempts/final-enotch_mod2_period6.lean
  未证出/未立项定理（T4 备选）不进本稿。proof-manifest 见 attempts/prove-manifest.json。

  口径（按任务卡锁定，逐字沿用）：
  kernel 层只证「递推定义版序列」（ℕ → ℤ 的 def，初值与整数系数递推显式写进 def）
  的定理；statement 不含图/网格/匹配组合对象。「a(n) = 该图的匹配数」是组合语义桥，
  不进 theorem 层；论文按「已证定理（公式侧）+ 计数猜想（语义侧）」两级呈现。
  【占位围栏】PM（完美匹配）偶 n 子列 = OEIS A061278 已挂名占位，禁止以其作新颖性
  主张；价值级「新序列·新递推」成立（七阶递推与母族 A033506 不同谱，
  2026-09-28 机器双向核验互不满足）。（后续论文措辞不得越此围栏，逐字沿用。）
-/

import Mathlib

/-- **序列 adiag（主列，七阶递推）**。
初值 a(0..6) = 1, 5, 33, 204, 1266, 7873, 48882（0-based；对应 1-based a(1..7)）；
递推 a(n+7) = 4·a(n+6) + 15·a(n+5) − 5·a(n+4) − 19·a(n+3)
            + 9·a(n+2) + 2·a(n+1) − a(n)（n ≥ 0）。 -/
def adiag : ℕ → ℤ
  | 0 => 1
  | 1 => 5
  | 2 => 33
  | 3 => 204
  | 4 => 1266
  | 5 => 7873
  | 6 => 48882
  | n + 7 =>
      4 * adiag (n + 6) + 15 * adiag (n + 5) - 5 * adiag (n + 4)
        - 19 * adiag (n + 3) + 9 * adiag (n + 2) + 2 * adiag (n + 1) - adiag n

/-- **序列 onotch（1-based 奇位子列，与 enotch 同系数的七阶递推）**。
初值 o(0..6) = 1, 33, 1266, 48882, 1886600, 72804880, 2809532937
（= adiag 在下标 0,2,4,6,8,10,12 处之值）；
递推 o(k+7) = 46·o(k+6) − 303·o(k+5) + 671·o(k+4) − 519·o(k+3)
            + 167·o(k+2) − 22·o(k+1) + o(k)（k ≥ 0）。 -/
def onotch : ℕ → ℤ
  | 0 => 1
  | 1 => 33
  | 2 => 1266
  | 3 => 48882
  | 4 => 1886600
  | 5 => 72804880
  | 6 => 2809532937
  | k + 7 =>
      46 * onotch (k + 6) - 303 * onotch (k + 5) + 671 * onotch (k + 4)
        - 519 * onotch (k + 3) + 167 * onotch (k + 2) - 22 * onotch (k + 1) + onotch k

/-- **序列 enotch（1-based 偶位子列，与 onotch 同系数的七阶递推）**。
初值 e(0..6) = 5, 204, 7873, 303723, 11720017, 452270456, 17453021829
（= adiag 在下标 1,3,5,7,9,11,13 处之值）；
递推 e(k+7) = 46·e(k+6) − 303·e(k+5) + 671·e(k+4) − 519·e(k+3)
            + 167·e(k+2) − 22·e(k+1) + e(k)（k ≥ 0）。 -/
def enotch : ℕ → ℤ
  | 0 => 5
  | 1 => 204
  | 2 => 7873
  | 3 => 303723
  | 4 => 11720017
  | 5 => 452270456
  | 6 => 17453021829
  | k + 7 =>
      46 * enotch (k + 6) - 303 * enotch (k + 5) + 671 * enotch (k + 4)
        - 519 * enotch (k + 3) + 167 * enotch (k + 2) - 22 * enotch (k + 1) + enotch k

/-- **余数样式 pat2**（12 留数类 ↦ mod 2 余数）：
0↦1, 1↦1, 2↦1, 3↦0, 4↦0, 5↦1, 6↦0, 7↦1, 8↦0, 9↦1, 10↦0, 11↦0。 -/
def pat2 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 1
  | 3 => 0
  | 4 => 0
  | 5 => 1
  | 6 => 0
  | 7 => 1
  | 8 => 0
  | 9 => 1
  | 10 => 0
  | _ => 0

/-- **余数样式 pat6o**（onotch 侧 6 留数类 ↦ mod 2 余数）：
0↦1, 1↦1, 其余↦0（即 onotch k 为奇 ⟺ k ≡ 0 或 1 (mod 6)）。 -/
def pat6o : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | _ => 0

/-- **余数样式 pat6e**（enotch 侧 6 留数类 ↦ mod 2 余数）：
1↦0, 5↦0, 其余↦1（即 enotch k 为偶 ⟺ k ≡ 1 或 5 (mod 6)）。 -/
def pat6e : ℕ → ℤ
  | 1 => 0
  | 5 => 0
  | _ => 1

/-- **T1（主攻·交织恒等式）**：对一切 k，adiag (2k) = onotch k 且
adiag (2k+1) = enotch k。即：主列的完整七阶递推 = 两条同系数
（46,−303,671,−519,167,−22,1）七阶子列递推（onotch/enotch）的交织，
两者互相刻画（0-based；对应 1-based 的 a(2k+1)=o(k)、a(2k+2)=e(k)）。 -/
theorem adiag_interleave (k : ℕ) :
    adiag (2 * k) = onotch k ∧ adiag (2 * k + 1) = enotch k := by
  have lifted : ∀ n : ℕ, adiag (n + 14) = 46 * adiag (n + 12) - 303 * adiag (n + 10)
      + 671 * adiag (n + 8) - 519 * adiag (n + 6) + 167 * adiag (n + 4)
      - 22 * adiag (n + 2) + adiag n := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ihn =>
      by_cases hn : n < 7
      · interval_cases n <;> decide
      · obtain ⟨m, rfl⟩ : ∃ m, n = m + 7 := ⟨n - 7, by omega⟩
        show adiag (m + 21) = 46 * adiag (m + 19) - 303 * adiag (m + 17)
            + 671 * adiag (m + 15) - 519 * adiag (m + 13) + 167 * adiag (m + 11)
            - 22 * adiag (m + 9) + adiag (m + 7)
        have p0 : adiag (m + 7) = 4 * adiag (m + 6) + 15 * adiag (m + 5)
            - 5 * adiag (m + 4) - 19 * adiag (m + 3) + 9 * adiag (m + 2)
            + 2 * adiag (m + 1) - adiag m := by simp only [adiag]
        have p2 : adiag (m + 9) = 4 * adiag (m + 8) + 15 * adiag (m + 7)
            - 5 * adiag (m + 6) - 19 * adiag (m + 5) + 9 * adiag (m + 4)
            + 2 * adiag (m + 3) - adiag (m + 2) := by simp only [adiag]
        have p4 : adiag (m + 11) = 4 * adiag (m + 10) + 15 * adiag (m + 9)
            - 5 * adiag (m + 8) - 19 * adiag (m + 7) + 9 * adiag (m + 6)
            + 2 * adiag (m + 5) - adiag (m + 4) := by simp only [adiag]
        have p6 : adiag (m + 13) = 4 * adiag (m + 12) + 15 * adiag (m + 11)
            - 5 * adiag (m + 10) - 19 * adiag (m + 9) + 9 * adiag (m + 8)
            + 2 * adiag (m + 7) - adiag (m + 6) := by simp only [adiag]
        have p8 : adiag (m + 15) = 4 * adiag (m + 14) + 15 * adiag (m + 13)
            - 5 * adiag (m + 12) - 19 * adiag (m + 11) + 9 * adiag (m + 10)
            + 2 * adiag (m + 9) - adiag (m + 8) := by simp only [adiag]
        have p10 : adiag (m + 17) = 4 * adiag (m + 16) + 15 * adiag (m + 15)
            - 5 * adiag (m + 14) - 19 * adiag (m + 13) + 9 * adiag (m + 12)
            + 2 * adiag (m + 11) - adiag (m + 10) := by simp only [adiag]
        have p12 : adiag (m + 19) = 4 * adiag (m + 18) + 15 * adiag (m + 17)
            - 5 * adiag (m + 16) - 19 * adiag (m + 15) + 9 * adiag (m + 14)
            + 2 * adiag (m + 13) - adiag (m + 12) := by simp only [adiag]
        have p14 : adiag (m + 21) = 4 * adiag (m + 20) + 15 * adiag (m + 19)
            - 5 * adiag (m + 18) - 19 * adiag (m + 17) + 9 * adiag (m + 16)
            + 2 * adiag (m + 15) - adiag (m + 14) := by simp only [adiag]
        have h0 : adiag (m + 14) = 46 * adiag (m + 12) - 303 * adiag (m + 10)
            + 671 * adiag (m + 8) - 519 * adiag (m + 6) + 167 * adiag (m + 4)
            - 22 * adiag (m + 2) + adiag m := ihn m (by omega)
        have h1 : adiag (m + 15) = 46 * adiag (m + 13) - 303 * adiag (m + 11)
            + 671 * adiag (m + 9) - 519 * adiag (m + 7) + 167 * adiag (m + 5)
            - 22 * adiag (m + 3) + adiag (m + 1) := ihn (m + 1) (by omega)
        have h2 : adiag (m + 16) = 46 * adiag (m + 14) - 303 * adiag (m + 12)
            + 671 * adiag (m + 10) - 519 * adiag (m + 8) + 167 * adiag (m + 6)
            - 22 * adiag (m + 4) + adiag (m + 2) := ihn (m + 2) (by omega)
        have h3 : adiag (m + 17) = 46 * adiag (m + 15) - 303 * adiag (m + 13)
            + 671 * adiag (m + 11) - 519 * adiag (m + 9) + 167 * adiag (m + 7)
            - 22 * adiag (m + 5) + adiag (m + 3) := ihn (m + 3) (by omega)
        have h4 : adiag (m + 18) = 46 * adiag (m + 16) - 303 * adiag (m + 14)
            + 671 * adiag (m + 12) - 519 * adiag (m + 10) + 167 * adiag (m + 8)
            - 22 * adiag (m + 6) + adiag (m + 4) := ihn (m + 4) (by omega)
        have h5 : adiag (m + 19) = 46 * adiag (m + 17) - 303 * adiag (m + 15)
            + 671 * adiag (m + 13) - 519 * adiag (m + 11) + 167 * adiag (m + 9)
            - 22 * adiag (m + 7) + adiag (m + 5) := ihn (m + 5) (by omega)
        have h6 : adiag (m + 20) = 46 * adiag (m + 18) - 303 * adiag (m + 16)
            + 671 * adiag (m + 14) - 519 * adiag (m + 12) + 167 * adiag (m + 10)
            - 22 * adiag (m + 8) + adiag (m + 6) := ihn (m + 6) (by omega)
        linear_combination 4 * h6 + 15 * h5 - 5 * h4 - 19 * h3 + 9 * h2 + 2 * h1 - h0
          + p14 - 46 * p12 + 303 * p10 - 671 * p8 + 519 * p6 - 167 * p4 + 22 * p2 - p0
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 7
    · interval_cases k <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, k = j + 7 := ⟨k - 7, by omega⟩
      constructor
      · rw [show 2 * (j + 7) = 2 * j + 14 by ring, lifted (2 * j)]
        rw [show 2 * j + 12 = 2 * (j + 6) by ring,
            show 2 * j + 10 = 2 * (j + 5) by ring,
            show 2 * j + 8 = 2 * (j + 4) by ring,
            show 2 * j + 6 = 2 * (j + 3) by ring,
            show 2 * j + 4 = 2 * (j + 2) by ring,
            show 2 * j + 2 = 2 * (j + 1) by ring]
        rw [(ih (j + 6) (by omega)).1, (ih (j + 5) (by omega)).1,
            (ih (j + 4) (by omega)).1, (ih (j + 3) (by omega)).1,
            (ih (j + 2) (by omega)).1, (ih (j + 1) (by omega)).1,
            (ih j (by omega)).1]
        simp only [onotch]
      · rw [show 2 * (j + 7) + 1 = 2 * j + 1 + 14 by ring, lifted (2 * j + 1)]
        rw [show 2 * j + 1 + 12 = 2 * (j + 6) + 1 by ring,
            show 2 * j + 1 + 10 = 2 * (j + 5) + 1 by ring,
            show 2 * j + 1 + 8 = 2 * (j + 4) + 1 by ring,
            show 2 * j + 1 + 6 = 2 * (j + 3) + 1 by ring,
            show 2 * j + 1 + 4 = 2 * (j + 2) + 1 by ring,
            show 2 * j + 1 + 2 = 2 * (j + 1) + 1 by ring]
        rw [(ih (j + 6) (by omega)).2, (ih (j + 5) (by omega)).2,
            (ih (j + 4) (by omega)).2, (ih (j + 3) (by omega)).2,
            (ih (j + 2) (by omega)).2, (ih (j + 1) (by omega)).2,
            (ih j (by omega)).2]
        simp only [enotch]

/-- **T2（伴随·主列 mod 2 周期 12 显式样式）**：adiag n 的 mod 2 余数仅依赖
n mod 12，样式为 pat2（即 adiag n 为奇 ⟺ n ≡ 0,1,2,5,7,9 (mod 12)）。 -/
theorem adiag_mod2_period12 (n r : ℕ) (hr : n % 12 = r) :
    adiag n % 2 = pat2 r := by
  have main : ∀ n : ℕ, adiag n % 2 = pat2 (n % 12) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 7
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 7 := ⟨n - 7, by omega⟩
        have h1 : adiag (j + 7) % 2
            = (adiag (j + 5) % 2 + adiag (j + 4) % 2 + adiag (j + 3) % 2
                + adiag (j + 2) % 2 + adiag j % 2) % 2 := by
          simp only [adiag]
          omega
        rw [h1, ih (j + 5) (by omega), ih (j + 4) (by omega),
            ih (j + 3) (by omega), ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 12
        · have hj0 : j % 12 = 0 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 5 := by omega
          have h4 : (j + 4) % 12 = 4 := by omega
          have h3 : (j + 3) % 12 = 3 := by omega
          have h2 : (j + 2) % 12 = 2 := by omega
          have h7 : (j + 7) % 12 = 7 := by omega
          rw [hj0, h5, h4, h3, h2, h7]; decide
        · have hj1 : j % 12 = 1 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 6 := by omega
          have h4 : (j + 4) % 12 = 5 := by omega
          have h3 : (j + 3) % 12 = 4 := by omega
          have h2 : (j + 2) % 12 = 3 := by omega
          have h7 : (j + 7) % 12 = 8 := by omega
          rw [hj1, h5, h4, h3, h2, h7]; decide
        · have hj2 : j % 12 = 2 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 7 := by omega
          have h4 : (j + 4) % 12 = 6 := by omega
          have h3 : (j + 3) % 12 = 5 := by omega
          have h2 : (j + 2) % 12 = 4 := by omega
          have h7 : (j + 7) % 12 = 9 := by omega
          rw [hj2, h5, h4, h3, h2, h7]; decide
        · have hj3 : j % 12 = 3 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 8 := by omega
          have h4 : (j + 4) % 12 = 7 := by omega
          have h3 : (j + 3) % 12 = 6 := by omega
          have h2 : (j + 2) % 12 = 5 := by omega
          have h7 : (j + 7) % 12 = 10 := by omega
          rw [hj3, h5, h4, h3, h2, h7]; decide
        · have hj4 : j % 12 = 4 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 9 := by omega
          have h4 : (j + 4) % 12 = 8 := by omega
          have h3 : (j + 3) % 12 = 7 := by omega
          have h2 : (j + 2) % 12 = 6 := by omega
          have h7 : (j + 7) % 12 = 11 := by omega
          rw [hj4, h5, h4, h3, h2, h7]; decide
        · have hj5 : j % 12 = 5 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 10 := by omega
          have h4 : (j + 4) % 12 = 9 := by omega
          have h3 : (j + 3) % 12 = 8 := by omega
          have h2 : (j + 2) % 12 = 7 := by omega
          have h7 : (j + 7) % 12 = 0 := by omega
          rw [hj5, h5, h4, h3, h2, h7]; decide
        · have hj6 : j % 12 = 6 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 11 := by omega
          have h4 : (j + 4) % 12 = 10 := by omega
          have h3 : (j + 3) % 12 = 9 := by omega
          have h2 : (j + 2) % 12 = 8 := by omega
          have h7 : (j + 7) % 12 = 1 := by omega
          rw [hj6, h5, h4, h3, h2, h7]; decide
        · have hj7 : j % 12 = 7 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 0 := by omega
          have h4 : (j + 4) % 12 = 11 := by omega
          have h3 : (j + 3) % 12 = 10 := by omega
          have h2 : (j + 2) % 12 = 9 := by omega
          have h7 : (j + 7) % 12 = 2 := by omega
          rw [hj7, h5, h4, h3, h2, h7]; decide
        · have hj8 : j % 12 = 8 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 1 := by omega
          have h4 : (j + 4) % 12 = 0 := by omega
          have h3 : (j + 3) % 12 = 11 := by omega
          have h2 : (j + 2) % 12 = 10 := by omega
          have h7 : (j + 7) % 12 = 3 := by omega
          rw [hj8, h5, h4, h3, h2, h7]; decide
        · have hj9 : j % 12 = 9 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 2 := by omega
          have h4 : (j + 4) % 12 = 1 := by omega
          have h3 : (j + 3) % 12 = 0 := by omega
          have h2 : (j + 2) % 12 = 11 := by omega
          have h7 : (j + 7) % 12 = 4 := by omega
          rw [hj9, h5, h4, h3, h2, h7]; decide
        · have hj10 : j % 12 = 10 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 3 := by omega
          have h4 : (j + 4) % 12 = 2 := by omega
          have h3 : (j + 3) % 12 = 1 := by omega
          have h2 : (j + 2) % 12 = 0 := by omega
          have h7 : (j + 7) % 12 = 5 := by omega
          rw [hj10, h5, h4, h3, h2, h7]; decide
        · have hj11 : j % 12 = 11 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 12 = 4 := by omega
          have h4 : (j + 4) % 12 = 3 := by omega
          have h3 : (j + 3) % 12 = 2 := by omega
          have h2 : (j + 2) % 12 = 1 := by omega
          have h7 : (j + 7) % 12 = 6 := by omega
          rw [hj11, h5, h4, h3, h2, h7]; decide
  rw [← hr]; exact main n

/-- **T3 之 onotch（伴随·奇位子列 mod 2 周期 6 样式）**：onotch k 的 mod 2 余数
仅依赖 k mod 6，样式为 pat6o（即 onotch k 为奇 ⟺ k ≡ 0 或 1 (mod 6)）。 -/
theorem onotch_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    onotch k % 2 = pat6o r := by
  have main : ∀ k : ℕ, onotch k % 2 = pat6o (k % 6) := by
    intro k
    induction k using Nat.strong_induction_on with
    | h k ih =>
      by_cases hk : k < 7
      · interval_cases k <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, k = j + 7 := ⟨k - 7, by omega⟩
        have h1 : onotch (j + 7) % 2
            = (onotch (j + 5) % 2 + onotch (j + 4) % 2 + onotch (j + 3) % 2
                + onotch (j + 2) % 2 + onotch j % 2) % 2 := by
          simp only [onotch]
          omega
        rw [h1, ih (j + 5) (by omega), ih (j + 4) (by omega),
            ih (j + 3) (by omega), ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 6
        · have hj0 : j % 6 = 0 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 5 := by omega
          have h4 : (j + 4) % 6 = 4 := by omega
          have h3 : (j + 3) % 6 = 3 := by omega
          have h2 : (j + 2) % 6 = 2 := by omega
          have h7 : (j + 7) % 6 = 1 := by omega
          rw [hj0, h5, h4, h3, h2, h7]; decide
        · have hj1 : j % 6 = 1 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 0 := by omega
          have h4 : (j + 4) % 6 = 5 := by omega
          have h3 : (j + 3) % 6 = 4 := by omega
          have h2 : (j + 2) % 6 = 3 := by omega
          have h7 : (j + 7) % 6 = 2 := by omega
          rw [hj1, h5, h4, h3, h2, h7]; decide
        · have hj2 : j % 6 = 2 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 1 := by omega
          have h4 : (j + 4) % 6 = 0 := by omega
          have h3 : (j + 3) % 6 = 5 := by omega
          have h2 : (j + 2) % 6 = 4 := by omega
          have h7 : (j + 7) % 6 = 3 := by omega
          rw [hj2, h5, h4, h3, h2, h7]; decide
        · have hj3 : j % 6 = 3 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 2 := by omega
          have h4 : (j + 4) % 6 = 1 := by omega
          have h3 : (j + 3) % 6 = 0 := by omega
          have h2 : (j + 2) % 6 = 5 := by omega
          have h7 : (j + 7) % 6 = 4 := by omega
          rw [hj3, h5, h4, h3, h2, h7]; decide
        · have hj4 : j % 6 = 4 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 3 := by omega
          have h4 : (j + 4) % 6 = 2 := by omega
          have h3 : (j + 3) % 6 = 1 := by omega
          have h2 : (j + 2) % 6 = 0 := by omega
          have h7 : (j + 7) % 6 = 5 := by omega
          rw [hj4, h5, h4, h3, h2, h7]; decide
        · have hj5 : j % 6 = 5 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 4 := by omega
          have h4 : (j + 4) % 6 = 3 := by omega
          have h3 : (j + 3) % 6 = 2 := by omega
          have h2 : (j + 2) % 6 = 1 := by omega
          have h7 : (j + 7) % 6 = 0 := by omega
          rw [hj5, h5, h4, h3, h2, h7]; decide
  rw [← hr]; exact main k

/-- **T3 之 enotch（伴随·偶位子列 mod 2 周期 6 样式）**：enotch k 的 mod 2 余数
仅依赖 k mod 6，样式为 pat6e（即 enotch k 为偶 ⟺ k ≡ 1 或 5 (mod 6)）。 -/
theorem enotch_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    enotch k % 2 = pat6e r := by
  have main : ∀ k : ℕ, enotch k % 2 = pat6e (k % 6) := by
    intro k
    induction k using Nat.strong_induction_on with
    | h k ih =>
      by_cases hk : k < 7
      · interval_cases k <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, k = j + 7 := ⟨k - 7, by omega⟩
        have h1 : enotch (j + 7) % 2
            = (enotch (j + 5) % 2 + enotch (j + 4) % 2 + enotch (j + 3) % 2
                + enotch (j + 2) % 2 + enotch j % 2) % 2 := by
          simp only [enotch]
          omega
        rw [h1, ih (j + 5) (by omega), ih (j + 4) (by omega),
            ih (j + 3) (by omega), ih (j + 2) (by omega), ih j (by omega)]
        mod_cases hj : j % 6
        · have hj0 : j % 6 = 0 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 5 := by omega
          have h4 : (j + 4) % 6 = 4 := by omega
          have h3 : (j + 3) % 6 = 3 := by omega
          have h2 : (j + 2) % 6 = 2 := by omega
          have h7 : (j + 7) % 6 = 1 := by omega
          rw [hj0, h5, h4, h3, h2, h7]; decide
        · have hj1 : j % 6 = 1 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 0 := by omega
          have h4 : (j + 4) % 6 = 5 := by omega
          have h3 : (j + 3) % 6 = 4 := by omega
          have h2 : (j + 2) % 6 = 3 := by omega
          have h7 : (j + 7) % 6 = 2 := by omega
          rw [hj1, h5, h4, h3, h2, h7]; decide
        · have hj2 : j % 6 = 2 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 1 := by omega
          have h4 : (j + 4) % 6 = 0 := by omega
          have h3 : (j + 3) % 6 = 5 := by omega
          have h2 : (j + 2) % 6 = 4 := by omega
          have h7 : (j + 7) % 6 = 3 := by omega
          rw [hj2, h5, h4, h3, h2, h7]; decide
        · have hj3 : j % 6 = 3 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 2 := by omega
          have h4 : (j + 4) % 6 = 1 := by omega
          have h3 : (j + 3) % 6 = 0 := by omega
          have h2 : (j + 2) % 6 = 5 := by omega
          have h7 : (j + 7) % 6 = 4 := by omega
          rw [hj3, h5, h4, h3, h2, h7]; decide
        · have hj4 : j % 6 = 4 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 3 := by omega
          have h4 : (j + 4) % 6 = 2 := by omega
          have h3 : (j + 3) % 6 = 1 := by omega
          have h2 : (j + 2) % 6 = 0 := by omega
          have h7 : (j + 7) % 6 = 5 := by omega
          rw [hj4, h5, h4, h3, h2, h7]; decide
        · have hj5 : j % 6 = 5 := by simpa [Nat.ModEq] using hj
          have h5 : (j + 5) % 6 = 4 := by omega
          have h4 : (j + 4) % 6 = 3 := by omega
          have h3 : (j + 3) % 6 = 2 := by omega
          have h2 : (j + 2) % 6 = 1 := by omega
          have h7 : (j + 7) % 6 = 0 := by omega
          rw [hj5, h5, h4, h3, h2, h7]; decide
  rw [← hr]; exact main k
