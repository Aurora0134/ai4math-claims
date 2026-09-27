/-
  AI4Math 流水线 · AI 生成 · 2026-09-27
  部门：02 形式化部（dept-formalize）
  任务线：mossad-cchord · 圈 C_n 加 ⌊n/3⌋ 弦的匹配数（pool-mossad-04，pool Part A）
  来源卡：tasks/20260927-mossad-cchord/card.md（闸门一 2026-09-27 立项，顺序 cchord 线）
  主张定稿：tasks/20260927-mossad-cchord/phase0/claims.md（C1 主攻 + C2/C3 伴随；C4 本批不做）
  初值数据出处：phase0/counts.txt（M1/M2/M3 三法互证 PASS）+ 主代理复核订正节
    （日志 logs/main-verify-mossad.out：发布递推在 counts.txt 全窗口逐位精确一致，
    C1–C3 模式在定义序列上全窗口 0 违反）；
    本文件三条 def 的初值与递推系数已按上述计数逐字核对一致，照抄 claims.md 草稿。

  口径（按任务卡锁定）：陈述中不出现图、匹配等组合对象；只形式化
  「递推定义版序列」（ℕ → ℤ，初值 + 整数系数递推显式进 def）的模周期/奇偶性质。
  语义桥（cchordR k ?= 匹配计数）不进本文件 theorem 层（comb.excluded.semantics-bridge 先例）。

  索引口径：三条序列 0-based；`cchordRr j` 对应子族 b(j+1)，即 a(3(j+1)+r)。
  本文件为军政部终态交付版：三条 theorem 的 proof body 已由占位替换为完整证明
  （statement 与冻结件 formalized/01-cchord-mods.lean 逐字一致，sha256 见 freeze.md）。
-/

import Mathlib

/-- **序列 cchordR2（r=2 子族，阶 8 递推）**。
初值 c(0..8) = 11, 191, 1475, 10615, 77623, 565895, 4127167, 30100411, 219522983
（= counts.txt 中 a(5),a(8),a(11),a(14),a(17),a(20),a(23),a(26),a(29)）；
递推 c(n+9) = 4c(n+8)+22c(n+7)+18c(n+6)−22c(n+5)−16c(n+4)+10c(n+3)+2c(n+2)−c(n+1)。 -/
def cchordR2 : ℕ → ℤ
  | 0 => 11
  | 1 => 191
  | 2 => 1475
  | 3 => 10615
  | 4 => 77623
  | 5 => 565895
  | 6 => 4127167
  | 7 => 30100411
  | 8 => 219522983
  | n + 9 =>
      4 * cchordR2 (n + 8) + 22 * cchordR2 (n + 7) + 18 * cchordR2 (n + 6)
        - 22 * cchordR2 (n + 5) - 16 * cchordR2 (n + 4) + 10 * cchordR2 (n + 3)
        + 2 * cchordR2 (n + 2) - cchordR2 (n + 1)

/-- **C1（主攻）**：r=2 子族 mod 4 恒等于 3。 -/
theorem cchordR2_mod_four : ∀ k : ℕ, cchordR2 k ≡ 3 [ZMOD 4] := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 9 with h | h
    · interval_cases n <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
      have rec9 : ∀ m : ℕ, cchordR2 (m + 9)
          = 4 * cchordR2 (m + 8) + 22 * cchordR2 (m + 7) + 18 * cchordR2 (m + 6)
            - 22 * cchordR2 (m + 5) - 16 * cchordR2 (m + 4) + 10 * cchordR2 (m + 3)
            + 2 * cchordR2 (m + 2) - cchordR2 (m + 1) := fun m => by
        simp only [cchordR2]
      rw [rec9 j]
      have h8 : cchordR2 (j + 8) ≡ 3 [ZMOD 4] := ih (j + 8) (by omega)
      have h7 : cchordR2 (j + 7) ≡ 3 [ZMOD 4] := ih (j + 7) (by omega)
      have h6 : cchordR2 (j + 6) ≡ 3 [ZMOD 4] := ih (j + 6) (by omega)
      have h5 : cchordR2 (j + 5) ≡ 3 [ZMOD 4] := ih (j + 5) (by omega)
      have h4 : cchordR2 (j + 4) ≡ 3 [ZMOD 4] := ih (j + 4) (by omega)
      have h3 : cchordR2 (j + 3) ≡ 3 [ZMOD 4] := ih (j + 3) (by omega)
      have h2 : cchordR2 (j + 2) ≡ 3 [ZMOD 4] := ih (j + 2) (by omega)
      have h1 : cchordR2 (j + 1) ≡ 3 [ZMOD 4] := ih (j + 1) (by omega)
      have key := (((((((h8.mul_left 4).add (h7.mul_left 22)).add (h6.mul_left 18)).sub
          (h5.mul_left 22)).sub (h4.mul_left 16)).add (h3.mul_left 10)).add
          (h2.mul_left 2)).sub h1
      exact key.trans (by decide)

