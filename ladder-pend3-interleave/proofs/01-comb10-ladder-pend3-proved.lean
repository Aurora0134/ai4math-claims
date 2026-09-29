/-
  AI4Math 流水线 · AI 生成 · 2026-09-29
  任务线：comb10-ladder-pend3（pool-comb-10）· 三定理合并终审稿
  冻结快照：formalized/comb10-ladder-pend3.statement.txt
    （sha256 47d54db7c3d5309720537295055d5869e990618399950aaacb311f8028a9bba9）
  来源分件（kernel 已逐件过）：attempts/comb10-t1.lean / comb10-t2.lean / comb10-t3.lean
  声明层对冻结件零改动；T3 前一条 set_option maxHeartbeats 800000 为编译资源旋钮
  （comb-09 T2 同类判例，内核语义不受影响）。
-/

import Mathlib

def ap3 : ℕ → ℤ
  | 0 => 1
  | 1 => 3
  | 2 => 10
  | 3 => 32
  | 4 => 150
  | 5 => 457
  | 6 => 1489
  | 7 => 6948
  | 8 => 21191
  | 9 => 69032
  | 10 => 322142
  | 11 => 982496
  | n + 12 => 45 * ap3 (n + 9) + 63 * ap3 (n + 6) + 11 * ap3 (n + 3) - ap3 n

def bp0 : ℕ → ℤ
  | 0 => 1
  | 1 => 32
  | 2 => 1489
  | 3 => 69032
  | k + 4 => 45 * bp0 (k + 3) + 63 * bp0 (k + 2) + 11 * bp0 (k + 1) - bp0 k

def bp1 : ℕ → ℤ
  | 0 => 3
  | 1 => 150
  | 2 => 6948
  | 3 => 322142
  | k + 4 => 45 * bp1 (k + 3) + 63 * bp1 (k + 2) + 11 * bp1 (k + 1) - bp1 k

def bp2 : ℕ → ℤ
  | 0 => 10
  | 1 => 457
  | 2 => 21191
  | 3 => 982496
  | k + 4 => 45 * bp2 (k + 3) + 63 * bp2 (k + 2) + 11 * bp2 (k + 1) - bp2 k

theorem ap3_sub_0 (k : ℕ) : ap3 (3 * k) = bp0 k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 4
    · interval_cases k <;> norm_num [ap3, bp0]
    · let t := k - 4
      have ht : k = t + 4 := by dsimp [t]; omega
      have h0 := ih t (by omega)
      have h1 := ih (t + 1) (by omega)
      have h2 := ih (t + 2) (by omega)
      have h3 := ih (t + 3) (by omega)
      rw [ht, bp0]
      have hidx : 3 * (t + 4) = 3 * t + 12 := by omega
      rw [hidx]
      have hrec : ap3 (3 * t + 12) =
          45 * ap3 (3 * t + 9) + 63 * ap3 (3 * t + 6) +
            11 * ap3 (3 * t + 3) - ap3 (3 * t) := by
        rw [ap3]
      rw [hrec]
      have e3 : 3 * t + 9 = 3 * (t + 3) := by omega
      have e2 : 3 * t + 6 = 3 * (t + 2) := by omega
      have e1 : 3 * t + 3 = 3 * (t + 1) := by omega
      rw [e3, e2, e1, h3, h2, h1, h0]

theorem ap3_sub_1 (k : ℕ) : ap3 (3 * k + 1) = bp1 k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 4
    · interval_cases k <;> norm_num [ap3, bp1]
    · let t := k - 4
      have ht : k = t + 4 := by dsimp [t]; omega
      have h0 := ih t (by omega)
      have h1 := ih (t + 1) (by omega)
      have h2 := ih (t + 2) (by omega)
      have h3 := ih (t + 3) (by omega)
      rw [ht, bp1]
      have hidx : 3 * (t + 4) + 1 = (3 * t + 1) + 12 := by omega
      rw [hidx]
      have hrec : ap3 ((3 * t + 1) + 12) =
          45 * ap3 ((3 * t + 1) + 9) + 63 * ap3 ((3 * t + 1) + 6) +
            11 * ap3 ((3 * t + 1) + 3) - ap3 (3 * t + 1) := by
        rw [ap3]
      rw [hrec]
      have e3 : (3 * t + 1) + 9 = 3 * (t + 3) + 1 := by omega
      have e2 : (3 * t + 1) + 6 = 3 * (t + 2) + 1 := by omega
      have e1 : (3 * t + 1) + 3 = 3 * (t + 1) + 1 := by omega
      rw [e3, e2, e1, h3, h2, h1, h0]

