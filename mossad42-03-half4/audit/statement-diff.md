# 宪条 2 检查：statement 对称差（产物 vs 冻结快照）

## t1 vs 01-half3-statements.lean
- ✔ `b1`：逐字节一致
- ✔ `a1`：逐字节一致
- ✔ `a1_mul_eight`：逐字节一致
- ✔ `a1_eq_zero_of_not_dvd`：逐字节一致
- ✔ `a1_ne_zero_iff`：逐字节一致
- ✔ `b1_ratio`：逐字节一致

## t2 vs 02-mod3x3-statements.lean
- ✔ `a2`：逐字节一致
- ✔ `b2`：逐字节一致
- ✔ `b2_mod8`：逐字节一致
- ✔ `a2_interleave`：逐字节一致
- ✔ `a2_odd_eq_zero`：逐字节一致

## t3 vs 03-half4-statements.lean
- ✔ `steps4`：逐字节一致
- ✔ `pc`：逐字节一致
- ✔ `D4`：逐字节一致
- ✔ `a3`：逐字节一致
- ✔ `D4_pc_even`：逐字节一致
- ✔ `D4_h_even`：逐字节一致
- ✔ `a3_odd_eq_zero`：逐字节一致
- ✔ `a3_even_ne_zero`：逐字节一致
- ✔ `a3_ne_zero_iff`：逐字节一致
- 注：产物含冻结件之外的声明（辅助引理，允许）：['map_sum_ne_zero_of_mem', 'exists_of_sum_ne_zero', 'steps4_guard', 'D4_inv', 'D4_step2']

## t4 vs 04-mod3x4-statements.lean
- ✔ `a4`：逐字节一致
- ✔ `pat2_15`：逐字节一致
- ✔ `pat3_30`：逐字节一致
- ✔ `a4_mod2_period15`：逐字节一致
- ✔ `a4_mod3_period30`：逐字节一致
- 注：产物含冻结件之外的声明（辅助引理，允许）：['int_two_mul_ediv_add_emod', 'int_three_mul_ediv_add_emod', 'pat2_15_step', 'a4_aux15', 'pat3_30_step', 'a4_aux30']

## 总裁决：全部逐字节一致 ✔
