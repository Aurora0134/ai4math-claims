/-
  AI4Math 流水线 · AI 生成 · 2026-09-27
  部门：04 军政部（dept-prove）终态交付版
  任务线：mossad-notch · 3×n / 4×n 网格缺右上角匹配数（pool-mossad-02 / pool-mossad-03，pool Part A）
  来源卡：tasks/20260927-mossad-notch/card.md（闸门一 2026-09-27 立项；节点 anthropic/a6api-main/kimi-k3）
  主张定稿：tasks/20260927-mossad-notch/phase0/claims.md（T1/T2 主攻 + T3/T4 伴随；T4 取锐利 iff 形）
  冻结件：formalized/01-notch-mods.lean（sha256 9a787b6be05dc345343edf675d107801e674e3abae095356ace390fac8426fb8）；
    本文件两条 def 与四条 theorem 的 statement（含 docstring）与冻结件逐字一致（程序化抽取拼装），
    仅证明体由占位替换为完整证明。
  证明骨架（临摹 tasks/20260927-mossad-cchord/final/01-cchord-proved.lean 全绿先例）：
    逐点余数主引理（have 内嵌）+ Nat.strong_induction_on + 一次 simp only 展开递推
    + Int.ModEq.mul_left/add/sub 代数链 + decide 收口 + mod_cases 余类分支 + omega 驱动 if 分支消解；
    T1/T2 再经 Int.odd_iff 桥回 Odd；T4 残基表 [3,0,3,0,0,1,2,3,0,0] 以三段 if 链内嵌于主引理。
  初值数据出处：phase0/counts.txt（双方法互证 PASS；主代理复核递推全窗口逐位一致）。
  口径：陈述中不出现图、网格、匹配等组合对象；只证递推定义版序列的奇偶/模周期性质。
  索引口径：两条序列 0-based；a3 n / a4 n 对应 counts.txt 第 (n+1) 行的 a3/a4 列。
-/

import Mathlib

/-- **序列 a3（3×n 缺角宽度，阶 5 递推）**。
初值 a3(0..4) = 2, 10, 67, 407, 2546（= counts.txt 第 1..5 行 a3 列）；
递推 a3(n+5) = 5·a3(n+4)+9·a3(n+3)−9·a3(n+2)−a3(n+1)+a3(n)。 -/
def a3 : ℕ → ℤ
  | 0 => 2
  | 1 => 10
  | 2 => 67
  | 3 => 407
  | 4 => 2546
  | n + 5 =>
      5 * a3 (n + 4) + 9 * a3 (n + 3) - 9 * a3 (n + 2) - a3 (n + 1) + a3 n

