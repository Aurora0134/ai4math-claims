import Mathlib

open SimpleGraph

/-!
# S0 · 定义层（holestrip-tour-pipeline，军政部阶段 0）

本文件 = S0 定义层：`formalized/holestrip-tour.lean` 冻结快照的
**定义块逐字节复制**（`Cell` / `IsCell` / `V` / 两个 instance / `leap` /
`leap8` / `knightGraph`），外加冒烟件 3×6 固定版四件邻接引理的
**泛 `n : ℕ` 化**（机制与 3×6 版逐条一致，仅参数化）。

用途：S1–S8 各阶段共享的泛 `n` 定义与邻接引理。
不含冻结 statement 的两个主定理（O 开巡游 / C 闭巡游）——那是 statement 文件的事。

板与洞编码（`.val` 形式，无 `Fin n` 字面量）：`IsCell` 排除左上角 `(0,0)`
与右下角 `(2, n−1)`；`leap` 为四代表方向，`fromRel` 自动对称化出完整 8 向。

引用约定：所有 mathlib 标识符（`Or.comm`、`SimpleGraph.fromRel_adj`、
`decidable_of_iff'`）均经 kernel 核验（`lean_run_code` `#check`）后落笔。
-/

/-! ## 1. 定义块（冻结快照逐字节复制） -/

/-- 3×n 棋盘的格子坐标。 -/
abbrev Cell (n : ℕ) := Fin 3 × Fin n

/-- 棋盘格子（非洞）：删去 (0,0) 与 (2, n−1)，用 `.val` 编码（见文件头注释）。 -/
abbrev IsCell (n : ℕ) (p : Cell n) : Prop :=
  ¬ (p.1.val = 0 ∧ p.2.val = 0) ∧ ¬ (p.1.val = 2 ∧ p.2.val + 1 = n)

/-- 顶点类型：3n−2 个非洞格子。 -/
def V (n : ℕ) := {p : Cell n // IsCell n p}

instance (n : ℕ) : Fintype (V n) := Subtype.fintype _
instance (n : ℕ) : DecidableEq (V n) := Subtype.instDecidableEq

/-- 骑士走法的四个代表方向（b − a ∈ {(1,2),(2,1),(−1,2),(−2,1)}）；
    `fromRel` 自动对称化，补全另外四个方向（(|Δ行|,|Δ列|) ∈ {(1,2),(2,1)} 全 8 组合）。 -/
abbrev leap {n : ℕ} (a b : Cell n) : Prop :=
  ((a.1 : ℕ) + 1 = (b.1 : ℕ) ∧ (a.2 : ℕ) + 2 = (b.2 : ℕ)) ∨
  ((a.1 : ℕ) + 2 = (b.1 : ℕ) ∧ (a.2 : ℕ) + 1 = (b.2 : ℕ)) ∨
  ((b.1 : ℕ) + 1 = (a.1 : ℕ) ∧ (a.2 : ℕ) + 2 = (b.2 : ℕ)) ∨
  ((b.1 : ℕ) + 2 = (a.1 : ℕ) ∧ (a.2 : ℕ) + 1 = (b.2 : ℕ))

/-- 完整 8 向（对称）骑士关系。 -/
abbrev leap8 {n : ℕ} (a b : Cell n) : Prop := leap a b ∨ leap b a

/-- K_n：3×n 棋盘删 (0,0)、(2,n−1) 后的骑士图。 -/
def knightGraph (n : ℕ) : SimpleGraph (V n) :=
  SimpleGraph.fromRel (fun a b : V n => leap8 a.1 b.1)

/-! ## 2. 邻接引理（冒烟件 3×6 版四件，泛 `n` 化） -/

/-- `leap8` 对称（冒烟件 `Or.comm` 证法，泛 `n`）。 -/
theorem leap8_symm {n : ℕ} (a b : Cell n) : leap8 a b ↔ leap8 b a := Or.comm

/-- `leap8` 非自反（冒烟件证法：析取展开 + 四代表方向在 `a = b` 时算术矛盾）。 -/
theorem leap8_irrefl {n : ℕ} (a : Cell n) : ¬ leap8 a a := by
  simp only [leap8, leap, not_or, not_and]
  omega

/-- K_n 的邻接判据：相邻 ⟺ 坐标成完整 8 向骑士关系。
    冒烟件 `adj_iff` 证法（`fromRel_adj` 展开；反方向用 `leap8_irrefl` 排环）。 -/
theorem knightGraph_adj_iff {n : ℕ} {a b : V n} :
    (knightGraph n).Adj a b ↔ leap8 a.1 b.1 := by
  constructor
  · intro h
    have h' := h
    rw [knightGraph, SimpleGraph.fromRel_adj] at h'
    obtain ⟨_, h | h⟩ := h'
    · exact h
    · exact Or.comm.mp h
  · intro h
    rw [knightGraph, SimpleGraph.fromRel_adj]
    refine ⟨?_, Or.inl h⟩
    intro heq
    have h2 : a.1 = b.1 := congrArg Subtype.val heq
    rw [h2] at h
    exact leap8_irrefl b.1 h

/-- K_n 的邻接关系可判定（经 `knightGraph_adj_iff` 转成数值相等式）。 -/
instance (n : ℕ) : DecidableRel (knightGraph n).Adj := fun a b =>
  decidable_of_iff' (leap8 a.1 b.1) knightGraph_adj_iff

/-!
# S1 · 计数工具层（军政部阶段 1）

本段 = 冒烟件 `holed3x6-forcing.lean` 路径边数引理族的泛 `n` 化
（`V`/`knightGraph` 换为 `V n`/`knightGraph n`，机制逐形一致），
外加闭圈侧 analogs（`incCount_cycle_two` / `force_edge_cycle`，供 S6 闭侧使用）。
-/

/-! ## 3. 路径侧计数族（冒烟件泛 `n` 化，逐形照抄） -/

/-- 路径中经过顶点 v 的边数（按重数计）。 -/
def incCount {n : ℕ} {a b : V n} (p : (knightGraph n).Walk a b) (v : V n) : ℕ :=
  (p.edges.filter (fun e => v ∈ e)).length

theorem incCount_cons {n} {u v w : V n} (h : (knightGraph n).Adj u v)
    (q : (knightGraph n).Walk v w) (x : V n) :
    incCount (Walk.cons h q) x = incCount q x + (if x ∈ s(u, v) then 1 else 0) := by
  simp only [incCount, Walk.edges_cons, List.filter_cons, Sym2.mem_iff]
  by_cases hc : x = u ∨ x = v
  · simp [hc]
  · simp [hc]

/-- 单点列表的计数。 -/
theorem count_singleton {n} (x u : V n) : List.count x [u] = if x = u then 1 else 0 := by
  by_cases h : x = u
  · subst h; simp
  · have h' : ¬(u = x) := fun heq => h heq.symm
    simp [List.count_nil, h, h']

/-- if 条件交换（引理 count_cons 给出 `u = x` 形式，需归一为 `x = u`）。 -/
theorem if_eq_comm {c d : Prop} [Decidable c] [Decidable d] (h : c ↔ d) :
    (if c then 1 else 0) = (if d then 1 else 0) := by
  by_cases hc : c <;> by_cases hd : d <;> simp_all

/-- 上界：路径边数 + 端点修正 ≤ 2·出现次数。 -/
theorem incCount_upper {n} (x : V n) : ∀ {a b : V n} (p : (knightGraph n).Walk a b),
    incCount p x + (if x = a then 1 else 0) + (if x = b then 1 else 0)
      ≤ 2 * p.support.count x := by
  intro a b p
  induction p with
  | nil =>
      simp only [incCount, Walk.edges_nil, List.filter_nil, List.length_nil, Walk.support_nil]
      rw [count_singleton]
      omega
  | @cons u v w h q ih =>
      rw [incCount_cons, Walk.support_cons, List.count_cons]
      simp only [beq_iff_eq]
      have hmem : x ∈ s(u, v) ↔ x = u ∨ x = v := Sym2.mem_iff
      have huv : u ≠ v := h.ne
      have hvu : v ≠ u := fun heq => huv heq.symm
      by_cases hxu : x = u
      · have hiA : (if x ∈ s(u, v) then 1 else 0) = 1 := by simp [hmem, hxu]
        have hGu : (if x = u then 1 else 0) = 1 := by simp [hxu]
        have hCu : (if u = x then 1 else 0) = 1 := by simp [hxu]
        have hGv : (if x = v then 1 else 0) = 0 := by
          have hnv : x ≠ v := fun heq => huv (hxu.symm.trans heq)
          simp [hnv]
        rw [hiA, hGu, hCu]
        rw [hGv] at ih
        omega
      · by_cases hxv : x = v
        · have hiA : (if x ∈ s(u, v) then 1 else 0) = 1 := by simp [hmem, hxv]
          have hGu : (if x = u then 1 else 0) = 0 := by
            have hnu : x ≠ u := fun heq => hvu (hxv.symm.trans heq)
            simp [hnu]
          have hCu : (if u = x then 1 else 0) = 0 := by
            have hnu : x ≠ u := fun heq => hvu (hxv.symm.trans heq)
            have hnux : ¬ u = x := fun heq => hnu heq.symm
            simp [hnux]
          have hGv : (if x = v then 1 else 0) = 1 := by simp [hxv]
          rw [hiA, hGu, hCu]
          rw [hGv] at ih
          omega
        · have hiA : (if x ∈ s(u, v) then 1 else 0) = 0 := by simp [hmem, hxu, hxv]
          have hGu : (if x = u then 1 else 0) = 0 := by simp [hxu]
          have hCu : (if u = x then 1 else 0) = 0 := by
            have hnux : ¬ u = x := fun heq => hxu heq.symm
            simp [hnux]
          have hGv : (if x = v then 1 else 0) = 0 := by simp [hxv]
          rw [hiA, hGu, hCu]
          rw [hGv] at ih
          omega

/-- 下界：2·出现次数 ≤ 路径边数 + 端点修正。 -/
theorem incCount_lower {n} (x : V n) : ∀ {a b : V n} (p : (knightGraph n).Walk a b),
    2 * p.support.count x
      ≤ incCount p x + (if x = a then 1 else 0) + (if x = b then 1 else 0) := by
  intro a b p
  induction p with
  | nil =>
      simp only [incCount, Walk.edges_nil, List.filter_nil, List.length_nil, Walk.support_nil]
      rw [count_singleton]
      omega
  | @cons u v w h q ih =>
      rw [incCount_cons, Walk.support_cons, List.count_cons]
      simp only [beq_iff_eq]
      have hmem : x ∈ s(u, v) ↔ x = u ∨ x = v := Sym2.mem_iff
      have huv : u ≠ v := h.ne
      have hvu : v ≠ u := fun heq => huv heq.symm
      by_cases hxu : x = u
      · have hiA : (if x ∈ s(u, v) then 1 else 0) = 1 := by simp [hmem, hxu]
        have hGu : (if x = u then 1 else 0) = 1 := by simp [hxu]
        have hCu : (if u = x then 1 else 0) = 1 := by simp [hxu]
        have hGv : (if x = v then 1 else 0) = 0 := by
          have hnv : x ≠ v := fun heq => huv (hxu.symm.trans heq)
          simp [hnv]
        rw [hiA, hGu, hCu]
        rw [hGv] at ih
        omega
      · by_cases hxv : x = v
        · have hiA : (if x ∈ s(u, v) then 1 else 0) = 1 := by simp [hmem, hxv]
          have hGu : (if x = u then 1 else 0) = 0 := by
            have hnu : x ≠ u := fun heq => hvu (hxv.symm.trans heq)
            simp [hnu]
          have hCu : (if u = x then 1 else 0) = 0 := by
            have hnu : x ≠ u := fun heq => hvu (hxv.symm.trans heq)
            have hnux : ¬ u = x := fun heq => hnu heq.symm
            simp [hnux]
          have hGv : (if x = v then 1 else 0) = 1 := by simp [hxv]
          rw [hiA, hGu, hCu]
          rw [hGv] at ih
          omega
        · have hiA : (if x ∈ s(u, v) then 1 else 0) = 0 := by simp [hmem, hxu, hxv]
          have hGu : (if x = u then 1 else 0) = 0 := by simp [hxu]
          have hCu : (if u = x then 1 else 0) = 0 := by
            have hnux : ¬ u = x := fun heq => hxu heq.symm
            simp [hnux]
          have hGv : (if x = v then 1 else 0) = 0 := by simp [hxv]
          rw [hiA, hGu, hCu]
          rw [hGv] at ih
          omega

/-- 哈密顿路径中，非端点的顶点恰有 2 条路径边。 -/
theorem incCount_internal_two {n} {a b v : V n} {p : (knightGraph n).Walk a b}
    (hp : p.IsHamiltonian) (hva : v ≠ a) (hvb : v ≠ b) : incCount p v = 2 := by
  have h1 := incCount_upper v p
  have h2 := incCount_lower v p
  have hc : p.support.count v = 1 := hp v
  have e1 : (if v = a then 1 else 0) = 0 := by simp [hva]
  have e2 : (if v = b then 1 else 0) = 0 := by simp [hvb]
  rw [e1, e2, hc] at h1 h2
  omega

/-- 哈密顿 ⇒ 支撑无重复。 -/
theorem support_nodup_of_hamiltonian {n} {a b : V n} {p : (knightGraph n).Walk a b}
    (hp : p.IsHamiltonian) : p.support.Nodup := by
  rw [List.nodup_iff_count_le_one]
  intro v
  have := hp v
  omega

/-- 支撑无重复 ⇒ 边表无重复。 -/
theorem edges_nodup_of_support_nodup {n} : ∀ {a b : V n} (p : (knightGraph n).Walk a b),
    p.support.Nodup → p.edges.Nodup := by
  intro a b p
  induction p with
  | nil => intro _; simp
  | @cons u v w h q ih =>
      intro hp
      rw [Walk.support_cons, List.nodup_cons] at hp
      simp only [Walk.edges_cons]
      rw [List.nodup_cons]
      refine ⟨?_, ih hp.2⟩
      intro hmem
      have hu : u ∈ q.support :=
        (Walk.mem_support_iff_exists_mem_edges (p := q)).mpr
          (Or.inr ⟨s(u, v), hmem, by rw [Sym2.mem_iff]; exact Or.inl rfl⟩)
      exact hp.1 hu

/-- 哈密顿 ⇒ 边表无重复。 -/
theorem edges_nodup_of_hamiltonian {n} {a b : V n} {p : (knightGraph n).Walk a b}
    (hp : p.IsHamiltonian) : p.edges.Nodup :=
  edges_nodup_of_support_nodup p (support_nodup_of_hamiltonian hp)

/-- 强迫边引理：内部顶点 v 若只有两个邻居 u1、u2，则连向它们的边必在
    哈密顿路径的边表里。 -/
theorem force_edge {n} {a b v u1 u2 : V n} (p : (knightGraph n).Walk a b)
    (hp : p.IsHamiltonian)
    (hva : v ≠ a) (hvb : v ≠ b) (hu12 : u1 ≠ u2)
    (honly : ∀ u, (knightGraph n).Adj v u → u = u1 ∨ u = u2) :
    s(v, u1) ∈ p.edges ∧ s(v, u2) ∈ p.edges := by
  have htwo : incCount p v = 2 := incCount_internal_two hp hva hvb
  have hnd : p.edges.Nodup := edges_nodup_of_hamiltonian hp
  have hLnd : (p.edges.filter (fun e => v ∈ e)).Nodup := hnd.filter _
  have hLlen : (p.edges.filter (fun e => v ∈ e)).length = 2 := by
    have h2 := htwo
    unfold incCount at h2
    exact h2
  have hLcard : (p.edges.filter (fun e => v ∈ e)).toFinset.card = 2 := by
    rw [List.toFinset_card_of_nodup hLnd, hLlen]
  -- L 的每个元素都是 s(v,u1) 或 s(v,u2)
  have hLmem : ∀ e ∈ p.edges.filter (fun e => v ∈ e), e = s(v, u1) ∨ e = s(v, u2) := by
    intro e he
    have he1 : e ∈ p.edges := (List.mem_filter.mp he).1
    have he2 : v ∈ e := of_decide_eq_true (List.mem_filter.mp he).2
    obtain ⟨y, hy⟩ := Sym2.mem_iff_exists.mp he2
    subst hy
    have hadj : (knightGraph n).Adj v y := Walk.adj_of_mem_edges p he1
    obtain h | h := honly y hadj
    · exact Or.inl (by rw [h])
    · exact Or.inr (by rw [h])
  have hLsub : (p.edges.filter (fun e => v ∈ e)).toFinset ⊆
      ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))) := by
    intro e he
    obtain h | h := hLmem e (List.mem_toFinset.mp he)
    · exact Finset.mem_insert.mpr (Or.inl h)
    · exact Finset.mem_insert.mpr (Or.inr (Finset.mem_singleton.mpr h))
  have hcard2 : ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))).card = 2 := by
    have hne12 : s(v, u1) ≠ s(v, u2) := by
      intro heq
      obtain (⟨-, h⟩ | ⟨h1, h2⟩) := Sym2.eq_iff.mp heq
      · exact hu12 h
      · exact hu12 (h2.trans h1)
    rw [Finset.card_insert_of_notMem (Finset.notMem_singleton.mpr hne12), Finset.card_singleton]
  have hLeq : (p.edges.filter (fun e => v ∈ e)).toFinset =
      ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))) :=
    Finset.eq_of_subset_of_card_le hLsub (by omega)
  refine ⟨?_, ?_⟩
  · have hs : s(v, u1) ∈ (p.edges.filter (fun e => v ∈ e)).toFinset := by
      rw [hLeq]; exact Finset.mem_insert_self s(v, u1) _
    exact (List.mem_filter.mp (List.mem_toFinset.mp hs)).1
  · have hs : s(v, u2) ∈ (p.edges.filter (fun e => v ∈ e)).toFinset := by
      rw [hLeq]
      exact Finset.mem_insert_of_mem (Finset.mem_singleton.mpr rfl)
    exact (List.mem_filter.mp (List.mem_toFinset.mp hs)).1

/-- Sym2 不等式工具：s(a,b) ≠ s(c,b) 当 a 既不是 c 也不是 b。 -/
theorem sym2_ne_of_not_mem {n} {a b c : V n} (h : ¬(a = c ∨ a = b)) : s(a, b) ≠ s(c, b) := by
  intro heq
  have hmem : a ∈ s(c, b) := by
    rw [← heq, Sym2.mem_iff]
    exact Or.inl rfl
  rw [Sym2.mem_iff] at hmem
  exact h hmem


/-! ## 4. 闭圈侧 analogs（供 S6 闭侧使用） -/

/-- 哈密顿闭圈中每个顶点恰有 2 条圈边（`incCount_internal_two` 的闭侧 analog）。
    证法：闭圈支撑计数现货（首格 2、其余 1，`count_support_self`/`support_count_of_ne`）
    直接套路径侧 `incCount_upper`/`incCount_lower`（端点 a = a，修正项恰为 0 或 2）。 -/
theorem incCount_cycle_two {n : ℕ} {a : V n} {p : (knightGraph n).Walk a a}
    (hp : p.IsHamiltonianCycle) (v : V n) : incCount p v = 2 := by
  have hu := incCount_upper v p
  have hl := incCount_lower v p
  by_cases hva : v = a
  · subst hva
    rw [hp.count_support_self] at hu hl
    simp only [if_true] at hu hl
    omega
  · rw [hp.support_count_of_ne (fun h => hva h.symm)] at hu hl
    simp only [hva, if_false, add_zero] at hu hl
    omega

/-- 闭圈侧强迫边引理：顶点 v 若只有两个邻居 u1、u2，闭圈边表必含 s(v,u1)、s(v,u2)。
    尾部证法逐形照抄 `force_edge`（filter 列表 → toFinset 基数 2 → 两元夹逼）；
    边表无重复由闭圈的 IsCycle 结构投影链（IsCycle → IsCircuit → IsTrail → edges_nodup）给出。 -/
