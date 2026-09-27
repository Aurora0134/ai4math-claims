import Mathlib.Data.Int.ModEq

/-!
# P1 statement 冻结（候选 03 · edgemid_master）

statement 文本锚定 `tasks/20260926-beian-extselect/candidates/smoke-03/EdgemidSmoke03r3.lean`
的 `edgemid_master` 定理头，逐字一致（名称 / binder / 类型 / 结论均不可改，宪条 2）。
proof body 暂置 sorry（良定义模式允许）；闸门二通过后由军政部只改 proof body。
AI 生成（2026-09-26 形式化部工人）。
-/

/-- P1(首选命题):凡满足六阶线性递推
`c (n+6) = 4 * c (n+5) + 14 * c (n+4) - 10 * c (n+2) + c n` 的整数序列,
模 2 以 6 为周期,且模 2 余数由 `n % 6` 完全决定(整除刻画支)。 -/
theorem edgemid_master (c : ℕ → ℤ)
    (h : ∀ n, c (n+6) = 4 * c (n+5) + 14 * c (n+4) - 10 * c (n+2) + c n) :
    (∀ n, c (n+6) ≡ c n [ZMOD 2]) ∧ (∀ n, c n ≡ c (n % 6) [ZMOD 2]) := by
  sorry
