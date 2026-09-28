/-
  AI4Math 流水线 · AI 生成 · 2026-09-28
  部门：04 军政部（dept-prove）终稿组装 + 02 形式化部 statement 冻结
  任务线：comb09-4ntwocorner（pool-comb-09，4×n 删右列上下两角全匹配）
  来源卡：tasks/20260928-comb09-4ntwocorner/card.md（闸门一 2026-09-28 立项）
  五条 def 与三条 theorem 的 statement（含 docstring）逐字拷贝自冻结快照
    formalized/01-comb09-4ntwocorner-statements.statement.txt
    （sha256 4cb1083846bcc64e249717309e63d071d0ecf5bb03f23d85affeaab8152ce005），
    仅证明体由占据位替换为完整证明（SOP 04 纪律：proof body 之外零改动）。
  合并来源（各经 scripts/lean-verify 严格模式单文件 EXIT=0 验证，proof 逐字合并）：
    T1 主攻 atc_interleave   ← attempts/final-atc_interleave.lean
      （辅助引理 atc_sq：平方递推 = 主递推 10 实例 linear_combination，
       证书 (1,1,−23,−29,91,111,−41,−41,9,1) 经 python 符号展开 + a(1..50) 数值双核证）；
    T2 伴随 atc_mod2_period5  ← attempts/final-atc_mod2_period5.lean（强归纳 + mod_cases 五留数类）；
    T3 伴随 atc_mod4_period10 ← attempts/final-atc_mod4_period10.lean（同构十留数类）。
  口径（按任务卡锁定）：纯序列（ℕ → ℤ）定理，statement 不含图/网格/匹配组合对象；
  组合语义桥 = OEIS/文献背书 + 探针猜想层降级声明，不进 kernel 主张。
  索引口径（0-based Lean ↔ 1-based 计数）：atc n = a(n+1)；ot k = a(2k+1)；et k = a(2k+2)。
  具名引理 Nat.strong_induction_on / Nat.ModEq 均经 r0 批量 #check 核验在册
  （attempts/r0-precheck.lean/.log）。
-/
import Mathlib

/-- **序列 atc（主列，九阶全滞后递推）**。
初值 a(0..8) = 2, 15, 209, 2426, 29566, 355504, 4290501, 51728089, 623832332
（0-based；1-based 即 a(1..9)，逐位取自卡面与 counts.txt）；
递推 atc(n+9) = 9·atc(n+8) + 41·atc(n+7) − 41·atc(n+6) − 111·atc(n+5)
  + 91·atc(n+4) + 29·atc(n+3) − 23·atc(n+2) − atc(n+1) + atc(n)（n ≥ 0）。 -/
def atc : ℕ → ℤ
  | 0 => 2
  | 1 => 15
  | 2 => 209
  | 3 => 2426
  | 4 => 29566
  | 5 => 355504
  | 6 => 4290501
  | 7 => 51728089
  | 8 => 623832332
  | n + 9 =>
      9 * atc (n + 8) + 41 * atc (n + 7) - 41 * atc (n + 6) - 111 * atc (n + 5)
        + 91 * atc (n + 4) + 29 * atc (n + 3) - 23 * atc (n + 2) - atc (n + 1) + atc n

/-- **序列 ot（奇位侧子列，九阶递推）**：ot k = a(2k+1)。
初值 o(0..8) = 2, 209, 29566, 4290501, 623832332, 90717725366,
  13192325177001, 1918451920976894, 278984786074420317
（= atc 在下标 0,2,…,16 处之值，即 1-based a(1),a(3),…,a(17)）；
递推 ot(k+9) = 163·ot(k+8) − 2641·ot(k+7) + 12479·ot(k+6) − 22577·ot(k+5)
  + 16705·ot(k+4) − 5331·ot(k+3) + 769·ot(k+2) − 47·ot(k+1) + ot(k)（k ≥ 0）。 -/
def ot : ℕ → ℤ
  | 0 => 2
  | 1 => 209
  | 2 => 29566
  | 3 => 4290501
  | 4 => 623832332
  | 5 => 90717725366
  | 6 => 13192325177001
  | 7 => 1918451920976894
  | 8 => 278984786074420317
  | k + 9 =>
      163 * ot (k + 8) - 2641 * ot (k + 7) + 12479 * ot (k + 6) - 22577 * ot (k + 5)
        + 16705 * ot (k + 4) - 5331 * ot (k + 3) + 769 * ot (k + 2) - 47 * ot (k + 1) + ot k

