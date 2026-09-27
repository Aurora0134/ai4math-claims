import Mathlib.Data.Int.ModEq
import Mathlib.Data.Matrix.Mul

/-!
# 04-proof-complete（军政部 r1）

两定理定理头与 tasks/20260926-cyl3-pipeline/formalized/04-statement-p{1,2}.lean
冻结文本逐字一致；本文件只写 proof body。AI 生成（dept-04-prove，
node=anthropic/a6api-main/kimi-k3），kernel 实编裁决为准。

- P1 路线（03 同型 r2 实证形态）：Int.modEq_iff_dvd 显式 dvd 证人 + ring；
  模 2 由 `c (n+4) ≡ c (n+2) + c n` 在 n 与 n+2 两处展开后 add_right/trans 收束；
  模 3 反周期一步证人（6、9 被 3 整除）。
- P2 路线（EdgemidSmoke03r3.lean edgemid_matrix_family 同型临摹，系数 6,9,−1）：
  hgen = pow_add + hT + Matrix.mul_sub/mul_add + mul_smul_comm×2 + Matrix.mul_one
  + ← pow_add×2；mulVec 线性 = Matrix.sub_mulVec/add_mulVec + smul_mulVec×2；
  收尾 first | rfl | simp only [smul_eq_mul] | …（03 r3 已编译验证）。
-/

/-- P1（`cyl3_master`，修正档=稳妥）：任一满足四阶线性递推
`c (n+4) = 6 * c (n+3) + 9 * c (n+2) - c n` 的整数序列，
模 2 以 6 为周期，且模 3 有反周期 `c (n+4) ≡ -c n [ZMOD 3]`
（推论：`3 ∣ c n ⟺ 3 ∣ c (n % 4)` 型整除刻画与基线奇偶模式）。
人话语义：带缺陷圆柱格 C₃×Pₙ（3×n，三种固定孔位）匹配计数族的
统一同余律——无孔基线（OEIS A033515）与同行相邻/对角/三角三种
三孔缺陷序列同满足递推 (6,9,0,−1)，本定理对该递推整族一次覆盖。
题源：tasks/20260926-beian-select/candidates/04-cylinder-3holes-review.md（收窄命题 P1）。 -/
theorem cyl3_master (c : ℕ → ℤ)
    (h : ∀ n, c (n+4) = 6 * c (n+3) + 9 * c (n+2) - c n) :
    (∀ n, c (n+6) ≡ c n [ZMOD 2]) ∧ (∀ n, c (n+4) ≡ -c n [ZMOD 3]) := by
  have key : ∀ m, c (m+4) ≡ c (m+2) + c m [ZMOD 2] := by
    intro m
    refine Int.modEq_iff_dvd.2 ⟨-(3 * c (m+3) + 4 * c (m+2) - c m), ?_⟩
    rw [h m]
    ring
  refine ⟨fun n => ?_, fun n => ?_⟩
  · have h1 : c (n+4) ≡ c (n+2) + c n [ZMOD 2] := key n
    have h2 : c (n+6) ≡ c (n+4) + c (n+2) [ZMOD 2] := key (n+2)
    have h3 : c (n+6) ≡ (c (n+2) + c n) + c (n+2) [ZMOD 2] := h2.trans (h1.add_right _)
    exact h3.trans (Int.modEq_iff_dvd.2 ⟨-c (n+2), by ring⟩)
  · refine Int.modEq_iff_dvd.2 ⟨-(2 * c (n+3) + 3 * c (n+2)), ?_⟩
    rw [h n]
    ring

/-- P2（`cyl3_matrix_family`，挑战档）：8×8 整数转移矩阵 `T` 一旦被
四次多项式零化（`T ^ 4 = 6 • T ^ 3 + 9 • T ^ 2 - 1`），其任意矩阵幂
泛函 `(T ^ (n+k)).mulVec v i` 都满足同一个四阶递推
`a (n+4) = 6 * a (n+3) + 9 * a (n+2) - a n`——一条引理统一三种
固定孔位缺陷计数在转移矩阵层的共有结构（矩阵泛函层统一递推定理）。
人话语义：这是转移矩阵法（Lundow 1996/1998 口径）的泛函形式化；
「该矩阵确实等于缺陷匹配计数」的组合语义桥不进 kernel，
论文/报告层按主张降级如实声明，不得拔高为计数本体定理。
题源：tasks/20260926-beian-select/candidates/04-cylinder-3holes-review.md（收窄命题 P2）。 -/
theorem cyl3_matrix_family {T : Matrix (Fin 8) (Fin 8) ℤ}
    (v : Fin 8 → ℤ) (i : Fin 8)
    (hT : T ^ 4 = 6 • T ^ 3 + 9 • T ^ 2 - (1 : Matrix (Fin 8) (Fin 8) ℤ))
    (n : ℕ) :
    (T ^ (n+4)).mulVec v i
      = 6 * (T ^ (n+3)).mulVec v i + 9 * (T ^ (n+2)).mulVec v i - (T ^ n).mulVec v i := by
  have hgen : T ^ (n+4)
      = 6 • T ^ (n+3) + 9 • T ^ (n+2) - (T^n : Matrix (Fin 8) (Fin 8) ℤ) := by
    rw [pow_add, hT, Matrix.mul_sub, Matrix.mul_add,
        mul_smul_comm, mul_smul_comm,
        Matrix.mul_one, ← pow_add, ← pow_add]
  -- 收尾：rw 自带 rfl 不足以穿透 Pi 逐点作用（r2 实测 unsolved goals），
  -- 显式 `rfl` tactic 以全 defeq 收官（r1 级联实测首支即中，故仅留此一支）。
  rw [hgen, Matrix.sub_mulVec, Matrix.add_mulVec,
      Matrix.smul_mulVec, Matrix.smul_mulVec]
  rfl
