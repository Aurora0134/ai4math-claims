/-
  AI4Math 流水线 · AI 生成 · 2026-09-27
  部门：02 形式化部（dept-formalize）
  任务线：mossad-notch · 3×n / 4×n 网格缺右上角匹配数（pool-mossad-02 / pool-mossad-03，pool Part A）
  来源卡：tasks/20260927-mossad-notch/card.md（闸门一 2026-09-27 立项；节点 anthropic/a6api-main/kimi-k3）
  主张定稿：tasks/20260927-mossad-notch/phase0/claims.md（T1/T2 主攻 + T3/T4 伴随；T4 取锐利 iff 形）
  初值数据出处：phase0/counts.txt（方法1 mask DP + 方法2 暴力对拍，双方法互证 PASS；
    主代理已复核递推全窗口逐位一致）；
    本文件两条 def 的初值与递推系数照抄 claims.md 草稿，零改数
    （格式上仅把每行多分枝改为每行一分枝，语义不变）。

  口径（按任务卡锁定）：陈述中不出现图、网格、匹配等组合对象；只形式化
  「递推定义版序列」（ℕ → ℤ，初值 + 整数系数递推显式进 def）的奇偶/模周期性质。
  语义桥（a3 n / a4 n ?= 缺角网格全匹配数，主口径 = 全匹配计数）不进本文件 theorem 层
  （comb.excluded.semantics-bridge 先例；3×n 完美匹配子命题已占位 OEIS A001353，见 claims.md 围栏）。

  索引口径：两条序列 0-based；a3 n / a4 n 对应 counts.txt 第 (n+1) 行（n 从 1 起计）的 a3/a4 列。
  proof body 全部 `sorry` 占位（形式化部只交付 statement；良定义门由宪兵 gate-batch 集中跑）。
-/

import Mathlib

/-- **序列 a3（3×n 缺角宽度，阶 5 递推）**。
初值 a3(0..4) = 2, 10, 67, 407, 2546（= counts.txt 第 1..5 行 a3 列）；
递推 a3(n+5) = 5·a3(n+4)+9·a3(n+3)−9·a3(n+2)−a3(n+1)+a3(n)。 -/
def a3 : ℕ → ℤ
  | 0 => 2
  | 1 => 10
  | 2 => 67
  | 3 => 407
  | 4 => 2546
  | n + 5 =>
      5 * a3 (n + 4) + 9 * a3 (n + 3) - 9 * a3 (n + 2) - a3 (n + 1) + a3 n

/-- **T1（主攻）**：a3 为奇数 ⟺ n 除以 6 余 2 或 3（奇偶性以 6 为周期）。 -/
theorem a3_odd_iff (n : ℕ) : Odd (a3 n) ↔ n % 6 = 2 ∨ n % 6 = 3 := by
  sorry

/-- **T3（伴随）**：a3 模 8 以 12 为周期。 -/
theorem a3_mod8_periodic (n : ℕ) : a3 (n + 12) ≡ a3 n [ZMOD 8] := by
  sorry

/-- **序列 a4（4×n 缺角宽度，阶 9 递推）**。
初值 a4(0..8) = 3, 32, 407, 4840, 58608, 705949, 8515850, 102684287, 1238310540
（= counts.txt 第 1..9 行 a4 列）；
递推 a4(n+9) = 9·a4(n+8)+41·a4(n+7)−41·a4(n+6)−111·a4(n+5)+91·a4(n+4)+29·a4(n+3)
  −23·a4(n+2)−a4(n+1)+a4(n)。 -/
def a4 : ℕ → ℤ
  | 0 => 3
  | 1 => 32
  | 2 => 407
  | 3 => 4840
  | 4 => 58608
  | 5 => 705949
  | 6 => 8515850
  | 7 => 102684287
  | 8 => 1238310540
  | n + 9 =>
      9 * a4 (n + 8) + 41 * a4 (n + 7) - 41 * a4 (n + 6) - 111 * a4 (n + 5)
        + 91 * a4 (n + 4) + 29 * a4 (n + 3) - 23 * a4 (n + 2) - a4 (n + 1) + a4 n

/-- **T2（主攻）**：a4 为奇数 ⟺ n 除以 5 余 0 或 2（奇偶性以 5 为周期）。 -/
theorem a4_odd_iff (n : ℕ) : Odd (a4 n) ↔ n % 5 = 0 ∨ n % 5 = 2 := by
  sorry

/-- **T4（伴随，锐利 iff 形）**：a4(n) ≡ 2 (mod 4) ⟺ n 除以 10 余 6
（其余余类 mod 4 ∈ {0,1,3} 各 5 余类循环；周期 10）。 -/
theorem a4_mod4_eq2_iff (n : ℕ) : a4 n ≡ 2 [ZMOD 4] ↔ n % 10 = 6 := by
  sorry
