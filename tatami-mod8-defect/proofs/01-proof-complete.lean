/-
  AI4Math 流水线 · AI 生成 · 2026-09-26
  任务：20260926-beian-select 候选01 Tatami 缺陷位形 —— 完全证明终稿（三定理合一）。
  组规：statement 段（本注释块以下全部 def/定理头/docstring）逐字 = 冻结
  formalized/01-statement.lean 第 26 行至 EOF（快照 01-snapshot.md）；proof body 为
  军政部三工人交付件的逐字并入（attempts/01-tatami_mod8_period4.lean、
  01-bcorner_odd.lean、02-bcorner_eq.lean；各件 strict 编译过、公理白名单内）。
-/

import Mathlib

/-- A180970 as a recurrence-defined sequence: base values a(0..8) and the
order-6 recurrence a(n) = a(n-1) + 2 a(n-2) + 2 a(n-4) - a(n-5) - a(n-6)
for n ≥ 9 (OEIS signature (1,2,0,2,-1,-1)). -/
def a180970 : ℕ → ℤ
  | 0 => 1
  | 1 => 3
  | 2 => 13
  | 3 => 22
  | 4 => 44
  | 5 => 90
  | 6 => 196
  | 7 => 406
  | 8 => 852
  | n + 9 =>
      a180970 (n + 8) + 2 * a180970 (n + 7) + 2 * a180970 (n + 5)
        - a180970 (n + 4) - a180970 (n + 3)

/-- Residue pattern: a(n) % 8 = pat8 (n % 4). -/
def pat8 : ℕ → ℤ
  | 0 => 4
  | 1 => 2
  | 2 => 4
  | _ => 6

/-- Corner-defect sequence b_c(n), recurrence-defined version: tatami tilings of a
3×n grid with one corner cell removed.  Base values b(1..9) from exact enumeration
(machine probe, n ≤ 20); b(0) := 0 is a conventional value (a 3×0 grid has no corner
cell) — no theorem below depends on it.  For n ≥ 10 the same order-6 recurrence as
the base sequence holds: b(n) = b(n-1) + 2 b(n-2) + 2 b(n-4) - b(n-5) - b(n-6). -/
def bcorner : ℕ → ℤ
  | 0 => 0
  | 1 => 2
  | 2 => 8
  | 3 => 24
  | 4 => 41
  | 5 => 85
  | 6 => 177
  | 7 => 381
  | 8 => 787
  | 9 => 1655
  | n + 10 =>
      bcorner (n + 9) + 2 * bcorner (n + 8) + 2 * bcorner (n + 6)
        - bcorner (n + 5) - bcorner (n + 4)

/-- **P1 (主攻)**: the mod-8 residue of A180970(n) depends only on n mod 4,
with pattern (4, 2, 4, 6) — equivalently a(n) % 8 = pat8 (n % 4) for all n ≥ 4.
Statement form verbatim from the r2 smoke-round kernel-accepted text. -/
theorem tatami_mod8_period4 (n r : ℕ) (hn : 4 ≤ n) (hr : n % 4 = r) :
    a180970 n % 8 = pat8 r := by
  induction n using Nat.strong_induction_on generalizing r with
  | _ n ih =>
    rcases lt_or_ge n 10 with h | h
    · interval_cases n
      all_goals norm_num at hr
      all_goals subst r
      all_goals norm_num [a180970, pat8]
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
      have hj : 1 ≤ j := by omega
      have rec9 : ∀ m : ℕ, a180970 (m + 9)
          = a180970 (m + 8) + 2 * a180970 (m + 7) + 2 * a180970 (m + 5)
            - a180970 (m + 4) - a180970 (m + 3) := fun m => by
        simp only [a180970]
      rw [rec9 j]
      have h8 := ih (j + 8) (by omega) ((r + 3) % 4) (by omega) (by omega)
      have h7 := ih (j + 7) (by omega) ((r + 2) % 4) (by omega) (by omega)
      have h5 := ih (j + 5) (by omega) r (by omega) (by omega)
      have h4 := ih (j + 4) (by omega) ((r + 3) % 4) (by omega) (by omega)
      have h3 := ih (j + 3) (by omega) ((r + 2) % 4) (by omega) (by omega)
      have hml := Nat.mod_lt (j + 9) (show 0 < 4 by norm_num)
      have rl : r < 4 := by omega
      interval_cases r <;>
        simp only [Nat.reduceAdd, Nat.reduceMod, pat8] at h8 h7 h5 h4 h3 ⊢ <;>
        omega

