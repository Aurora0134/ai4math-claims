/-
  AI4Math 流水线 · AI 生成 · 2026-09-28
  部门：02 形式化部 statement 生成（proof body 一律 sorry 占位，终稿由 04 军政部完成）
  执行形态：zcode 端点 scripts/agent-call.py 拒派（exit 2 预期），生成类动作按
    SOP 02《约束·执行形态》兜底条款走主会话派发；1 次派发 = 1 采样，已记 budget.log。
  任务线：comb-07（pool-comb-07 · 3×n 网格删两对角角的全匹配数 · 七阶递推线）
  来源卡：tasks/20260928-comb07-diagnotch/card.md（闸门一 2026-09-28 立项）
  主张定稿：tasks/20260928-comb07-diagnotch/phase0/claims.md
    （T1 主攻交织恒等式 + T2 伴随主列 mod 2 周期 12 + T3 伴随两子列 mod 2 周期 6；
    T4 备选不进首批）
  初值数据出处：phase0/counts.txt + phase0/modscan.txt（卡面 14 项逐位 PASS、
    异构三法交叉PASS、递推外推 50 项全成立、有理域极小阶恰 7；
    子列最小阶拟合各 7 阶、系数逐字相同（46,−303,671,−519,167,−22,1），
    自由检验点各 66）；
    全部 def 的初值/系数/样式逐字照抄 claims.md「(b) Lean statement 草案」节；
    形式化部此前另用 python 对 adiag/onotch/enotch 前 10 项做了交织一致性复算
    （o、e 双边递推值与主列奇/偶位逐位一致，含递推在第 8–10 项的外推）、
    三条 mod 2 样式在各自窗口复算全真，数值与 claims.md 台账一致。

  口径（按任务卡锁定，逐字沿用）：
  kernel 层只证「递推定义版序列」（ℕ → ℤ 的 def，初值与整数系数递推显式写进 def）
  的定理；statement 不含图/网格/匹配组合对象。「a(n) = 该图的匹配数」是组合语义桥，
  不进 theorem 层；论文按「已证定理（公式侧）+ 计数猜想（语义侧）」两级呈现。
  索引口径（0-based Lean ↔ 1-based 计数，claims.md 写死）：
  adiag n = a(n+1)；onotch k = a(2k+1) = 1-based 奇位；enotch k = a(2k+2) = 1-based 偶位。

  【占位围栏】PM（完美匹配）偶 n 子列 = OEIS A061278 已挂名占位，禁止以其作新颖性
  主张；价值级「新序列·新递推」成立（七阶递推与母族 A033506 不同谱，
  2026-09-28 机器双向核验互不满足）。（后续论文措辞不得越此围栏，逐字沿用。）
  statement 层仅为纯序列命题，占位状态不改变命题真伪，仅约束下游报告/论文措辞；
  本文件措辞不得把 PM 子列（A061278，PM 口径禁单体，数值 1,5,20,76,…）拉进主张。

  proof body 由军政部完成；良定义门由宪兵 gate-batch 集中跑（单定理骨架
  gate-<定理名>.lean 与本文件同目录）。
-/

import Mathlib

/-- **序列 adiag（主列，七阶递推）**。
初值 a(0..6) = 1, 5, 33, 204, 1266, 7873, 48882（0-based；对应 1-based a(1..7)）；
递推 a(n+7) = 4·a(n+6) + 15·a(n+5) − 5·a(n+4) − 19·a(n+3)
            + 9·a(n+2) + 2·a(n+1) − a(n)（n ≥ 0）。 -/
def adiag : ℕ → ℤ
  | 0 => 1
  | 1 => 5
  | 2 => 33
  | 3 => 204
  | 4 => 1266
  | 5 => 7873
  | 6 => 48882
  | n + 7 =>
      4 * adiag (n + 6) + 15 * adiag (n + 5) - 5 * adiag (n + 4)
        - 19 * adiag (n + 3) + 9 * adiag (n + 2) + 2 * adiag (n + 1) - adiag n

/-- **序列 onotch（1-based 奇位子列，与 enotch 同系数的七阶递推）**。
初值 o(0..6) = 1, 33, 1266, 48882, 1886600, 72804880, 2809532937
（= adiag 在下标 0,2,4,6,8,10,12 处之值）；
递推 o(k+7) = 46·o(k+6) − 303·o(k+5) + 671·o(k+4) − 519·o(k+3)
            + 167·o(k+2) − 22·o(k+1) + o(k)（k ≥ 0）。 -/
