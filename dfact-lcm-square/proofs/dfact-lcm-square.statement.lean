  
                                                                                                 
                                                                                

                                                            
                                                      
                                         
                                                                          

                                                                                    
                    

                                                   
                                 
                                                      
                         

                                                     
                                                

                              
                                                                    
                                                                                 
                                                                                             
                                                                                 
                                                                          
                               
  
import Mathlib

open Nat Finset

namespace DFactLcmSquare

                                                      
                             
                                                                
                                                                      
                                                       
theorem isSquare_dfact_mul_lcmUpto_iff (n : ℕ) :
    IsSquare (n‼ * Nat.lcmUpto n) ↔
      ∀ p : ℕ, p.Prime → Even ((n‼).factorization p + p.log n) := by
  sorry

                                                                      
theorem dfact_lcm_witnesses :
    1 ^ 2 = 0‼ * Nat.lcmUpto 0 ∧ 1 ^ 2 = 1‼ * Nat.lcmUpto 1 ∧
      2 ^ 2 = 2‼ * Nat.lcmUpto 2 ∧ 30 ^ 2 = 5‼ * Nat.lcmUpto 5 ∧
        210 ^ 2 = 7‼ * Nat.lcmUpto 7 := by
  sorry

                         
                                                      
                                     
theorem dfact_lcm_square_solution_set (n : ℕ) :
    IsSquare (n‼ * Nat.lcmUpto n) ↔ n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 5 ∨ n = 7 := by
  sorry

end DFactLcmSquare
