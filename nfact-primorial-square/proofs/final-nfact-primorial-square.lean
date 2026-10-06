/-
  AI 生成（assemble-main 塔台工人 M5，2026-10-06，kimi 端点 anthropic/a6api-main/kimi-k3；宪条 6 标注）
  M5 终态件：x² = n!·n# 完全解集定理 —— 主定理组装，单文件含全部 8 条冻结 statement
  （statement 文本逐字 = formalized/nfact-primorial-square.statement.txt，宪条 2，仅写 proof body）
  与全部支撑件，proof 全闭合、零占位。

  组件来源（均为塔台 kernel 复验过的 merged 组件，逐字照抄）：
  - namespace NFactPrimorialSquareChain 段 = attempts/lemma-b/lemma-b.lean 前段
    （M11 证书链截链 lemmaB_upto_999999 + M9 尾巴 lemmaB_tail_1000000 + 单跳件 lemmaB_hop；
    塔台组装复验记录 attempts/lemma-b/tower-reverify.md）。
  - namespace NFactPrimorialSquare 内：
    引理 A 与三辅助（辅助三件在前、引理 A 在后，保持 final-lemma-a.lean 依赖序）
      = attempts/lemma-a/final-lemma-a.lean（M2）；
    见证层 witnesses_zero_to_five + 桥 not_isSquare_of_odd_factorization
      + 16 条 nonsquare_at_<n> + 组装件 nonsquare_six_to_twenty_one
      = attempts/witnesses/witness-layer.lean（M4）；
    引理 B exists_prime_between_div_three_and_div_two = attempts/lemma-b/lemma-b.lean 末段（M3）。
  - 本批新写 proof 仅两条主定理：
    ① isSquare_factorial_mul_primorial_iff —— ⟸ 向 n ≤ 5 经 interval_cases 六点配 witnesses_zero_to_five
       与 isSquare_iff_exists_sq 给显式平方根；⟹ 向 by_contra 得 6 ≤ n，6 ≤ n ≤ 21 段引用
       nonsquare_six_to_twenty_one 直接矛盾，22 ≤ n 段经引理 B 取素数 p ∈ (n/3, n/2]，
       引理 A 判据给出 Odd (ν_p(n!))，而 Legendre 和式（Nat.factorization_factorial，b = 2，
       由 p² > n 经 Nat.log_lt_of_lt_pow 得 Nat.log p n < 2）算出 ν_p(n!) = ⌊n/p⌋ = 2（2p ≤ n < 3p），
       Odd 2 矛盾（omega 拆穿）。
    ② exists_sq_factorial_mul_primorial_iff —— 经 isSquare_iff_exists_sq 桥到 ①，
       再 n ≤ 5 ⟺ n ∈ ({0,…,5} : Finset ℕ)（simp 展开成员 + omega）。
-/
import Mathlib

open Nat Finset

set_option maxRecDepth 8192
set_option maxHeartbeats 2000000

namespace NFactPrimorialSquareChain

theorem prime_cert_11 : Nat.Prime 11 := by norm_num
theorem prime_cert_13 : Nat.Prime 13 := by norm_num
theorem prime_cert_19 : Nat.Prime 19 := by norm_num
theorem prime_cert_23 : Nat.Prime 23 := by norm_num
theorem prime_cert_31 : Nat.Prime 31 := by norm_num
theorem prime_cert_43 : Nat.Prime 43 := by norm_num
theorem prime_cert_61 : Nat.Prime 61 := by norm_num
theorem prime_cert_89 : Nat.Prime 89 := by norm_num
theorem prime_cert_131 : Nat.Prime 131 := by norm_num
theorem prime_cert_193 : Nat.Prime 193 := by norm_num
theorem prime_cert_283 : Nat.Prime 283 := by norm_num
theorem prime_cert_421 : Nat.Prime 421 := by norm_num
theorem prime_cert_631 : Nat.Prime 631 := by norm_num
theorem prime_cert_941 : Nat.Prime 941 := by norm_num
theorem prime_cert_1409 : Nat.Prime 1409 := by norm_num
theorem prime_cert_2113 : Nat.Prime 2113 := by norm_num
theorem prime_cert_3169 : Nat.Prime 3169 := by norm_num
theorem prime_cert_4751 : Nat.Prime 4751 := by norm_num
theorem prime_cert_7121 : Nat.Prime 7121 := by norm_num
theorem prime_cert_10667 : Nat.Prime 10667 := by norm_num
theorem prime_cert_15991 : Nat.Prime 15991 := by norm_num
theorem prime_cert_23981 : Nat.Prime 23981 := by norm_num
theorem prime_cert_35969 : Nat.Prime 35969 := by norm_num
theorem prime_cert_53951 : Nat.Prime 53951 := by norm_num
theorem prime_cert_80923 : Nat.Prime 80923 := by norm_num
theorem prime_cert_121379 : Nat.Prime 121379 := by norm_num
theorem prime_cert_182059 : Nat.Prime 182059 := by norm_num
theorem prime_cert_273083 : Nat.Prime 273083 := by norm_num
theorem prime_cert_409609 : Nat.Prime 409609 := by norm_num

theorem cont_cert_13 : 2 * 13 ≤ 3 * 11 := by omega
theorem cont_cert_19 : 2 * 19 ≤ 3 * 13 := by omega
theorem cont_cert_23 : 2 * 23 ≤ 3 * 19 := by omega
theorem cont_cert_31 : 2 * 31 ≤ 3 * 23 := by omega
theorem cont_cert_43 : 2 * 43 ≤ 3 * 31 := by omega
theorem cont_cert_61 : 2 * 61 ≤ 3 * 43 := by omega
theorem cont_cert_89 : 2 * 89 ≤ 3 * 61 := by omega
theorem cont_cert_131 : 2 * 131 ≤ 3 * 89 := by omega
theorem cont_cert_193 : 2 * 193 ≤ 3 * 131 := by omega
theorem cont_cert_283 : 2 * 283 ≤ 3 * 193 := by omega
theorem cont_cert_421 : 2 * 421 ≤ 3 * 283 := by omega
theorem cont_cert_631 : 2 * 631 ≤ 3 * 421 := by omega
theorem cont_cert_941 : 2 * 941 ≤ 3 * 631 := by omega
theorem cont_cert_1409 : 2 * 1409 ≤ 3 * 941 := by omega
theorem cont_cert_2113 : 2 * 2113 ≤ 3 * 1409 := by omega
theorem cont_cert_3169 : 2 * 3169 ≤ 3 * 2113 := by omega
theorem cont_cert_4751 : 2 * 4751 ≤ 3 * 3169 := by omega
theorem cont_cert_7121 : 2 * 7121 ≤ 3 * 4751 := by omega
theorem cont_cert_10667 : 2 * 10667 ≤ 3 * 7121 := by omega
theorem cont_cert_15991 : 2 * 15991 ≤ 3 * 10667 := by omega
theorem cont_cert_23981 : 2 * 23981 ≤ 3 * 15991 := by omega
theorem cont_cert_35969 : 2 * 35969 ≤ 3 * 23981 := by omega
theorem cont_cert_53951 : 2 * 53951 ≤ 3 * 35969 := by omega
theorem cont_cert_80923 : 2 * 80923 ≤ 3 * 53951 := by omega
theorem cont_cert_121379 : 2 * 121379 ≤ 3 * 80923 := by omega
theorem cont_cert_182059 : 2 * 182059 ≤ 3 * 121379 := by omega
theorem cont_cert_273083 : 2 * 273083 ≤ 3 * 182059 := by omega
theorem cont_cert_409609 : 2 * 409609 ≤ 3 * 273083 := by omega

theorem chain_start : 22 = 2 * 11 := by omega
theorem chain_end : 999999 ≤ 3 * 409609 - 1 := by omega

/-- 证书链单跳件（M3 报告 §三.2 kernel 实证件，逐字复用）：
    q 为素数且 n ∈ [2q, 3q−1] 时，q 即见证 n/3 < q ≤ n/2。
    注：必须先抽 `hq.two_le`，否则 ℕ 截断减法下 omega 在 q = 0 反例处卡死（M3 实测）。 -/
theorem lemmaB_hop {q : ℕ} (hq : q.Prime) {n : ℕ} (h1 : 2 * q ≤ n) (h2 : n ≤ 3 * q - 1) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 :=
  have hq2 : 2 ≤ q := hq.two_le
  ⟨q, hq, by omega, by omega⟩

/-- **引理 B 有限段（证书链决策树）**：∀ n ∈ [22, 999999]，
    ∃ p, p.Prime ∧ n/3 < p ∧ p ≤ n/2。
    与尾巴定理（A1/A2 路，起点 N0 = 1000000）的衔接口径见 M11 交接报告。 -/
