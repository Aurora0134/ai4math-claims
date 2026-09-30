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
-- ============================================================
-- 段 A · 桥梁恒等式 `z n = validCount n`（攻证员：桥梁证明员）
-- 前缀纪律：全部新引理 `br_` 开头（guide §7.2），不含接口已有声明。
-- 数学路线：guide §3（Finset 双射：独立集 ↔ 合法剖面函数）
-- ============================================================

/-!
### A0. 两侧计数对象与定义展开

`br_S1` / `br_S2` 与 `indepCountHoles` / `validCount` 的 filter 同形，
`DecidablePred` 实例链与 interface 段一/段二完全一致（`card_bij` 实例陷阱的
防法：不另写同形 filter，只复用这两个 def）。
-/

/-- 桥侧辅助：`z n` 所数的对象 = 三行 n 列图中与 `holes 3 n` 不交的独立集。 -/
def br_S1 (n : ℕ) : Finset (Finset (Fin 3 × Fin n)) :=
  (univ : Finset (Finset (Fin 3 × Fin n))).filter (fun s =>
    Disjoint s (holes 3 n) ∧ (pathGraph 3 □ pathGraph n).IsIndepSet s)

/-- 桥侧辅助：`validCount n` 所数的对象 = 合法剖面函数。 -/
def br_S2 (n : ℕ) : Finset (Fin n → Finset (Fin 3)) :=
  (univ : Finset (Fin n → Finset (Fin 3))).filter (ValidProf n)

theorem br_z_eq_card_S1 (n : ℕ) : z n = (br_S1 n).card := rfl

theorem br_validCount_eq_card_S2 (n : ℕ) : validCount n = (br_S2 n).card := rfl

theorem br_mem_S1 (n : ℕ) (s : Finset (Fin 3 × Fin n)) (hd : Disjoint s (holes 3 n))
    (hi : (pathGraph 3 □ pathGraph n).IsIndepSet s) : s ∈ br_S1 n :=
  Finset.mem_filter.mpr ⟨Finset.mem_univ s, hd, hi⟩

theorem br_mem_S2 (n : ℕ) (f : Fin n → Finset (Fin 3)) (h : ValidProf n f) :
    f ∈ br_S2 n := Finset.mem_filter.mpr ⟨Finset.mem_univ f, h⟩

/-!
### A1. 成员性小工具（列切片 / 重建 / 缺陷集 / 邻接 / 独立集改写）

全部按 `defeq` 释义展开（`have h' : <展开形> := h`），不依赖 `rw` 对
beta-可约元的匹配，规避 guide §6 之外另发现的 `rw` 匹配坑。
-/

/-- 列切片成员性：`r ∈ colSlice n j s ↔ (r, j) ∈ s`（定义直接展开）。 -/
theorem br_mem_colSlice (n : ℕ) (j : Fin n) (s : Finset (Fin 3 × Fin n)) (r : Fin 3) :
    r ∈ colSlice n j s ↔ (r, j) ∈ s := by
  constructor
  · intro h
    have h' : r ∈ univ.filter (fun r => (r, j) ∈ s) := h
    exact (Finset.mem_filter.mp h').2
  · intro h
    exact Finset.mem_filter.mpr ⟨Finset.mem_univ r, h⟩

/-- 重建成员性：`(r, j) ∈ reconstruct n f ↔ r ∈ f j`（定义直接展开）。 -/
theorem br_mem_reconstruct (n : ℕ) (f : Fin n → Finset (Fin 3)) (r : Fin 3) (j : Fin n) :
    (r, j) ∈ reconstruct n f ↔ r ∈ f j := by
  constructor
  · intro h
    have h' : (r, j) ∈ univ.biUnion (fun j' => (f j').image (fun r' => (r', j'))) := h
    obtain ⟨j', hj', himg⟩ := Finset.mem_biUnion.mp h'
    have himg' : (r, j) ∈ (f j').image (fun r' => (r', j')) := himg
    obtain ⟨r', hr', heq⟩ := Finset.mem_image.mp himg'
    obtain ⟨h1, h2⟩ := Prod.mk_inj.mp heq
    subst h2
    exact h1 ▸ hr'
  · intro hr
    have himg : (r, j) ∈ (f j).image (fun r' => (r', j)) :=
      Finset.mem_image.mpr ⟨r, hr, rfl⟩
    exact Finset.mem_biUnion.mpr ⟨j, Finset.mem_univ j, himg⟩

/-- 缺陷集成员性（中行点）。 -/
theorem br_mem_holes_iff (n : ℕ) (j : Fin n) :
    ((1 : Fin 3), j) ∈ holes 3 n ↔ j.val % 2 = 1 := by
  simp [holes, Finset.mem_filter]

/-- 缺陷集成员性（一般行）。 -/
theorem br_mem_holes_iff_row (n : ℕ) (r : Fin 3) (j : Fin n) :
    (r, j) ∈ holes 3 n ↔ r.val = 1 ∧ j.val % 2 = 1 := by
  simp [holes, Finset.mem_filter]

