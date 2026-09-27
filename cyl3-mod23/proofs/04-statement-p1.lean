import Mathlib.Data.Int.ModEq

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
  sorry