theorem lemmaB_upto_999999 (n : ℕ) (h1 : 22 ≤ n) (h2 : n ≤ 999999) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 := by
  rcases lt_or_ge n 33 with h | h
  · exact lemmaB_hop (q := 11) prime_cert_11 (by omega) (by omega)
  · rcases lt_or_ge n 39 with h | h
    · exact lemmaB_hop (q := 13) prime_cert_13 (by omega) (by omega)
    · rcases lt_or_ge n 57 with h | h
      · exact lemmaB_hop (q := 19) prime_cert_19 (by omega) (by omega)
      · rcases lt_or_ge n 69 with h | h
        · exact lemmaB_hop (q := 23) prime_cert_23 (by omega) (by omega)
        · rcases lt_or_ge n 93 with h | h
          · exact lemmaB_hop (q := 31) prime_cert_31 (by omega) (by omega)
          · rcases lt_or_ge n 129 with h | h
            · exact lemmaB_hop (q := 43) prime_cert_43 (by omega) (by omega)
            · rcases lt_or_ge n 183 with h | h
              · exact lemmaB_hop (q := 61) prime_cert_61 (by omega) (by omega)
              · rcases lt_or_ge n 267 with h | h
                · exact lemmaB_hop (q := 89) prime_cert_89 (by omega) (by omega)
                · rcases lt_or_ge n 393 with h | h
                  · exact lemmaB_hop (q := 131) prime_cert_131 (by omega) (by omega)
                  · rcases lt_or_ge n 579 with h | h
                    · exact lemmaB_hop (q := 193) prime_cert_193 (by omega) (by omega)
                    · rcases lt_or_ge n 849 with h | h
                      · exact lemmaB_hop (q := 283) prime_cert_283 (by omega) (by omega)
                      · rcases lt_or_ge n 1263 with h | h
                        · exact lemmaB_hop (q := 421) prime_cert_421 (by omega) (by omega)
                        · rcases lt_or_ge n 1893 with h | h
                          · exact lemmaB_hop (q := 631) prime_cert_631 (by omega) (by omega)
                          · rcases lt_or_ge n 2823 with h | h
                            · exact lemmaB_hop (q := 941) prime_cert_941 (by omega) (by omega)
                            · rcases lt_or_ge n 4227 with h | h
                              · exact lemmaB_hop (q := 1409) prime_cert_1409 (by omega) (by omega)
                              · rcases lt_or_ge n 6339 with h | h
                                · exact lemmaB_hop (q := 2113) prime_cert_2113 (by omega) (by omega)
                                · rcases lt_or_ge n 9507 with h | h
                                  · exact lemmaB_hop (q := 3169) prime_cert_3169 (by omega) (by omega)
                                  · rcases lt_or_ge n 14253 with h | h
                                    · exact lemmaB_hop (q := 4751) prime_cert_4751 (by omega) (by omega)
                                    · rcases lt_or_ge n 21363 with h | h
                                      · exact lemmaB_hop (q := 7121) prime_cert_7121 (by omega) (by omega)
                                      · rcases lt_or_ge n 32001 with h | h
                                        · exact lemmaB_hop (q := 10667) prime_cert_10667 (by omega) (by omega)
                                        · rcases lt_or_ge n 47973 with h | h
                                          · exact lemmaB_hop (q := 15991) prime_cert_15991 (by omega) (by omega)
                                          · rcases lt_or_ge n 71943 with h | h
                                            · exact lemmaB_hop (q := 23981) prime_cert_23981 (by omega) (by omega)
                                            · rcases lt_or_ge n 107907 with h | h
                                              · exact lemmaB_hop (q := 35969) prime_cert_35969 (by omega) (by omega)
                                              · rcases lt_or_ge n 161853 with h | h
                                                · exact lemmaB_hop (q := 53951) prime_cert_53951 (by omega) (by omega)
                                                · rcases lt_or_ge n 242769 with h | h
                                                  · exact lemmaB_hop (q := 80923) prime_cert_80923 (by omega) (by omega)
                                                  · rcases lt_or_ge n 364137 with h | h
                                                    · exact lemmaB_hop (q := 121379) prime_cert_121379 (by omega) (by omega)
                                                    · rcases lt_or_ge n 546177 with h | h
                                                      · exact lemmaB_hop (q := 182059) prime_cert_182059 (by omega) (by omega)
                                                      · rcases lt_or_ge n 819249 with h | h
                                                        · exact lemmaB_hop (q := 273083) prime_cert_273083 (by omega) (by omega)
                                                        · exact lemmaB_hop (q := 409609) prime_cert_409609 (by omega) (by omega)

/-- 每个素数幂位上的估值单元。 -/
def hval (m : ℕ) : ℕ := m / 2 + m / 6 - (m / 3 + m / 4 + m / 12)

theorem hval_le (m : ℕ) : m / 3 + m / 4 + m / 12 ≤ m / 2 + m / 6 := by omega

theorem hval_add (m : ℕ) : hval m + (m / 3 + m / 4 + m / 12) = m / 2 + m / 6 :=
  Nat.sub_add_cancel (hval_le m)

theorem hval_le_one (m : ℕ) : hval m ≤ 1 := by unfold hval; omega

theorem hval_eq_zero_of_le_one (m : ℕ) (hm : m ≤ 1) : hval m = 0 := by unfold hval; omega

theorem hval_eq_one_iff (m : ℕ) :
    hval m = 1 ↔ m % 12 = 2 ∨ m % 12 = 6 ∨ m % 12 = 7 ∨ m % 12 = 8 ∨ m % 12 = 10 ∨ m % 12 = 11 := by
  unfold hval; omega

/-- 主件：尾巴阶乘比。 -/
def tailR (n : ℕ) : ℕ := (n/2)! * (n/6)! / ((n/3)! * (n/4)! * (n/12)!)

theorem tailR_factorization_add2 (n : ℕ) (p : ℕ) :
    ((n/2)! * (n/6)!).factorization p = (n/2)!.factorization p + (n/6)!.factorization p := by
  rw [Nat.factorization_mul (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _),
    Finsupp.coe_add, Pi.add_apply]

theorem tailR_factorization_add3 (n : ℕ) (p : ℕ) :
    ((n/3)! * (n/4)! * (n/12)!).factorization p
      = (n/3)!.factorization p + (n/4)!.factorization p + (n/12)!.factorization p := by
  rw [Nat.factorization_mul (Nat.mul_ne_zero (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _))
      (Nat.factorial_ne_zero _), Finsupp.coe_add, Pi.add_apply]
  rw [Nat.factorization_mul (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _),
    Finsupp.coe_add, Pi.add_apply]

theorem tailR_dvd (n : ℕ) : (n/3)! * (n/4)! * (n/12)! ∣ (n/2)! * (n/6)! := by
  rw [← Nat.factorization_le_iff_dvd (by positivity) (by positivity)]
  rw [Finsupp.le_def]
  intro p
  by_cases hp : p.Prime
  · have hb : ∀ k : ℕ, k ≤ n/2 → Nat.log p k < Nat.log p (n/2) + 2 :=
      fun k hk => (Nat.log_mono_right hk).trans_lt (by omega)
    rw [tailR_factorization_add3, tailR_factorization_add2]
    rw [Nat.factorization_factorial hp (hb (n/2) le_rfl),
      Nat.factorization_factorial hp (hb (n/6) (by omega)),
      Nat.factorization_factorial hp (hb (n/3) (by omega)),
      Nat.factorization_factorial hp (hb (n/4) (by omega)),
      Nat.factorization_factorial hp (hb (n/12) (by omega))]
    have key : ∀ i : ℕ, (n/3)/p^i + (n/4)/p^i + (n/12)/p^i ≤ (n/2)/p^i + (n/6)/p^i := by
      intro i
      have e : ∀ k : ℕ, (n/k)/p^i = (n/p^i)/k := fun k => by
        rw [Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, Nat.mul_comm]
      rw [e 3, e 4, e 12, e 2, e 6]
      exact hval_le (n / p^i)
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_le_sum (fun i _ => key i)
  · rw [Nat.factorization_eq_zero_of_not_prime _ hp, Nat.factorization_eq_zero_of_not_prime _ hp]

theorem tailR_mul (n : ℕ) : tailR n * ((n/3)! * (n/4)! * (n/12)!) = (n/2)! * (n/6)! :=
  Nat.div_mul_cancel (tailR_dvd n)

theorem tailR_pos (n : ℕ) : 0 < tailR n := by
  have h := tailR_mul n
  refine Nat.pos_of_ne_zero fun hz => ?_
  rw [hz, Nat.zero_mul] at h
  exact (Nat.mul_ne_zero (Nat.factorial_ne_zero _) (Nat.factorial_ne_zero _)) h.symm

theorem tailR_factorization (n : ℕ) (hp : p.Prime) :
    (tailR n).factorization p = ∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), hval (n / p^i) := by
  have hb : ∀ k : ℕ, k ≤ n/2 → Nat.log p k < Nat.log p (n/2) + 2 :=
    fun k hk => (Nat.log_mono_right hk).trans_lt (by omega)
  unfold tailR
  rw [Nat.factorization_div (tailR_dvd n), Finsupp.coe_tsub, Pi.sub_apply,
    tailR_factorization_add2, tailR_factorization_add3]
  rw [Nat.factorization_factorial hp (hb (n/2) le_rfl),
    Nat.factorization_factorial hp (hb (n/6) (by omega)),
    Nat.factorization_factorial hp (hb (n/3) (by omega)),
    Nat.factorization_factorial hp (hb (n/4) (by omega)),
    Nat.factorization_factorial hp (hb (n/12) (by omega))]
  symm
  apply Nat.eq_sub_of_add_eq
  have key : ∀ i : ℕ, hval (n / p^i) + ((n/3)/p^i + (n/4)/p^i + (n/12)/p^i)
      = (n/2)/p^i + (n/6)/p^i := by
    intro i
    have e : ∀ k : ℕ, (n/k)/p^i = (n/p^i)/k := fun k => by
      rw [Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, Nat.mul_comm]
    rw [e 3, e 4, e 12, e 2, e 6]
    exact hval_add (n / p^i)
  calc (∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), hval (n / p^i))
        + ((∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), (n/3)/p^i)
          + (∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), (n/4)/p^i)
          + (∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), (n/12)/p^i))
      = ∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2),
          (hval (n / p^i) + ((n/3)/p^i + (n/4)/p^i + (n/12)/p^i)) := by
        rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    _ = ∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), ((n/2)/p^i + (n/6)/p^i) :=
        Finset.sum_congr rfl fun i _ => key i
    _ = (∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), (n/2)/p^i)
        + (∑ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), (n/6)/p^i) := Finset.sum_add_distrib

