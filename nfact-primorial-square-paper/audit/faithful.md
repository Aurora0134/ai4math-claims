# Roundtrip faithfulness record — nfact-primorial-square

- Statement file: the source task's `formalized/nfact-primorial-square.lean`
  (8 statements, all proof bodies `:= by sorry` placeholders); source task
  records are held in the source repository and are not shipped.
- Judge prompt and judge reply: recorded verbatim in the source task
  (`formalized/roundtrip-prompt.md` / `formalized/roundtrip-reply.md`,
  not shipped).
- Well-definedness compile (kernel): the repository's Lean verification
  script in `--allow-sorry` mode, **exit 0** (0 errors; the 8 sorry warnings
  are the placeholders, as expected). **Compiling is not faithfulness** —
  faithfulness is adjudicated by the roundtrip record in this file.

> **2026-10-07 version note.** Translated to English and cleaned of internal
> references for publication; all technical content and conclusions
> unchanged.

## 1. Statement inventory and back-translations (generator's own)

Numbering follows the `.lean` file:

| # | Lean declaration | back-translation NL′ |
|---|---|---|
| S1 | `isSquare_factorial_mul_primorial_iff (n : ℕ) : IsSquare (n ! * primorial n) ↔ n ≤ 5` | For every natural number n, "n!·n# is a perfect square" if and only if "n ≤ 5". |
| S2 | `exists_sq_factorial_mul_primorial_iff (n : ℕ) : (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ n ∈ ({0,1,2,3,4,5} : Finset ℕ)` | For every natural number n, "there exists a natural number x with x² = n!·n#" if and only if "n ∈ {0,1,2,3,4,5}". |
| S3 | `isSquare_iff_all_factorization_odd (n : ℕ) (hn : 1 ≤ n) : IsSquare (n ! * primorial n) ↔ ∀ p : ℕ, p.Prime → p ≤ n → Odd ((n !).factorization p)` | For every natural number n ≥ 1, "n!·n# is a perfect square" if and only if "for every prime p ≤ n, ν_p(n!) is odd". |
| S4 | `exists_prime_between_div_three_and_div_two (n : ℕ) (hn : 22 ≤ n) : ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2` | For every integer n ≥ 22, there is a prime p with ⌊n/3⌋ < p ≤ ⌊n/2⌋. |
| S5 | `witnesses_zero_to_five : 1^2 = 0!*primorial 0 ∧ … ∧ 60^2 = 5!*primorial 5` | The six equalities 1²=0!·0#, 1²=1!·1#, 2²=2!·2#, 6²=3!·3#, 12²=4!·4#, 60²=5!·5# hold simultaneously (the witnesses x=1,1,2,6,12,60 for n=0..5). |
| S6 | `primorial_factorization_eq_one {p n} (hp : p.Prime) (hpn : p ≤ n) : (primorial n).factorization p = 1` | For a prime p ≤ n, ν_p(n#) = 1. |
| S7 | `primorial_factorization_eq_zero {p n} (hp : p.Prime) (hpn : ¬ p ≤ n) : (primorial n).factorization p = 0` | For a prime p > n, ν_p(n#) = 0. |
| S8 | `factorization_factorial_mul_primorial {p n} (hp : p.Prime) (hpn : p ≤ n) : (n ! * primorial n).factorization p = (n !).factorization p + 1` | For a prime p ≤ n, ν_p(n!·n#) = ν_p(n!) + 1. |

## 2. Reasons for the form choices (both forms delivered + equivalence noted)

1. **Why the main theorem is delivered in two forms**: the source task fixed
   the iff form `IsSquare (n ! * primorial n) ↔ n ≤ 5` (S1); the NL wording
   "the solutions of the Diophantine equation x² = n!·n# are exactly
   n ∈ {0,…,5}" is closer to the existence form (S2). The two are delivered
   side by side; neither replaces the other.
2. **Over ℕ, `n ≤ 5 ⟺ n ∈ {0,1,2,3,4,5}`**: ℕ here includes 0 (the mathlib
   convention), so `n ≤ 5` and `n ∈ {0,1,2,3,4,5}` are pointwise
   equivalent — the right-hand sides of S1 and S2 have the same semantics.
3. **`IsSquare a ⟺ ∃ x, x² = a`**: mathlib defines `IsSquare a := ∃ r, a = r * r`
   (Mathlib/Algebra/Group/Even.lean:57), and `isSquare_iff_exists_sq` (same
   file, :130) gives `∃ r, a = r ^ 2`; the equation directions `a = r^2` and
   S2's `x^2 = a` are equivalent by symmetry — the left-hand sides of S1 and
   S2 have the same semantics.
4. **Where "with x = 1,1,2,6,12,60" lands**: carried by the witness layer S5
   (for fixed n, x² = m has at most one solution in ℕ, so pointwise witnesses
   fully express the correspondence; the judge's coverage ruling agreed).
5. **The natural-division reading of Lemma B's interval**: in Lean, `n / 3`
   and `n / 2` are natural-number division. For integer p one always has
   "n/3 < p (real reading) ⟺ ⌊n/3⌋ < p" and "p ≤ n/2 (real reading) ⟺
   p ≤ ⌊n/2⌋", so S4 has the same prime-existence semantics as the NL Lemma B
   (this equivalence is written into S4's docstring and was part of the
   judge's background agreement).
6. **The auxiliary statements (S6–S8)**: not given verbatim in the NL
   original; they are route-support items permitted by the tasking (their
   shapes reuse a smoke-tested trio that had already compiled with 0 sorry),
   supporting Lemma A's proof route without changing the semantics of the
   main proposition, Lemma A, or Lemma B.

## 3. Judge call and ruling (roundtrip)

- **Judge channel**: a read-only adjudicator subagent on the session's model
  node (model node kimi-k3; isolated context, ruling returned for the
  record) — same-node self-judging, whose independence risk is hedged by the
  kernel as final arbiter plus human spot checks, per the model-call rules.
- **Mechanism-drift note (recorded honestly)**: the judge-invocation
  mechanism originally named in the tasking had been retired that same day;
  three same-parameter attempts at it returned HTTP 502 (upstream fault;
  stderr recorded in the source task, calls at about 2026-10-06
  01:47–01:52 +0800). The judging was then re-dispatched as a read-only
  adjudicator subagent under the rules in force; the node did not change
  (the subagent inherits the endpoint's default model = the session node),
  satisfying the no-cross-node rule.
- **Ruling**: every item S1–S8 judged "consistent"; coverage of the main
  proposition / Lemma A / Lemma B all judged "covered"; **overall verdict:
  consistent**. The full reply is in the source task records (not shipped).
- **Changes made for inconsistency**: none (the judge found no
  inconsistency; no statement changed because of the roundtrip).

## 4. Citation-wording duties checked (the parts applying to this document)

1. The must-cite duties for 2606.23485 §5.3.1 and 2610.01899: this document
   is not a related-work section, so they do not apply here; they bind
   downstream (paper/claim package).
2. erdosproblems #399 not used as an open anchor: this document does not
   cite #399 ✓.
3. The restricted wording "2602.09687's object of study does not contain n#":
   this document does not cite that paper ✓.
4. The failure set `{2,3,9,21}` of the interval property carries the domain
   convention **n ≥ 2** (n = 0, 1 also fail, on an empty interval): this
   document does not list the failure set; the convention is noted here as a
   duty for downstream citations ✓.
5. The A055204 (squarefree part of n!) distinction duty (minimal a vs the
   specific value a = n#): this document does not cite A055204; it is
   declared here as a duty: this proposition asks for the complete solution
   set for the specific value `a = n#` making `n!·a` a square, and is **not**
   an instance of A055204's minimal-cofactor problem ✓.
