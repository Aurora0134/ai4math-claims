/-
  Frozen statements of record: the complete solution set of
  x^2 = n! * n# (factorial times primorial) over ℕ — the solutions are
  exactly n ∈ {0, 1, 2, 3, 4, 5} (with x = 1, 1, 2, 6, 12, 60).

  This file contains the eight frozen statements only; every proof body is
  a `sorry` placeholder by design: the file records the frozen claims, and
  the proofs live in `final-nfact-primorial-square.lean` (this directory).

  Notation: `primorial` is the top-level mathlib declaration (the primorial
  n# = product of the primes p ≤ n); `IsSquare` is the square predicate;
  `Nat.factorization m p` is ν_p(m), the exponent of the prime p in m.
  The two main-theorem forms are semantically equivalent over ℕ
  (`n ≤ 5 ⟺ n ∈ {0,...,5}`, via `isSquare_iff_exists_sq`).

  Contents: main theorem (iff form), main theorem (existence-witness
  form), Lemma A (valuation criterion), Lemma B (interval prime lemma),
  the six-point witness layer, and three auxiliary factorization
  statements.
-/
import Mathlib

open Nat

namespace NFactPrimorialSquare

/-- **Main theorem (complete solution set, iff form)**:
    `n! * n#` is a perfect square ⟺ `n ≤ 5` (for `n : ℕ`).
    Over ℕ, `n ≤ 5 ⟺ n ∈ {0,1,2,3,4,5}`, so this is the main statement "the solutions are exactly n ∈ {0,...,5}". -/
theorem isSquare_factorial_mul_primorial_iff (n : ℕ) :
    IsSquare (n ! * primorial n) ↔ n ≤ 5 := by
  sorry

/-- **Main theorem (existence-witness form, delivered alongside the iff form)**:
    the Diophantine equation `x² = n! * n#` has a solution ⟺ `n ∈ {0,1,2,3,4,5}`.
    The semantic equivalence with `isSquare_factorial_mul_primorial_iff` (via `isSquare_iff_exists_sq`
    and `n ≤ 5 ⟺ n ∈ {0,...,5}` over ℕ) is recorded in the faithfulness record. -/
theorem exists_sq_factorial_mul_primorial_iff (n : ℕ) :
    (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ n ∈ ({0, 1, 2, 3, 4, 5} : Finset ℕ) := by
  sorry

/-- **Lemma A (equivalent valuation criterion)**: for `n ≥ 1`, `n! * n#` is a perfect square ⟺
    `ν_p(n!)` is odd for every prime `p ≤ n`.
    (`Nat.factorization m p` is ν_p(m): the exponent of the prime `p` in `m`.) -/
theorem isSquare_iff_all_factorization_odd (n : ℕ) (hn : 1 ≤ n) :
    IsSquare (n ! * primorial n) ↔
      ∀ p : ℕ, p.Prime → p ≤ n → Odd ((n !).factorization p) := by
  sorry

/-- **Lemma B (interval prime lemma)**: for every integer `n ≥ 22` there exists a prime `p` with `n/3 < p ≤ n/2`.
    (`/` is natural-number division: the interval reads `⌊n/3⌋ < p ≤ ⌊n/2⌋`; for prime existence this coincides
    with the real reading, since `p` is an integer: `n/3 < p ⟺ ⌊n/3⌋ < p` and `p ≤ n/2 ⟺ p ≤ ⌊n/2⌋`.) -/
theorem exists_prime_between_div_three_and_div_two (n : ℕ) (hn : 22 ≤ n) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 := by
  sorry

/-- **Witness layer (explicit square roots for the ⟸ direction of the main theorem)**: `x² = n! * n#`
    at each of n = 0..5, with x = 1, 1, 2, 6, 12, 60 (the pointwise correspondence of the main statement). -/
theorem witnesses_zero_to_five :
    1 ^ 2 = 0 ! * primorial 0 ∧
    1 ^ 2 = 1 ! * primorial 1 ∧
    2 ^ 2 = 2 ! * primorial 2 ∧
    6 ^ 2 = 3 ! * primorial 3 ∧
    12 ^ 2 = 4 ! * primorial 4 ∧
    60 ^ 2 = 5 ! * primorial 5 := by
  sorry

/-- Auxiliary statement (load-bearing for the Lemma A route):
    `ν_p(n#) = 1` for primes `p ≤ n`. -/
theorem primorial_factorization_eq_one {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (primorial n).factorization p = 1 := by
  sorry

/-- Auxiliary statement: `ν_p(n#) = 0` for primes `p ≰ n`. -/
theorem primorial_factorization_eq_zero {p n : ℕ} (hp : p.Prime) (hpn : ¬ p ≤ n) :
    (primorial n).factorization p = 0 := by
  sorry

/-- Auxiliary statement (the multiplicative skeleton of the criterion): `ν_p(n! * n#) = ν_p(n!) + 1` for primes `p ≤ n`. -/
theorem factorization_factorial_mul_primorial {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (n ! * primorial n).factorization p = (n !).factorization p + 1 := by
  sorry

end NFactPrimorialSquare