/-- **序列 et（偶位侧子列，九阶递推）**：et k = a(2k+2)。
初值 e(0..8) = 15, 2426, 355504, 51728089, 7522727192, 1093972462647,
  159087517952550, 23134798325751388, 3364304696158749633
（= atc 在下标 1,3,…,17 处之值，即 1-based a(2),a(4),…,a(18)）；
递推 et(k+9) = 163·et(k+8) − 2641·et(k+7) + 12479·et(k+6) − 22577·et(k+5)
  + 16705·et(k+4) − 5331·et(k+3) + 769·et(k+2) − 47·et(k+1) + et(k)（k ≥ 0）。 -/
def et : ℕ → ℤ
  | 0 => 15
  | 1 => 2426
  | 2 => 355504
  | 3 => 51728089
  | 4 => 7522727192
  | 5 => 1093972462647
  | 6 => 159087517952550
  | 7 => 23134798325751388
  | 8 => 3364304696158749633
  | k + 9 =>
      163 * et (k + 8) - 2641 * et (k + 7) + 12479 * et (k + 6) - 22577 * et (k + 5)
        + 16705 * et (k + 4) - 5331 * et (k + 3) + 769 * et (k + 2) - 47 * et (k + 1) + et k

/-- **余数样式 pat2**（mod 5 留数类 ↦ mod 2 余数，0-based）：
0↦0, 1↦1, 2↦1，其余↦0（即 atc n 为奇 ⟺ n ≡ 1 或 2 (mod 5)；
1-based 口径：a(k) 为奇 ⟺ k ≡ 2 或 3 (mod 5)）。 -/
def pat2 : ℕ → ℤ
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | _ => 0

/-- **余数样式 pat4**（mod 10 留数类 ↦ mod 4 余数，0-based）：
r ↦ a(r+1) mod 4，r = 0..9 依次 (2,3,1,2,2,0,1,1,0,0)
（1-based 口径：a(k) mod 4 按 k mod 10，k=1..10 同为 (2,3,1,2,2,0,1,1,0,0)）。 -/
def pat4 : ℕ → ℤ
  | 0 => 2
  | 1 => 3
  | 2 => 1
  | 3 => 2
  | 4 => 2
  | 5 => 0
  | 6 => 1
  | 7 => 1
  | _ => 0