theorem ap3_sub_2 (k : ℕ) : ap3 (3 * k + 2) = bp2 k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 4
    · interval_cases k <;> norm_num [ap3, bp2]
    · let t := k - 4
      have ht : k = t + 4 := by dsimp [t]; omega
      have h0 := ih t (by omega)
      have h1 := ih (t + 1) (by omega)
      have h2 := ih (t + 2) (by omega)
      have h3 := ih (t + 3) (by omega)
      rw [ht, bp2]
      have hidx : 3 * (t + 4) + 2 = (3 * t + 2) + 12 := by omega
      rw [hidx]
      have hrec : ap3 ((3 * t + 2) + 12) =
          45 * ap3 ((3 * t + 2) + 9) + 63 * ap3 ((3 * t + 2) + 6) +
            11 * ap3 ((3 * t + 2) + 3) - ap3 (3 * t + 2) := by
        rw [ap3]
      rw [hrec]
      have e3 : (3 * t + 2) + 9 = 3 * (t + 3) + 2 := by omega
      have e2 : (3 * t + 2) + 6 = 3 * (t + 2) + 2 := by omega
      have e1 : (3 * t + 2) + 3 = 3 * (t + 1) + 2 := by omega
      rw [e3, e2, e1, h3, h2, h1, h0]

theorem ap3_interleave (k : ℕ) :
    ap3 (3 * k) = bp0 k ∧ ap3 (3 * k + 1) = bp1 k ∧ ap3 (3 * k + 2) = bp2 k := by
  exact ⟨ap3_sub_0 k, ap3_sub_1 k, ap3_sub_2 k⟩

def pat15 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 0
  | 3 => 0
  | 4 => 0
  | 5 => 1
  | 6 => 1
  | 7 => 0
  | 8 => 1
  | 9 => 0
  | 10 => 0
  | 11 => 0
  | 12 => 0
  | 13 => 1
  | _ => 0