theorem force_edge_cycle {n} {a v u1 u2 : V n} {p : (knightGraph n).Walk a a}
    (hp : p.IsHamiltonianCycle) (hu12 : u1 ≠ u2)
    (honly : ∀ u, (knightGraph n).Adj v u → u = u1 ∨ u = u2) :
    s(v, u1) ∈ p.edges ∧ s(v, u2) ∈ p.edges := by
  have htwo : incCount p v = 2 := incCount_cycle_two hp v
  have hcyc : p.IsCycle :=
    (SimpleGraph.Walk.isHamiltonianCycle_isCycle_and_isHamiltonian_tail.mp hp).1
  have hnd : p.edges.Nodup := hcyc.edges_nodup
  have hLnd : (p.edges.filter (fun e => v ∈ e)).Nodup := hnd.filter _
  have hLlen : (p.edges.filter (fun e => v ∈ e)).length = 2 := by
    have h2 := htwo
    unfold incCount at h2
    exact h2
  have hLcard : (p.edges.filter (fun e => v ∈ e)).toFinset.card = 2 := by
    rw [List.toFinset_card_of_nodup hLnd, hLlen]
  -- L 的每个元素都是 s(v,u1) 或 s(v,u2)
  have hLmem : ∀ e ∈ p.edges.filter (fun e => v ∈ e), e = s(v, u1) ∨ e = s(v, u2) := by
    intro e he
    have he1 : e ∈ p.edges := (List.mem_filter.mp he).1
    have he2 : v ∈ e := of_decide_eq_true (List.mem_filter.mp he).2
    obtain ⟨y, hy⟩ := Sym2.mem_iff_exists.mp he2
    subst hy
    have hadj : (knightGraph n).Adj v y := Walk.adj_of_mem_edges p he1
    obtain h | h := honly y hadj
    · exact Or.inl (by rw [h])
    · exact Or.inr (by rw [h])
  have hLsub : (p.edges.filter (fun e => v ∈ e)).toFinset ⊆
      ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))) := by
    intro e he
    obtain h | h := hLmem e (List.mem_toFinset.mp he)
    · exact Finset.mem_insert.mpr (Or.inl h)
    · exact Finset.mem_insert.mpr (Or.inr (Finset.mem_singleton.mpr h))
  have hcard2 : ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))).card = 2 := by
    have hne12 : s(v, u1) ≠ s(v, u2) := by
      intro heq
      obtain (⟨-, h⟩ | ⟨h1, h2⟩) := Sym2.eq_iff.mp heq
      · exact hu12 h
      · exact hu12 (h2.trans h1)
    rw [Finset.card_insert_of_notMem (Finset.notMem_singleton.mpr hne12), Finset.card_singleton]
  have hLeq : (p.edges.filter (fun e => v ∈ e)).toFinset =
      ({s(v, u1), s(v, u2)} : Finset (Sym2 (V n))) :=
    Finset.eq_of_subset_of_card_le hLsub (by omega)
  refine ⟨?_, ?_⟩
  · have hs : s(v, u1) ∈ (p.edges.filter (fun e => v ∈ e)).toFinset := by
      rw [hLeq]; exact Finset.mem_insert_self s(v, u1) _
    exact (List.mem_filter.mp (List.mem_toFinset.mp hs)).1
  · have hs : s(v, u2) ∈ (p.edges.filter (fun e => v ∈ e)).toFinset := by
      rw [hLeq]
      exact Finset.mem_insert_of_mem (Finset.mem_singleton.mpr rfl)
    exact (List.mem_filter.mp (List.mem_toFinset.mp hs)).1


/-! ## 5. 小情形存在侧：n=4/5 开巡游见证（S2，Phase 0 数据） -/

/-- 细胞构造助手（n=4）：合法格 → 顶点。 -/
def w4 (r : Fin 3) (c : Fin 4) (h : IsCell 4 (r, c) := by decide) : V 4 := ⟨(r, c), h⟩

/-- n=4 开巡游见证走法表（Phase 0 数据：final_machines.json open_witness_4）。 -/
def witness4List : List (Cell 4) :=
  [(1, 1), (0, 3), (2, 2), (1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2)]

/-- n=4 开巡游见证 walk（逐步邻接由 decide 核验，边序同上表）。 -/
def witness4Walk : (knightGraph 4).Walk (w4 1 1) (w4 1 2) :=
  Walk.cons (show (knightGraph 4).Adj (w4 1 1) (w4 0 3) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 0 3) (w4 2 2) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 2 2) (w4 1 0) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 1 0) (w4 0 2) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 0 2) (w4 2 1) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 2 1) (w4 1 3) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 1 3) (w4 0 1) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 0 1) (w4 2 0) from by decide) <|
  Walk.cons (show (knightGraph 4).Adj (w4 2 0) (w4 1 2) from by decide) <| Walk.nil

/-- 见证覆盖核验：支撑每顶点计数恰 1。 -/
theorem witness4_hamiltonian : witness4Walk.IsHamiltonian := by
  unfold SimpleGraph.Walk.IsHamiltonian
  decide

/-- n=4 开巡游存在。 -/
theorem open_tour_4 : ∃ a b : V 4, ∃ w : (knightGraph 4).Walk a b, w.IsHamiltonian :=
  ⟨_, _, witness4Walk, witness4_hamiltonian⟩

/-- 细胞构造助手（n=5）：合法格 → 顶点。 -/
def w5 (r : Fin 3) (c : Fin 5) (h : IsCell 5 (r, c) := by decide) : V 5 := ⟨(r, c), h⟩

/-- n=5 开巡游见证走法表（Phase 0 数据：final_machines.json open_witness_5）。 -/
def witness5List : List (Cell 5) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (2, 3), (1, 1), (0, 3), (2, 2), (1, 4)]

/-- n=5 开巡游见证 walk（逐步邻接由 decide 核验，边序同上表）。 -/
def witness5Walk : (knightGraph 5).Walk (w5 1 0) (w5 1 4) :=
  Walk.cons (show (knightGraph 5).Adj (w5 1 0) (w5 0 2) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 0 2) (w5 2 1) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 2 1) (w5 1 3) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 1 3) (w5 0 1) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 0 1) (w5 2 0) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 2 0) (w5 1 2) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 1 2) (w5 0 4) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 0 4) (w5 2 3) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 2 3) (w5 1 1) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 1 1) (w5 0 3) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 0 3) (w5 2 2) from by decide) <|
  Walk.cons (show (knightGraph 5).Adj (w5 2 2) (w5 1 4) from by decide) <| Walk.nil

/-- 见证覆盖核验：支撑每顶点计数恰 1。 -/
theorem witness5_hamiltonian : witness5Walk.IsHamiltonian := by
  unfold SimpleGraph.Walk.IsHamiltonian
  decide

/-- n=5 开巡游存在。 -/
theorem open_tour_5 : ∃ a b : V 5, ∃ w : (knightGraph 5).Walk a b, w.IsHamiltonian :=
  ⟨_, _, witness5Walk, witness5_hamiltonian⟩
/-! ## 6. 基石存在侧（S3）：四闭基座 + 两奇开基座 + 闭开派生 -/

/-- 细胞构造助手（n=8）。 -/
def w8 (r : Fin 3) (c : Fin 8) (h : IsCell 8 (r, c) := by decide) : V 8 := ⟨(r, c), h⟩

/-- n=8 闭圈基座走法表（Phase 0 final_machines.json closed_machines 的 n=8 基座）。 -/
def base8List : List (Cell 8) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (1, 6), (2, 4), (0, 5), (1, 7), (2, 5), (0, 6), (1, 4), (2, 6), (0, 7), (1, 5), (2, 3), (1, 1), (0, 3), (2, 2)]

/-- n=8 闭圈基座 walk（含闭合边，逐边 decide 核验）。 -/
def base8Cycle : (knightGraph 8).Walk (w8 1 0) (w8 1 0) :=
  Walk.cons (show (knightGraph 8).Adj (w8 1 0) (w8 0 2) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 2) (w8 2 1) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 1) (w8 1 3) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 3) (w8 0 1) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 1) (w8 2 0) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 0) (w8 1 2) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 2) (w8 0 4) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 4) (w8 1 6) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 6) (w8 2 4) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 4) (w8 0 5) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 5) (w8 1 7) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 7) (w8 2 5) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 5) (w8 0 6) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 6) (w8 1 4) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 4) (w8 2 6) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 6) (w8 0 7) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 7) (w8 1 5) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 5) (w8 2 3) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 3) (w8 1 1) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 1 1) (w8 0 3) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 0 3) (w8 2 2) from by decide) <|
  Walk.cons (show (knightGraph 8).Adj (w8 2 2) (w8 1 0) from by decide) <| Walk.nil

/-- n=8 闭圈存在。 -/
theorem closed_cycle_8 : ∃ a : V 8, ∃ w : (knightGraph 8).Walk a a, w.IsHamiltonianCycle :=
  ⟨_, base8Cycle, by
    rw [SimpleGraph.Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one]
    exact ⟨(SimpleGraph.Walk.cons_isCycle_iff _ _).mpr
      ⟨SimpleGraph.Walk.IsPath.mk' (by decide), by decide⟩, by decide⟩⟩

/-- 细胞构造助手（n=10）。 -/
def w10 (r : Fin 3) (c : Fin 10) (h : IsCell 10 (r, c) := by decide) : V 10 := ⟨(r, c), h⟩

/-- n=10 闭圈基座走法表（Phase 0 final_machines.json closed_machines 的 n=10 基座）。 -/
def base10List : List (Cell 10) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (2, 5), (1, 7), (0, 9), (2, 8), (1, 6), (0, 8), (2, 7), (1, 9), (0, 7), (1, 5), (2, 3), (1, 1), (0, 3), (2, 4), (0, 5), (2, 6), (1, 8), (0, 6), (1, 4), (2, 2)]

/-- n=10 闭圈基座 walk（含闭合边，逐边 decide 核验）。 -/
def base10Cycle : (knightGraph 10).Walk (w10 1 0) (w10 1 0) :=
  Walk.cons (show (knightGraph 10).Adj (w10 1 0) (w10 0 2) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 2) (w10 2 1) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 1) (w10 1 3) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 3) (w10 0 1) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 1) (w10 2 0) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 0) (w10 1 2) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 2) (w10 0 4) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 4) (w10 2 5) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 5) (w10 1 7) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 7) (w10 0 9) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 9) (w10 2 8) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 8) (w10 1 6) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 6) (w10 0 8) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 8) (w10 2 7) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 7) (w10 1 9) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 9) (w10 0 7) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 7) (w10 1 5) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 5) (w10 2 3) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 3) (w10 1 1) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 1) (w10 0 3) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 3) (w10 2 4) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 4) (w10 0 5) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 5) (w10 2 6) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 6) (w10 1 8) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 8) (w10 0 6) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 0 6) (w10 1 4) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 1 4) (w10 2 2) from by decide) <|
  Walk.cons (show (knightGraph 10).Adj (w10 2 2) (w10 1 0) from by decide) <| Walk.nil

/-- n=10 闭圈存在。 -/
theorem closed_cycle_10 : ∃ a : V 10, ∃ w : (knightGraph 10).Walk a a, w.IsHamiltonianCycle :=
  ⟨_, base10Cycle, by
    rw [SimpleGraph.Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one]
    exact ⟨(SimpleGraph.Walk.cons_isCycle_iff _ _).mpr
      ⟨SimpleGraph.Walk.IsPath.mk' (by decide), by decide⟩, by decide⟩⟩

/-- 细胞构造助手（n=12）。 -/
def w12 (r : Fin 3) (c : Fin 12) (h : IsCell 12 (r, c) := by decide) : V 12 := ⟨(r, c), h⟩

/-- n=12 闭圈基座走法表（Phase 0 final_machines.json closed_machines 的 n=12 基座）。 -/
def base12List : List (Cell 12) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (2, 3), (1, 1), (0, 3), (2, 4), (1, 6), (0, 8), (1, 10), (2, 8), (0, 7), (1, 5), (2, 7), (1, 9), (0, 11), (2, 10), (0, 9), (1, 11), (2, 9), (0, 10), (1, 8), (0, 6), (2, 5), (1, 7), (0, 5), (2, 6), (1, 4), (2, 2)]

/-- n=12 闭圈基座 walk（含闭合边，逐边 decide 核验）。 -/
def base12Cycle : (knightGraph 12).Walk (w12 1 0) (w12 1 0) :=
  Walk.cons (show (knightGraph 12).Adj (w12 1 0) (w12 0 2) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 2) (w12 2 1) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 1) (w12 1 3) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 3) (w12 0 1) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 1) (w12 2 0) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 0) (w12 1 2) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 2) (w12 0 4) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 4) (w12 2 3) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 3) (w12 1 1) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 1) (w12 0 3) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 3) (w12 2 4) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 4) (w12 1 6) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 6) (w12 0 8) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 8) (w12 1 10) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 10) (w12 2 8) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 8) (w12 0 7) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 7) (w12 1 5) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 5) (w12 2 7) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 7) (w12 1 9) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 9) (w12 0 11) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 11) (w12 2 10) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 10) (w12 0 9) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 9) (w12 1 11) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 11) (w12 2 9) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 9) (w12 0 10) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 10) (w12 1 8) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 8) (w12 0 6) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 6) (w12 2 5) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 5) (w12 1 7) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 7) (w12 0 5) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 0 5) (w12 2 6) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 6) (w12 1 4) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 1 4) (w12 2 2) from by decide) <|
  Walk.cons (show (knightGraph 12).Adj (w12 2 2) (w12 1 0) from by decide) <| Walk.nil

/-- n=12 闭圈存在。 -/
theorem closed_cycle_12 : ∃ a : V 12, ∃ w : (knightGraph 12).Walk a a, w.IsHamiltonianCycle :=
  ⟨_, base12Cycle, by
    rw [SimpleGraph.Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one]
    exact ⟨(SimpleGraph.Walk.cons_isCycle_iff _ _).mpr
      ⟨SimpleGraph.Walk.IsPath.mk' (by decide), by decide⟩, by decide⟩⟩

/-- 细胞构造助手（n=14）。 -/
def w14 (r : Fin 3) (c : Fin 14) (h : IsCell 14 (r, c) := by decide) : V 14 := ⟨(r, c), h⟩

/-- n=14 闭圈基座走法表（Phase 0 final_machines.json closed_machines 的 n=14 基座）。 -/
def base14List : List (Cell 14) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (2, 3), (1, 1), (0, 3), (2, 4), (0, 5), (2, 6), (1, 8), (0, 10), (1, 12), (2, 10), (0, 9), (1, 11), (0, 13), (2, 12), (1, 10), (0, 12), (2, 11), (1, 13), (0, 11), (1, 9), (2, 7), (1, 5), (0, 7), (2, 8), (1, 6), (0, 8), (2, 9), (1, 7), (2, 5), (0, 6), (1, 4), (2, 2)]

/-- n=14 闭圈基座 walk（含闭合边，逐边 decide 核验）。 -/
def base14Cycle : (knightGraph 14).Walk (w14 1 0) (w14 1 0) :=
  Walk.cons (show (knightGraph 14).Adj (w14 1 0) (w14 0 2) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 2) (w14 2 1) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 1) (w14 1 3) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 3) (w14 0 1) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 1) (w14 2 0) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 0) (w14 1 2) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 2) (w14 0 4) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 4) (w14 2 3) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 3) (w14 1 1) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 1) (w14 0 3) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 3) (w14 2 4) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 4) (w14 0 5) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 5) (w14 2 6) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 6) (w14 1 8) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 8) (w14 0 10) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 10) (w14 1 12) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 12) (w14 2 10) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 10) (w14 0 9) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 9) (w14 1 11) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 11) (w14 0 13) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 13) (w14 2 12) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 12) (w14 1 10) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 10) (w14 0 12) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 12) (w14 2 11) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 11) (w14 1 13) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 13) (w14 0 11) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 11) (w14 1 9) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 9) (w14 2 7) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 7) (w14 1 5) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 5) (w14 0 7) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 7) (w14 2 8) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 8) (w14 1 6) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 6) (w14 0 8) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 8) (w14 2 9) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 9) (w14 1 7) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 7) (w14 2 5) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 5) (w14 0 6) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 0 6) (w14 1 4) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 1 4) (w14 2 2) from by decide) <|
  Walk.cons (show (knightGraph 14).Adj (w14 2 2) (w14 1 0) from by decide) <| Walk.nil

/-- n=14 闭圈存在。 -/
theorem closed_cycle_14 : ∃ a : V 14, ∃ w : (knightGraph 14).Walk a a, w.IsHamiltonianCycle :=
  ⟨_, base14Cycle, by
    rw [SimpleGraph.Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one]
    exact ⟨(SimpleGraph.Walk.cons_isCycle_iff _ _).mpr
      ⟨SimpleGraph.Walk.IsPath.mk' (by decide), by decide⟩, by decide⟩⟩

/-- 细胞构造助手（n=9）。 -/
def w9 (r : Fin 3) (c : Fin 9) (h : IsCell 9 (r, c) := by decide) : V 9 := ⟨(r, c), h⟩

/-- n=9 开巡游基座走法表（M 机基座去末格，Phase 0 数据）。 -/
def openBase9List : List (Cell 9) :=
  [(1, 0), (2, 2), (1, 4), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (2, 3), (1, 1), (0, 3), (2, 4), (0, 5), (1, 7), (2, 5), (0, 6), (1, 8), (2, 6), (0, 7), (1, 5), (2, 7), (0, 8), (1, 6)]

/-- n=9 开巡游基座 walk。 -/
def openBase9Walk : (knightGraph 9).Walk (w9 1 0) (w9 1 6) :=
  Walk.cons (show (knightGraph 9).Adj (w9 1 0) (w9 2 2) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 2) (w9 1 4) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 4) (w9 0 2) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 2) (w9 2 1) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 1) (w9 1 3) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 3) (w9 0 1) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 1) (w9 2 0) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 0) (w9 1 2) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 2) (w9 0 4) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 4) (w9 2 3) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 3) (w9 1 1) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 1) (w9 0 3) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 3) (w9 2 4) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 4) (w9 0 5) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 5) (w9 1 7) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 7) (w9 2 5) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 5) (w9 0 6) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 6) (w9 1 8) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 8) (w9 2 6) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 6) (w9 0 7) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 7) (w9 1 5) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 1 5) (w9 2 7) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 2 7) (w9 0 8) from by decide) <|
  Walk.cons (show (knightGraph 9).Adj (w9 0 8) (w9 1 6) from by decide) <| Walk.nil

/-- n=9 开巡游基座覆盖核验。 -/
theorem openBase9_hamiltonian : openBase9Walk.IsHamiltonian := by
  unfold SimpleGraph.Walk.IsHamiltonian
  decide

/-- n=9 开巡游存在。 -/
theorem open_tour_9 : ∃ a b : V 9, ∃ w : (knightGraph 9).Walk a b, w.IsHamiltonian :=
  ⟨_, _, openBase9Walk, openBase9_hamiltonian⟩

/-- 细胞构造助手（n=11）。 -/
def w11 (r : Fin 3) (c : Fin 11) (h : IsCell 11 (r, c) := by decide) : V 11 := ⟨(r, c), h⟩

/-- n=11 开巡游基座走法表（M 机基座去末格，Phase 0 数据）。 -/
def openBase11List : List (Cell 11) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (2, 5), (0, 6), (1, 4), (2, 6), (0, 5), (2, 4), (1, 6), (0, 4), (1, 2), (2, 0), (0, 1), (2, 2), (0, 3), (1, 1), (2, 3), (1, 5), (0, 7), (1, 9), (2, 7), (0, 8), (1, 10), (2, 8), (0, 9), (1, 7), (2, 9), (0, 10), (1, 8)]