theorem tailR_factorization_le_log (n : ℕ) (hp : p.Prime) :
    (tailR n).factorization p ≤ Nat.log p (n/2) := by
  rw [tailR_factorization n hp]
  have hz : ∀ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), ¬ p^i ≤ n/2 → hval (n / p^i) = 0 := by
    intro i _ hpi
    apply hval_eq_zero_of_le_one
    have h1 : n/2 + 1 ≤ p^i := Nat.add_one_le_iff.mpr (not_le.1 hpi)
    have h2 : n < 2 * p^i := by omega
    exact Nat.lt_succ_iff.mp ((Nat.div_lt_iff_lt_mul (Nat.pow_pos hp.pos)).mpr h2)
  rw [← Finset.sum_filter_add_sum_filter_not (Finset.Ico 1 (Nat.log p (n/2) + 2))
    (fun i => p^i ≤ n/2) (fun i => hval (n / p^i))]
  rw [Finset.sum_eq_zero (fun i hi => hz i (Finset.mem_filter.1 hi).1 (Finset.mem_filter.1 hi).2),
    add_zero]
  calc ∑ i ∈ (Finset.Ico 1 (Nat.log p (n/2) + 2)).filter (fun i => p^i ≤ n/2), hval (n / p^i)
      ≤ ∑ i ∈ (Finset.Ico 1 (Nat.log p (n/2) + 2)).filter (fun i => p^i ≤ n/2), 1 :=
        Finset.sum_le_sum fun i _ => hval_le_one _
    _ = ((Finset.Ico 1 (Nat.log p (n/2) + 2)).filter (fun i => p^i ≤ n/2)).card := by simp
    _ ≤ (Finset.Ico 1 (Nat.log p (n/2) + 1)).card := by
        apply Finset.card_le_card
        intro i hi
        rw [Finset.mem_filter, Finset.mem_Ico] at hi
        rw [Finset.mem_Ico]
        exact ⟨hi.1.1, Nat.lt_succ_iff.mpr (Nat.le_log_of_pow_le hp.one_lt hi.2)⟩
    _ = Nat.log p (n/2) := Nat.card_Ico 1 _

theorem pow_tailR_factorization_le (n : ℕ) (hn : 2 ≤ n) (hp : p.Prime) :
    p ^ (tailR n).factorization p ≤ n / 2 :=
  Nat.pow_le_of_le_log (by omega : n/2 ≠ 0) (tailR_factorization_le_log n hp)

theorem tailR_factorization_le_one (n : ℕ) (hp : p.Prime) (hpsq : n/2 < p^2) :
    (tailR n).factorization p ≤ 1 := by
  rw [tailR_factorization n hp]
  have hz : ∀ i ∈ Finset.Ico 1 (Nat.log p (n/2) + 2), i ≠ 1 → hval (n / p^i) = 0 := by
    intro i hi hi1
    apply hval_eq_zero_of_le_one
    rw [Finset.mem_Ico] at hi
    have hi2 : 2 ≤ i := by omega
    have hpi : p^2 ≤ p^i := Nat.pow_le_pow_right hp.pos hi2
    have h10 : 2 * p^2 ≤ 2 * p^i := Nat.mul_le_mul le_rfl hpi
    have h9 : n < 2 * p^i := by omega
    exact Nat.lt_succ_iff.mp ((Nat.div_lt_iff_lt_mul (Nat.pow_pos hp.pos)).mpr h9)
  rw [Finset.sum_eq_single 1 hz (by
    intro h
    exfalso
    rw [Finset.mem_Ico] at h
    exact h ⟨le_refl 1, by omega⟩)]
  rw [pow_one]
  exact hval_le_one _

theorem tailR_factorization_eq_zero_of_lt (n : ℕ) (hp : p.Prime) (h : n/2 < p) :
    (tailR n).factorization p = 0 := by
  rw [tailR_factorization n hp]
  apply Finset.sum_eq_zero
  intro i hi
  apply hval_eq_zero_of_le_one
  rw [Finset.mem_Ico] at hi
  have hpi : p ≤ p^i := by
    calc p = p^1 := (pow_one p).symm
      _ ≤ p^i := Nat.pow_le_pow_right hp.pos hi.1
  have h1 : n < 2 * p := by omega
  have h3 : 2 * p ≤ 2 * p^i := Nat.mul_le_mul le_rfl hpi
  have h2 : n < 2 * p^i := by omega
  exact Nat.lt_succ_iff.mp ((Nat.div_lt_iff_lt_mul (Nat.pow_pos hp.pos)).mpr h2)