/-- **P2 (伴随)**: the corner-defect sequence b_c(n) is odd for all n ≥ 4. -/
theorem bcorner_odd (n : ℕ) (hn : 4 ≤ n) :
    bcorner n % 2 = 1 := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 10 with h | h
    · interval_cases n <;> norm_num [bcorner]
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 10 := ⟨n - 10, by omega⟩
      have rec10 : ∀ m : ℕ, bcorner (m + 10)
          = bcorner (m + 9) + 2 * bcorner (m + 8) + 2 * bcorner (m + 6)
            - bcorner (m + 5) - bcorner (m + 4) := fun m => by
        simp only [bcorner]
      rw [rec10 j]
      have h9 := ih (j + 9) (by omega) (by omega)
      have h8 := ih (j + 8) (by omega) (by omega)
      have h6 := ih (j + 6) (by omega) (by omega)
      have h5 := ih (j + 5) (by omega) (by omega)
      have h4 := ih (j + 4) (by omega) (by omega)
      omega

/-- **P3 (伴随)**: exact defect↔base linear identity for n ≥ 10:
20·b(n) = 4a(n) + 33a(n-1) - 9a(n-2) + 8a(n-3) + a(n-4) - 3a(n-5). -/
theorem bcorner_eq (n : ℕ) (hn : 10 ≤ n) :
    20 * bcorner n = 4 * a180970 n + 33 * a180970 (n - 1) - 9 * a180970 (n - 2)
      + 8 * a180970 (n - 3) + a180970 (n - 4) - 3 * a180970 (n - 5) := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 16 with h | h
    · interval_cases n <;> norm_num [a180970, bcorner]
    · obtain ⟨j, rfl⟩ : ∃ j, n = j + 16 := ⟨n - 16, by omega⟩
      rw [show j + 16 - 1 = j + 15 by omega, show j + 16 - 2 = j + 14 by omega,
          show j + 16 - 3 = j + 13 by omega, show j + 16 - 4 = j + 12 by omega,
          show j + 16 - 5 = j + 11 by omega]
      have rec9 : ∀ m : ℕ, a180970 (m + 9)
          = a180970 (m + 8) + 2 * a180970 (m + 7) + 2 * a180970 (m + 5)
            - a180970 (m + 4) - a180970 (m + 3) := fun m => by
        simp only [a180970]
      have rec10 : ∀ m : ℕ, bcorner (m + 10)
          = bcorner (m + 9) + 2 * bcorner (m + 8) + 2 * bcorner (m + 6)
            - bcorner (m + 5) - bcorner (m + 4) := fun m => by
        simp only [bcorner]
      have hb : bcorner (j + 16)
          = bcorner (j + 15) + 2 * bcorner (j + 14) + 2 * bcorner (j + 12)
            - bcorner (j + 11) - bcorner (j + 10) := by
        have h1 := rec10 (j + 6)
        rw [show j + 6 + 10 = j + 16 by omega, show j + 6 + 9 = j + 15 by omega,
            show j + 6 + 8 = j + 14 by omega, show j + 6 + 6 = j + 12 by omega,
            show j + 6 + 5 = j + 11 by omega, show j + 6 + 4 = j + 10 by omega] at h1
        exact h1
      have i1 := ih (j + 15) (by omega) (by omega)
      rw [show j + 15 - 1 = j + 14 by omega, show j + 15 - 2 = j + 13 by omega,
          show j + 15 - 3 = j + 12 by omega, show j + 15 - 4 = j + 11 by omega,
          show j + 15 - 5 = j + 10 by omega] at i1
      have a16 : a180970 (j + 16)
          = a180970 (j + 15) + 2 * a180970 (j + 14) + 2 * a180970 (j + 12)
            - a180970 (j + 11) - a180970 (j + 10) := by
        have h2 := rec9 (j + 7)
        rw [show j + 7 + 9 = j + 16 by omega, show j + 7 + 8 = j + 15 by omega,
            show j + 7 + 7 = j + 14 by omega, show j + 7 + 5 = j + 12 by omega,
            show j + 7 + 4 = j + 11 by omega, show j + 7 + 3 = j + 10 by omega] at h2
        exact h2
      have a15 : a180970 (j + 15)
          = a180970 (j + 14) + 2 * a180970 (j + 13) + 2 * a180970 (j + 11)
            - a180970 (j + 10) - a180970 (j + 9) := by
        have h3 := rec9 (j + 6)
        rw [show j + 6 + 9 = j + 15 by omega, show j + 6 + 8 = j + 14 by omega,
            show j + 6 + 7 = j + 13 by omega, show j + 6 + 5 = j + 11 by omega,
            show j + 6 + 4 = j + 10 by omega, show j + 6 + 3 = j + 9 by omega] at h3
        exact h3
      have a14 : a180970 (j + 14)
          = a180970 (j + 13) + 2 * a180970 (j + 12) + 2 * a180970 (j + 10)
            - a180970 (j + 9) - a180970 (j + 8) := by
        have h4 := rec9 (j + 5)
        rw [show j + 5 + 9 = j + 14 by omega, show j + 5 + 8 = j + 13 by omega,
            show j + 5 + 7 = j + 12 by omega, show j + 5 + 5 = j + 10 by omega,
            show j + 5 + 4 = j + 9 by omega, show j + 5 + 3 = j + 8 by omega] at h4
        exact h4
      have a13 : a180970 (j + 13)
          = a180970 (j + 12) + 2 * a180970 (j + 11) + 2 * a180970 (j + 9)
            - a180970 (j + 8) - a180970 (j + 7) := by
        have h5 := rec9 (j + 4)
        rw [show j + 4 + 9 = j + 13 by omega, show j + 4 + 8 = j + 12 by omega,
            show j + 4 + 7 = j + 11 by omega, show j + 4 + 5 = j + 9 by omega,
            show j + 4 + 4 = j + 8 by omega, show j + 4 + 3 = j + 7 by omega] at h5
        exact h5
      have a12 : a180970 (j + 12)
          = a180970 (j + 11) + 2 * a180970 (j + 10) + 2 * a180970 (j + 8)
            - a180970 (j + 7) - a180970 (j + 6) := by
        have h6 := rec9 (j + 3)
        rw [show j + 3 + 9 = j + 12 by omega, show j + 3 + 8 = j + 11 by omega,
            show j + 3 + 7 = j + 10 by omega, show j + 3 + 5 = j + 8 by omega,
            show j + 3 + 4 = j + 7 by omega, show j + 3 + 3 = j + 6 by omega] at h6
        exact h6
      have a11 : a180970 (j + 11)
          = a180970 (j + 10) + 2 * a180970 (j + 9) + 2 * a180970 (j + 7)
            - a180970 (j + 6) - a180970 (j + 5) := by
        have h7 := rec9 (j + 2)
        rw [show j + 2 + 9 = j + 11 by omega, show j + 2 + 8 = j + 10 by omega,
            show j + 2 + 7 = j + 9 by omega, show j + 2 + 5 = j + 7 by omega,
            show j + 2 + 4 = j + 6 by omega, show j + 2 + 3 = j + 5 by omega] at h7
        exact h7
      have i2 := ih (j + 14) (by omega) (by omega)
      rw [show j + 14 - 1 = j + 13 by omega, show j + 14 - 2 = j + 12 by omega,
          show j + 14 - 3 = j + 11 by omega, show j + 14 - 4 = j + 10 by omega,
          show j + 14 - 5 = j + 9 by omega] at i2
      have i3 := ih (j + 13) (by omega) (by omega)
      rw [show j + 13 - 1 = j + 12 by omega, show j + 13 - 2 = j + 11 by omega,
          show j + 13 - 3 = j + 10 by omega, show j + 13 - 4 = j + 9 by omega,
          show j + 13 - 5 = j + 8 by omega] at i3
      have i4 := ih (j + 12) (by omega) (by omega)
      rw [show j + 12 - 1 = j + 11 by omega, show j + 12 - 2 = j + 10 by omega,
          show j + 12 - 3 = j + 9 by omega, show j + 12 - 4 = j + 8 by omega,
          show j + 12 - 5 = j + 7 by omega] at i4
      have i5 := ih (j + 11) (by omega) (by omega)
      rw [show j + 11 - 1 = j + 10 by omega, show j + 11 - 2 = j + 9 by omega,
          show j + 11 - 3 = j + 8 by omega, show j + 11 - 4 = j + 7 by omega,
          show j + 11 - 5 = j + 6 by omega] at i5
      have i6 := ih (j + 10) (by omega) (by omega)
      rw [show j + 10 - 1 = j + 9 by omega, show j + 10 - 2 = j + 8 by omega,
          show j + 10 - 3 = j + 7 by omega, show j + 10 - 4 = j + 6 by omega,
          show j + 10 - 5 = j + 5 by omega] at i6
      omega
