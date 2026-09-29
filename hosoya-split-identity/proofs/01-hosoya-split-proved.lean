import Mathlib

open SimpleGraph Finset

/-!
# Phase 0 删边分割恒等式 · 完全证明（2026-09-29，零占位、严格编译通过）

 provenance：
 - 基座代码逐字承冻结快照 `formalized/statement.lean`（宪条 2，只许拷贝不许改）。
 - 「已验证块 A–D」逐字承 `attempts/phase0/r1/scratch-probe1.lean` 与
   `scratch-probe2.lean`（军政部 headless 工人 r1b 留下，主代理 `lake env lean`
   实测两文件均 exit 0 / 0 error，2026-09-29 15:2x）；本文件把两探针的 example
   转成可引用的 theorem（证明体逐字未动；`edgeSupp_card_two` 前加 `include G he`
   一处——Lean 4 section 变量只按声明签名收绑定件，证明体里单独用要 include）。
 - 一般装置引理 `hosoya_deleteEdge_split_pts`（两点集形态）：数学骨架承工人 r2 在
   `r2-scratch.lean` 中证明的 edgeSp 形态版（主代理实测编译通过），由主代理适配为
   两点集形态——原因：`Set.univ \ ↑(edgeSupp …)` 经 Finset coercion，TC 合成
   `Set.univ.fintypeDiffLeft` 实例，与变量集形态的通用 `Subtype.fintype` 实例
   非 defeq（实测 8M 心跳 type mismatch），实例化时 rw/exact 全线失配；
   两点集字面量与冻结陈述同一条实例合成路径（pts 探针实证 exit 0）。
 - 目标定理 `hosoya_prism_split_spoke`：statement 逐字冻结，实例化走两点集引理
   + `boxProd_adj` 邻接路线（承工人 P2 探针）。
-/

-- ===== 基座代码（逐字承冻结快照 formalized/statement.lean，只许拷贝不许改） =====

instance (n : ℕ) : DecidableRel (pathGraph n).Adj := fun _ _ =>
  decidable_of_iff _ pathGraph_adj.symm

instance {α β : Type*} [DecidableEq α] [DecidableEq β] (G : SimpleGraph α) (H : SimpleGraph β)
    [DecidableRel G.Adj] [DecidableRel H.Adj] : DecidableRel (G □ H).Adj := fun _ _ =>
  decidable_of_iff _ boxProd_adj.symm

def edgeSupp {V : Type*} [DecidableEq V] [Fintype V] (e : Sym2 V) : Finset V :=
  (univ : Finset V).filter fun v => v ∈ e

def hosoya (G : SimpleGraph V) [Fintype V] [DecidableEq V] [DecidableRel G.Adj] : ℕ :=
  ((G.edgeFinset.powerset).filter fun s =>
    (∀ e ∈ s, ∀ f ∈ s, e ≠ f → Disjoint (edgeSupp e) (edgeSupp f))).card

def prism (n : ℕ) : SimpleGraph (Fin n × Fin 2) := cycleGraph n □ pathGraph 2

instance (n : ℕ) : DecidableRel (prism n).Adj :=
  show DecidableRel (cycleGraph n □ pathGraph 2).Adj from inferInstance

def prismDelSpoke (n : ℕ) (hn : 3 ≤ n) : SimpleGraph (Fin n × Fin 2) :=
  (prism n).deleteEdges {Sym2.mk ((⟨0, by omega⟩, (0 : Fin 2))) ((⟨0, by omega⟩, (1 : Fin 2)))}

instance (n : ℕ) (hn : 3 ≤ n) : DecidableRel (prismDelSpoke n hn).Adj :=
  show DecidableRel ((prism n).deleteEdges
    {Sym2.mk ((⟨0, by omega⟩, (0 : Fin 2))) ((⟨0, by omega⟩, (1 : Fin 2)))}).Adj from inferInstance

-- ===== 已验证块 A（承 scratch-probe1.lean，rfl 展开层） =====