theorem tailR_eq_prod_range (n : ℕ) :
    (∏ p ∈ Finset.range (n/2 + 1), p ^ (tailR n).factorization p) = tailR n := by
  conv_rhs => rw [← Nat.prod_factorization_pow_eq_self (tailR_pos n).ne']
  rw [eq_comm]
  apply Finset.prod_subset
  · intro p hp
    rw [Finset.mem_range]
    contrapose! hp
    rw [Finsupp.mem_support_iff, Classical.not_not]
    by_cases hpp : p.Prime
    · exact tailR_factorization_eq_zero_of_lt n hpp (by omega)
    · exact Nat.factorization_eq_zero_of_not_prime _ hpp
  · intro p _ h2
    simp [Classical.not_not.1 (mt Finsupp.mem_support_iff.2 h2)]

theorem tailR_factorization_small (n : ℕ) (hn : 18 ≤ n)
    (no_prime : ∀ p : ℕ, p.Prime → n / 3 < p → ¬ p ≤ n / 2) :
    tailR n = ∏ p ∈ Finset.range (n/6 + 1), p ^ (tailR n).factorization p := by
  refine (Eq.trans ?_ (tailR_eq_prod_range n)).symm
  apply Finset.prod_subset
  · intro x hx
    rw [Finset.mem_range, Nat.lt_succ_iff] at hx ⊢
    have h66 : n/6 ≤ n/2 := by omega
    omega
  intro x hx h2x
  rw [Finset.mem_range, Nat.lt_succ_iff] at hx h2x
  rw [not_le] at h2x
  by_cases hxp : x.Prime
  · have h6 : n + 1 ≤ 6 * x := by omega
    have hx4 : 4 ≤ x := by omega
    have hxx : 3 * x ≤ x^2 := by
      rw [pow_two]
      exact Nat.mul_le_mul_right x (by omega)
    have h9 : 6 * x ≤ 2 * x^2 := by linarith [hxx]
    have hsq : n < 2 * x^2 := by omega
    have hdm : x * (n/x) + n % x = n := Nat.div_add_mod n x
    have hmod : n % x < x := Nat.mod_lt n (by omega)
    rw [tailR_factorization n hxp]
    have hz : ∀ i ∈ Finset.Ico 1 (Nat.log x (n/2) + 2), i ≠ 1 → hval (n / x^i) = 0 := by
      intro i hi hi1
      apply hval_eq_zero_of_le_one
      rw [Finset.mem_Ico] at hi
      have hi2 : 2 ≤ i := by omega
      have hpi : x^2 ≤ x^i := Nat.pow_le_pow_right (by omega) hi2
      have h10 : 2 * x^2 ≤ 2 * x^i := Nat.mul_le_mul le_rfl hpi
      have h8 : n < 2 * x^i := by omega
      exact Nat.lt_succ_iff.mp ((Nat.div_lt_iff_lt_mul (Nat.pow_pos hxp.pos)).mpr h8)
    rw [Finset.sum_eq_single 1 hz (by
      intro h
      exfalso
      rw [Finset.mem_Ico] at h
      exact h ⟨le_refl 1, by omega⟩)]
    rw [pow_one]
    have hm2 : 2 ≤ n / x := (Nat.le_div_iff_mul_le (by omega : 0 < x)).mpr (by omega)
    have hm5 : n / x ≤ 5 := by
      have h9' : n < 6 * x := by omega
      have h10 : n / x < 6 := (Nat.div_lt_iff_lt_mul (by omega : 0 < x)).mpr h9'
      omega
    interval_cases h : n / x
    · exfalso
      exact (no_prime x hxp (by omega)) hx
    · norm_num [hval]
    · norm_num [hval]
    · norm_num [hval]
  · rw [Nat.factorization_eq_zero_of_not_prime _ hxp, pow_zero]

theorem tailR_le_of_no_prime (n : ℕ) (hn : 18 ≤ n)
    (no_prime : ∀ p : ℕ, p.Prime → n / 3 < p → ¬ p ≤ n / 2) :
    tailR n ≤ (n/2) ^ Nat.sqrt (n/2) * 4 ^ (n/6) := by
  have n2_pos : 1 ≤ n/2 := by omega
  let S := {p ∈ Finset.range (n/6 + 1) | Nat.Prime p}
  let f : ℕ → ℕ := fun x => x ^ (tailR n).factorization x
  have hSf : ∏ x ∈ S, f x = ∏ x ∈ Finset.range (n/6 + 1), f x := by
    refine Finset.prod_filter_of_ne fun p _ h => ?_
    by_contra hp
    exact h (by
      show p ^ (tailR n).factorization p = 1
      rw [Nat.factorization_eq_zero_of_not_prime (tailR n) hp, pow_zero])
  rw [tailR_factorization_small n hn no_prime, ← hSf,
    ← Finset.prod_filter_mul_prod_filter_not S (· ≤ Nat.sqrt (n/2))]
  apply mul_le_mul'
  · refine (Finset.prod_le_prod fun p hp => (?_ : f p ≤ n/2)).trans ?_
    · obtain ⟨h1, -⟩ := Finset.mem_filter.1 hp
      exact pow_tailR_factorization_le n (by omega) (Finset.mem_filter.1 h1).2
    · have hcard : (Finset.Icc 1 (Nat.sqrt (n/2))).card = Nat.sqrt (n/2) := by
        rw [Nat.card_Icc, Nat.add_sub_cancel]
      rw [Finset.prod_const]
      refine pow_right_mono₀ n2_pos ((Finset.card_le_card fun x hx => ?_).trans hcard.le)
      obtain ⟨h1, h2⟩ := Finset.mem_filter.1 hx
      exact Finset.mem_Icc.mpr ⟨(Finset.mem_filter.1 h1).2.one_lt.le, h2⟩
  · refine le_trans ?_ (primorial_le_four_pow (n/6))
    refine (Finset.prod_le_prod fun p hp => (?_ : f p ≤ p)).trans ?_
    · obtain ⟨h1, h2⟩ := Finset.mem_filter.1 hp
      refine (pow_right_mono₀ (Finset.mem_filter.1 h1).2.one_lt.le ?_).trans (pow_one p).le
      exact tailR_factorization_le_one n (Finset.mem_filter.1 h1).2 (Nat.sqrt_lt'.mp (not_le.1 h2))
    · refine Finset.prod_le_prod_of_subset_of_one_le (Finset.filter_subset _ _) ?_
      exact fun p hp _ => (Finset.mem_filter.1 hp).2.one_lt.le

theorem tailR_step_key (q : ℕ) (hq : 1 ≤ q) :
    3 * (4*q+1)^2 * (4*q+3) * (q+1) ≤ (6*q+1) * (2*q+1) * (6*q+5) * (4*q+5) := by
  have h1 : 3 * (4*q+3) ≤ 2 * (6*q+5) := by omega
  have h2 : 3 * (q+1) ≤ 2 * (2*q+1) := by omega
  have h3 : 4 * (4*q+1)^2 ≤ 3 * (6*q+1) * (4*q+5) := by nlinarith [sq_nonneg q]
  have m1 := Nat.mul_le_mul h1 h2
  have m2 := Nat.mul_le_mul h3 m1
  have m3 : 12 * (3 * (4*q+1)^2 * (4*q+3) * (q+1)) ≤ 12 * ((6*q+1) * (2*q+1) * (6*q+5) * (4*q+5)) := by
    convert m2 using 1 <;> ring
  exact Nat.le_of_mul_le_mul_left m3 (by norm_num)

theorem tailR_step (q : ℕ) (hq : 1 ≤ q) :
    18 * (4*q+1) * (((4*q+1)*(4*q+2)*(4*q+3)*(4*q+4)) * ((3*q+1)*(3*q+2)*(3*q+3)) * (q+1))
      ≤ ((6*q+1)*(6*q+2)*(6*q+3)*(6*q+4)*(6*q+5)*(6*q+6)) * ((2*q+1)*(2*q+2)) * (4*q+5) := by
  have h : (144 * (2*q+1) * (3*q+1) * (3*q+2) * (q+1)^2) * (3 * (4*q+1)^2 * (4*q+3) * (q+1))
      ≤ (144 * (2*q+1) * (3*q+1) * (3*q+2) * (q+1)^2) * ((6*q+1) * (2*q+1) * (6*q+5) * (4*q+5)) :=
    Nat.mul_le_mul (le_refl (144 * (2*q+1) * (3*q+1) * (3*q+2) * (q+1)^2)) (tailR_step_key q hq)
  convert h using 1 <;> ring

theorem tailR_lower_twelve (q : ℕ) (hq : 1 ≤ q) : 18^q < tailR (12*q) * (4*q+1) := by
  induction q, hq using Nat.le_induction with
  | base =>
      have hR : tailR 12 = 10 := by
        have h := tailR_mul 12
        have e1 : ((12:ℕ)/3)! * ((12:ℕ)/4)! * ((12:ℕ)/12)! = 144 := by decide
        have e2 : ((12:ℕ)/2)! * ((12:ℕ)/6)! = 1440 := by decide
        rw [e1, e2] at h
        omega
      rw [show (12:ℕ) * 1 = 12 by norm_num, hR]
      norm_num
  | succ k hk ih =>
      have hm := tailR_mul (12*(k+1))
      have hm0 := tailR_mul (12*k)
      have d2 : 12*(k+1)/2 = 6*(k+1) := by omega
      have d3 : 12*(k+1)/3 = 4*(k+1) := by omega
      have d4 : 12*(k+1)/4 = 3*(k+1) := by omega
      have d6 : 12*(k+1)/6 = 2*(k+1) := by omega
      have d12 : 12*(k+1)/12 = k+1 := by omega
      rw [d2, d3, d4, d6, d12] at hm
      have e2 : 12*k/2 = 6*k := by omega
      have e3 : 12*k/3 = 4*k := by omega
      have e4 : 12*k/4 = 3*k := by omega
      have e6 : 12*k/6 = 2*k := by omega
      have e12 : 12*k/12 = k := by omega
      rw [e2, e3, e4, e6, e12] at hm0
      have f1 : (6*(k+1))! = (6*k)! * ((6*k+1)*(6*k+2)*(6*k+3)*(6*k+4)*(6*k+5)*(6*k+6)) := by
        rw [show 6*(k+1) = 6*k + 5 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ,
          Nat.factorial_succ, Nat.factorial_succ, Nat.factorial_succ, Nat.factorial_succ]
        ring
      have f2 : (2*(k+1))! = (2*k)! * ((2*k+1)*(2*k+2)) := by
        rw [show 2*(k+1) = 2*k + 1 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ]
        ring
      have f3 : (4*(k+1))! = (4*k)! * ((4*k+1)*(4*k+2)*(4*k+3)*(4*k+4)) := by
        rw [show 4*(k+1) = 4*k + 3 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ,
          Nat.factorial_succ, Nat.factorial_succ]
        ring
      have f4 : (3*(k+1))! = (3*k)! * ((3*k+1)*(3*k+2)*(3*k+3)) := by
        rw [show 3*(k+1) = 3*k + 2 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ,
          Nat.factorial_succ]
        ring
      have hstep : 18^k * ((4*k)! * (3*k)! * k !) < (4*k+1) * ((6*k)! * (2*k)!) := by
        calc 18^k * ((4*k)! * (3*k)! * k !)
            < (tailR (12*k) * (4*k+1)) * ((4*k)! * (3*k)! * k !) :=
              (Nat.mul_lt_mul_right (by positivity)).mpr ih
          _ = (4*k+1) * ((6*k)! * (2*k)!) := by rw [← hm0]; ring
      have key : 18^(k+1) * ((4*(k+1))! * (3*(k+1))! * (k+1)!)
          < ((6*k)! * (2*k)!) * (((6*k+1)*(6*k+2)*(6*k+3)*(6*k+4)*(6*k+5)*(6*k+6))
            * ((2*k+1)*(2*k+2)) * (4*k+5)) := by
        have e1 : 18^(k+1) * ((4*(k+1))! * (3*(k+1))! * (k+1)!) =
            (18^k * ((4*k)! * (3*k)! * k !)) * (18 * ((4*k+1)*(4*k+2)*(4*k+3)*(4*k+4))
              * ((3*k+1)*(3*k+2)*(3*k+3)) * (k+1)) := by
          rw [f3, f4, Nat.factorial_succ k, pow_succ]
          ring
        rw [e1]
        calc (18^k * ((4*k)! * (3*k)! * k !)) * (18 * ((4*k+1)*(4*k+2)*(4*k+3)*(4*k+4))
                * ((3*k+1)*(3*k+2)*(3*k+3)) * (k+1))
            < ((4*k+1) * ((6*k)! * (2*k)!)) * (18 * ((4*k+1)*(4*k+2)*(4*k+3)*(4*k+4))
                * ((3*k+1)*(3*k+2)*(3*k+3)) * (k+1)) :=
              (Nat.mul_lt_mul_right (by positivity)).mpr hstep
          _ = ((6*k)! * (2*k)!) * (18 * (4*k+1) * (((4*k+1)*(4*k+2)*(4*k+3)*(4*k+4))
                * ((3*k+1)*(3*k+2)*(3*k+3)) * (k+1))) := by ring
          _ ≤ ((6*k)! * (2*k)!) * (((6*k+1)*(6*k+2)*(6*k+3)*(6*k+4)*(6*k+5)*(6*k+6))
                * ((2*k+1)*(2*k+2)) * (4*k+5)) :=
              Nat.mul_le_mul le_rfl (tailR_step k hk)
      have key2 : 18^(k+1) * ((4*(k+1))! * (3*(k+1))! * (k+1)!)
          < (tailR (12*(k+1)) * (4*(k+1)+1)) * ((4*(k+1))! * (3*(k+1))! * (k+1)!) := by
        have e2' : (6*(k+1))! * (2*(k+1))! * (4*(k+1)+1) =
            ((6*k)! * (2*k)!) * (((6*k+1)*(6*k+2)*(6*k+3)*(6*k+4)*(6*k+5)*(6*k+6))
              * ((2*k+1)*(2*k+2)) * (4*k+5)) := by
          rw [f1, f2]
          ring
        rw [← e2'] at key
        exact key.trans_eq (by rw [← hm]; ring)
      exact Nat.lt_of_mul_lt_mul_right key2

theorem tailR_block (n : ℕ) :
    tailR (12*(n/12)) ≤ tailR n * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2)) := by
  have hm := tailR_mul n
  have hm0 := tailR_mul (12*(n/12))
  have e2 : 12*(n/12)/2 = 6*(n/12) := by omega
  have e3 : 12*(n/12)/3 = 4*(n/12) := by omega
  have e4 : 12*(n/12)/4 = 3*(n/12) := by omega
  have e6 : 12*(n/12)/6 = 2*(n/12) := by omega
  have e12 : 12*(n/12)/12 = n/12 := by omega
  rw [e2, e3, e4, e6, e12] at hm0
  have h2 : n < (n/12 + 1) * 12 := (Nat.div_lt_iff_lt_mul (by norm_num : (0:ℕ) < 12)).mp (Nat.lt_succ_self _)
  have c1 : (6*(n/12))! ≤ (n/2)! := Nat.factorial_le (by omega)
  have c2 : (2*(n/12))! ≤ (n/6)! := Nat.factorial_le (by omega)
  have c3 : (n/3)! ≤ (4*(n/12)+3)! := Nat.factorial_le (by omega)
  have c4 : (n/4)! ≤ (3*(n/12)+2)! := Nat.factorial_le (by omega)
  have g3 : (4*(n/12)+3)! = (4*(n/12))! * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)) := by
    rw [show 4*(n/12)+3 = 4*(n/12) + 2 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ,
      Nat.factorial_succ]
    ring
  have g4 : (3*(n/12)+2)! = (3*(n/12))! * ((3*(n/12)+1)*(3*(n/12)+2)) := by
    rw [show 3*(n/12)+2 = 3*(n/12) + 1 + 1 by ring, Nat.factorial_succ, Nat.factorial_succ]
    ring
  have c3' : (n/3)! ≤ (4*(n/12))! * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)) := c3.trans_eq g3
  have c4' : (n/4)! ≤ (3*(n/12))! * ((3*(n/12)+1)*(3*(n/12)+2)) := c4.trans_eq g4
  have key : tailR (12*(n/12)) * ((4*(n/12))! * (3*(n/12))! * (n/12)!) ≤
      tailR n * (((4*(n/12))! * (3*(n/12))! * (n/12)!)
        * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2))) := by
    calc tailR (12*(n/12)) * ((4*(n/12))! * (3*(n/12))! * (n/12)!)
        = (6*(n/12))! * (2*(n/12))! := hm0
      _ ≤ (n/2)! * (n/6)! := Nat.mul_le_mul c1 c2
      _ = tailR n * ((n/3)! * (n/4)! * (n/12)!) := hm.symm
      _ ≤ tailR n * (((4*(n/12))! * (3*(n/12))! * (n/12)!)
          * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2))) :=
        Nat.mul_le_mul le_rfl ((Nat.mul_le_mul (Nat.mul_le_mul c3' c4') le_rfl).trans_eq (by ring))
  have key2 : tailR (12*(n/12)) * ((4*(n/12))! * (3*(n/12))! * (n/12)!) ≤
      (tailR n * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2)))
        * ((4*(n/12))! * (3*(n/12))! * (n/12)!) := key.trans_eq (by ring)
  exact Nat.le_of_mul_le_mul_right key2 (by positivity)

