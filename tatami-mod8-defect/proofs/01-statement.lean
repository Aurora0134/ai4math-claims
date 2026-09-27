/-
  AI4Math 流水线 · AI 生成 · 2026-09-26
  部门：02 形式化部（dept-formalize）  任务：20260926-beian-select 候选01 Tatami 缺陷位形
  文件性质：冻结 statement（宪条2——自此 statement 段任何人不得改动；证明侧只许替换
  proof body 的 sorry 占位）。三个定理 proof body 一律 `:= by sorry`（SOP 02 占位）。

  语义唯一事实源：candidates/01-tatami-defect-review.md 人话区块
  + tmp-probe/gate-batch.src.lean（r2 冒烟 kernel 验收文本，WELLDEF OK /
    探针 8xFAIL / #check 6xOK / axioms 恰白名单）。

  与任务派发草形的差异点（以冒烟验收文本为准，语义无漂移）：
  1. P1 采用 r2 验收的 binder 形态 `(n r : ℕ) (hn : 4 ≤ n) (hr : n % 4 = r)`，
     与派发草形的 ∀ 命题形态 elaboration 后同一命题（currying）。
  2. pat8 采用 r2 验收文本的通配分支 `| _ => 6`：r=3 时为 6；r≥4 时亦为 6，
     但 P1 假设 `n % 4 = r` 使 r≥4 时前提不可满足（n % 4 < 4），语义不漂移。
  3. bcorner 的 b(0) 为约定值 0（3×0 棋盘无角格可去；递推自 n=10 起最远回看
     b(n-6)=b(4)，P2/P3 量程 n≥4 / n≥10，任何定理结论均不依赖 b(0)..b(3) 之外的
     约定——b(1)..b(9) 全部为探针实枚举值）。

  序列语义分层（组合含义不形式化，依选题院定题口径）：
  a180970 / bcorner 均为「递推定义版整数序列」；「= A180970 = tatami 铺法计数」由
  OEIS 记录 + Erickson–Ruskey 文献背书（不形式化）；bcorner 的角孔组合含义按
  计算猜想分级（本机精确枚举探针 n≤20 + 转移矩阵一般理论）。
-/

import Mathlib

/-- A180970 as a recurrence-defined sequence: base values a(0..8) and the
order-6 recurrence a(n) = a(n-1) + 2 a(n-2) + 2 a(n-4) - a(n-5) - a(n-6)
for n ≥ 9 (OEIS signature (1,2,0,2,-1,-1)). -/
def a180970 : ℕ → ℤ
  | 0 => 1
  | 1 => 3
  | 2 => 13
  | 3 => 22
  | 4 => 44
  | 5 => 90
  | 6 => 196
  | 7 => 406
  | 8 => 852
  | n + 9 =>
      a180970 (n + 8) + 2 * a180970 (n + 7) + 2 * a180970 (n + 5)
        - a180970 (n + 4) - a180970 (n + 3)

/-- Residue pattern: a(n) % 8 = pat8 (n % 4). -/
def pat8 : ℕ → ℤ
  | 0 => 4
  | 1 => 2
  | 2 => 4
  | _ => 6

/-- Corner-defect sequence b_c(n), recurrence-defined version: tatami tilings of a
3×n grid with one corner cell removed.  Base values b(1..9) from exact enumeration
(machine probe, n ≤ 20); b(0) := 0 is a conventional value (a 3×0 grid has no corner
cell) — no theorem below depends on it.  For n ≥ 10 the same order-6 recurrence as
the base sequence holds: b(n) = b(n-1) + 2 b(n-2) + 2 b(n-4) - b(n-5) - b(n-6). -/
def bcorner : ℕ → ℤ
  | 0 => 0
  | 1 => 2
  | 2 => 8
  | 3 => 24
  | 4 => 41
  | 5 => 85
  | 6 => 177
  | 7 => 381
  | 8 => 787
  | 9 => 1655
  | n + 10 =>
      bcorner (n + 9) + 2 * bcorner (n + 8) + 2 * bcorner (n + 6)
        - bcorner (n + 5) - bcorner (n + 4)

/-- **P1 (主攻)**: the mod-8 residue of A180970(n) depends only on n mod 4,
with pattern (4, 2, 4, 6) — equivalently a(n) % 8 = pat8 (n % 4) for all n ≥ 4.
Statement form verbatim from the r2 smoke-round kernel-accepted text. -/
theorem tatami_mod8_period4 (n r : ℕ) (hn : 4 ≤ n) (hr : n % 4 = r) :
    a180970 n % 8 = pat8 r := by
  sorry

/-- **P2 (伴随)**: the corner-defect sequence b_c(n) is odd for all n ≥ 4. -/
theorem bcorner_odd (n : ℕ) (hn : 4 ≤ n) :
    bcorner n % 2 = 1 := by
  sorry

/-- **P3 (伴随)**: exact defect↔base linear identity for n ≥ 10:
20·b(n) = 4a(n) + 33a(n-1) - 9a(n-2) + 8a(n-3) + a(n-4) - 3a(n-5). -/
theorem bcorner_eq (n : ℕ) (hn : 10 ≤ n) :
    20 * bcorner n = 4 * a180970 n + 33 * a180970 (n - 1) - 9 * a180970 (n - 2)
      + 8 * a180970 (n - 3) + a180970 (n - 4) - 3 * a180970 (n - 5) := by
  sorry