/-- n=11 开巡游基座 walk。 -/
def openBase11Walk : (knightGraph 11).Walk (w11 1 0) (w11 1 8) :=
  Walk.cons (show (knightGraph 11).Adj (w11 1 0) (w11 0 2) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 2) (w11 2 1) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 1) (w11 1 3) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 3) (w11 2 5) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 5) (w11 0 6) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 6) (w11 1 4) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 4) (w11 2 6) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 6) (w11 0 5) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 5) (w11 2 4) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 4) (w11 1 6) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 6) (w11 0 4) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 4) (w11 1 2) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 2) (w11 2 0) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 0) (w11 0 1) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 1) (w11 2 2) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 2) (w11 0 3) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 3) (w11 1 1) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 1) (w11 2 3) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 3) (w11 1 5) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 5) (w11 0 7) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 7) (w11 1 9) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 9) (w11 2 7) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 7) (w11 0 8) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 8) (w11 1 10) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 10) (w11 2 8) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 8) (w11 0 9) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 9) (w11 1 7) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 1 7) (w11 2 9) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 2 9) (w11 0 10) from by decide) <|
  Walk.cons (show (knightGraph 11).Adj (w11 0 10) (w11 1 8) from by decide) <| Walk.nil

/-- n=11 开巡游基座覆盖核验。 -/
theorem openBase11_hamiltonian : openBase11Walk.IsHamiltonian := by
  unfold SimpleGraph.Walk.IsHamiltonian
  decide

/-- n=11 开巡游存在。 -/
theorem open_tour_11 : ∃ a b : V 11, ∃ w : (knightGraph 11).Walk a b, w.IsHamiltonian :=
  ⟨_, _, openBase11Walk, openBase11_hamiltonian⟩

/-- 闭圈派生开巡游：闭圈掐掉首格的一步即哈密顿路径（tail.IsHamiltonian 现货）。 -/
theorem open_of_closed {n : ℕ}
    (h : ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle) :
    ∃ a b : V n, ∃ w : (knightGraph n).Walk a b, w.IsHamiltonian := by
  obtain ⟨a, w, hw⟩ := h
  exact ⟨_, _, w.tail,
    (SimpleGraph.Walk.isHamiltonianCycle_isCycle_and_isHamiltonian_tail.mp hw).2⟩

/-! ## 7. 装载层（T1）：显式顶点列表 → walk / 哈密顿路径 / 哈密顿圈 -/

/-- 从起点与后继列表按链证据构建 walk（Σ 打包终点，避免依赖类型 defeq 墙）。 -/
def walkOfChain {n : ℕ} (a : V n) : (l : List (V n)) →
    List.IsChain (knightGraph n).Adj (a :: l) → Σ b, (knightGraph n).Walk a b
  | [], _ => ⟨a, Walk.nil⟩
  | b :: tl, h => by
      have h1 : (knightGraph n).Adj a b ∧ List.IsChain (knightGraph n).Adj (b :: tl) := by
        rw [List.isChain_cons_iff] at h
        rcases h with hnil | ⟨b', l', hab, hchain, hcons⟩
        · exact absurd hnil (List.cons_ne_nil _ _)
        · cases hcons
          exact ⟨hab, hchain⟩
      exact ⟨walkOfChain b tl h1.2 |>.1, Walk.cons h1.1 (walkOfChain b tl h1.2).2⟩

/-- 链证据分解（`walkOfChain` cons 枝内部构造的外化，供各展开引理复用）。 -/
theorem isChain_cons_dest {n : ℕ} {a b : V n} {tl : List (V n)}
    (h : List.IsChain (knightGraph n).Adj (a :: b :: tl)) :
    (knightGraph n).Adj a b ∧ List.IsChain (knightGraph n).Adj (b :: tl) := by
  rw [List.isChain_cons_iff] at h
  rcases h with hnil | ⟨b', l', hab, hchain, hcons⟩
  · exact absurd hnil (List.cons_ne_nil _ _)
  · cases hcons
    exact ⟨hab, hchain⟩

/-- 展开辅助：cons 枝在 Sigma 两个分量上都归结为对尾列表的递归结果
    （链/邻接证据均为 Prop，证明无关性兜底，定义式展开即 `rfl`）。 -/
theorem walkOfChain_cons {n : ℕ} (a b : V n) (tl : List (V n))
    (h : List.IsChain (knightGraph n).Adj (a :: b :: tl)) :
    walkOfChain a (b :: tl) h =
      ⟨(walkOfChain b tl (isChain_cons_dest h).2).1,
        Walk.cons (isChain_cons_dest h).1 (walkOfChain b tl (isChain_cons_dest h).2).2⟩ := rfl

/-- 装载 walk 的终点 = 列表末格。 -/
theorem walkOfChain_endpoint {n : ℕ} (a : V n) : (l : List (V n)) →
    (h : List.IsChain (knightGraph n).Adj (a :: l)) →
    (walkOfChain a l h).1 = (a :: l).getLast (List.cons_ne_nil _ _)
  | [], _ => rfl
  | b :: tl, h => by
      rw [walkOfChain_cons a b tl h, List.getLast_cons_cons]
      exact walkOfChain_endpoint b tl (isChain_cons_dest h).2

/-- 装载 walk 的支撑 = 起点 :: 后继列表。 -/
theorem support_walkOfChain {n : ℕ} (a : V n) : (l : List (V n)) →
    (h : List.IsChain (knightGraph n).Adj (a :: l)) →
    (walkOfChain a l h).2.support = a :: l
  | [], _ => rfl
  | b :: tl, h => by
      rw [walkOfChain_cons a b tl h]
      show (Walk.cons (isChain_cons_dest h).1
        (walkOfChain b tl (isChain_cons_dest h).2).2).support = a :: b :: tl
      rw [Walk.support_cons, support_walkOfChain b tl (isChain_cons_dest h).2]

/-- 路径装载：nodup + 全覆盖 + 链邻接 ⇒ 哈密顿路径存在。 -/
theorem pathOfChain {n : ℕ} (l : List (V n)) (hne : l ≠ []) (hnodup : l.Nodup)
    (hcov : ∀ v : V n, v ∈ l) (hchain : l.IsChain (knightGraph n).Adj) :
    ∃ a b : V n, ∃ w : (knightGraph n).Walk a b, w.IsHamiltonian := by
  obtain ⟨a, tl, rfl⟩ := List.exists_cons_of_ne_nil hne
  refine ⟨a, (walkOfChain a tl hchain).1, (walkOfChain a tl hchain).2, ?_⟩
  intro x
  show (walkOfChain a tl hchain).2.support.count x = 1
  rw [support_walkOfChain]
  exact List.count_eq_one_of_mem hnodup (hcov x)