theorem tailR_lower_strict (n : ℕ) (hn : 1000000 ≤ n) :
    18^(n/12) < tailR n * (4*(n/12)+3)^6 := by
  have q1 : 1 ≤ n/12 := by omega
  have h1 := tailR_lower_twelve (n/12) q1
  have h2 := tailR_block n
  have h3 : ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2)) * (4*(n/12)+1)
      ≤ (4*(n/12)+3)^6 := by
    have e : (4*(n/12)+3)^6 = (((((4*(n/12)+3)*(4*(n/12)+3))*(4*(n/12)+3))*(4*(n/12)+3))*(4*(n/12)+3))*(4*(n/12)+3) := by
      ring
    rw [e]
    have a1 : 4*(n/12)+1 ≤ 4*(n/12)+3 := by omega
    have a2 : 4*(n/12)+2 ≤ 4*(n/12)+3 := by omega
    have a3 : 4*(n/12)+3 ≤ 4*(n/12)+3 := le_rfl
    have a4 : 3*(n/12)+1 ≤ 4*(n/12)+3 := by omega
    have a5 : 3*(n/12)+2 ≤ 4*(n/12)+3 := by omega
    have a6 : 4*(n/12)+1 ≤ 4*(n/12)+3 := by omega
    exact Nat.mul_le_mul (Nat.mul_le_mul (Nat.mul_le_mul (Nat.mul_le_mul (Nat.mul_le_mul a1 a2) a3) a4) a5) a6
  calc 18^(n/12) < tailR (12*(n/12)) * (4*(n/12)+1) := h1
    _ ≤ (tailR n * ((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2))) * (4*(n/12)+1) :=
        Nat.mul_le_mul_right _ h2
    _ = tailR n * (((4*(n/12)+1)*(4*(n/12)+2)*(4*(n/12)+3)*(3*(n/12)+1)*(3*(n/12)+2)) * (4*(n/12)+1)) := by
        ring
    _ ≤ tailR n * (4*(n/12)+3)^6 := Nat.mul_le_mul le_rfl h3

theorem concave_log_affine : ConcaveOn ℝ (Set.Ioi (0.5:ℝ)) (fun x => Real.log (4*x + 3)) := by
  let g : ℝ →ᵃ[ℝ] ℝ := AffineMap.mk (fun x => 4*x + 3) ((4:ℝ) • LinearMap.id) (by
    intro p v
    simp only [LinearMap.smul_apply, LinearMap.id_coe, id_eq, smul_eq_mul, vadd_eq_add]
    ring)
  have h := strictConcaveOn_log_Ioi.concaveOn.comp_affineMap g
  refine (h.subset ?_ (convex_Ioi (0.5:ℝ))).congr (fun x _ => rfl)
  intro x hx
  simp only [Set.mem_preimage, Set.mem_Ioi] at hx ⊢
  show (0:ℝ) < 4*x + 3
  have hx' : (0.5:ℝ) < x := hx
  linarith

theorem concave_sqrt_mul_log_affine :
    ConcaveOn ℝ (Set.Ioi (0.5:ℝ)) (fun x => Real.sqrt (6*x + 5) * Real.log (6*x + 5)) := by
  let g : ℝ →ᵃ[ℝ] ℝ := AffineMap.mk (fun x => 6*x + 5) ((6:ℝ) • LinearMap.id) (by
    intro p v
    simp only [LinearMap.smul_apply, LinearMap.id_coe, id_eq, smul_eq_mul, vadd_eq_add]
    ring)
  have h := strictConcaveOn_sqrt_mul_log_Ioi.concaveOn.comp_affineMap g
  refine (h.subset ?_ (convex_Ioi (0.5:ℝ))).congr (fun x _ => rfl)
  intro x hx
  simp only [Set.mem_preimage, Set.mem_Ioi] at hx ⊢
  show (1:ℝ) < 6*x + 5
  have hx' : (0.5:ℝ) < x := hx
  linarith

private noncomputable def tailf (x : ℝ) : ℝ :=
  Real.log 4 + 6 * Real.log (4*x+3) + Real.sqrt (6*x+5) * Real.log (6*x+5) - Real.log (9/8) * x