/-- **辅助引理 atc_sq（平方递推，T1 的关键中间件）**：主列 atc 自身满足
偶滞后 18 的递推（= 子列递推 s(y) 在 y=x² 处的拉回 s(x²) = −p(x)p(−x)，
q(E)a(n) = 0 由主递推的 10 个相邻实例线性组合给出，无需归纳）。
系数证书 (h0..h9) ↦ (1,1,−23,−29,91,111,−41,−41,9,1) 经 python 符号展开
与 a(1..50) 数值逐项核验（r1 准备记录）。 -/
theorem atc_sq (n : ℕ) :
    atc (n + 18) = 163 * atc (n + 16) - 2641 * atc (n + 14) + 12479 * atc (n + 12)
      - 22577 * atc (n + 10) + 16705 * atc (n + 8) - 5331 * atc (n + 6)
        + 769 * atc (n + 4) - 47 * atc (n + 2) + atc n := by
  have e : ∀ m : ℕ, atc (m + 9)
      = 9 * atc (m + 8) + 41 * atc (m + 7) - 41 * atc (m + 6) - 111 * atc (m + 5)
        + 91 * atc (m + 4) + 29 * atc (m + 3) - 23 * atc (m + 2) - atc (m + 1) + atc m :=
    fun m => by simp only [atc]
  have h0 : atc (n + 9) = 9 * atc (n + 8) + 41 * atc (n + 7) - 41 * atc (n + 6)
      - 111 * atc (n + 5) + 91 * atc (n + 4) + 29 * atc (n + 3) - 23 * atc (n + 2)
      - atc (n + 1) + atc n := e n
  have h1 : atc (n + 10) = 9 * atc (n + 9) + 41 * atc (n + 8) - 41 * atc (n + 7)
      - 111 * atc (n + 6) + 91 * atc (n + 5) + 29 * atc (n + 4) - 23 * atc (n + 3)
      - atc (n + 2) + atc (n + 1) := e (n + 1)
  have h2 : atc (n + 11) = 9 * atc (n + 10) + 41 * atc (n + 9) - 41 * atc (n + 8)
      - 111 * atc (n + 7) + 91 * atc (n + 6) + 29 * atc (n + 5) - 23 * atc (n + 4)
      - atc (n + 3) + atc (n + 2) := e (n + 2)
  have h3 : atc (n + 12) = 9 * atc (n + 11) + 41 * atc (n + 10) - 41 * atc (n + 9)
      - 111 * atc (n + 8) + 91 * atc (n + 7) + 29 * atc (n + 6) - 23 * atc (n + 5)
      - atc (n + 4) + atc (n + 3) := e (n + 3)
  have h4 : atc (n + 13) = 9 * atc (n + 12) + 41 * atc (n + 11) - 41 * atc (n + 10)
      - 111 * atc (n + 9) + 91 * atc (n + 8) + 29 * atc (n + 7) - 23 * atc (n + 6)
      - atc (n + 5) + atc (n + 4) := e (n + 4)
  have h5 : atc (n + 14) = 9 * atc (n + 13) + 41 * atc (n + 12) - 41 * atc (n + 11)
      - 111 * atc (n + 10) + 91 * atc (n + 9) + 29 * atc (n + 8) - 23 * atc (n + 7)
      - atc (n + 6) + atc (n + 5) := e (n + 5)
  have h6 : atc (n + 15) = 9 * atc (n + 14) + 41 * atc (n + 13) - 41 * atc (n + 12)
      - 111 * atc (n + 11) + 91 * atc (n + 10) + 29 * atc (n + 9) - 23 * atc (n + 8)
      - atc (n + 7) + atc (n + 6) := e (n + 6)
  have h7 : atc (n + 16) = 9 * atc (n + 15) + 41 * atc (n + 14) - 41 * atc (n + 13)
      - 111 * atc (n + 12) + 91 * atc (n + 11) + 29 * atc (n + 10) - 23 * atc (n + 9)
      - atc (n + 8) + atc (n + 7) := e (n + 7)
  have h8 : atc (n + 17) = 9 * atc (n + 16) + 41 * atc (n + 15) - 41 * atc (n + 14)
      - 111 * atc (n + 13) + 91 * atc (n + 12) + 29 * atc (n + 11) - 23 * atc (n + 10)
      - atc (n + 9) + atc (n + 8) := e (n + 8)
  have h9 : atc (n + 18) = 9 * atc (n + 17) + 41 * atc (n + 16) - 41 * atc (n + 15)
      - 111 * atc (n + 14) + 91 * atc (n + 13) + 29 * atc (n + 12) - 23 * atc (n + 11)
      - atc (n + 10) + atc (n + 9) := e (n + 9)
  linear_combination h9 + 9 * h8 - 41 * h7 - 41 * h6 + 111 * h5 + 91 * h4
    - 29 * h3 - 23 * h2 + h1 + h0