theorem ap3_mod2_period15 (n r : ℕ) (hr : n % 15 = r) :
    ap3 n % 2 = pat15 r := by
  have hperiod : ∀ m : ℕ, ap3 m % 2 = pat15 (m % 15) := by
    intro m
    induction m using Nat.strong_induction_on with
    | h m ih =>
      by_cases hm : m < 12
      · interval_cases m <;> decide
      · let t := m - 12
        have hmt : m = t + 12 := by
          dsimp [t]
          omega
        rw [hmt, ap3]
        have h0 := ih t (by omega)
        have h3 := ih (t + 3) (by omega)
        have h6 := ih (t + 6) (by omega)
        have h9 := ih (t + 9) (by omega)
        have hresBound : t % 15 < 15 := Nat.mod_lt _ (by omega)
        interval_cases hres : t % 15
        case «0» =>
          rw [(show (t + 3) % 15 = 3 by omega), (show (t + 6) % 15 = 6 by omega),
              (show (t + 9) % 15 = 9 by omega), (show (t + 12) % 15 = 12 by omega)] at *
          norm_num [pat15] at *
          omega
        case «1» =>
          rw [(show (t + 3) % 15 = 4 by omega), (show (t + 6) % 15 = 7 by omega),
              (show (t + 9) % 15 = 10 by omega), (show (t + 12) % 15 = 13 by omega)] at *
          norm_num [pat15] at *
          omega
        case «2» =>
          rw [(show (t + 3) % 15 = 5 by omega), (show (t + 6) % 15 = 8 by omega),
              (show (t + 9) % 15 = 11 by omega), (show (t + 12) % 15 = 14 by omega)] at *
          norm_num [pat15] at *
          omega
        case «3» =>
          rw [(show (t + 3) % 15 = 6 by omega), (show (t + 6) % 15 = 9 by omega),
              (show (t + 9) % 15 = 12 by omega), (show (t + 12) % 15 = 0 by omega)] at *
          norm_num [pat15] at *
          omega
        case «4» =>
          rw [(show (t + 3) % 15 = 7 by omega), (show (t + 6) % 15 = 10 by omega),
              (show (t + 9) % 15 = 13 by omega), (show (t + 12) % 15 = 1 by omega)] at *
          norm_num [pat15] at *
          omega
        case «5» =>
          rw [(show (t + 3) % 15 = 8 by omega), (show (t + 6) % 15 = 11 by omega),
              (show (t + 9) % 15 = 14 by omega), (show (t + 12) % 15 = 2 by omega)] at *
          norm_num [pat15] at *
          omega
        case «6» =>
          rw [(show (t + 3) % 15 = 9 by omega), (show (t + 6) % 15 = 12 by omega),
              (show (t + 9) % 15 = 0 by omega), (show (t + 12) % 15 = 3 by omega)] at *
          norm_num [pat15] at *
          omega
        case «7» =>
          rw [(show (t + 3) % 15 = 10 by omega), (show (t + 6) % 15 = 13 by omega),
              (show (t + 9) % 15 = 1 by omega), (show (t + 12) % 15 = 4 by omega)] at *
          norm_num [pat15] at *
          omega
        case «8» =>
          rw [(show (t + 3) % 15 = 11 by omega), (show (t + 6) % 15 = 14 by omega),
              (show (t + 9) % 15 = 2 by omega), (show (t + 12) % 15 = 5 by omega)] at *
          norm_num [pat15] at *
          omega
        case «9» =>
          rw [(show (t + 3) % 15 = 12 by omega), (show (t + 6) % 15 = 0 by omega),
              (show (t + 9) % 15 = 3 by omega), (show (t + 12) % 15 = 6 by omega)] at *
          norm_num [pat15] at *
          omega
        case «10» =>
          rw [(show (t + 3) % 15 = 13 by omega), (show (t + 6) % 15 = 1 by omega),
              (show (t + 9) % 15 = 4 by omega), (show (t + 12) % 15 = 7 by omega)] at *
          norm_num [pat15] at *
          omega
        case «11» =>
          rw [(show (t + 3) % 15 = 14 by omega), (show (t + 6) % 15 = 2 by omega),
              (show (t + 9) % 15 = 5 by omega), (show (t + 12) % 15 = 8 by omega)] at *
          norm_num [pat15] at *
          omega
        case «12» =>
          rw [(show (t + 3) % 15 = 0 by omega), (show (t + 6) % 15 = 3 by omega),
              (show (t + 9) % 15 = 6 by omega), (show (t + 12) % 15 = 9 by omega)] at *
          norm_num [pat15] at *
          omega
        case «13» =>
          rw [(show (t + 3) % 15 = 1 by omega), (show (t + 6) % 15 = 4 by omega),
              (show (t + 9) % 15 = 7 by omega), (show (t + 12) % 15 = 10 by omega)] at *
          norm_num [pat15] at *
          omega
        case «14» =>
          rw [(show (t + 3) % 15 = 2 by omega), (show (t + 6) % 15 = 5 by omega),
              (show (t + 9) % 15 = 8 by omega), (show (t + 12) % 15 = 11 by omega)] at *
          norm_num [pat15] at *
          omega
  rw [hperiod n, hr]

def pat30 : ℕ → ℤ
  | 0 => 1
  | 1 => 3
  | 2 => 2
  | 3 => 0
  | 4 => 2
  | 5 => 1
  | 6 => 1
  | 7 => 0
  | 8 => 3
  | 9 => 0
  | 10 => 2
  | 11 => 0
  | 12 => 2
  | 13 => 1
  | 14 => 2
  | 15 => 1
  | 16 => 1
  | 17 => 2
  | 18 => 2
  | 19 => 2
  | 20 => 1
  | 21 => 3
  | 22 => 2
  | 23 => 1
  | 24 => 2
  | 25 => 2
  | 26 => 0
  | 27 => 0
  | 28 => 1
  | _ => 0