theorem real_tail_inequality {x : ℝ} (x_large : (100000:ℝ) ≤ x) :
    4 * (4*x+3)^6 * (6*x+5)^(Real.sqrt (6*x+5)) * 16^x ≤ 18^x := by
  have hf : ∀ x : ℝ, 0 < x → tailf x =
      Real.log ((4 * (4*x+3)^6 * (6*x+5)^(Real.sqrt (6*x+5)) * 16^x) / 18^x) := by
    intro x hx
    have h1 : (0:ℝ) < 4*x+3 := by positivity
    have h6 : (0:ℝ) < 6*x+5 := by positivity
    rw [Real.log_div (by positivity) (Real.rpow_pos_of_pos (by norm_num : (0:ℝ) < 18) x).ne',
      Real.log_mul (by positivity) (Real.rpow_pos_of_pos (by norm_num : (0:ℝ) < 16) x).ne',
      Real.log_mul (by positivity) (Real.rpow_pos_of_pos h6 _).ne',
      Real.log_mul (by norm_num : (4:ℝ) ≠ 0) (pow_pos h1 6).ne',
      Real.log_pow, Real.log_rpow h6,
      Real.log_rpow (by norm_num : (0:ℝ) < 16), Real.log_rpow (by norm_num : (0:ℝ) < 18)]
    have h95 : Real.log (9/8) = Real.log 18 - Real.log 16 := by
      rw [← Real.log_div (by norm_num : (18:ℝ) ≠ 0) (by norm_num : (16:ℝ) ≠ 0)]
      congr 1
      norm_num
    simp only [tailf]
    push_cast
    rw [h95]
    ring
  have hconv : ConcaveOn ℝ (Set.Ioi (0.5:ℝ)) tailf := by
    unfold tailf
    apply ConcaveOn.sub
    · exact ((concaveOn_const (Real.log 4) (convex_Ioi (0.5:ℝ))).add
        ((concave_log_affine).smul (by norm_num : (0:ℝ) ≤ 6))).add concave_sqrt_mul_log_affine
    · exact (convexOn_id (convex_Ioi (0.5:ℝ))).smul (Real.log_nonneg (by norm_num : (1:ℝ) ≤ 9/8))
  have hx0 : (0:ℝ) < x := lt_of_lt_of_le (by norm_num1) x_large
  have hfx : tailf x ≤ 0 := by
    suffices ∃ x1 x2 : ℝ, 0.5 < x1 ∧ x1 < x2 ∧ x2 ≤ x ∧ 0 ≤ tailf x1 ∧ tailf x2 ≤ 0 by
      obtain ⟨x1, x2, h1, h2, h0, h3, h4⟩ := this
      exact (hconv.right_le_of_le_left'' h1 ((h1.trans h2).trans_le h0) h2 h0 (h4.trans h3)).trans h4
    refine ⟨(4:ℕ), (100000:ℕ), by norm_num, by norm_num, by exact_mod_cast x_large, ?_, ?_⟩
    · have hL : (1:ℝ)/2 ≤ Real.log 2 := by
        have h := Real.log_le_sub_one_of_pos (show (0:ℝ) < (1:ℝ)/2 by norm_num)
        rw [show (1:ℝ)/2 = (2:ℝ)⁻¹ by norm_num, Real.log_inv] at h
        linarith
      have hL4 : Real.log 4 = 2 * Real.log 2 := by
        rw [show (4:ℝ) = 2^2 by norm_num, Real.log_pow]; norm_num
      have hL16 : Real.log 16 = 4 * Real.log 2 := by
        rw [show (16:ℝ) = 2^4 by norm_num, Real.log_pow]; norm_num
      have hL19 : 4 * Real.log 2 ≤ Real.log 19 := by
        rw [← hL16]; exact Real.log_le_log (by norm_num) (by norm_num)
      have hL29 : 4 * Real.log 2 ≤ Real.log 29 := by
        rw [← hL16]; exact Real.log_le_log (by norm_num) (by norm_num)
      have hs29 : (4:ℝ) ≤ Real.sqrt 29 := by
        rw [Real.le_sqrt (by norm_num : (0:ℝ) ≤ 4) (by norm_num : (0:ℝ) ≤ 29)]; norm_num
      have h98 : Real.log (9/8) ≤ 1/8 :=
        (Real.log_le_sub_one_of_pos (by norm_num : (0:ℝ) < (9:ℝ)/8)).trans (by norm_num)
      have hmul : 4 * (4 * Real.log 2) ≤ Real.sqrt 29 * Real.log 29 :=
        mul_le_mul hs29 hL29 (mul_nonneg (by norm_num) (Real.log_nonneg (by norm_num))) (by norm_num)
      have hfin : (0:ℝ) ≤ Real.log 4 + 6 * Real.log 19 + Real.sqrt 29 * Real.log 29
          - Real.log (9/8) * 4 := by
        linarith [hL, hL4, hL19, hmul, h98]
      unfold tailf
      norm_num1
      exact hfin
    · rw [hf (100000:ℕ) (by norm_num)]
      rw [Real.rpow_natCast, Real.rpow_natCast]
      rw [Real.log_nonpos_iff (by positivity), div_le_one (by positivity)]
      have e4' : (4:ℝ)*((100000:ℕ):ℝ)+3 = 400003 := by norm_num
      have e6' : (6:ℝ)*((100000:ℕ):ℝ)+5 = 600005 := by norm_num
      rw [e4', e6']
      have hsqrt775 : Real.sqrt 600005 ≤ 775 :=
        (Real.sqrt_le_sqrt (by norm_num : (600005:ℝ) ≤ 600625)).trans
          (le_of_eq ((Real.sqrt_eq_iff_mul_self_eq_of_pos (by norm_num : (0:ℝ) < 775)).mpr (by norm_num)))
      have e1 : (600005:ℝ)^(Real.sqrt 600005) ≤ (2:ℝ)^15500 :=
        (Real.rpow_le_rpow_of_exponent_le (by norm_num) hsqrt775).trans (by
          rw [show (775:ℝ) = ((775:ℕ):ℝ) by norm_num, Real.rpow_natCast]
          calc (600005:ℝ)^775 ≤ (2^20:ℝ)^775 := pow_le_pow_left₀ (by norm_num) (by norm_num) _
            _ = (2:ℝ)^15500 := by rw [← pow_mul])
      have e2 : (400003:ℝ)^6 ≤ (2:ℝ)^114 :=
        (pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 400003) (by norm_num : (400003:ℝ) ≤ 2^19) 6).trans (by
          rw [← pow_mul])
      have s1 : (4:ℝ) * (400003)^6 ≤ (2:ℝ)^2 * (2:ℝ)^114 :=
        mul_le_mul (by norm_num) e2 (by positivity) (by positivity)
      have s2 : (4:ℝ) * (400003)^6 * (600005)^(Real.sqrt 600005) ≤ (2:ℝ)^2 * (2:ℝ)^114 * (2:ℝ)^15500 :=
        mul_le_mul s1 e1 (by positivity) (by positivity)
      have e3 : (4:ℝ) * (400003)^6 * (600005)^(Real.sqrt 600005) * 16^100000 ≤
          (2:ℝ)^2 * (2:ℝ)^114 * (2:ℝ)^15500 * 16^100000 :=
        mul_le_mul s2 le_rfl (by positivity) (by positivity)
      have e4 : (2:ℝ)^2 * (2:ℝ)^114 * (2:ℝ)^15500 * 16^100000 = (2:ℝ)^15616 * 16^100000 := by
        rw [← pow_add, ← pow_add]
      have e5 : (2:ℝ)^15616 ≤ (9/8)^100000 :=
        calc (2:ℝ)^15616 ≤ (2:ℝ)^16666 := pow_le_pow_right₀ (by norm_num) (by norm_num)
          _ ≤ ((9/8)^6)^16666 := pow_le_pow_left₀ (by norm_num) (by norm_num) _
          _ = (9/8)^(6*16666) := by rw [pow_mul]
          _ ≤ (9/8)^100000 := pow_le_pow_right₀ (by norm_num) (by norm_num)
      calc (4:ℝ) * (400003)^6 * (600005)^(Real.sqrt 600005) * 16^100000
          ≤ (2:ℝ)^15616 * 16^100000 := e3.trans_eq e4
        _ ≤ (9/8)^100000 * 16^100000 := mul_le_mul e5 le_rfl (by positivity) (by positivity)
        _ = 18^100000 := by rw [show (18:ℝ) = 16*(9/8) by norm_num, mul_pow]; ring
  rw [← div_le_one (Real.rpow_pos_of_pos (by norm_num : (0:ℝ) < 18) x),
    ← Real.log_nonpos_iff (by positivity), ← hf x hx0]
  exact hfx

theorem tail_main_inequality_nat (q : ℕ) (hq : 100000 ≤ q) :
    4 * (4*q+3)^6 * (6*q+5)^(Nat.sqrt (6*q+5)) * 16^q ≤ 18^q := by
  have h1 : (1:ℝ) ≤ 6*(q:ℝ)+5 := by
    have h0 : (0:ℝ) < 6*(q:ℝ)+5 := by positivity
    linarith
  have hexp : ((Nat.sqrt (6*q+5) : ℕ) : ℝ) ≤ Real.sqrt (6*(q:ℝ)+5) := by
    have h := Real.nat_sqrt_le_real_sqrt (a := 6*q+5)
    rwa [show ((6*q+5:ℕ):ℝ) = 6*(q:ℝ)+5 by push_cast; ring] at h
  have key : (6*(q:ℝ)+5)^(Nat.sqrt (6*q+5)) ≤ (6*(q:ℝ)+5)^(Real.sqrt (6*(q:ℝ)+5)) := by
    rw [← Real.rpow_natCast]
    exact Real.rpow_le_rpow_of_exponent_le h1 hexp
  have main := real_tail_inequality (x := (q:ℝ)) (by exact_mod_cast hq)
  rw [Real.rpow_natCast, Real.rpow_natCast] at main
  rw [← @Nat.cast_le ℝ]
  push_cast
  calc (4:ℝ) * (4*↑q+3)^6 * (6*↑q+5)^(Nat.sqrt (6*q+5)) * 16^q
      ≤ (4:ℝ) * (4*↑q+3)^6 * (6*↑q+5)^(Real.sqrt (6*↑q+5)) * 16^q :=
        mul_le_mul (mul_le_mul le_rfl key (by positivity) (by positivity)) le_rfl
          (by positivity) (by positivity)
    _ ≤ 18^q := main


theorem lemmaB_tail_1000000 (n : ℕ) (hn : 1000000 ≤ n) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 := by
  rcases lt_or_ge n 1200000 with h | h
  · exact lemmaB_hop (q := 400009) (by norm_num) (by omega) (by omega)
  · by_contra hc
    push_neg at hc
    have hc' : ∀ p : ℕ, p.Prime → n / 3 < p → ¬ p ≤ n / 2 := by
      intro p hp1 hp2 hle
      have hcc := hc p hp1 hp2
      omega
    have hub := tailR_le_of_no_prime n (by omega) hc'
    have hlb := tailR_lower_strict n hn
    have hmain := tail_main_inequality_nat (n/12) (by omega)
    have h2 : n < (n/12 + 1) * 12 := (Nat.div_lt_iff_lt_mul (by norm_num : (0:ℕ) < 12)).mp (Nat.lt_succ_self _)
    have e1 : (n/2)^(Nat.sqrt (n/2)) ≤ (6*(n/12)+5)^(Nat.sqrt (6*(n/12)+5)) := by
      have hbase : n/2 ≤ 6*(n/12)+5 := by omega
      have hs : Nat.sqrt (n/2) ≤ Nat.sqrt (6*(n/12)+5) := Nat.sqrt_le_sqrt hbase
      exact (Nat.pow_le_pow_right (by omega : 0 < n/2) hs).trans (Nat.pow_le_pow_left hbase _)
    have e2 : 4^(n/6) ≤ 4 * 16^(n/12) := by
      have h4 : n/6 ≤ 2*(n/12) + 1 := by omega
      calc 4^(n/6) ≤ 4^(2*(n/12)+1) := Nat.pow_le_pow_right (by norm_num) h4
        _ = 4 * 16^(n/12) := by
          rw [pow_succ, pow_mul]
          norm_num
          ring
    have key : 18^(n/12) < 18^(n/12) := by
      calc 18^(n/12) < tailR n * (4*(n/12)+3)^6 := hlb
        _ ≤ ((n/2)^(Nat.sqrt (n/2)) * 4^(n/6)) * (4*(n/12)+3)^6 := Nat.mul_le_mul_right _ hub
        _ ≤ ((6*(n/12)+5)^(Nat.sqrt (6*(n/12)+5)) * (4 * 16^(n/12))) * (4*(n/12)+3)^6 :=
            Nat.mul_le_mul_right _ (Nat.mul_le_mul e1 e2)
        _ = 4 * (4*(n/12)+3)^6 * (6*(n/12)+5)^(Nat.sqrt (6*(n/12)+5)) * 16^(n/12) := by ring
        _ ≤ 18^(n/12) := hmain
    exact absurd key (lt_irrefl _)