def onotch : ℕ → ℤ
  | 0 => 1
  | 1 => 33
  | 2 => 1266
  | 3 => 48882
  | 4 => 1886600
  | 5 => 72804880
  | 6 => 2809532937
  | k + 7 =>
      46 * onotch (k + 6) - 303 * onotch (k + 5) + 671 * onotch (k + 4)
        - 519 * onotch (k + 3) + 167 * onotch (k + 2) - 22 * onotch (k + 1) + onotch k

/-- **序列 enotch（1-based 偶位子列，与 onotch 同系数的七阶递推）**。
初值 e(0..6) = 5, 204, 7873, 303723, 11720017, 452270456, 17453021829
（= adiag 在下标 1,3,5,7,9,11,13 处之值）；
递推 e(k+7) = 46·e(k+6) − 303·e(k+5) + 671·e(k+4) − 519·e(k+3)
            + 167·e(k+2) − 22·e(k+1) + e(k)（k ≥ 0）。 -/
def enotch : ℕ → ℤ
  | 0 => 5
  | 1 => 204
  | 2 => 7873
  | 3 => 303723
  | 4 => 11720017
  | 5 => 452270456
  | 6 => 17453021829
  | k + 7 =>
      46 * enotch (k + 6) - 303 * enotch (k + 5) + 671 * enotch (k + 4)
        - 519 * enotch (k + 3) + 167 * enotch (k + 2) - 22 * enotch (k + 1) + enotch k

/-- **T1（主攻·交织恒等式）**：对一切 k，adiag (2k) = onotch k 且
adiag (2k+1) = enotch k。即：主列的完整七阶递推 = 两条同系数
（46,−303,671,−519,167,−22,1）七阶子列递推（onotch/enotch）的交织，
两者互相刻画（0-based；对应 1-based 的 a(2k+1)=o(k)、a(2k+2)=e(k)）。 -/
theorem adiag_interleave (k : ℕ) :
    adiag (2 * k) = onotch k ∧ adiag (2 * k + 1) = enotch k := by
  sorry

/-- **余数样式 pat2**（12 留数类 ↦ mod 2 余数）：
0↦1, 1↦1, 2↦1, 3↦0, 4↦0, 5↦1, 6↦0, 7↦1, 8↦0, 9↦1, 10↦0, 11↦0。 -/
def pat2 : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | 2 => 1
  | 3 => 0
  | 4 => 0
  | 5 => 1
  | 6 => 0
  | 7 => 1
  | 8 => 0
  | 9 => 1
  | 10 => 0
  | _ => 0

/-- **T2（伴随·主列 mod 2 周期 12 显式样式）**：adiag n 的 mod 2 余数仅依赖
n mod 12，样式为 pat2（即 adiag n 为奇 ⟺ n ≡ 0,1,2,5,7,9 (mod 12)）。 -/
theorem adiag_mod2_period12 (n r : ℕ) (hr : n % 12 = r) :
    adiag n % 2 = pat2 r := by
  sorry

/-- **余数样式 pat6o**（onotch 侧 6 留数类 ↦ mod 2 余数）：
0↦1, 1↦1, 其余↦0（即 onotch k 为奇 ⟺ k ≡ 0 或 1 (mod 6)）。 -/
def pat6o : ℕ → ℤ
  | 0 => 1
  | 1 => 1
  | _ => 0

/-- **余数样式 pat6e**（enotch 侧 6 留数类 ↦ mod 2 余数）：
1↦0, 5↦0, 其余↦1（即 enotch k 为偶 ⟺ k ≡ 1 或 5 (mod 6)）。 -/
def pat6e : ℕ → ℤ
  | 1 => 0
  | 5 => 0
  | _ => 1

/-- **T3 之 onotch（伴随·奇位子列 mod 2 周期 6 样式）**：onotch k 的 mod 2 余数
仅依赖 k mod 6，样式为 pat6o（即 onotch k 为奇 ⟺ k ≡ 0 或 1 (mod 6)）。 -/
theorem onotch_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    onotch k % 2 = pat6o r := by
  sorry

/-- **T3 之 enotch（伴随·偶位子列 mod 2 周期 6 样式）**：enotch k 的 mod 2 余数
仅依赖 k mod 6，样式为 pat6e（即 enotch k 为偶 ⟺ k ≡ 1 或 5 (mod 6)）。 -/
theorem enotch_mod2_period6 (k r : ℕ) (hr : k % 6 = r) :
    enotch k % 2 = pat6e r := by
  sorry