set_option maxHeartbeats 800000 in
theorem ap3_mod4_period30 (n r : ℕ) (hr : n % 30 = r) :
    ap3 n % 4 = pat30 r := by
  have hperiod : ∀ m : ℕ, ap3 m % 4 = pat30 (m % 30) := by
    intro m
    induction m using Nat.strong_induction_on with
    | h m ih =>
      by_cases hm : m < 12
      · interval_cases m <;> decide
      · let t := m - 12
        have hmt : m = t + 12 := by
          dsimp [t]
          omega
        rw [hmt, ap3]
        have h0 := ih t (by omega)
        have h3 := ih (t + 3) (by omega)
        have h6 := ih (t + 6) (by omega)
        have h9 := ih (t + 9) (by omega)
        have hresBound : t % 30 < 30 := Nat.mod_lt _ (by omega)
        interval_cases hres : t % 30
        case «0» =>
          rw [(show (t + 3) % 30 = 3 by omega), (show (t + 6) % 30 = 6 by omega),
              (show (t + 9) % 30 = 9 by omega), (show (t + 12) % 30 = 12 by omega)] at *
          norm_num [pat30] at *
          omega
        case «1» =>
          rw [(show (t + 3) % 30 = 4 by omega), (show (t + 6) % 30 = 7 by omega),
              (show (t + 9) % 30 = 10 by omega), (show (t + 12) % 30 = 13 by omega)] at *
          norm_num [pat30] at *
          omega
        case «2» =>
          rw [(show (t + 3) % 30 = 5 by omega), (show (t + 6) % 30 = 8 by omega),
              (show (t + 9) % 30 = 11 by omega), (show (t + 12) % 30 = 14 by omega)] at *
          norm_num [pat30] at *
          omega
        case «3» =>
          rw [(show (t + 3) % 30 = 6 by omega), (show (t + 6) % 30 = 9 by omega),
              (show (t + 9) % 30 = 12 by omega), (show (t + 12) % 30 = 15 by omega)] at *
          norm_num [pat30] at *
          omega
        case «4» =>
          rw [(show (t + 3) % 30 = 7 by omega), (show (t + 6) % 30 = 10 by omega),
              (show (t + 9) % 30 = 13 by omega), (show (t + 12) % 30 = 16 by omega)] at *
          norm_num [pat30] at *
          omega
        case «5» =>
          rw [(show (t + 3) % 30 = 8 by omega), (show (t + 6) % 30 = 11 by omega),
              (show (t + 9) % 30 = 14 by omega), (show (t + 12) % 30 = 17 by omega)] at *
          norm_num [pat30] at *
          omega
        case «6» =>
          rw [(show (t + 3) % 30 = 9 by omega), (show (t + 6) % 30 = 12 by omega),
              (show (t + 9) % 30 = 15 by omega), (show (t + 12) % 30 = 18 by omega)] at *
          norm_num [pat30] at *
          omega
        case «7» =>
          rw [(show (t + 3) % 30 = 10 by omega), (show (t + 6) % 30 = 13 by omega),
              (show (t + 9) % 30 = 16 by omega), (show (t + 12) % 30 = 19 by omega)] at *
          norm_num [pat30] at *
          omega
        case «8» =>
          rw [(show (t + 3) % 30 = 11 by omega), (show (t + 6) % 30 = 14 by omega),
              (show (t + 9) % 30 = 17 by omega), (show (t + 12) % 30 = 20 by omega)] at *
          norm_num [pat30] at *
          omega
        case «9» =>
          rw [(show (t + 3) % 30 = 12 by omega), (show (t + 6) % 30 = 15 by omega),
              (show (t + 9) % 30 = 18 by omega), (show (t + 12) % 30 = 21 by omega)] at *
          norm_num [pat30] at *
          omega
        case «10» =>
          rw [(show (t + 3) % 30 = 13 by omega), (show (t + 6) % 30 = 16 by omega),
              (show (t + 9) % 30 = 19 by omega), (show (t + 12) % 30 = 22 by omega)] at *
          norm_num [pat30] at *
          omega
        case «11» =>
          rw [(show (t + 3) % 30 = 14 by omega), (show (t + 6) % 30 = 17 by omega),
              (show (t + 9) % 30 = 20 by omega), (show (t + 12) % 30 = 23 by omega)] at *
          norm_num [pat30] at *
          omega
        case «12» =>
          rw [(show (t + 3) % 30 = 15 by omega), (show (t + 6) % 30 = 18 by omega),
              (show (t + 9) % 30 = 21 by omega), (show (t + 12) % 30 = 24 by omega)] at *
          norm_num [pat30] at *
          omega
        case «13» =>
          rw [(show (t + 3) % 30 = 16 by omega), (show (t + 6) % 30 = 19 by omega),
              (show (t + 9) % 30 = 22 by omega), (show (t + 12) % 30 = 25 by omega)] at *
          norm_num [pat30] at *
          omega
        case «14» =>
          rw [(show (t + 3) % 30 = 17 by omega), (show (t + 6) % 30 = 20 by omega),
              (show (t + 9) % 30 = 23 by omega), (show (t + 12) % 30 = 26 by omega)] at *
          norm_num [pat30] at *
          omega
        case «15» =>
          rw [(show (t + 3) % 30 = 18 by omega), (show (t + 6) % 30 = 21 by omega),
              (show (t + 9) % 30 = 24 by omega), (show (t + 12) % 30 = 27 by omega)] at *
          norm_num [pat30] at *
          omega
        case «16» =>
          rw [(show (t + 3) % 30 = 19 by omega), (show (t + 6) % 30 = 22 by omega),
              (show (t + 9) % 30 = 25 by omega), (show (t + 12) % 30 = 28 by omega)] at *
          norm_num [pat30] at *
          omega
        case «17» =>
          rw [(show (t + 3) % 30 = 20 by omega), (show (t + 6) % 30 = 23 by omega),
              (show (t + 9) % 30 = 26 by omega), (show (t + 12) % 30 = 29 by omega)] at *
          norm_num [pat30] at *
          omega
        case «18» =>
          rw [(show (t + 3) % 30 = 21 by omega), (show (t + 6) % 30 = 24 by omega),
              (show (t + 9) % 30 = 27 by omega), (show (t + 12) % 30 = 0 by omega)] at *
          norm_num [pat30] at *
          omega
        case «19» =>
          rw [(show (t + 3) % 30 = 22 by omega), (show (t + 6) % 30 = 25 by omega),
              (show (t + 9) % 30 = 28 by omega), (show (t + 12) % 30 = 1 by omega)] at *
          norm_num [pat30] at *
          omega
        case «20» =>
          rw [(show (t + 3) % 30 = 23 by omega), (show (t + 6) % 30 = 26 by omega),
              (show (t + 9) % 30 = 29 by omega), (show (t + 12) % 30 = 2 by omega)] at *
          norm_num [pat30] at *
          omega
        case «21» =>
          rw [(show (t + 3) % 30 = 24 by omega), (show (t + 6) % 30 = 27 by omega),
              (show (t + 9) % 30 = 0 by omega), (show (t + 12) % 30 = 3 by omega)] at *
          norm_num [pat30] at *
          omega
        case «22» =>
          rw [(show (t + 3) % 30 = 25 by omega), (show (t + 6) % 30 = 28 by omega),
              (show (t + 9) % 30 = 1 by omega), (show (t + 12) % 30 = 4 by omega)] at *
          norm_num [pat30] at *
          omega
        case «23» =>
          rw [(show (t + 3) % 30 = 26 by omega), (show (t + 6) % 30 = 29 by omega),
              (show (t + 9) % 30 = 2 by omega), (show (t + 12) % 30 = 5 by omega)] at *
          norm_num [pat30] at *
          omega
        case «24» =>
          rw [(show (t + 3) % 30 = 27 by omega), (show (t + 6) % 30 = 0 by omega),
              (show (t + 9) % 30 = 3 by omega), (show (t + 12) % 30 = 6 by omega)] at *
          norm_num [pat30] at *
          omega
        case «25» =>
          rw [(show (t + 3) % 30 = 28 by omega), (show (t + 6) % 30 = 1 by omega),
              (show (t + 9) % 30 = 4 by omega), (show (t + 12) % 30 = 7 by omega)] at *
          norm_num [pat30] at *
          omega
        case «26» =>
          rw [(show (t + 3) % 30 = 29 by omega), (show (t + 6) % 30 = 2 by omega),
              (show (t + 9) % 30 = 5 by omega), (show (t + 12) % 30 = 8 by omega)] at *
          norm_num [pat30] at *
          omega
        case «27» =>
          rw [(show (t + 3) % 30 = 0 by omega), (show (t + 6) % 30 = 3 by omega),
              (show (t + 9) % 30 = 6 by omega), (show (t + 12) % 30 = 9 by omega)] at *
          norm_num [pat30] at *
          omega
        case «28» =>
          rw [(show (t + 3) % 30 = 1 by omega), (show (t + 6) % 30 = 4 by omega),
              (show (t + 9) % 30 = 7 by omega), (show (t + 12) % 30 = 10 by omega)] at *
          norm_num [pat30] at *
          omega
        case «29» =>
          rw [(show (t + 3) % 30 = 2 by omega), (show (t + 6) % 30 = 5 by omega),
              (show (t + 9) % 30 = 8 by omega), (show (t + 12) % 30 = 11 by omega)] at *
          norm_num [pat30] at *
          omega
  rw [hperiod n, hr]
