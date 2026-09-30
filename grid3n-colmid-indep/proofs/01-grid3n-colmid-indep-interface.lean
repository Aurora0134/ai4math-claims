import Mathlib

open Finset SimpleGraph Matrix

/-!
# comb-12 接口冻结件（formalized/interface.lean，2026-09-30）

任务：tasks/20260930-comb12-grid-indep（pool-comb-12 全流程）
冻结 statement 来源：tasks/20260929-preselect-deeprecheck-01/attempts/L13C/statement.lean
  （sha256 b726f0d8e01672b39a93ce0c256f5036014bc80f7f0b6a5fcb484272d805c884）

本文件 = ①冻结 statement 的声明段（逐字节）+ ②攻证接口（新增 def，kernel 实测可编）
+ ③转移矩阵证书（`decide` 一击闭，严格模式实测 exit 0）。

**接口纪律**：本文件在最终稿中逐字节保留；证明员只读引用，不得改写其中任何声明。
-/

-- ============================================================
-- 段一：冻结 statement（逐字节，禁改）
-- ============================================================

instance (n : ℕ) : DecidableRel (pathGraph n).Adj := fun _ _ =>
  decidable_of_iff _ pathGraph_adj.symm

instance {α β : Type*} [DecidableEq α] [DecidableEq β] (G : SimpleGraph α) (H : SimpleGraph β)
    [DecidableRel G.Adj] [DecidableRel H.Adj] : DecidableRel (G □ H).Adj := fun _ _ =>
  decidable_of_iff _ boxProd_adj.symm

/-- 与挖点集 `holes` 不交的独立集数 = 挖去 `holes` 后剩余图的独立集数。 -/
def indepCountHoles (m n : ℕ) (holes : Finset (Fin m × Fin n)) : ℕ :=
  ((univ : Finset (Finset (Fin m × Fin n))).filter (fun s =>
    Disjoint s holes ∧ (pathGraph m □ pathGraph n).IsIndepSet s)).card

/-- 隔列挖中点缺陷集：`Fin m × Fin n` 中行号 = 1（中行）且列号为奇数的点，
0 基行列，即 (1, 1), (1, 3), (1, 5), …（`Finset.univ.filter` 口径，不经 `Subgraph.induce`）。 -/
def holes (m n : ℕ) : Finset (Fin m × Fin n) :=
  (univ : Finset (Fin m × Fin n)).filter (fun p => p.1.val = 1 ∧ p.2.val % 2 = 1)

/-- 三行带每隔一列挖去中行顶点所得图的独立集数列。 -/
def z (n : ℕ) : ℕ := indepCountHoles 3 n (holes 3 n)

-- ============================================================
-- 段二：攻证接口（新增；证明员只读引用，不改写）
-- ============================================================

/-- 列切片：点集 `s` 在第 `j` 列上的行集合。 -/
def colSlice (n : ℕ) (j : Fin n) (s : Finset (Fin 3 × Fin n)) : Finset (Fin 3) :=
  univ.filter (fun r => (r, j) ∈ s)

/-- 偶列（无洞）允许的剖面集：全 5 个竖直独立剖面。 -/
def Pprof : Finset (Finset (Fin 3)) := {∅, {0}, {1}, {2}, {0, 2}}

/-- 奇列（有洞，禁中行）允许的剖面集：4 个不含行 1 的竖直独立剖面。 -/
def Qprof : Finset (Finset (Fin 3)) := {∅, {0}, {2}, {0, 2}}

/-- 第 `j` 列（0 基）允许的剖面集：奇列禁中行，偶列全允许。 -/
def allowed (j : ℕ) : Finset (Finset (Fin 3)) := if j % 2 = 1 then Qprof else Pprof