end NFactPrimorialSquareChain

namespace NFactPrimorialSquare

/-- 辅助 statement：`ν_p(n#) = 1`（素数 `p ≤ n`）。 -/
theorem primorial_factorization_eq_one {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (primorial n).factorization p = 1 :=
  factorization_eq_one_of_squarefree (squarefree_primorial n) hp
    ((Nat.Prime.dvd_primorial_iff hp).mpr hpn)

/-- 辅助 statement：`ν_p(n#) = 0`（素数 `p ≰ n`）。 -/
theorem primorial_factorization_eq_zero {p n : ℕ} (hp : p.Prime) (hpn : ¬ p ≤ n) :
    (primorial n).factorization p = 0 :=
  Nat.factorization_eq_zero_of_not_dvd
    (fun h => hpn ((Nat.Prime.dvd_primorial_iff hp).mp h))

/-- 辅助 statement（判据的乘法骨架）：`ν_p(n!·n#) = ν_p(n!) + 1`（素数 `p ≤ n`）。 -/
theorem factorization_factorial_mul_primorial {p n : ℕ} (hp : p.Prime) (hpn : p ≤ n) :
    (n ! * primorial n).factorization p = (n !).factorization p + 1 := by
  rw [Nat.factorization_mul (Nat.factorial_ne_zero n) (primorial_ne_zero n),
      Finsupp.add_apply, primorial_factorization_eq_one hp hpn]

/-- **引理 A（等价估值判据）**：对 `n ≥ 1`，`n! · n#` 是完全平方 ⟺
    对每个素数 `p ≤ n`，`ν_p(n!)` 为奇数。
    （`Nat.factorization m p` 即 ν_p(m)：素数 p 在 m 中的指数。） -/
theorem isSquare_iff_all_factorization_odd (n : ℕ) (hn : 1 ≤ n) :
    IsSquare (n ! * primorial n) ↔
      ∀ p : ℕ, p.Prime → p ≤ n → Odd ((n !).factorization p) := by
  constructor
  · intro h p hp hpn
    have hEven : Even ((n ! * primorial n).factorization p) :=
      Nat.isSquare_iff_even_factorization.mp h p hp
    rw [factorization_factorial_mul_primorial hp hpn] at hEven
    obtain ⟨m, hm⟩ := hEven
    cases m with
    | zero => simp at hm
    | succ k => exact ⟨k, by omega⟩
  · intro h
    apply Nat.isSquare_iff_even_factorization.mpr
    intro p hp
    by_cases hpn : p ≤ n
    · rw [factorization_factorial_mul_primorial hp hpn]
      exact (h p hp hpn).add_one
    · rw [Nat.factorization_mul (Nat.factorial_ne_zero n) (primorial_ne_zero n),
        Finsupp.add_apply,
        Nat.factorization_eq_zero_of_not_dvd
          (fun hd => hpn ((Nat.Prime.dvd_factorial hp).mp hd)),
        primorial_factorization_eq_zero hp hpn]
      exact ⟨0, rfl⟩

/-- **见证层（主定理 ⟸ 向的显式平方根）**：n = 0..5 各点 `x² = n!·n#`，
    x = 1, 1, 2, 6, 12, 60（与 NL 主命题的对应关系逐点一致）。 -/
theorem witnesses_zero_to_five :
    1 ^ 2 = 0 ! * primorial 0 ∧
    1 ^ 2 = 1 ! * primorial 1 ∧
    2 ^ 2 = 2 ! * primorial 2 ∧
    6 ^ 2 = 3 ! * primorial 3 ∧
    12 ^ 2 = 4 ! * primorial 4 ∧
    60 ^ 2 = 5 ! * primorial 5 := by decide

/-- 桥接引理（witness 层内部）：某素数位上 factorization 为奇 ⟹ 非平方。
    IsSquare 给出 m = r * r，则 ν_p(m) = ν_p(r) + ν_p(r) 为偶，与奇数假设矛盾。 -/
theorem not_isSquare_of_odd_factorization {m p e : ℕ} (hm : m ≠ 0)
    (h : m.factorization p = 2 * e + 1) : ¬ IsSquare m := by
  rintro ⟨r, hr⟩
  have hne : r ≠ 0 := by rintro rfl; rw [mul_zero] at hr; exact hm hr
  rw [hr, Nat.factorization_mul hne hne, Finsupp.add_apply] at h
  omega

/-- 非平方见证 n = 6：ν_2(6!·6#) = 5（奇），6!·6# = 2^5 · 675，2 ∤ 675。 -/
theorem nonsquare_at_6 : ¬ IsSquare (6 ! * primorial 6) := by
  have hM : (6 : ℕ) ! * primorial 6 = 2 ^ 5 * 675 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 2)
    (mul_ne_zero (Nat.factorial_ne_zero 6) (primorial_ne_zero 6))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^5) ≠ 0) (by norm_num : (675:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 675),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 7：ν_2(7!·7#) = 5（奇），7!·7# = 2^5 · 33075，2 ∤ 33075。 -/
theorem nonsquare_at_7 : ¬ IsSquare (7 ! * primorial 7) := by
  have hM : (7 : ℕ) ! * primorial 7 = 2 ^ 5 * 33075 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 2)
    (mul_ne_zero (Nat.factorial_ne_zero 7) (primorial_ne_zero 7))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^5) ≠ 0) (by norm_num : (33075:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 33075),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 8：ν_3(8!·8#) = 3（奇），8!·8# = 3^3 · 313600，3 ∤ 313600。 -/
theorem nonsquare_at_8 : ¬ IsSquare (8 ! * primorial 8) := by
  have hM : (8 : ℕ) ! * primorial 8 = 3 ^ 3 * 313600 := by decide
  apply not_isSquare_of_odd_factorization (p := 3) (e := 1)
    (mul_ne_zero (Nat.factorial_ne_zero 8) (primorial_ne_zero 8))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^3) ≠ 0) (by norm_num : (313600:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 313600),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 9：ν_3(9!·9#) = 5（奇），9!·9# = 3^5 · 313600，3 ∤ 313600。 -/
theorem nonsquare_at_9 : ¬ IsSquare (9 ! * primorial 9) := by
  have hM : (9 : ℕ) ! * primorial 9 = 3 ^ 5 * 313600 := by decide
  apply not_isSquare_of_odd_factorization (p := 3) (e := 2)
    (mul_ne_zero (Nat.factorial_ne_zero 9) (primorial_ne_zero 9))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^5) ≠ 0) (by norm_num : (313600:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 313600),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 10：ν_2(10!·10#) = 9（奇），10!·10# = 2^9 · 1488375，2 ∤ 1488375。 -/
theorem nonsquare_at_10 : ¬ IsSquare (10 ! * primorial 10) := by
  have hM : (10 : ℕ) ! * primorial 10 = 2 ^ 9 * 1488375 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 4)
    (mul_ne_zero (Nat.factorial_ne_zero 10) (primorial_ne_zero 10))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^9) ≠ 0) (by norm_num : (1488375:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 1488375),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 11：ν_2(11!·11#) = 9（奇），11!·11# = 2^9 · 180093375，2 ∤ 180093375。 -/
theorem nonsquare_at_11 : ¬ IsSquare (11 ! * primorial 11) := by
  have hM : (11 : ℕ) ! * primorial 11 = 2 ^ 9 * 180093375 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 4)
    (mul_ne_zero (Nat.factorial_ne_zero 11) (primorial_ne_zero 11))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^9) ≠ 0) (by norm_num : (180093375:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 180093375),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 12：ν_2(12!·12#) = 11（奇），12!·12# = 2^11 · 540280125，2 ∤ 540280125。 -/
theorem nonsquare_at_12 : ¬ IsSquare (12 ! * primorial 12) := by
  have hM : (12 : ℕ) ! * primorial 12 = 2 ^ 11 * 540280125 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 5)
    (mul_ne_zero (Nat.factorial_ne_zero 12) (primorial_ne_zero 12))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^11) ≠ 0) (by norm_num : (540280125:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 540280125),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 13：ν_2(13!·13#) = 11（奇），13!·13# = 2^11 · 91307341125，2 ∤ 91307341125。 -/
theorem nonsquare_at_13 : ¬ IsSquare (13 ! * primorial 13) := by
  have hM : (13 : ℕ) ! * primorial 13 = 2 ^ 11 * 91307341125 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 5)
    (mul_ne_zero (Nat.factorial_ne_zero 13) (primorial_ne_zero 13))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^11) ≠ 0) (by norm_num : (91307341125:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 91307341125),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 14：ν_5(14!·14#) = 3（奇），14!·14# = 5^3 · 20943712677888，5 ∤ 20943712677888。 -/
theorem nonsquare_at_14 : ¬ IsSquare (14 ! * primorial 14) := by
  have hM : (14 : ℕ) ! * primorial 14 = 5 ^ 3 * 20943712677888 := by decide
  apply not_isSquare_of_odd_factorization (p := 5) (e := 1)
    (mul_ne_zero (Nat.factorial_ne_zero 14) (primorial_ne_zero 14))
  rw [hM, Nat.factorization_mul (by norm_num : ((5:ℕ)^3) ≠ 0) (by norm_num : (20943712677888:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (5:ℕ) ∣ 20943712677888),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization (by norm_num : Nat.Prime 5), Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 15：ν_3(15!·15#) = 7（奇），15!·15# = 3^7 · 17955857920000，3 ∤ 17955857920000。 -/
theorem nonsquare_at_15 : ¬ IsSquare (15 ! * primorial 15) := by
  have hM : (15 : ℕ) ! * primorial 15 = 3 ^ 7 * 17955857920000 := by decide
  apply not_isSquare_of_odd_factorization (p := 3) (e := 3)
    (mul_ne_zero (Nat.factorial_ne_zero 15) (primorial_ne_zero 15))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^7) ≠ 0) (by norm_num : (17955857920000:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 17955857920000),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 16：ν_3(16!·16#) = 7（奇），16!·16# = 3^7 · 287293726720000，3 ∤ 287293726720000。 -/
theorem nonsquare_at_16 : ¬ IsSquare (16 ! * primorial 16) := by
  have hM : (16 : ℕ) ! * primorial 16 = 3 ^ 7 * 287293726720000 := by decide
  apply not_isSquare_of_odd_factorization (p := 3) (e := 3)
    (mul_ne_zero (Nat.factorial_ne_zero 16) (primorial_ne_zero 16))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^7) ≠ 0) (by norm_num : (287293726720000:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 287293726720000),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 17：ν_3(17!·17#) = 7（奇），17!·17# = 3^7 · 83027887022080000，3 ∤ 83027887022080000。 -/
theorem nonsquare_at_17 : ¬ IsSquare (17 ! * primorial 17) := by
  have hM : (17 : ℕ) ! * primorial 17 = 3 ^ 7 * 83027887022080000 := by decide
  apply not_isSquare_of_odd_factorization (p := 3) (e := 3)
    (mul_ne_zero (Nat.factorial_ne_zero 17) (primorial_ne_zero 17))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^7) ≠ 0) (by norm_num : (83027887022080000:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 83027887022080000),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 18：ν_2(18!·18#) = 17（奇），18!·18# = 2^17 · 24936491397943125，2 ∤ 24936491397943125。 -/
theorem nonsquare_at_18 : ¬ IsSquare (18 ! * primorial 18) := by
  have hM : (18 : ℕ) ! * primorial 18 = 2 ^ 17 * 24936491397943125 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 8)
    (mul_ne_zero (Nat.factorial_ne_zero 18) (primorial_ne_zero 18))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^17) ≠ 0) (by norm_num : (24936491397943125:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 24936491397943125),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 19：ν_2(19!·19#) = 17（奇），19!·19# = 2^17 · 9002073394657468125，2 ∤ 9002073394657468125。 -/
theorem nonsquare_at_19 : ¬ IsSquare (19 ! * primorial 19) := by
  have hM : (19 : ℕ) ! * primorial 19 = 2 ^ 17 * 9002073394657468125 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 8)
    (mul_ne_zero (Nat.factorial_ne_zero 19) (primorial_ne_zero 19))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^17) ≠ 0) (by norm_num : (9002073394657468125:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 9002073394657468125),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 20：ν_2(20!·20#) = 19（奇），20!·20# = 2^19 · 45010366973287340625，2 ∤ 45010366973287340625。 -/
theorem nonsquare_at_20 : ¬ IsSquare (20 ! * primorial 20) := by
  have hM : (20 : ℕ) ! * primorial 20 = 2 ^ 19 * 45010366973287340625 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 9)
    (mul_ne_zero (Nat.factorial_ne_zero 20) (primorial_ne_zero 20))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^19) ≠ 0) (by norm_num : (45010366973287340625:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 45010366973287340625),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 非平方见证 n = 21：ν_2(21!·21#) = 19（奇），21!·21# = 2^19 · 945217706439034153125，2 ∤ 945217706439034153125。 -/
theorem nonsquare_at_21 : ¬ IsSquare (21 ! * primorial 21) := by
  have hM : (21 : ℕ) ! * primorial 21 = 2 ^ 19 * 945217706439034153125 := by decide
  apply not_isSquare_of_odd_factorization (p := 2) (e := 9)
    (mul_ne_zero (Nat.factorial_ne_zero 21) (primorial_ne_zero 21))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^19) ≠ 0) (by norm_num : (945217706439034153125:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 945217706439034153125),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

/-- 组装形态（供 M5 主定理 ⟹ 向引用）：6 ≤ n ≤ 21 的每一点 n!·n# 均非平方。 -/
theorem nonsquare_six_to_twenty_one (n : ℕ) (h6 : 6 ≤ n) (h21 : n ≤ 21) :
    ¬ IsSquare (n ! * primorial n) := by
  interval_cases n
  · exact nonsquare_at_6
  · exact nonsquare_at_7
  · exact nonsquare_at_8
  · exact nonsquare_at_9
  · exact nonsquare_at_10
  · exact nonsquare_at_11
  · exact nonsquare_at_12
  · exact nonsquare_at_13
  · exact nonsquare_at_14
  · exact nonsquare_at_15
  · exact nonsquare_at_16
  · exact nonsquare_at_17
  · exact nonsquare_at_18
  · exact nonsquare_at_19
  · exact nonsquare_at_20
  · exact nonsquare_at_21

/-- **引理 B（区间素数引理）**：对每个整数 `n ≥ 22`，存在素数 `p` 使 `n/3 < p ≤ n/2`。
    （`/ `为 ℕ 整除：区间即 `⌊n/3⌋ < p ≤ ⌊n/2⌋`，与 NL 原文的实数区间解读在素数存在性上
    一致——p 为整数，`n/3 < p ⟺ ⌊n/3⌋ < p`，`p ≤ n/2 ⟺ p ≤ ⌊n/2⌋`，详见 faithful.md。） -/
theorem exists_prime_between_div_three_and_div_two (n : ℕ) (hn : 22 ≤ n) :
    ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2 := by
  rcases lt_or_ge n 1000000 with h | h
  · exact NFactPrimorialSquareChain.lemmaB_upto_999999 n hn (by omega)
  · exact NFactPrimorialSquareChain.lemmaB_tail_1000000 n h

/-- **主定理（完全解集，iff 形态）**：
    `n! · n#` 是完全平方 ⟺ `n ≤ 5`（n : ℕ）。
    ℕ 上 `n ≤ 5 ⟺ n ∈ {0,1,2,3,4,5}`，故此即 NL 主命题「解恰为 n ∈ {0,…,5}」。 -/
theorem isSquare_factorial_mul_primorial_iff (n : ℕ) :
    IsSquare (n ! * primorial n) ↔ n ≤ 5 := by
  constructor
  · -- ⟹ 向：n!·n# 为平方 ⟹ n ≤ 5（对偶：n ≥ 6 时 n!·n# 非平方）
    intro h
    by_contra hle
    have h6 : 6 ≤ n := by omega
    rcases lt_or_ge n 22 with hlt | h22
    · -- 6 ≤ n ≤ 21 段：witness 层逐点非平方见证直接矛盾
      exact nonsquare_six_to_twenty_one n h6 (by omega) h
    · -- 22 ≤ n 段：引理 B 取素数 p ∈ (n/3, n/2]；判据给出 Odd (ν_p(n!))，但 Legendre 和式算出 ν_p(n!) = 2
      obtain ⟨p, hp, hpl, hpu⟩ := exists_prime_between_div_three_and_div_two n h22
      have hodd : Odd ((n !).factorization p) :=
        (isSquare_iff_all_factorization_odd n (by omega)).mp h p hp (by omega)
      have hn3p : n < 3 * p := by omega
      have hp3 : 3 ≤ p := by omega
      have hpsq : n < p ^ 2 := by
        have h3pp : 3 * p ≤ p * p := Nat.mul_le_mul hp3 (le_refl p)
        rw [pow_two]
        exact lt_of_lt_of_le hn3p h3pp
      have hlog2 : Nat.log p n < 2 := Nat.log_lt_of_lt_pow (by omega) hpsq
      have hd1 : n / p = 2 := by
        have hp0 : 0 < p := hp.pos
        have hr : n - 2 * p < p := by omega
        rw [show n = n - 2 * p + p * 2 by omega, Nat.add_mul_div_left _ _ hp0,
          Nat.div_eq_of_lt hr, zero_add]
      have hfact2 : (n !).factorization p = 2 := by
        have hIco : Finset.Ico 1 2 = ({1} : Finset ℕ) := by decide
        calc (n !).factorization p = ∑ i ∈ Finset.Ico 1 2, n / p ^ i :=
              Nat.factorization_factorial hp hlog2
          _ = ∑ i ∈ ({1} : Finset ℕ), n / p ^ i := by rw [hIco]
          _ = n / p ^ 1 := Finset.sum_singleton _ _
          _ = n / p := by rw [pow_one]
          _ = 2 := hd1
      rw [hfact2] at hodd
      obtain ⟨k, hk⟩ := hodd
      omega
  · -- ⟸ 向：n ≤ 5 逐点给显式平方根（x = 1, 1, 2, 6, 12, 60）
    intro h
    obtain ⟨h0, h1, h2, h3, h4, h5⟩ := witnesses_zero_to_five
    interval_cases n
    · exact (isSquare_iff_exists_sq _).mpr ⟨1, h0.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨1, h1.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨2, h2.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨6, h3.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨12, h4.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨60, h5.symm⟩

/-- **主定理（存在见证形态，与 iff 形态并列交付）**：
    丢番图方程 `x² = n!·n#` 有解 ⟺ `n ∈ {0,1,2,3,4,5}`。 -/
theorem exists_sq_factorial_mul_primorial_iff (n : ℕ) :
    (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ n ∈ ({0, 1, 2, 3, 4, 5} : Finset ℕ) := by
  have hbridge : (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ IsSquare (n ! * primorial n) := by
    rw [isSquare_iff_exists_sq]
    constructor
    · rintro ⟨x, hx⟩
      exact ⟨x, hx.symm⟩
    · rintro ⟨r, hr⟩
      exact ⟨r, hr.symm⟩
  rw [hbridge, isSquare_factorial_mul_primorial_iff]
  simp only [Finset.mem_insert, Finset.mem_singleton]
  constructor <;> intro h <;> omega

end NFactPrimorialSquare
