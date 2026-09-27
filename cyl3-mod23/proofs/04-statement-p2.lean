import Mathlib.Data.Int.ModEq
import Mathlib.Data.Matrix.Mul

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
  sorry