/-- **T1（主攻）**：a3 为奇数 ⟺ n 除以 6 余 2 或 3（奇偶性以 6 为周期）。 -/
theorem a3_odd_iff (n : ℕ) : Odd (a3 n) ↔ n % 6 = 2 ∨ n % 6 = 3 := by
  have main : ∀ n : ℕ, a3 n ≡ (if n % 6 = 2 ∨ n % 6 = 3 then (1 : ℤ) else 0) [ZMOD 2] := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      rcases lt_or_ge n 5 with hlt | hge
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 5 := ⟨n - 5, by omega⟩
        have rec5 : ∀ m : ℕ, a3 (m + 5)
            = 5 * a3 (m + 4) + 9 * a3 (m + 3) - 9 * a3 (m + 2) - a3 (m + 1) + a3 m := fun m => by
          simp only [a3]
        rw [rec5 j]
        have g4 := ih (j + 4) (by omega)
        have g3 := ih (j + 3) (by omega)
        have g2 := ih (j + 2) (by omega)
        have g1 := ih (j + 1) (by omega)
        have g0 := ih j (by omega)
        mod_cases hx : j % 6
        · have hx' : j % 6 = 0 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3) by omega)]
          rw [if_neg (show ¬ ((j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3) by omega)] at g4
          rw [if_pos (show (j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3 by omega)] at g3
          rw [if_pos (show (j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3) by omega)] at g1
          rw [if_neg (show ¬ (j % 6 = 2 ∨ j % 6 = 3) by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 6 = 1 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3) by omega)]
          rw [if_neg (show ¬ ((j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3) by omega)] at g3
          rw [if_pos (show (j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3 by omega)] at g2
          rw [if_pos (show (j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3 by omega)] at g1
          rw [if_neg (show ¬ (j % 6 = 2 ∨ j % 6 = 3) by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 6 = 2 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3) by omega)]
          rw [if_neg (show ¬ ((j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3) by omega)] at g2
          rw [if_pos (show (j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3 by omega)] at g1
          rw [if_pos (show j % 6 = 2 ∨ j % 6 = 3 by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 6 = 3 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3 by omega)]
          rw [if_neg (show ¬ ((j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3) by omega)] at g1
          rw [if_pos (show j % 6 = 2 ∨ j % 6 = 3 by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 6 = 4 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3 by omega)]
          rw [if_pos (show (j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3) by omega)] at g1
          rw [if_neg (show ¬ (j % 6 = 2 ∨ j % 6 = 3) by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 6 = 5 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 5) % 6 = 2 ∨ (j + 5) % 6 = 3) by omega)]
          rw [if_pos (show (j + 4) % 6 = 2 ∨ (j + 4) % 6 = 3 by omega)] at g4
          rw [if_pos (show (j + 3) % 6 = 2 ∨ (j + 3) % 6 = 3 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 6 = 2 ∨ (j + 2) % 6 = 3) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 6 = 2 ∨ (j + 1) % 6 = 3) by omega)] at g1
          rw [if_neg (show ¬ (j % 6 = 2 ∨ j % 6 = 3) by omega)] at g0
          have key := ((((g4.mul_left 5).add (g3.mul_left 9)).sub (g2.mul_left 9)).sub g1).add g0
          exact key.trans (by decide)
  have h := main n
  constructor
  · intro hodd
    by_cases hc : n % 6 = 2 ∨ n % 6 = 3
    · exact hc
    · rw [if_neg hc] at h
      have h' : a3 n % 2 = 0 % 2 := h
      have h1 : a3 n % 2 = 1 := Int.odd_iff.mp hodd
      omega
  · intro hc
    rw [if_pos hc] at h
    rw [Int.odd_iff]
    have h' : a3 n % 2 = 1 % 2 := h
    omega

/-- **T3（伴随）**：a3 模 8 以 12 为周期。 -/
theorem a3_mod8_periodic (n : ℕ) : a3 (n + 12) ≡ a3 n [ZMOD 8] := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 12 with hlt | hge
    · interval_cases n <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 12 := ⟨n - 12, by omega⟩
      have rec5 : ∀ m : ℕ, a3 (m + 5)
          = 5 * a3 (m + 4) + 9 * a3 (m + 3) - 9 * a3 (m + 2) - a3 (m + 1) + a3 m := fun m => by
        simp only [a3]
      have e1 : a3 (j + 12 + 12)
          = 5 * a3 (j + 23) + 9 * a3 (j + 22) - 9 * a3 (j + 21) - a3 (j + 20) + a3 (j + 19) :=
        rec5 (j + 19)
      have e2 : a3 (j + 12)
          = 5 * a3 (j + 11) + 9 * a3 (j + 10) - 9 * a3 (j + 9) - a3 (j + 8) + a3 (j + 7) :=
        rec5 (j + 7)
      have h23 : a3 (j + 23) ≡ a3 (j + 11) [ZMOD 8] := ih (j + 11) (by omega)
      have h22 : a3 (j + 22) ≡ a3 (j + 10) [ZMOD 8] := ih (j + 10) (by omega)
      have h21 : a3 (j + 21) ≡ a3 (j + 9) [ZMOD 8] := ih (j + 9) (by omega)
      have h20 : a3 (j + 20) ≡ a3 (j + 8) [ZMOD 8] := ih (j + 8) (by omega)
      have h19 : a3 (j + 19) ≡ a3 (j + 7) [ZMOD 8] := ih (j + 7) (by omega)
      have key := ((((h23.mul_left 5).add (h22.mul_left 9)).sub (h21.mul_left 9)).sub h20).add h19
      rw [e1, e2]
      exact key

/-- **序列 a4（4×n 缺角宽度，阶 9 递推）**。
初值 a4(0..8) = 3, 32, 407, 4840, 58608, 705949, 8515850, 102684287, 1238310540
（= counts.txt 第 1..9 行 a4 列）；
递推 a4(n+9) = 9·a4(n+8)+41·a4(n+7)−41·a4(n+6)−111·a4(n+5)+91·a4(n+4)+29·a4(n+3)
  −23·a4(n+2)−a4(n+1)+a4(n)。 -/
def a4 : ℕ → ℤ
  | 0 => 3
  | 1 => 32
  | 2 => 407
  | 3 => 4840
  | 4 => 58608
  | 5 => 705949
  | 6 => 8515850
  | 7 => 102684287
  | 8 => 1238310540
  | n + 9 =>
      9 * a4 (n + 8) + 41 * a4 (n + 7) - 41 * a4 (n + 6) - 111 * a4 (n + 5)
        + 91 * a4 (n + 4) + 29 * a4 (n + 3) - 23 * a4 (n + 2) - a4 (n + 1) + a4 n

/-- **T2（主攻）**：a4 为奇数 ⟺ n 除以 5 余 0 或 2（奇偶性以 5 为周期）。 -/
theorem a4_odd_iff (n : ℕ) : Odd (a4 n) ↔ n % 5 = 0 ∨ n % 5 = 2 := by
  have main : ∀ n : ℕ, a4 n ≡ (if n % 5 = 0 ∨ n % 5 = 2 then (1 : ℤ) else 0) [ZMOD 2] := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      rcases lt_or_ge n 9 with hlt | hge
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
        have rec9 : ∀ m : ℕ, a4 (m + 9)
            = 9 * a4 (m + 8) + 41 * a4 (m + 7) - 41 * a4 (m + 6) - 111 * a4 (m + 5)
              + 91 * a4 (m + 4) + 29 * a4 (m + 3) - 23 * a4 (m + 2) - a4 (m + 1) + a4 m := fun m => by
          simp only [a4]
        rw [rec9 j]
        have g8 := ih (j + 8) (by omega)
        have g7 := ih (j + 7) (by omega)
        have g6 := ih (j + 6) (by omega)
        have g5 := ih (j + 5) (by omega)
        have g4 := ih (j + 4) (by omega)
        have g3 := ih (j + 3) (by omega)
        have g2 := ih (j + 2) (by omega)
        have g1 := ih (j + 1) (by omega)
        have g0 := ih j (by omega)
        mod_cases hx : j % 5
        · have hx' : j % 5 = 0 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 5 = 0 ∨ (j + 9) % 5 = 2) by omega)]
          rw [if_neg (show ¬ ((j + 8) % 5 = 0 ∨ (j + 8) % 5 = 2) by omega)] at g8
          rw [if_pos (show (j + 7) % 5 = 0 ∨ (j + 7) % 5 = 2 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 5 = 0 ∨ (j + 6) % 5 = 2) by omega)] at g6
          rw [if_pos (show (j + 5) % 5 = 0 ∨ (j + 5) % 5 = 2 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 5 = 0 ∨ (j + 4) % 5 = 2) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 5 = 0 ∨ (j + 3) % 5 = 2) by omega)] at g3
          rw [if_pos (show (j + 2) % 5 = 0 ∨ (j + 2) % 5 = 2 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 5 = 0 ∨ (j + 1) % 5 = 2) by omega)] at g1
          rw [if_pos (show j % 5 = 0 ∨ j % 5 = 2 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 5 = 1 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9) % 5 = 0 ∨ (j + 9) % 5 = 2 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 5 = 0 ∨ (j + 8) % 5 = 2) by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 5 = 0 ∨ (j + 7) % 5 = 2) by omega)] at g7
          rw [if_pos (show (j + 6) % 5 = 0 ∨ (j + 6) % 5 = 2 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 5 = 0 ∨ (j + 5) % 5 = 2) by omega)] at g5
          rw [if_pos (show (j + 4) % 5 = 0 ∨ (j + 4) % 5 = 2 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 5 = 0 ∨ (j + 3) % 5 = 2) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 5 = 0 ∨ (j + 2) % 5 = 2) by omega)] at g2
          rw [if_pos (show (j + 1) % 5 = 0 ∨ (j + 1) % 5 = 2 by omega)] at g1
          rw [if_neg (show ¬ (j % 5 = 0 ∨ j % 5 = 2) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 5 = 2 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 5 = 0 ∨ (j + 9) % 5 = 2) by omega)]
          rw [if_pos (show (j + 8) % 5 = 0 ∨ (j + 8) % 5 = 2 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 5 = 0 ∨ (j + 7) % 5 = 2) by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 5 = 0 ∨ (j + 6) % 5 = 2) by omega)] at g6
          rw [if_pos (show (j + 5) % 5 = 0 ∨ (j + 5) % 5 = 2 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 5 = 0 ∨ (j + 4) % 5 = 2) by omega)] at g4
          rw [if_pos (show (j + 3) % 5 = 0 ∨ (j + 3) % 5 = 2 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 5 = 0 ∨ (j + 2) % 5 = 2) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 5 = 0 ∨ (j + 1) % 5 = 2) by omega)] at g1
          rw [if_pos (show j % 5 = 0 ∨ j % 5 = 2 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 5 = 3 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9) % 5 = 0 ∨ (j + 9) % 5 = 2 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 5 = 0 ∨ (j + 8) % 5 = 2) by omega)] at g8
          rw [if_pos (show (j + 7) % 5 = 0 ∨ (j + 7) % 5 = 2 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 5 = 0 ∨ (j + 6) % 5 = 2) by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 5 = 0 ∨ (j + 5) % 5 = 2) by omega)] at g5
          rw [if_pos (show (j + 4) % 5 = 0 ∨ (j + 4) % 5 = 2 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 5 = 0 ∨ (j + 3) % 5 = 2) by omega)] at g3
          rw [if_pos (show (j + 2) % 5 = 0 ∨ (j + 2) % 5 = 2 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 5 = 0 ∨ (j + 1) % 5 = 2) by omega)] at g1
          rw [if_neg (show ¬ (j % 5 = 0 ∨ j % 5 = 2) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 5 = 4 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 5 = 0 ∨ (j + 9) % 5 = 2) by omega)]
          rw [if_pos (show (j + 8) % 5 = 0 ∨ (j + 8) % 5 = 2 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 5 = 0 ∨ (j + 7) % 5 = 2) by omega)] at g7
          rw [if_pos (show (j + 6) % 5 = 0 ∨ (j + 6) % 5 = 2 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 5 = 0 ∨ (j + 5) % 5 = 2) by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 5 = 0 ∨ (j + 4) % 5 = 2) by omega)] at g4
          rw [if_pos (show (j + 3) % 5 = 0 ∨ (j + 3) % 5 = 2 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 5 = 0 ∨ (j + 2) % 5 = 2) by omega)] at g2
          rw [if_pos (show (j + 1) % 5 = 0 ∨ (j + 1) % 5 = 2 by omega)] at g1
          rw [if_neg (show ¬ (j % 5 = 0 ∨ j % 5 = 2) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
  have h := main n
  constructor
  · intro hodd
    by_cases hc : n % 5 = 0 ∨ n % 5 = 2
    · exact hc
    · rw [if_neg hc] at h
      have h' : a4 n % 2 = 0 % 2 := h
      have h1 : a4 n % 2 = 1 := Int.odd_iff.mp hodd
      omega
  · intro hc
    rw [if_pos hc] at h
    rw [Int.odd_iff]
    have h' : a4 n % 2 = 1 % 2 := h
    omega

/-- **T4（伴随，锐利 iff 形）**：a4(n) ≡ 2 (mod 4) ⟺ n 除以 10 余 6
（其余余类 mod 4 ∈ {0,1,3} 各 5 余类循环；周期 10）。 -/
theorem a4_mod4_eq2_iff (n : ℕ) : a4 n ≡ 2 [ZMOD 4] ↔ n % 10 = 6 := by
  have main : ∀ n : ℕ, a4 n ≡ (if n % 10 = 0 ∨ n % 10 = 2 ∨ n % 10 = 7 then (3 : ℤ)
      else if n % 10 = 5 then 1 else if n % 10 = 6 then 2 else 0) [ZMOD 4] := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      rcases lt_or_ge n 9 with hlt | hge
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
        have rec9 : ∀ m : ℕ, a4 (m + 9)
            = 9 * a4 (m + 8) + 41 * a4 (m + 7) - 41 * a4 (m + 6) - 111 * a4 (m + 5)
              + 91 * a4 (m + 4) + 29 * a4 (m + 3) - 23 * a4 (m + 2) - a4 (m + 1) + a4 m := fun m => by
          simp only [a4]
        rw [rec9 j]
        have g8 := ih (j + 8) (by omega)
        have g7 := ih (j + 7) (by omega)
        have g6 := ih (j + 6) (by omega)
        have g5 := ih (j + 5) (by omega)
        have g4 := ih (j + 4) (by omega)
        have g3 := ih (j + 3) (by omega)
        have g2 := ih (j + 2) (by omega)
        have g1 := ih (j + 1) (by omega)
        have g0 := ih j (by omega)
        mod_cases hx : j % 10
        · have hx' : j % 10 = 0 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 6) by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 6) by omega)] at g8
          rw [if_pos (show (j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_pos (show (j + 6) % 10 = 6 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_pos (show (j + 5) % 10 = 5 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 6) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 6) by omega)] at g3
          rw [if_pos (show (j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 6) by omega)] at g1
          rw [if_pos (show j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 1 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 6) by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 6) by omega)] at g7
          rw [if_pos (show (j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_pos (show (j + 5) % 10 = 6 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_pos (show (j + 4) % 10 = 5 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 6) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 6) by omega)] at g2
          rw [if_pos (show (j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7 by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_neg (show ¬ (j % 10 = 6) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 2 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 6) by omega)]
          rw [if_pos (show (j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 6) by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 6) by omega)] at g6
          rw [if_pos (show (j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_pos (show (j + 4) % 10 = 6 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_pos (show (j + 3) % 10 = 5 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 6) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 6) by omega)] at g1
          rw [if_pos (show j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 3 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 6) by omega)] at g8
          rw [if_pos (show (j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 6) by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 6) by omega)] at g5
          rw [if_pos (show (j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_pos (show (j + 3) % 10 = 6 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_pos (show (j + 2) % 10 = 5 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 6) by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_neg (show ¬ (j % 10 = 6) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 4 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 6) by omega)]
          rw [if_pos (show (j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 6) by omega)] at g7
          rw [if_pos (show (j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 6) by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 6) by omega)] at g4
          rw [if_pos (show (j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_pos (show (j + 2) % 10 = 6 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_pos (show (j + 1) % 10 = 5 by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_neg (show ¬ (j % 10 = 6) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 5 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 6) by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 6) by omega)] at g8
          rw [if_pos (show (j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 6) by omega)] at g6
          rw [if_pos (show (j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 6) by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 6) by omega)] at g3
          rw [if_pos (show (j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_pos (show (j + 1) % 10 = 6 by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_pos (show j % 10 = 5 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 6 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_pos (show (j + 9) % 10 = 5 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 6) by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 6) by omega)] at g7
          rw [if_pos (show (j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 6) by omega)] at g5
          rw [if_pos (show (j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 6) by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 6) by omega)] at g2
          rw [if_pos (show (j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7 by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_pos (show j % 10 = 6 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 7 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_pos (show (j + 9) % 10 = 6 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_pos (show (j + 8) % 10 = 5 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 6) by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 6) by omega)] at g6
          rw [if_pos (show (j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7 by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 6) by omega)] at g4
          rw [if_pos (show (j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 6) by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 6) by omega)] at g1
          rw [if_pos (show j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7 by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 8 := by simpa [Nat.ModEq] using hx
          rw [if_pos (show (j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7 by omega)]
          rw [if_neg (show ¬ ((j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 8) % 10 = 5) by omega),
            if_pos (show (j + 8) % 10 = 6 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_pos (show (j + 7) % 10 = 5 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 6) % 10 = 6) by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 6) by omega)] at g5
          rw [if_pos (show (j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7 by omega)] at g4
          rw [if_neg (show ¬ ((j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 3) % 10 = 6) by omega)] at g3
          rw [if_pos (show (j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7 by omega)] at g2
          rw [if_neg (show ¬ ((j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 1) % 10 = 6) by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_neg (show ¬ (j % 10 = 6) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
        · have hx' : j % 10 = 9 := by simpa [Nat.ModEq] using hx
          rw [if_neg (show ¬ ((j + 9) % 10 = 0 ∨ (j + 9) % 10 = 2 ∨ (j + 9) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 9) % 10 = 6) by omega)]
          rw [if_pos (show (j + 8) % 10 = 0 ∨ (j + 8) % 10 = 2 ∨ (j + 8) % 10 = 7 by omega)] at g8
          rw [if_neg (show ¬ ((j + 7) % 10 = 0 ∨ (j + 7) % 10 = 2 ∨ (j + 7) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 7) % 10 = 5) by omega),
            if_pos (show (j + 7) % 10 = 6 by omega)] at g7
          rw [if_neg (show ¬ ((j + 6) % 10 = 0 ∨ (j + 6) % 10 = 2 ∨ (j + 6) % 10 = 7) by omega),
            if_pos (show (j + 6) % 10 = 5 by omega)] at g6
          rw [if_neg (show ¬ ((j + 5) % 10 = 0 ∨ (j + 5) % 10 = 2 ∨ (j + 5) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 5) % 10 = 6) by omega)] at g5
          rw [if_neg (show ¬ ((j + 4) % 10 = 0 ∨ (j + 4) % 10 = 2 ∨ (j + 4) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 4) % 10 = 6) by omega)] at g4
          rw [if_pos (show (j + 3) % 10 = 0 ∨ (j + 3) % 10 = 2 ∨ (j + 3) % 10 = 7 by omega)] at g3
          rw [if_neg (show ¬ ((j + 2) % 10 = 0 ∨ (j + 2) % 10 = 2 ∨ (j + 2) % 10 = 7) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 5) by omega),
            if_neg (show ¬ ((j + 2) % 10 = 6) by omega)] at g2
          rw [if_pos (show (j + 1) % 10 = 0 ∨ (j + 1) % 10 = 2 ∨ (j + 1) % 10 = 7 by omega)] at g1
          rw [if_neg (show ¬ (j % 10 = 0 ∨ j % 10 = 2 ∨ j % 10 = 7) by omega),
            if_neg (show ¬ (j % 10 = 5) by omega),
            if_neg (show ¬ (j % 10 = 6) by omega)] at g0
          have key := ((((((((g8.mul_left 9).add (g7.mul_left 41)).sub (g6.mul_left 41)).sub
              (g5.mul_left 111)).add (g4.mul_left 91)).add (g3.mul_left 29)).sub
              (g2.mul_left 23)).sub g1).add g0
          exact key.trans (by decide)
  have h := main n
  constructor
  · intro hd
    have c := h.symm.trans hd
    mod_cases hx : n % 10
    · have hx' : n % 10 = 0 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 1 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 2 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 3 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 4 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 5 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 6 := by simpa [Nat.ModEq] using hx
      exact hx'
    · have hx' : n % 10 = 7 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 8 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
    · have hx' : n % 10 = 9 := by simpa [Nat.ModEq] using hx
      rw [hx'] at c
      exact absurd c (by decide)
  · intro hc
    rw [hc] at h
    exact h.trans (by decide)
