/-
  AI 生成（dept-formalize 工人，2026-10-06，kimi 端点 anthropic/a6api-main/kimi-k3；宪条 6 标注）
  任务：tasks/20261006-nfact-primorial-square —— x² = n!·n# 完全解集定理（S5 具名问题轨）

  本文件**只含 statement**（proof body 全 `:= by sorry` 占位），不含任何证明。
  NL 原文（任务卡 §一.1 逐字，statement 语义以此为准）：

    记 n# = ∏_{p ≤ n, p prime} p（primorial），ν_p(m) 为素数 p 在 m 中的指数。
    则丢番图方程 x² = n! · n# 在 n ∈ ℕ 中的解恰为 n ∈ {0, 1, 2, 3, 4, 5}
    （对应 x = 1, 1, 2, 6, 12, 60）。

    引理 A（等价估值判据）：对 n ≥ 1，n! · n# 是完全平方 ⟺
      对每个素数 p ≤ n，ν_p(n!) 为奇数。

    引理 B（区间素数引理）：对每个整数 n ≥ 22，存在素数 p 使 n/3 < p ≤ n/2。

  形式化口径（任务卡 §一.2 / C3 已核）：
  - `primorial` 为顶层声明（Mathlib/NumberTheory/Primorial.lean），禁写 `Nat.primorial`；
    `n#` 记法为 local，不可外用，本文件一律写 `primorial n`。
  - 平方谓词用 `IsSquare`（`Nat.isSquare_iff` / `Nat.sqrt_eq_iff` 不在库，禁用）。
  - 主定理取 iff 形态 `IsSquare (n ! * primorial n) ↔ n ≤ 5`（任务卡 §一.2 指定）；
    并列交付存在见证形态（`∃ x, x^2 = ... ↔ n ∈ {0,...,5}`）——ℕ 上 `n ≤ 5` 与
    `n ∈ {0,1,2,3,4,5}` 等价，两形态语义取舍见 faithful.md。
-/
import Mathlib

open Nat

namespace NFactPrimorialSquare

/-- **主定理（完全解集，iff 形态）**：
    `n! · n#` 是完全平方 ⟺ `n ≤ 5`（n : ℕ）。
    ℕ 上 `n ≤ 5 ⟺ n ∈ {0,1,2,3,4,5}`，故此即 NL 主命题「解恰为 n ∈ {0,…,5}」。 -/
theorem isSquare_factorial_mul_primorial_iff (n : ℕ) :
    IsSquare (n ! * primorial n) ↔ n ≤ 5 := by
  sorry

/-- **主定理（存在见证形态，与 iff 形态并列交付）**：
    丢番图方程 `x² = n!·n#` 有解 ⟺ `n ∈ {0,1,2,3,4,5}`。
    与 `isSquare_factorial_mul_primorial_iff` 的语义等价性（经 `isSquare_iff_exists_sq`
    与 ℕ 上 `n ≤ 5 ⟺ n ∈ {0,…,5}`）见 faithful.md。 -/
theorem exists_sq_factorial_mul_primorial_iff (n : ℕ) :
    (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ n ∈ ({0, 1, 2, 3, 4, 5} : Finset ℕ) := by
  sorry

/-- **引理 A（等价估值判据）**：对 `n ≥ 1`，`n! · n#` 是完全平方 ⟺
    对每个素数 `p ≤ n`，`ν_p(n!)` 为奇数。
    （`Nat.factorization m p` 即 ν_p(m)：素数 p 在 m 中的指数。） -/
theorem isSquare_iff_all_factorization_odd (n : ℕ) (hn : 1 ≤ n) :
    IsSquare (n ! * primorial n) ↔
      ∀ p : ℕ, p.Prime → p ≤ n → Odd ((n !).factorization p) := by
  sorry

/-- **引理 B（区间素数引理）**：对每个整数 `n ≥ 22`，存在素数 `p` 使 `n/3 < p ≤ n/2`。
    （`/ `为 ℕ 整除：区间即 `⌊n/3⌋ < p ≤ ⌊n/2⌋`，与 NL 原文的实数区间解读在素数存在性上
    一致——p 为整数，`n/3 < p ⟺ ⌊n/3⌋ < p`，`p ≤ n/2 ⟺ p ≤ ⌊n/2⌋`，详见 faithful.md。） -/
theorem exists_prime_between_div_three_and_div_two (n : ℕ) (hn : 22 ≤ n) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 := by
  sorry

/-- **见证层（主定理 ⟸ 向的显式平方根）**：n = 0..5 各点 `x² = n!·n#`，
    x = 1, 1, 2, 6, 12, 60（与 NL 主命题的对应关系逐点一致）。 -/
theorem witnesses_zero_to_five :
    1 ^ 2 = 0 ! * primorial 0 ∧
    1 ^ 2 = 1 ! * primorial 1 ∧
    2 ^ 2 = 2 ! * primorial 2 ∧
    6 ^ 2 = 3 ! * primorial 3 ∧
    12 ^ 2 = 4 ! * primorial 4 ∧
    60 ^ 2 = 5 ! * primorial 5 := by
  sorry

/-- 辅助 statement（引理 A 路线承重，C8 冒烟件已 0 sorry 落地形态复用）：
    `ν_p(n#) = 1`（素数 `p ≤ n`）。 -/
theorem primorial_factorization_eq_one {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (primorial n).factorization p = 1 := by
  sorry

/-- 辅助 statement：`ν_p(n#) = 0`（素数 `p ≰ n`）。 -/
theorem primorial_factorization_eq_zero {p n : ℕ} (hp : p.Prime) (hpn : ¬ p ≤ n) :
    (primorial n).factorization p = 0 := by
  sorry

/-- 辅助 statement（判据的乘法骨架）：`ν_p(n!·n#) = ν_p(n!) + 1`（素数 `p ≤ n`）。 -/
theorem factorization_factorial_mul_primorial {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (n ! * primorial n).factorization p = (n !).factorization p + 1 := by
  sorry

end NFactPrimorialSquare