/-- 闭圈装载：nodup + 全覆盖 + 链邻接 + 首尾闭合邻接 + 长度 ≥3 ⇒ 哈密顿圈存在。 -/
theorem cycleOfChain {n : ℕ} (l : List (V n)) (hne : l ≠ []) (hnodup : l.Nodup)
    (hlen : 3 ≤ l.length)
    (hcov : ∀ v : V n, v ∈ l) (hchain : l.IsChain (knightGraph n).Adj)
    (hclose : (knightGraph n).Adj (l.getLast hne) (l.head hne)) :
    ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle := by
  obtain ⟨a, tl, rfl⟩ := List.exists_cons_of_ne_nil hne
  rw [List.length_cons] at hlen
  have htlne : tl ≠ [] := by
    rintro h; rw [h, List.length_nil] at hlen; omega
  obtain ⟨b, tl', rfl⟩ := List.exists_cons_of_ne_nil htlne
  rw [List.length_cons] at hlen
  have htl'ne : tl' ≠ [] := by
    rintro h; rw [h, List.length_nil] at hlen; omega
  obtain ⟨c, tl'', rfl⟩ := List.exists_cons_of_ne_nil htl'ne
  obtain ⟨hab, hchain'⟩ := isChain_cons_dest hchain
  have hclose' : (knightGraph n).Adj (walkOfChain b (c :: tl'') hchain').1 a := by
    rw [walkOfChain_endpoint b (c :: tl'') hchain']
    have h2 := hclose
    rw [List.head_cons, List.getLast_cons_cons] at h2
    exact h2
  refine ⟨a, Walk.cons hab
    ((walkOfChain b (c :: tl'') hchain').2.append (Walk.cons hclose' Walk.nil)), ?_⟩
  have hsupIn := support_walkOfChain b (c :: tl'') hchain'
  have haNin : a ∉ b :: c :: tl'' := (List.nodup_cons.mp hnodup).1
  have hbNin : b ∉ c :: tl'' := (List.nodup_cons.mp (List.nodup_cons.mp hnodup).2).1
  have htailNodup : ((b :: c :: tl'') ++ [a]).Nodup := by
    rw [List.nodup_append_comm]
    exact hnodup
  rw [SimpleGraph.Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one]
  refine ⟨?_, ?_⟩
  · rw [SimpleGraph.Walk.cons_isCycle_iff]
    refine ⟨?_, ?_⟩
    · apply SimpleGraph.Walk.IsPath.mk'
      rw [Walk.support_append, hsupIn, Walk.support_cons, Walk.support_nil]
      exact htailNodup
    · rw [Walk.edges_append, Walk.edges_cons, Walk.edges_nil]
      intro hmem
      rw [List.mem_append, List.mem_singleton] at hmem
      obtain hmem | hmem := hmem
      · have ha : a ∈ (walkOfChain b (c :: tl'') hchain').2.support :=
          (Walk.mem_support_iff_exists_mem_edges).mpr
            (Or.inr ⟨s(a, b), hmem, by rw [Sym2.mem_iff]; exact Or.inl rfl⟩)
        rw [hsupIn] at ha
        exact haNin ha
      · have hb2 : b ∈ s((walkOfChain b (c :: tl'') hchain').1, a) := by
          rw [← hmem, Sym2.mem_iff]; exact Or.inr rfl
        rw [Sym2.mem_iff] at hb2
        obtain hb2 | hb2 := hb2
        · apply hbNin
          rw [hb2, walkOfChain_endpoint b (c :: tl'') hchain', List.getLast_cons_cons]
          exact List.getLast_mem _
        · exact haNin (List.mem_cons.mpr (Or.inl hb2.symm))
  · intro v
    have h1 : (Walk.cons hab
        ((walkOfChain b (c :: tl'') hchain').2.append (Walk.cons hclose' Walk.nil))).support.tail
        = (b :: c :: tl'') ++ [a] := by
      rw [Walk.support_cons, Walk.support_append, hsupIn, Walk.support_cons, Walk.support_nil,
        List.tail_cons, List.tail_cons]
    rw [h1]
    apply List.count_eq_one_of_mem htailNodup
    rw [List.mem_append, List.mem_singleton]
    have hv := hcov v
    rw [List.mem_cons] at hv
    exact Or.comm.mp hv


/-! ## 8. 闭巡游延拓器·基础层（T2a） -/

/-- 顶点嵌入：K_n → K_(n+8)（列 val 不变；已由试桩验证）。 -/
def embedV {n : ℕ} (x : V n) : V (n + 8) :=
  ⟨(x.1.1, x.1.2.castLE (Nat.le_add_right n 8)), by
    obtain ⟨⟨r, c⟩, h1, h2⟩ := x
    refine ⟨?_, ?_⟩
    · rintro ⟨hr, hc⟩; exact h1 ⟨hr, by simpa using hc⟩
    · rintro ⟨hr, hc⟩
      apply h2; refine ⟨hr, ?_⟩
      have := c.isLt
      simp only [Fin.val_castLE] at hc
      omega⟩

theorem embedV_adj {n : ℕ} {x y : V n} (h : (knightGraph n).Adj x y) :
    (knightGraph (n + 8)).Adj (embedV x) (embedV y) := by
  rw [knightGraph_adj_iff] at h ⊢
  simp only [leap8, leap, embedV, Fin.val_castLE]
  convert h using 3

/-- 嵌入单射：V 层等式逐层投影（Subtype → Prod → Fin val）回拉。 -/
theorem embedV_injective {n : ℕ} : Function.Injective (embedV (n := n)) := by
  intro x y hxy
  have hrow : x.1.1 = y.1.1 := congrArg (fun z : V (n + 8) => z.1.1) hxy
  have hcolv : x.1.2.val = y.1.2.val :=
    congrArg (fun z : V (n + 8) => z.1.2.val) hxy
  exact Subtype.ext (Prod.ext hrow (Fin.ext hcolv))

/-- 窗口相对路径（Fin 3 × Fin 9；绝对列 = (n−1)+c_rel；Phase 0 P 数据）。 -/
def PRel : List (Fin 3 × Fin 9) :=
  [(1, 1), (2, 3), (1, 5), (0, 7), (2, 6), (1, 8), (0, 6), (2, 7), (0, 8), (1, 6), (0, 4), (1, 2), (2, 0), (0, 1), (1, 3), (2, 5), (1, 7), (0, 5), (2, 4), (0, 3), (2, 2), (1, 4), (0, 2), (2, 1)]

/-- 窗口格绝对化（绝对列 = (c+n)−1；截断减法对任意 n 安全，无需假设）。 -/
def pcellAbs (n : ℕ) (p : Fin 3 × Fin 9) : Cell (n + 8) := (p.1, ⟨(p.2.val + n) - 1, by omega⟩)

/-- 窗口格行 val 直通。 -/
theorem pcellAbs_val1 (n : ℕ) (p : Fin 3 × Fin 9) : (pcellAbs n p).1.val = p.1.val := rfl

/-- 窗口格列 val = c + n − 1（截断减法）。 -/
theorem pcellAbs_val2 (n : ℕ) (p : Fin 3 × Fin 9) : (pcellAbs n p).2.val = p.2.val + n - 1 := rfl

/-- PRel 中新洞位（(2,8)）缺席。 -/
theorem PRel_not_newhole : ∀ p ∈ PRel, p ≠ (2, 8) := by decide

/-- PRel 逐对相邻（相对层 = Cell 9 上的 leap8，decide）。 -/
theorem PRel_chain : PRel.IsChain (fun a b => leap8 (n := 9) a b) := by decide

/-- PRel 无重复（相对层）。 -/
theorem PRel_nodup : PRel.Nodup := by decide

/-- 平移保持单向骑士关系（逐枝单等式 omega，避免 8×8 析取爆炸）。 -/
theorem leap_shift {n : ℕ} (hn : 1 ≤ n) {a b : Fin 3 × Fin 9}
    (h : leap (n := 9) a b) : leap (pcellAbs n a) (pcellAbs n b) := by
  rcases h with (⟨hr, hc⟩|⟨hr, hc⟩|⟨hr, hc⟩|⟨hr, hc⟩)
  · exact Or.inl ⟨hr, by rw [pcellAbs_val2, pcellAbs_val2]; omega⟩
  · exact Or.inr (Or.inl ⟨hr, by rw [pcellAbs_val2, pcellAbs_val2]; omega⟩)
  · exact Or.inr (Or.inr (Or.inl ⟨hr, by rw [pcellAbs_val2, pcellAbs_val2]; omega⟩))
  · exact Or.inr (Or.inr (Or.inr ⟨hr, by rw [pcellAbs_val2, pcellAbs_val2]; omega⟩))

/-- 平移保持骑士邻接（行同、列同加 n 后减 1；截断减法需 1 ≤ n）。 -/
theorem pcellAbs_leap8 {n : ℕ} (hn : 1 ≤ n) {a b : Fin 3 × Fin 9}
    (h : leap8 (n := 9) a b) : leap8 (pcellAbs n a) (pcellAbs n b) := by
  rcases h with h' | h'
  · exact Or.inl (leap_shift hn h')
  · exact Or.inr (leap_shift hn h')

/-- 窗口格绝对化的 V 层装箱（显式类型签名，保 pmap 的 β 为 V 层）。 -/
def PAbsVmk {n : ℕ} (p : Fin 3 × Fin 9) (h : IsCell (n + 8) (pcellAbs n p)) : V (n + 8) :=
  ⟨pcellAbs n p, h⟩

/-- 窗口顶点列（V 层；新洞缺席由 PRel_not_newhole 给出，需 8 ≤ n）。 -/
def PAbsV {n : ℕ} (hn : 8 ≤ n) : List (V (n + 8)) :=
  List.pmap (PAbsVmk (n := n)) PRel
    (fun p hp => by
      have hnh := PRel_not_newhole p hp
      have hlt := p.2.isLt
      refine ⟨?_, ?_⟩
      · rintro ⟨hr, hc⟩
        have hc' : p.2.val + n - 1 = 0 := hc
        omega
      · rintro ⟨hr, hc⟩
        have hc' : p.2.val + n - 1 + 1 = n + 8 := hc
        have hr' : p.1.val = 2 := hr
        have hc8 : p.2 = ⟨8, by omega⟩ := Fin.ext (by omega : p.2.val = 8)
        have hr2 : p.1 = ⟨2, by omega⟩ := Fin.ext (by omega : p.1.val = 2)
        exact hnh (Prod.ext hr2 hc8))

theorem PAbsV_nodup {n : ℕ} (hn : 8 ≤ n) : (PAbsV hn).Nodup := by
  unfold PAbsV
  refine List.Nodup.pmap ?_ PRel_nodup
  intro a ha b hb hab
  have hrow : a.1 = b.1 := congrArg (fun z : V (n + 8) => z.1.1) hab
  have hcolv : a.2.val = b.2.val := by
    have hv : (a.2.val + n) - 1 = (b.2.val + n) - 1 :=
      congrArg (fun z : V (n + 8) => z.1.2.val) hab
    have ha9 := a.2.isLt
    have hb9 := b.2.isLt
    omega
  exact Prod.ext hrow (Fin.ext hcolv)

theorem PAbsV_chain {n : ℕ} (hn : 8 ≤ n) :
    (PAbsV hn).IsChain (knightGraph (n + 8)).Adj := by
  have h1n : 1 ≤ n := by omega
  unfold PAbsV
  refine List.isChain_pmap_of_isChain ?_ PRel_chain _
  intro a b ha hb hab
  exact knightGraph_adj_iff.mpr (pcellAbs_leap8 h1n hab)

/-- n=8 正向基座走法表（Cell 层；Phase 0 bases_forward.json，有向断边正向）。 -/
def baseFwd8List : List (Cell 8) :=
  [(1, 0), (0, 2), (2, 1), (1, 3), (0, 1), (2, 0), (1, 2), (0, 4), (1, 6), (2, 4), (0, 5), (1, 7), (2, 5), (0, 6), (1, 4), (2, 6), (0, 7), (1, 5), (2, 3), (1, 1), (0, 3), (2, 2)]

/-- n=10 正向基座走法表（Cell 层；Phase 0 bases_forward.json，有向断边正向）。 -/
def baseFwd10List : List (Cell 10) :=
  [(1, 0), (2, 2), (1, 4), (0, 6), (1, 8), (2, 6), (0, 5), (2, 4), (0, 3), (1, 1), (2, 3), (1, 5), (0, 7), (1, 9), (2, 7), (0, 8), (1, 6), (2, 8), (0, 9), (1, 7), (2, 5), (0, 4), (1, 2), (2, 0), (0, 1), (1, 3), (2, 1), (0, 2)]

/-- n=12 正向基座走法表（Cell 层；Phase 0 bases_forward.json，有向断边正向）。 -/
def baseFwd12List : List (Cell 12) :=
  [(1, 0), (2, 2), (1, 4), (2, 6), (0, 5), (1, 7), (2, 5), (0, 6), (1, 8), (0, 10), (2, 9), (1, 11), (0, 9), (2, 10), (0, 11), (1, 9), (2, 7), (1, 5), (0, 7), (2, 8), (1, 10), (0, 8), (1, 6), (2, 4), (0, 3), (1, 1), (2, 3), (0, 4), (1, 2), (2, 0), (0, 1), (1, 3), (2, 1), (0, 2)]

/-- n=14 正向基座走法表（Cell 层；Phase 0 bases_forward.json，有向断边正向）。 -/
def baseFwd14List : List (Cell 14) :=
  [(1, 0), (2, 2), (1, 4), (0, 6), (2, 5), (1, 7), (2, 9), (0, 8), (1, 6), (2, 8), (0, 7), (1, 5), (2, 7), (1, 9), (0, 11), (1, 13), (2, 11), (0, 12), (1, 10), (2, 12), (0, 13), (1, 11), (0, 9), (2, 10), (1, 12), (0, 10), (1, 8), (2, 6), (0, 5), (2, 4), (0, 3), (1, 1), (2, 3), (0, 4), (1, 2), (2, 0), (0, 1), (1, 3), (2, 1), (0, 2)]

/-- 四基座 V 层（decide 全判）。 -/
def baseV8 : List (V 8) := List.pmap (fun c h => (⟨c, h⟩ : V 8)) baseFwd8List
    (fun c hc => (show ∀ c ∈ baseFwd8List, IsCell 8 c from by decide) c hc)
def baseV10 : List (V 10) := List.pmap (fun c h => (⟨c, h⟩ : V 10)) baseFwd10List
    (fun c hc => (show ∀ c ∈ baseFwd10List, IsCell 10 c from by decide) c hc)
def baseV12 : List (V 12) := List.pmap (fun c h => (⟨c, h⟩ : V 12)) baseFwd12List
    (fun c hc => (show ∀ c ∈ baseFwd12List, IsCell 12 c from by decide) c hc)
def baseV14 : List (V 14) := List.pmap (fun c h => (⟨c, h⟩ : V 14)) baseFwd14List
    (fun c hc => (show ∀ c ∈ baseFwd14List, IsCell 14 c from by decide) c hc)

theorem baseV8_nodup : baseV8.Nodup := by decide

theorem baseV8_cover : ∀ v : V 8, v ∈ baseV8 := by decide

theorem baseV8_chain : baseV8.IsChain (knightGraph 8).Adj := by decide

/-- 闭合成边：末格 → 首格（索引形态，免 hne 杂耍）。 -/
theorem baseV8_close :
    (knightGraph 8).Adj (baseV8.get ⟨21, by decide⟩) (baseV8.get ⟨0, by decide⟩) := by decide

/-- n=8 有向断边左端（具名，避开语句内联匿名构造子的 TC 推迟坑）。 -/
def brkL8 : V 8 := ⟨(2, 6), by decide⟩
/-- n=8 有向断边右端。 -/
def brkR8 : V 8 := ⟨(0, 7), by decide⟩

/-- 有向断边不变量（索引形态）：位置 15/16 = (2,6)→(0,7)。 -/
theorem baseV8_invariant :
    baseV8.get ⟨15, by decide⟩ = brkL8 ∧ baseV8.get ⟨16, by decide⟩ = brkR8 := by decide

theorem baseV10_nodup : baseV10.Nodup := by decide

theorem baseV10_cover : ∀ v : V 10, v ∈ baseV10 := by decide

theorem baseV10_chain : baseV10.IsChain (knightGraph 10).Adj := by decide

/-- 闭合成边：末格 → 首格（索引形态，免 hne 杂耍）。 -/
theorem baseV10_close :
    (knightGraph 10).Adj (baseV10.get ⟨27, by decide⟩) (baseV10.get ⟨0, by decide⟩) := by decide

/-- n=10 有向断边左端（具名，避开语句内联匿名构造子的 TC 推迟坑）。 -/
def brkL10 : V 10 := ⟨(2, 8), by decide⟩
/-- n=10 有向断边右端。 -/
def brkR10 : V 10 := ⟨(0, 9), by decide⟩

/-- 有向断边不变量（索引形态）：位置 17/18 = (2,8)→(0,9)。 -/
theorem baseV10_invariant :
    baseV10.get ⟨17, by decide⟩ = brkL10 ∧ baseV10.get ⟨18, by decide⟩ = brkR10 := by decide

theorem baseV12_nodup : baseV12.Nodup := by decide

theorem baseV12_cover : ∀ v : V 12, v ∈ baseV12 := by decide

theorem baseV12_chain : baseV12.IsChain (knightGraph 12).Adj := by decide

/-- 闭合成边：末格 → 首格（索引形态，免 hne 杂耍）。 -/
theorem baseV12_close :
    (knightGraph 12).Adj (baseV12.get ⟨33, by decide⟩) (baseV12.get ⟨0, by decide⟩) := by decide

/-- n=12 有向断边左端（具名，避开语句内联匿名构造子的 TC 推迟坑）。 -/
def brkL12 : V 12 := ⟨(2, 10), by decide⟩
/-- n=12 有向断边右端。 -/
def brkR12 : V 12 := ⟨(0, 11), by decide⟩

/-- 有向断边不变量（索引形态）：位置 13/14 = (2,10)→(0,11)。 -/
theorem baseV12_invariant :
    baseV12.get ⟨13, by decide⟩ = brkL12 ∧ baseV12.get ⟨14, by decide⟩ = brkR12 := by decide

theorem baseV14_nodup : baseV14.Nodup := by decide

theorem baseV14_cover : ∀ v : V 14, v ∈ baseV14 := by decide

theorem baseV14_chain : baseV14.IsChain (knightGraph 14).Adj := by decide

/-- 闭合成边：末格 → 首格（索引形态，免 hne 杂耍）。 -/
theorem baseV14_close :
    (knightGraph 14).Adj (baseV14.get ⟨39, by decide⟩) (baseV14.get ⟨0, by decide⟩) := by decide

/-- n=14 有向断边左端（具名，避开语句内联匿名构造子的 TC 推迟坑）。 -/
def brkL14 : V 14 := ⟨(2, 12), by decide⟩
/-- n=14 有向断边右端。 -/
def brkR14 : V 14 := ⟨(0, 13), by decide⟩

/-- 有向断边不变量（索引形态）：位置 19/20 = (2,12)→(0,13)。 -/
theorem baseV14_invariant :
    baseV14.get ⟨19, by decide⟩ = brkL14 ∧ baseV14.get ⟨20, by decide⟩ = brkR14 := by decide


/-! ## 9. 闭巡游延拓器·好列表与基座组装 -/

/-- 闭圈好列表（装载层四条件 + 有向断边不变量，val 表达免 Fin 字面量）。 -/
def GoodCycleList {n : ℕ} (l : List (V n)) : Prop :=
  l ≠ [] ∧ l.Nodup ∧ (∀ v : V n, v ∈ l) ∧ l.IsChain (knightGraph n).Adj ∧
    (∀ hne : l ≠ [], (knightGraph n).Adj (l.getLast hne) (l.head hne)) ∧
    (∃ j : Fin l.length,
        (l.get j).1.1.val = 2 ∧ (l.get j).1.2.val + 2 = n ∧
        (l.get ⟨(j.val + 1) % l.length, Nat.mod_lt _ (by have := j.isLt; omega)⟩).1.1.val = 0 ∧
        (l.get ⟨(j.val + 1) % l.length, Nat.mod_lt _ (by have := j.isLt; omega)⟩).1.2.val + 1 = n)

/-- n=8 基座是好列表（闭合成边与断边不变量均 decide 直判）。 -/
theorem baseV8_good : GoodCycleList baseV8 := by
  refine ⟨by decide, baseV8_nodup, baseV8_cover, baseV8_chain, ?_, ?_⟩
  · intro hne
    exact baseV8_close
  · refine ⟨⟨15, by decide⟩, ?_, ?_, ?_, ?_⟩
    · rw [baseV8_invariant.1]
      rfl
    · rw [baseV8_invariant.1]
      rfl
    · show (brkR8).1.1.val = 0
      rfl
    · show (brkR8).1.2.val + 1 = 8
      rfl

/-- n=10 基座是好列表。 -/
theorem baseV10_good : GoodCycleList baseV10 := by
  refine ⟨by decide, baseV10_nodup, baseV10_cover, baseV10_chain, ?_, ?_⟩
  · intro hne
    exact baseV10_close
  · refine ⟨⟨17, by decide⟩, ?_, ?_, ?_, ?_⟩
    · rw [baseV10_invariant.1]
      rfl
    · rw [baseV10_invariant.1]
      rfl
    · show (brkR10).1.1.val = 0
      rfl
    · show (brkR10).1.2.val + 1 = 10
      rfl

/-- n=12 基座是好列表。 -/
theorem baseV12_good : GoodCycleList baseV12 := by
  refine ⟨by decide, baseV12_nodup, baseV12_cover, baseV12_chain, ?_, ?_⟩
  · intro hne
    exact baseV12_close
  · refine ⟨⟨13, by decide⟩, ?_, ?_, ?_, ?_⟩
    · rw [baseV12_invariant.1]
      rfl
    · rw [baseV12_invariant.1]
      rfl
    · show (brkR12).1.1.val = 0
      rfl
    · show (brkR12).1.2.val + 1 = 12
      rfl

/-- n=14 基座是好列表。 -/
theorem baseV14_good : GoodCycleList baseV14 := by
  refine ⟨by decide, baseV14_nodup, baseV14_cover, baseV14_chain, ?_, ?_⟩
  · intro hne
    exact baseV14_close
  · refine ⟨⟨19, by decide⟩, ?_, ?_, ?_, ?_⟩
    · rw [baseV14_invariant.1]
      rfl
    · rw [baseV14_invariant.1]
      rfl
    · show (brkR14).1.1.val = 0
      rfl
    · show (brkR14).1.2.val + 1 = 14
      rfl


/-! ## 10. 拼接步 -/

/-! ### 10.1 嵌入取值与窗口取值小引理 -/

theorem embedV_val1 {n : ℕ} (x : V n) : (embedV x).1.1.val = x.1.1.val := rfl

theorem embedV_val2 {n : ℕ} (x : V n) : (embedV x).1.2.val = x.1.2.val := by
  simp only [embedV, Fin.val_castLE]

/-- `PAbsV` 长度 = 24（pmap 对字面 `PRel` 的 iota 归约）。 -/
theorem PAbsV_length {n : ℕ} (hn : 8 ≤ n) : (PAbsV hn).length = 24 := by rfl

theorem PAbsV_ne {n : ℕ} (hn : 8 ≤ n) : PAbsV hn ≠ [] := by
  intro hcon
  have hp := PAbsV_length hn
  rw [hcon, List.length_nil] at hp
  omega

/-- `PAbsV` 成员的格级刻画。 -/
theorem PAbsV_mem_iff {n : ℕ} (hn : 8 ≤ n) (x : V (n + 8)) :
    x ∈ PAbsV hn ↔ ∃ p ∈ PRel, x.1 = pcellAbs n p := by
  simp only [PAbsV]
  rw [List.mem_pmap]
  constructor
  · rintro ⟨p, hp, hf⟩
    exact ⟨p, hp, (congrArg (fun z : V (n + 8) => z.1) hf).symm⟩
  · rintro ⟨p, hp, hxe⟩
    exact ⟨p, hp, Subtype.ext hxe.symm⟩

/-- 窗口末格 = (2, n)（行）。 -/
theorem PAbsV_last_row {n : ℕ} (hn : 8 ≤ n) (hne : PAbsV hn ≠ []) :
    ((PAbsV hn).getLast hne).1.1.val = 2 := rfl

/-- 窗口末格 = (2, n)（列）。 -/
theorem PAbsV_last_col {n : ℕ} (hn : 8 ≤ n) (hne : PAbsV hn ≠ []) :
    ((PAbsV hn).getLast hne).1.2.val = n := by
  show (1:ℕ) + n - 1 = n
  omega

/-- `PAbsV` 末格的索引形态（供拼接边引用）。 -/
theorem PAbsV_last_eq {n : ℕ} (hn : 8 ≤ n) (hne : PAbsV hn ≠ []) :
    (PAbsV hn).getLast hne = (PAbsV hn)[23]'(by rw [PAbsV_length hn]; decide) := by
  rw [List.getLast_eq_getElem hne]
  simp only [PAbsV_length hn]

/-- 窗口第 7 格 = (2, n+6)（行）——新断边左端。 -/
theorem PAbsV_idx7_row {n : ℕ} (hn : 8 ≤ n) :
    ((PAbsV hn)[7]'(by rw [PAbsV_length hn]; decide)).1.1.val = 2 := rfl

/-- 窗口第 7 格（列）。 -/
theorem PAbsV_idx7_col {n : ℕ} (hn : 8 ≤ n) :
    ((PAbsV hn)[7]'(by rw [PAbsV_length hn]; decide)).1.2.val = n + 6 := by
  show (7:ℕ) + n - 1 = n + 6
  omega

/-- 窗口第 8 格 = (0, n+7)（行）——新断边右端。 -/
theorem PAbsV_idx8_row {n : ℕ} (hn : 8 ≤ n) :
    ((PAbsV hn)[8]'(by rw [PAbsV_length hn]; decide)).1.1.val = 0 := rfl

/-- 窗口第 8 格（列）。 -/
theorem PAbsV_idx8_col {n : ℕ} (hn : 8 ≤ n) :
    ((PAbsV hn)[8]'(by rw [PAbsV_length hn]; decide)).1.2.val = n + 7 := by
  show (8:ℕ) + n - 1 = n + 7
  omega

/-- `PRel` 含 (2,0)（对应旧洞 (2, n−1) 的窗口位）。 -/
theorem PRel_mem_20 : (2, 0) ∈ PRel := by decide

/-- `PRel` 中 c9 = 0 的只有 (2,0)。 -/
theorem PRel_c9_0 : ∀ p ∈ PRel, p.2.val = 0 → p.1.val = 2 := by decide

/-- `PRel` 覆盖全部 c9 ∈ 1..8 的格（除新洞 (2,8)）。 -/
theorem PRel_univ : ∀ p : Fin 3 × Fin 9, 1 ≤ p.2.val → p ≠ (2, 8) → p ∈ PRel := by decide

/-- 嵌入格不撞窗口格（列分层 + 旧洞 (2, m−1) 只在窗口侧出现）。 -/
theorem embedV_ne_PAbsV {m : ℕ} (hm : 8 ≤ m) (x : V m) {b : V (m + 8)}
    (hb : b ∈ PAbsV hm) : embedV x ≠ b := by
  rintro heq
  obtain ⟨p, hp, hpx⟩ := (PAbsV_mem_iff hm b).mp hb
  have hcol : x.1.2.val = p.2.val + m - 1 := by
    have h := congrArg (fun z : V (m + 8) => z.1.2.val) heq
    rwa [embedV_val2, hpx, pcellAbs_val2] at h
  have hrow : x.1.1.val = p.1.val := by
    have h := congrArg (fun z : V (m + 8) => z.1.1.val) heq
    rwa [embedV_val1, hpx, pcellAbs_val1] at h
  have hc0 : p.2.val = 0 := by
    have h9 := p.2.isLt
    omega
  exact x.2.2 ⟨hrow.trans (PRel_c9_0 p hp hc0), by omega⟩

/-- 索引相等迁移（按 ℕ 等式重索引，免实例证明钉死 motive）。 -/
theorem reindex_getElem {α : Type*} {l : List α} {i j : ℕ}
    (hi : i < l.length) (hj : j < l.length) (h : i = j) : l[i]'hi = l[j]'hj := by
  subst h
  rfl

/-! ### 10.2 拼接步本体 -/

/-- 步进：好列表在 m → 好列表在 m+8（splice：有向断边处插入 24 格窗口路径）。 -/
theorem step_closed_list {m : ℕ} (hm : 8 ≤ m) {l : List (V m)} (hg : GoodCycleList l) :
    ∃ l' : List (V (m + 8)), GoodCycleList l' := by
  obtain ⟨hne, hnd, hcov, hchain, hclose, j, hj1r, hj1c, hj2r, hj2c⟩ := hg
  have hjk : j.val < l.length := j.isLt
  have hjk0 : 0 < l.length := by omega
  have hj1r' : (l.get ⟨j.val, hjk⟩).1.1.val = 2 := hj1r
  have hj1c' : (l.get ⟨j.val, hjk⟩).1.2.val + 2 = m := hj1c
  have hkle : j.val + 1 ≤ l.length := by omega
  have hWne : PAbsV hm ≠ [] := PAbsV_ne hm
  have hWlen : (PAbsV hm).length = 24 := PAbsV_length hm
  have hL1len : ((l.take (j.val + 1)).map embedV).length = j.val + 1 := by
    rw [List.length_map, List.length_take, min_eq_left hkle]
  have hL2len : ((l.drop (j.val + 1)).map embedV).length = l.length - (j.val + 1) := by
    rw [List.length_map, List.length_drop]
  have hLWlen : ((l.take (j.val + 1)).map embedV ++ PAbsV hm).length = j.val + 25 := by
    rw [List.length_append, hL1len, hWlen]
  have hl' : (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
      (l.drop (j.val + 1)).map embedV).length = l.length + 24 := by
    rw [List.length_append, hLWlen, hL2len]
    omega
  -- take/drop 两侧不交（供 nodup 交叉用）
  have hdisj : List.Disjoint (l.take (j.val + 1)) (l.drop (j.val + 1)) := by
    have hl2 : (l.take (j.val + 1) ++ l.drop (j.val + 1)).Nodup := by
      rw [List.take_append_drop (j.val + 1) l]
      exact hnd
    exact List.disjoint_of_nodup_append hl2
  -- 原 V m 格的嵌入必落 take 侧或 drop 侧
  have embInL' : ∀ x : V m, embedV x ∈ (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
      (l.drop (j.val + 1)).map embedV) := by
    intro x
    have hx : x ∈ l := hcov x
    rw [← List.take_append_drop (j.val + 1) l] at hx
    rw [List.mem_append]
    rcases List.mem_append.mp hx with ht | hd
    · refine Or.inl ?_
      rw [List.mem_append]
      exact Or.inl (List.mem_map.mpr ⟨x, ht, rfl⟩)
    · exact Or.inr (List.mem_map.mpr ⟨x, hd, rfl⟩)
  have hmemDrop : ∀ x : V m, x ∈ l.drop (j.val + 1) → x ∈ l := by
    intro x hx
    rw [← List.take_append_drop (j.val + 1) l]
    exact List.mem_append.mpr (Or.inr hx)
  -- 原像构造：列带不越过旧洞的 v 可回拉到 V m
  have preim : ∀ v : V (m + 8), v.1.2.val + 1 ≤ m →
      (v.1.2.val + 1 < m ∨ v.1.1.val ≠ 2) → ∃ x : V m, embedV x = v := by
    intro v hc hr
    have hrlt : v.1.1.val < 3 := v.1.1.isLt
    have hclt : v.1.2.val < m := by have := v.1.2.isLt; omega
    have hcell : IsCell m (⟨v.1.1.val, hrlt⟩, ⟨v.1.2.val, hclt⟩) := by
      refine ⟨?_, ?_⟩
      · rintro ⟨hr0, hc0⟩
        exact v.2.1 ⟨by show v.1.1.val = 0; omega, by show v.1.2.val = 0; omega⟩
      · rintro ⟨hr2, hc2⟩
        rcases hr with hlt | hne2
        · have h2 : v.1.2.val + 1 = m := hc2
          omega
        · exact hne2 hr2
    refine ⟨⟨(⟨v.1.1.val, hrlt⟩, ⟨v.1.2.val, hclt⟩), hcell⟩, ?_⟩
    apply Subtype.ext; apply Prod.ext
    · apply Fin.ext; rfl
    · apply Fin.ext; rfl
  refine ⟨((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
    (l.drop (j.val + 1)).map embedV, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- 1. 非空
    intro hcon
    rw [hcon, List.length_nil] at hl'
    omega
  · -- 2. 无重复（(L1 ++ W) ++ L2 三段两两不交）
    rw [List.nodup_append]
    refine ⟨?_, (hnd.sublist (List.drop_sublist (j.val + 1) l)).map embedV_injective, ?_⟩
    · rw [List.nodup_append]
      refine ⟨(hnd.sublist (List.take_sublist (j.val + 1) l)).map embedV_injective,
        PAbsV_nodup hm, ?_⟩
      · rintro a ha b hb hab
        rw [List.mem_map] at ha
        obtain ⟨x, hx, ha'⟩ := ha
        exact embedV_ne_PAbsV hm x hb (ha'.trans hab)
    · rintro a ha b hb hab
      rw [List.mem_append] at ha
      rcases ha with ha | ha
      · rw [List.mem_map] at ha hb
        obtain ⟨x, hx, ha'⟩ := ha
        obtain ⟨y, hy, hb'⟩ := hb
        have heq : x = y := by
          apply embedV_injective
          rw [ha', hab, hb']
        exact hdisj hx (by rw [heq]; exact hy)
      · rw [List.mem_map] at hb
        obtain ⟨y, hy, hb'⟩ := hb
        exact embedV_ne_PAbsV hm y ha (hb'.trans hab.symm)
  · -- 3. 覆盖
    intro v
    rcases Nat.lt_or_ge (v.1.2.val) (m - 1) with hcl | hcl
    · -- 左案：col < m−1 → 原象
      obtain ⟨x, hx⟩ := preim v (by omega) (Or.inl (by omega))
      rw [← hx]
      exact embInL' x
    · rcases Nat.lt_or_ge (v.1.2.val) m with hlt2 | hge2
      · -- 中案：col = m−1
        have hcm1 : v.1.2.val = m - 1 := by omega
        by_cases hr2 : v.1.1.val = 2
        · rw [List.mem_append, List.mem_append]
          refine Or.inl (Or.inr ((PAbsV_mem_iff hm v).mpr ⟨(2, 0), PRel_mem_20, ?_⟩))
          have h1 : v.1.1.val = (pcellAbs m (2, 0)).1.val := by
            show v.1.1.val = 2
            exact hr2
          have h2 : v.1.2.val = (pcellAbs m (2, 0)).2.val := by
            show v.1.2.val = (0:ℕ) + m - 1
            omega
          exact Prod.ext (Fin.ext h1) (Fin.ext h2)
        · obtain ⟨x, hx⟩ := preim v (by omega) (Or.inr hr2)
          rw [← hx]
          exact embInL' x
      · -- 右案：col ≥ m → 窗口格（c9 = col − m + 1 ∈ 1..8；(2,8) 被新洞排掉）
        have hr3 : v.1.1.val < 3 := v.1.1.isLt
        have hb9 : v.1.2.val - m + 1 < 9 := by have := v.1.2.isLt; omega
        have hb1 : 1 ≤ v.1.2.val - m + 1 := by omega
        rw [List.mem_append, List.mem_append]
        refine Or.inl (Or.inr ((PAbsV_mem_iff hm v).mpr
          ⟨(⟨v.1.1.val, hr3⟩, ⟨v.1.2.val - m + 1, hb9⟩), PRel_univ _ hb1 ?_, ?_⟩))
        · -- 新洞 (2,8) 排除
          rintro heq
          have hs1 := congrArg Prod.fst heq.symm
          have hs2 := congrArg Prod.snd heq.symm
          have hv2 : v.1.2.val - m + 1 = 8 := (congrArg (fun q : Fin 9 => q.val) hs2).symm
          have hv1 : v.1.1.val = 2 := (congrArg (fun q : Fin 3 => q.val) hs1).symm
          exact v.2.2 ⟨hv1, by omega⟩
        · -- v.1 = pcellAbs m (row, c9)
          have h1 : v.1.1.val =
              (pcellAbs m (⟨v.1.1.val, hr3⟩, ⟨v.1.2.val - m + 1, hb9⟩)).1.val := rfl
          have h2 : v.1.2.val =
              (pcellAbs m (⟨v.1.1.val, hr3⟩, ⟨v.1.2.val - m + 1, hb9⟩)).2.val := by
            show v.1.2.val = (v.1.2.val - m + 1) + m - 1
            omega
          exact Prod.ext (Fin.ext h1) (Fin.ext h2)
  · -- 4. 链
    have hL1c : ((l.take (j.val + 1)).map embedV).IsChain (knightGraph (m + 8)).Adj :=
      List.isChain_map_of_isChain embedV (fun a b hab => embedV_adj hab)
        (hchain.take (j.val + 1))
    have hWc := PAbsV_chain hm
    have hL2c : ((l.drop (j.val + 1)).map embedV).IsChain (knightGraph (m + 8)).Adj :=
      List.isChain_map_of_isChain embedV (fun a b hab => embedV_adj hab)
        (hchain.drop (j.val + 1))
    have hL1ne : (l.take (j.val + 1)).map embedV ≠ [] := by
      intro hcon
      rw [hcon, List.length_nil] at hL1len
      omega
    have hLWne : (l.take (j.val + 1)).map embedV ++ PAbsV hm ≠ [] := by
      intro hcon
      rw [List.append_eq_nil_iff] at hcon
      exact hWne hcon.2
    have hlast1 : ((l.take (j.val + 1)).map embedV).getLast? =
        some (embedV (l.get ⟨j.val, hjk⟩)) := by
      rw [List.getLast?_eq_getLast_of_ne_nil hL1ne, List.getLast_eq_getElem hL1ne,
        Option.some_inj, List.getElem_map, List.getElem_take]
      congr 1
      simp only [hL1len, Nat.add_sub_cancel]
      rfl
    have hWhead? : (PAbsV hm).head? = some ((PAbsV hm)[0]'(by rw [hWlen]; decide)) := rfl
    refine (hL1c.append hWc ?_).append hL2c ?_
    · -- J1：嵌入断边左端 (2, m−2) → 窗口首格 (1, m)
      rintro x hx y hy
      rw [hlast1] at hx
      rw [hWhead?] at hy
      rw [Option.mem_def, Option.some_inj] at hx
      rw [Option.mem_def, Option.some_inj] at hy
      subst hx
      subst hy
      have w0r : ((PAbsV hm)[0]'(by rw [hWlen]; decide)).1.1.val = 1 := rfl
      have w0c : ((PAbsV hm)[0]'(by rw [hWlen]; decide)).1.2.val = m := by
        show (1:ℕ) + m - 1 = m
        omega
      refine knightGraph_adj_iff.mpr (Or.inl (Or.inr (Or.inr (Or.inl ⟨?_, ?_⟩))))
      · rw [w0r, embedV_val1, hj1r']
      · rw [embedV_val2, hj1c', w0c]
    · -- J2：窗口末格 (2, m) → 嵌入断边右端 (0, m−1)（L2 空时该侧条件空洞）
      rintro x hx y hy
      have hLWlast? : ((l.take (j.val + 1)).map embedV ++ PAbsV hm).getLast? =
          some ((PAbsV hm).getLast hWne) := by
        rw [List.getLast?_eq_getLast_of_ne_nil hLWne,
          List.getLast_append_of_right_ne_nil _ _ hWne]
      rw [hLWlast?] at hx
      rw [Option.mem_def, Option.some_inj] at hx
      rcases em (((l.drop (j.val + 1)).map embedV) = []) with hL2e | hL2ne
      · -- L2 空：该侧条件不可能满足
        rw [hL2e] at hy
        simp at hy
      · -- L2 非空
        have hlt2 : j.val + 1 < l.length := by
          by_contra hcon
          have h1 : l.drop (j.val + 1) = [] := by
            rw [show j.val + 1 = l.length by omega, List.drop_length]
          apply hL2ne
          rw [h1, List.map_nil]
        have hyx : ∀ pf : (j.val + 1) % l.length < l.length,
            l.get ⟨(j.val + 1) % l.length, pf⟩ = l.get ⟨j.val + 1, hlt2⟩ :=
          fun pf => congrArg (l.get) (Fin.ext (Nat.mod_eq_of_lt hlt2))
        rw [hyx _] at hj2r hj2c
        have hj2r'' : (l[j.val + 1]'hlt2).1.1.val = 0 := hj2r
        have hj2c'' : (l[j.val + 1]'hlt2).1.2.val + 1 = m := hj2c
        rw [List.head?_eq_some_head hL2ne, Option.mem_def, Option.some_inj] at hy
        rw [List.head_eq_getElem_zero hL2ne, List.getElem_map, List.getElem_drop] at hy
        simp only [Nat.add_zero] at hy
        have hy' : y = embedV (l[j.val + 1]'hlt2) := hy.symm
        rw [hy', ← hx]
        refine knightGraph_adj_iff.mpr (Or.inr (Or.inr (Or.inl ⟨?_, ?_⟩)))
        · rw [embedV_val1, hj2r'', PAbsV_last_row hm hWne]
        · rw [PAbsV_last_col hm hWne, embedV_val2, hj2c'']
  · -- 5. 闭合成边（统一经 getElem 展开，按 L2 空否分 dite 两支）
    have hc := hclose hne
    rw [List.getLast_eq_getElem hne, List.head_eq_getElem_zero hne] at hc
    have hW23edge : ∀ y : V m, y.1.1.val = 0 → y.1.2.val + 1 = m →
        (knightGraph (m + 8)).Adj ((PAbsV hm).getLast hWne) (embedV y) := by
      intro y hy1 hy2
      refine knightGraph_adj_iff.mpr (Or.inr (Or.inr (Or.inl ⟨?_, ?_⟩)))
      · rw [embedV_val1, hy1, PAbsV_last_row hm hWne]
      · rw [PAbsV_last_col hm hWne, embedV_val2, hy2]
    intro hne'
    have hhead : ((((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV).head hne') = embedV (l[0]'hjk0) := by
      rw [List.head_eq_getElem_zero hne', List.getElem_append,
        dif_pos (by rw [hLWlen]; omega), List.getElem_append,
        dif_pos (by rw [hL1len]; omega), List.getElem_map, List.getElem_take]
    rw [List.getLast_eq_getElem hne']
    simp only [hl']
    rw [List.getElem_append]
    split
    · -- 尾支 1：L2 空；闭合边 = 窗口末格 (2, m) → l[0] = (0, m−1)
      rename_i hbr
      rw [hhead]
      rw [List.getElem_append, dif_neg (by rw [hL1len]; omega)]
      simp only [hL1len]
      have hlen_eq : j.val + 1 = l.length := by omega
      have heq0 : (j.val + 1) % l.length = 0 := by
        rw [hlen_eq, Nat.mod_self]
      have hyx0 : ∀ pf : (j.val + 1) % l.length < l.length,
          l.get ⟨(j.val + 1) % l.length, pf⟩ = l.get ⟨0, hjk0⟩ :=
        fun pf => congrArg (l.get) (Fin.ext heq0)
      rw [hyx0 _] at hj2r hj2c
      have hj2r0 : (l[0]'hjk0).1.1.val = 0 := hj2r
      have hj2c0 : (l[0]'hjk0).1.2.val + 1 = m := hj2c
      have h23 : l.length + 24 - 1 - (j.val + 1) = 23 := by omega
      simp only [h23]
      exact hW23edge (l[0]'hjk0) hj2r0 hj2c0
    · -- 尾支 2：L2 非空；闭合边 = 嵌入后的原首尾边
      rename_i hbr
      rw [hhead]
      simp only [hLWlen]
      rw [List.getElem_map, List.getElem_drop]
      have hidx2 : l.length - 1 =
          (j.val + 1) + (l.length + 24 - 1 - (j.val + 25)) := by omega
      simp only [hidx2] at hc
      exact embedV_adj hc
  · -- 6. 有向断边不变量（新位置 j+8：窗口第 7/8 格）
    have hp8 : j.val + 8 < (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV).length := by rw [hl']; omega
    have he7 : (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV).get (⟨j.val + 8, hp8⟩ : Fin _)
        = ((PAbsV hm)[7]'(by omega)) := by
      show ((((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV)[j.val + 8]'(by omega) =
        ((PAbsV hm)[7]'(by omega)))
      rw [List.getElem_append, dif_pos (by rw [hLWlen]; omega),
        List.getElem_append, dif_neg (by rw [hL1len]; omega)]
      simp only [hL1len]
      have hidx7 : j.val + 8 - (j.val + 1) = 7 := by omega
      simp only [hidx7]
    have hmod8 : ((⟨j.val + 8, hp8⟩ : Fin _).val + 1) %
        (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
          (l.drop (j.val + 1)).map embedV).length = j.val + 9 :=
      Nat.mod_eq_of_lt (by
        have hval : (⟨j.val + 8, hp8⟩ : Fin _).val = j.val + 8 := rfl
        omega)
    have he8 : (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV).get
        ⟨((⟨j.val + 8, hp8⟩ : Fin _).val + 1) %
          (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
            (l.drop (j.val + 1)).map embedV).length,
          Nat.mod_lt _ (by omega)⟩
        = ((PAbsV hm)[8]'(by omega)) := by
      show ((((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
        (l.drop (j.val + 1)).map embedV)[((⟨j.val + 8, hp8⟩ : Fin _).val + 1) %
        (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
          (l.drop (j.val + 1)).map embedV).length]'(by omega) =
        ((PAbsV hm)[8]'(by omega)))
      rw [List.getElem_append, dif_pos (by rw [hLWlen]; omega),
        List.getElem_append, dif_neg (by rw [hL1len]; omega)]
      simp only [hL1len]
      have hidx8 : ((⟨j.val + 8, hp8⟩ : Fin _).val + 1) %
          (((l.take (j.val + 1)).map embedV ++ PAbsV hm) ++
            (l.drop (j.val + 1)).map embedV).length - (j.val + 1) = 8 := by
        rw [hmod8]
        omega
      simp only [hidx8]
    refine ⟨⟨j.val + 8, hp8⟩, ?_, ?_, ?_, ?_⟩
    · rw [he7]
      exact PAbsV_idx7_row hm
    · rw [he7, PAbsV_idx7_col hm]
    · rw [he8]
      exact PAbsV_idx8_row hm
    · rw [he8, PAbsV_idx8_col hm]

/-! ## 11. 闭侧归纳组装（T2b-3） -/

/-- n ≥ 8 时 V n 至少含三个互异顶点（(1,0)、(2,0)、(0,1)）。 -/
theorem three_vertices_exist {n : ℕ} (hn : 8 ≤ n) :
    ∃ v1 v2 v3 : V n, v1 ≠ v2 ∧ v1 ≠ v3 ∧ v2 ≠ v3 := by
  refine ⟨⟨((⟨1, by omega⟩, ⟨0, by omega⟩) : Cell n), by
      refine ⟨by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega,
        by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega⟩⟩,
    ⟨((⟨2, by omega⟩, ⟨0, by omega⟩) : Cell n), by
      refine ⟨by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega,
        by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega⟩⟩,
    ⟨((⟨0, by omega⟩, ⟨1, by omega⟩) : Cell n), by
      refine ⟨by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega,
        by rintro ⟨hr, hc⟩; simp only [Fin.val_mk] at hr hc; omega⟩⟩,
    ?_, ?_, ?_⟩
  · intro h
    have h1 : (1:ℕ) = 2 := congrArg (fun z : V n => z.1.1.val) h
    omega
  · intro h
    have h1 : (1:ℕ) = 0 := congrArg (fun z : V n => z.1.1.val) h
    omega
  · intro h
    have h1 : (2:ℕ) = 0 := congrArg (fun z : V n => z.1.1.val) h
    omega

/-- 闭侧好列表存在性：偶数 n ≥ 8 ⇒ 存在 GoodCycleList
    （强归纳：小 n 四基座 8/10/12/14，步进 m ↦ m+8）。 -/
theorem closed_good_list : ∀ n : ℕ, 8 ≤ n → Even n → ∃ l : List (V n), GoodCycleList l := by
  intro n
  apply Nat.strong_induction_on
    (p := fun n => 8 ≤ n → Even n → ∃ l : List (V n), GoodCycleList l)
  intro n ih hn heven
  rcases Nat.lt_or_ge n 16 with h16 | h16
  · -- 小 n：8 ≤ n < 16 且偶数 ⇒ n ∈ {8, 10, 12, 14}
    rcases heven with ⟨m, hm⟩
    have hn' : n = 8 ∨ n = 10 ∨ n = 12 ∨ n = 14 := by omega
    rcases hn' with h | h | h | h
    · subst h; exact ⟨baseV8, baseV8_good⟩
    · subst h; exact ⟨baseV10, baseV10_good⟩
    · subst h; exact ⟨baseV12, baseV12_good⟩
    · subst h; exact ⟨baseV14, baseV14_good⟩
  · -- n ≥ 16：从 n − 8 步进
    have hn8 : n - 8 < n := by omega
    have hn8' : 8 ≤ n - 8 := by omega
    have heven8 : Even (n - 8) := by
      rcases heven with ⟨m, hm⟩
      exact ⟨m - 4, by omega⟩
    obtain ⟨l, hg⟩ := ih (n - 8) hn8 hn8' heven8
    obtain ⟨l', hg'⟩ := step_closed_list hn8' hg
    rw [← show n - 8 + 8 = n from by omega]
    exact ⟨l', hg'⟩

/-- 闭巡游存在性（正向）：偶数 n ≥ 8 ⇒ K_n 存在哈密顿圈
    （GoodCycleList 经 cycleOfChain 装载为 IsHamiltonianCycle）。 -/
theorem closed_cycle_exists : ∀ n : ℕ, Even n → 8 ≤ n →
    ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle := by
  intro n heven hn
  obtain ⟨l, hg⟩ := closed_good_list n hn heven
  obtain ⟨hne, hnd, hcov, hchain, hclose, j, hj1r, hj1c, hj2r, hj2c⟩ := hg
  obtain ⟨v1, v2, v3, h12, h13, h23⟩ := three_vertices_exist hn
  have hlen : 3 ≤ l.length := by
    have hsub : [v1, v2, v3] ⊆ l := fun a ha => by
      rw [List.mem_cons, List.mem_cons, List.mem_singleton] at ha
      rcases ha with h | h | h
      · rw [h]; exact hcov v1
      · rw [h]; exact hcov v2
      · rw [h]; exact hcov v3
    have hnd3 : ([v1, v2, v3] : List (V n)).Nodup := by
      rw [List.nodup_cons, List.nodup_cons]
      refine ⟨?_, ?_, List.nodup_singleton v3⟩
      · intro h
        rw [List.mem_cons, List.mem_singleton] at h
        rcases h with h | h
        · exact h12 h
        · exact h13 h
      · intro h
        rw [List.mem_singleton] at h
        exact h23 h
    have := (hnd3.subperm hsub).length_le
    simpa using this
  exact cycleOfChain l hne hnd hlen hcov hchain (hclose hne)
/-! ## 12. 开巡游延拓器（T3a）：M 机 m → m+4 奇开 -/

/-! ### 12.1 嵌入层：V m → V (m+4)（列不变） -/

/-- 顶点嵌入：K_m → K_(m+4)（列 val 不变；与 `embedV` 同机制，+4 版本）。 -/
def embV4 {m : ℕ} (x : V m) : V (m + 4) :=
  ⟨(x.1.1, x.1.2.castLE (Nat.le_add_right m 4)), by
    obtain ⟨⟨r, c⟩, h1, h2⟩ := x
    refine ⟨?_, ?_⟩
    · rintro ⟨hr, hc⟩; exact h1 ⟨hr, by simpa using hc⟩
    · rintro ⟨hr, hc⟩
      apply h2; refine ⟨hr, ?_⟩
      have := c.isLt
      simp only [Fin.val_castLE] at hc
      omega⟩

theorem embV4_val1 {m : ℕ} (x : V m) : (embV4 x).1.1.val = x.1.1.val := rfl

theorem embV4_val2 {m : ℕ} (x : V m) : (embV4 x).1.2.val = x.1.2.val := by
  simp only [embV4, Fin.val_castLE]

theorem embV4_adj {m : ℕ} {x y : V m} (h : (knightGraph m).Adj x y) :
    (knightGraph (m + 4)).Adj (embV4 x) (embV4 y) := by
  rw [knightGraph_adj_iff] at h ⊢
  simp only [leap8, leap, embV4, Fin.val_castLE]
  convert h using 3

theorem embV4_injective {m : ℕ} : Function.Injective (embV4 (m := m)) := by
  intro x y hxy
  have hrow : x.1.1 = y.1.1 := congrArg (fun z : V (m + 4) => z.1.1) hxy
  have hcolv : x.1.2.val = y.1.2.val :=
    congrArg (fun z : V (m + 4) => z.1.2.val) hxy
  exact Subtype.ext (Prod.ext hrow (Fin.ext hcolv))

/-! ### 12.2 尾窗相对数据（T_old 去末格，11 格，Fin 3 × Fin 4） -/

/-- 尾窗相对路径（绝对列 = m + c_rel；Phase 0 T_old 去掉末格 (2,3)——
    该格即新板洞位 (2, m+3)，属 M(m+4) 的末格、在 K_(m+4) 开巡游中删除）。 -/
def QRel : List (Fin 3 × Fin 4) :=
  [(0, 0), (1, 2), (2, 0), (0, 1), (1, 3), (2, 1), (0, 2), (1, 0), (2, 2), (0, 3), (1, 1)]

/-- 尾窗格绝对化（绝对列 = m + c_rel，无截断减法）。 -/
def qcellAbs (m : ℕ) (p : Fin 3 × Fin 4) : Cell (m + 4) := (p.1, ⟨p.2.val + m, by omega⟩)

theorem qcellAbs_val1 (m : ℕ) (p : Fin 3 × Fin 4) : (qcellAbs m p).1.val = p.1.val := rfl

theorem qcellAbs_val2 (m : ℕ) (p : Fin 3 × Fin 4) : (qcellAbs m p).2.val = p.2.val + m := rfl

/-- QRel 逐对相邻（相对层 = Cell 4 上的 leap8，decide）。 -/
theorem QRel_leap : QRel.IsChain (fun a b => leap8 (n := 4) a b) := by decide

/-- QRel 无重复（相对层）。 -/
theorem QRel_nodup : QRel.Nodup := by decide

/-- QRel 不含 (2,3)（新洞位）。 -/
theorem QRel_not_23 : ∀ p ∈ QRel, p ≠ (2, 3) := by decide

/-- QRel 覆盖全部 3×4 格除 (2,3)。 -/
theorem QRel_univ : ∀ p : Fin 3 × Fin 4, p ≠ (2, 3) → p ∈ QRel := by decide

/-- 平移保持单向骑士关系（行同、列同加 m，逐枝单等式 omega）。 -/
theorem leap_shift4 {m : ℕ} {a b : Fin 3 × Fin 4}
    (h : leap (n := 4) a b) : leap (qcellAbs m a) (qcellAbs m b) := by
  rcases h with (⟨hr, hc⟩|⟨hr, hc⟩|⟨hr, hc⟩|⟨hr, hc⟩)
  · exact Or.inl ⟨hr, by rw [qcellAbs_val2, qcellAbs_val2]; omega⟩
  · exact Or.inr (Or.inl ⟨hr, by rw [qcellAbs_val2, qcellAbs_val2]; omega⟩)
  · exact Or.inr (Or.inr (Or.inl ⟨hr, by rw [qcellAbs_val2, qcellAbs_val2]; omega⟩))
  · exact Or.inr (Or.inr (Or.inr ⟨hr, by rw [qcellAbs_val2, qcellAbs_val2]; omega⟩))

/-- 平移保持骑士邻接（行同、列同加 m）。 -/
theorem qcellAbs_leap4 {m : ℕ} {a b : Fin 3 × Fin 4}
    (h : leap8 (n := 4) a b) : leap8 (qcellAbs m a) (qcellAbs m b) := by
  rcases h with h' | h'
  · exact Or.inl (leap_shift4 h')
  · exact Or.inr (leap_shift4 h')

/-- 尾窗格的 V 层装箱。 -/
def QAbsVmk {m : ℕ} (p : Fin 3 × Fin 4) (h : IsCell (m + 4) (qcellAbs m p)) : V (m + 4) :=
  ⟨qcellAbs m p, h⟩

/-- 尾窗顶点列（V 层；洞位排除需 9 ≤ m：(0,0) 因列 ≥ m > 0，(2,m+3) 因 (2,3) ∉ QRel）。 -/
def QAbsV {m : ℕ} (hm : 9 ≤ m) : List (V (m + 4)) :=
  List.pmap (QAbsVmk (m := m)) QRel
    (fun p hp => by
      refine ⟨?_, ?_⟩
      · rintro ⟨hr, hc⟩
        have hc' : p.2.val + m = 0 := hc
        omega
      · rintro ⟨hr, hc⟩
        have hc' : p.2.val + m + 1 = m + 4 := hc
        have hr' : p.1.val = 2 := hr
        have hc3v : p.2.val = 3 := by omega
        exact QRel_not_23 p hp (Prod.ext (Fin.ext hr') (Fin.ext hc3v)))

theorem QAbsV_length {m : ℕ} (hm : 9 ≤ m) : (QAbsV hm).length = 11 := by rfl

theorem QAbsV_ne {m : ℕ} (hm : 9 ≤ m) : QAbsV hm ≠ [] := by
  rw [← List.length_pos_iff_ne_nil, QAbsV_length]
  decide

theorem QAbsV_mem_iff {m : ℕ} (hm : 9 ≤ m) (x : V (m + 4)) :
    x ∈ QAbsV hm ↔ ∃ p ∈ QRel, x.1 = qcellAbs m p := by
  simp only [QAbsV]
  rw [List.mem_pmap]
  constructor
  · rintro ⟨p, hp, hf⟩
    exact ⟨p, hp, (congrArg (fun z : V (m + 4) => z.1) hf).symm⟩
  · rintro ⟨p, hp, hxe⟩
    exact ⟨p, hp, Subtype.ext hxe.symm⟩

theorem QAbsV_nodup {m : ℕ} (hm : 9 ≤ m) : (QAbsV hm).Nodup := by
  unfold QAbsV
  refine List.Nodup.pmap ?_ QRel_nodup
  intro a ha b hb hab
  have hrow : a.1 = b.1 := congrArg (fun z : V (m + 4) => z.1.1) hab
  have hcolv : a.2.val = b.2.val := by
    have hv : (a.2.val + m) = (b.2.val + m) :=
      congrArg (fun z : V (m + 4) => z.1.2.val) hab
    have ha9 := a.2.isLt
    have hb9 := b.2.isLt
    omega
  exact Prod.ext hrow (Fin.ext hcolv)

theorem QAbsV_chain {m : ℕ} (hm : 9 ≤ m) :
    (QAbsV hm).IsChain (knightGraph (m + 4)).Adj := by
  have h1m : 1 ≤ m := by omega
  unfold QAbsV
  refine List.isChain_pmap_of_isChain ?_ QRel_leap _
  intro a b ha hb hab
  exact knightGraph_adj_iff.mpr (qcellAbs_leap4 hab)

/-- 尾窗末格 = (1, m+1)（行）。 -/
theorem QAbsV_last_row {m : ℕ} (hm : 9 ≤ m) (hne : QAbsV hm ≠ []) :
    ((QAbsV hm).getLast hne).1.1.val = 1 := rfl

/-- 尾窗末格 = (1, m+1)（列）。 -/
theorem QAbsV_last_col {m : ℕ} (hm : 9 ≤ m) (hne : QAbsV hm ≠ []) :
    ((QAbsV hm).getLast hne).1.2.val = m + 1 := by
  show (1:ℕ) + m = m + 1
  omega

/-! ### 12.3 开侧好列表与 M 机基座（n = 9, 11） -/

/-- 开侧好列表：非空 + 无重复 + 全覆盖 + 链 + 末格 = (1, n−3)
    （末格位是 M 机接合点：从 (1, n−3) 跳到新窗接合格 (2, n−1) 成 (1,2) 骑士步）。 -/
def GoodOpenList {n : ℕ} (l : List (V n)) : Prop :=
  l ≠ [] ∧ l.Nodup ∧ (∀ v : V n, v ∈ l) ∧ l.IsChain (knightGraph n).Adj ∧
    (∀ hne : l ≠ [], (l.getLast hne).1.1.val = 1 ∧ (l.getLast hne).1.2.val + 3 = n)

/-- n=9 开巡游基座走法表（V 层；M 机基座去末格，Phase 0 数据）。 -/
def openBase9V : List (V 9) :=
  [w9 1 0, w9 2 2, w9 1 4, w9 0 2, w9 2 1, w9 1 3, w9 0 1, w9 2 0, w9 1 2, w9 0 4, w9 2 3,
   w9 1 1, w9 0 3, w9 2 4, w9 0 5, w9 1 7, w9 2 5, w9 0 6, w9 1 8, w9 2 6, w9 0 7, w9 1 5,
   w9 2 7, w9 0 8, w9 1 6]

theorem openBase9V_good : GoodOpenList openBase9V := by
  refine ⟨by decide, by decide, by decide, by decide, ?_⟩
  intro hne
  exact ⟨rfl, rfl⟩

/-- n=11 开巡游基座走法表（V 层；M 机基座去末格，Phase 0 数据）。 -/
def openBase11V : List (V 11) :=
  [w11 1 0, w11 0 2, w11 2 1, w11 1 3, w11 2 5, w11 0 6, w11 1 4, w11 2 6, w11 0 5, w11 2 4,
   w11 1 6, w11 0 4, w11 1 2, w11 2 0, w11 0 1, w11 2 2, w11 0 3, w11 1 1, w11 2 3, w11 1 5,
   w11 0 7, w11 1 9, w11 2 7, w11 0 8, w11 1 10, w11 2 8, w11 0 9, w11 1 7, w11 2 9, w11 0 10,
   w11 1 8]

theorem openBase11V_good : GoodOpenList openBase11V := by
  refine ⟨by decide, by decide, by decide, by decide, ?_⟩
  intro hne
  exact ⟨rfl, rfl⟩

/-! ### 12.4 步进本体：好开列表 m → 好开列表 m+4 -/

/-- 接合格 (2, m−1)（V (m+4) 层）：旧板洞位在新板复活，M 机 append 的首格。 -/
def jcell4 {m : ℕ} (hm : 9 ≤ m) : V (m + 4) :=
  ⟨(⟨2, by omega⟩, ⟨m - 1, by omega⟩), by
    refine ⟨?_, ?_⟩
    · rintro ⟨hr, hc⟩
      simp only [Fin.val_mk] at hr
      omega
    · rintro ⟨hr, hc⟩
      simp only [Fin.val_mk] at hc
      omega⟩

theorem jcell4_row {m : ℕ} (hm : 9 ≤ m) : (jcell4 hm).1.1.val = 2 := rfl

theorem jcell4_col {m : ℕ} (hm : 9 ≤ m) : (jcell4 hm).1.2.val = m - 1 := rfl

/-- 步进：好开列表在 m → 好开列表在 m+4
    （M 机：l ↦ (l.map embV4 ++ [jcell4]) ++ QAbsV；
     即 M(m+4) = M(m) ++ T_old@m，K_(m+4) 巡游再去掉末格 (2, m+3)）。 -/
theorem step_open_list {m : ℕ} (hm : 9 ≤ m) {l : List (V m)} (hg : GoodOpenList l) :
    ∃ l' : List (V (m + 4)), GoodOpenList l' := by
  obtain ⟨hne, hnd, hcov, hchain, hend⟩ := hg
  have hWne : QAbsV hm ≠ [] := QAbsV_ne hm
  have hWlen : (QAbsV hm).length = 11 := QAbsV_length hm
  have hLne : l.map embV4 ≠ [] := by
    rw [← List.length_pos_iff_ne_nil, List.length_map, List.length_pos_iff_ne_nil]
    exact hne
  refine ⟨l.map embV4 ++ [jcell4 hm] ++ QAbsV hm, ?_, ?_, ?_, ?_, ?_⟩
  · -- 1. 非空（尾窗非空即整体非空）
    exact List.append_ne_nil_of_right_ne_nil _ hWne
  · -- 2. 无重复（旧格段 / 接合格 / 尾窗三段两两不交）
    rw [List.nodup_append]
    refine ⟨?_, QAbsV_nodup hm, ?_⟩
    · -- 接合段 = 旧格嵌入 ++ [接合格]
      rw [List.nodup_append]
      refine ⟨hnd.map embV4_injective, List.nodup_singleton _, ?_⟩
      · -- 接合格 ≠ 任意旧嵌入格（列 = m−1 时行 ≠ 2：(2,m−1) 是 V m 洞位）
        rintro a ha b hb hab
        rw [List.mem_singleton] at hb
        subst hb
        rw [List.mem_map] at ha
        obtain ⟨x, hx, ha'⟩ := ha
        have heq : embV4 x = jcell4 hm := ha'.trans hab
        have hrow : x.1.1.val = 2 := by
          have h := congrArg (fun z : V (m + 4) => z.1.1.val) heq
          rw [embV4_val1] at h
          exact h
        have hcolx : x.1.2.val = m - 1 := by
          have h := congrArg (fun z : V (m + 4) => z.1.2.val) heq
          rw [embV4_val2] at h
          exact h
        exact x.2.2 ⟨hrow, by omega⟩
    · -- 接合段 ∩ 尾窗 = ∅（接合段列 ≤ m−1，尾窗列 ≥ m）
      rintro a ha b hb hab
      rw [List.mem_append] at ha
      obtain ⟨p, hp, hpe⟩ := (QAbsV_mem_iff hm b).mp hb
      have hbc : b.1.2.val = p.2.val + m := congrArg (fun z : Cell (m + 4) => z.2.val) hpe
      rcases ha with ha | ha
      · obtain ⟨x, hx, ha'⟩ := List.mem_map.mp ha
        have hxb : x.1.2.val = b.1.2.val := by
          have h2 := congrArg (fun z : V (m + 4) => z.1.2.val) (ha'.trans hab)
          rw [embV4_val2] at h2
          exact h2
        have hxcol : x.1.2.val < m := x.1.2.isLt
        omega
      · rw [List.mem_singleton] at ha
        subst ha
        have hj : (jcell4 hm).1.2.val = b.1.2.val :=
          congrArg (fun z : V (m + 4) => z.1.2.val) hab
        rw [jcell4_col hm] at hj
        omega
  · -- 3. 覆盖
    intro v
    have hrlt : v.1.1.val < 3 := v.1.1.isLt
    have hclt : v.1.2.val < m + 4 := v.1.2.isLt
    have preim : ∀ w : V (m + 4), w.1.2.val < m →
        (w.1.2.val + 1 < m ∨ w.1.1.val ≠ 2) → ∃ x : V m, embV4 x = w := by
      intro w hcl hr2
      have hcell : IsCell m (⟨w.1.1.val, w.1.1.isLt⟩, ⟨w.1.2.val, hcl⟩) := by
        refine ⟨?_, ?_⟩
        · rintro ⟨hr, hc⟩; exact w.2.1 ⟨hr, hc⟩
        · rintro ⟨hr, hc⟩
          have hc' : w.1.2.val + 1 = m := hc
          rcases hr2 with hlt | hne2
          · omega
          · exact hne2 hr
      refine ⟨⟨(⟨w.1.1.val, w.1.1.isLt⟩, ⟨w.1.2.val, hcl⟩), hcell⟩, ?_⟩
      apply Subtype.ext; apply Prod.ext
      · apply Fin.ext; rfl
      · apply Fin.ext; rfl
    rcases Nat.lt_or_ge (v.1.2.val) (m - 1) with hc1 | hc1
    · -- 左案：col < m−1 → 旧格
      obtain ⟨x, hx⟩ := preim v (by omega) (Or.inl (by omega))
      rw [← hx]
      exact List.mem_append.mpr
        (Or.inl (List.mem_append.mpr (Or.inl (List.mem_map.mpr ⟨x, hcov x, rfl⟩))))
    · rcases Nat.lt_or_ge (v.1.2.val) m with hc2 | hc2
      · -- 中案：col = m−1
        by_cases hr2 : v.1.1.val = 2
        · -- v = (2, m−1) = 接合格
          have hvm : v.1.2.val = m - 1 := by omega
          refine List.mem_append.mpr
            (Or.inl (List.mem_append.mpr (Or.inr (List.mem_singleton.mpr ?_))))
          apply Subtype.ext
          exact Prod.ext (Fin.ext hr2) (Fin.ext hvm)
        · -- 旧格（行 ≠ 2）
          obtain ⟨x, hx⟩ := preim v (by omega) (Or.inr hr2)
          rw [← hx]
          exact List.mem_append.mpr
            (Or.inl (List.mem_append.mpr (Or.inl (List.mem_map.mpr ⟨x, hcov x, rfl⟩))))
      · -- 右案：col ≥ m → 尾窗格（(2,3) 被新洞排掉）
        have hb4 : v.1.2.val - m < 4 := by omega
        refine List.mem_append.mpr
          (Or.inr ((QAbsV_mem_iff hm v).mpr
            ⟨(⟨v.1.1.val, hrlt⟩, ⟨v.1.2.val - m, hb4⟩), ?_, ?_⟩))
        · exact QRel_univ _ (by
            rintro heq
            have hs1 := congrArg Prod.fst heq.symm
            have hs2 := congrArg Prod.snd heq.symm
            have hv2 : v.1.2.val - m = 3 := (congrArg (fun q : Fin 4 => q.val) hs2).symm
            have hv1 : v.1.1.val = 2 := (congrArg (fun q : Fin 3 => q.val) hs1).symm
            exact v.2.2 ⟨hv1, by omega⟩)
        · have h1 : v.1.1.val =
              (qcellAbs m (⟨v.1.1.val, hrlt⟩, ⟨v.1.2.val - m, hb4⟩)).1.val := rfl
          have h2 : v.1.2.val =
              (qcellAbs m (⟨v.1.1.val, hrlt⟩, ⟨v.1.2.val - m, hb4⟩)).2.val := by
            show v.1.2.val = (v.1.2.val - m) + m
            omega
          exact Prod.ext (Fin.ext h1) (Fin.ext h2)
  · -- 4. 链（三段：旧格段 → 接合格 → 尾窗；两个接合点均为 (1,2) 骑士步）
    have hLc : (l.map embV4).IsChain (knightGraph (m + 4)).Adj :=
      List.isChain_map_of_isChain embV4 (fun a b hab => embV4_adj hab) hchain
    have hWc := QAbsV_chain hm
    have hLlen : (l.map embV4).length = l.length := List.length_map embV4
    have hlast : (l.map embV4).getLast? = some (embV4 (l.getLast hne)) := by
      rw [List.getLast?_eq_getLast_of_ne_nil hLne, List.getLast_eq_getElem hLne,
        Option.some_inj, List.getElem_map]
      simp only [hLlen]
      rw [List.getLast_eq_getElem hne]
    have hWhead : (QAbsV hm).head? =
        some ((QAbsV hm)[0]'(by rw [hWlen]; decide)) := rfl
    refine (hLc.append (List.isChain_singleton (jcell4 hm)) ?_).append hWc ?_
    · -- J1：旧格末格 (1, m−3) → 接合格 (2, m−1)
      rintro x hx y hy
      rw [hlast, Option.mem_def, Option.some_inj] at hx
      subst hx
      have hys : ([jcell4 hm] : List (V (m + 4))).head? = some (jcell4 hm) := rfl
      rw [hys, Option.mem_def, Option.some_inj] at hy
      subst hy
      obtain ⟨hr, hc⟩ := hend hne
      refine knightGraph_adj_iff.mpr (Or.inl (Or.inl ⟨?_, ?_⟩))
      · rw [embV4_val1, hr, jcell4_row]
      · rw [embV4_val2]
        have hc' : (l.getLast hne).1.2.val + 2 = m - 1 := by omega
        rw [hc', jcell4_col]
    · -- J2：接合格 (2, m−1) → 尾窗首格 (0, m)
      rintro x hx y hy
      have hLJne : l.map embV4 ++ [jcell4 hm] ≠ [] :=
        List.append_ne_nil_of_right_ne_nil _ (List.cons_ne_nil (jcell4 hm) [])
      have hLJlast : (l.map embV4 ++ [jcell4 hm]).getLast? = some (jcell4 hm) := by
        rw [List.getLast?_eq_getLast_of_ne_nil hLJne,
          List.getLast_append_of_right_ne_nil _ _ (List.cons_ne_nil (jcell4 hm) []),
          List.getLast_singleton' (jcell4 hm)]
      rw [hLJlast, Option.mem_def, Option.some_inj] at hx
      subst hx
      rw [hWhead, Option.mem_def, Option.some_inj] at hy
      subst hy
      have h0r : ((QAbsV hm)[0]'(by rw [hWlen]; decide)).1.1.val = 0 := rfl
      have h0c : ((QAbsV hm)[0]'(by rw [hWlen]; decide)).1.2.val = m := by
        show (0:ℕ) + m = m
        omega
      refine knightGraph_adj_iff.mpr (Or.inl (Or.inr (Or.inr (Or.inr ⟨?_, ?_⟩))))
      · rw [h0r, jcell4_row]
      · rw [h0c, jcell4_col]
        omega
  · -- 5. 末格不变量：新末格 = 尾窗末格 (1, m+1) = (1, (m+4)−3)
    intro hne'
    have hpr : ((l.map embV4 ++ [jcell4 hm]) ++ QAbsV hm).getLast hne' =
        ((l.map embV4 ++ [jcell4 hm]) ++ QAbsV hm).getLast
          (List.append_ne_nil_of_right_ne_nil _ hWne) := rfl
    rw [hpr, List.getLast_append_of_right_ne_nil _ _ hWne]
    refine ⟨QAbsV_last_row hm hWne, ?_⟩
    rw [QAbsV_last_col hm hWne]
/-! ### 12.5 奇归纳组装（T3a 收官） -/

/-- 开侧好列表存在性：奇数 n ≥ 9 ⇒ 存在 GoodOpenList
    （强归纳：小 n 两基座 9/11，步进 m ↦ m+4）。 -/
theorem open_good_list : ∀ n : ℕ, 9 ≤ n → Odd n → ∃ l : List (V n), GoodOpenList l := by
  intro n
  apply Nat.strong_induction_on
    (p := fun n => 9 ≤ n → Odd n → ∃ l : List (V n), GoodOpenList l)
  intro n ih hn hodd
  rcases Nat.lt_or_ge n 13 with h13 | h13
  · -- 小 n：奇数且 9 ≤ n < 13 ⇒ n ∈ {9, 11}
    have hn' : n = 9 ∨ n = 11 := by
      rcases hodd with ⟨m, hm⟩
      omega
    rcases hn' with h | h
    · subst h; exact ⟨openBase9V, openBase9V_good⟩
    · subst h; exact ⟨openBase11V, openBase11V_good⟩
  · -- n ≥ 13：从 n − 4 步进
    have hn4 : n - 4 < n := by omega
    have hn4' : 9 ≤ n - 4 := by omega
    have hodd4 : Odd (n - 4) := by
      rcases hodd with ⟨m, hm⟩
      exact ⟨m - 2, by omega⟩
    obtain ⟨l, hg⟩ := ih (n - 4) hn4 hn4' hodd4
    obtain ⟨l', hg'⟩ := step_open_list hn4' hg
    rw [← show n - 4 + 4 = n from by omega]
    exact ⟨l', hg'⟩

/-- 开巡游存在性（正向·奇）：奇数 n ≥ 9 ⇒ K_n 存在哈密顿路径
    （GoodOpenList 经 pathOfChain 装载为 IsHamiltonian）。 -/
theorem open_tour_exists_odd : ∀ n : ℕ, 9 ≤ n → Odd n →
    ∃ a b : V n, ∃ w : (knightGraph n).Walk a b, w.IsHamiltonian := by
  intro n hn hodd
  obtain ⟨l, hg⟩ := open_good_list n hn hodd
  obtain ⟨hne, hnd, hcov, hchain, hend⟩ := hg
  exact pathOfChain l hne hnd hcov hchain

/-! ## 附：公理审计（kernel 终裁） -/
#print axioms open_tour_exists_odd
#print axioms open_good_list
#print axioms step_open_list
#print axioms closed_cycle_exists
#print axioms openBase9V_good
#print axioms openBase11V_good
/-! ## 13. 零值侧与检查器（T3b + T4） -/

/-! ### 13.1 基数与奇偶（闭侧奇 n 排除） -/

/-- 洞位格（n 板左上）：构造时需 0 < n。 -/
def hole00 {n : ℕ} (hn : 1 ≤ n) : Cell n := ((0 : Fin 3), ⟨0, by omega⟩)

/-- 洞位格（n 板右下）：构造时需 n ≥ 1。 -/
def holeLast {n : ℕ} (hn : 1 ≤ n) : Cell n := ((2 : Fin 3), ⟨n - 1, by omega⟩)

/-- `IsCell` 恰为「非两个洞位」。 -/
theorem isCell_iff {n : ℕ} (hn : 1 ≤ n) (p : Cell n) :
    IsCell n p ↔ (p ≠ hole00 hn ∧ p ≠ holeLast hn) := by
  constructor
  · rintro ⟨h1, h2⟩
    refine ⟨fun h => ?_, fun h => ?_⟩
    · subst h; exact h1 ⟨rfl, rfl⟩
    · subst h
      exact h2 ⟨rfl, by show (n:ℕ) - 1 + 1 = n; omega⟩
  · rintro ⟨h1, h2⟩
    refine ⟨fun hc => h1 ?_, fun hc => h2 ?_⟩
    · exact Prod.ext (Fin.ext hc.1) (Fin.ext hc.2)
    · have h2v : p.2.val = n - 1 := by omega
      exact Prod.ext (Fin.ext hc.1) (Fin.ext h2v)

/-- K_n 顶点数 = 3n − 2（n ≥ 1）。 -/
theorem card_V {n : ℕ} (hn : 1 ≤ n) : Fintype.card (V n) = 3 * n - 2 := by
  have hcard : Fintype.card (V n)
      = (Finset.univ \ ({hole00 hn, holeLast hn} : Finset (Cell n))).card :=
    Fintype.card_of_subtype _ (fun p => by
      simp only [Finset.mem_sdiff, Finset.mem_univ, true_and, Finset.mem_insert,
        Finset.mem_singleton]
      rw [isCell_iff hn p]
      tauto)
  have h2 : ({hole00 hn, holeLast hn} : Finset (Cell n)).card = 2 := by
    have hne : hole00 hn ∉ ({holeLast hn} : Finset (Cell n)) := by
      rw [Finset.mem_singleton]
      intro heq
      have hd : (hole00 hn).1.val = (holeLast hn).1.val :=
        congrArg (fun z : Cell n => z.1.val) heq
      have h1 : (hole00 hn).1.val = 0 := rfl
      have h2 : (holeLast hn).1.val = 2 := rfl
      rw [h1, h2] at hd
      omega
    rw [Finset.card_insert_of_notMem hne, Finset.card_singleton]
  rw [hcard, Finset.card_sdiff, Finset.inter_univ, h2, Finset.card_univ, Fintype.card_prod,
    Fintype.card_fin, Fintype.card_fin]

/-- 顶点色（行列和奇偶）。 -/
def vcol {n : ℕ} (v : V n) : ℕ := (v.1.1.val + v.1.2.val) % 2

theorem vcol_lt {n : ℕ} (v : V n) : vcol v < 2 := Nat.mod_lt _ (by norm_num)

/-- 邻格必异色（骑士步改变行列和奇偶）。 -/
theorem adj_vcol_ne {x y : V n} (h : (knightGraph n).Adj x y) : vcol x ≠ vcol y := by
  rw [knightGraph_adj_iff] at h
  obtain h | h := h
  · rcases h with ⟨hr, hc⟩ | ⟨hr, hc⟩ | ⟨hr, hc⟩ | ⟨hr, hc⟩ <;>
      simp only [vcol] <;> omega
  · rcases h with ⟨hr, hc⟩ | ⟨hr, hc⟩ | ⟨hr, hc⟩ | ⟨hr, hc⟩ <;>
      simp only [vcol] <;> omega

/-- 走法奇偶：两端同色 ⟺ 边数为偶。 -/
theorem walk_col_parity {n : ℕ} {x y : V n} (w : (knightGraph n).Walk x y) :
    (vcol x = vcol y) ↔ (w.length % 2 = 0) := by
  induction w with
  | nil => exact ⟨fun _ => by simp, fun _ => rfl⟩
  | @cons u v w h w' ih =>
      rw [Walk.length_cons h w']
      have hadj : vcol u ≠ vcol v := adj_vcol_ne h
      constructor
      · intro hcol
        by_contra hmod
        have hk0 : w'.length % 2 = 0 := by omega
        have hbc : vcol v = vcol w := ih.mpr hk0
        exact hadj (hcol.trans hbc.symm)
      · intro hmod
        have hk1 : w'.length % 2 = 1 := by omega
        have hbc : vcol v ≠ vcol w := by
          intro heq
          have := ih.mp heq
          omega
        have hu2 := vcol_lt u
        have hv2 := vcol_lt v
        have hw2 := vcol_lt w
        omega

/-- 走法支撑表长度 = 边数 + 1。 -/
theorem walk_support_length {n : ℕ} {x y : V n} : ∀ (w : (knightGraph n).Walk x y),
    w.support.length = w.length + 1 := by
  intro w
  induction w with
  | nil => rfl
  | cons h w' ih =>
      rw [Walk.support_cons, Walk.length_cons, List.length_cons, ih]

/-- 奇数 n 无哈密顿圈（二部奇偶：圈边数 = 顶点数必须为偶）。 -/
theorem no_cycle_odd {n : ℕ} (hodd : Odd n) :
    ¬ ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle := by
  rintro ⟨a, w, hw⟩
  obtain ⟨k, hk⟩ := hodd
  have hpar : w.length % 2 = 0 := (walk_col_parity w).mp rfl
  rw [Walk.IsHamiltonianCycle.length_eq hw, card_V (by omega)] at hpar
  omega

/-! ### 13.2 孤立点排除（n = 2, 3） -/

/-- 走法支撑表中的格子：要么整条支撑表只有首格（走法长度 0），
    要么该格有邻格也在支撑表中。归纳证明，不依赖 `cases` 对端点的处理。 -/
theorem walk_support_adj {n : ℕ} : ∀ (a b : V n) (w : (knightGraph n).Walk a b) (v : V n),
    v ∈ w.support → w.support = [a] ∨ ∃ c ∈ w.support, (knightGraph n).Adj v c := by
  intro a b w
  induction w with
  | nil =>
      intro v hv
      exact Or.inl (by rw [Walk.support_nil])
  | @cons u1 v1 b1 h p ih =>
      intro v hv
      simp only [Walk.support_cons] at hv ⊢
      rcases List.mem_cons.mp hv with heq | hv'
      · subst heq
        exact Or.inr ⟨v1, List.mem_cons.mpr (Or.inr (Walk.start_mem_support p)), h⟩
      · rcases ih v hv' with hsup | ⟨c, hc, hadj⟩
        · rw [hsup, List.mem_singleton] at hv'
          subst hv'
          exact Or.inr ⟨u1, List.mem_cons.mpr (Or.inl rfl), h.symm⟩
        · exact Or.inr ⟨c, List.mem_cons.mpr (Or.inr hc), hadj⟩

/-- 含孤立点且顶点数 ≥ 2 的图无哈密顿路径。 -/
theorem no_ham_path_isolated {n : ℕ} {v0 : V n}
    (hiso : ∀ c : V n, ¬ (knightGraph n).Adj v0 c) (h2 : ∃ u : V n, u ≠ v0) :
    ¬ ∃ a b : V n, ∃ w : (knightGraph n).Walk a b, w.IsHamiltonian := by
  rintro ⟨a, b, w, hw⟩
  obtain ⟨u, hu⟩ := h2
  have hv0 : v0 ∈ w.support := List.count_pos_iff.mp (by have := hw v0; omega)
  have hmem : u ∈ w.support := List.count_pos_iff.mp (by have := hw u; omega)
  rcases walk_support_adj a b w v0 hv0 with hsup | ⟨c, hc, hadj⟩
  · rw [hsup, List.mem_singleton] at hv0 hmem
    exact hu (by rw [hmem, hv0])
  · exact hiso c hadj

/-- 含孤立点的图无哈密顿圈。 -/
theorem no_cycle_isolated {n : ℕ} {v0 : V n}
    (hiso : ∀ c : V n, ¬ (knightGraph n).Adj v0 c) :
    ¬ ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle := by
  rintro ⟨a, w, hw⟩
  have ht : ∀ x : V n, w.support.tail.count x = 1 :=
    (Walk.isHamiltonianCycle_iff_isCycle_and_support_count_tail_eq_one.mp hw).2
  have hv0t : v0 ∈ w.support.tail := List.count_pos_iff.mp (by have := ht v0; omega)
  have hv0 : v0 ∈ w.support := List.mem_of_mem_tail hv0t
  rcases walk_support_adj a a w v0 hv0 with hsup | ⟨c, hc, hadj⟩
  · rw [hsup] at hv0t
    exact absurd hv0t List.not_mem_nil
  · exact hiso c hadj

/-! ### 13.3 小 n 实例（n = 1, 2, 3） -/

/-- (1,1) 与任意 (r, c)（r < 3，c ≤ 2）不成 8 向骑士关系：n = 2, 3 的孤立点核心。 -/
theorem leap8_11_false {n : ℕ} (a b : Cell n)
    (ha : (a.1 : ℕ) = 1 ∧ (a.2 : ℕ) = 1) (hb : (b.1 : ℕ) < 3 ∧ (b.2 : ℕ) ≤ 2) :
    ¬ leap8 a b := by
  simp only [leap8, leap]
  omega

def v1c : V 1 := ⟨(⟨1, by decide⟩, ⟨0, by decide⟩), by decide⟩

/-- n = 1：单顶点，空走法即哈密顿路径。 -/
theorem open_tour_1 : ∃ a b : V 1, ∃ w : (knightGraph 1).Walk a b, w.IsHamiltonian := by
  have huniq : ∀ x : V 1, x = v1c := by
    intro x
    obtain ⟨rc, hrc⟩ := x
    obtain ⟨r, c⟩ := rc
    have hc0 : (c : ℕ) = 0 := by have := c.isLt; omega
    have hr0 : (r : ℕ) ≠ 0 := fun h => hrc.1 ⟨h, hc0⟩
    have hr2 : (r : ℕ) ≠ 2 := fun h => hrc.2 ⟨h, by omega⟩
    have hr1 : (r : ℕ) = 1 := by have := r.isLt; omega
    exact Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hc0))
  refine ⟨v1c, v1c, Walk.nil, ?_⟩
  intro x
  rw [huniq x]
  simp

def v2c : V 2 := ⟨(⟨1, by decide⟩, ⟨1, by decide⟩), by decide⟩

def v2a : V 2 := ⟨(⟨0, by decide⟩, ⟨1, by decide⟩), by decide⟩

/-- n = 2：(1,1) 孤立 → 无哈密顿路径、无哈密顿圈。 -/
theorem no_open_tour_2 : ¬ ∃ a b : V 2, ∃ w : (knightGraph 2).Walk a b, w.IsHamiltonian := by
  refine no_ham_path_isolated (v0 := v2c) ?_ ⟨v2a, by decide⟩
  intro c
  rw [knightGraph_adj_iff]
  exact leap8_11_false v2c.1 c.1 ⟨rfl, rfl⟩ ⟨c.1.1.isLt, by have := c.1.2.isLt; omega⟩

theorem no_closed_tour_2 : ¬ ∃ a : V 2, ∃ w : (knightGraph 2).Walk a a, w.IsHamiltonianCycle := by
  refine no_cycle_isolated (v0 := v2c) ?_
  intro c
  rw [knightGraph_adj_iff]
  exact leap8_11_false v2c.1 c.1 ⟨rfl, rfl⟩ ⟨c.1.1.isLt, by have := c.1.2.isLt; omega⟩

def v3c : V 3 := ⟨(⟨1, by decide⟩, ⟨1, by decide⟩), by decide⟩

def v3a : V 3 := ⟨(⟨0, by decide⟩, ⟨1, by decide⟩), by decide⟩

/-- n = 3：(1,1) 孤立 → 无哈密顿路径、无哈密顿圈。 -/
theorem no_open_tour_3 : ¬ ∃ a b : V 3, ∃ w : (knightGraph 3).Walk a b, w.IsHamiltonian := by
  refine no_ham_path_isolated (v0 := v3c) ?_ ⟨v3a, by decide⟩
  intro c
  rw [knightGraph_adj_iff]
  exact leap8_11_false v3c.1 c.1 ⟨rfl, rfl⟩ ⟨c.1.1.isLt, by have := c.1.2.isLt; omega⟩

theorem no_closed_tour_3 : ¬ ∃ a : V 3, ∃ w : (knightGraph 3).Walk a a, w.IsHamiltonianCycle := by
  refine no_cycle_isolated (v0 := v3c) ?_
  intro c
  rw [knightGraph_adj_iff]
  exact leap8_11_false v3c.1 c.1 ⟨rfl, rfl⟩ ⟨c.1.1.isLt, by have := c.1.2.isLt; omega⟩

#print axioms card_V
#print axioms no_cycle_odd
#print axioms no_open_tour_2
#print axioms no_closed_tour_2
#print axioms no_open_tour_3
#print axioms no_closed_tour_3
#print axioms open_tour_1

/-! ## 14. 小情形补全（n = 0 双空侧、n = 4 闭侧度 1、n = 6 闭侧帽强迫；接手会话新增） -/

/-- n = 0：V 0 为空（Fin 0 无元素），开侧 LHS 为假。 -/
theorem no_open_tour_0 : ¬ ∃ a b : V 0, ∃ w : (knightGraph 0).Walk a b, w.IsHamiltonian :=
  fun ⟨a, _, _, _⟩ => (a.1.2).elim0

/-- n = 0：闭侧 LHS 为假。 -/
theorem no_closed_tour_0 : ¬ ∃ a : V 0, ∃ w : (knightGraph 0).Walk a a, w.IsHamiltonianCycle :=
  fun ⟨a, _, _⟩ => (a.1.2).elim0

/-- 三个互异元素都属于同一 nodup 列表 ⟹ 该列表长度 ≥ 3。 -/
theorem three_le_length_of_nodup {α : Type*} [DecidableEq α] {l : List α} (hl : l.Nodup)
    {x y z : α} (hx : x ∈ l) (hy : y ∈ l) (hz : z ∈ l)
    (hxy : x ≠ y) (hxz : x ≠ z) (hyz : y ≠ z) : 3 ≤ l.length := by
  have hsub : ({x, y, z} : Finset α) ⊆ l.toFinset := by
    intro e he
    simp only [Finset.mem_insert, Finset.mem_singleton] at he
    rcases he with rfl | rfl | rfl
    · exact List.mem_toFinset.mpr hx
    · exact List.mem_toFinset.mpr hy
    · exact List.mem_toFinset.mpr hz
  have hcard : ({x, y, z} : Finset α).card = 3 := by
    have h1 : x ∉ ({y, z} : Finset α) := by
      simp only [Finset.mem_insert, Finset.mem_singleton, not_or]
      exact ⟨hxy, hxz⟩
    have h2 : y ∉ ({z} : Finset α) := by
      simp only [Finset.mem_singleton]
      exact hyz
    rw [Finset.card_insert_of_notMem h1, Finset.card_insert_of_notMem h2, Finset.card_singleton]
  have hle := Finset.card_le_card hsub
  rw [hcard, List.toFinset_card_of_nodup hl] at hle
  exact hle

/-- 至多一个邻居的顶点不在任何哈密顿闭圈上（圈边恰 2 条 vs 可用边 ≤ 1 条）。 -/
theorem no_cycle_degree_one {n : ℕ} {v0 u1 : V n}
    (honly : ∀ u : V n, (knightGraph n).Adj v0 u → u = u1) :
    ¬ ∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle := by
  rintro ⟨a, w, hw⟩
  have htwo : incCount w v0 = 2 := incCount_cycle_two hw v0
  have hcyc : w.IsCycle :=
    (SimpleGraph.Walk.isHamiltonianCycle_isCycle_and_isHamiltonian_tail.mp hw).1
  have hnd : w.edges.Nodup := hcyc.edges_nodup
  have hLnd : (w.edges.filter (fun e => v0 ∈ e)).Nodup := hnd.filter _
  have hLlen : (w.edges.filter (fun e => v0 ∈ e)).length = 2 := by
    have h2 := htwo
    unfold incCount at h2
    exact h2
  have hLcard : (w.edges.filter (fun e => v0 ∈ e)).toFinset.card = 2 := by
    rw [List.toFinset_card_of_nodup hLnd, hLlen]
  have hLmem : ∀ e ∈ w.edges.filter (fun e => v0 ∈ e), e = s(v0, u1) := by
    intro e he
    have he1 : e ∈ w.edges := (List.mem_filter.mp he).1
    have he2 : v0 ∈ e := of_decide_eq_true (List.mem_filter.mp he).2
    obtain ⟨y, hy⟩ := Sym2.mem_iff_exists.mp he2
    subst hy
    rw [honly y (Walk.adj_of_mem_edges w he1)]
  have hLsub : (w.edges.filter (fun e => v0 ∈ e)).toFinset ⊆
      ({s(v0, u1)} : Finset (Sym2 (V n))) := by
    intro e he
    rw [hLmem e (List.mem_toFinset.mp he)]
    exact Finset.mem_singleton_self _
  have hle := Finset.card_le_card hLsub
  rw [hLcard, Finset.card_singleton] at hle
  omega

/-- n = 4 度 1 顶点 (1,1)。 -/
def v4d : V 4 := ⟨(⟨1, by decide⟩, ⟨1, by decide⟩), by decide⟩

/-- (1,1) 在 K_4 中的唯一邻居 (0,3)。 -/
def v4u : V 4 := ⟨(⟨0, by decide⟩, ⟨3, by decide⟩), by decide⟩

/-- n = 4 闭侧：(1,1) 唯一邻居为 (0,3)（度 1）⟹ 无哈密顿圈。 -/
theorem no_closed_tour_4 : ¬ ∃ a : V 4, ∃ w : (knightGraph 4).Walk a a, w.IsHamiltonianCycle := by
  refine no_cycle_degree_one (v0 := v4d) (u1 := v4u) ?_
  intro u hu
  rw [knightGraph_adj_iff] at hu
  have hcell := u.2
  have h1 := u.1.1.isLt
  have h2 := u.1.2.isLt
  have hr : ((u.1.1 : ℕ) = 0 ∧ (u.1.2 : ℕ) = 3) ∨ ((u.1.1 : ℕ) = 2 ∧ (u.1.2 : ℕ) = 3) := by
    have ha : leap8 ((⟨1, by decide⟩ : Fin 3), (⟨1, by decide⟩ : Fin 4)) u.1 := hu
    simp only [leap8, leap] at ha
    omega
  rcases hr with ⟨hr1, hr2⟩ | ⟨hr1, hr2⟩
  · exact Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2))
  · exact absurd ⟨hr1, by omega⟩ hcell.2

/-- K_6 帽顶点 (1,0)。 -/
def e10 : V 6 := ⟨(⟨1, by decide⟩, ⟨0, by decide⟩), by decide⟩

/-- K_6 帽顶点 (2,1)。 -/
def e21 : V 6 := ⟨(⟨2, by decide⟩, ⟨1, by decide⟩), by decide⟩

/-- K_6 帽顶点 (1,4)。 -/
def e14 : V 6 := ⟨(⟨1, by decide⟩, ⟨4, by decide⟩), by decide⟩

/-- K_6 枢纽格 (0,2)。 -/
def e02 : V 6 := ⟨(⟨0, by decide⟩, ⟨2, by decide⟩), by decide⟩

/-- K_6 格 (2,2)。 -/
def e22 : V 6 := ⟨(⟨2, by decide⟩, ⟨2, by decide⟩), by decide⟩

/-- K_6 格 (1,3)。 -/
def e13 : V 6 := ⟨(⟨1, by decide⟩, ⟨3, by decide⟩), by decide⟩

/-- (1,0) 在 K_6 中的邻居恰为 {(0,2),(2,2)}。 -/
theorem adj_6_10 (u : V 6) (hu : (knightGraph 6).Adj e10 u) : u = e02 ∨ u = e22 := by
  rw [knightGraph_adj_iff] at hu
  have h1 := u.1.1.isLt
  have h2 := u.1.2.isLt
  have hr : ((u.1.1 : ℕ) = 0 ∧ (u.1.2 : ℕ) = 2) ∨ ((u.1.1 : ℕ) = 2 ∧ (u.1.2 : ℕ) = 2) := by
    have ha : leap8 ((⟨1, by decide⟩ : Fin 3), (⟨0, by decide⟩ : Fin 6)) u.1 := hu
    simp only [leap8, leap] at ha
    omega
  rcases hr with ⟨hr1, hr2⟩ | ⟨hr1, hr2⟩
  · exact Or.inl (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))
  · exact Or.inr (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))

/-- (2,1) 在 K_6 中的邻居恰为 {(0,2),(1,3)}（算术候选 (0,0) 为洞，由 IsCell 排除）。 -/
theorem adj_6_21 (u : V 6) (hu : (knightGraph 6).Adj e21 u) : u = e02 ∨ u = e13 := by
  rw [knightGraph_adj_iff] at hu
  have hcell := u.2
  have h1 := u.1.1.isLt
  have h2 := u.1.2.isLt
  have hr : ((u.1.1 : ℕ) = 0 ∧ (u.1.2 : ℕ) = 0) ∨ ((u.1.1 : ℕ) = 0 ∧ (u.1.2 : ℕ) = 2) ∨
      ((u.1.1 : ℕ) = 1 ∧ (u.1.2 : ℕ) = 3) := by
    have ha : leap8 ((⟨2, by decide⟩ : Fin 3), (⟨1, by decide⟩ : Fin 6)) u.1 := hu
    simp only [leap8, leap] at ha
    omega
  rcases hr with ⟨hr1, hr2⟩ | ⟨hr1, hr2⟩ | ⟨hr1, hr2⟩
  · exact absurd ⟨hr1, hr2⟩ hcell.1
  · exact Or.inl (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))
  · exact Or.inr (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))

/-- (1,4) 在 K_6 中的邻居恰为 {(0,2),(2,2)}。 -/
theorem adj_6_14 (u : V 6) (hu : (knightGraph 6).Adj e14 u) : u = e02 ∨ u = e22 := by
  rw [knightGraph_adj_iff] at hu
  have h1 := u.1.1.isLt
  have h2 := u.1.2.isLt
  have hr : ((u.1.1 : ℕ) = 0 ∧ (u.1.2 : ℕ) = 2) ∨ ((u.1.1 : ℕ) = 2 ∧ (u.1.2 : ℕ) = 2) := by
    have ha : leap8 ((⟨1, by decide⟩ : Fin 3), (⟨4, by decide⟩ : Fin 6)) u.1 := hu
    simp only [leap8, leap] at ha
    omega
  rcases hr with ⟨hr1, hr2⟩ | ⟨hr1, hr2⟩
  · exact Or.inl (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))
  · exact Or.inr (Subtype.ext (Prod.ext (Fin.ext hr1) (Fin.ext hr2)))

/-- n = 6 闭侧：三帽顶点 (1,0)/(2,1)/(1,4) 均被迫占用通往 (0,2) 的圈边，
    (0,2) 处圈边 ≥ 3 与恰 2 矛盾。 -/
theorem no_closed_tour_6 : ¬ ∃ a : V 6, ∃ w : (knightGraph 6).Walk a a, w.IsHamiltonianCycle := by
  rintro ⟨a, w, hw⟩
  have hnd : w.edges.Nodup :=
    ((SimpleGraph.Walk.isHamiltonianCycle_isCycle_and_isHamiltonian_tail.mp hw).1).edges_nodup
  obtain ⟨h1a, -⟩ := force_edge_cycle hw (v := e10) (u1 := e02) (u2 := e22) (by decide) adj_6_10
  obtain ⟨h1b, -⟩ := force_edge_cycle hw (v := e21) (u1 := e02) (u2 := e13) (by decide) adj_6_21
  obtain ⟨h1c, -⟩ := force_edge_cycle hw (v := e14) (u1 := e02) (u2 := e22) (by decide) adj_6_14
  have hm1 : s(e10, e02) ∈ w.edges.filter (fun e => e02 ∈ e) :=
    List.mem_filter.mpr ⟨h1a, by rw [decide_eq_true_iff]; exact Sym2.mem_iff.mpr (Or.inr rfl)⟩
  have hm2 : s(e21, e02) ∈ w.edges.filter (fun e => e02 ∈ e) :=
    List.mem_filter.mpr ⟨h1b, by rw [decide_eq_true_iff]; exact Sym2.mem_iff.mpr (Or.inr rfl)⟩
  have hm3 : s(e14, e02) ∈ w.edges.filter (fun e => e02 ∈ e) :=
    List.mem_filter.mpr ⟨h1c, by rw [decide_eq_true_iff]; exact Sym2.mem_iff.mpr (Or.inr rfl)⟩
  have hge : 3 ≤ (w.edges.filter (fun e => e02 ∈ e)).length :=
    three_le_length_of_nodup (hnd.filter _) hm1 hm2 hm3
      (sym2_ne_of_not_mem (by decide)) (sym2_ne_of_not_mem (by decide))
      (sym2_ne_of_not_mem (by decide))
  have htwo : incCount w e02 = 2 := incCount_cycle_two hw e02
  unfold incCount at htwo
  omega

#print axioms no_open_tour_0
#print axioms no_closed_tour_0
#print axioms no_closed_tour_4
#print axioms no_closed_tour_6

set_option maxHeartbeats 4000000
set_option maxRecDepth 8000

/-! ## 15. 割集阻障（T4-open：n = 6/7 开侧否定） -/

theorem cut_card_bound {α : Type*} [DecidableEq α] {S : List α} {N : ℕ} {lab : α → Fin N}
    {G : SimpleGraph α}
    (hadj : ∀ a b : α, G.Adj a b → a ∉ S → b ∉ S → lab a = lab b) :
    ∀ {L : List α}, L.IsChain G.Adj →
      ((L.filter (· ∉ S)).map lab).toFinset.card ≤ 1 + L.tail.countP (· ∈ S) := by
  intro L
  induction L with
  | nil => intro _; simp
  | cons x xs ih =>
      intro hL
      cases xs with
      | nil => by_cases hx : x ∈ S <;> simp [hx]
      | cons y ys =>
          obtain ⟨hxy, htail⟩ := List.isChain_cons_cons.mp hL
          have hih := ih htail
          rw [List.tail_cons] at hih
          rw [List.tail_cons]
          by_cases hx : x ∈ S <;> by_cases hy : y ∈ S
          · -- ① x ∈ S, y ∈ S
            have hF : (x :: y :: ys).filter (· ∉ S) = (y :: ys).filter (· ∉ S) :=
              List.filter_cons_of_neg (by simp [hx])
            rw [hF]
            have hc : (y :: ys).countP (· ∈ S) = ys.countP (· ∈ S) + 1 := by simp [hy]
            rw [hc]; omega
          · -- ② x ∈ S, y ∉ S
            have hF : (x :: y :: ys).filter (· ∉ S) = (y :: ys).filter (· ∉ S) :=
              List.filter_cons_of_neg (by simp [hx])
            rw [hF]
            have hc : (y :: ys).countP (· ∈ S) = ys.countP (· ∈ S) := by simp [hy]
            rw [hc]; omega
          · -- ③ x ∉ S, y ∈ S
            have hF : (x :: y :: ys).filter (· ∉ S) = x :: (y :: ys).filter (· ∉ S) :=
              List.filter_cons_of_pos (by simp [hx])
            rw [hF, List.map_cons, List.toFinset_cons]
            have hc : (y :: ys).countP (· ∈ S) = ys.countP (· ∈ S) + 1 := by simp [hy]
            rw [hc]
            exact le_trans (Finset.card_insert_le (lab x) _) (by omega)
          · -- ④ x ∉ S, y ∉ S
            have hF : (x :: y :: ys).filter (· ∉ S) = x :: (y :: ys).filter (· ∉ S) :=
              List.filter_cons_of_pos (by simp [hx])
            rw [hF, List.map_cons, List.toFinset_cons]
            have hc : (y :: ys).countP (· ∈ S) = ys.countP (· ∈ S) := by simp [hy]
            rw [hc]
            have hlab : lab x = lab y := hadj x y hxy hx hy
            have hymem : lab y ∈ (((y :: ys).filter (· ∉ S)).map lab).toFinset :=
              List.mem_toFinset.mpr (List.mem_map_of_mem (f := lab)
                (List.mem_filter.mpr ⟨by simp, by simp [hy]⟩))
            rw [hlab, Finset.insert_eq_of_mem hymem]
            omega

theorem cut_bound {V : Type*} [Fintype V] [DecidableEq V] {G : SimpleGraph V} {N : ℕ}
    (S : List V) (hSnd : S.Nodup) (lab : V → Fin N)
    (hadj : ∀ a b : V, G.Adj a b → a ∉ S → b ∉ S → lab a = lab b)
    (hsurj : ∀ i : Fin N, ∃ v : V, v ∉ S ∧ lab v = i)
    {a b : V} {w : G.Walk a b} (hw : w.IsHamiltonian) :
    N ≤ S.length + 1 := by
  have hchain : w.support.IsChain G.Adj := SimpleGraph.Walk.isChain_adj_support w
  have hnd : w.support.Nodup :=
    List.nodup_iff_count_le_one.mpr (fun v => by have h := hw v; omega)
  have hcut := cut_card_bound hadj hchain
  have hcover : ∀ i : Fin N, i ∈ ((w.support.filter (· ∉ S)).map lab).toFinset := by
    intro i
    obtain ⟨v, hvS, hvl⟩ := hsurj i
    have hvm : v ∈ w.support := List.count_pos_iff.mp (by have h := hw v; omega)
    rw [← hvl]
    exact List.mem_toFinset.mpr (List.mem_map_of_mem (f := lab)
      (List.mem_filter.mpr ⟨hvm, by simp [hvS]⟩))
  have hNcard : N = (Finset.univ : Finset (Fin N)).card := by
    rw [Finset.card_univ, Fintype.card_fin]
  have hcle : (Finset.univ : Finset (Fin N)).card
      ≤ ((w.support.filter (· ∉ S)).map lab).toFinset.card :=
    Finset.card_le_card (fun i _ => hcover i)
  have htail : w.support.tail.countP (· ∈ S) ≤ w.support.countP (· ∈ S) :=
    List.Sublist.countP_le (List.tail_sublist w.support)
  have hlen : w.support.countP (· ∈ S) = (w.support.filter (· ∈ S)).length :=
    List.countP_eq_length_filter
  have hsub : List.Subperm (w.support.filter (· ∈ S)) S :=
    List.Nodup.subperm (hnd.filter _)
      (fun x hx => of_decide_eq_true (List.mem_filter.mp hx).2)
  have hflen := hsub.length_le
  omega

theorem no_hamiltonian_of_cut {V : Type*} [Fintype V] [DecidableEq V] {G : SimpleGraph V} {N : ℕ}
    (S : List V) (hSnd : S.Nodup) (lab : V → Fin N)
    (hadj : ∀ a b : V, G.Adj a b → a ∉ S → b ∉ S → lab a = lab b)
    (hsurj : ∀ i : Fin N, ∃ v : V, v ∉ S ∧ lab v = i)
    (hN : S.length + 1 < N) :
    ¬ ∃ a b : V, ∃ w : G.Walk a b, w.IsHamiltonian := by
  rintro ⟨a, b, w, hw⟩
  have h := cut_bound S hSnd lab hadj hsurj hw
  omega

/-- n=6 顶点构造助手。 -/
def v6 (r : Fin 3) (c : Fin 6) (h : IsCell 6 (r, c) := by decide) : V 6 := ⟨(r, c), h⟩

/-- n=6 割集证书：中间两列 6 格。 -/
def cutS6 : List (V 6) := [v6 0 2, v6 0 3, v6 1 2, v6 1 3, v6 2 2, v6 2 3]

/-- n=6 连通块标签（S 格与未列格 ↦ 0）。 -/
def cutLab6 : V 6 → Fin 8 := fun v =>
  match v.1.1.val, v.1.2.val with
  | 0, 1 => 0 | 0, 4 => 1 | 0, 5 => 2
  | 1, 0 => 3 | 1, 1 => 4 | 1, 4 => 5 | 1, 5 => 6
  | 2, 0 => 0 | 2, 1 => 7 | 2, 4 => 2
  | _, _ => 0

theorem no_open_tour_6 :
    ¬ ∃ a b : V 6, ∃ w : (knightGraph 6).Walk a b, w.IsHamiltonian :=
  no_hamiltonian_of_cut cutS6 (by decide) cutLab6 (by decide) (by decide) (by decide)

/-- n=7 顶点构造助手。 -/
def v7 (r : Fin 3) (c : Fin 7) (h : IsCell 7 (r, c) := by decide) : V 7 := ⟨(r, c), h⟩

/-- n=7 割集证书：5 格。 -/
def cutS7 : List (V 7) := [v7 0 2, v7 0 4, v7 1 3, v7 2 2, v7 2 4]

/-- n=7 连通块标签（S 格与未列格 ↦ 0）。 -/
def cutLab7 : V 7 → Fin 7 := fun v =>
  match v.1.1.val, v.1.2.val with
  | 0, 1 => 0 | 0, 3 => 1 | 0, 5 => 2 | 0, 6 => 3
  | 1, 0 => 4 | 1, 1 => 1 | 1, 2 => 0 | 1, 4 => 3 | 1, 5 => 1 | 1, 6 => 5
  | 2, 0 => 0 | 2, 1 => 6 | 2, 3 => 1 | 2, 5 => 3
  | _, _ => 0

theorem no_open_tour_7 :
    ¬ ∃ a b : V 7, ∃ w : (knightGraph 7).Walk a b, w.IsHamiltonian :=
  no_hamiltonian_of_cut cutS7 (by decide) cutLab7 (by decide) (by decide) (by decide)

/-! ## 16. T5 组装：双 iff 主定理（statement 冻结件） -/

/-- **定理 O**（开巡游 iff）：K_n 存在哈密顿路径 ⟺ n = 1 ∨ 4 ∨ 5 ∨ ≥8。 -/
theorem exists_hamiltonian_path_iff (n : ℕ) :
    (∃ a b : V n, ∃ w : (knightGraph n).Walk a b, w.IsHamiltonian) ↔
      n = 1 ∨ n = 4 ∨ n = 5 ∨ 8 ≤ n := by
  constructor
  · intro h
    by_cases h8 : 8 ≤ n
    · exact Or.inr (Or.inr (Or.inr h8))
    · push_neg at h8
      have : n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 3 ∨ n = 4 ∨ n = 5 ∨ n = 6 ∨ n = 7 := by omega
      rcases this with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
      · exact absurd h no_open_tour_0
      · exact Or.inl rfl
      · exact absurd h no_open_tour_2
      · exact absurd h no_open_tour_3
      · exact Or.inr (Or.inl rfl)
      · exact Or.inr (Or.inr (Or.inl rfl))
      · exact absurd h no_open_tour_6
      · exact absurd h no_open_tour_7
  · rintro (rfl | rfl | rfl | h8)
    · exact open_tour_1
    · exact open_tour_4
    · exact open_tour_5
    · rcases Nat.even_or_odd n with he | ho
      · exact open_of_closed (closed_cycle_exists n he h8)
      · obtain ⟨k, rfl⟩ := ho
        exact open_tour_exists_odd _ (by omega) ⟨k, rfl⟩

/-- **定理 C**（闭巡游 iff）：K_n 存在哈密顿圈 ⟺ Even n ∧ ≥8。 -/
theorem exists_hamiltonian_cycle_iff (n : ℕ) :
    (∃ a : V n, ∃ w : (knightGraph n).Walk a a, w.IsHamiltonianCycle) ↔
      Even n ∧ 8 ≤ n := by
  constructor
  · intro h
    constructor
    · rcases Nat.even_or_odd n with he | ho
      · exact he
      · exact absurd h (no_cycle_odd ho)
    · by_contra h8
      push_neg at h8
      have : n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 3 ∨ n = 4 ∨ n = 5 ∨ n = 6 ∨ n = 7 := by omega
      rcases this with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
      · exact no_closed_tour_0 h
      · exact no_cycle_odd ⟨0, rfl⟩ h
      · exact no_closed_tour_2 h
      · exact no_cycle_odd ⟨1, rfl⟩ h
      · exact no_closed_tour_4 h
      · exact no_cycle_odd ⟨2, rfl⟩ h
      · exact no_closed_tour_6 h
      · exact no_cycle_odd ⟨3, rfl⟩ h
  · rintro ⟨he, h8⟩
    exact closed_cycle_exists n he h8

#print axioms exists_hamiltonian_path_iff
#print axioms exists_hamiltonian_cycle_iff
