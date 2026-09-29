import Mathlib

open SimpleGraph Finset

/-!
# L14 C 槽图侧陈述（pool-comb-13 · 形态乙：图侧陈述升级）

本件只交 statement（`:= by sorry` 占位），不含任何证明。
基座代码逐字拷贝自 `tasks/20260929-l14c-graphside-deep/smoke/graphside-statability-v3.lean`
（lean-verify --allow-sorry exit 0 / 0 error），含三条显式可判定实例（prism / prismDelSpoke /
prismDelRim——绕开「实例搜索不展开 def」的关键，删了会全线合成失败）。

## 对象与口径（冻结 NL 转录）
- 棱柱图 = 环图与二节点路的盒子积 `C_n □ P_2`（mathlib：`cycleGraph n □ pathGraph 2`）。
- 两条缺陷切片：删去第 0 列的一条**横档**（spoke，(0,0)-(0,1)，两端点保留）得 `prismDelSpoke`；
  删去第 0 层的一条**周长边**（rim，(0,0)-(1,0)，两端点保留）得 `prismDelRim`。
- 匹配数 Hosoya 口径 = 全部匹配数（含空匹配），边子集口径（`hosoya` def）。

## 高危结构处置标注
1. **自然数截断减法**：两个主定理的右侧下标写作 `n - 3`（ℕ 截断减法），命题自带假设
   `hn : 3 ≤ n`，故 `n - 3` 在假设域内即真实差值，无截断失真；为忠实转录冻结 NL（「序列
   `a (n - 3)`」），此处不改为 `n + 3` 等变形，仅作标注。
2. **induce 顶点型变化**：伴随引理的被诱导子图顶点型为子类型
   `↥(Set.univ \ {…})`，与 `prism n` 的 `Fin n × Fin 2` 不同；两侧 `hosoya` 各自在自己的
   有限型上取边子集幂集，计数口径一致（均为该图全部匹配数），此处仅作标注。
3. **native_decide**：四个数据锚以 `native_decide` 核验，编译期引入 `Lean.ofReduceBool`
   （**非公理白名单**）。它们**只作数据核验**（口径锚定），**不是入库初值、不是立项主体**；
   冻结 NL 明列其口径为「数据核验口径，非入库初值」。
4. **退化形态自查**：主定理一/二为一般 `n` 形（带 `hn : 3 ≤ n` 的 ∀），天然非 bare
   tactic 秒杀形态；伴随引理为一般 `n` 恒等式，亦非退化；数据锚为显式标注的核验件，不在此禁。
5. **不在本 statement 范围**：mod 2/4/8 同余定理（六条）已在形态甲快照
   `tasks/20260929-preselect-deeprecheck-01/attempts/L14C/statement.lean` 在案，本件不重述、
   不改写；母体（无缺陷棱柱）不主张。
-/

-- ===== 基座代码（逐字，禁改） =====

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

def prismDelRim (n : ℕ) (hn : 3 ≤ n) : SimpleGraph (Fin n × Fin 2) :=
  (prism n).deleteEdges {Sym2.mk ((⟨0, by omega⟩, ⟨0, by omega⟩)) ((⟨1, by omega⟩, ⟨0, by omega⟩))}

instance (n : ℕ) (hn : 3 ≤ n) : DecidableRel (prismDelRim n hn).Adj :=
  show DecidableRel ((prism n).deleteEdges
    {Sym2.mk ((⟨0, by omega⟩, ⟨0, by omega⟩)) ((⟨1, by omega⟩, ⟨0, by omega⟩))}).Adj from inferInstance

def aspoke : ℕ → ℤ
  | 0 => 25
  | 1 => 86
  | 2 => 271
  | 3 => 876
  | n + 4 => 2 * aspoke (n + 3) + 4 * aspoke (n + 2) - aspoke n

def arim : ℕ → ℤ
  | 0 => 26
  | 1 => 86
  | 2 => 274
  | 3 => 883
  | n + 4 => 2 * arim (n + 3) + 4 * arim (n + 2) - arim n

-- ===== 追加 statement（语义冻结，sorry 占位合规） =====

/-- **主定理一（spoke 侧桥定理）**：对一切 `n ≥ 3`，删一条 spoke 的棱柱的匹配数等于序列
`aspoke (n - 3)`。其中 `aspoke` 为已冻结序列（初值 25, 86, 271, 876，四阶递推
`a(n+4) = 2·a(n+3) + 4·a(n+2) − a(n)`，下标 0 对应图侧 n = 3）。 -/
theorem hosoya_prism_del_spoke : ∀ (n : ℕ) (hn : 3 ≤ n),
    (hosoya (prismDelSpoke n hn) : ℤ) = aspoke (n - 3) := by
  sorry

/-- **主定理二（rim 侧桥定理）**：对一切 `n ≥ 3`，删一条 rim 边的棱柱的匹配数等于序列
`arim (n - 3)`。其中 `arim` 为已冻结序列（初值 26, 86, 274, 883，同四阶递推）。 -/
theorem hosoya_prism_del_rim : ∀ (n : ℕ) (hn : 3 ≤ n),
    (hosoya (prismDelRim n hn) : ℤ) = arim (n - 3) := by
  sorry

/-- **伴随引理（证明架构第一步，删边分割恒等式对完整棱柱沿该 spoke 切开）**：
`hosoya (prism n) = hosoya (prismDelSpoke n hn) + hosoya (prism 诱导删去该 spoke 两端点后的子图)`。 -/
theorem hosoya_prism_split_spoke : ∀ (n : ℕ) (hn : 3 ≤ n),
    hosoya (prism n) =
      hosoya (prismDelSpoke n hn) +
        hosoya (SimpleGraph.induce
          (Set.univ \ {((⟨0, by omega⟩, (0 : Fin 2))), ((⟨0, by omega⟩, (1 : Fin 2)))} : Set (Fin n × Fin 2))
          (prism n)) := by
  sorry

/-- 数据锚（数据核验口径，非入库初值）：`hosoya (prismDelSpoke 3) = 25`（n=3）；
`native_decide` 引入 `Lean.ofReduceBool`（非公理白名单），只作数据核验。 -/
example : hosoya (prismDelSpoke 3 (by omega)) = 25 := by native_decide

/-- 数据锚（数据核验口径，非入库初值）：`hosoya (prismDelSpoke 4) = 86`（n=4）；
`native_decide` 引入 `Lean.ofReduceBool`（非公理白名单），只作数据核验。 -/
example : hosoya (prismDelSpoke 4 (by omega)) = 86 := by native_decide

/-- 数据锚（数据核验口径，非入库初值）：`hosoya (prismDelRim 3) = 26`（n=3）；
`native_decide` 引入 `Lean.ofReduceBool`（非公理白名单），只作数据核验。 -/
example : hosoya (prismDelRim 3 (by omega)) = 26 := by native_decide

/-- 数据锚（数据核验口径，非入库初值）：`hosoya (prismDelRim 4) = 86`（n=4）；
`native_decide` 引入 `Lean.ofReduceBool`（非公理白名单），只作数据核验。 -/
example : hosoya (prismDelRim 4 (by omega)) = 86 := by native_decide
