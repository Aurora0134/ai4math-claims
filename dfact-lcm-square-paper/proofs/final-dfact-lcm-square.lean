  
                                                                                                 
                                                                                      

                                                                          
                                                                             

                            
                                                                       
                        
                                                         
                                                                                        
                                            
                                                                                       
                                                                                  
                                                     
                                                                                    
                                               

                                                                        
                           
  
import Mathlib
import Library.NFactPrimorialSquare
import Library.IntervalPrimeQuarter

open Nat Finset

namespace DFactLcmSquare

                                                                             

                                                      
                             
                                                                
                                                                      
                                      
theorem isSquare_dfact_mul_lcmUpto_iff (n : ℕ) :
    IsSquare (n‼ * Nat.lcmUpto n) ↔
      ∀ p : ℕ, p.Prime → Even ((n‼).factorization p + p.log n) := by
  rw [Nat.isSquare_iff_even_factorization]
  refine forall_congr' fun p => imp_congr_right fun hp => ?_
  simp only [Nat.factorization_mul (Nat.doubleFactorial_pos n).ne' (Nat.lcmUpto_ne_zero n),
    Finsupp.add_apply, Nat.factorization_lcmUpto n hp]

                                                   

                                                                      
theorem dfact_lcm_witnesses :
    1 ^ 2 = 0‼ * Nat.lcmUpto 0 ∧ 1 ^ 2 = 1‼ * Nat.lcmUpto 1 ∧
      2 ^ 2 = 2‼ * Nat.lcmUpto 2 ∧ 30 ^ 2 = 5‼ * Nat.lcmUpto 5 ∧
        210 ^ 2 = 7‼ * Nat.lcmUpto 7 := by
  decide

                                                                   

                                                                              