/-- 盒积邻接·竖直分量（逐字即 `SimpleGraph.boxProd_adj_left`）。 -/
theorem br_adj_vert {n : ℕ} {r r' : Fin 3} {j : Fin n} :
    (pathGraph 3 □ pathGraph n).Adj (r, j) (r', j) ↔ (pathGraph 3).Adj r r' :=
  boxProd_adj_left

/-- 盒积邻接·水平分量（逐字即 `SimpleGraph.boxProd_adj_right`）。 -/
theorem br_adj_horiz {n : ℕ} {r : Fin 3} {j j' : Fin n} :
    (pathGraph 3 □ pathGraph n).Adj (r, j) (r, j') ↔ (pathGraph n).Adj j j' :=
  boxProd_adj_right

/-- `IsIndepSet`（`Set.Pairwise` 形）改写为干净的 ∀∀ 否定形。
mathlib v4.34 中 `Set.Pairwise s r` 带 `x ≠ y` 前提（`Logic/Pairwise.lean:83`），
而 `SimpleGraph.ne_of_adj` 总能把该前提免费补上。 -/
theorem br_isIndepSet_iff_forall {m n : ℕ} (s : Finset (Fin m × Fin n)) :
    (pathGraph m □ pathGraph n).IsIndepSet s ↔
      ∀ a b : Fin m × Fin n, a ∈ s → b ∈ s → ¬(pathGraph m □ pathGraph n).Adj a b := by
  constructor
  · intro h a b ha hb habj
    exact h (Finset.mem_coe.mpr ha) (Finset.mem_coe.mpr hb) (ne_of_adj _ habj) habj
  · intro h
    exact fun a ha b hb _ habj => h a b (Finset.mem_coe.mp ha) (Finset.mem_coe.mp hb) habj

/-!
### A2. 竖直独立剖面的有限枚举（`Pprof` / `Qprof` 小引理）

`Finset (Fin 3)` 只有 8 个子集；枚举入口用 `fin_cases`（实测 `interval_cases`
不支持 `Fin 3`，见 notes）与 5/4 路 `Finset.mem_insert` 链。
-/

/-- 不含中行 ⇒ 属于奇列允许集 `Qprof`。 -/
theorem br_Qprof_of_not_mem_one (t : Finset (Fin 3)) (h : (1 : Fin 3) ∉ t) :
    t ∈ Qprof := by
  have hsub : t ⊆ ({0, 2} : Finset (Fin 3)) := by
    intro r hr
    fin_cases r
    · exact Finset.mem_insert.2 (Or.inl rfl)
    · exact absurd hr h
    · exact Finset.mem_insert.2 (Or.inr (Finset.mem_singleton.2 rfl))
  have hps : ({0, 2} : Finset (Fin 3)).powerset = Qprof := by decide
  rw [← hps]
  exact Finset.mem_powerset.mpr hsub

/-- 奇列允许集的成员不含中行。 -/
theorem br_Qprof_not_mem_one (t : Finset (Fin 3)) (h : t ∈ Qprof) : (1 : Fin 3) ∉ t := by
  rw [Qprof, Finset.mem_insert, Finset.mem_insert, Finset.mem_insert,
    Finset.mem_singleton] at h
  rcases h with h | h | h | h <;> subst h <;> decide

/-- 列内无竖直相邻 ⇒ 属于偶列允许集 `Pprof`。 -/
theorem br_Pprof_of_indep (t : Finset (Fin 3))
    (h : ∀ r r' : Fin 3, (pathGraph 3).Adj r r' → r ∈ t → r' ∈ t → False) :
    t ∈ Pprof := by
  by_cases h1 : (1 : Fin 3) ∈ t
  · have h0 : (0 : Fin 3) ∉ t := fun h0' => h 0 1 (by decide) h0' h1
    have h2 : (2 : Fin 3) ∉ t := fun h2' => h 1 2 (by decide) h1 h2'
    have hsub : t ⊆ ({(1 : Fin 3)} : Finset (Fin 3)) := by
      intro r hr
      fin_cases r
      · exact absurd hr h0
      · exact Finset.mem_singleton.2 rfl
      · exact absurd hr h2
    have hsub' : ({(1 : Fin 3)} : Finset (Fin 3)) ⊆ t := by
      intro r hr
      have hr1 : r = (1 : Fin 3) := Finset.mem_singleton.1 hr
      rw [hr1]
      exact h1
    have hcard : t = {(1 : Fin 3)} := Finset.Subset.antisymm hsub hsub'
    rw [hcard]
    decide
  · have hQ : t ∈ Qprof := br_Qprof_of_not_mem_one t h1
    have hQP : Qprof ⊆ Pprof := by decide
    exact hQP hQ

/-- 允许剖面（`Pprof` 成员）竖直无相邻：`A14` 偶列支的唯一入口。 -/
theorem br_Pprof_vert_indep (t : Finset (Fin 3)) (h : t ∈ Pprof) (r r' : Fin 3)
    (hadj : (pathGraph 3).Adj r r') (hr : r ∈ t) (hr' : r' ∈ t) : False := by
  have hcases : t = ∅ ∨ t = {(0 : Fin 3)} ∨ t = {(1 : Fin 3)} ∨ t = {(2 : Fin 3)}
      ∨ t = {(0 : Fin 3), (2 : Fin 3)} := by
    rw [Pprof, Finset.mem_insert, Finset.mem_insert, Finset.mem_insert, Finset.mem_insert,
      Finset.mem_singleton] at h
    tauto
  rcases hcases with h | h | h | h | h <;> subst h
  · simp at hr
  · rw [Finset.mem_singleton] at hr hr'
    subst hr
    subst hr'
    exact absurd hadj (by decide)
  · rw [Finset.mem_singleton] at hr hr'
    subst hr
    subst hr'
    exact absurd hadj (by decide)
  · rw [Finset.mem_singleton] at hr hr'
    subst hr
    subst hr'
    exact absurd hadj (by decide)
  · rw [Finset.mem_insert, Finset.mem_singleton] at hr hr'
    rcases hr with hr | hr <;> rcases hr' with hr' | hr' <;>
      subst hr <;> subst hr' <;> exact absurd hadj (by decide)

/-!
### A3. 奇偶列的允许集
-/

theorem br_allowed_odd (j : ℕ) (h : j % 2 = 1) : allowed j = Qprof := by
  simp [allowed, h]

theorem br_allowed_even (j : ℕ) (h : j % 2 ≠ 1) : allowed j = Pprof := by
  simp [allowed, h]

/-!
### A4. 双射两条互逆方向（guide §3.1 条 1、2）
-/

/-- 桥梁方向一：`ψ (φ s) = s`，无需任何假设（guide §3.1 条 1）。 -/
theorem br_reconstruct_colSlice (n : ℕ) (s : Finset (Fin 3 × Fin n)) :
    reconstruct n (fun j => colSlice n j s) = s := by
  apply Finset.ext
  intro p
  obtain ⟨r, j⟩ := p
  constructor
  · intro h
    exact (br_mem_colSlice n j s r).mp
      ((br_mem_reconstruct n (fun j => colSlice n j s) r j).mp h)
  · intro h
    exact (br_mem_reconstruct n (fun j => colSlice n j s) r j).mpr
      ((br_mem_colSlice n j s r).mpr h)

/-- 桥梁方向二：`φ (ψ f) = f`，只用到 `Prod.mk.injEq`，不需要 loopless（guide §3.1 条 2）。 -/
theorem br_colSlice_reconstruct (n : ℕ) (f : Fin n → Finset (Fin 3)) (j : Fin n) :
    colSlice n j (reconstruct n f) = f j := by
  apply Finset.ext
  intro r
  exact (br_mem_colSlice n j (reconstruct n f) r).trans (br_mem_reconstruct n f r j)

/-!
### A5. 桥梁方向三、四（合法剖面 ↔ 独立集）
-/

/-- 桥梁方向三：与 holes 不交的独立集 ⇒ 合法剖面（guide §3.1 条 3）。 -/
theorem br_ValidProf_of_mem_S1 (n : ℕ) (s : Finset (Fin 3 × Fin n)) (h : s ∈ br_S1 n) :
    ValidProf n (fun j => colSlice n j s) := by
  obtain ⟨hd, hi⟩ := (Finset.mem_filter.mp h).2
  have hi' : ∀ a b : Fin 3 × Fin n, a ∈ s → b ∈ s →
      ¬(pathGraph 3 □ pathGraph n).Adj a b := (br_isIndepSet_iff_forall s).mp hi
  refine ⟨?_, ?_⟩
  · intro j
    show colSlice n j s ∈ allowed j.val
    by_cases hodd : j.val % 2 = 1
    · rw [br_allowed_odd j.val hodd]
      refine br_Qprof_of_not_mem_one _ ?_
      intro h1
      have hmem : ((1 : Fin 3), j) ∈ s := (br_mem_colSlice n j s 1).mp h1
      have hnot : ((1 : Fin 3), j) ∉ holes 3 n := Finset.disjoint_left.mp hd hmem
      exact hnot ((br_mem_holes_iff n j).mpr hodd)
    · rw [br_allowed_even j.val hodd]
      refine br_Pprof_of_indep _ ?_
      intro r r' hadj hr hr'
      exact hi' (r, j) (r', j) ((br_mem_colSlice n j s r).mp hr)
        ((br_mem_colSlice n j s r').mp hr') ((br_adj_vert).mpr hadj)
  · intro j j' hadj
    rw [Finset.disjoint_left]
    intro r hrj hrj'
    exact hi' (r, j) (r, j') ((br_mem_colSlice n j s r).mp hrj)
      ((br_mem_colSlice n j' s r).mp hrj') ((br_adj_horiz).mpr hadj)

/-- 桥梁方向四：合法剖面 ⇒ 与 holes 不交的独立集（guide §3.1 条 4）。 -/
theorem br_mem_S1_of_ValidProf (n : ℕ) (f : Fin n → Finset (Fin 3)) (h : ValidProf n f) :
    reconstruct n f ∈ br_S1 n := by
  obtain ⟨hcol, hadjcol⟩ := h
  refine br_mem_S1 n (reconstruct n f) ?_ ?_
  · rw [Finset.disjoint_left]
    intro p hp
    obtain ⟨r, j⟩ := p
    rw [br_mem_reconstruct] at hp
    by_contra hcon
    rw [br_mem_holes_iff_row] at hcon
    obtain ⟨hval, hodd⟩ := hcon
    have hr1 : r = (1 : Fin 3) := by
      have : r.val = ((1 : Fin 3)).val := by rw [hval]; rfl
      exact Fin.val_injective this
    subst hr1
    have hcolj : f j ∈ allowed j.val := hcol j
    rw [br_allowed_odd j.val hodd] at hcolj
    exact br_Qprof_not_mem_one _ hcolj hp
  · rw [br_isIndepSet_iff_forall]
    intro a b ha hb habj
    obtain ⟨ra, ja⟩ := a
    obtain ⟨rb, jb⟩ := b
    rw [br_mem_reconstruct] at ha hb
    rcases boxProd_adj.mp habj with ⟨hvert, hj⟩ | ⟨hhoriz, hr⟩
    · -- 竖直邻接：同列相邻行
      have hvert' : (pathGraph 3).Adj ra rb := hvert
      have hj' : ja = jb := hj
      rw [← hj'] at hb
      have hP : f ja ∈ Pprof := by
        have hcolj : f ja ∈ allowed ja.val := hcol ja
        by_cases hodd : ja.val % 2 = 1
        · rw [br_allowed_odd ja.val hodd] at hcolj
          have hQP : Qprof ⊆ Pprof := by decide
          exact hQP hcolj
        · rw [br_allowed_even ja.val hodd] at hcolj
          exact hcolj
      exact br_Pprof_vert_indep _ hP ra rb hvert' ha hb
    · -- 水平邻接：同行相邻列
      have hhoriz' : (pathGraph n).Adj ja jb := hhoriz
      have hr' : ra = rb := hr
      rw [hr'] at ha
      have hdis : Disjoint (f ja) (f jb) := hadjcol ja jb hhoriz'
      exact Finset.disjoint_left.mp hdis ha hb

/-!
### A6. 计数相等（`Finset.card_bij`，guide §3.2）
-/

/-- 桥梁主引理：`z n = validCount n`（独立集 ↔ 合法剖面函数的双射）。 -/
theorem br_z_eq_validCount (n : ℕ) : z n = validCount n := by
  rw [br_z_eq_card_S1, br_validCount_eq_card_S2]
  refine Finset.card_bij (fun s _ => fun j => colSlice n j s) ?_ ?_ ?_
  · intro s hs
    exact br_mem_S2 n _ (br_ValidProf_of_mem_S1 n s hs)
  · intro s1 hs1 s2 hs2 heq
    have h1 : reconstruct n (fun j => colSlice n j s1)
        = reconstruct n (fun j => colSlice n j s2) := congrArg (reconstruct n) heq
    rw [br_reconstruct_colSlice, br_reconstruct_colSlice] at h1
    exact h1
  · intro b hb
    have hbv : ValidProf n b := (Finset.mem_filter.mp hb).2
    refine ⟨reconstruct n b, br_mem_S1_of_ValidProf n b hbv, ?_⟩
    funext j
    exact br_colSlice_reconstruct n b j

-- ============================================================
-- 段 B：转移 validCount n = 矩阵表达式（guide §4）
-- ============================================================

/-- 转移侧辅助：前 `m + 1` 列合法填法数，且最后一列剖面恰为 `p`（guide §4.2）。 -/
def tr_fillEnd : ℕ → Finset (Fin 3) → ℕ
  | 0, _ => 0
  | m + 1, p =>
    ((univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
      (fun f => ValidProf (m + 1) f ∧ f (Fin.last m) = p)).card

/-- 转移侧辅助：偶侧向量 `Vv k = Tmat ^ k *ᵥ ones5` 的递归形式（guide §4.2；
记号按 §6 用 `*ᵥ`（mulVec，矩阵在左），guide 正文的 `ᵥ*` 为同义简写）。 -/
def tr_Vv : ℕ → Fin 5 → ℤ
  | 0 => fun _ => 1
  | k + 1 => Tmat *ᵥ tr_Vv k

/-! ### Fin 列指标的分解小引理 -/

/-- `Fin (n + 1)` 的元素要么是某个 `Fin n` 元素的 `castSucc`，要么是 `Fin.last n`。 -/
theorem tr_fin_cases {n : ℕ} (i : Fin (n + 1)) :
    (∃ j : Fin n, i = j.castSucc) ∨ i = Fin.last n := by
  rcases Nat.lt_or_ge i.val n with h | h
  · left
    exact ⟨⟨i.val, h⟩, Fin.ext (by simp)⟩
  · right
    exact Fin.ext (by simp only [Fin.val_last]; have := i.isLt; omega)

/-- `pathGraph` 邻接在 `castSucc` 下保持。 -/
theorem tr_adj_castSucc {n : ℕ} (i j : Fin n) :
    (pathGraph (n + 1)).Adj (i.castSucc) (j.castSucc) ↔ (pathGraph n).Adj i j := by
  rw [pathGraph_adj, pathGraph_adj, Fin.val_castSucc, Fin.val_castSucc]

/-- `Fin (m + 2)` 的末两列相邻。 -/
theorem tr_adj_last_pair {m : ℕ} :
    (pathGraph (m + 1 + 1)).Adj ((Fin.last m).castSucc) (Fin.last (m + 1)) := by
  rw [pathGraph_adj, Fin.val_castSucc]
  simp only [Fin.val_last]
  exact Or.inl trivial

/-- `Fin (m + 2)` 中与末列相邻的只能是倒数第二列。 -/
theorem tr_adj_last_neighbor {m : ℕ} {i : Fin (m + 1)}
    (h : (pathGraph (m + 1 + 1)).Adj (i.castSucc) (Fin.last (m + 1))) : i = Fin.last m := by
  rw [pathGraph_adj, Fin.val_castSucc] at h
  simp only [Fin.val_last] at h
  have hi := i.isLt
  rcases h with h1 | h1
  · exact Fin.ext (by simp only [Fin.val_last]; omega)
  · exfalso; omega

/-- `Fin 1` 的唯一元素就是 `Fin.last 0`。 -/
theorem tr_fin_one_eq (i : Fin (0 + 1)) : i = Fin.last 0 :=
  Fin.ext (by simp only [Fin.val_last]; have := i.isLt; omega)

/-! ### B1 / B2：剖面枚举 -/

/-- B1a：`P5` 枚举恰为 Pprof。 -/
theorem tr_P5_image : Finset.image P5 univ = Pprof := by
  decide

/-- B1b：`P5` 单射。 -/
theorem tr_P5_inj : Function.Injective P5 := by
  decide

/-- B2a：`Q4` 枚举恰为 Qprof。 -/
theorem tr_Q4_image : Finset.image Q4 univ = Qprof := by
  decide

/-- B2b：`Q4` 单射。 -/
theorem tr_Q4_inj : Function.Injective Q4 := by
  decide

/-! ### B3：allowed 的奇偶 -/

/-- B3a：偶列允许集 = Pprof。 -/
theorem tr_allowed_double (j : ℕ) : allowed (2 * j) = Pprof := by
  simp [allowed]

/-- B3b：奇列允许集 = Qprof。 -/
theorem tr_allowed_double_succ (j : ℕ) : allowed (2 * j + 1) = Qprof := by
  simp [allowed]

/-! ### B4：单列基例 -/

/-- `ValidProf 1` 只约束唯一那一列。 -/
theorem tr_ValidProf_one (f : Fin (0 + 1) → Finset (Fin 3)) :
    ValidProf (0 + 1) f ↔ f (Fin.last 0) ∈ allowed 0 := by
  constructor
  · intro h
    exact h.1 (Fin.last 0)
  · intro h
    refine ⟨fun j => ?_, fun j j' hj => ?_⟩
    · have hji := tr_fin_one_eq j
      rw [hji]
      exact h
    · exfalso
      rw [pathGraph_adj] at hj
      have hj1 := j.isLt
      have hj2 := j'.isLt
      omega

/-- B4：单列递推基例。 -/
theorem tr_fillEnd_one (p : Finset (Fin 3)) :
    tr_fillEnd 1 p = if p ∈ allowed 0 then 1 else 0 := by
  by_cases hp : p ∈ allowed 0
  · have hif : (if p ∈ allowed 0 then 1 else 0) = 1 := by simp [hp]
    rw [hif]
    have h1 : tr_fillEnd 1 p
        = ((univ : Finset (Fin (0 + 1) → Finset (Fin 3))).filter
            (fun f => ValidProf (0 + 1) f ∧ f (Fin.last 0) = p)).card := rfl
    rw [h1]
    have h2 : ((univ : Finset (Fin (0 + 1) → Finset (Fin 3))).filter
        (fun f => ValidProf (0 + 1) f ∧ f (Fin.last 0) = p))
        = {fun _ : Fin (0 + 1) => p} := by
      ext f
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_singleton]
      rw [tr_ValidProf_one]
      constructor
      · rintro ⟨h1, h2⟩
        funext i
        have hii := tr_fin_one_eq i
        rw [hii]
        exact h2
      · rintro rfl
        exact ⟨hp, rfl⟩
    rw [h2, Finset.card_singleton]
  · have hif : (if p ∈ allowed 0 then 1 else 0) = 0 := by simp [hp]
    rw [hif]
    have h1 : tr_fillEnd 1 p
        = ((univ : Finset (Fin (0 + 1) → Finset (Fin 3))).filter
            (fun f => ValidProf (0 + 1) f ∧ f (Fin.last 0) = p)).card := rfl
    rw [h1]
    have h2 : ((univ : Finset (Fin (0 + 1) → Finset (Fin 3))).filter
        (fun f => ValidProf (0 + 1) f ∧ f (Fin.last 0) = p)) = ∅ := by
      ext f
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.notMem_empty]
      exact ⟨fun h => hp (h.2 ▸ h.1.1 (Fin.last 0)), fun h => h.elim⟩
    rw [h2, Finset.card_empty]

/-! ### B5：填法数的双步递推 -/

/-- 砍掉末列：`ValidProf (m + 2) f` 给出前 `m + 1` 列的 `ValidProf (m + 1) (Fin.init f)`。 -/
theorem tr_validProf_init {m : ℕ} (f : Fin (m + 1 + 1) → Finset (Fin 3))
    (h : ValidProf (m + 1 + 1) f) : ValidProf (m + 1) (Fin.init f) := by
  refine ⟨fun i => ?_, fun i i' hi => ?_⟩
  · exact h.1 (i.castSucc)
  · exact h.2 (i.castSucc) (i'.castSucc) ((tr_adj_castSucc i i').2 hi)

/-- 接上末列：`Fin.snoc g p` 合法当且仅当 `g` 合法、`p` 在末列允许集、且与倒数第二列不交。 -/
theorem tr_validProf_snoc {m : ℕ} (g : Fin (m + 1) → Finset (Fin 3)) (p : Finset (Fin 3))
    (hg : ValidProf (m + 1) g) (hp : p ∈ allowed (m + 1))
    (hdisj : Disjoint (g (Fin.last m)) p) :
    ValidProf (m + 1 + 1) (Fin.snoc (α := fun _ => Finset (Fin 3)) g p) := by
  refine ⟨fun j => ?_, fun j j' hadj => ?_⟩
  · rcases tr_fin_cases j with ⟨i, rfl⟩ | hlast
    · rw [Fin.snoc_castSucc]
      exact hg.1 i
    · rw [hlast, Fin.snoc_last, Fin.val_last]
      exact hp
  · rcases tr_fin_cases j with ⟨i, rfl⟩ | hj
    · rcases tr_fin_cases j' with ⟨i', rfl⟩ | hj'
      · rw [Fin.snoc_castSucc, Fin.snoc_castSucc]
        exact hg.2 i i' ((tr_adj_castSucc i i').mp hadj)
      · rw [hj'] at hadj
        rw [hj', Fin.snoc_last, Fin.snoc_castSucc]
        have hi : i = Fin.last m := tr_adj_last_neighbor hadj
        rw [hi]
        exact hdisj
    · rcases tr_fin_cases j' with ⟨i', rfl⟩ | hj'
      · rw [hj] at hadj
        rw [hj, Fin.snoc_last, Fin.snoc_castSucc]
        have hi' : i' = Fin.last m := tr_adj_last_neighbor (Adj.symm hadj)
        rw [hi']
        refine Finset.disjoint_left.mpr fun r hr hr' => ?_
        exact Finset.disjoint_left.mp hdisj hr' hr
      · exfalso
        rw [hj, hj', pathGraph_adj] at hadj
        simp only [Fin.val_last] at hadj
        omega

/-- B5：填法数的双步递推（先走奇列 Amat 加权，再走偶列 Bmat 加权）。 -/
theorem tr_fillEnd_step (m : ℕ) (p : Finset (Fin 3)) :
    tr_fillEnd (m + 2) p
      = if p ∈ allowed (m + 1) then
          ∑ q ∈ allowed m, (if Disjoint q p then 1 else 0) * tr_fillEnd (m + 1) q
        else 0 := by
  have hL : tr_fillEnd (m + 2) p
      = ((univ : Finset (Fin (m + 1 + 1) → Finset (Fin 3))).filter
          (fun f => ValidProf (m + 1 + 1) f ∧ f (Fin.last (m + 1)) = p)).card := rfl
  rw [hL]
  split_ifs with hp
  · -- 主情形：末列剖面 p 合法
    have hcard : ((univ : Finset (Fin (m + 1 + 1) → Finset (Fin 3))).filter
        (fun f => ValidProf (m + 1 + 1) f ∧ f (Fin.last (m + 1)) = p)).card
        = ((allowed m).biUnion (fun q => (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
            (fun g => ValidProf (m + 1) g ∧ g (Fin.last m) = q ∧ Disjoint q p))).card := by
      apply Finset.card_bij (i := fun f _ => Fin.init f)
      · -- 映入
        intro f hf
        obtain ⟨-, hval, hfp⟩ := Finset.mem_filter.mp hf
        refine Finset.mem_biUnion.mpr ⟨f ((Fin.last m).castSucc), ?_, ?_⟩
        · exact hval.1 ((Fin.last m).castSucc)
        · refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩
          refine ⟨tr_validProf_init f hval, rfl, ?_⟩
          exact hfp ▸ hval.2 ((Fin.last m).castSucc) (Fin.last (m + 1)) tr_adj_last_pair
      · -- 单射
        intro f₁ hf₁ f₂ hf₂ h
        obtain ⟨-, hv1, hl1⟩ := Finset.mem_filter.mp hf₁
        obtain ⟨-, hv2, hl2⟩ := Finset.mem_filter.mp hf₂
        calc f₁ = Fin.snoc (α := fun _ => Finset (Fin 3)) (Fin.init f₁) (f₁ (Fin.last (m + 1))) :=
              (Fin.snoc_init_self f₁).symm
          _ = Fin.snoc (α := fun _ => Finset (Fin 3)) (Fin.init f₂) (f₁ (Fin.last (m + 1))) := by
              rw [h]
          _ = Fin.snoc (α := fun _ => Finset (Fin 3)) (Fin.init f₂) (f₂ (Fin.last (m + 1))) := by
              rw [hl1, hl2]
          _ = f₂ := Fin.snoc_init_self f₂
      · -- 满射
        intro b hb
        obtain ⟨q, hqm, hbf⟩ := Finset.mem_biUnion.mp hb
        obtain ⟨-, hbval, hblast, hbdisj⟩ := Finset.mem_filter.mp hbf
        refine ⟨Fin.snoc (α := fun _ => Finset (Fin 3)) b p, ?_, ?_⟩
        · refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩
          refine ⟨tr_validProf_snoc b p hbval hp (hblast ▸ hbdisj),
            Fin.snoc_last (α := fun _ => Finset (Fin 3)) p b⟩
        · exact Fin.init_snoc (α := fun _ => Finset (Fin 3)) p b
    rw [hcard, Finset.card_biUnion]
    · refine Finset.sum_congr rfl fun q hq => ?_
      split_ifs with hd
      · rw [one_mul]
        have hfib : (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
            (fun g => ValidProf (m + 1) g ∧ g (Fin.last m) = q ∧ Disjoint q p)
            = (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
              (fun g => ValidProf (m + 1) g ∧ g (Fin.last m) = q) := by
          ext g
          simp only [Finset.mem_filter, Finset.mem_univ, true_and, hd, and_true]
        rw [hfib]
        rfl
      · have hfib : (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
            (fun g => ValidProf (m + 1) g ∧ g (Fin.last m) = q ∧ Disjoint q p) = ∅ := by
          ext g
          simp only [Finset.mem_filter, Finset.mem_univ, hd, and_false]
          exact ⟨fun h => h.elim, fun h => Finset.notMem_empty g h⟩
        rw [hfib, Finset.card_empty, zero_mul]
    · -- 纤维两两不交
      intro a ha b hb hab x hxa hxb y hy
      exfalso
      apply hab
      have h1 : y (Fin.last m) = a := (((Finset.mem_filter.mp (hxa hy)).right).right).left
      have h2 : y (Fin.last m) = b := (((Finset.mem_filter.mp (hxb hy)).right).right).left
      rw [← h1, ← h2]
  · -- 末列剖面不允许：filter 为空
    have hempty : (univ : Finset (Fin (m + 1 + 1) → Finset (Fin 3))).filter
        (fun f => ValidProf (m + 1 + 1) f ∧ f (Fin.last (m + 1)) = p) = ∅ := by
      ext f
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.notMem_empty, iff_false]
      rintro ⟨hval, hfp⟩
      exact hp (hfp ▸ hval.1 (Fin.last (m + 1)))
    rw [hempty, Finset.card_empty]

/-! ### B6：零列恰一合法填法 -/

/-- B6：零列恰一合法填法。 -/
theorem tr_validCount_zero : validCount 0 = 1 := by
  have hval : ∀ f : Fin 0 → Finset (Fin 3), ValidProf 0 f := fun f =>
    ⟨fun j => Fin.elim0 j, fun j j' _ => Fin.elim0 j⟩
  have hfil : (univ : Finset (Fin 0 → Finset (Fin 3))).filter (ValidProf 0) = univ := by
    ext f
    simp [hval]
  have hsub : Subsingleton (Fin 0 → Finset (Fin 3)) :=
    Subsingleton.intro fun a b => by
      funext j
      exact Fin.elim0 j
  have hcard : (univ : Finset (Fin 0 → Finset (Fin 3))).card = 1 := by
    have h1 : (univ : Finset (Fin 0 → Finset (Fin 3))).card ≤ 1 :=
      Finset.card_le_one.mpr fun a _ b _ => Subsingleton.elim a b
    have h2 : 0 < (univ : Finset (Fin 0 → Finset (Fin 3))).card :=
      Finset.card_pos.mpr Finset.univ_nonempty
    omega
  simp only [validCount]
  rw [hfil, hcard]

/-! ### B7：合法剖面数 = 按末列剖面求和 -/

/-- B7：合法剖面数 = 按末列剖面求和。 -/
theorem tr_validCount_succ (m : ℕ) :
    validCount (m + 1) = ∑ p ∈ allowed m, tr_fillEnd (m + 1) p := by
  have hfib : (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter (ValidProf (m + 1))
      = (allowed m).biUnion (fun p => (univ : Finset (Fin (m + 1) → Finset (Fin 3))).filter
          (fun f => ValidProf (m + 1) f ∧ f (Fin.last m) = p)) := by
    ext f
    simp only [Finset.mem_filter, Finset.mem_biUnion, Finset.mem_univ, true_and]
    constructor
    · intro h
      refine ⟨f (Fin.last m), h.1 (Fin.last m), h, rfl⟩
    · rintro ⟨p, -, hf, hfp⟩
      exact hf
  rw [validCount, hfib]
  rw [Finset.card_biUnion]
  · rfl
  · intro a ha b hb hab x hxa hxb y hy
    exfalso
    apply hab
    have h1 : y (Fin.last m) = a := ((Finset.mem_filter.mp (hxa hy)).right).right
    have h2 : y (Fin.last m) = b := ((Finset.mem_filter.mp (hxb hy)).right).right
    rw [← h1, ← h2]

/-! ### B8 / B9 的辅助：枚举成员性、cast 处理、if 权重对齐、联合归纳 -/

/-- 用可判定条件的证明化简 `if`（取真支）。 -/
theorem tr_if_pos {α : Type} {c : Prop} [Decidable c] (h : c) (a b : α) :
    (if c then a else b) = a := by
  simp [h]

/-- ℕ → ℤ 的 cast 穿过 `if`。 -/
theorem tr_cast_if {c : Prop} [Decidable c] (a b : ℕ) :
    ((if c then a else b : ℕ) : ℤ) = if c then (a : ℤ) else (b : ℤ) := by
  by_cases h : c
  · simp [h]
  · simp [h]

/-- ℕ → ℤ 的 cast 穿过 `(if c then 1 else 0) * f`（一步到位）。 -/
theorem tr_cast_ite_mul {c : Prop} [Decidable c] (f : ℕ) :
    (((if c then 1 else 0) * f : ℕ) : ℤ) = (if c then (1 : ℤ) else 0) * (f : ℤ) := by
  by_cases h : c
  · simp [h]
  · simp [h]

/-- `P5` 的每个分量都在 `Pprof` 中。 -/
theorem tr_P5_mem (i : Fin 5) : P5 i ∈ Pprof := by
  rw [← tr_P5_image]
  exact Finset.mem_image.mpr ⟨i, Finset.mem_univ i, rfl⟩

/-- `Q4` 的每个分量都在 `Qprof` 中。 -/
theorem tr_Q4_mem (j : Fin 4) : Q4 j ∈ Qprof := by
  rw [← tr_Q4_image]
  exact Finset.mem_image.mpr ⟨j, Finset.mem_univ j, rfl⟩

/-- `P5` 在 `univ` 上单射（`sum_image` 用）。 -/
theorem tr_P5_injOn : Set.InjOn P5 (↑(univ : Finset (Fin 5))) := by
  intro a _ b _ h
  exact tr_P5_inj h

/-- `Q4` 在 `univ` 上单射（`sum_image` 用）。 -/
theorem tr_Q4_injOn : Set.InjOn Q4 (↑(univ : Finset (Fin 4))) := by
  intro a _ b _ h
  exact tr_Q4_inj h

/-- 不交 `if` 权重交换两参数后相同（ℤ 系数版）。 -/
theorem tr_ite_disjoint_comm (a b : Finset (Fin 3)) :
    (if Disjoint a b then (1 : ℤ) else 0) = (if Disjoint b a then (1 : ℤ) else 0) := by
  by_cases h : Disjoint a b
  · have h' : Disjoint b a := _root_.disjoint_comm.mp h
    simp [h, h']
  · have h' : ¬ Disjoint b a := fun h' => h (_root_.disjoint_comm.mpr h')
    simp [h, h']

/-- `Amat i j = Bmat j i`（不交条件交换两个剖面）。 -/
theorem tr_Amat_eq_Bmat (i : Fin 5) (j : Fin 4) : Amat i j = Bmat j i := by
  show (if Disjoint (P5 i) (Q4 j) then (1 : ℤ) else 0)
    = (if Disjoint (Q4 j) (P5 i) then (1 : ℤ) else 0)
  exact tr_ite_disjoint_comm (P5 i) (Q4 j)

/-- 矩阵幂前移一步：`Tmat ^ (k + 1) = Tmat * Tmat ^ k`。 -/
theorem tr_pow_succ' (k : ℕ) : Tmat ^ (k + 1) = Tmat * Tmat ^ k := by
  rw [pow_succ]
  exact (Commute.eq ((Commute.refl Tmat).pow_right k)).symm

/-- B8/B9 的联合归纳形式（计数提升到 ℤ 后陈述）。 -/
theorem tr_fillEnd_pair (k : ℕ) :
    (∀ i : Fin 5, (tr_fillEnd (2 * k + 1) (P5 i) : ℤ) = ((Tmat ^ k) *ᵥ ones5) i) ∧
    (∀ j : Fin 4, (tr_fillEnd (2 * k + 2) (Q4 j) : ℤ) = (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j) := by
  induction k with
  | zero =>
    refine ⟨?_, ?_⟩
    · intro i
      rw [show 2 * 0 + 1 = 1 from by simp, tr_fillEnd_one, tr_cast_if,
        show allowed 0 = Pprof from by simp [allowed], tr_if_pos (tr_P5_mem i)]
      rw [pow_zero, Matrix.one_mulVec, Nat.cast_one]
      rfl
    · intro j
      rw [show 2 * 0 + 2 = 0 + 2 from by simp, tr_fillEnd_step, tr_cast_if,
        show (0 : ℕ) + 1 = 1 from by simp, show allowed 1 = Qprof from by simp [allowed],
        show allowed 0 = Pprof from by simp [allowed], tr_if_pos (tr_Q4_mem j), Nat.cast_sum]
      rw [pow_zero, Matrix.one_mulVec]
      rw [← tr_P5_image, Finset.sum_image tr_P5_injOn]
      rw [show (Bmat *ᵥ ones5) j
          = ∑ i : Fin 5, (if Disjoint (Q4 j) (P5 i) then (1 : ℤ) else 0) * ones5 i from rfl]
      refine Finset.sum_congr rfl fun i _ => ?_
      have h1 : tr_fillEnd 1 (P5 i) = 1 := by
        rw [tr_fillEnd_one, show allowed 0 = Pprof from by simp [allowed],
          tr_if_pos (tr_P5_mem i)]
      rw [tr_cast_ite_mul, h1, Nat.cast_one, mul_one,
        show ones5 i = (1 : ℤ) from rfl, mul_one]
      exact tr_ite_disjoint_comm (P5 i) (Q4 j)
  | succ k ih =>
    obtain ⟨ihP, ihQ⟩ := ih
    have hallowed1 : allowed (2 * k + 1 + 1) = Pprof := by
      rw [show 2 * k + 1 + 1 = 2 * (k + 1) from by omega]
      exact tr_allowed_double (k + 1)
    have hallowed2 : allowed (2 * k + 2 + 1) = Qprof := by
      rw [show 2 * k + 2 + 1 = 2 * (k + 1) + 1 from by omega]
      exact tr_allowed_double_succ (k + 1)
    have hallowed3 : allowed (2 * k + 2) = Pprof := by
      rw [show 2 * k + 2 = 2 * (k + 1) from by omega]
      exact tr_allowed_double (k + 1)
    have hP1 : ∀ i : Fin 5,
        (tr_fillEnd (2 * (k + 1) + 1) (P5 i) : ℤ) = ((Tmat ^ (k + 1)) *ᵥ ones5) i := by
      intro i
      have key : ((Tmat ^ (k + 1)) *ᵥ ones5) i
          = ∑ j : Fin 4, Bmat j i * (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j := by
        have h1 : (Amat *ᵥ (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5))) = (Tmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) :=
          Matrix.mulVec_mulVec _ Amat Bmat
        rw [tr_pow_succ', ← Matrix.mulVec_mulVec, ← h1]
        show (∑ j : Fin 4, Amat i j * (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j) = _
        exact Finset.sum_congr rfl fun j _ => by rw [tr_Amat_eq_Bmat i j]
      rw [show 2 * (k + 1) + 1 = 2 * k + 1 + 2 from by omega, tr_fillEnd_step, tr_cast_if,
        hallowed1, tr_allowed_double_succ, tr_if_pos (tr_P5_mem i), Nat.cast_sum, key]
      rw [← tr_Q4_image, Finset.sum_image tr_Q4_injOn]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [tr_cast_ite_mul, show 2 * k + 1 + 1 = 2 * k + 2 from by omega, ihQ j]
      rfl
    refine ⟨hP1, ?_⟩
    intro j
    rw [show (Bmat *ᵥ ((Tmat ^ (k + 1)) *ᵥ ones5)) j
        = ∑ i : Fin 5, (if Disjoint (Q4 j) (P5 i) then (1 : ℤ) else 0)
            * ((Tmat ^ (k + 1)) *ᵥ ones5) i from rfl]
    rw [show 2 * (k + 1) + 2 = 2 * k + 2 + 2 from by omega, tr_fillEnd_step, tr_cast_if,
      hallowed2, hallowed3, tr_if_pos (tr_Q4_mem j), Nat.cast_sum]
    rw [← tr_P5_image, Finset.sum_image tr_P5_injOn]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [tr_cast_ite_mul, show 2 * k + 2 + 1 = 2 * (k + 1) + 1 from by omega, hP1 i,
      tr_ite_disjoint_comm (P5 i) (Q4 j)]

/-- `tr_Vv` 与矩阵幂表示一致（对 k 归纳）。 -/
theorem tr_Vv_eq (k : ℕ) : tr_Vv k = (Tmat ^ k) *ᵥ ones5 := by
  induction k with
  | zero =>
      rw [pow_zero, Matrix.one_mulVec]
      rfl
  | succ k ih =>
      rw [tr_Vv, ih, Matrix.mulVec_mulVec, tr_pow_succ']

/-- B8：奇列末的填法数 = `Tmat ^ k *ᵥ ones5` 分量。 -/
theorem tr_fillEnd_P5 (k : ℕ) (i : Fin 5) :
    tr_fillEnd (2 * k + 1) (P5 i) = ((Tmat ^ k) *ᵥ ones5) i :=
  (tr_fillEnd_pair k).1 i

/-- B9：偶列末的填法数 = `Bmat *ᵥ (Tmat ^ k *ᵥ ones5)` 分量。 -/
theorem tr_fillEnd_Q4 (k : ℕ) (j : Fin 4) :
    tr_fillEnd (2 * k + 2) (Q4 j) = (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j :=
  (tr_fillEnd_pair k).2 j

/-- B10：奇宽度计数 = ones5 侧矩阵和。 -/
theorem tr_validCount_odd (k : ℕ) :
    validCount (2 * k + 1) = ∑ i : Fin 5, ((Tmat ^ k) *ᵥ ones5) i := by
  rw [tr_validCount_succ, Nat.cast_sum, tr_allowed_double, ← tr_P5_image,
    Finset.sum_image tr_P5_injOn]
  exact Finset.sum_congr rfl fun i _ => tr_fillEnd_P5 k i

/-- B11：偶宽度计数 = vec0 侧矩阵和。 -/
theorem tr_validCount_even (k : ℕ) :
    validCount (2 * k + 2) = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j := by
  rw [show 2 * k + 2 = (2 * k + 1) + 1 from by omega, tr_validCount_succ, Nat.cast_sum,
    show (2 * k + 1) + 1 = 2 * k + 2 from by omega,
    tr_allowed_double_succ, ← tr_Q4_image, Finset.sum_image tr_Q4_injOn]
  exact Finset.sum_congr rfl fun j _ => tr_fillEnd_Q4 k j

-- ============================================================
-- 段 C：代数归约（组装员追加；新引理统一前缀 `asm_`，不与 br_ / tr_ 重名）
-- 数学路线：attempts/guide.md §5（证书 → w/u 递推 → 奇偶归约 → 唯一边界 n = 6）
-- ============================================================

/-!
### C0. 求和 / `*ᵥ` 的 ℤ-线性辅助

不复用 mathlib 分配律名（避免名字漂移），全部自证：`Finset.induction`
（`empty` / `insert` 两情形）+ `Finset.sum_insert` + `ring`。
`asm_mulVec_lin` 经 `Matrix.mulVec`（`dotProduct` 的点态展开）把 `M *ᵥ`
搬到分量上，再套 C0 的求和恒等式。
-/

/-- 常数倍过求和（左系数版）。 -/
theorem asm_mul_sum {ι : Type} (s : Finset ι) (c : ℤ) (g : ι → ℤ) :
    c * ∑ j ∈ s, g j = ∑ j ∈ s, c * g j := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, mul_add, ih]

/-- 两个求和的加法合并。 -/
theorem asm_sum_add {ι : Type} (s : Finset ι) (f g : ι → ℤ) :
    (∑ j ∈ s, f j) + (∑ j ∈ s, g j) = ∑ j ∈ s, (f j + g j) := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Finset.sum_insert ha]
      calc (f a + ∑ x ∈ s, f x) + (g a + ∑ x ∈ s, g x)
          = (f a + g a) + (∑ x ∈ s, f x + ∑ x ∈ s, g x) := by ring
        _ = (f a + g a) + ∑ x ∈ s, (f x + g x) := by rw [ih]

/-- 两个求和的减法合并。 -/
theorem asm_sum_sub {ι : Type} (s : Finset ι) (f g : ι → ℤ) :
    (∑ j ∈ s, f j) - (∑ j ∈ s, g j) = ∑ j ∈ s, (f j - g j) := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Finset.sum_insert ha]
      calc (f a + ∑ x ∈ s, f x) - (g a + ∑ x ∈ s, g x)
          = (f a - g a) + (∑ x ∈ s, f x - ∑ x ∈ s, g x) := by ring
        _ = (f a - g a) + ∑ x ∈ s, (f x - g x) := by rw [ih]

/-- ℤ-线性组合 `12 · a - 15 · b + 2 · c` 过求和。 -/
theorem asm_sum_lin {ι : Type} (s : Finset ι) (M : ι → ℤ) (a b c : ι → ℤ) :
    ∑ j ∈ s, M j * (12 * a j - 15 * b j + 2 * c j)
      = 12 * ∑ j ∈ s, M j * a j - 15 * ∑ j ∈ s, M j * b j + 2 * ∑ j ∈ s, M j * c j := by
  rw [asm_mul_sum, asm_mul_sum, asm_mul_sum, asm_sum_sub, asm_sum_add]
  exact Finset.sum_congr rfl fun j _ => by ring

/-!
### C1. w-递推 / u-递推（guide §5.1）

`cert_ones`（interface 段三）给 `k = 0` 的点态递推；`Matrix.mulVec_mulVec`
（向量占第一个显式参数位）+ 裸 `pow_add` 把 `Tmat ^ k *ᵥ` 前后搬，
`asm_mulVec_lin` 处理线性组合，得任意 `k` 的递推。u-递推由 w-递推对
`Bmat *ᵥ` 逐点搬得到（guide §5.1 末段）。
-/

/-- `M *ᵥ` 对点态 ℤ-线性组合的作用（分量形）。 -/
theorem asm_mulVec_lin (M : Matrix (Fin 5) (Fin 5) ℤ) (a b c : Fin 5 → ℤ) (i : Fin 5) :
    (M *ᵥ fun j => 12 * a j - 15 * b j + 2 * c j) i
      = 12 * (M *ᵥ a) i - 15 * (M *ᵥ b) i + 2 * (M *ᵥ c) i := by
  show ∑ j : Fin 5, M i j * (12 * a j - 15 * b j + 2 * c j)
      = 12 * (∑ j : Fin 5, M i j * a j) - 15 * (∑ j : Fin 5, M i j * b j)
        + 2 * (∑ j : Fin 5, M i j * c j)
  exact asm_sum_lin (s := (univ : Finset (Fin 5))) (fun j => M i j) a b c

/-- w-递推（点态）：`w k = Tmat ^ k *ᵥ ones5`。 -/
theorem asm_w_rec (k : ℕ) (i : Fin 5) :
    ((Tmat ^ (k + 3)) *ᵥ ones5) i
      = 12 * ((Tmat ^ (k + 2)) *ᵥ ones5) i - 15 * ((Tmat ^ (k + 1)) *ᵥ ones5) i
        + 2 * ((Tmat ^ k) *ᵥ ones5) i := by
  have hstep : (Tmat ^ (k + 3)) *ᵥ ones5 = (Tmat ^ k) *ᵥ ((Tmat ^ 3) *ᵥ ones5) := by
    rw [pow_add]
    exact (Matrix.mulVec_mulVec _ _ _).symm
  have hcert : (Tmat ^ 3) *ᵥ ones5
      = fun j => 12 * ((Tmat ^ 2) *ᵥ ones5) j - 15 * ((Tmat ^ 1) *ᵥ ones5) j + 2 * ones5 j := by
    funext j
    exact cert_ones j
  have e2 : (Tmat ^ k) *ᵥ ((Tmat ^ 2) *ᵥ ones5) = (Tmat ^ (k + 2)) *ᵥ ones5 := by
    rw [Matrix.mulVec_mulVec, ← pow_add]
  have e1 : (Tmat ^ k) *ᵥ ((Tmat ^ 1) *ᵥ ones5) = (Tmat ^ (k + 1)) *ᵥ ones5 := by
    rw [Matrix.mulVec_mulVec, ← pow_add]
  rw [hstep, hcert, asm_mulVec_lin, e2, e1]

/-- u-递推（点态）：`u k = Bmat *ᵥ (Tmat ^ k *ᵥ ones5)`。 -/
theorem asm_u_rec (k : ℕ) (j : Fin 4) :
    (Bmat *ᵥ ((Tmat ^ (k + 3)) *ᵥ ones5)) j
      = 12 * (Bmat *ᵥ ((Tmat ^ (k + 2)) *ᵥ ones5)) j
        - 15 * (Bmat *ᵥ ((Tmat ^ (k + 1)) *ᵥ ones5)) j + 2 * (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j := by
  show ∑ i : Fin 5, Bmat j i * (((Tmat ^ (k + 3)) *ᵥ ones5) i)
      = 12 * (∑ i : Fin 5, Bmat j i * (((Tmat ^ (k + 2)) *ᵥ ones5) i))
        - 15 * (∑ i : Fin 5, Bmat j i * (((Tmat ^ (k + 1)) *ᵥ ones5) i))
        + 2 * (∑ i : Fin 5, Bmat j i * (((Tmat ^ k) *ᵥ ones5) i))
  rw [asm_mul_sum, asm_mul_sum, asm_mul_sum, asm_sum_sub, asm_sum_add]
  exact Finset.sum_congr rfl fun i _ => by rw [asm_w_rec k i]; ring

/-- w-递推（求和形，奇侧用）。 -/
theorem asm_w_rec_sum (k : ℕ) :
    (∑ i : Fin 5, ((Tmat ^ (k + 3)) *ᵥ ones5) i)
      = 12 * (∑ i : Fin 5, ((Tmat ^ (k + 2)) *ᵥ ones5) i)
        - 15 * (∑ i : Fin 5, ((Tmat ^ (k + 1)) *ᵥ ones5) i) + 2 * (∑ i : Fin 5, ((Tmat ^ k) *ᵥ ones5) i) := by
  rw [asm_mul_sum, asm_mul_sum, asm_mul_sum, asm_sum_sub, asm_sum_add]
  exact Finset.sum_congr rfl fun i _ => asm_w_rec k i

/-- u-递推（求和形，偶侧用）。 -/
theorem asm_u_rec_sum (k : ℕ) :
    (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (k + 3)) *ᵥ ones5)) j)
      = 12 * (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (k + 2)) *ᵥ ones5)) j)
        - 15 * (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (k + 1)) *ᵥ ones5)) j)
        + 2 * (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ k) *ᵥ ones5)) j) := by
  rw [asm_mul_sum, asm_mul_sum, asm_mul_sum, asm_sum_sub, asm_sum_add]
  exact Finset.sum_congr rfl fun j _ => asm_u_rec k j

/-!
### C2. 主定理（陈述与 `formalized/statement.lean` 冻结件逐字一致）

按 guide §5.2–5.3 组装：
- 奇 `n = 2m + 1`（`6 ≤ n` ⟹ `m ≥ 3`）：走 w-递推，无边界情形；
- 偶 `n = 2m`（`n ≠ 6` ⟹ `m ≥ 4`）：走 u-递推；
- 唯一边界 `n = 6`：`z 6 / z 4 / z 2` 走矩阵和、`z 0 = 1` 走 B6，`decide` 闭。

ℕ/ℤ 口径：`tr_validCount_odd` / `tr_validCount_even` / `tr_validCount_zero`
的右端是 ℤ 矩阵和，故每个分支先把要用的等式搬到 ℤ（`have key : (… : ℤ) = …`），
分支内用 `omega` 收口；最后 `omega` 借 ℤ 假设回证 ℕ 目标（本机 kernel 实测
`omega` 可桥接 `Nat.cast` 两侧，见 `tmp-probe/comb12-asm-probe.lean` T2）。
`n - 4` / `n - 2` / `n - 6` 是 ℕ 截断减法，用 `omega` 翻译成 `2 * (m - k) + c` 形。
-/

theorem c_z_rec : ∀ n : ℕ, 6 ≤ n → z n + 15 * z (n - 4) = 12 * z (n - 2) + 2 * z (n - 6) := by
  intro n hn
  rcases eq_or_ne n 6 with rfl | hne
  · -- 唯一边界 n = 6
    have h4 : (6 - 4 : ℕ) = 2 := by decide
    have h2 : (6 - 2 : ℕ) = 4 := by decide
    have h0 : (6 - 6 : ℕ) = 0 := by decide
    have key : (z 6 : ℤ) + 15 * (z 2 : ℤ) = 12 * (z 4 : ℤ) + 2 * (z 0 : ℤ) := by
      have h1 : (z 6 : ℤ) = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 2) *ᵥ ones5)) j := by
        have h := tr_validCount_even 2
        rw [← br_z_eq_validCount (2 * 2 + 2)] at h
        exact h
      have h2' : (z 2 : ℤ) = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 0) *ᵥ ones5)) j := by
        have h := tr_validCount_even 0
        rw [← br_z_eq_validCount (2 * 0 + 2)] at h
        exact h
      have h3 : (z 4 : ℤ) = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 1) *ᵥ ones5)) j := by
        have h := tr_validCount_even 1
        rw [← br_z_eq_validCount (2 * 1 + 2)] at h
        exact h
      have h0z : (z 0 : ℤ) = 1 := by
        have h := tr_validCount_zero
        rw [← br_z_eq_validCount 0] at h
        exact_mod_cast h
      have vsum : (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 2) *ᵥ ones5)) j)
          + 15 * (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 0) *ᵥ ones5)) j)
          = 12 * (∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ 1) *ᵥ ones5)) j) + 2 * 1 := by
        decide
      omega
    rw [h4, h2, h0]
    omega
  · -- n ≥ 7：奇偶分岔（guide §5.2）
    have hpar : ∃ m, n = 2 * m ∨ n = 2 * m + 1 := by
      refine ⟨n / 2, ?_⟩
      omega
    obtain ⟨m, hw⟩ := hpar
    rcases hw with rfl | rfl
    · -- 偶 n = 2 * m，hne : 2 * m ≠ 6 且 6 ≤ 2 * m ⟹ m ≥ 4
      have hm : 4 ≤ m := by omega
      have e4 : 2 * m - 4 = 2 * (m - 3) + 2 := by omega
      have e2 : 2 * m - 2 = 2 * (m - 2) + 2 := by omega
      have e6 : 2 * m - 6 = 2 * (m - 4) + 2 := by omega
      have e0 : 2 * m = 2 * (m - 1) + 2 := by omega
      have key : (z (2 * (m - 1) + 2) : ℤ) + 15 * (z (2 * (m - 3) + 2) : ℤ)
          = 12 * (z (2 * (m - 2) + 2) : ℤ) + 2 * (z (2 * (m - 4) + 2) : ℤ) := by
        have h1 : (z (2 * (m - 1) + 2) : ℤ)
            = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (m - 1)) *ᵥ ones5)) j := by
          have h := tr_validCount_even (m - 1)
          rw [← br_z_eq_validCount (2 * (m - 1) + 2)] at h
          exact h
        have h2 : (z (2 * (m - 3) + 2) : ℤ)
            = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (m - 3)) *ᵥ ones5)) j := by
          have h := tr_validCount_even (m - 3)
          rw [← br_z_eq_validCount (2 * (m - 3) + 2)] at h
          exact h
        have h3 : (z (2 * (m - 2) + 2) : ℤ)
            = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (m - 2)) *ᵥ ones5)) j := by
          have h := tr_validCount_even (m - 2)
          rw [← br_z_eq_validCount (2 * (m - 2) + 2)] at h
          exact h
        have h4 : (z (2 * (m - 4) + 2) : ℤ)
            = ∑ j : Fin 4, (Bmat *ᵥ ((Tmat ^ (m - 4)) *ᵥ ones5)) j := by
          have h := tr_validCount_even (m - 4)
          rw [← br_z_eq_validCount (2 * (m - 4) + 2)] at h
          exact h
        have hrec := asm_u_rec_sum (m - 4)
        rw [show (m - 4) + 3 = m - 1 from by omega, show (m - 4) + 2 = m - 2 from by omega,
          show (m - 4) + 1 = m - 3 from by omega] at hrec
        omega
      rw [e4, e2, e6, e0]
      omega
    · -- 奇 n = 2 * m + 1，6 ≤ 2 * m + 1 ⟹ m ≥ 3
      have hm : 3 ≤ m := by omega
      have e4 : 2 * m + 1 - 4 = 2 * (m - 2) + 1 := by omega
      have e2 : 2 * m + 1 - 2 = 2 * (m - 1) + 1 := by omega
      have e6 : 2 * m + 1 - 6 = 2 * (m - 3) + 1 := by omega
      have key : (z (2 * m + 1) : ℤ) + 15 * (z (2 * (m - 2) + 1) : ℤ)
          = 12 * (z (2 * (m - 1) + 1) : ℤ) + 2 * (z (2 * (m - 3) + 1) : ℤ) := by
        have h1 : (z (2 * m + 1) : ℤ) = ∑ i : Fin 5, ((Tmat ^ m) *ᵥ ones5) i := by
          have h := tr_validCount_odd m
          rw [← br_z_eq_validCount (2 * m + 1)] at h
          exact h
        have h2 : (z (2 * (m - 2) + 1) : ℤ) = ∑ i : Fin 5, ((Tmat ^ (m - 2)) *ᵥ ones5) i := by
          have h := tr_validCount_odd (m - 2)
          rw [← br_z_eq_validCount (2 * (m - 2) + 1)] at h
          exact h
        have h3 : (z (2 * (m - 1) + 1) : ℤ) = ∑ i : Fin 5, ((Tmat ^ (m - 1)) *ᵥ ones5) i := by
          have h := tr_validCount_odd (m - 1)
          rw [← br_z_eq_validCount (2 * (m - 1) + 1)] at h
          exact h
        have h4 : (z (2 * (m - 3) + 1) : ℤ) = ∑ i : Fin 5, ((Tmat ^ (m - 3)) *ᵥ ones5) i := by
          have h := tr_validCount_odd (m - 3)
          rw [← br_z_eq_validCount (2 * (m - 3) + 1)] at h
          exact h
        have hrec := asm_w_rec_sum (m - 3)
        rw [show (m - 3) + 3 = m from by omega, show (m - 3) + 2 = m - 1 from by omega,
          show (m - 3) + 1 = m - 2 from by omega] at hrec
        omega
      rw [e4, e2, e6]
      omega

#print axioms c_z_rec