/-- **T1（主攻）交织恒等式**：完整九阶递推 = 两条同签名九阶子列的交织——
对一切 k，atc(2k) = ot k 且 atc(2k+1) = et k
（子列递推 = 主递推特征多项式的平方合取 p(x)p(−x) 面，无阶下降）。 -/
theorem atc_interleave (k : ℕ) :
    atc (2 * k) = ot k ∧ atc (2 * k + 1) = et k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    by_cases hk : k < 9
    · interval_cases k <;> decide
    · obtain ⟨j, rfl⟩ : ∃ j, k = j + 9 := ⟨k - 9, by omega⟩
      constructor
      · have e18 : 2 * (j + 9) = 2 * j + 18 := by ring
        rw [e18, atc_sq]
        simp only [ot]
        rw [show 2 * j + 16 = 2 * (j + 8) by ring,
            show 2 * j + 14 = 2 * (j + 7) by ring,
            show 2 * j + 12 = 2 * (j + 6) by ring,
            show 2 * j + 10 = 2 * (j + 5) by ring,
            show 2 * j + 8 = 2 * (j + 4) by ring,
            show 2 * j + 6 = 2 * (j + 3) by ring,
            show 2 * j + 4 = 2 * (j + 2) by ring,
            show 2 * j + 2 = 2 * (j + 1) by ring,
            (ih (j + 8) (by omega)).1, (ih (j + 7) (by omega)).1,
            (ih (j + 6) (by omega)).1, (ih (j + 5) (by omega)).1,
            (ih (j + 4) (by omega)).1, (ih (j + 3) (by omega)).1,
            (ih (j + 2) (by omega)).1, (ih (j + 1) (by omega)).1,
            (ih j (by omega)).1]
      · have e19 : 2 * (j + 9) + 1 = 2 * j + 1 + 18 := by ring
        rw [e19, atc_sq]
        simp only [et]
        rw [show 2 * j + 1 + 16 = 2 * (j + 8) + 1 by ring,
            show 2 * j + 1 + 14 = 2 * (j + 7) + 1 by ring,
            show 2 * j + 1 + 12 = 2 * (j + 6) + 1 by ring,
            show 2 * j + 1 + 10 = 2 * (j + 5) + 1 by ring,
            show 2 * j + 1 + 8 = 2 * (j + 4) + 1 by ring,
            show 2 * j + 1 + 6 = 2 * (j + 3) + 1 by ring,
            show 2 * j + 1 + 4 = 2 * (j + 2) + 1 by ring,
            show 2 * j + 1 + 2 = 2 * (j + 1) + 1 by ring,
            (ih (j + 8) (by omega)).2, (ih (j + 7) (by omega)).2,
            (ih (j + 6) (by omega)).2, (ih (j + 5) (by omega)).2,
            (ih (j + 4) (by omega)).2, (ih (j + 3) (by omega)).2,
            (ih (j + 2) (by omega)).2, (ih (j + 1) (by omega)).2,
            (ih j (by omega)).2]

set_option maxHeartbeats 1600000 in
/-- **T2（伴随）**：atc 的 mod 2 余数仅依赖 n mod 5，样式为 pat2。 -/
theorem atc_mod2_period5 (n r : ℕ) (hr : n % 5 = r) :
    atc n % 2 = pat2 r := by
  have main : ∀ n : ℕ, atc n % 2 = pat2 (n % 5) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 9
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
        have h1 : atc (j + 9) % 2
            = (atc (j + 8) % 2 + atc (j + 7) % 2 - atc (j + 6) % 2 - atc (j + 5) % 2
                + atc (j + 4) % 2 + atc (j + 3) % 2 - atc (j + 2) % 2 - atc (j + 1) % 2
                + atc j % 2) % 2 := by
          simp only [atc]
          omega
        rw [h1, ih (j + 8) (by omega), ih (j + 7) (by omega), ih (j + 6) (by omega),
            ih (j + 5) (by omega), ih (j + 4) (by omega), ih (j + 3) (by omega),
            ih (j + 2) (by omega), ih (j + 1) (by omega), ih j (by omega)]
        mod_cases hj : j % 5
        · have hj0 : j % 5 = 0 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 5 = 1 := by omega
          have hj2 : (j + 2) % 5 = 2 := by omega
          have hj3 : (j + 3) % 5 = 3 := by omega
          have hj4 : (j + 4) % 5 = 4 := by omega
          have hj5 : (j + 5) % 5 = 0 := by omega
          have hj6 : (j + 6) % 5 = 1 := by omega
          have hj7 : (j + 7) % 5 = 2 := by omega
          have hj8 : (j + 8) % 5 = 3 := by omega
          have hj9 : (j + 9) % 5 = 4 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 5 = 1 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 5 = 2 := by omega
          have hj2 : (j + 2) % 5 = 3 := by omega
          have hj3 : (j + 3) % 5 = 4 := by omega
          have hj4 : (j + 4) % 5 = 0 := by omega
          have hj5 : (j + 5) % 5 = 1 := by omega
          have hj6 : (j + 6) % 5 = 2 := by omega
          have hj7 : (j + 7) % 5 = 3 := by omega
          have hj8 : (j + 8) % 5 = 4 := by omega
          have hj9 : (j + 9) % 5 = 0 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 5 = 2 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 5 = 3 := by omega
          have hj2 : (j + 2) % 5 = 4 := by omega
          have hj3 : (j + 3) % 5 = 0 := by omega
          have hj4 : (j + 4) % 5 = 1 := by omega
          have hj5 : (j + 5) % 5 = 2 := by omega
          have hj6 : (j + 6) % 5 = 3 := by omega
          have hj7 : (j + 7) % 5 = 4 := by omega
          have hj8 : (j + 8) % 5 = 0 := by omega
          have hj9 : (j + 9) % 5 = 1 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 5 = 3 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 5 = 4 := by omega
          have hj2 : (j + 2) % 5 = 0 := by omega
          have hj3 : (j + 3) % 5 = 1 := by omega
          have hj4 : (j + 4) % 5 = 2 := by omega
          have hj5 : (j + 5) % 5 = 3 := by omega
          have hj6 : (j + 6) % 5 = 4 := by omega
          have hj7 : (j + 7) % 5 = 0 := by omega
          have hj8 : (j + 8) % 5 = 1 := by omega
          have hj9 : (j + 9) % 5 = 2 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 5 = 4 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 5 = 0 := by omega
          have hj2 : (j + 2) % 5 = 1 := by omega
          have hj3 : (j + 3) % 5 = 2 := by omega
          have hj4 : (j + 4) % 5 = 3 := by omega
          have hj5 : (j + 5) % 5 = 4 := by omega
          have hj6 : (j + 6) % 5 = 0 := by omega
          have hj7 : (j + 7) % 5 = 1 := by omega
          have hj8 : (j + 8) % 5 = 2 := by omega
          have hj9 : (j + 9) % 5 = 3 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
  rw [← hr]; exact main n

