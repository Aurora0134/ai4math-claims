import Mathlib
import Library.HosoyaPrismSplit
import Library.GraphsidePhase1
import Library.LadderHosoya
import Library.PrismHosoya

/-!
# Phase 2 r3 · 双桥定理 + 棱柱 R4 收口（bridge.lean，2026-10-01）

provenance：
- 任务契约 `attempts/phase2/r3/prompt.md`（Phase 2 第 4 采样位，最后一个）。
- 基座 def（aspoke/arim/prismDelRim + instance）逐字拷自冻结快照
  `formalized/statement.lean` L64–L83（宪条 2：只许拷贝不许改）。
- 数学骨架（契约 T4a–T4f）：p(n) = a(n)+2c(n)+a(n-2) 四格分解；
  d_rim(n) = a(n)+c(n)（列旋转共轭）；d_spoke(n) = p(n)-a(n-1)（Phase 0 分割
  + 同构）；归纳桥走强归纳 + aspoke/arim 自身 R4（ℤ）。库件 G0 全部经 kernel
  预核验（本文件编译即复验）。
- 战术承 r1/r2 模板：rfl 桥（Fin.val_mk / pair 投影）、omega 断原子先放桥、
  membership 经 `eset_mem_mk`/`lad_adj_iff`/`disjoint_esupp_iff` 线性化。
- n 一律写成 m+3（Fin (m+3) 上字面量 1 与算术实例可用；Fin n 一般形无
  OfNat 实例，r1/r2 同款移位口径）。
-/

open SimpleGraph Finset

-- ===== 基座 def（逐字拷自冻结快照 formalized/statement.lean，勿改） =====

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

namespace PrismR3

/-! ## §0 小工具（Fin 2 行算术 / Fin (m+3) 模加一 / wrap 边） -/

-- Fin 2 行算术（全枚举 decide）
theorem one_sub_val : ∀ r : Fin 2, ((1 - r : Fin 2) : ℕ) = 1 - (r : ℕ) := by decide
theorem one_sub_ne : ∀ r s : Fin 2, r ≠ s → (1 - r : Fin 2) ≠ 1 - s := by decide
theorem one_sub_eq_one : ∀ r : Fin 2, ((1 - r : Fin 2) : ℕ) = 1 ↔ r = 0 := by decide
theorem one_sub_eq_zero : ∀ r : Fin 2, ((1 - r : Fin 2) : ℕ) = 0 ↔ r = 1 := by decide

-- Fin (m+3) 加一（含环绕）的 val 字符化
theorem fin_add_one_val (m : ℕ) (u v : Fin (m+3)) :
    v = u + 1 ↔ (v : ℕ) = (u:ℕ) + 1 ∨ ((u:ℕ) = m + 2 ∧ (v:ℕ) = 0) := by
  constructor
  · intro h
    have hc := congrArg Fin.val h
    rw [Fin.val_add, Fin.val_one] at hc
    rcases Nat.lt_or_ge ((u:ℕ) + 1) (m + 3) with hlt | hge
    · rw [Nat.mod_eq_of_lt hlt] at hc
      exact Or.inl hc
    · have hu : (u:ℕ) = m + 2 := by omega
      have hmod : ((u:ℕ) + 1) % (m + 3) = 0 := by
        rw [show (u:ℕ) + 1 = m + 3 from by omega]
        exact Nat.mod_self _
      rw [hmod] at hc
      exact Or.inr ⟨hu, hc⟩
  · rintro (h | ⟨hu, hv⟩)
    · apply Fin.val_injective
      rw [Fin.val_add, Fin.val_one]
      rw [show ((u:ℕ) + 1) % (m + 3) = (u:ℕ) + 1 from Nat.mod_eq_of_lt (by omega)]
      exact h
    · apply Fin.val_injective
      rw [Fin.val_add, Fin.val_one]
      rw [show ((u:ℕ) + 1) % (m + 3) = 0 from by
        rw [show (u:ℕ) + 1 = m + 3 from by omega]; exact Nat.mod_self _]
      exact hv

/-- 环图 vs 路图二分：cycleGraph (m+3) 的邻接 = 路邻接 ∪ 环绕边（val 口径）。 -/
theorem cyc_path (m : ℕ) (u v : Fin (m+3)) :
    (cycleGraph (m+3)).Adj u v ↔ (pathGraph (m+3)).Adj u v ∨
      ((u:ℕ) = m + 2 ∧ (v:ℕ) = 0) ∨ ((u:ℕ) = 0 ∧ (v:ℕ) = m + 2) := by
  rw [cycleGraph_adj_iff_succ, pathGraph_adj, fin_add_one_val m u v, fin_add_one_val m v u]
  constructor
  · rintro ((h | ⟨h1, h2⟩) | (h | ⟨h1, h2⟩))
    · exact Or.inl (Or.inl (by omega))
    · exact Or.inr (Or.inl ⟨h1, h2⟩)
    · exact Or.inl (Or.inr (by omega))
    · exact Or.inr (Or.inr ⟨h2, h1⟩)
  · rintro ((h | h) | ⟨h1, h2⟩ | ⟨h1, h2⟩)
    · exact Or.inl (Or.inl (by omega))
    · exact Or.inr (Or.inl (by omega))
    · exact Or.inl (Or.inr ⟨h1, h2⟩)
    · exact Or.inr (Or.inr ⟨h2, h1⟩)

theorem cyc_of_path (m : ℕ) (u v : Fin (m+3)) (h : (pathGraph (m+3)).Adj u v) :
    (cycleGraph (m+3)).Adj u v := (cyc_path m u v).mpr (Or.inl h)

theorem cyc_wrap_0 (m : ℕ) :
    (cycleGraph (m+3)).Adj (⟨m+2, by omega⟩ : Fin (m+3)) (⟨0, by omega⟩ : Fin (m+3)) := by
  refine (cyc_path m _ _).mpr (Or.inr (Or.inl ⟨?_, ?_⟩))
  · exact rfl
  · exact rfl

theorem cyc_wrap_1 (m : ℕ) :
    (cycleGraph (m+3)).Adj (⟨0, by omega⟩ : Fin (m+3)) (⟨m+2, by omega⟩ : Fin (m+3)) := by
  refine (cyc_path m _ _).mpr (Or.inr (Or.inr ⟨?_, ?_⟩))
  · exact rfl
  · exact rfl

theorem top_val (m : ℕ) : ((⟨m+2, by omega⟩ : Fin (m+3)) : ℕ) = m + 2 := rfl
theorem zero_val (m : ℕ) : ((⟨0, by omega⟩ : Fin (m+3)) : ℕ) = 0 := rfl

/-- 环绕 rim 边：第 m+2 列 ~ 第 0 列，行 j。 -/
def wE (m : ℕ) (j : Fin 2) : Sym2 (Fin (m+3) × Fin 2) :=
  s((⟨m+2, by omega⟩, j), (⟨0, by omega⟩, j))

theorem f2_01 : (0 : Fin 2) ≠ (1 : Fin 2) := by decide