theorem hosoya_def {V : Type*} [DecidableEq V] [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] :
    hosoya G = ((G.edgeFinset.powerset).filter fun s =>
      (∀ e ∈ s, ∀ f ∈ s, e ≠ f → Disjoint (edgeSupp e) (edgeSupp f))).card := rfl

-- ===== 已验证块 B（承 scratch-probe1.lean P2/P4，棱柱 spoke 事实） =====

theorem spoke_mem_edgeFinset (n : ℕ) (hn : 3 ≤ n) :
    Sym2.mk ((⟨0, by omega⟩ : Fin n), (0 : Fin 2))
      ((⟨0, by omega⟩ : Fin n), (1 : Fin 2)) ∈ (prism n).edgeFinset := by
  rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
  show (cycleGraph n □ pathGraph 2).Adj (⟨0, by omega⟩, (0 : Fin 2)) (⟨0, by omega⟩, (1 : Fin 2))
  rw [boxProd_adj]
  refine Or.inr ⟨?_, rfl⟩
  show (pathGraph 2).Adj (0 : Fin 2) (1 : Fin 2)
  decide

theorem edgeSupp_spoke (n : ℕ) (hn : 3 ≤ n) :
    (↑(edgeSupp (Sym2.mk ((⟨0, by omega⟩ : Fin n), (0 : Fin 2))
      ((⟨0, by omega⟩ : Fin n), (1 : Fin 2)))) : Set (Fin n × Fin 2)) =
    {((⟨0, by omega⟩ : Fin n), (0 : Fin 2)), ((⟨0, by omega⟩ : Fin n), (1 : Fin 2))} := by
  ext v
  simp [edgeSupp, Sym2.mem_iff]

-- ===== 已验证块 C（承 scratch-probe1.lean P5/P6，不含 e 半 + 分区计数） =====

theorem matching_filter_not_mem (V : Type*) [Fintype V] [DecidableEq V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (e : Sym2 V) :
    (G.edgeFinset.powerset.filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f)) ∧ e ∉ s) =
      ((G.edgeFinset \ {e}).powerset).filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f)) := by
  ext s
  simp only [Finset.mem_powerset, Finset.mem_filter]
  constructor
  · rintro ⟨hs, hP, hne⟩
    refine ⟨fun x hx => ?_, hP⟩
    rw [Finset.mem_sdiff, Finset.mem_singleton]
    exact ⟨hs hx, fun h => hne (h ▸ hx)⟩
  · rintro ⟨hs, hP⟩
    refine ⟨fun x hx => (Finset.mem_sdiff.mp (hs hx)).1, hP, fun h => ?_⟩
    exact (Finset.mem_sdiff.mp (hs h)).2 (Finset.mem_singleton_self e)

theorem hosoya_partition (V : Type*) [Fintype V] [DecidableEq V] (G : SimpleGraph V)
    [DecidableRel G.Adj] (e : Sym2 V) :
    hosoya G = ((G.edgeFinset.powerset.filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f)) ∧ e ∉ s).card +
      (G.edgeFinset.powerset.filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f)) ∧ e ∈ s).card) := by
  have h1 := Finset.card_filter_add_card_filter_not
    (s := G.edgeFinset.powerset.filter fun s =>
      (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f))) (fun s => e ∉ s)
  rw [hosoya_def, ← h1]
  congr 1
  · rw [Finset.filter_filter]
  · rw [Finset.filter_filter]
    congr 1
    ext s
    simp only [not_not]

-- ===== 已验证块 D（承 scratch-probe2.lean，Sym2 跨顶点型搬运四件） =====

theorem edgeSupp_mem {V : Type*} [DecidableEq V] [Fintype V] (e : Sym2 V) (v : V) :
    v ∈ edgeSupp e ↔ v ∈ e := by simp [edgeSupp]

section Transport

variable {V : Type*} [Fintype V] [DecidableEq V] (G : SimpleGraph V) [DecidableRel G.Adj]
  (e : Sym2 V) (he : e ∈ G.edgeFinset)