theorem nonsquare_at_3 : ¬ IsSquare (3‼ * Nat.lcmUpto 3) := by
  have hM : (3‼ * Nat.lcmUpto 3) = 2 ^ 1 * 9 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 2) (e := 0)
    (mul_ne_zero (Nat.doubleFactorial_pos 3).ne' (Nat.lcmUpto_ne_zero 3))
  rw [hM, Nat.factorization_mul (by norm_num : ((2:ℕ)^1) ≠ 0) (by norm_num : (9:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (2:ℕ) ∣ 9),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_two, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

                                                                           
theorem nonsquare_at_9 : ¬ IsSquare (9‼ * Nat.lcmUpto 9) := by
  have hM : (9‼ * Nat.lcmUpto 9) = 3 ^ 5 * 9800 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 3) (e := 2)
    (mul_ne_zero (Nat.doubleFactorial_pos 9).ne' (Nat.lcmUpto_ne_zero 9))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^5) ≠ 0) (by norm_num : (9800:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 9800),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

                                                                                      
theorem nonsquare_at_11 : ¬ IsSquare (11‼ * Nat.lcmUpto 11) := by
  have hM : (11‼ * Nat.lcmUpto 11) = 3 ^ 5 * 1185800 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 3) (e := 2)
    (mul_ne_zero (Nat.doubleFactorial_pos 11).ne' (Nat.lcmUpto_ne_zero 11))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^5) ≠ 0) (by norm_num : (1185800:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 1185800),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

                                                                                            
theorem nonsquare_at_13 : ¬ IsSquare (13‼ * Nat.lcmUpto 13) := by
  have hM : (13‼ * Nat.lcmUpto 13) = 3 ^ 5 * 200400200 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 3) (e := 2)
    (mul_ne_zero (Nat.doubleFactorial_pos 13).ne' (Nat.lcmUpto_ne_zero 13))
  rw [hM, Nat.factorization_mul (by norm_num : ((3:ℕ)^5) ≠ 0)
      (by norm_num : (200400200:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd (by decide : ¬ (3:ℕ) ∣ 200400200),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization Nat.prime_three, Finsupp.single_eq_same]; norm_num [nsmul_eq_mul]

                            
                                                                                         
theorem nonsquare_at_29 : ¬ IsSquare (29‼ * Nat.lcmUpto 29) := by
  have hM : (29‼ * Nat.lcmUpto 29) = 7 ^ 3 * 42034181777588218110750000 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 7) (e := 1)
    (mul_ne_zero (Nat.doubleFactorial_pos 29).ne' (Nat.lcmUpto_ne_zero 29))
  rw [hM, Nat.factorization_mul (by norm_num : ((7:ℕ)^3) ≠ 0)
      (by norm_num : (42034181777588218110750000:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd
      (by decide : ¬ (7:ℕ) ∣ 42034181777588218110750000),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization (by norm_num : Nat.Prime 7), Finsupp.single_eq_same]
  norm_num [nsmul_eq_mul]

                            
                                                                                               
theorem nonsquare_at_31 : ¬ IsSquare (31‼ * Nat.lcmUpto 31) := by
  have hM : (31‼ * Nat.lcmUpto 31) = 7 ^ 3 * 40394848688262277604430750000 := by decide
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := 7) (e := 1)
    (mul_ne_zero (Nat.doubleFactorial_pos 31).ne' (Nat.lcmUpto_ne_zero 31))
  rw [hM, Nat.factorization_mul (by norm_num : ((7:ℕ)^3) ≠ 0)
      (by norm_num : (40394848688262277604430750000:ℕ) ≠ 0),
    Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd
      (by decide : ¬ (7:ℕ) ∣ 40394848688262277604430750000),
    Nat.factorization_pow, Finsupp.smul_apply,
    Nat.Prime.factorization (by norm_num : Nat.Prime 7), Finsupp.single_eq_same]
  norm_num [nsmul_eq_mul]

                                                                        

                                                                             
                                                                                        
                                                                                
                                                                                    
                                                                      
                                                         
                                                   
theorem odd_dfact_lcm_nonsquare_of_prime {n p : ℕ} (ho : Odd n) (hp : p.Prime)
    (h4 : n / 4 < p) (h3 : p ≤ n / 3) (hpsq : n < p * p) :
    ¬ IsSquare (n‼ * Nat.lcmUpto n) := by
  have hn3p : 3 * p ≤ n := by omega
  have hn4p : n < 4 * p := by omega
  have hp5 : 5 ≤ p := by
    by_contra hlt
    have hlt' : p < 5 := by omega
    have hp2 : 2 ≤ p := hp.two_le
    interval_cases p
    · omega
    · omega
    · exact absurd hp (by norm_num)
  obtain ⟨m, rfl⟩ := ho
  have hpm : p ≤ m := by omega
  have hm2p : m < 2 * p := by omega
  have hmpsq : m < p * p := by omega
  have hlogn : Nat.log p (2 * m + 1) < 2 :=
    Nat.log_lt_of_lt_pow (by omega) (by rwa [pow_two])
  have hdivn : (2 * m + 1) / p = 3 := by
    have hr : 2 * m + 1 - 3 * p < p := by omega
    rw [show 2 * m + 1 = 2 * m + 1 - 3 * p + p * 3 by omega,
      Nat.add_mul_div_left _ _ hp.pos, Nat.div_eq_of_lt hr, Nat.zero_add]
  have hfactn : ((2 * m + 1)!).factorization p = 3 := by
    have hIco : Finset.Ico 1 2 = ({1} : Finset ℕ) := by decide
    calc ((2 * m + 1)!).factorization p = ∑ i ∈ Finset.Ico 1 2, (2 * m + 1) / p ^ i :=
          Nat.factorization_factorial hp hlogn
      _ = ∑ i ∈ ({1} : Finset ℕ), (2 * m + 1) / p ^ i := by rw [hIco]
      _ = (2 * m + 1) / p ^ 1 := Finset.sum_singleton _ _
      _ = (2 * m + 1) / p := by rw [pow_one]
      _ = 3 := hdivn
  have hlogm : Nat.log p m < 2 := Nat.log_lt_of_lt_pow (by omega) (by rwa [pow_two])
  have hdivm : m / p = 1 := by
    have hr : m - p < p := by omega
    rw [show m = m - p + p * 1 by omega, Nat.add_mul_div_left _ _ hp.pos,
      Nat.div_eq_of_lt hr, Nat.zero_add]
  have hfactm : (m !).factorization p = 1 := by
    have hIco : Finset.Ico 1 2 = ({1} : Finset ℕ) := by decide
    calc (m !).factorization p = ∑ i ∈ Finset.Ico 1 2, m / p ^ i :=
          Nat.factorization_factorial hp hlogm
      _ = ∑ i ∈ ({1} : Finset ℕ), m / p ^ i := by rw [hIco]
      _ = m / p ^ 1 := Finset.sum_singleton _ _
      _ = m / p := by rw [pow_one]
      _ = 1 := hdivm
  have hndvd2m : ¬ p ∣ 2 ^ m := fun hd => by
    have h1 := hp.dvd_of_dvd_pow hd
    have h2 := Nat.le_of_dvd (by norm_num : (0:ℕ) < 2) h1
    omega
  have hfact2m : ((2 * m)‼).factorization p = 1 := by
    rw [Nat.doubleFactorial_two_mul,
      Nat.factorization_mul (pow_ne_zero _ (by norm_num : (2:ℕ) ≠ 0)) (Nat.factorial_ne_zero m),
      Finsupp.add_apply, Nat.factorization_eq_zero_of_not_dvd hndvd2m, hfactm, Nat.zero_add]
  have hsplit : (2 * m + 1)! = (2 * m + 1)‼ * (2 * m)‼ :=
    Nat.factorial_eq_mul_doubleFactorial (2 * m)
  have hfacteq : ((2 * m + 1)‼).factorization p = 2 := by
    have hmul := congrArg (fun a => Nat.factorization a p) hsplit
    rw [Nat.factorization_mul (Nat.doubleFactorial_pos _).ne' (Nat.doubleFactorial_pos _).ne',
      Finsupp.add_apply, hfact2m, hfactn] at hmul
    omega
  have hlog1 : p.log (2 * m + 1) = 1 := by
    have hge : 1 ≤ Nat.log p (2 * m + 1) :=
      Nat.le_log_of_pow_le hp.one_lt (by rw [pow_one]; omega)
    omega
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := p) (e := 1)
    (mul_ne_zero (Nat.doubleFactorial_pos _).ne' (Nat.lcmUpto_ne_zero _))
  rw [Nat.factorization_mul (Nat.doubleFactorial_pos _).ne' (Nat.lcmUpto_ne_zero _),
    Finsupp.add_apply, hfacteq, Nat.factorization_lcmUpto _ hp, hlog1]

                                                           

                                          
                                                                 
                                                                      
                                                                 
                                                                       
theorem even_dfact_lcm_nonsquare (n : ℕ) (hn : 4 ≤ n) (h2 : Even n) :
    ¬ IsSquare (n‼ * Nat.lcmUpto n) := by
  obtain ⟨m, rfl⟩ : ∃ m, n = 2 * m := by
    obtain ⟨m, hm⟩ := h2
    exact ⟨m, by omega⟩
  have hm2 : 2 ≤ m := by omega
  obtain ⟨p, hp, hmp, hpn⟩ := Nat.bertrand m (by omega)
  have hpsq : 2 * m < p * p := by
    have h1 : 2 * m < 2 * p := by omega
    have h2' : 2 * p ≤ p * p := Nat.mul_le_mul (by omega : 2 ≤ p) (le_refl p)
    exact lt_of_lt_of_le h1 h2'
  have hndvd2m : ¬ p ∣ 2 ^ m := fun hd => by
    have h1 := hp.dvd_of_dvd_pow hd
    have h2 := Nat.le_of_dvd (by norm_num : (0:ℕ) < 2) h1
    omega
  have hndvdm : ¬ p ∣ m ! := fun hd => by
    have := (Nat.Prime.dvd_factorial hp).mp hd
    omega
  have hfact_dfact : ((2 * m)‼).factorization p = 0 := by
    rw [Nat.doubleFactorial_two_mul,
      Nat.factorization_eq_zero_of_not_dvd (hp.not_dvd_mul hndvd2m hndvdm)]
  have hlog1 : p.log (2 * m) = 1 := by
    have hge : 1 ≤ Nat.log p (2 * m) :=
      Nat.le_log_of_pow_le hp.one_lt (by rw [pow_one]; omega)
    have hlt : Nat.log p (2 * m) < 2 :=
      Nat.log_lt_of_lt_pow (by omega) (by rwa [pow_two])
    omega
  apply NFactPrimorialSquare.not_isSquare_of_odd_factorization (p := p) (e := 0)
    (mul_ne_zero (Nat.doubleFactorial_pos _).ne' (Nat.lcmUpto_ne_zero _))
  rw [Nat.factorization_mul (Nat.doubleFactorial_pos _).ne' (Nat.lcmUpto_ne_zero _),
    Finsupp.add_apply, hfact_dfact, Nat.factorization_lcmUpto _ hp, hlog1]

                                                 

                         
                                                      
                                  
                                   
                                             
                                                                    
                                                                       
                                                  
theorem dfact_lcm_square_solution_set (n : ℕ) :
    IsSquare (n‼ * Nat.lcmUpto n) ↔ n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 5 ∨ n = 7 := by
  constructor
  · intro h
    by_contra hne
    push_neg at hne
    rcases lt_or_ge n 4 with hlt | hge
    · interval_cases n
      · omega
      · omega
      · omega
      · exact nonsquare_at_3 h
    · rcases Nat.even_or_odd n with he | ho
      · exact even_dfact_lcm_nonsquare n hge he h
      · have h9 : 9 ≤ n := by
          obtain ⟨k, hk⟩ := ho
          omega
        rcases lt_or_ge n 33 with hlt2 | hge2
        · interval_cases n
          · exact nonsquare_at_9 h
          · exact even_dfact_lcm_nonsquare 10 (by norm_num) (by decide) h
          · exact nonsquare_at_11 h
          · exact even_dfact_lcm_nonsquare 12 (by norm_num) (by decide) h
          · exact nonsquare_at_13 h
          · exact even_dfact_lcm_nonsquare 14 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 5) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 16 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 5) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 18 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 5) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 20 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 7) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 22 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 7) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 24 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 7) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 26 (by norm_num) (by decide) h
          · exact odd_dfact_lcm_nonsquare_of_prime (p := 7) (by decide) (by norm_num)
              (by norm_num) (by norm_num) (by norm_num) h
          · exact even_dfact_lcm_nonsquare 28 (by norm_num) (by decide) h
          · exact nonsquare_at_29 h
          · exact even_dfact_lcm_nonsquare 30 (by norm_num) (by decide) h
          · exact nonsquare_at_31 h
          · exact even_dfact_lcm_nonsquare 32 (by norm_num) (by decide) h
        · obtain ⟨p, hp, h4, h3⟩ := exists_prime_between_quarter_and_third n hge2
          have hpsq : n < p * p := by
            have hn4 : n < 4 * p := by omega
            have hp4 : 4 ≤ p := by omega
            exact lt_of_lt_of_le hn4 (Nat.mul_le_mul hp4 (le_refl p))
          exact odd_dfact_lcm_nonsquare_of_prime ho hp h4 h3 hpsq h
  · intro h
    obtain ⟨h0, h1, h2w, h5, h7⟩ := dfact_lcm_witnesses
    rcases h with rfl | rfl | rfl | rfl | rfl
    · exact (isSquare_iff_exists_sq _).mpr ⟨1, h0.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨1, h1.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨2, h2w.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨30, h5.symm⟩
    · exact (isSquare_iff_exists_sq _).mpr ⟨210, h7.symm⟩

                                                  

                                 
                                                        
theorem exists_sq_dfact_lcm_iff (n : ℕ) :
    (∃ x : ℕ, x ^ 2 = n‼ * Nat.lcmUpto n) ↔ n ∈ ({0, 1, 2, 5, 7} : Finset ℕ) := by
  have hbridge : (∃ x : ℕ, x ^ 2 = n‼ * Nat.lcmUpto n) ↔ IsSquare (n‼ * Nat.lcmUpto n) := by
    rw [isSquare_iff_exists_sq]
    constructor
    · rintro ⟨x, hx⟩
      exact ⟨x, hx.symm⟩
    · rintro ⟨r, hr⟩
      exact ⟨r, hr.symm⟩
  rw [hbridge, dfact_lcm_square_solution_set]
  simp only [Finset.mem_insert, Finset.mem_singleton]

end DFactLcmSquare