theorem wE_nondisj (m : ℕ) (j : Fin 2) :
    ¬ Disjoint (edgeSupp (wE m j)) (edgeSupp (wE m j)) := by
  intro h
  have h4 := (disjoint_esupp_iff ((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2)
    ((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2)
    ((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2)
    ((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2)).mp h
  exact h4.1 rfl

theorem wE_ne (m : ℕ) : wE m 0 ≠ wE m 1 := by
  intro h
  simp only [wE] at h
  rw [Sym2.eq_iff] at h
  rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact absurd (congrArg Prod.snd h1) f2_01
  · have hf : (⟨m+2, by omega⟩ : Fin (m+3)) = (⟨0, by omega⟩ : Fin (m+3)) :=
      congrArg Prod.fst h1
    have hv : ((⟨m+2, by omega⟩ : Fin (m+3)) : ℕ) = ((⟨0, by omega⟩ : Fin (m+3)) : ℕ) :=
      congrArg Fin.val hf
    rw [top_val, zero_val] at hv
    omega

theorem wE_not_mem_Eset (m : ℕ) (j : Fin 2) : wE m j ∉ Eset (m+3) (m+3) := by
  intro h
  have hadj := (eset_mem_mk ((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2)
    ((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2)).mp h
  have h1 := hadj.1
  rw [lad_adj_iff] at h1
  rcases h1 with ⟨hc, hr⟩ | ⟨hr, hc⟩
  · have hA : (((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = m + 2 := rfl
    have hB : (((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = 0 := rfl
    have hv := congrArg Fin.val hc
    rw [hA, hB] at hv
    omega
  · rcases hc with hc | hc
    · have hA : (((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = m + 2 := rfl
      have hB : (((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = 0 := rfl
      rw [hA, hB] at hc
      omega
    · have hA : (((⟨m+2, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = m + 2 := rfl
      have hB : (((⟨0, by omega⟩, j) : Fin (m+3) × Fin 2).1 : ℕ) = 0 := rfl
      rw [hA, hB] at hc
      omega

/-- Eset (m+3) (m+3) 的成员资格 = 梯子邻接（列界自动成立）。 -/
theorem esetNN (m : ℕ) (a b : Fin (m+3) × Fin 2) :
    s(a, b) ∈ Eset (m+3) (m+3) ↔ (pathGraph (m+3) □ pathGraph 2).Adj a b := by
  rw [eset_mem_mk]
  exact ⟨fun h => h.1, fun h => ⟨h, a.1.isLt, b.1.isLt⟩⟩

/-- Cst (m+3) (m+3) 的成员资格线性化（r2 §1 口径）。 -/
theorem cstNN (m : ℕ) (a b : Fin (m+3) × Fin 2) :
    s(a, b) ∈ PrismR2.Cst (m+3) (m+3) ↔ (pathGraph (m+3) □ pathGraph 2).Adj a b ∧
      ((a.2 : ℕ) = 1 ∨ 1 ≤ (a.1 : ℕ) ∧ (a.1 : ℕ) + 2 ≤ m + 3) ∧
      ((b.2 : ℕ) = 1 ∨ 1 ≤ (b.1 : ℕ) ∧ (b.1 : ℕ) + 2 ≤ m + 3) := by
  simp only [PrismR2.Cst, Finset.mem_filter, PrismR2.filt2, esetNN]

/-- 与 wE 的 disjoint 条件（列/行线性口径）。 -/
theorem disj_wE_iff (m : ℕ) (j : Fin 2) (a b : Fin (m+3) × Fin 2) :
    Disjoint (edgeSupp (s(a, b))) (edgeSupp (wE m j)) ↔
      ((a.1 : ℕ) ≠ m + 2 ∨ a.2 ≠ j) ∧ ((a.1 : ℕ) ≠ 0 ∨ a.2 ≠ j) ∧
      ((b.1 : ℕ) ≠ m + 2 ∨ b.2 ≠ j) ∧ ((b.1 : ℕ) ≠ 0 ∨ b.2 ≠ j) := by
  have h := disjoint_esupp_iff a b (⟨m+2, by omega⟩, j) (⟨0, by omega⟩, j)
  constructor
  · intro hd
    obtain ⟨h1, h2, h3, h4⟩ := h.mp hd
    refine ⟨?_, ?_, ?_, ?_⟩
    · simpa only [top_val] using PrismR2.ne_to_col _ _ _ h1
    · simpa only [zero_val] using PrismR2.ne_to_col _ _ _ h2
    · simpa only [top_val] using PrismR2.ne_to_col _ _ _ h3
    · simpa only [zero_val] using PrismR2.ne_to_col _ _ _ h4
  · rintro ⟨h1, h2, h3, h4⟩
    refine h.mpr ⟨?_, ?_, ?_, ?_⟩
    · exact PrismR2.col_to_ne _ _ _ (by simpa only [top_val] using h1)
    · exact PrismR2.col_to_ne _ _ _ (by simpa only [zero_val] using h2)
    · exact PrismR2.col_to_ne _ _ _ (by simpa only [top_val] using h3)
    · exact PrismR2.col_to_ne _ _ _ (by simpa only [zero_val] using h4)

/-! ## §0b 三个结构映射：swapv（行翻转对合）/ rotv（列旋转）/ shEmb（列平移） -/

/-- 行翻转对合。 -/
def swapv {N : ℕ} (v : Fin N × Fin 2) : Fin N × Fin 2 := (v.1, 1 - v.2)

theorem swapv_inv {N : ℕ} (v : Fin N × Fin 2) : swapv (swapv v) = v := by
  have hkey : (1 - (1 - v.2) : Fin 2) = v.2 := by
    rcases fin2_ex v.2 with h | h <;> rw [h] <;> rfl
  show (v.1, 1 - (1 - v.2)) = v
  rw [hkey]

theorem swapv_inj {N : ℕ} : Function.Injective (swapv : Fin N × Fin 2 → Fin N × Fin 2) := by
  intro v v' h
  have h2 : swapv (swapv v) = swapv (swapv v') := by rw [h]
  rw [swapv_inv, swapv_inv] at h2
  exact h2

theorem swapv_fst {N : ℕ} (v : Fin N × Fin 2) : (swapv v).1 = v.1 := rfl
theorem swapv_fst_val {N : ℕ} (v : Fin N × Fin 2) : ((swapv v).1 : ℕ) = (v.1 : ℕ) := rfl
theorem swapv_snd_val {N : ℕ} (v : Fin N × Fin 2) : ((swapv v).2 : ℕ) = 1 - (v.2 : ℕ) :=
  one_sub_val v.2

/-- 列旋转（+1 mod m+3），行不变。 -/
def rotv (m : ℕ) (v : Fin (m+3) × Fin 2) : Fin (m+3) × Fin 2 := (v.1 + 1, v.2)

theorem rotv_val_lt (m : ℕ) (v : Fin (m+3) × Fin 2) (h : (v.1 : ℕ) + 1 < m + 3) :
    ((rotv m v).1 : ℕ) = (v.1 : ℕ) + 1 := by
  show (((v.1 + 1 : Fin (m+3))) : ℕ) = (v.1 : ℕ) + 1
  rw [Fin.val_add, Fin.val_one]
  exact Nat.mod_eq_of_lt h

theorem rotv_val_top (m : ℕ) (v : Fin (m+3) × Fin 2) (h : (v.1 : ℕ) = m + 2) :
    ((rotv m v).1 : ℕ) = 0 := by
  show (((v.1 + 1 : Fin (m+3))) : ℕ) = 0
  rw [Fin.val_add, Fin.val_one]
  have hmod : ((v.1 : ℕ) + 1) % (m + 3) = 0 := by
    rw [show (v.1 : ℕ) + 1 = m + 3 from by omega]
    exact Nat.mod_self _
  rw [hmod]

theorem rotv_row (m : ℕ) (v : Fin (m+3) × Fin 2) : (rotv m v).2 = v.2 := rfl

theorem rotv_inj (m : ℕ) : Function.Injective (rotv m) := by
  intro v v' h
  have hrow : (rotv m v).2 = (rotv m v').2 := congrArg (fun p : Fin (m+3) × Fin 2 => p.2) h
  have hcol0 : (rotv m v).1 = (rotv m v').1 := congrArg (fun p : Fin (m+3) × Fin 2 => p.1) h
  have ha : (rotv m v).1 = v.1 + 1 := rfl
  have hb : (rotv m v').1 = v'.1 + 1 := rfl
  rw [ha, hb] at hcol0
  have hval := congrArg Fin.val hcol0
  rw [Fin.val_add, Fin.val_one, Fin.val_add, Fin.val_one] at hval
  have hv : (v.1 : ℕ) < m + 3 := v.1.isLt
  have hv' : (v'.1 : ℕ) < m + 3 := v'.1.isLt
  have hcc : (v.1 : ℕ) = (v'.1 : ℕ) := by
    rcases Nat.lt_or_ge ((v.1 : ℕ) + 1) (m + 3) with h1 | h1
    · rcases Nat.lt_or_ge ((v'.1 : ℕ) + 1) (m + 3) with h2 | h2
      · rw [Nat.mod_eq_of_lt h1, Nat.mod_eq_of_lt h2] at hval
        omega
      · rw [Nat.mod_eq_of_lt h1] at hval
        have hmod : ((v'.1 : ℕ) + 1) % (m + 3) = 0 := by
          rw [show (v'.1 : ℕ) + 1 = m + 3 from by omega]
          exact Nat.mod_self _
        rw [hmod] at hval
        omega
    · rcases Nat.lt_or_ge ((v'.1 : ℕ) + 1) (m + 3) with h2 | h2
      · rw [Nat.mod_eq_of_lt h2] at hval
        have hmod : ((v.1 : ℕ) + 1) % (m + 3) = 0 := by
          rw [show (v.1 : ℕ) + 1 = m + 3 from by omega]
          exact Nat.mod_self _
        rw [hmod] at hval
        omega
      · have hmod1 : ((v.1 : ℕ) + 1) % (m + 3) = 0 := by
          rw [show (v.1 : ℕ) + 1 = m + 3 from by omega]
          exact Nat.mod_self _
        have hmod2 : ((v'.1 : ℕ) + 1) % (m + 3) = 0 := by
          rw [show (v'.1 : ℕ) + 1 = m + 3 from by omega]
          exact Nat.mod_self _
        rw [hmod1, hmod2] at hval
        omega
  exact Prod.ext_iff.mpr ⟨Fin.val_injective hcc, by exact hrow⟩

/-- 列平移嵌入（col ↦ col+1）：Fin (m+1) × Fin 2 → Fin (m+3) × Fin 2。 -/
def shEmb (m : ℕ) (v : Fin (m+1) × Fin 2) : Fin (m+3) × Fin 2 :=
  (⟨(v.1 : ℕ) + 1, by omega⟩, v.2)

theorem shEmb_inj (m : ℕ) : Function.Injective (shEmb m) := by
  intro v v' h
  have hrow : (shEmb m v).2 = (shEmb m v').2 := by rw [h]
  have hcol : ((shEmb m v).1 : ℕ) = ((shEmb m v').1 : ℕ) := by rw [h]
  have hA : ((shEmb m v).1 : ℕ) = (v.1 : ℕ) + 1 := rfl
  have hB : ((shEmb m v').1 : ℕ) = (v'.1 : ℕ) + 1 := rfl
  rw [hA, hB] at hcol
  have hv : (v.1 : ℕ) < m + 1 := v.1.isLt
  have hv' : (v'.1 : ℕ) < m + 1 := v'.1.isLt
  exact Prod.ext_iff.mpr ⟨Fin.val_injective (by omega), by exact hrow⟩

theorem shEmb_val (m : ℕ) (v : Fin (m+1) × Fin 2) :
    ((shEmb m v).1 : ℕ) = (v.1 : ℕ) + 1 := rfl
theorem shEmb_row (m : ℕ) (v : Fin (m+1) × Fin 2) : (shEmb m v).2 = v.2 := rfl

/-- emb 单射（r1 transp 证明体内嵌的核验件，抽出复用）。 -/
theorem emb_inj {N k : ℕ} (hk : k ≤ N) : Function.Injective (emb hk) := by
  intro v v' h
  have h1 : (⟨(v.1 : ℕ), by omega⟩ : Fin N) = (⟨(v'.1 : ℕ), by omega⟩ : Fin N) :=
    congrArg Prod.fst h
  have hv : v.1 = v'.1 := by
    apply Fin.val_injective
    show (v.1 : ℕ) = (v'.1 : ℕ)
    exact congrArg (fun i : Fin N => (i : ℕ)) h1
  have hs : (emb hk v).2 = (emb hk v').2 := congrArg (fun p : Fin N × Fin 2 => p.2) h
  exact Prod.ext_iff.mpr ⟨hv, hs⟩

/-! ## §1 T4a：棱柱边集两分类（梯子边集 + 双环绕 rim 边） -/

theorem s_eq_wE_iff (m : ℕ) (j : Fin 2) (a b : Fin (m+3) × Fin 2) :
    s(a, b) = wE m j ↔
      (a = (⟨m+2, by omega⟩, j) ∧ b = (⟨0, by omega⟩, j)) ∨
      (a = (⟨0, by omega⟩, j) ∧ b = (⟨m+2, by omega⟩, j)) := by
  simp only [wE, Sym2.eq_iff]

theorem s_eq_wE_of (m : ℕ) (j : Fin 2) (a b : Fin (m+3) × Fin 2)
    (ha : (a.1 : ℕ) = m + 2) (hb : (b.1 : ℕ) = 0) (hja : a.2 = j) (hjb : b.2 = j) :
    s(a, b) = wE m j := by
  rw [s_eq_wE_iff]
  exact Or.inl ⟨Prod.ext_iff.mpr ⟨Fin.val_injective ha, hja⟩,
    Prod.ext_iff.mpr ⟨Fin.val_injective hb, hjb⟩⟩

theorem s_eq_wE_of' (m : ℕ) (j : Fin 2) (a b : Fin (m+3) × Fin 2)
    (ha : (a.1 : ℕ) = 0) (hb : (b.1 : ℕ) = m + 2) (hja : a.2 = j) (hjb : b.2 = j) :
    s(a, b) = wE m j := by
  rw [s_eq_wE_iff]
  exact Or.inr ⟨Prod.ext_iff.mpr ⟨Fin.val_injective ha, hja⟩,
    Prod.ext_iff.mpr ⟨Fin.val_injective hb, hjb⟩⟩

theorem wE_adj_prism (m : ℕ) (j : Fin 2) :
    (prism (m+3)).Adj (⟨m+2, by omega⟩, j) (⟨0, by omega⟩, j) := by
  show (cycleGraph (m+3) □ pathGraph 2).Adj (⟨m+2, by omega⟩, j) (⟨0, by omega⟩, j)
  exact boxProd_adj.mpr (Or.inl ⟨cyc_wrap_0 m, rfl⟩)

theorem wE_adj_prism' (m : ℕ) (j : Fin 2) :
    (prism (m+3)).Adj (⟨0, by omega⟩, j) (⟨m+2, by omega⟩, j) := by
  show (cycleGraph (m+3) □ pathGraph 2).Adj (⟨0, by omega⟩, j) (⟨m+2, by omega⟩, j)
  exact boxProd_adj.mpr (Or.inl ⟨cyc_wrap_1 m, rfl⟩)

theorem wE_mem_prism (m : ℕ) (j : Fin 2) : wE m j ∈ (prism (m+3)).edgeFinset := by
  simp only [wE]
  rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
  exact wE_adj_prism m j

/-- **T4a**：棱柱边集 = Eset（梯子）∪ 双环绕。 -/
theorem prism_edges (m : ℕ) :
    (prism (m+3)).edgeFinset = Eset (m+3) (m+3) ∪ {wE m 0, wE m 1} := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  simp only [Finset.mem_union, Finset.mem_insert, Finset.mem_singleton, esetNN,
    SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
  have hb : (cycleGraph (m+3) □ pathGraph 2).Adj a b ↔
      ((cycleGraph (m+3)).Adj a.1 b.1 ∧ a.2 = b.2) ∨
      ((pathGraph 2).Adj a.2 b.2 ∧ a.1 = b.1) := boxProd_adj
  constructor
  · intro h
    have h' : (cycleGraph (m+3) □ pathGraph 2).Adj a b := h
    rcases hb.mp h' with ⟨hcyc, hrow⟩ | ⟨hp2, hcol⟩
    · rcases (cyc_path m a.1 b.1).mp hcyc with hpath | ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact Or.inl (by rw [lad_adj_iff]; exact Or.inr ⟨hrow, pathGraph_adj.mp hpath⟩)
      · rcases fin2_ex a.2 with hr | hr
        · exact Or.inr (Or.inl (s_eq_wE_of m 0 a b h1 h2 hr (hrow.symm.trans hr)))
        · exact Or.inr (Or.inr (s_eq_wE_of m 1 a b h1 h2 hr (hrow.symm.trans hr)))
      · rcases fin2_ex a.2 with hr | hr
        · exact Or.inr (Or.inl (s_eq_wE_of' m 0 a b h1 h2 hr (hrow.symm.trans hr)))
        · exact Or.inr (Or.inr (s_eq_wE_of' m 1 a b h1 h2 hr (hrow.symm.trans hr)))
    · exact Or.inl (by rw [lad_adj_iff]; exact Or.inl ⟨hcol, (p2adj a.2 b.2).mp hp2⟩)
  · rintro (hlad | hw | hw)
    · rcases (lad_adj_iff.mp hlad) with ⟨hcol, hrow⟩ | ⟨hrow, hc⟩
      · exact boxProd_adj.mpr (Or.inr ⟨(p2adj a.2 b.2).mpr hrow, hcol⟩)
      · exact boxProd_adj.mpr (Or.inl ⟨cyc_of_path m a.1 b.1 (pathGraph_adj.mpr hc), hrow⟩)
    · rw [s_eq_wE_iff] at hw
      rcases hw with ⟨ha, hb2⟩ | ⟨ha, hb2⟩
      · rw [ha, hb2]; exact wE_adj_prism m 0
      · rw [ha, hb2]; exact wE_adj_prism' m 0
    · rw [s_eq_wE_iff] at hw
      rcases hw with ⟨ha, hb2⟩ | ⟨ha, hb2⟩
      · rw [ha, hb2]; exact wE_adj_prism m 1
      · rw [ha, hb2]; exact wE_adj_prism' m 1

theorem hosoya_prism_mc (m : ℕ) :
    hosoya (prism (m+3)) = matchCount (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) := by
  rw [hosoya_matchCount, prism_edges]

/-! ## §2 T4b 四格 cell 引理 -/

theorem f2_val0 : ∀ j : Fin 2, (j : ℕ) = 0 → j = 0 := by decide
theorem f2_val1 : ∀ j : Fin 2, (j : ℕ) = 1 → j = 1 := by decide
theorem f2_val_cases : ∀ j : Fin 2, (j : ℕ) = 0 ∨ (j : ℕ) = 1 := by decide
theorem f2_ne01 : ∀ j : Fin 2, (j : ℕ) = 1 → j ≠ 0 := by decide
theorem f2_ne10 : ∀ j : Fin 2, (j : ℕ) = 0 → j ≠ 1 := by decide
theorem one_sub_inj : ∀ r s : Fin 2, (1 - r : Fin 2) = 1 - s → r = s := by decide

theorem lad_adj_swap {N : ℕ} (x y : Fin N × Fin 2) :
    (pathGraph N □ pathGraph 2).Adj (swapv x) (swapv y) ↔
      (pathGraph N □ pathGraph 2).Adj x y := by
  rw [lad_adj_iff, lad_adj_iff]
  constructor
  · rintro (⟨hcol, hr⟩ | ⟨hrow, hc⟩)
    · exact Or.inl ⟨hcol, fun h => hr (congrArg (fun j : Fin 2 => 1 - j) h)⟩
    · exact Or.inr ⟨one_sub_inj x.2 y.2 hrow, hc⟩
  · rintro (⟨hcol, hr⟩ | ⟨hrow, hc⟩)
    · exact Or.inl ⟨hcol, fun h => hr (one_sub_inj x.2 y.2 h)⟩
    · exact Or.inr ⟨congrArg (fun j : Fin 2 => 1 - j) hrow, hc⟩

/-- **cell C2'（T4b·Eset 格）**：Eset 过滤 wE0-不相交格 = Cst。 -/
theorem cell_wE0 (m : ℕ) :
    (Eset (m+3) (m+3)).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 0))) =
      PrismR2.Cst (m+3) (m+3) := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  simp only [Finset.mem_filter, esetNN, cstNN, disj_wE_iff m 0 a b]
  have hais : (a.1 : ℕ) < m + 3 := a.1.isLt
  have hbis : (b.1 : ℕ) < m + 3 := b.1.isLt
  constructor
  · rintro ⟨hadj, h1, h2, h3, h4⟩
    refine ⟨hadj, ?_, ?_⟩
    · rcases f2_val_cases a.2 with hva | hva
      · refine Or.inr ⟨?_, ?_⟩
        · rcases h2 with h | h
          · omega
          · exact absurd (f2_val0 a.2 hva) h
        · rcases h1 with h | h
          · omega
          · exact absurd (f2_val0 a.2 hva) h
      · exact Or.inl hva
    · rcases f2_val_cases b.2 with hvb | hvb
      · refine Or.inr ⟨?_, ?_⟩
        · rcases h4 with h | h
          · omega
          · exact absurd (f2_val0 b.2 hvb) h
        · rcases h3 with h | h
          · omega
          · exact absurd (f2_val0 b.2 hvb) h
      · exact Or.inl hvb
  · rintro ⟨hadj, hqa, hqb⟩
    refine ⟨hadj, ?_, ?_, ?_, ?_⟩
    · rcases f2_val_cases a.2 with hva | hva
      · rcases hqa with hq | hq <;> omega
      · exact Or.inr (f2_ne01 a.2 hva)
    · rcases f2_val_cases a.2 with hva | hva
      · rcases hqa with hq | hq <;> omega
      · exact Or.inr (f2_ne01 a.2 hva)
    · rcases f2_val_cases b.2 with hvb | hvb
      · rcases hqb with hq | hq <;> omega
      · exact Or.inr (f2_ne01 b.2 hvb)
    · rcases f2_val_cases b.2 with hvb | hvb
      · rcases hqb with hq | hq <;> omega
      · exact Or.inr (f2_ne01 b.2 hvb)

theorem f2_flip_ne1 {N : ℕ} (a x : Fin N × Fin 2) (h : (a.2 : ℕ) = 1 - (x.2 : ℕ))
    (hv : (x.2 : ℕ) = 1) : a.2 ≠ (1 : Fin 2) := by
  intro hcon
  have hva : (a.2 : ℕ) = 1 := by rw [hcon]; rfl
  omega

theorem f2_flip_ne1' {N : ℕ} (a x : Fin N × Fin 2) (h : (a.2 : ℕ) = 1 - (x.2 : ℕ))
    (hv : (x.2 : ℕ) = 0) : a.2 ≠ 0 := by
  intro hcon
  have hva : (a.2 : ℕ) = 0 := by rw [hcon]; rfl
  omega

/-- **cell C1（T4b·Eset 格）**：Eset 过滤 wE1-不相交格 = Cst 的行翻转像。 -/
theorem cell_wE1 (m : ℕ) :
    (Eset (m+3) (m+3)).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) =
      (PrismR2.Cst (m+3) (m+3)).image
        (Sym2.map (swapv : Fin (m+3) × Fin 2 → Fin (m+3) × Fin 2)) := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  simp only [Finset.mem_filter, Finset.mem_image, esetNN]
  constructor
  · intro h
    have hadj := h.1
    obtain ⟨h1, h2, h3, h4⟩ := (disj_wE_iff m 1 a b).mp h.2
    refine ⟨s(swapv a, swapv b), ?_, ?_⟩
    · rw [cstNN]
      refine ⟨(lad_adj_swap a b).mpr hadj, ?_, ?_⟩
      · rcases f2_val_cases a.2 with hva | hva
        · exact Or.inl (by have := swapv_snd_val a; omega)
        · refine Or.inr ⟨?_, ?_⟩
          · rcases h2 with h | h
            · have := swapv_fst_val a; omega
            · exact absurd (f2_val1 a.2 hva) h
          · rcases h1 with h | h
            · have := swapv_fst_val a; have := a.1.isLt; omega
            · exact absurd (f2_val1 a.2 hva) h
      · rcases f2_val_cases b.2 with hvb | hvb
        · exact Or.inl (by have := swapv_snd_val b; omega)
        · refine Or.inr ⟨?_, ?_⟩
          · rcases h4 with h | h
            · have := swapv_fst_val b; omega
            · exact absurd (f2_val1 b.2 hvb) h
          · rcases h3 with h | h
            · have := swapv_fst_val b; have := b.1.isLt; omega
            · exact absurd (f2_val1 b.2 hvb) h
    · rw [Sym2.map_mk, swapv_inv, swapv_inv]
  · rintro ⟨e', he', hmap⟩
    induction e' using Sym2.ind with
    | _ x y =>
    rw [Sym2.map_mk, Sym2.eq_iff] at hmap
    obtain ⟨hadj, hqx, hqy⟩ := (cstNN m x y).mp he'
    rcases hmap with ⟨hsa, hsb⟩ | ⟨hsb, hsa⟩
    · have hA : a = swapv x := hsa.symm
      have hB : b = swapv y := hsb.symm
      subst hA
      subst hB
      have ha1 : ((swapv x).1 : ℕ) = (x.1 : ℕ) := swapv_fst_val x
      have ha2 : ((swapv x).2 : ℕ) = 1 - (x.2 : ℕ) := swapv_snd_val x
      have hb1 : ((swapv y).1 : ℕ) = (y.1 : ℕ) := swapv_fst_val y
      have hb2 : ((swapv y).2 : ℕ) = 1 - (y.2 : ℕ) := swapv_snd_val y
      refine ⟨(lad_adj_swap x y).mpr hadj, (disj_wE_iff m 1 (swapv x) (swapv y)).mpr ⟨?_, ?_, ?_, ?_⟩⟩
      · rcases f2_val_cases x.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv x) x ha2 hv)
      · rcases f2_val_cases x.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv x) x ha2 hv)
      · rcases f2_val_cases y.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv y) y hb2 hv)
      · rcases f2_val_cases y.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv y) y hb2 hv)
    · have hA : a = swapv y := hsa.symm
      have hB : b = swapv x := hsb.symm
      subst hA
      subst hB
      have ha1 : ((swapv y).1 : ℕ) = (y.1 : ℕ) := swapv_fst_val y
      have ha2 : ((swapv y).2 : ℕ) = 1 - (y.2 : ℕ) := swapv_snd_val y
      have hb1 : ((swapv x).1 : ℕ) = (x.1 : ℕ) := swapv_fst_val x
      have hb2 : ((swapv x).2 : ℕ) = 1 - (x.2 : ℕ) := swapv_snd_val x
      refine ⟨((lad_adj_swap x y).mpr hadj).symm, (disj_wE_iff m 1 (swapv y) (swapv x)).mpr ⟨?_, ?_, ?_, ?_⟩⟩
      · rcases f2_val_cases y.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv y) y ha2 hv)
      · rcases f2_val_cases y.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv y) y ha2 hv)
      · rcases f2_val_cases x.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv x) x hb2 hv)
      · rcases f2_val_cases x.2 with hv | hv
        · left; omega
        · exact Or.inr (f2_flip_ne1 (swapv x) x hb2 hv)

theorem eset_full (N : ℕ) (a b : Fin N × Fin 2) :
    s(a, b) ∈ Eset N N ↔ (pathGraph N □ pathGraph 2).Adj a b := by
  rw [eset_mem_mk]
  exact ⟨fun h => h.1, fun h => ⟨h, a.1.isLt, b.1.isLt⟩⟩

/-- omega 断原子桥（↑v.1 投影原子 omega 不直接连，先抽象成纯 ℕ 变量）。 -/
theorem sub_lt_aux (m c : ℕ) (h1 : 1 ≤ c) (h2 : c ≤ m + 1) : c - 1 < m + 1 := by omega

/-- 列前移一格（col ↦ col-1）的预像函数（1 ≤ col ≤ m+1）。 -/
def vpred (m : ℕ) (v : Fin (m+3) × Fin 2) (h : 1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) ≤ m + 1) :
    Fin (m+1) × Fin 2 :=
  (⟨(v.1 : ℕ) - 1, sub_lt_aux m (v.1 : ℕ) h.1 h.2⟩, v.2)

theorem vpred_fst_val (m : ℕ) (v : Fin (m+3) × Fin 2) (h : 1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) ≤ m + 1) :
    ((vpred m v h).1 : ℕ) = (v.1 : ℕ) - 1 := rfl
theorem vpred_snd (m : ℕ) (v : Fin (m+3) × Fin 2) (h : 1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) ≤ m + 1) :
    (vpred m v h).2 = v.2 := rfl

theorem cst_bound (m : ℕ) (v : Fin (m+3) × Fin 2)
    (hq : (v.2 : ℕ) = 1 ∨ 1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) + 2 ≤ m + 3)
    (hc1 : (v.1 : ℕ) ≠ m + 2 ∨ v.2 ≠ (1 : Fin 2))
    (hc2 : (v.1 : ℕ) ≠ 0 ∨ v.2 ≠ (1 : Fin 2)) :
    1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) ≤ m + 1 := by
  have his := v.1.isLt
  rcases f2_val_cases v.2 with hv | hv
  · rcases hq with hq' | hq' <;> omega
  · rcases hc1 with h | h
    · rcases hc2 with h' | h'
      · omega
      · exact absurd (f2_val1 v.2 hv) h'
    · exact absurd (f2_val1 v.2 hv) h

theorem lad_adj_pred (m : ℕ) (a b : Fin (m+3) × Fin 2)
    (ha : 1 ≤ (a.1 : ℕ) ∧ (a.1 : ℕ) ≤ m + 1) (hb : 1 ≤ (b.1 : ℕ) ∧ (b.1 : ℕ) ≤ m + 1) :
    (pathGraph (m+1) □ pathGraph 2).Adj (vpred m a ha) (vpred m b hb) ↔
      (pathGraph (m+3) □ pathGraph 2).Adj a b := by
  rw [lad_adj_iff, lad_adj_iff]
  have hxa : ((vpred m a ha).1 : ℕ) = (a.1 : ℕ) - 1 := rfl
  have hxb : ((vpred m b hb).1 : ℕ) = (b.1 : ℕ) - 1 := rfl
  constructor
  · rintro (⟨hc, hr⟩ | ⟨hr, hc⟩)
    · refine Or.inl ⟨?_, hr⟩
      apply Fin.val_injective
      have hcv : (a.1 : ℕ) - 1 = (b.1 : ℕ) - 1 := congrArg Fin.val hc
      omega
    · refine Or.inr ⟨hr, ?_⟩
      rcases hc with hc | hc
      · left; omega
      · right; omega
  · rintro (⟨hc, hr⟩ | ⟨hr, hc⟩)
    · refine Or.inl ⟨?_, hr⟩
      apply Fin.val_injective
      have hcv : (a.1 : ℕ) = (b.1 : ℕ) := congrArg Fin.val hc
      omega
    · refine Or.inr ⟨hr, ?_⟩
      rcases hc with hc | hc
      · left; omega
      · right; omega

theorem shEmb_vpred (m : ℕ) (v : Fin (m+3) × Fin 2) (h : 1 ≤ (v.1 : ℕ) ∧ (v.1 : ℕ) ≤ m + 1) :
    shEmb m (vpred m v h) = v := by
  have hval : ((shEmb m (vpred m v h)).1 : ℕ) = (v.1 : ℕ) := by
    show ((vpred m v h).1 : ℕ) + 1 = (v.1 : ℕ)
    have hx : ((vpred m v h).1 : ℕ) = (v.1 : ℕ) - 1 := rfl
    omega
  exact Prod.ext_iff.mpr ⟨Fin.val_injective hval, rfl⟩

theorem shEmb_row_val (m : ℕ) (v : Fin (m+1) × Fin 2) : ((shEmb m v).2 : ℕ) = (v.2 : ℕ) := rfl

theorem lad_adj_emb (m : ℕ) (x y : Fin (m+1) × Fin 2) :
    (pathGraph (m+3) □ pathGraph 2).Adj (shEmb m x) (shEmb m y) ↔
      (pathGraph (m+1) □ pathGraph 2).Adj x y := by
  rw [lad_adj_iff, lad_adj_iff]
  have hxa : ((shEmb m x).1 : ℕ) = (x.1 : ℕ) + 1 := rfl
  have hxb : ((shEmb m y).1 : ℕ) = (y.1 : ℕ) + 1 := rfl
  have hx : (x.1 : ℕ) < m + 1 := x.1.isLt
  have hy : (y.1 : ℕ) < m + 1 := y.1.isLt
  constructor
  · rintro (⟨hc, hr⟩ | ⟨hr, hc⟩)
    · refine Or.inl ⟨?_, hr⟩
      apply Fin.val_injective
      have hcv : ((shEmb m x).1 : ℕ) = ((shEmb m y).1 : ℕ) := congrArg Fin.val hc
      omega
    · refine Or.inr ⟨hr, ?_⟩
      rcases hc with hc | hc
      · left; omega
      · right; omega
  · rintro (⟨hc, hr⟩ | ⟨hr, hc⟩)
    · refine Or.inl ⟨?_, hr⟩
      apply Fin.val_injective
      have hcv : (x.1 : ℕ) = (y.1 : ℕ) := congrArg Fin.val hc
      omega
    · refine Or.inr ⟨hr, ?_⟩
      rcases hc with hc | hc
      · left; omega
      · right; omega

/-- **cell C3（T4b·Cst 格）**：Cst 过滤 wE1-不相交格 = 列平移梯子像。 -/
theorem cell_C3 (m : ℕ) :
    (PrismR2.Cst (m+3) (m+3)).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) =
      (Eset (m+1) (m+1)).image (Sym2.map (shEmb m)) := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  simp only [Finset.mem_filter, Finset.mem_image, cstNN]
  constructor
  · rintro ⟨⟨hadj, hqa, hqb⟩, hdisj⟩
    obtain ⟨h1, h2, h3, h4⟩ := (disj_wE_iff m 1 a b).mp hdisj
    obtain ⟨hal, har⟩ := cst_bound m a hqa h1 h2
    obtain ⟨hbl, hbr⟩ := cst_bound m b hqb h3 h4
    refine ⟨s(vpred m a ⟨hal, har⟩, vpred m b ⟨hbl, hbr⟩), ?_, ?_⟩
    · rw [eset_full]
      exact (lad_adj_pred m a b ⟨hal, har⟩ ⟨hbl, hbr⟩).mpr hadj
    · rw [Sym2.map_mk, Sym2.eq_iff]
      exact Or.inl ⟨shEmb_vpred m a ⟨hal, har⟩, shEmb_vpred m b ⟨hbl, hbr⟩⟩
  · rintro ⟨e', he', hmap⟩
    induction e' using Sym2.ind with
    | _ x y =>
    rw [Sym2.map_mk, Sym2.eq_iff] at hmap
    have hadj := (eset_full (m+1) x y).mp he'
    rcases hmap with ⟨hsa, hsb⟩ | ⟨hsb, hsa⟩
    · have hA : a = shEmb m x := hsa.symm
      have hB : b = shEmb m y := hsb.symm
      subst hA
      subst hB
      have hxa : ((shEmb m x).1 : ℕ) = (x.1 : ℕ) + 1 := rfl
      have hxb : ((shEmb m y).1 : ℕ) = (y.1 : ℕ) + 1 := rfl
      have hx2 : ((shEmb m x).2 : ℕ) = (x.2 : ℕ) := rfl
      have hy2 : ((shEmb m y).2 : ℕ) = (y.2 : ℕ) := rfl
      have hx : (x.1 : ℕ) < m + 1 := x.1.isLt
      have hy : (y.1 : ℕ) < m + 1 := y.1.isLt
      refine ⟨⟨(lad_adj_emb m x y).mpr hadj, ?_, ?_⟩,
        (disj_wE_iff m 1 (shEmb m x) (shEmb m y)).mpr ⟨?_, ?_, ?_, ?_⟩⟩
      · rcases f2_val_cases x.2 with hv | hv
        · refine Or.inr ⟨?_, ?_⟩
          · omega
          · omega
        · exact Or.inl (by omega)
      · rcases f2_val_cases y.2 with hv | hv
        · refine Or.inr ⟨?_, ?_⟩
          · omega
          · omega
        · exact Or.inl (by omega)
      · rcases f2_val_cases x.2 with hv | hv
        · exact Or.inr (f2_ne10 x.2 hv)
        · left; omega
      · rcases f2_val_cases x.2 with hv | hv
        · exact Or.inr (f2_ne10 x.2 hv)
        · left; omega
      · rcases f2_val_cases y.2 with hv | hv
        · exact Or.inr (f2_ne10 y.2 hv)
        · left; omega
      · rcases f2_val_cases y.2 with hv | hv
        · exact Or.inr (f2_ne10 y.2 hv)
        · left; omega
    · have hA : a = shEmb m y := hsa.symm
      have hB : b = shEmb m x := hsb.symm
      subst hA
      subst hB
      have hxa : ((shEmb m x).1 : ℕ) = (x.1 : ℕ) + 1 := rfl
      have hxb : ((shEmb m y).1 : ℕ) = (y.1 : ℕ) + 1 := rfl
      have hx2 : ((shEmb m x).2 : ℕ) = (x.2 : ℕ) := rfl
      have hy2 : ((shEmb m y).2 : ℕ) = (y.2 : ℕ) := rfl
      have hx : (x.1 : ℕ) < m + 1 := x.1.isLt
      have hy : (y.1 : ℕ) < m + 1 := y.1.isLt
      refine ⟨⟨((lad_adj_emb m x y).mpr hadj).symm, ?_, ?_⟩,
        (disj_wE_iff m 1 (shEmb m y) (shEmb m x)).mpr ⟨?_, ?_, ?_, ?_⟩⟩
      · rcases f2_val_cases y.2 with hv | hv
        · refine Or.inr ⟨?_, ?_⟩
          · omega
          · omega
        · exact Or.inl (by omega)
      · rcases f2_val_cases x.2 with hv | hv
        · refine Or.inr ⟨?_, ?_⟩
          · omega
          · omega
        · exact Or.inl (by omega)
      · rcases f2_val_cases y.2 with hv | hv
        · exact Or.inr (f2_ne10 y.2 hv)
        · left; omega
      · rcases f2_val_cases y.2 with hv | hv
        · exact Or.inr (f2_ne10 y.2 hv)
        · left; omega
      · rcases f2_val_cases x.2 with hv | hv
        · exact Or.inr (f2_ne10 x.2 hv)
        · left; omega
      · rcases f2_val_cases x.2 with hv | hv
        · exact Or.inr (f2_ne10 x.2 hv)
        · left; omega

/-! ## §3 T4b 组装：p = a + 2c + a(n-2) -/

theorem f2_10 : (1 : Fin 2) ≠ (0 : Fin 2) := fun h => f2_01 h.symm

/-- wE1 与 wE0 跨行不相交（行 0 vs 行 1）。 -/
theorem wE_cross_disj (m : ℕ) : Disjoint (edgeSupp (wE m 1)) (edgeSupp (wE m 0)) := by
  have h := disjoint_esupp_iff ((⟨m+2, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)
    ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)
    ((⟨m+2, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2)
    ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2)
  refine h.mpr ⟨?_, ?_, ?_, ?_⟩
  · intro hcon; exact f2_10 (congrArg Prod.snd hcon)
  · intro hcon
    have hval := congrArg Fin.val (congrArg Prod.fst hcon)
    have h1 : ((⟨m+2, by omega⟩ : Fin (m+3)) : ℕ) = m + 2 := rfl
    have h2 : ((⟨0, by omega⟩ : Fin (m+3)) : ℕ) = 0 := rfl
    rw [h1, h2] at hval
    omega
  · intro hcon
    have hval := congrArg Fin.val (congrArg Prod.fst hcon)
    have h1 : ((⟨0, by omega⟩ : Fin (m+3)) : ℕ) = 0 := rfl
    have h2 : ((⟨m+2, by omega⟩ : Fin (m+3)) : ℕ) = m + 2 := rfl
    rw [h1, h2] at hval
    omega
  · intro hcon; exact f2_10 (congrArg Prod.snd hcon)

theorem wE1_not_mem_Cst (m : ℕ) : wE m 1 ∉ PrismR2.Cst (m+3) (m+3) := by
  intro h
  simp only [PrismR2.Cst, Finset.mem_filter] at h
  exact wE_not_mem_Eset m 1 h.1

/-- P \ {wE0} = Eset ∪ {wE1}。 -/
theorem pE_sdiff (m : ℕ) :
    (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) \ {wE m 0} = Eset (m+3) (m+3) ∪ {wE m 1} := by
  ext f
  simp only [Finset.mem_sdiff, Finset.mem_union, Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨(h | h | h), hne⟩
    · exact Or.inl h
    · exact absurd h hne
    · exact Or.inr h
  · rintro (h | h)
    · refine ⟨Or.inl h, ?_⟩
      intro hcon
      have hw : wE m 0 ∈ Eset (m+3) (m+3) := by rw [← hcon]; exact h
      exact wE_not_mem_Eset m 0 hw
    · refine ⟨Or.inr (Or.inr h), ?_⟩
      intro hcon
      exact wE_ne m (hcon.symm.trans h)

/-- (Eset ∪ {wE1}) \ {wE1} = Eset。 -/
theorem eset_sdiff (m : ℕ) :
    (Eset (m+3) (m+3) ∪ {wE m 1}) \ {wE m 1} = Eset (m+3) (m+3) := by
  ext f
  simp only [Finset.mem_sdiff, Finset.mem_union, Finset.mem_singleton]
  constructor
  · rintro ⟨(h | h), hne⟩
    · exact h
    · rw [h] at hne; exact absurd rfl hne
  · intro h
    refine ⟨Or.inl h, ?_⟩
    intro hcon
    have hw : wE m 1 ∈ Eset (m+3) (m+3) := by rw [← hcon]; exact h
    exact wE_not_mem_Eset m 1 hw

/-- (Cst ∪ {wE1}) \ {wE1} = Cst。 -/
theorem cst_sdiff (m : ℕ) :
    (PrismR2.Cst (m+3) (m+3) ∪ {wE m 1}) \ {wE m 1} = PrismR2.Cst (m+3) (m+3) := by
  ext f
  simp only [Finset.mem_sdiff, Finset.mem_union, Finset.mem_singleton]
  constructor
  · rintro ⟨(h | h), hne⟩
    · exact h
    · rw [h] at hne; exact absurd rfl hne
  · intro h
    refine ⟨Or.inl h, ?_⟩
    intro hcon
    have hw : wE m 1 ∈ PrismR2.Cst (m+3) (m+3) := by rw [← hcon]; exact h
    exact wE1_not_mem_Cst m hw

/-- (Eset ∪ {wE1}).filter (disj wE1) = Eset.filter (disj wE1)。 -/
theorem filter_u_wE1 (m : ℕ) :
    (Eset (m+3) (m+3) ∪ {wE m 1}).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) =
      (Eset (m+3) (m+3)).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) := by
  ext f
  simp only [Finset.mem_filter, Finset.mem_union, Finset.mem_singleton]
  constructor
  · rintro ⟨(h | h), hd⟩
    · exact ⟨h, hd⟩
    · rw [h] at hd; exact absurd hd (wE_nondisj m 1)
  · exact fun h => ⟨Or.inl h.1, h.2⟩

/-- (Cst ∪ {wE1}).filter (disj wE1) = Cst.filter (disj wE1)。 -/
theorem filter_c_wE1 (m : ℕ) :
    (PrismR2.Cst (m+3) (m+3) ∪ {wE m 1}).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) =
      (PrismR2.Cst (m+3) (m+3)).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 1))) := by
  ext f
  simp only [Finset.mem_filter, Finset.mem_union, Finset.mem_singleton]
  constructor
  · rintro ⟨(h | h), hd⟩
    · exact ⟨h, hd⟩
    · rw [h] at hd; exact absurd hd (wE_nondisj m 1)
  · exact fun h => ⟨Or.inl h.1, h.2⟩

/-- {wE0, wE1}.filter (disj wE0) = {wE1}。 -/
theorem filter_pair_wE0 (m : ℕ) :
    ({wE m 0, wE m 1} : Finset (Sym2 (Fin (m+3) × Fin 2))).filter
        (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 0))) = {wE m 1} := by
  ext f
  simp only [Finset.mem_filter, Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨(rfl | h), hd⟩
    · exact absurd hd (wE_nondisj m 0)
    · exact h
  · intro h
    rw [h]
    exact ⟨Or.inr rfl, wE_cross_disj m⟩

/-- P.filter (disj wE0) = Cst ∪ {wE1}（cell C2）。 -/
theorem pFilter (m : ℕ) :
    (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}).filter (fun f => Disjoint (edgeSupp f) (edgeSupp (wE m 0))) =
      PrismR2.Cst (m+3) (m+3) ∪ {wE m 1} := by
  rw [Finset.filter_union, cell_wE0, filter_pair_wE0]

/-- **T4b 第 2 步**：MC(Eset ∪ {wE1}) = a(n) + c(n)。 -/
theorem mc_union_wE1 (m : ℕ) :
    matchCount (Eset (m+3) (m+3) ∪ {wE m 1}) =
      hosoya (pathGraph (m+3) □ pathGraph 2) + matchCount (PrismR2.Cst (m+3) (m+3)) := by
  have hpart := matchCount_partition
    (E := Eset (m+3) (m+3) ∪ {wE m 1}) (e := wE m 1) (by simp) (wE_nondisj m 1)
  rw [eset_sdiff m, filter_u_wE1 m] at hpart
  have hE : matchCount (Eset (m+3) (m+3)) = hosoya (pathGraph (m+3) □ pathGraph 2) :=
    (transp (le_refl (m+3))).symm
  have hC : matchCount ((PrismR2.Cst (m+3) (m+3)).image
      (Sym2.map (swapv : Fin (m+3) × Fin 2 → Fin (m+3) × Fin 2))) =
    matchCount (PrismR2.Cst (m+3) (m+3)) :=
    (matchCount_map_inj (swapv : Fin (m+3) × Fin 2 → Fin (m+3) × Fin 2) swapv_inj _).symm
  rw [hpart, cell_wE1 m, hE, hC]

/-- **T4b 第 5 步**：MC(Cst ∪ {wE1}) = c(n) + a(n-2)。 -/
theorem mc_Cst_wE1 (m : ℕ) :
    matchCount (PrismR2.Cst (m+3) (m+3) ∪ {wE m 1}) =
      matchCount (PrismR2.Cst (m+3) (m+3)) + hosoya (pathGraph (m+1) □ pathGraph 2) := by
  have hpart := matchCount_partition
    (E := PrismR2.Cst (m+3) (m+3) ∪ {wE m 1}) (e := wE m 1) (by simp) (wE_nondisj m 1)
  rw [cst_sdiff m, filter_c_wE1 m] at hpart
  have hE : matchCount (Eset (m+1) (m+1)) = hosoya (pathGraph (m+1) □ pathGraph 2) :=
    (transp (le_refl (m+1))).symm
  have hC : matchCount ((Eset (m+1) (m+1)).image (Sym2.map (shEmb m))) =
      matchCount (Eset (m+1) (m+1)) :=
    (matchCount_map_inj (shEmb m) (shEmb_inj m) _).symm
  rw [hpart, cell_C3 m, hC, hE]

/-- **T4b 主分解**：p(n) = a(n) + 2c(n) + a(n-2)。 -/
theorem p_decomp (m : ℕ) :
    matchCount (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) =
      hosoya (pathGraph (m+3) □ pathGraph 2) + 2 * matchCount (PrismR2.Cst (m+3) (m+3)) +
      hosoya (pathGraph (m+1) □ pathGraph 2) := by
  have hpart := matchCount_partition
    (E := Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) (e := wE m 0) (by simp) (wE_nondisj m 0)
  rw [pE_sdiff m, pFilter m, mc_union_wE1 m, mc_Cst_wE1 m] at hpart
  omega

/-! ## §4 ambient 不变性 + c-R4 + T4c 主 R4 -/

/-- Cst N m 的成员资格线性化（任意 ambient）。 -/
theorem cstNN' {N m : ℕ} (a b : Fin N × Fin 2) :
    s(a, b) ∈ PrismR2.Cst N m ↔ (pathGraph N □ pathGraph 2).Adj a b ∧
      (a.1 : ℕ) < m ∧ (b.1 : ℕ) < m ∧
      ((a.2 : ℕ) = 1 ∨ 1 ≤ (a.1 : ℕ) ∧ (a.1 : ℕ) + 2 ≤ m) ∧
      ((b.2 : ℕ) = 1 ∨ 1 ≤ (b.1 : ℕ) ∧ (b.1 : ℕ) + 2 ≤ m) := by
  simp only [PrismR2.Cst, Finset.mem_filter, PrismR2.filt2, eset_mem_mk, and_assoc]

/-- emb 保 Cst 成员（升 ambient）。 -/
theorem cst_emb_mem {N m : ℕ} (hk : m ≤ N) (x y : Fin m × Fin 2)
    (hadj : (pathGraph m □ pathGraph 2).Adj x y) (hxm : (x.1 : ℕ) < m) (hym : (y.1 : ℕ) < m)
    (hqx : (x.2 : ℕ) = 1 ∨ 1 ≤ (x.1 : ℕ) ∧ (x.1 : ℕ) + 2 ≤ m)
    (hqy : (y.2 : ℕ) = 1 ∨ 1 ≤ (y.1 : ℕ) ∧ (y.1 : ℕ) + 2 ≤ m) :
    s(emb hk x, emb hk y) ∈ PrismR2.Cst N m := by
  rw [cstNN']
  refine ⟨?_, hxm, hym, hqx, hqy⟩
  rw [lad_adj_iff] at hadj ⊢
  rcases hadj with ⟨hc, hr⟩ | ⟨hr, hc⟩
  · refine Or.inl ⟨?_, hr⟩
    apply Fin.val_injective
    have h1 : ((emb hk x).1 : ℕ) = (x.1 : ℕ) := rfl
    have h2 : ((emb hk y).1 : ℕ) = (y.1 : ℕ) := rfl
    rw [h1, h2]
    exact congrArg Fin.val hc
  · refine Or.inr ⟨hr, ?_⟩
    have h1 : ((emb hk x).1 : ℕ) = (x.1 : ℕ) := rfl
    have h2 : ((emb hk y).1 : ℕ) = (y.1 : ℕ) := rfl
    rcases hc with hc | hc <;> omega

/-- **ambient 不变（集合版）**：Cst N m = Cst m m 的 emb 像。 -/
theorem cst_ambient_image (N m : ℕ) (hk : m ≤ N) :
    PrismR2.Cst N m = (PrismR2.Cst m m).image (Sym2.map (emb hk)) := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  rw [Finset.mem_image, cstNN']
  constructor
  · rintro ⟨hadj, hma, hmb, hqa, hqb⟩
    have hax : emb hk ((⟨(a.1 : ℕ), by omega⟩ : Fin m), a.2) = a := by
      refine Prod.ext_iff.mpr ⟨?_, rfl⟩
      exact Fin.val_injective rfl
    have hby : emb hk ((⟨(b.1 : ℕ), by omega⟩ : Fin m), b.2) = b := by
      refine Prod.ext_iff.mpr ⟨?_, rfl⟩
      exact Fin.val_injective rfl
    refine ⟨s(((⟨(a.1 : ℕ), by omega⟩ : Fin m), a.2), ((⟨(b.1 : ℕ), by omega⟩ : Fin m), b.2)),
      ?_, ?_⟩
    · rw [cstNN']
      refine ⟨?_, hma, hmb, hqa, hqb⟩
      rw [lad_adj_iff] at hadj ⊢
      rcases hadj with ⟨hc, hr⟩ | ⟨hr, hc⟩
      · refine Or.inl ⟨?_, hr⟩
        apply Fin.val_injective
        have h1 : ((⟨(a.1 : ℕ), by omega⟩ : Fin m) : ℕ) = (a.1 : ℕ) := rfl
        have h2 : ((⟨(b.1 : ℕ), by omega⟩ : Fin m) : ℕ) = (b.1 : ℕ) := rfl
        rw [h1, h2]
        exact congrArg Fin.val hc
      · refine Or.inr ⟨hr, ?_⟩
        have h1 : (((⟨(a.1 : ℕ), by omega⟩ : Fin m), a.2).1 : ℕ) = (a.1 : ℕ) := rfl
        have h2 : (((⟨(b.1 : ℕ), by omega⟩ : Fin m), b.2).1 : ℕ) = (b.1 : ℕ) := rfl
        rcases hc with hc | hc <;> omega
    · rw [Sym2.map_mk, hax, hby]
  · rintro ⟨e', he', hmap⟩
    induction e' using Sym2.ind with
    | _ x y =>
    rw [Sym2.map_mk] at hmap
    rw [cstNN'] at he'
    obtain ⟨hadj, hxm, hym, hqx, hqy⟩ := he'
    rw [Sym2.eq_iff] at hmap
    rcases hmap with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · rw [← h1, ← h2]
      exact (cstNN' (emb hk x) (emb hk y)).mp (cst_emb_mem hk x y hadj hxm hym hqx hqy)
    · rw [← h2, ← h1]
      exact (cstNN' (emb hk y) (emb hk x)).mp
        (cst_emb_mem hk y x hadj.symm hym hxm hqy hqx)

/-- **ambient 不变（计数版）**：MC(Cst N m) = MC(Cst m m)。 -/
theorem cst_ambient (N m : ℕ) (hk : m ≤ N) :
    matchCount (PrismR2.Cst N m) = matchCount (PrismR2.Cst m m) := by
  rw [cst_ambient_image N m hk]
  exact (matchCount_map_inj (emb hk) (emb_inj hk) _).symm

/-- **c-R4**（ambient-free 口径，n ≥ 3）。 -/
theorem c_rec4' (n : ℕ) (hn : 3 ≤ n) :
    matchCount (PrismR2.Cst (n+4) (n+4)) + matchCount (PrismR2.Cst n n) =
      2 * matchCount (PrismR2.Cst (n+3) (n+3)) + 4 * matchCount (PrismR2.Cst (n+2) (n+2)) := by
  have h := PrismR2.c_rec4 (N := n+5) (n := n) hn (by omega)
  rw [cst_ambient (n+5) (n+4) (by omega), cst_ambient (n+5) n (by omega),
      cst_ambient (n+5) (n+3) (by omega), cst_ambient (n+5) (n+2) (by omega)] at h
  exact h

/-- **T4c**：棱柱主 R4。 -/
theorem hosoya_prism_rec4 (m : ℕ) :
    hosoya (prism (m+7)) + hosoya (prism (m+3)) =
      2 * hosoya (prism (m+6)) + 4 * hosoya (prism (m+5)) := by
  have hm4 : hosoya (prism (m+7)) = matchCount (Eset (m+7) (m+7) ∪ {wE (m+4) 0, wE (m+4) 1}) :=
    hosoya_prism_mc (m+4)
  have hm3 : hosoya (prism (m+6)) = matchCount (Eset (m+6) (m+6) ∪ {wE (m+3) 0, wE (m+3) 1}) :=
    hosoya_prism_mc (m+3)
  have hm2 : hosoya (prism (m+5)) = matchCount (Eset (m+5) (m+5) ∪ {wE (m+2) 0, wE (m+2) 1}) :=
    hosoya_prism_mc (m+2)
  have hm0 : hosoya (prism (m+3)) = matchCount (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) :=
    hosoya_prism_mc m
  have pd4 : matchCount (Eset (m+7) (m+7) ∪ {wE (m+4) 0, wE (m+4) 1}) =
      hosoya (pathGraph (m+7) □ pathGraph 2) + 2 * matchCount (PrismR2.Cst (m+7) (m+7)) +
      hosoya (pathGraph (m+5) □ pathGraph 2) := p_decomp (m+4)
  have pd3 : matchCount (Eset (m+6) (m+6) ∪ {wE (m+3) 0, wE (m+3) 1}) =
      hosoya (pathGraph (m+6) □ pathGraph 2) + 2 * matchCount (PrismR2.Cst (m+6) (m+6)) +
      hosoya (pathGraph (m+4) □ pathGraph 2) := p_decomp (m+3)
  have pd2 : matchCount (Eset (m+5) (m+5) ∪ {wE (m+2) 0, wE (m+2) 1}) =
      hosoya (pathGraph (m+5) □ pathGraph 2) + 2 * matchCount (PrismR2.Cst (m+5) (m+5)) +
      hosoya (pathGraph (m+3) □ pathGraph 2) := p_decomp (m+2)
  have pd0 : matchCount (Eset (m+3) (m+3) ∪ {wE m 0, wE m 1}) =
      hosoya (pathGraph (m+3) □ pathGraph 2) + 2 * matchCount (PrismR2.Cst (m+3) (m+3)) +
      hosoya (pathGraph (m+1) □ pathGraph 2) := p_decomp m
  have ha0 : hosoya (pathGraph (m+4) □ pathGraph 2) + hosoya (pathGraph m □ pathGraph 2) =
      2 * hosoya (pathGraph (m+3) □ pathGraph 2) + 4 * hosoya (pathGraph (m+2) □ pathGraph 2) :=
    hosoya_ladder_rec4 m
  have ha1 : hosoya (pathGraph (m+5) □ pathGraph 2) + hosoya (pathGraph (m+1) □ pathGraph 2) =
      2 * hosoya (pathGraph (m+4) □ pathGraph 2) + 4 * hosoya (pathGraph (m+3) □ pathGraph 2) :=
    hosoya_ladder_rec4 (m+1)
  have ha2 : hosoya (pathGraph (m+6) □ pathGraph 2) + hosoya (pathGraph (m+2) □ pathGraph 2) =
      2 * hosoya (pathGraph (m+5) □ pathGraph 2) + 4 * hosoya (pathGraph (m+4) □ pathGraph 2) :=
    hosoya_ladder_rec4 (m+2)
  have ha3 : hosoya (pathGraph (m+7) □ pathGraph 2) + hosoya (pathGraph (m+3) □ pathGraph 2) =
      2 * hosoya (pathGraph (m+6) □ pathGraph 2) + 4 * hosoya (pathGraph (m+5) □ pathGraph 2) :=
    hosoya_ladder_rec4 (m+3)
  have hc : matchCount (PrismR2.Cst (m+7) (m+7)) + matchCount (PrismR2.Cst (m+3) (m+3)) =
      2 * matchCount (PrismR2.Cst (m+6) (m+6)) + 4 * matchCount (PrismR2.Cst (m+5) (m+5)) :=
    c_rec4' (m+3) (by omega)
  rw [hm4, hm0, hm3, hm2, pd4, pd0, pd3, pd2]
  omega

/-! ## §5 T4d rim 桥：整体旋转把 delRim 边集映成 Eset ∪ {wE1} -/

/-- 无环绕时 Fin 加一的 val。 -/
theorem fin_succ_val (m : ℕ) (i : Fin (m+3)) (h : (i : ℕ) + 1 < m + 3) :
    ((i + 1 : Fin (m+3)) : ℕ) = (i : ℕ) + 1 := by
  rw [Fin.val_add, Fin.val_one]
  exact Nat.mod_eq_of_lt h

/-- prismDelRim 删的那条 rim 边（第 0-1 列、行 0）。 -/
def e0 (m : ℕ) : Sym2 (Fin (m+3) × Fin 2) :=
  s((⟨0, by omega⟩, (0 : Fin 2)), (⟨1, by omega⟩, (0 : Fin 2)))

/-- 列旋转 −1（含环绕），行不变。 -/
def colw (m : ℕ) (i : Fin (m+3)) : Fin (m+3) :=
  if (i : ℕ) = 0 then ⟨m+2, by omega⟩ else ⟨(i : ℕ) - 1, by omega⟩

def rotw (m : ℕ) (v : Fin (m+3) × Fin 2) : Fin (m+3) × Fin 2 := (colw m v.1, v.2)

theorem rotw_row (m : ℕ) (v : Fin (m+3) × Fin 2) : (rotw m v).2 = v.2 := rfl

theorem colw_val_zero (m : ℕ) (i : Fin (m+3)) (h : (i : ℕ) = 0) : ((colw m i) : ℕ) = m + 2 := by
  simp only [colw, if_pos h]

theorem colw_val_pos (m : ℕ) (i : Fin (m+3)) (h : 1 ≤ (i : ℕ)) : ((colw m i) : ℕ) = (i : ℕ) - 1 := by
  have hne : ¬ ((i : ℕ) = 0) := by omega
  simp only [colw, if_neg hne]

theorem colw_zero (m : ℕ) : colw m (⟨0, by omega⟩ : Fin (m+3)) = ⟨m+2, by omega⟩ := rfl

theorem colw_one (m : ℕ) : colw m (⟨1, by omega⟩ : Fin (m+3)) = ⟨0, by omega⟩ := by
  have h1 : ((⟨1, by omega⟩ : Fin (m+3)) : ℕ) = 1 := rfl
  have hne : ¬ (((⟨1, by omega⟩ : Fin (m+3)) : ℕ) = 0) := by
    intro hcon
    rw [h1] at hcon
    omega
  simp only [colw, if_neg hne]

theorem colw_inj (m : ℕ) : Function.Injective (colw m) := by
  intro i j h
  by_cases hi : (i : ℕ) = 0
  · by_cases hj : (j : ℕ) = 0
    · exact Fin.val_injective (by show (i : ℕ) = (j : ℕ); omega)
    · exfalso
      have hv := congrArg Fin.val h
      rw [colw_val_zero m i hi, colw_val_pos m j (by omega)] at hv
      have his : (i : ℕ) < m + 3 := i.isLt
      omega
  · by_cases hj : (j : ℕ) = 0
    · exfalso
      have hv := congrArg Fin.val h
      rw [colw_val_pos m i (by omega), colw_val_zero m j hj] at hv
      have his : (i : ℕ) < m + 3 := i.isLt
      omega
    · exact Fin.val_injective (by
        have hv := congrArg Fin.val h
        rw [colw_val_pos m i (by omega), colw_val_pos m j (by omega)] at hv
        omega)

theorem rotw_inj (m : ℕ) : Function.Injective (rotw m) := by
  intro v v' h
  have hrow : (rotw m v).2 = (rotw m v').2 := congrArg Prod.snd h
  have hcol : (rotw m v).1 = (rotw m v').1 := congrArg Prod.fst h
  exact Prod.ext_iff.mpr ⟨colw_inj m hcol, hrow⟩

theorem rotv_rotw (m : ℕ) (v : Fin (m+3) × Fin 2) : rotv m (rotw m v) = v := by
  have hrow : (rotv m (rotw m v)).2 = v.2 := rfl
  have hc : (rotv m (rotw m v)).1 = v.1 := by
    show (colw m v.1) + 1 = v.1
    by_cases hv : (v.1 : ℕ) = 0
    · have hcw : ((colw m v.1) : ℕ) = m + 2 := colw_val_zero m v.1 hv
      apply Fin.val_injective
      rw [Fin.val_add, Fin.val_one, hcw]
      have hmod : (m + 2 + 1) % (m + 3) = 0 := by
        rw [show m + 2 + 1 = m + 3 from by omega]; exact Nat.mod_self _
      rw [hmod]
      omega
    · have hcw : ((colw m v.1) : ℕ) = (v.1 : ℕ) - 1 := colw_val_pos m v.1 (by omega)
      have his : (v.1 : ℕ) < m + 3 := v.1.isLt
      apply Fin.val_injective
      rw [Fin.val_add, Fin.val_one, hcw]
      rw [Nat.mod_eq_of_lt (by omega)]
      omega
  exact Prod.ext_iff.mpr ⟨hc, hrow⟩

theorem rotw_rotv (m : ℕ) (v : Fin (m+3) × Fin 2) : rotw m (rotv m v) = v := by
  have hrow : (rotw m (rotv m v)).2 = v.2 := rfl
  have hc : (rotw m (rotv m v)).1 = v.1 := by
    show colw m (v.1 + 1) = v.1
    by_cases hv : (v.1 : ℕ) = m + 2
    · have hvv : ((v.1 + 1 : Fin (m+3)) : ℕ) = 0 := by
        rw [Fin.val_add, Fin.val_one]
        have hmod : ((v.1 : ℕ) + 1) % (m + 3) = 0 := by
          rw [show (v.1 : ℕ) + 1 = m + 3 from by omega]; exact Nat.mod_self _
        rw [hmod]
      have hcw : ((colw m (v.1 + 1)) : ℕ) = m + 2 := colw_val_zero m (v.1 + 1) hvv
      apply Fin.val_injective
      rw [hcw]
      omega
    · have hvv : ((v.1 + 1 : Fin (m+3)) : ℕ) = (v.1 : ℕ) + 1 :=
        fin_succ_val m v.1 (by omega)
      have hpos : 1 ≤ ((v.1 + 1 : Fin (m+3)) : ℕ) := by omega
      have hcw : ((colw m (v.1 + 1)) : ℕ) = (v.1 : ℕ) := by
        rw [colw_val_pos m (v.1 + 1) hpos, hvv]
        omega
      apply Fin.val_injective
      rw [hcw]
  exact Prod.ext_iff.mpr ⟨hc, hrow⟩

/-- rotw 作用在 e0 上恰是 wE0。 -/
theorem rotw_e0 (m : ℕ) : Sym2.map (rotw m) (e0 m) = wE m 0 := by
  simp only [e0, Sym2.map_mk]
  have h1 : rotw m ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) =
      ((⟨m+2, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) := by
    refine Prod.ext_iff.mpr ⟨?_, rfl⟩
    show colw m (⟨0, by omega⟩ : Fin (m+3)) = _
    rw [colw_zero]
  have h2 : rotw m ((⟨1, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) =
      ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) := by
    refine Prod.ext_iff.mpr ⟨?_, rfl⟩
    show colw m (⟨1, by omega⟩ : Fin (m+3)) = _
    rw [colw_one]
  rw [h1, h2]
  simp only [wE]

/-- rotv 把 wE1 映到第 0-1 列行 1 的梯子边。 -/
theorem rotv_wE1 (m : ℕ) : Sym2.map (rotv m) (wE m 1) =
    s(((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2),
      ((⟨1, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)) := by
  simp only [wE, Sym2.map_mk]
  have h1 : rotv m ((⟨m+2, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) =
      ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
    refine Prod.ext_iff.mpr ⟨?_, rfl⟩
    apply Fin.val_injective
    show (((⟨m+2, by omega⟩ : Fin (m+3)) + 1 : Fin (m+3)) : ℕ) = 0
    rw [Fin.val_add, Fin.val_one, top_val m]
    have hmod : (m + 2 + 1) % (m + 3) = 0 := by
      rw [show m + 2 + 1 = m + 3 from by omega]; exact Nat.mod_self _
    rw [hmod]
  have h2 : rotv m ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) =
      ((⟨1, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
    refine Prod.ext_iff.mpr ⟨?_, rfl⟩
    apply Fin.val_injective
    show (((⟨0, by omega⟩ : Fin (m+3)) + 1 : Fin (m+3)) : ℕ) = 1
    rw [Fin.val_add, Fin.val_one, zero_val m]
    have hmod : (0 + 1) % (m + 3) = 1 := Nat.mod_eq_of_lt (by omega)
    rw [hmod]
  rw [h1, h2]

/-- 梯子邻接在 rotv 下的像仍是棱柱邻接。 -/
theorem prism_adj_rotv (m : ℕ) (x y : Fin (m+3) × Fin 2)
    (hadj : (pathGraph (m+3) □ pathGraph 2).Adj x y) :
    (prism (m+3)).Adj (rotv m x) (rotv m y) := by
  show (cycleGraph (m+3) □ pathGraph 2).Adj (rotv m x) (rotv m y)
  rw [boxProd_adj]
  have his : (x.1 : ℕ) < m + 3 := x.1.isLt
  rw [lad_adj_iff] at hadj
  rcases hadj with ⟨hc, hr⟩ | ⟨hr, hc⟩
  · refine Or.inr ⟨(p2adj _ _).mpr hr, ?_⟩
    show (x.1 + 1 : Fin (m+3)) = (y.1 + 1 : Fin (m+3))
    exact congrArg (fun i : Fin (m+3) => i + 1) hc
  · refine Or.inl ⟨?_, hr⟩
    rw [cycleGraph_adj_iff_succ]
    rcases hc with hc | hc
    · refine Or.inl ?_
      have hfin : x.1 + 1 = y.1 := by
        apply Fin.val_injective
        rw [Fin.val_add, Fin.val_one]
        rw [show ((x.1 : ℕ) + 1) % (m + 3) = (x.1 : ℕ) + 1 from Nat.mod_eq_of_lt (by omega)]
        exact hc
      show (y.1 + 1 : Fin (m+3)) = ((x.1 + 1 : Fin (m+3)) + 1)
      exact (congrArg (fun i : Fin (m+3) => i + 1) hfin).symm
    · refine Or.inr ?_
      have hfin : y.1 + 1 = x.1 := by
        apply Fin.val_injective
        rw [Fin.val_add, Fin.val_one]
        rw [show ((y.1 : ℕ) + 1) % (m + 3) = (y.1 : ℕ) + 1 from Nat.mod_eq_of_lt (by omega)]
        exact hc
      show (x.1 + 1 : Fin (m+3)) = ((y.1 + 1 : Fin (m+3)) + 1)
      exact (congrArg (fun i : Fin (m+3) => i + 1) hfin).symm

/-- 第 0-1 列行 1 的梯子边是棱柱边。 -/
theorem adj01 (m : ℕ) :
    (prism (m+3)).Adj ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)
      ((⟨1, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
  show (cycleGraph (m+3) □ pathGraph 2).Adj _ _
  refine boxProd_adj.mpr (Or.inl ⟨?_, rfl⟩)
  rw [cycleGraph_adj_iff_succ]
  refine Or.inl ?_
  apply Fin.val_injective
  have hA : ((⟨1, by omega⟩ : Fin (m+3)) : ℕ) = 1 := rfl
  have hB : ((⟨0, by omega⟩ : Fin (m+3)) : ℕ) = 0 := rfl
  rw [Fin.val_add, Fin.val_one, hA, hB]
  exact (Nat.mod_eq_of_lt (by omega)).symm

/-- 行 1 的边不是 e0。 -/
theorem ne01 (m : ℕ) :
    s(((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2),
      ((⟨1, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)) ≠ e0 m := by
  intro hcon
  simp only [e0] at hcon
  rw [Sym2.eq_iff] at hcon
  rcases hcon with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact f2_10 (congrArg Prod.snd h1)
  · exact f2_10 (congrArg Prod.snd h2)

theorem sym2_swap (V : Type*) (x y : V) : s(x, y) = s(y, x) :=
  (Sym2.eq_iff.mpr (Or.inr ⟨rfl, rfl⟩))

/-- **cell C4（旋转版）**：(Eset ∪ {wE1}) 的 rotv 像 = prismDelRim 边集。 -/
theorem cell_C4 (m : ℕ) :
    (Eset (m+3) (m+3) ∪ {wE m 1}).image (Sym2.map (rotv m)) =
      (prism (m+3)).edgeFinset \ {e0 m} := by
  ext e
  induction e using Sym2.ind with
  | _ a b =>
  simp only [Finset.mem_image, Finset.mem_sdiff, Finset.mem_union, Finset.mem_singleton,
    SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
  constructor
  · rintro ⟨e', hmem, hmap⟩
    induction e' using Sym2.ind with
    | _ x y =>
    rw [Sym2.map_mk] at hmap
    rcases hmem with hE | hw
    · have hadj : (prism (m+3)).Adj (rotv m x) (rotv m y) :=
        prism_adj_rotv m x y ((esetNN m x y).mp hE)
      have hne : s(rotv m x, rotv m y) ≠ e0 m := by
        intro hcon
        have hc2 : Sym2.map (rotw m) (s(rotv m x, rotv m y)) = Sym2.map (rotw m) (e0 m) :=
          congrArg (Sym2.map (rotw m)) hcon
        rw [Sym2.map_mk, rotw_rotv, rotw_rotv, rotw_e0] at hc2
        exact wE_not_mem_Eset m 0 (by rw [← hc2]; exact hE)
      rcases (Sym2.eq_iff.mp hmap) with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · rw [← h1, ← h2]
        exact ⟨hadj, hne⟩
      · rw [← h2, ← h1]
        exact ⟨hadj.symm,
          fun hcon => hne ((sym2_swap _ (rotv m x) (rotv m y)).trans hcon)⟩
    · have hmma : Sym2.map (rotv m) (s(x, y)) = s(rotv m x, rotv m y) := Sym2.map_mk (rotv m) x y
      rw [hw, rotv_wE1] at hmma
      have hab := hmma.trans hmap
      rw [Sym2.eq_iff] at hab
      rcases hab with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · rw [← h1, ← h2]
        exact ⟨adj01 m, ne01 m⟩
      · rw [← h1, ← h2]
        exact ⟨(adj01 m).symm, fun hcon =>
          ne01 m ((sym2_swap _
            ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)
            ((⟨1, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2)).trans hcon)⟩
  · rintro ⟨hadj, hne⟩
    refine ⟨s(rotw m a, rotw m b), ?_, ?_⟩
    · rw [show (prism (m+3)).Adj a b = ((cycleGraph (m+3) □ pathGraph 2).Adj a b) from rfl] at hadj
      rw [boxProd_adj] at hadj
      rcases hadj with ⟨hcyc, hrow⟩ | ⟨hp2, hcol⟩
      · rw [cycleGraph_adj_iff_succ] at hcyc
        rcases f2_val_cases a.2 with hv | hv
        · -- 行 0：a.2 = 0
          by_cases ha0 : (a.1 : ℕ) = 0
          · rcases hcyc with hb | hb
            · -- b.1 = a.1+1 = ⟨1⟩ → 与 ≠e0 矛盾
              exfalso
              apply hne
              have hvt : a.1 = (⟨0, by omega⟩ : Fin (m+3)) :=
                Fin.val_injective (by show (a.1 : ℕ) = 0; omega)
              have hbv : (b.1 : ℕ) = 1 := by
                rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                · omega
                · omega
              have hbt : b.1 = (⟨1, by omega⟩ : Fin (m+3)) :=
                Fin.val_injective (by show (b.1 : ℕ) = 1; omega)
              have hrowb : b.2 = (0 : Fin 2) := by
                rw [← hrow]; exact f2_val0 a.2 hv
              have hat : a = ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) :=
                Prod.ext_iff.mpr ⟨hvt, f2_val0 a.2 hv⟩
              have hbt2 : b = ((⟨1, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) :=
                Prod.ext_iff.mpr ⟨hbt, hrowb⟩
              rw [hat, hbt2]
              rfl
            · -- a.1 = b.1+1，b.1.val = m+2：梯子边
              refine Or.inl ?_
              rw [esetNN, lad_adj_iff]
              refine Or.inr ⟨hrow, ?_⟩
              have hbv : (b.1 : ℕ) = m + 2 := by
                rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                · omega
                · omega
              have hca : ((rotw m a).1 : ℕ) = m + 2 := colw_val_zero m a.1 ha0
              have hcb : ((rotw m b).1 : ℕ) = (b.1 : ℕ) - 1 := colw_val_pos m b.1 (by omega)
              rcases f2_val_cases b.2 with hvb | hvb
              · right; omega
              · right; omega
          · by_cases hb0 : (b.1 : ℕ) = 0
            · rcases hcyc with hb | hb
              · -- b.1 = a.1+1（a.1.val = m+2 环绕）：梯子边
                refine Or.inl ?_
                rw [esetNN, lad_adj_iff]
                refine Or.inr ⟨hrow, ?_⟩
                have hav : (a.1 : ℕ) = m + 2 := by
                  rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                  · omega
                  · omega
                have hca : ((rotw m a).1 : ℕ) = (a.1 : ℕ) - 1 := colw_val_pos m a.1 (by omega)
                have hcb : ((rotw m b).1 : ℕ) = m + 2 := colw_val_zero m b.1 hb0
                rcases f2_val_cases b.2 with hvb | hvb
                · left; omega
                · left; omega
              · -- a.1 = b.1+1 = ⟨1⟩ → 与 ≠e0 矛盾
                exfalso
                apply hne
                have hbt : b.1 = (⟨0, by omega⟩ : Fin (m+3)) :=
                  Fin.val_injective (by show (b.1 : ℕ) = 0; omega)
                have hav : (a.1 : ℕ) = 1 := by
                  rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                  · omega
                  · omega
                have hat : a.1 = (⟨1, by omega⟩ : Fin (m+3)) :=
                  Fin.val_injective (by show (a.1 : ℕ) = 1; omega)
                have hrowa : a.2 = (0 : Fin 2) := f2_val0 a.2 hv
                have hrowb : b.2 = (0 : Fin 2) := by
                  rw [← hrow]; exact hrowa
                have hat2 : a = ((⟨1, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) :=
                  Prod.ext_iff.mpr ⟨hat, hrowa⟩
                have hbt2 : b = ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2) :=
                  Prod.ext_iff.mpr ⟨hbt, hrowb⟩
                rw [hat2, hbt2]
                exact sym2_swap _ ((⟨1, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2)
                  ((⟨0, by omega⟩, (0 : Fin 2)) : Fin (m+3) × Fin 2)
            · -- 两侧 val ≥ 1：colw = val−1，梯子邻接
              refine Or.inl ?_
              rw [esetNN, lad_adj_iff]
              refine Or.inr ⟨hrow, ?_⟩
              have hca : ((rotw m a).1 : ℕ) = (a.1 : ℕ) - 1 := colw_val_pos m a.1 (by omega)
              have hcb : ((rotw m b).1 : ℕ) = (b.1 : ℕ) - 1 := colw_val_pos m b.1 (by omega)
              rcases hcyc with hb | hb
              · rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                · left; omega
                · omega
              · rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                · right; omega
                · omega
        · -- 行 1：a.2 = 1
          by_cases ha0 : (a.1 : ℕ) = 0
          · rcases hcyc with hb | hb
            · -- b.1 = ⟨1⟩：像恰是 wE1
              refine Or.inr ?_
              have hvt : a.1 = (⟨0, by omega⟩ : Fin (m+3)) :=
                Fin.val_injective (by show (a.1 : ℕ) = 0; omega)
              have hbv : (b.1 : ℕ) = 1 := by
                rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                · omega
                · omega
              have hbt : b.1 = (⟨1, by omega⟩ : Fin (m+3)) :=
                Fin.val_injective (by show (b.1 : ℕ) = 1; omega)
              have hrowa : a.2 = (1 : Fin 2) := f2_val1 a.2 hv
              have hrowb : b.2 = (1 : Fin 2) := by rw [← hrow]; exact hrowa
              have ha : rotw m a = ((⟨m+2, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
                refine Prod.ext_iff.mpr ⟨?_, hrowa⟩
                show colw m a.1 = _
                rw [hvt, colw_zero]
              have hb : rotw m b = ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
                refine Prod.ext_iff.mpr ⟨?_, hrowb⟩
                show colw m b.1 = _
                rw [hbt, colw_one]
              rw [ha, hb]
              simp only [wE]
            · -- a.1 = b.1+1，b.1.val = m+2：梯子边
              refine Or.inl ?_
              rw [esetNN, lad_adj_iff]
              refine Or.inr ⟨hrow, ?_⟩
              have hbv : (b.1 : ℕ) = m + 2 := by
                rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                · omega
                · omega
              have hca : ((rotw m a).1 : ℕ) = m + 2 := colw_val_zero m a.1 ha0
              have hcb : ((rotw m b).1 : ℕ) = (b.1 : ℕ) - 1 := colw_val_pos m b.1 (by omega)
              rcases f2_val_cases b.2 with hvb | hvb
              · right; omega
              · right; omega
          · by_cases hb0 : (b.1 : ℕ) = 0
            · rcases hcyc with hb | hb
              · -- b.1 = a.1+1（a.1.val = m+2 环绕）：梯子边
                refine Or.inl ?_
                rw [esetNN, lad_adj_iff]
                refine Or.inr ⟨hrow, ?_⟩
                have hav : (a.1 : ℕ) = m + 2 := by
                  rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                  · omega
                  · omega
                have hca : ((rotw m a).1 : ℕ) = (a.1 : ℕ) - 1 := colw_val_pos m a.1 (by omega)
                have hcb : ((rotw m b).1 : ℕ) = m + 2 := colw_val_zero m b.1 hb0
                rcases f2_val_cases b.2 with hvb | hvb
                · left; omega
                · left; omega
              · -- a.1 = b.1+1 = ⟨1⟩：像恰是 wE1（对称）
                refine Or.inr ?_
                have hbt : b.1 = (⟨0, by omega⟩ : Fin (m+3)) :=
                  Fin.val_injective (by show (b.1 : ℕ) = 0; omega)
                have hav : (a.1 : ℕ) = 1 := by
                  rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                  · omega
                  · omega
                have hat : a.1 = (⟨1, by omega⟩ : Fin (m+3)) :=
                  Fin.val_injective (by show (a.1 : ℕ) = 1; omega)
                have hrowa : a.2 = (1 : Fin 2) := f2_val1 a.2 hv
                have hrowb : b.2 = (1 : Fin 2) := by rw [← hrow]; exact hrowa
                have ha : rotw m a = ((⟨0, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
                  refine Prod.ext_iff.mpr ⟨?_, hrowa⟩
                  show colw m a.1 = _
                  rw [hat, colw_one]
                have hb : rotw m b = ((⟨m+2, by omega⟩, (1 : Fin 2)) : Fin (m+3) × Fin 2) := by
                  refine Prod.ext_iff.mpr ⟨?_, hrowb⟩
                  show colw m b.1 = _
                  rw [hbt, colw_zero]
                rw [ha, hb]
                simp only [wE]
                exact sym2_swap _ _ _
            · -- 两侧 val ≥ 1：梯子邻接
              refine Or.inl ?_
              rw [esetNN, lad_adj_iff]
              refine Or.inr ⟨hrow, ?_⟩
              have hca : ((rotw m a).1 : ℕ) = (a.1 : ℕ) - 1 := colw_val_pos m a.1 (by omega)
              have hcb : ((rotw m b).1 : ℕ) = (b.1 : ℕ) - 1 := colw_val_pos m b.1 (by omega)
              rcases hcyc with hb | hb
              · rcases (fin_add_one_val m a.1 b.1).mp hb with h | ⟨h, h2⟩
                · left; omega
                · omega
              · rcases (fin_add_one_val m b.1 a.1).mp hb with h | ⟨h, h2⟩
                · right; omega
                · omega
      · -- 竖档：行翻转、列不变
        refine Or.inl ?_
        rw [esetNN, lad_adj_iff]
        refine Or.inl ⟨congrArg (colw m) hcol, (p2adj _ _).mp hp2⟩
    · rw [Sym2.map_mk, rotv_rotw, rotv_rotw]

/-- prismDelRim 的边集 = 棱柱边集 \ {e0}。 -/
theorem delrim_edges (m : ℕ) (hm : 3 ≤ m + 3) :
    (prismDelRim (m+3) hm).edgeFinset = (prism (m+3)).edgeFinset \ {e0 m} := by
  ext f
  induction f using Sym2.ind with
  | _ x y =>
    simp only [Finset.mem_sdiff, Finset.mem_singleton]
    rw [SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet,
      SimpleGraph.mem_edgeFinset, SimpleGraph.mem_edgeSet]
    simp only [prismDelRim]
    rw [SimpleGraph.deleteEdges_adj, Set.mem_singleton_iff]
    simp only [e0]
    rfl

/-- **T4d**：d_rim(n) = a(n) + c(n)。 -/
theorem delrim_eq (m : ℕ) (hm : 3 ≤ m + 3) :
    hosoya (prismDelRim (m+3) hm) =
      hosoya (pathGraph (m+3) □ pathGraph 2) + matchCount (PrismR2.Cst (m+3) (m+3)) := by
  rw [hosoya_matchCount, delrim_edges m hm, ← cell_C4]
  rw [← (matchCount_map_inj (rotv m) (rotv_inj m) (Eset (m+3) (m+3) ∪ {wE m 1}))]
  exact mc_union_wE1 m

/-! ## §6 T4e spoke 桥 + T4f 初值/强归纳 + 主桥收口

探针 provenance：T4e = 子代理 agent-15/18（双批同参，探针 probe-t4e.lean EXIT=0）；
初值 = agent-16/19（probe-t4f-init.lean，c6 经库件 T1–T7 递推链，decide 超界留档）；
强归纳/R4 = agent-17/20（probe-t4f-ind.lean）。组装 = 主代理 scaffold。
-/

set_option maxRecDepth 40000
set_option maxHeartbeats 1000000

-- ===== T4e spoke 桥 =====

/-- **T4e**：d_spoke 分割恒等式——删 spoke 的棱柱匹配数 = 完整棱柱 − (m+2) 梯子。 -/
theorem delspoke_eq (m : ℕ) (hm : 3 ≤ m + 3) :
    hosoya (prism (m+3)) =
      hosoya (prismDelSpoke (m+3) hm) + hosoya (pathGraph (m+2) □ pathGraph 2) := by
  have h := hosoya_prism_split_spoke (m+3) hm
  have h2 : hosoya (SimpleGraph.induce
      (Set.univ \ {((⟨0, by omega⟩, (0 : Fin 2))), ((⟨0, by omega⟩, (1 : Fin 2)))} :
        Set (Fin (m+3) × Fin 2)) (prism (m+3))) =
      hosoya (pathGraph (m+2) □ pathGraph 2) :=
    hosoya_iso _ _ (prism_delSpokeEnds_induce_iso_ladder (m+3) hm)
  rw [h2] at h
  exact h

-- ===== T4f 初值：a(4..6) = 71,228,733 与 c(3..6) = 4,15,46,150 =====

theorem a4 : hosoya (pathGraph 4 □ pathGraph 2) = 71 := by
  -- rec3 (m=1)：a(4) + a(1) = 3·a(3) + a(2)
  have hr := hosoya_ladder_rec3 1
  have h4 : hosoya (pathGraph (1 + 3) □ pathGraph 2) = hosoya (pathGraph 4 □ pathGraph 2) := rfl
  have h3 : hosoya (pathGraph (1 + 2) □ pathGraph 2) = hosoya (pathGraph 3 □ pathGraph 2) := rfl
  have h2 : hosoya (pathGraph (1 + 1) □ pathGraph 2) = hosoya (pathGraph 2 □ pathGraph 2) := rfl
  rw [h4, h3, h2] at hr
  have e1 := hosoya_lad1
  have e2 := hosoya_lad2
  have e3 := hosoya_lad3
  omega

theorem a5 : hosoya (pathGraph 5 □ pathGraph 2) = 228 := by
  -- rec3 (m=2)：a(5) + a(2) = 3·a(4) + a(3)
  have hr := hosoya_ladder_rec3 2
  have h5 : hosoya (pathGraph (2 + 3) □ pathGraph 2) = hosoya (pathGraph 5 □ pathGraph 2) := rfl
  have h4 : hosoya (pathGraph (2 + 2) □ pathGraph 2) = hosoya (pathGraph 4 □ pathGraph 2) := rfl
  have h3 : hosoya (pathGraph (2 + 1) □ pathGraph 2) = hosoya (pathGraph 3 □ pathGraph 2) := rfl
  rw [h5, h4, h3] at hr
  have e2 := hosoya_lad2
  have e3 := hosoya_lad3
  have e4 := a4
  omega

theorem a6 : hosoya (pathGraph 6 □ pathGraph 2) = 733 := by
  -- rec3 (m=3)：a(6) + a(3) = 3·a(5) + a(4)
  have hr := hosoya_ladder_rec3 3
  have h6 : hosoya (pathGraph (3 + 3) □ pathGraph 2) = hosoya (pathGraph 6 □ pathGraph 2) := rfl
  have h5 : hosoya (pathGraph (3 + 2) □ pathGraph 2) = hosoya (pathGraph 5 □ pathGraph 2) := rfl
  have h4 : hosoya (pathGraph (3 + 1) □ pathGraph 2) = hosoya (pathGraph 4 □ pathGraph 2) := rfl
  rw [h6, h5, h4] at hr
  have e3 := hosoya_lad3
  have e4 := a4
  have e5 := a5
  omega

theorem c3 : matchCount (PrismR2.Cst 3 3) = 4 := by decide

theorem c4 : matchCount (PrismR2.Cst 4 4) = 15 := by decide

theorem c5 : matchCount (PrismR2.Cst 5 5) = 46 := by decide

/-- c6 递推链所需的 4 个小实例（m ≤ 2 或与 c4 同规模的 decide）。 -/
private theorem c6_small :
    matchCount (PrismR2.V3 6 2) = 14 ∧
    matchCount (PrismR2.V5 6 2) = 10 ∧
    matchCount (PrismR2.V7 6 2) = 8 ∧
    matchCount (PrismR2.Cst 6 (3 + 1)) = 15 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    (try decide) <;>
    (try decide) <;>
    (try decide) <;>
    (try decide)

/-- c(6) = 150：直接 decide 超界（2^21 幂集枚举，whnf 心跳超时留档），
改走 PrismHosoya 库件 T1–T7 递推实例链 + omega 线性消元。 -/
theorem c6 : matchCount (PrismR2.Cst 6 6) = 150 := by
  obtain ⟨e32, e42, e72, c6c4⟩ := c6_small
  set i3 : Fin 6 := ⟨3, by omega⟩ with hi3
  set i4 : Fin 6 := ⟨4, by omega⟩ with hi4
  -- V5r(3) = V3(2) + V7(2) = 14 + 8 = 22（T1 m=2）
  have s3 : matchCount (PrismR2.V5r 6 3 i3) = matchCount (PrismR2.V5r 6 (2 + 1) i3) := rfl
  have A1 := PrismR2.T1 (N := 6) (m := 2) i3 (by simp [hi3]) (by omega) (by omega)
  rw [← s3] at A1
  have hV5r3 : matchCount (PrismR2.V5r 6 3 i3) = 22 := by omega
  -- V5(3) = V5r(3) + V5(2) = 22 + 10 = 32（T7 m=2）
  have s5a : matchCount (PrismR2.V5 6 3) = matchCount (PrismR2.V5 6 (2 + 1)) := rfl
  have s5b : matchCount (PrismR2.V5r 6 3 i3) = matchCount (PrismR2.V5r 6 (2 + 1) i3) := rfl
  have A2 := PrismR2.T7 (N := 6) (m := 2) i3 (by simp [hi3]) (by omega) (by omega)
  rw [← s5a, ← s5b] at A2
  have hV53 : matchCount (PrismR2.V5 6 3) = 32 := by omega
  -- V3r(3) = V5r(3) + Cst(4) = 22 + 15 = 37（T4 m=3）
  have A3 := PrismR2.T4 (N := 6) (m := 3) i3 (by simp [hi3]) (by omega) (by omega)
  have hV3r3 : matchCount (PrismR2.V3r 6 3 i3) = 37 := by omega
  -- V3(3) = V3r(3) + V5(2) = 37 + 10 = 47（T3 m=3）
  have s7 : matchCount (PrismR2.V5 6 2) = matchCount (PrismR2.V5 6 (3 - 1)) := rfl
  have A4 := PrismR2.T3 (N := 6) (m := 3) i3 (by simp [hi3]) (by omega) (by omega)
  rw [← s7] at A4
  have hV33 : matchCount (PrismR2.V3 6 3) = 47 := by omega
  -- V7(3) = V3(2) + V5(2) = 14 + 10 = 24（T6 m=3）
  have s8a : matchCount (PrismR2.V3 6 2) = matchCount (PrismR2.V3 6 (3 - 1)) := rfl
  have A5 := PrismR2.T6 (N := 6) (m := 3) (by omega) (by omega)
  rw [← s8a, ← s7] at A5
  have hV73 : matchCount (PrismR2.V7 6 3) = 24 := by omega
  -- V5r(4) = V3(3) + V7(3) = 47 + 24 = 71（T1 m=3）
  have s9 : matchCount (PrismR2.V5r 6 4 i4) = matchCount (PrismR2.V5r 6 (3 + 1) i4) := rfl
  have A6 := PrismR2.T1 (N := 6) (m := 3) i4 (by simp [hi4]) (by omega) (by omega)
  rw [← s9] at A6
  have hV5r4 : matchCount (PrismR2.V5r 6 4 i4) = 71 := by omega
  -- V5(4) = V5r(4) + V5(3) = 71 + 32 = 103（T5 m=4）
  have s10 : matchCount (PrismR2.V5 6 3) = matchCount (PrismR2.V5 6 (4 - 1)) := rfl
  have A7 := PrismR2.T5 (N := 6) (m := 4) i4 (by simp [hi4]) (by omega) (by omega)
  rw [← s10] at A7
  have hV54 : matchCount (PrismR2.V5 6 4) = 103 := by omega
  -- Cst(6) = V5(4) + V3(3) = 103 + 47 = 150（T2 m=4）
  have s11a : matchCount (PrismR2.Cst 6 6) = matchCount (PrismR2.Cst 6 (4 + 2)) := rfl
  have s11b : matchCount (PrismR2.V3 6 3) = matchCount (PrismR2.V3 6 (4 - 1)) := rfl
  have A8 := PrismR2.T2 (N := 6) (m := 4) (by omega) (by omega)
  rw [← s11a, ← s11b] at A8
  omega

-- ===== T4f 强归纳 + R4 代数（纯 ℤ，探针逐字） =====

theorem aspoke_strong (D : ℕ → ℤ) (h0 : D 0 = 25) (h1 : D 1 = 86) (h2 : D 2 = 271) (h3 : D 3 = 876)
    (hr : ∀ k : ℕ, D (k+4) + D k = 2 * D (k+3) + 4 * D (k+2)) : ∀ m : ℕ, D m = aspoke m := by
  intro m
  induction m using Nat.strongRecOn with
  | ind n ih =>
    rcases Nat.lt_or_ge n 4 with hlt | hge
    · obtain rfl | rfl | rfl | rfl :=
        (show n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 3 by omega)
      · exact h0
      · exact h1
      · exact h2
      · exact h3
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 4 := ⟨n - 4, by omega⟩
      have hrk := hr k
      have e3 := ih (k + 3) (by omega)
      have e2 := ih (k + 2) (by omega)
      have e0 := ih k (by omega)
      simp only [aspoke]
      omega

theorem arim_strong (D : ℕ → ℤ) (h0 : D 0 = 26) (h1 : D 1 = 86) (h2 : D 2 = 274) (h3 : D 3 = 883)
    (hr : ∀ k : ℕ, D (k+4) + D k = 2 * D (k+3) + 4 * D (k+2)) : ∀ m : ℕ, D m = arim m := by
  intro m
  induction m using Nat.strongRecOn with
  | ind n ih =>
    rcases Nat.lt_or_ge n 4 with hlt | hge
    · obtain rfl | rfl | rfl | rfl :=
        (show n = 0 ∨ n = 1 ∨ n = 2 ∨ n = 3 by omega)
      · exact h0
      · exact h1
      · exact h2
      · exact h3
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 4 := ⟨n - 4, by omega⟩
      have hrk := hr k
      have e3 := ih (k + 3) (by omega)
      have e2 := ih (k + 2) (by omega)
      have e0 := ih k (by omega)
      simp only [arim]
      omega

theorem dspoke_r4 (a c : ℕ → ℤ)
    (ha : ∀ k : ℕ, a (k+4) + a k = 2 * a (k+3) + 4 * a (k+2))
    (hc : ∀ k : ℕ, 3 ≤ k → c (k+4) + c k = 2 * c (k+3) + 4 * c (k+2)) :
    ∀ k : ℕ, (a (k+7) + 2 * c (k+7) + a (k+5) - a (k+6)) + (a (k+3) + 2 * c (k+3) + a (k+1) - a (k+2))
      = 2 * (a (k+6) + 2 * c (k+6) + a (k+4) - a (k+5)) + 4 * (a (k+5) + 2 * c (k+5) + a (k+3) - a (k+4)) := by
  intro k
  -- omega 原子坑规避：ha (k+j) 展开为 a (k+j+4) 等嵌套形，须复述为与目标同形的 a (k+7) 等。
  have ha1 : a (k + 5) + a (k + 1) = 2 * a (k + 4) + 4 * a (k + 3) := by
    have h := ha (k + 1)
    rw [show k + 1 + 4 = k + 5 from by omega,
        show k + 1 + 3 = k + 4 from by omega,
        show k + 1 + 2 = k + 3 from by omega] at h
    exact h
  have ha2 : a (k + 6) + a (k + 2) = 2 * a (k + 5) + 4 * a (k + 4) := by
    have h := ha (k + 2)
    rw [show k + 2 + 4 = k + 6 from by omega,
        show k + 2 + 3 = k + 5 from by omega,
        show k + 2 + 2 = k + 4 from by omega] at h
    exact h
  have ha3 : a (k + 7) + a (k + 3) = 2 * a (k + 6) + 4 * a (k + 5) := by
    have h := ha (k + 3)
    rw [show k + 3 + 4 = k + 7 from by omega,
        show k + 3 + 3 = k + 6 from by omega,
        show k + 3 + 2 = k + 5 from by omega] at h
    exact h
  have hc3 : c (k + 7) + c (k + 3) = 2 * c (k + 6) + 4 * c (k + 5) := by
    have h := hc (k + 3) (by omega)
    rw [show k + 3 + 4 = k + 7 from by omega,
        show k + 3 + 3 = k + 6 from by omega,
        show k + 3 + 2 = k + 5 from by omega] at h
    exact h
  omega

theorem drim_r4 (a c : ℕ → ℤ)
    (ha : ∀ k : ℕ, a (k+4) + a k = 2 * a (k+3) + 4 * a (k+2))
    (hc : ∀ k : ℕ, 3 ≤ k → c (k+4) + c k = 2 * c (k+3) + 4 * c (k+2)) :
    ∀ k : ℕ, (a (k+7) + c (k+7)) + (a (k+3) + c (k+3)) = 2 * (a (k+6) + c (k+6)) + 4 * (a (k+5) + c (k+5)) := by
  intro k
  have ha3 : a (k + 7) + a (k + 3) = 2 * a (k + 6) + 4 * a (k + 5) := by
    have h := ha (k + 3)
    rw [show k + 3 + 4 = k + 7 from by omega,
        show k + 3 + 3 = k + 6 from by omega,
        show k + 3 + 2 = k + 5 from by omega] at h
    exact h
  have hc3 : c (k + 7) + c (k + 3) = 2 * c (k + 6) + 4 * c (k + 5) := by
    have h := hc (k + 3) (by omega)
    rw [show k + 3 + 4 = k + 7 from by omega,
        show k + 3 + 3 = k + 6 from by omega,
        show k + 3 + 2 = k + 5 from by omega] at h
    exact h
  omega

-- ===== 主桥收口：具体序列实例化 + D_spoke/D_rim 强归纳 =====

/-- 具体序列（ℤ 化）：a(n) = 梯子匹配数，c(n) = Cst 匹配数。 -/
def az : ℕ → ℤ := fun k => ((hosoya (pathGraph k □ pathGraph 2) : ℕ) : ℤ)
def cz : ℕ → ℤ := fun k => ((matchCount (PrismR2.Cst k k) : ℕ) : ℤ)

@[simp] theorem az_val (k : ℕ) : az k = ((hosoya (pathGraph k □ pathGraph 2) : ℕ) : ℤ) := rfl
@[simp] theorem cz_val (k : ℕ) : cz k = ((matchCount (PrismR2.Cst k k) : ℕ) : ℤ) := rfl

/-- a-R4 具体实例（由 hosoya_ladder_rec4）。 -/
theorem az_r4 (k : ℕ) : az (k+4) + az k = 2 * az (k+3) + 4 * az (k+2) := by
  have h := hosoya_ladder_rec4 k
  simp only [az_val]
  push_cast
  omega

/-- c-R4 具体实例（由 c_rec4'，ambient-free）。 -/
theorem cz_r4 (k : ℕ) (hk : 3 ≤ k) : cz (k+4) + cz k = 2 * cz (k+3) + 4 * cz (k+2) := by
  have h := c_rec4' k hk
  simp only [cz_val]
  push_cast
  omega

/-- D_spoke(m) = a(m+3) + 2c(m+3) + a(m+1) − a(m+2)（d_spoke 的 ℤ 表达）。 -/
def Dspoke : ℕ → ℤ := fun m => az (m+3) + 2 * cz (m+3) + az (m+1) - az (m+2)
/-- D_rim(m) = a(m+3) + c(m+3)（d_rim 的 ℤ 表达）。 -/
def Drim : ℕ → ℤ := fun m => az (m+3) + cz (m+3)

@[simp] theorem Dspoke_val (m : ℕ) :
    Dspoke m = az (m+3) + 2 * cz (m+3) + az (m+1) - az (m+2) := rfl
@[simp] theorem Drim_val (m : ℕ) : Drim m = az (m+3) + cz (m+3) := rfl

theorem Dspoke_r4 (k : ℕ) : Dspoke (k+4) + Dspoke k = 2 * Dspoke (k+3) + 4 * Dspoke (k+2) := by
  simpa only [Dspoke_val, Nat.add_assoc, Nat.reduceAdd] using
    dspoke_r4 az cz az_r4 (fun j hj => cz_r4 j hj) k

theorem Drim_r4 (k : ℕ) : Drim (k+4) + Drim k = 2 * Drim (k+3) + 4 * Drim (k+2) := by
  simpa only [Drim_val, Nat.add_assoc, Nat.reduceAdd] using drim_r4 az cz az_r4 (fun j hj => cz_r4 j hj) k

-- 具体序列数值（az1..az6 / cz3..cz6）
theorem az1 : az 1 = 2 := by rw [az_val, hosoya_lad1]; norm_num
theorem az2 : az 2 = 7 := by rw [az_val, hosoya_lad2]; norm_num
theorem az3 : az 3 = 22 := by rw [az_val, hosoya_lad3]; norm_num
theorem az4 : az 4 = 71 := by rw [az_val, a4]; norm_num
theorem az5 : az 5 = 228 := by rw [az_val, a5]; norm_num
theorem az6 : az 6 = 733 := by rw [az_val, a6]; norm_num
theorem cz3 : cz 3 = 4 := by rw [cz_val, c3]; norm_num
theorem cz4 : cz 4 = 15 := by rw [cz_val, c4]; norm_num
theorem cz5 : cz 5 = 46 := by rw [cz_val, c5]; norm_num
theorem cz6 : cz 6 = 150 := by rw [cz_val, c6]; norm_num

/-- D_spoke 初值：25, 86, 271, 876。 -/
theorem Dspoke0 : Dspoke 0 = 25 := by
  simp only [Dspoke_val, Nat.zero_add, az3, cz3, az1, az2]
  norm_num
theorem Dspoke1 : Dspoke 1 = 86 := by
  simp only [Dspoke_val, Nat.reduceAdd, az4, cz4, az2, az3]
  norm_num
theorem Dspoke2 : Dspoke 2 = 271 := by
  simp only [Dspoke_val, Nat.reduceAdd, az5, cz5, az3, az4]
  norm_num
theorem Dspoke3 : Dspoke 3 = 876 := by
  simp only [Dspoke_val, Nat.reduceAdd, az6, cz6, az4, az5]
  norm_num

/-- D_rim 初值：26, 86, 274, 883。 -/
theorem Drim0 : Drim 0 = 26 := by
  simp only [Drim_val, Nat.zero_add, az3, cz3]
  norm_num
theorem Drim1 : Drim 1 = 86 := by
  simp only [Drim_val, Nat.reduceAdd, az4, cz4]
  norm_num
theorem Drim2 : Drim 2 = 274 := by
  simp only [Drim_val, Nat.reduceAdd, az5, cz5]
  norm_num
theorem Drim3 : Drim 3 = 883 := by
  simp only [Drim_val, Nat.reduceAdd, az6, cz6]
  norm_num

/-- **主桥（spoke 侧）**：ℤ 口径下 hosoya (prismDelSpoke (m+3)) = D_spoke(m)。
三式 omega 消元：hosoya_prism_mc + delspoke_eq + p_decomp。 -/
theorem dspoke_cast (m : ℕ) (hm : 3 ≤ m + 3) :
    ((hosoya (prismDelSpoke (m+3) hm) : ℕ) : ℤ) = Dspoke m := by
  have h0 := hosoya_prism_mc m
  have h1 := delspoke_eq m hm
  have h2 := p_decomp m
  simp only [Dspoke_val, az_val, cz_val]
  push_cast
  omega

/-- **主桥（rim 侧）**：ℤ 口径下 hosoya (prismDelRim (m+3)) = D_rim(m)。 -/
theorem drim_cast (m : ℕ) (hm : 3 ≤ m + 3) :
    ((hosoya (prismDelRim (m+3) hm) : ℕ) : ℤ) = Drim m := by
  have h := delrim_eq m hm
  simp only [Drim_val, az_val, cz_val]
  push_cast
  omega

/-- 强归纳收口（spoke 侧）：D_spoke(m) = aspoke(m)。 -/
theorem dspoke_val (m : ℕ) (hm : 3 ≤ m + 3) :
    ((hosoya (prismDelSpoke (m+3) hm) : ℕ) : ℤ) = aspoke m := by
  have h0 := dspoke_cast m hm
  have h1 := aspoke_strong Dspoke Dspoke0 Dspoke1 Dspoke2 Dspoke3 Dspoke_r4 m
  omega

/-- 强归纳收口（rim 侧）：D_rim(m) = arim(m)。 -/
theorem drim_val (m : ℕ) (hm : 3 ≤ m + 3) :
    ((hosoya (prismDelRim (m+3) hm) : ℕ) : ℤ) = arim m := by
  have h0 := drim_cast m hm
  have h1 := arim_strong Drim Drim0 Drim1 Drim2 Drim3 Drim_r4 m
  omega

end PrismR3

-- ===== 冻结定理头（statement.lean L90–98 逐字，占位符已替换为实证证明体） =====

/-- **主定理一（spoke 侧桥定理）**：对一切 `n ≥ 3`，删一条 spoke 的棱柱的匹配数等于序列
`aspoke (n - 3)`。其中 `aspoke` 为已冻结序列（初值 25, 86, 271, 876，四阶递推
`a(n+4) = 2·a(n+3) + 4·a(n+2) − a(n)`，下标 0 对应图侧 n = 3）。 -/
theorem hosoya_prism_del_spoke : ∀ (n : ℕ) (hn : 3 ≤ n),
    (hosoya (prismDelSpoke n hn) : ℤ) = aspoke (n - 3) := by
  intro n hn
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 3 := ⟨n - 3, by omega⟩
  rw [show m + 3 - 3 = m from by omega]
  exact PrismR3.dspoke_val m hn

/-- **主定理二（rim 侧桥定理）**：对一切 `n ≥ 3`，删一条 rim 边的棱柱的匹配数等于序列
`arim (n - 3)`。其中 `arim` 为已冻结序列（初值 26, 86, 274, 883，同四阶递推）。 -/
theorem hosoya_prism_del_rim : ∀ (n : ℕ) (hn : 3 ≤ n),
    (hosoya (prismDelRim n hn) : ℤ) = arim (n - 3) := by
  intro n hn
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 3 := ⟨n - 3, by omega⟩
  rw [show m + 3 - 3 = m from by omega]
  exact PrismR3.drim_val m hn
