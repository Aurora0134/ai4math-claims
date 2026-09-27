import Mathlib.Data.Int.ModEq
import Mathlib.Data.Matrix.Mul

/-!
# 03 证明完成稿（候选 03 · edgemid-pipeline · P1+P2）

两定理 statement 头与冻结快照逐字一致（宪条 2）：P1 锚 `formalized/edgemid-p1-statement.lean:12-17`，
P2 锚 `formalized/edgemid-p2-statement.lean:14-22`（两者均锚定
`tasks/20260926-beian-extselect/candidates/smoke-03/EdgemidSmoke03r3.lean` 定理头）。
proof body 逐字取自 smoke r3（P1 :18-39 / P2 :50-63，逐字节一致零改动），
全稿零占位符、无 namespace。imports = 两冻结件 import 面并集。
AI 生成（2026-09-26 军政部工人，dynamic-workflow 子代理）。
-/

/-- P1(首选命题):凡满足六阶线性递推
`c (n+6) = 4 * c (n+5) + 14 * c (n+4) - 10 * c (n+2) + c n` 的整数序列,
模 2 以 6 为周期,且模 2 余数由 `n % 6` 完全决定(整除刻画支)。 -/
theorem edgemid_master (c : ℕ → ℤ)
    (h : ∀ n, c (n+6) = 4 * c (n+5) + 14 * c (n+4) - 10 * c (n+2) + c n) :
    (∀ n, c (n+6) ≡ c n [ZMOD 2]) ∧ (∀ n, c n ≡ c (n % 6) [ZMOD 2]) := by
  have key : ∀ n, c (n+6) ≡ c n [ZMOD 2] := by
    intro n
    refine Int.modEq_iff_dvd.2 ⟨-(2 * c (n+5) + 7 * c (n+4) - 5 * c (n+2)), ?_⟩
    rw [h n]
    ring
  have aux : ∀ k n, c (n + 6 * k) ≡ c n [ZMOD 2] := by
    intro k
    induction k with
    | zero =>
        intro n
        simp only [Nat.mul_zero, Nat.add_zero]
        exact Int.ModEq.refl _
    | succ k ih =>
        intro n
        have e : n + 6 * (k+1) = (n + 6 * k) + 6 := by ring
        rw [e]
        exact (key (n + 6 * k)).trans (ih n)
  refine ⟨key, fun n => ?_⟩
  have step : c (n % 6 + 6 * (n / 6)) ≡ c (n % 6) [ZMOD 2] := aux (n / 6) (n % 6)
  have e : n % 6 + 6 * (n / 6) = n := by omega
  rw [e] at step
  exact step

/-- P2(挑战档扩展):转移矩阵被六阶多项式零化时,其矩阵幂泛函
(含各固定孔位缺陷计数)满足同一递推。 -/
theorem edgemid_matrix_family {T : Matrix (Fin 8) (Fin 8) ℤ}
    (v : Fin 8 → ℤ) (i : Fin 8)
    (hT : T ^ 6 = 4 • T ^ 5 + 14 • T ^ 4 - 10 • T ^ 2 + (1 : Matrix (Fin 8) (Fin 8) ℤ))
    (n : ℕ) :
    (T ^ (n+6)).mulVec v i
      = 4 * (T ^ (n+5)).mulVec v i + 14 * (T ^ (n+4)).mulVec v i
        - 10 * (T ^ (n+2)).mulVec v i + (T ^ n).mulVec v i := by
  have hgen : T ^ (n+6)
      = 4 • T ^ (n+5) + 14 • T ^ (n+4) - 10 • T ^ (n+2) + (T^n : Matrix (Fin 8) (Fin 8) ℤ) := by
    rw [pow_add, hT, Matrix.mul_add, Matrix.mul_sub, Matrix.mul_add,
        mul_smul_comm, mul_smul_comm, mul_smul_comm,
        Matrix.mul_one, ← pow_add, ← pow_add, ← pow_add]
  rw [hgen, Matrix.add_mulVec, Matrix.sub_mulVec, Matrix.add_mulVec,
      Matrix.smul_mulVec, Matrix.smul_mulVec, Matrix.smul_mulVec]
  first
  | rfl
  | simp only [smul_eq_mul]
  | simp [smul_eq_mul]
  | norm_num
  | push_cast <;> rfl
  | lia