theorem edgeSupp_map_subtype (g : Sym2 ↥(↑((univ : Finset V) \ edgeSupp e) : Set V)) :
    (edgeSupp g).map (Function.Embedding.subtype
      (· ∈ (↑((univ : Finset V) \ edgeSupp e) : Set V))) =
    edgeSupp (Sym2.map (Subtype.val) g) := by
  ext v
  rw [Finset.mem_map]
  constructor
  · rintro ⟨u, hu, huv⟩
    rw [edgeSupp_mem] at hu
    rw [edgeSupp_mem]
    exact Sym2.mem_map.mpr ⟨u, hu, huv⟩
  · intro hv
    rw [edgeSupp_mem] at hv
    obtain ⟨u, hu, huv⟩ := Sym2.mem_map.mp hv
    exact ⟨u, by rw [edgeSupp_mem]; exact hu, huv⟩

theorem disjoint_map_subtype (g₁ g₂ : Sym2 ↥(↑((univ : Finset V) \ edgeSupp e) : Set V)) :
    Disjoint (edgeSupp g₁) (edgeSupp g₂) ↔
    Disjoint (edgeSupp (Sym2.map (Subtype.val) g₁)) (edgeSupp (Sym2.map (Subtype.val) g₂)) := by
  have L1 : ∀ g : Sym2 ↥(↑((univ : Finset V) \ edgeSupp e) : Set V),
      (edgeSupp g).map (Function.Embedding.subtype
        (· ∈ (↑((univ : Finset V) \ edgeSupp e) : Set V))) =
      edgeSupp (Sym2.map (Subtype.val) g) := by
    intro g
    ext v
    rw [Finset.mem_map]
    constructor
    · rintro ⟨u, hu, huv⟩
      rw [edgeSupp_mem] at hu
      rw [edgeSupp_mem]
      exact Sym2.mem_map.mpr ⟨u, hu, huv⟩
    · intro hv
      rw [edgeSupp_mem] at hv
      obtain ⟨u, hu, huv⟩ := Sym2.mem_map.mp hv
      exact ⟨u, by rw [edgeSupp_mem]; exact hu, huv⟩
  rw [← L1 g₁, ← L1 g₂]
  constructor
  · intro h
    rw [Finset.disjoint_left] at h ⊢
    intro v hv hv'
    rw [Finset.mem_map] at hv hv'
    obtain ⟨u, hu, huv⟩ := hv
    obtain ⟨u', hu', huv'⟩ := hv'
    have huu : u = u' := (Function.Embedding.subtype _).injective (huv.trans huv'.symm)
    exact h hu (huu ▸ hu')
  · intro h
    rw [Finset.disjoint_left] at h ⊢
    intro u hu hu'
    exact h (Finset.mem_map.mpr ⟨u, hu, rfl⟩) (Finset.mem_map.mpr ⟨u, hu', rfl⟩)

theorem mapped_ne_edge (g : Sym2 ↥(↑((univ : Finset V) \ edgeSupp e) : Set V)) :
    Sym2.map (Subtype.val) g ≠ e := by
  intro hge
  have hex : ∃ u : V, u ∈ e := by
    induction e using Sym2.ind with
    | _ a b => exact ⟨a, Sym2.mem_iff.mpr (Or.inl rfl)⟩
  obtain ⟨u, hu⟩ := hex
  have huE : u ∈ edgeSupp e := Finset.mem_filter.mpr ⟨Finset.mem_univ u, hu⟩
  have hu2 : u ∈ edgeSupp (Sym2.map (Subtype.val) g) := hge.symm ▸ huE
  rw [edgeSupp_mem] at hu2
  obtain ⟨w, hwg, hwu⟩ := Sym2.mem_map.mp hu2
  rw [← hwu] at huE
  have hwT : (↑w : V) ∈ (↑((univ : Finset V) \ edgeSupp e) : Set V) := w.2
  rw [Finset.mem_coe, Finset.mem_sdiff] at hwT
  exact hwT.2 huE

include G he
theorem edgeSupp_card_two : (edgeSupp e).card = 2 := by
  rw [SimpleGraph.mem_edgeFinset] at he
  induction e using Sym2.ind with
  | _ a b =>
    rw [SimpleGraph.mem_edgeSet] at he
    have hab : a ≠ b := G.ne_of_adj he
    rw [Finset.card_eq_two]
    refine ⟨a, b, hab, ?_⟩
    ext v
    simp [edgeSupp, Sym2.mem_iff]

end Transport

-- ===== 一般装置引理（删边分割恒等式 · 两点集形态） =====

/-- 一般装置引理（删边分割恒等式，两点集形态）：对任意图 `G` 与边 `a ~ b`，
匹配集按「含 `s(a, b)` / 不含 `s(a, b)`」二分——不含者 = `G.deleteEdges {s(a,b)}`
的匹配数（已验证块 C），含者 = 删 `a, b` 两端点后诱导子图的匹配数（B 侧：
`Finset.card_bij` 双豫 + Sym2 跨型搬运）。
形态说明：诱导集用 `Set.univ \ {a, b}`（两点集字面量）而非 `Set.univ \ ↑(edgeSupp …)`——
后者经 Finset coercion，TC 合成的是 `Set.univ.fintypeDiffLeft` 实例，与变量集形态的
通用 `Subtype.fintype` 实例非 defeq（实测 8M 心跳 type mismatch），会导致实例化时
rw/exact 全线失配；两点集字面量形态与冻结陈述同一条实例合成路径（pts 探针实证）。 -/
theorem hosoya_deleteEdge_split_pts {V : Type*} [Fintype V] [DecidableEq V]
    (G : SimpleGraph V) [DecidableRel G.Adj]
    (a b : V) (huv : G.Adj a b) :
    hosoya G = hosoya (G.deleteEdges {Sym2.mk a b}) +
      hosoya (SimpleGraph.induce (Set.univ \ {a, b} : Set V) G) := by
  have he : Sym2.mk a b ∈ G.edgeFinset := by
    rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]; exact huv
  have hA : ((G.edgeFinset.powerset).filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f)) ∧ Sym2.mk a b ∈ s).card
      = ((G.edgeFinset.powerset).filter fun u =>
        (∀ a₁ ∈ u, ∀ b₁ ∈ u, a₁ ≠ b₁ → Disjoint (edgeSupp a₁) (edgeSupp b₁)) ∧
          ∀ f ∈ u, Disjoint (edgeSupp f) (edgeSupp (Sym2.mk a b))).card := by
    apply Finset.card_bij (fun s _ => s.erase (Sym2.mk a b))
    · intro s hs
      rw [Finset.mem_filter, Finset.mem_powerset] at hs
      obtain ⟨hsE, hsP, hse⟩ := hs
      rw [Finset.mem_filter, Finset.mem_powerset]
      refine ⟨(Finset.erase_subset _ s).trans hsE, ?_, ?_⟩
      · intro a₁ ha b₁ hb hab
        exact hsP a₁ (Finset.mem_of_mem_erase ha) b₁ (Finset.mem_of_mem_erase hb) hab
      · intro f hf
        exact hsP f (Finset.mem_of_mem_erase hf) (Sym2.mk a b) hse (Finset.ne_of_mem_erase hf)
    · intro s₁ hs₁ s₂ hs₂ hh
      rw [Finset.mem_filter] at hs₁ hs₂
      rw [← Finset.insert_erase hs₁.2.2, ← Finset.insert_erase hs₂.2.2, hh]
    · intro u hu
      rw [Finset.mem_filter, Finset.mem_powerset] at hu
      obtain ⟨huE, huP, hdj⟩ := hu
      have heu : Sym2.mk a b ∉ u := by
        intro heu'
        have h := hdj (Sym2.mk a b) heu'
        obtain ⟨v, hv⟩ := Finset.card_pos.mp (by rw [edgeSupp_card_two G (Sym2.mk a b) he]; norm_num)
        exact Finset.disjoint_left.mp h hv hv
      refine ⟨insert (Sym2.mk a b) u, ?_, Finset.erase_insert heu⟩
      rw [Finset.mem_filter, Finset.mem_powerset]
      refine ⟨Finset.insert_subset he huE, ?_, Finset.mem_insert_self _ _⟩
      intro a₁ ha b₁ hb hab
      rw [Finset.mem_insert] at ha hb
      rcases ha with rfl | ha
      · rcases hb with rfl | hb
        · exact absurd rfl hab
        · exact (hdj b₁ hb).symm
      · rcases hb with rfl | hb
        · exact hdj a₁ ha
        · exact huP a₁ ha b₁ hb hab
  have hB : ((G.edgeFinset.powerset).filter fun u =>
        (∀ a₁ ∈ u, ∀ b₁ ∈ u, a₁ ≠ b₁ → Disjoint (edgeSupp a₁) (edgeSupp b₁)) ∧
          ∀ f ∈ u, Disjoint (edgeSupp f) (edgeSupp (Sym2.mk a b))).card
      = (((SimpleGraph.induce (Set.univ \ {a, b} : Set V) G).edgeFinset.powerset).filter
          fun t => (∀ a₁ ∈ t, ∀ b₁ ∈ t, a₁ ≠ b₁ → Disjoint (edgeSupp a₁) (edgeSupp b₁))).card := by
    have hTS : ∀ v : V, v ∉ edgeSupp (Sym2.mk a b) → v ∈ (Set.univ \ {a, b} : Set V) := by
      intro v hv
      refine ⟨Set.mem_univ v, ?_⟩
      intro hmem
      apply hv
      rw [edgeSupp_mem, Sym2.mem_iff]
      simpa using hmem
    have map_inj : Function.Injective
        (Sym2.map (Subtype.val : ↥(Set.univ \ {a, b} : Set V) → V)) := by
      intro x y hxy
      induction x using Sym2.ind with
      | _ x₁ y₁ =>
        induction y using Sym2.ind with
        | _ x₂ y₂ =>
          rw [Sym2.map_mk, Sym2.map_mk, Sym2.eq_iff] at hxy
          rw [Sym2.eq_iff]
          rcases hxy with ⟨h1, h2⟩ | ⟨h1, h2⟩
          · exact Or.inl ⟨Subtype.ext h1, Subtype.ext h2⟩
          · exact Or.inr ⟨Subtype.ext h1, Subtype.ext h2⟩
    have hlift : ∀ f : Sym2 V, f ∈ G.edgeFinset → Disjoint (edgeSupp f) (edgeSupp (Sym2.mk a b)) →
        ∃ g : Sym2 ↥(Set.univ \ {a, b} : Set V),
          Sym2.map Subtype.val g = f ∧
          g ∈ (SimpleGraph.induce (Set.univ \ {a, b} : Set V) G).edgeFinset := by
      intro f hfE hfdj
      induction f using Sym2.ind with
      | _ x y =>
        rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet] at hfE
        have hxE : x ∉ edgeSupp (Sym2.mk a b) := by
          intro ha
          exact Finset.disjoint_left.mp hfdj
            (by rw [edgeSupp_mem]; exact Sym2.mem_iff.mpr (Or.inl rfl)) ha
        have hyE : y ∉ edgeSupp (Sym2.mk a b) := by
          intro hb
          exact Finset.disjoint_left.mp hfdj
            (by rw [edgeSupp_mem]; exact Sym2.mem_iff.mpr (Or.inr rfl)) hb
        refine ⟨s((⟨x, hTS x hxE⟩ : ↥(Set.univ \ {a, b} : Set V)),
          (⟨y, hTS y hyE⟩ : ↥(Set.univ \ {a, b} : Set V))), ?_, ?_⟩
        · rw [Sym2.map_mk]
        · rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
          exact SimpleGraph.induce_adj.mpr hfE
    symm
    apply Finset.card_bij (fun t _ => t.image (Sym2.map (Subtype.val :
      ↥(Set.univ \ {a, b} : Set V) → V)))
    · intro t ht
      rw [Finset.mem_filter, Finset.mem_powerset] at ht
      obtain ⟨htE, htP⟩ := ht
      rw [Finset.mem_filter, Finset.mem_powerset]
      refine ⟨?_, ?_, ?_⟩
      · intro y hy
        obtain ⟨g, hg, rfl⟩ := Finset.mem_image.mp hy
        have hgE := htE hg
        induction g using Sym2.ind with
        | _ x y =>
          rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet] at hgE
          rw [Sym2.map_mk, SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
          exact SimpleGraph.induce_adj.mp hgE
      · intro x hx y₁ hy hxy
        obtain ⟨g₁, hg₁, rfl⟩ := Finset.mem_image.mp hx
        obtain ⟨g₂, hg₂, rfl⟩ := Finset.mem_image.mp hy
        have hgg : g₁ ≠ g₂ := fun h => hxy (by rw [h])
        have hdj := htP g₁ hg₁ g₂ hg₂ hgg
        rw [Finset.disjoint_left] at hdj ⊢
        intro v hv1 hv2
        rw [edgeSupp_mem] at hv1 hv2
        obtain ⟨u₁, hu₁, huv₁⟩ := Sym2.mem_map.mp hv1
        obtain ⟨u₂, hu₂, huv₂⟩ := Sym2.mem_map.mp hv2
        have huu : u₁ = u₂ := Subtype.ext (huv₁.trans huv₂.symm)
        exact hdj ((edgeSupp_mem g₁ u₁).mpr hu₁) ((edgeSupp_mem g₂ u₁).mpr (huu ▸ hu₂))
      · intro y hy
        obtain ⟨g, hg, rfl⟩ := Finset.mem_image.mp hy
        rw [Finset.disjoint_left]
        intro v hv hve
        rw [edgeSupp_mem] at hv
        obtain ⟨u, hu, huv⟩ := Sym2.mem_map.mp hv
        rw [← huv] at hve
        have huS := (Set.mem_sdiff _).mp u.2
        have hmem : (u.1 : V) ∈ ({a, b} : Set V) := by
          have h1 : u.1 ∈ Sym2.mk a b := (edgeSupp_mem _ _).mp hve
          have h2 : u.1 = a ∨ u.1 = b := (Sym2.mem_iff).mp h1
          simpa using h2
        exact huS.2 hmem
    · intro t₁ h₁ t₂ h₂ hh
      ext g
      constructor
      · intro hg
        have hm : Sym2.map Subtype.val g ∈ t₂.image (Sym2.map Subtype.val) := by
          rw [← hh]
          exact Finset.mem_image.mpr ⟨g, hg, rfl⟩
        obtain ⟨g', hg', hgg'⟩ := Finset.mem_image.mp hm
        exact (map_inj hgg') ▸ hg'
      · intro hg
        have hm : Sym2.map Subtype.val g ∈ t₁.image (Sym2.map Subtype.val) := by
          rw [hh]
          exact Finset.mem_image.mpr ⟨g, hg, rfl⟩
        obtain ⟨g', hg', hgg'⟩ := Finset.mem_image.mp hm
        exact (map_inj hgg') ▸ hg'
    · intro u hu
      rw [Finset.mem_filter, Finset.mem_powerset] at hu
      obtain ⟨huE, huP, hdj⟩ := hu
      refine ⟨u.attach.image fun x => Classical.choose (hlift x.1 (huE x.2) (hdj x.1 x.2)), ?_, ?_⟩
      · rw [Finset.mem_filter, Finset.mem_powerset]
        constructor
        · intro g hg
          obtain ⟨⟨f, hf⟩, -, rfl⟩ := Finset.mem_image.mp hg
          exact (Classical.choose_spec (hlift f (huE hf) (hdj f hf))).2
        · intro g₁ hg₁ g₂ hg₂ hgg
          obtain ⟨⟨f₁, hf₁⟩, -, rfl⟩ := Finset.mem_image.mp hg₁
          obtain ⟨⟨f₂, hf₂⟩, -, rfl⟩ := Finset.mem_image.mp hg₂
          have hff : f₁ ≠ f₂ := by
            intro h
            apply hgg
            subst h
            rfl
          have s1 := (Classical.choose_spec (hlift f₁ (huE hf₁) (hdj f₁ hf₁))).1
          have s2 := (Classical.choose_spec (hlift f₂ (huE hf₂) (hdj f₂ hf₂))).1
          have hdj2 := huP f₁ hf₁ f₂ hf₂ hff
          rw [Finset.disjoint_left] at hdj2 ⊢
          intro v hv1 hv2
          rw [edgeSupp_mem] at hv1 hv2
          exact hdj2
            ((edgeSupp_mem f₁ v).mpr (s1 ▸ Sym2.mem_map.mpr ⟨v, hv1, rfl⟩))
            ((edgeSupp_mem f₂ v).mpr (s2 ▸ Sym2.mem_map.mpr ⟨v, hv2, rfl⟩))
      · ext z
        constructor
        · intro hz
          obtain ⟨g, hg, hgz⟩ := Finset.mem_image.mp hz
          obtain ⟨⟨f, hf⟩, -, rfl⟩ := Finset.mem_image.mp hg
          have s := (Classical.choose_spec (hlift f (huE hf) (hdj f hf))).1
          rw [s] at hgz
          exact hgz ▸ hf
        · intro hz
          have s := (Classical.choose_spec (hlift z (huE hz) (hdj z hz))).1
          exact Finset.mem_image.mpr ⟨_, Finset.mem_image.mpr ⟨⟨z, hz⟩, Finset.mem_attach _ _, rfl⟩, s⟩
  have h2 : (G.deleteEdges {Sym2.mk a b}).edgeFinset = G.edgeFinset \ {Sym2.mk a b} := by
    ext f
    induction f using Sym2.ind with
    | _ x y =>
      simp only [Finset.mem_sdiff, Finset.mem_singleton]
      rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet,
        SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet, SimpleGraph.deleteEdges_adj,
        Set.mem_singleton_iff]
  have hdel : hosoya (G.deleteEdges {Sym2.mk a b}) =
      ((G.edgeFinset \ {Sym2.mk a b}).powerset.filter fun s =>
        (∀ e₁ ∈ s, ∀ f ∈ s, e₁ ≠ f → Disjoint (edgeSupp e₁) (edgeSupp f))).card := by
    rw [hosoya_def, h2]
  rw [hosoya_partition V G (Sym2.mk a b), matching_filter_not_mem V G (Sym2.mk a b), hdel,
    hosoya_def, hA, hB]
  congr 1

-- ===== 目标定理（statement 逐字冻结；实例化走两点集形态引理） =====

theorem hosoya_prism_split_spoke : ∀ (n : ℕ) (hn : 3 ≤ n),
    hosoya (prism n) =
      hosoya (prismDelSpoke n hn) +
        hosoya (SimpleGraph.induce
          (Set.univ \ {((⟨0, by omega⟩, (0 : Fin 2))), ((⟨0, by omega⟩, (1 : Fin 2)))} : Set (Fin n × Fin 2))
          (prism n)) := by
  intro n hn
  refine hosoya_deleteEdge_split_pts (prism n) ((⟨0, by omega⟩, (0 : Fin 2)))
    ((⟨0, by omega⟩, (1 : Fin 2))) ?_
  show (cycleGraph n □ pathGraph 2).Adj (⟨0, by omega⟩, (0 : Fin 2)) (⟨0, by omega⟩, (1 : Fin 2))
  rw [boxProd_adj]
  refine Or.inr ⟨?_, rfl⟩
  show (pathGraph 2).Adj (0 : Fin 2) (1 : Fin 2)
  decide
