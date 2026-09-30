import Mathlib

open Finset Polynomial SimpleGraph

/-!
# L13-C 窄口 statement：隔列挖中点独立集计数列 z 的六阶递推

- NL 命题源：深挖卡 `tasks/20260928-lineage-recon-01/deep/L13-defective-grid-independent-set.md` §1 窄口 C。
- **形态声明**：主定理取任务书主形（ℕ 截断减法形）
  `∀ n : ℕ, 6 ≤ n → z n + 15 * z (n - 4) = 12 * z (n - 2) + 2 * z (n - 6)`；
  截断减法在 `6 ≤ n` 假设下逐次自洽（n−4 ≤ n、n−2 ≤ n、n−6 ≤ n），未改系数 15/12/2 与方向。
- 高危结构处置：无整数除法 / min-max / 分段 / 大求和；唯一高危点 = 缺陷集的
  `Finset.univ.filter` 表达（深挖卡 S13-1 已定形：holes + Disjoint 口径，不走 Subgraph.induce），
  以及 `pathGraph` / `□` 邻接的 `DecidableRel` 实例链（照抄 B-deep-smokes.lean 已过 kernel 的两条 instance）。
- `holes m n`：顶点集 `Fin m × Fin n` 中**中行（第 1 行）且列号为奇数**的点集（0 基行列，
  即 (1, 1), (1, 3), (1, 5), …）；以 `p.1.val = 1 ∧ p.2.val % 2 = 1` 表达，避免 `Fin m` 上的
  `OfNat` 字面量实例（变量 m 处不可合成）。
- 初值段 `native_decide` 仅为数据核验（引入 `Lean.ofReduceBool`，非公理白名单，非入库形态）。
-/

-- 底座三件（照抄 smoke/B-deep-smokes.lean 已实测通过的写法）——

instance (n : ℕ) : DecidableRel (pathGraph n).Adj := fun _ _ =>
  decidable_of_iff _ pathGraph_adj.symm

instance {α β : Type*} [DecidableEq α] [DecidableEq β] (G : SimpleGraph α) (H : SimpleGraph β)
    [DecidableRel G.Adj] [DecidableRel H.Adj] : DecidableRel (G □ H).Adj := fun _ _ =>
  decidable_of_iff _ boxProd_adj.symm

/-- 与挖点集 `holes` 不交的独立集数 = 挖去 `holes` 后剩余图的独立集数。 -/
def indepCountHoles (m n : ℕ) (holes : Finset (Fin m × Fin n)) : ℕ :=
  ((univ : Finset (Finset (Fin m × Fin n))).filter (fun s =>
    Disjoint s holes ∧ (pathGraph m □ pathGraph n).IsIndepSet s)).card

-- 缺陷集与计数列 z ——

/-- 隔列挖中点缺陷集：`Fin m × Fin n` 中行号 = 1（中行）且列号为奇数的点，
0 基行列，即 (1, 1), (1, 3), (1, 5), …（`Finset.univ.filter` 口径，不经 `Subgraph.induce`）。 -/
def holes (m n : ℕ) : Finset (Fin m × Fin n) :=
  (univ : Finset (Fin m × Fin n)).filter (fun p => p.1.val = 1 ∧ p.2.val % 2 = 1)

/-- 三行带每隔一列挖去中行顶点所得图的独立集数列。 -/
def z (n : ℕ) : ℕ := indepCountHoles 3 n (holes 3 n)

-- 主定理（proof 占位：本任务只产 statement）——

/-- z 的六阶递推（ℕ 截断减法形，系数 15/12/2 与方向依任务书不动）。 -/
theorem c_z_rec : ∀ n : ℕ, 6 ≤ n → z n + 15 * z (n - 4) = 12 * z (n - 2) + 2 * z (n - 6) := by
  sorry

-- 初值段（数据核验，native_decide 非入库形态；值 = 深挖卡 §6 tm2/tm3 本机实算）——

example : z 0 = 1 := by native_decide

example : z 1 = 5 := by native_decide

example : z 2 = 13 := by native_decide

example : z 3 = 47 := by native_decide

example : z 4 = 141 := by native_decide