/-- **序列 cchordR0（r=0 子族，阶 6 递推）**。
初值 c(0..6) = 4, 51, 382, 2743, 19907, 144054, 1043147
（= counts.txt 中 a(3),a(6),a(9),a(12),a(15),a(18),a(21)）；
递推 c(n+7) = 5c(n+6)+16c(n+5)+3c(n+4)−10c(n+3)−c(n+2)+c(n+1)。 -/
def cchordR0 : ℕ → ℤ
  | 0 => 4
  | 1 => 51
  | 2 => 382
  | 3 => 2743
  | 4 => 19907
  | 5 => 144054
  | 6 => 1043147
  | n + 7 =>
      5 * cchordR0 (n + 6) + 16 * cchordR0 (n + 5) + 3 * cchordR0 (n + 4)
        - 10 * cchordR0 (n + 3) - cchordR0 (n + 2) + cchordR0 (n + 1)

/-- **C2（伴随）**：r=0 子族 mod 4 三分支（j≥1 起；j=0 处 ≡0 为已知首例外）。 -/
theorem cchordR0_mod_four (j : ℕ) (hj : 1 ≤ j) :
    cchordR0 j ≡ (if 3 ∣ (j + 1) then 2 else 3) [ZMOD 4] := by
  induction j using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 7 with h | h
    · interval_cases n <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 7 := ⟨n - 7, by omega⟩
      have rec7 : ∀ m : ℕ, cchordR0 (m + 7)
          = 5 * cchordR0 (m + 6) + 16 * cchordR0 (m + 5) + 3 * cchordR0 (m + 4)
            - 10 * cchordR0 (m + 3) - cchordR0 (m + 2) + cchordR0 (m + 1) := fun m => by
        simp only [cchordR0]
      rw [rec7 j]
      have g6 := ih (j + 6) (by omega) (by omega)
      have g5 := ih (j + 5) (by omega) (by omega)
      have g4 := ih (j + 4) (by omega) (by omega)
      have g3 := ih (j + 3) (by omega) (by omega)
      have g2 := ih (j + 2) (by omega) (by omega)
      have g1 := ih (j + 1) (by omega) (by omega)
      mod_cases hx : (j + 1) % 3
      · have hx' : (j + 1) % 3 = 0 := by simpa [Nat.ModEq] using hx
        rw [if_neg (show ¬ 3 ∣ (j + 7 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)]
        rw [if_pos (show 3 ∣ (j + 6 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g6
        rw [if_neg (show ¬ 3 ∣ (j + 5 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g5
        rw [if_neg (show ¬ 3 ∣ (j + 4 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g4
        rw [if_pos (show 3 ∣ (j + 3 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g3
        rw [if_neg (show ¬ 3 ∣ (j + 2 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g2
        rw [if_neg (show ¬ 3 ∣ (j + 1 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g1
        have key := (((((g6.mul_left 5).add (g5.mul_left 16)).add (g4.mul_left 3)).sub
            (g3.mul_left 10)).sub g2).add g1
        exact key.trans (by decide)
      · have hx' : (j + 1) % 3 = 1 := by simpa [Nat.ModEq] using hx
        rw [if_neg (show ¬ 3 ∣ (j + 7 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)]
        rw [if_neg (show ¬ 3 ∣ (j + 6 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g6
        rw [if_pos (show 3 ∣ (j + 5 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g5
        rw [if_neg (show ¬ 3 ∣ (j + 4 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g4
        rw [if_neg (show ¬ 3 ∣ (j + 3 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g3
        rw [if_pos (show 3 ∣ (j + 2 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g2
        rw [if_neg (show ¬ 3 ∣ (j + 1 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g1
        have key := (((((g6.mul_left 5).add (g5.mul_left 16)).add (g4.mul_left 3)).sub
            (g3.mul_left 10)).sub g2).add g1
        exact key.trans (by decide)
      · have hx' : (j + 1) % 3 = 2 := by simpa [Nat.ModEq] using hx
        rw [if_pos (show 3 ∣ (j + 7 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)]
        rw [if_neg (show ¬ 3 ∣ (j + 6 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g6
        rw [if_neg (show ¬ 3 ∣ (j + 5 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g5
        rw [if_pos (show 3 ∣ (j + 4 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g4
        rw [if_neg (show ¬ 3 ∣ (j + 3 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g3
        rw [if_neg (show ¬ 3 ∣ (j + 2 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g2
        rw [if_pos (show 3 ∣ (j + 1 + 1) by rw [Nat.dvd_iff_mod_eq_zero]; omega)] at g1
        have key := (((((g6.mul_left 5).add (g5.mul_left 16)).add (g4.mul_left 3)).sub
            (g3.mul_left 10)).sub g2).add g1
        exact key.trans (by decide)

/-- **序列 cchordR1（r=1 子族，阶 8 递推）**。
初值 c(0..8) = 7, 99, 780, 5591, 41281, 302139, 2217121, 16257026, 119231297
（= counts.txt 中 a(4),a(7),a(10),a(13),a(16),a(19),a(22),a(25),a(28)）；
递推 c(n+9) = 4c(n+8)+23c(n+7)+14c(n+6)−23c(n+5)−14c(n+4)+9c(n+3)+2c(n+2)−c(n+1)。 -/
def cchordR1 : ℕ → ℤ
  | 0 => 7
  | 1 => 99
  | 2 => 780
  | 3 => 5591
  | 4 => 41281
  | 5 => 302139
  | 6 => 2217121
  | 7 => 16257026
  | 8 => 119231297
  | n + 9 =>
      4 * cchordR1 (n + 8) + 23 * cchordR1 (n + 7) + 14 * cchordR1 (n + 6)
        - 23 * cchordR1 (n + 5) - 14 * cchordR1 (n + 4) + 9 * cchordR1 (n + 3)
        + 2 * cchordR1 (n + 2) - cchordR1 (n + 1)

/-- **C3（伴随）**：r=1 子族奇偶 iff——偶数当且仅当 (j+1) % 5 = 3。 -/
theorem cchordR1_even_iff (j : ℕ) : 2 ∣ cchordR1 j ↔ (j + 1) % 5 = 3 := by
  have main : ∀ k : ℕ, cchordR1 k ≡ (if (k + 1) % 5 = 3 then (0 : ℤ) else 1) [ZMOD 2] := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      rcases lt_or_ge n 9 with h | h
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
        have rec9 : ∀ m : ℕ, cchordR1 (m + 9)
            = 4 * cchordR1 (m + 8) + 23 * cchordR1 (m + 7) + 14 * cchordR1 (m + 6)
              - 23 * cchordR1 (m + 5) - 14 * cchordR1 (m + 4) + 9 * cchordR1 (m + 3)
              + 2 * cchordR1 (m + 2) - cchordR1 (m + 1) := fun m => by
          simp only [cchordR1]
        rw [rec9 j]
        have g8 := ih (j + 8) (by omega)
        have g7 := ih (j + 7) (by omega)
        have g6 := ih (j + 6) (by omega)
        have g5 := ih (j + 5) (by omega)
        have g4 := ih (j + 4) (by omega)
        have g3 := ih (j + 3) (by omega)
        have g2 := ih (j + 2) (by omega)
        have g1 := ih (j + 1) (by omega)
        mod_cases hx : (j + 1) % 5
        · have hx' : (j + 1) % 5 = 0 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ (j + 9 + 1) % 5 = 3 by omega)]
          rw [if_pos (show (j + 8 + 1) % 5 = 3 by omega)] at g8
          rw [if_neg (show ¬ (j + 7 + 1) % 5 = 3 by omega)] at g7
          rw [if_neg (show ¬ (j + 6 + 1) % 5 = 3 by omega)] at g6
          rw [if_neg (show ¬ (j + 5 + 1) % 5 = 3 by omega)] at g5
          rw [if_neg (show ¬ (j + 4 + 1) % 5 = 3 by omega)] at g4
          rw [if_pos (show (j + 3 + 1) % 5 = 3 by omega)] at g3
          rw [if_neg (show ¬ (j + 2 + 1) % 5 = 3 by omega)] at g2
          rw [if_neg (show ¬ (j + 1 + 1) % 5 = 3 by omega)] at g1
          have key := (((((((g8.mul_left 4).add (g7.mul_left 23)).add (g6.mul_left 14)).sub
              (g5.mul_left 23)).sub (g4.mul_left 14)).add (g3.mul_left 9)).add
              (g2.mul_left 2)).sub g1
          exact key.trans (by decide)
        · have hx' : (j + 1) % 5 = 1 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ (j + 9 + 1) % 5 = 3 by omega)]
          rw [if_neg (show ¬ (j + 8 + 1) % 5 = 3 by omega)] at g8
          rw [if_pos (show (j + 7 + 1) % 5 = 3 by omega)] at g7
          rw [if_neg (show ¬ (j + 6 + 1) % 5 = 3 by omega)] at g6
          rw [if_neg (show ¬ (j + 5 + 1) % 5 = 3 by omega)] at g5
          rw [if_neg (show ¬ (j + 4 + 1) % 5 = 3 by omega)] at g4
          rw [if_neg (show ¬ (j + 3 + 1) % 5 = 3 by omega)] at g3
          rw [if_pos (show (j + 2 + 1) % 5 = 3 by omega)] at g2
          rw [if_neg (show ¬ (j + 1 + 1) % 5 = 3 by omega)] at g1
          have key := (((((((g8.mul_left 4).add (g7.mul_left 23)).add (g6.mul_left 14)).sub
              (g5.mul_left 23)).sub (g4.mul_left 14)).add (g3.mul_left 9)).add
              (g2.mul_left 2)).sub g1
          exact key.trans (by decide)
        · have hx' : (j + 1) % 5 = 2 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ (j + 9 + 1) % 5 = 3 by omega)]
          rw [if_neg (show ¬ (j + 8 + 1) % 5 = 3 by omega)] at g8
          rw [if_neg (show ¬ (j + 7 + 1) % 5 = 3 by omega)] at g7
          rw [if_pos (show (j + 6 + 1) % 5 = 3 by omega)] at g6
          rw [if_neg (show ¬ (j + 5 + 1) % 5 = 3 by omega)] at g5
          rw [if_neg (show ¬ (j + 4 + 1) % 5 = 3 by omega)] at g4
          rw [if_neg (show ¬ (j + 3 + 1) % 5 = 3 by omega)] at g3
          rw [if_neg (show ¬ (j + 2 + 1) % 5 = 3 by omega)] at g2
          rw [if_pos (show (j + 1 + 1) % 5 = 3 by omega)] at g1
          have key := (((((((g8.mul_left 4).add (g7.mul_left 23)).add (g6.mul_left 14)).sub
              (g5.mul_left 23)).sub (g4.mul_left 14)).add (g3.mul_left 9)).add
              (g2.mul_left 2)).sub g1
          exact key.trans (by decide)
        · have hx' : (j + 1) % 5 = 3 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ (j + 9 + 1) % 5 = 3 by omega)]
          rw [if_neg (show ¬ (j + 8 + 1) % 5 = 3 by omega)] at g8
          rw [if_neg (show ¬ (j + 7 + 1) % 5 = 3 by omega)] at g7
          rw [if_neg (show ¬ (j + 6 + 1) % 5 = 3 by omega)] at g6
          rw [if_pos (show (j + 5 + 1) % 5 = 3 by omega)] at g5
          rw [if_neg (show ¬ (j + 4 + 1) % 5 = 3 by omega)] at g4
          rw [if_neg (show ¬ (j + 3 + 1) % 5 = 3 by omega)] at g3
          rw [if_neg (show ¬ (j + 2 + 1) % 5 = 3 by omega)] at g2
          rw [if_neg (show ¬ (j + 1 + 1) % 5 = 3 by omega)] at g1
          have key := (((((((g8.mul_left 4).add (g7.mul_left 23)).add (g6.mul_left 14)).sub
              (g5.mul_left 23)).sub (g4.mul_left 14)).add (g3.mul_left 9)).add
              (g2.mul_left 2)).sub g1
          exact key.trans (by decide)
        · have hx' : (j + 1) % 5 = 4 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9 + 1) % 5 = 3 by omega)]
          rw [if_neg (show ¬ (j + 8 + 1) % 5 = 3 by omega)] at g8
          rw [if_neg (show ¬ (j + 7 + 1) % 5 = 3 by omega)] at g7
          rw [if_neg (show ¬ (j + 6 + 1) % 5 = 3 by omega)] at g6
          rw [if_neg (show ¬ (j + 5 + 1) % 5 = 3 by omega)] at g5
          rw [if_pos (show (j + 4 + 1) % 5 = 3 by omega)] at g4
          rw [if_neg (show ¬ (j + 3 + 1) % 5 = 3 by omega)] at g3
          rw [if_neg (show ¬ (j + 2 + 1) % 5 = 3 by omega)] at g2
          rw [if_neg (show ¬ (j + 1 + 1) % 5 = 3 by omega)] at g1
          have key := (((((((g8.mul_left 4).add (g7.mul_left 23)).add (g6.mul_left 14)).sub
              (g5.mul_left 23)).sub (g4.mul_left 14)).add (g3.mul_left 9)).add
              (g2.mul_left 2)).sub g1
          exact key.trans (by decide)
  have h := main j
  rw [← Int.modEq_zero_iff_dvd]
  constructor
  · intro hd
    by_cases hc : (j + 1) % 5 = 3
    · exact hc
    · rw [if_neg hc] at h
      exact absurd (h.symm.trans hd) (by decide)
  · intro hc
    rw [if_pos hc] at h
    exact h