/-- 剖面函数合法性：每列剖面合法，且相邻两列剖面不交。 -/
def ValidProf (n : ℕ) (f : Fin n → Finset (Fin 3)) : Prop :=
  (∀ j : Fin n, f j ∈ allowed j.val) ∧
    (∀ j j' : Fin n, (pathGraph n).Adj j j' → Disjoint (f j) (f j'))

/-- `ValidProf` 的可判定性实例（显式给出，使 `validCount` 的 `filter` 实例唯一、
定义上透明：`validCount n = (univ.filter (ValidProf n)).card` 按 `rfl` 成立）。
不显式给会走 `classical` 盲选，证明里另写的同形 filter 会拿到不同实例，两侧
命题相等但不同定义，`card_bij` 直接卡死。 -/
instance (n : ℕ) : DecidablePred (ValidProf n) := fun f => by
  unfold ValidProf
  infer_instance

/-- 合法剖面函数计数。
（`noncomputable`：上面的可判定实例内部含经典判定；公理走白名单内 `Classical.choice`。） -/
noncomputable def validCount (n : ℕ) : ℕ :=
  ((univ : Finset (Fin n → Finset (Fin 3))).filter (ValidProf n)).card

/-- 由剖面函数重建点集：第 `j` 列取 `f j` 中的行。 -/
def reconstruct (n : ℕ) (f : Fin n → Finset (Fin 3)) : Finset (Fin 3 × Fin n) :=
  univ.biUnion (fun j => (f j).image (fun r => (r, j)))

-- ============================================================
-- 段三：转移矩阵与证书（`decide` 一击闭；已严格模式实测 exit 0）
-- ============================================================

/-- 剖面枚举（偶列侧，5 个）。 -/
def P5 : Fin 5 → Finset (Fin 3)
  | 0 => ∅
  | 1 => {0}
  | 2 => {1}
  | 3 => {2}
  | 4 => {0, 2}

/-- 剖面枚举（奇列侧，4 个）。 -/
def Q4 : Fin 4 → Finset (Fin 3)
  | 0 => ∅
  | 1 => {0}
  | 2 => {2}
  | 3 => {0, 2}

/-- 偶→奇转移矩阵：`Amat i j = 1` 当且仅当剖面 `P5 i` 与 `Q4 j` 不交。 -/
def Amat : Matrix (Fin 5) (Fin 4) ℤ := fun i j => if Disjoint (P5 i) (Q4 j) then 1 else 0

/-- 奇→偶转移矩阵：`Bmat i j = 1` 当且仅当剖面 `Q4 i` 与 `P5 j` 不交。 -/
def Bmat : Matrix (Fin 4) (Fin 5) ℤ := fun i j => if Disjoint (Q4 i) (P5 j) then 1 else 0

/-- 双步转移矩阵 `T = A·B`（5×5）。 -/
def Tmat : Matrix (Fin 5) (Fin 5) ℤ := Amat * Bmat

/-- 全 1 向量（5 维）。 -/
def ones5 : Fin 5 → ℤ := fun _ => 1

/-- 全 1 向量（4 维）。 -/
def ones4 : Fin 4 → ℤ := fun _ => 1

/-- 偶侧初值向量 `vec0 = A·1`（5 维；分量 = 与 `P5 i` 不交的奇剖面个数）。 -/
def vec0 : Fin 5 → ℤ := Amat *ᵥ ones4

/-- 证书一：`p(T)·1 = 0`（点态），`p(x) = x³ − 12x² + 15x − 2`。 -/
theorem cert_ones : ∀ i : Fin 5,
    ((Tmat ^ 3) *ᵥ ones5) i
      = 12 * (((Tmat ^ 2) *ᵥ ones5) i) - 15 * ((Tmat ^ 1) *ᵥ ones5) i + 2 * ones5 i := by
  decide

/-- 证书二：`p(T)·vec0 = 0`（点态）。 -/
theorem cert_vec0 : ∀ i : Fin 5,
    ((Tmat ^ 3) *ᵥ vec0) i
      = 12 * (((Tmat ^ 2) *ᵥ vec0) i) - 15 * ((Tmat ^ 1) *ᵥ vec0) i + 2 * vec0 i := by
  decide

-- ============================================================
-- 段四：名册核验（本文件编译即证下列名字存在；供证据包引用）
-- ============================================================

#check @Finset.card_bij
#check @Finset.card_biUnion
#check @Finset.card_sigma
#check @Finset.card_filter
#check @Finset.card_image_of_injOn
#check @Finset.mem_biUnion
#check @Finset.mem_image
#check @Finset.disjoint_left
#check @Finset.filter_filter
#check @Finset.sum_filter
#check @Finset.sum_boole
#check @Finset.sum_biUnion
#check @Finset.card_eq_sum_ones
#check @Fintype.card_congr
#check @Fintype.card_fin
#check @SimpleGraph.isIndepSet_iff
#check @SimpleGraph.boxProd_adj
#check @SimpleGraph.pathGraph_adj
#check @Nat.strong_induction_on
#check @Fin.last

-- 攻证期实测可用的 API 名册（2026-09-30 探针核实）——
#check @Finset.card_bij -- 依赖型签名：i : (a : α) → a ∈ s → β（带成员性证明）
#check @Fintype.card_congr -- 取 Equiv
#check @Finset.card_image_of_injOn
#check @Matrix.mulVec -- 记号 `M ᵥ* v`：(M ᵥ* v) i = ∑ j, M i j * v j
#check @Matrix.vecMul -- 记号 `v ᵥ* M`：(v ᵥ* M) j = ∑ i, v i * M i j
#check @Finset.sum_image
-- 实测不存在：`Matrix.dotProduct`（勿回喂该名字）

/-!
## 攻证须知（2026-09-30 实测，写 Lean 前必读）

1. **`decide` 无法从图定义直接算 z**：`example : z 0 = 1 := by decide` 实测失败
   （reduction 在 `instDecidableEqNat (z 0) 1` 处卡死）。z 的一切具体取值都必须走
   `z = validCount = 矩阵表达式` 路线后用 `decide` 闭（5×5 整数矩阵规模，
   `cert_ones`/`cert_vec0` 已实测 `decide` 一击闭）。
   **禁止用 `native_decide`**：它引入 `Lean.ofReduceBool`，不在公理白名单
   {propext, Quot.sound, Classical.choice} 内，入库即拒收（宪条 3）。
2. `validCount n = (univ.filter (ValidProf n)).card` 按 `rfl` 成立（见上方显式实例）；
   证明里可直接 `unfold validCount` 或 `show`。
3. `z 0 = 1` 不要从图定义硬算：走 `z 0 = validCount 0`（桥梁引理）+
   `validCount 0 = 1`（`Fin 0 → Finset (Fin 3)` 是 subsingleton，univ 恰一元素且合法）。
-/