set_option maxHeartbeats 3200000 in
/-- **T3（伴随）**：atc 的 mod 4 余数仅依赖 n mod 10，样式为 pat4。 -/
theorem atc_mod4_period10 (n r : ℕ) (hr : n % 10 = r) :
    atc n % 4 = pat4 r := by
  have main : ∀ n : ℕ, atc n % 4 = pat4 (n % 10) := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      by_cases hn : n < 9
      · interval_cases n <;> decide
      · obtain ⟨j, rfl⟩ : ∃ j, n = j + 9 := ⟨n - 9, by omega⟩
        have h1 : atc (j + 9) % 4
            = (atc (j + 8) % 4 + atc (j + 7) % 4 - atc (j + 6) % 4 + atc (j + 5) % 4
                - atc (j + 4) % 4 + atc (j + 3) % 4 + atc (j + 2) % 4 - atc (j + 1) % 4
                + atc j % 4) % 4 := by
          simp only [atc]
          omega
        rw [h1, ih (j + 8) (by omega), ih (j + 7) (by omega), ih (j + 6) (by omega),
            ih (j + 5) (by omega), ih (j + 4) (by omega), ih (j + 3) (by omega),
            ih (j + 2) (by omega), ih (j + 1) (by omega), ih j (by omega)]
        mod_cases hj : j % 10
        · have hj0 : j % 10 = 0 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 1 := by omega
          have hj2 : (j + 2) % 10 = 2 := by omega
          have hj3 : (j + 3) % 10 = 3 := by omega
          have hj4 : (j + 4) % 10 = 4 := by omega
          have hj5 : (j + 5) % 10 = 5 := by omega
          have hj6 : (j + 6) % 10 = 6 := by omega
          have hj7 : (j + 7) % 10 = 7 := by omega
          have hj8 : (j + 8) % 10 = 8 := by omega
          have hj9 : (j + 9) % 10 = 9 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 1 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 2 := by omega
          have hj2 : (j + 2) % 10 = 3 := by omega
          have hj3 : (j + 3) % 10 = 4 := by omega
          have hj4 : (j + 4) % 10 = 5 := by omega
          have hj5 : (j + 5) % 10 = 6 := by omega
          have hj6 : (j + 6) % 10 = 7 := by omega
          have hj7 : (j + 7) % 10 = 8 := by omega
          have hj8 : (j + 8) % 10 = 9 := by omega
          have hj9 : (j + 9) % 10 = 0 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 2 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 3 := by omega
          have hj2 : (j + 2) % 10 = 4 := by omega
          have hj3 : (j + 3) % 10 = 5 := by omega
          have hj4 : (j + 4) % 10 = 6 := by omega
          have hj5 : (j + 5) % 10 = 7 := by omega
          have hj6 : (j + 6) % 10 = 8 := by omega
          have hj7 : (j + 7) % 10 = 9 := by omega
          have hj8 : (j + 8) % 10 = 0 := by omega
          have hj9 : (j + 9) % 10 = 1 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 3 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 4 := by omega
          have hj2 : (j + 2) % 10 = 5 := by omega
          have hj3 : (j + 3) % 10 = 6 := by omega
          have hj4 : (j + 4) % 10 = 7 := by omega
          have hj5 : (j + 5) % 10 = 8 := by omega
          have hj6 : (j + 6) % 10 = 9 := by omega
          have hj7 : (j + 7) % 10 = 0 := by omega
          have hj8 : (j + 8) % 10 = 1 := by omega
          have hj9 : (j + 9) % 10 = 2 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 4 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 5 := by omega
          have hj2 : (j + 2) % 10 = 6 := by omega
          have hj3 : (j + 3) % 10 = 7 := by omega
          have hj4 : (j + 4) % 10 = 8 := by omega
          have hj5 : (j + 5) % 10 = 9 := by omega
          have hj6 : (j + 6) % 10 = 0 := by omega
          have hj7 : (j + 7) % 10 = 1 := by omega
          have hj8 : (j + 8) % 10 = 2 := by omega
          have hj9 : (j + 9) % 10 = 3 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 5 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 6 := by omega
          have hj2 : (j + 2) % 10 = 7 := by omega
          have hj3 : (j + 3) % 10 = 8 := by omega
          have hj4 : (j + 4) % 10 = 9 := by omega
          have hj5 : (j + 5) % 10 = 0 := by omega
          have hj6 : (j + 6) % 10 = 1 := by omega
          have hj7 : (j + 7) % 10 = 2 := by omega
          have hj8 : (j + 8) % 10 = 3 := by omega
          have hj9 : (j + 9) % 10 = 4 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 6 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 7 := by omega
          have hj2 : (j + 2) % 10 = 8 := by omega
          have hj3 : (j + 3) % 10 = 9 := by omega
          have hj4 : (j + 4) % 10 = 0 := by omega
          have hj5 : (j + 5) % 10 = 1 := by omega
          have hj6 : (j + 6) % 10 = 2 := by omega
          have hj7 : (j + 7) % 10 = 3 := by omega
          have hj8 : (j + 8) % 10 = 4 := by omega
          have hj9 : (j + 9) % 10 = 5 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 7 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 8 := by omega
          have hj2 : (j + 2) % 10 = 9 := by omega
          have hj3 : (j + 3) % 10 = 0 := by omega
          have hj4 : (j + 4) % 10 = 1 := by omega
          have hj5 : (j + 5) % 10 = 2 := by omega
          have hj6 : (j + 6) % 10 = 3 := by omega
          have hj7 : (j + 7) % 10 = 4 := by omega
          have hj8 : (j + 8) % 10 = 5 := by omega
          have hj9 : (j + 9) % 10 = 6 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 8 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 9 := by omega
          have hj2 : (j + 2) % 10 = 0 := by omega
          have hj3 : (j + 3) % 10 = 1 := by omega
          have hj4 : (j + 4) % 10 = 2 := by omega
          have hj5 : (j + 5) % 10 = 3 := by omega
          have hj6 : (j + 6) % 10 = 4 := by omega
          have hj7 : (j + 7) % 10 = 5 := by omega
          have hj8 : (j + 8) % 10 = 6 := by omega
          have hj9 : (j + 9) % 10 = 7 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
        · have hj0 : j % 10 = 9 := by simpa [Nat.ModEq] using hj
          have hj1 : (j + 1) % 10 = 0 := by omega
          have hj2 : (j + 2) % 10 = 1 := by omega
          have hj3 : (j + 3) % 10 = 2 := by omega
          have hj4 : (j + 4) % 10 = 3 := by omega
          have hj5 : (j + 5) % 10 = 4 := by omega
          have hj6 : (j + 6) % 10 = 5 := by omega
          have hj7 : (j + 7) % 10 = 6 := by omega
          have hj8 : (j + 8) % 10 = 7 := by omega
          have hj9 : (j + 9) % 10 = 8 := by omega
          rw [hj0, hj1, hj2, hj3, hj4, hj5, hj6, hj7, hj8, hj9]
          decide
  rw [← hr]; exact main n
