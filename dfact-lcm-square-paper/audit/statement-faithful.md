# Informal-to-formal correspondence table

English cleaned edition of the source task's faithfulness record. Conclusions,
mappings and data are unchanged; only the wording is English.

## 1. Object mapping

| informal concept | Lean object | basis |
|---|---|---|
| double factorial `n!!` (product of the integers of the same parity as `n`; empty product `0!! = 1`) | `Nat.doubleFactorial n`, notation `n‼` | Mathlib `Data/Nat/Factorial/DoubleFactorial.lean`; `0!! = 1` matches the standard convention |
| `lcm(1..n)` (least common multiple of `1` to `n`; empty lcm `= 1` at `n = 0`) | `Nat.lcmUpto n` | Mathlib `NumberTheory/Chebyshev.lean:212`, `lcmUpto n = (Icc 1 n).lcm id`; `Icc 1 0 = ∅` and `lcm ∅ = 1`, matching the empty-product convention |
| perfect square | `IsSquare` | mathlib's standard predicate (`isSquare_iff_exists_sq : IsSquare a ↔ ∃ r, a = r ^ 2`) |
| `ν_p(m)` (the exponent of the prime `p` in `m`) | `Nat.factorization m p` | mathlib standard (Finsupp value) |
| `⌊log_p n⌋` (the largest `k` with `p^k ≤ n`) | `Nat.log p n` | mathlib standard |
| membership in the solution set `n ∈ {0,1,2,5,7}` | the disjunction chain `n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 5 ∨ n = 7` | same shape as the smoke-test base version; equivalent to `Finset` membership on `ℕ` (`Finset.mem_insert` chain) |
| the equation's solution roots `x = 1,1,2,30,210` | the witness layer `1 ^ 2 = 0‼ * lcmUpto 0 ∧ …` | explicit square-root equalities; the correspondence `x = n#` (primorial) — `1 = 0# = 1#`, `2 = 2#`, `30 = 5#`, `210 = 7#` — is an informal-level observation and does not enter the statement |

## 2. Statement-by-statement correspondence

| # | informal (verbatim from the candidate card) | Lean (verbatim from the frozen snapshot) | faithfulness note |
|---|---|---|---|
| main theorem | "for `n ∈ ℕ`, `n‼·lcmUpto n` is a perfect square ⟺ `n ∈ {0,1,2,5,7}`" | `dfact_lcm_square_solution_set (n : ℕ) : IsSquare (n‼ * Nat.lcmUpto n) ↔ n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 5 ∨ n = 7` | the iff corresponds term by term; `n ∈ ℕ` is `(n : ℕ)`; the solution set is written as a disjunction chain |
| lemma A′ | "lemma A′ (parity criterion iff)" i.e. "square ⟺ for every prime `p` the total exponent `ν_p(n‼) + ⌊log_p n⌋` is even" | `isSquare_dfact_mul_lcmUpto_iff (n : ℕ) : IsSquare (n‼ * Nat.lcmUpto n) ↔ ∀ p : ℕ, p.Prime → Even ((n‼).factorization p + p.log n)` | "for every prime `p`" = `∀ p, p.Prime →`; "all even" = `Even`; the total exponent splits via the factorization product law and `Nat.factorization_lcmUpto` (which is `p.log n`) added term by term |
| witness layer | "the solution roots are exactly `x = n#` (= 1,1,2,30,210)", as square-equality content | `dfact_lcm_witnesses : 1 ^ 2 = 0‼ * Nat.lcmUpto 0 ∧ 1 ^ 2 = 1‼ * Nat.lcmUpto 1 ∧ 2 ^ 2 = 2‼ * Nat.lcmUpto 2 ∧ 30 ^ 2 = 5‼ * Nat.lcmUpto 5 ∧ 210 ^ 2 = 7‼ * Nat.lcmUpto 7` | a five-fold conjunction of pointwise equalities; "exactly `n#`" is an accompanying informal observation; the statement carries only the square-root equalities |
| lemma B′ (accompanying, not in this freeze set) | "for all `n ≥ 33`, the interval `(n/4, n/3]` contains a prime" | `exists_prime_between_quarter_and_third (n : ℕ) (hn : 33 ≤ n) : ∃ p, p.Prime ∧ n / 4 < p ∧ p ≤ n / 3` (proved in the accompanying library) | on `ℕ` the division is exact: `n/4 < p ⟺ ⌊n/4⌋ < p` and `p ≤ n/3 ⟺ p ≤ ⌊n/3⌋`; for the existence of a prime this matches the real-interval reading (since `p` is an integer) |
| accompanying corollary (not in the freeze set) | "square ⟹ the `x = n#` shape" | not formalized | listed as an accompanying observation in the candidate card and not included in the freeze set; the report level words it as an informal observation |

## 3. Semantic trade-offs

1. **Solution-set expression**: the disjunction chain `n = 0 ∨ … ∨ n = 7` versus
   `n ∈ ({0,1,2,5,7} : Finset ℕ)` — the former is used (same shape as the
   smoke-test base version; the anchor item's existential form uses the latter as
   a parallel deliverable, and the two forms interconvert via the
   `Finset.mem_insert` simp chain).
2. **The `n = 0` boundary**: `0‼ = 1` and `lcmUpto 0 = 1` (empty-product /
   empty-lcm conventions), so the product is `1 = 1²`, a square, consistent with
   the candidate card's solution set containing `0`. The difference from
   literature phrasings that start at `n ≥ 1` does not affect the statement
   itself (`0` is a trivial solution both sides accept).
3. **Interval endpoints** (lemma B′ on the consuming side): the exact-division
   semantics on `ℕ` and the real-interval semantics are equivalent for the
   existence of a prime (see the B′ row above), handled the same way as the
   anchor item's `exists_prime_between_div_three_and_div_two`.
