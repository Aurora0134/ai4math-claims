/-
  AI4Math 流水线 · AI 生成 · 2026-09-27
  部门：02 形式化部（dept-formalize）
  任务线：mossad-pend（pool-mossad-01，pool Part A；三线兄弟线之 pend 线）
  来源卡：tasks/20260927-mossad-pend/card.md（闸门一 2026-09-27 立项）
  主张定稿：tasks/20260927-mossad-pend/phase0/claims.md（T1 主攻 + T2/T3 伴随；T4 备选不进本批）
  初值数据出处：phase0/counts.txt（双算法互证 PASS）+ claims.md 主代理复核订正节
    （order-8 递推、两四阶子列递推、T1 交织恒等式、T2 样式在 n≤30 数据窗口全项 PASS）；
    本文件五条 def 的初值/系数/样式逐字照抄 claims.md Lean 草稿（T3 取订正后形态，
    格式上仅把每行多分枝改为每行一分枝，语义不变）。

  口径（按任务卡锁定）：本文件（含注释）只使用「初值 + 整数系数递推定义的纯序列」
  语言（ℕ → ℤ），命题只谈序列的交织/模余数性质；组合对象语义一律不进本层。
  索引口径（0-based Lean ↔ 1-based 计数）：
  apend n = a(n+1)；opend k = a(2k+1)（奇位侧）；epend k = a(2k+2)（偶位侧）。

  【占位围栏】opend 的数值 = OEIS A386889（Dresden & Demirkol，2025-09-04 挂名，
  已占位，数值核到 k=15）；本线新颖性主张严格限定「完整 order-8 递推 +
  偶数子列（epend 侧）」；禁止任何「新序列」泛写。statement 层仅为纯序列命题，
  占位状态不改变命题真伪，仅约束下游报告/论文措辞。

  proof body 全部 `sorry` 占位（形式化部只交付 statement；良定义门由宪兵 gate-batch 集中跑）。
-/

import Mathlib

/-- **序列 apend（主列，order-8 仅偶滞后递推）**。
初值 a(0..7) = 3, 10, 46, 141, 660, 2015, 9440, 28814；
递推 a(n+8) = 16·a(n+6) − 25·a(n+4) + 10·a(n+2) − a(n)（n ≥ 0）。 -/
def apend : ℕ → ℤ
  | 0 => 3
  | 1 => 10
  | 2 => 46
  | 3 => 141
  | 4 => 660
  | 5 => 2015
  | 6 => 9440
  | 7 => 28814
  | n + 8 =>
      16 * apend (n + 6) - 25 * apend (n + 4) + 10 * apend (n + 2) - apend n

/-- **序列 opend（奇位侧子列，四阶递推）**。
初值 o(0..3) = 3, 46, 660, 9440（= apend 在下标 0,2,4,6 处之值；
数值与 OEIS A386889 一致——该侧已占位，见文件头围栏）；
递推 o(k+4) = 16·o(k+3) − 25·o(k+2) + 10·o(k+1) − o(k)（k ≥ 0）。 -/
def opend : ℕ → ℤ
  | 0 => 3
  | 1 => 46
  | 2 => 660
  | 3 => 9440
  | k + 4 =>
      16 * opend (k + 3) - 25 * opend (k + 2) + 10 * opend (k + 1) - opend k

/-- **序列 epend（偶位侧子列，四阶递推）**。
初值 e(0..3) = 10, 141, 2015, 28814（= apend 在下标 1,3,5,7 处之值）；
递推 e(k+4) = 16·e(k+3) − 25·e(k+2) + 10·e(k+1) − e(k)（k ≥ 0）。 -/
def epend : ℕ → ℤ
  | 0 => 10
  | 1 => 141
  | 2 => 2015
  | 3 => 28814
  | k + 4 =>
      16 * epend (k + 3) - 25 * epend (k + 2) + 10 * epend (k + 1) - epend k

/-- **T1（主攻）**：主列 order-8 递推 = 两条同系数四阶子列的交织——
对一切 k，apend (2k) = opend k 且 apend (2k+1) = epend k。 -/
theorem apend_interleave (k : ℕ) :
    apend (2 * k) = opend k ∧ apend (2 * k + 1) = epend k := by
  sorry

/-- **余数样式 pat2**（12 留数类 ↦ 余数）：
0↦1, 1↦0, 2↦0, 3↦1, 4↦0, 5↦1, 6↦0, 7↦0, 8↦1, 9↦1, 10↦0, 11↦1。 -/
def pat2 : ℕ → ℤ
  | 0 => 1
  | 1 => 0
  | 2 => 0
  | 3 => 1
  | 4 => 0
  | 5 => 1
  | 6 => 0
  | 7 => 0
  | 8 => 1
  | 9 => 1
  | 10 => 0
  | _ => 1

/-- **T2（伴随）**：apend 的 mod 2 余数仅依赖 n mod 12，样式为 pat2。 -/
theorem apend_mod2_period12 (n r : ℕ) (hr : n % 12 = r) :
    apend n % 2 = pat2 r := by
  sorry

/-- **余数样式 pat6**：0↦1, 4↦1，其余↦0（订正后口径：奇 ⟺ k ≡ 0 或 4 (mod 6)）。 -/
def pat6 : ℕ → ℤ
  | 0 => 1
  | 4 => 1
  | _ => 0

/-- **余数样式 pat3**：0↦0，其余↦1（订正后口径：偶 ⟺ k ≡ 0 (mod 3)）。 -/
def pat3 : ℕ → ℤ
  | 0 => 0
  | _ => 1

/-- **T3 之 opend（伴随）**：opend k 的 mod 2 余数仅依赖 k mod 6，样式为 pat6
（即 opend k 为奇 ⟺ k ≡ 0 或 4 (mod 6)）。 -/
theorem opend_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    opend k % 2 = pat6 r := by
  sorry

/-- **T3 之 epend（伴随）**：epend k 的 mod 2 余数仅依赖 k mod 3，样式为 pat3
（即 epend k 为偶 ⟺ k ≡ 0 (mod 3)）。 -/
theorem epend_mod2_period3 (k r : ℕ) (hr : k % 3 = r) :
    epend k % 2 = pat3 r := by
  sorry
