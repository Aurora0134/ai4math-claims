# 检索证据包（候选 03 · edgemid-pipeline · P1/P2）

- 任务：`tasks/20260926-edgemid-pipeline`（卡 `tasks/20260926-edgemid-pipeline/card.md`）。
- 供料对象：宪兵（闸门二）、军政部（攻证）、监察院（终审）、外交部/翻译部（措辞与划界）。
- 输入：两冻结 statement `formalized/edgemid-p1-statement.lean`、`formalized/edgemid-p2-statement.lean`（本目录）；任务卡；审题卡 `tasks/20260926-beian-extselect/candidates/03-edgemid-monomer-dimer-review.md`。
- 检索渠道与实录（2026-09-26，检索员）：**本地 mathlib ripgrep 为主证**（`verify-proj/.lake/packages/mathlib`，钉死 v4.34.0 / rev 5ed29652）；Loogle 直连 3 次成功（经 `curl -x http://127.0.0.1:4180 --ssl-no-revoke`，分别核验 `Int.modEq_iff_dvd`、`mul_smul_comm`、`pow_add` 的模块与类型，与本地 rg 一致）；**LeanSearch 2 次失败（HTTP 502，如实记）**，其应覆盖项由本地 rg + Loogle 补齐。全部 file:line 均为本轮 rg/sed 实测，非沿用审题卡（审题卡 :79-95 旧值与本轮一致处予以对照确认）。
- AI 生成（2026-09-26 检索员，dynamic-workflow 子代理）。

## ① C3 预检 7 引理逐条

「7 引理」= 闸门二 gate-batch **p2 批次 CHECK 段的 7 条**（`audit/gate-p2-welldef.txt`：`CHECK Int.modEq_iff_dvd OK`、`CHECK Int.ModEq.trans OK`、`CHECK Matrix.smul_mulVec OK`、`CHECK Matrix.mulVec_mulVec OK`、`CHECK Matrix.add_mulVec OK`、`CHECK Matrix.sub_mulVec OK`、`CHECK mul_smul_comm OK`）；p1 批次跑其中 Int 2 条（`audit/gate-p1-welldef.txt`，import 面所限，口径见 `formalized/roundtrip.md` 第 0 节第 4 条与 budget.log 21:37/22:02 行）。全部 7 条在 r1/r3 冒烟中亦 #check 通过（审题卡 :79-95 预检引理清单）。

| # | 引理 | mathlib file:line（本轮实测） | 精确签名（源文本，含所在上下文） | 在 P1/P2 中的角色 |
|---|---|---|---|---|
| 1 | `Int.modEq_iff_dvd` | `Mathlib/Data/Int/ModEq.lean:105` | `theorem modEq_iff_dvd : a ≡ b [ZMOD n] ↔ n ∣ b - a`（binder 隐式，来自 `variable {m n a b c d : ℤ}`；别名 `⟨ModEq.dvd, modEq_of_dvd⟩` 于 :113） | **P1 周期支主桥**：目标 `c (n+6) ≡ c n [ZMOD 2]` 化为整除式 `2 ∣ c n - c (n+6)`，差式经 `h n` 重写 + `ring` 收成 `2·(2c(n+5)+7c(n+4)−5c(n+2))`（冒烟 r3 :20-22） |
| 2 | `Int.ModEq.trans` | `Mathlib/Data/Int/ModEq.lean:78` | `@[trans] protected theorem trans : a ≡ b [ZMOD n] → b ≡ c [ZMOD n] → a ≡ c [ZMOD n]` | **P1 商归纳拼接件**：`aux` 的 k+1 步 `key (n+6*k)`.trans `(ih n)`（r3 :34）；刻画支 `c n ≡ c (n % 6)` 整体复用 `aux`（r3 :36-39） |
| 3 | `Int.ModEq.refl` | `Mathlib/Data/Int/ModEq.lean:67` | `@[refl, simp] protected theorem refl (a : ℤ) : a ≡ a [ZMOD n]` | **P1 商归纳基础件**：k=0 情形 `exact Int.ModEq.refl _`（r3 :29） |
| 4 | `Matrix.add_mulVec` | `Mathlib/Data/Matrix/Mul.lean:797` | `theorem add_mulVec [Fintype n] (A B : Matrix m n α) (x : n → α) : (A + B) *ᵥ x = A *ᵥ x + B *ᵥ x`（`namespace Matrix` :286 起；section NonUnitalNonAssocSemiring :687-876，`variable [NonUnitalNonAssocSemiring α]` :689） | **P2 mulVec 分配件**：hgen 产生的矩阵多项和 `(4•T^(n+5) + 14•T^(n+4) + …) *ᵥ v` 按加项拆分（r3 :55，两处） |
| 5 | `Matrix.sub_mulVec` | `Mathlib/Data/Matrix/Mul.lean:1074` | `theorem sub_mulVec [Fintype n] (A B : Matrix m n α) (x : n → α) : (A - B) *ᵥ x = A *ᵥ x - B *ᵥ x`（section NonUnitalNonAssocRing :1043 起） | **P2 mulVec 分配件（减法侧）**：对 `−10 • T^(n+2)` 项拆分（r3 :55） |
| 6 | `Matrix.smul_mulVec` | `Mathlib/Data/Matrix/Mul.lean:818` | `theorem smul_mulVec [Fintype n] [DistribSMul R α] [IsScalarTower R α α] (b : R) (M : Matrix m n α) (v : n → α) : (b • M) *ᵥ v = b • M *ᵥ v` | **P2 标量提取件**：`(b • M) *ᵥ v` 中标量提到分量外（r3 :56 ×3），随后 `first \| rfl \| …` 多路兜底闭合（r3 :57-63，rfl 分支命中） |
| 7 | `mul_smul_comm`（root 形） | `Mathlib/Algebra/Group/Action/Defs.lean:350-351` | `@[to_additive] lemma mul_smul_comm [Mul β] [SMul α β] [SMulCommClass α β β] (s : α) (x y : β) : x * s • y = s • (x * y)`（特例 `Algebra.mul_smul_comm` = `Mathlib/Algebra/Algebra/Defs.lean:321`） | **P2 矩阵乘法内标量外提件**：hgen 中 `T * (b • T^k) = b • (T * T^k)`（r3 :53 ×3）；P2 实例 α=ℤ、β=Matrix (Fin 8) (Fin 8) ℤ，`SMulCommClass α β β` 由 Algebra 实例满足（mathlib docstring 明示此惯例，Loogle 回读一致） |

**在册但 r3 骨架未直接调用的预检件**（审题卡 :91 已记，本轮核实一致）：`Matrix.mulVec_mulVec`（`Mul.lean:889`，`@[simp] theorem mulVec_mulVec [Fintype n] [Fintype o] (v : o → α) (M : Matrix m n α) (N : Matrix n o α) : M *ᵥ N *ᵥ v = (M * N) *ᵥ v`——(M*N)*ᵥv ↔ M*ᵥ(N*ᵥv) 的备用桥；r3 走 `pow_add` 矩阵层路线未直接用）、`Matrix.one_mulVec`（`Mul.lean:1003`，`@[simp] theorem one_mulVec (v : m → α) : 1 *ᵥ v = v`，section NonAssocSemiring + `variable [Fintype m] [DecidableEq m]` :1000——rfl 收尾覆盖）。

**清单外但 P2 hgen 实用**：`pow_add` = `Mathlib/Algebra/Group/Monoid.lean:450`（`lemma pow_add (a : M) (m : ℕ) : ∀ n, a ^ (m + n) = a ^ m * a ^ n`，Monoid 上下文经 variable；审题卡 :93 记为「核心库」系不准，实为 mathlib 该文件——本轮 rg + Loogle 双证）。P2 的 hgen 以 `rw [pow_add, hT, Matrix.mul_add, Matrix.mul_sub, …]` 展开 T^(n+6)（r3 :52-54）。

## ② Int.ModEq 家族 API 面

文件全貌：`Mathlib/Data/Int/ModEq.lean` 共 406 行；定义 :30 `def Int.ModEq (n a b : ℤ) := a % n = b % n`；记号 :34 `notation:50 a " ≡ " b " [ZMOD " n "]" => Int.ModEq n a b`。本轮 `rg -n` 全文声明清单实测如下（全部 file:line 同文件，省略前缀）：

- **等价关系核**：`ModEq.refl` :67（@[refl,simp]）、`ModEq.rfl` :70、`ModEq.symm` :74（@[symm]）、`ModEq.trans` :78（@[trans]）、`IsEquiv ℤ (ModEq n)` 实例 :81、`ModEq.eq` :86（≡ → emod 相等）、`modEq_comm` :90。
- **ℕ/ℤ 桥与零模数**：`natCast_modEq_iff` :93（`a ≡ b [ZMOD n] ↔ a ≡ b [MOD n]`，@[simp,norm_cast]）、`modEq_zero_iff_dvd` :96、`Dvd.dvd.modEq_zero_int` :99、`Dvd.dvd.zero_modEq_int` :102、`modEq_zero_iff` :350（ZMOD 0 = 相等）。
- **整除刻画族（P1 主用面）**：`modEq_iff_dvd` :105、`modEq_iff_add_fac` :109（↔ ∃ t, b = a + n*t）、`alias ⟨ModEq.dvd, modEq_of_dvd⟩` :113、`mod_modEq` :115（`a % n ≡ a`）、`dvd_iff` :245（同余两侧整除互相转移）、`add_modEq_left_iff` :264 / `add_modEq_right_iff` :268 / `left_modEq_add_iff` :272 / `right_modEq_add_iff` :276（±n 可吸进同余 ↔ 整除）。
- **同余代数运算族**：`add` :141、`add_left` :144、`add_right` :147（审题卡 :86 备用未用，本轮核实仍在册）、`add_left_cancel` :150、`add_left_cancel'` :157、`add_right_cancel` :160、`add_right_cancel'` :165、`sub` :172、`sub_left` :176、`sub_right` :179、`mul_left` :182、`mul_right` :185、`mul` :189、`of_mul_left` :197、`of_mul_right` :200、`cancel_right_div_gcd` :204、`cancel_left_div_gcd` :215、`of_div` :218、`mul_left_cancel'` :224、`mul_right_cancel'` :236、`mul_right_cancel_iff'` :241、`neg_modEq_neg` :119、`modEq_neg` :123、`ModEq.of_dvd`（降模数）:127、`mul_left'`/`mul_right'` :130/:137。
- **「±modulus 无感」族（P1 周期步同型件）**：`add_modulus_modEq_iff` :280、`modulus_add_modEq_iff` :284、`modEq_add_modulus_iff` :288、`modEq_modulus_add_iff` :292、`add_mul_modulus_modEq_iff` :296、`mul_modulus_add_modEq_iff` :300、`modEq_add_mul_modulus_iff` :304、`modEq_mul_modulus_add_iff` :308、`add_modulus_mul_modEq_iff` :312、`modulus_mul_add_modEq_iff` :316、`modEq_add_modulus_mul_iff` :320、`modEq_modulus_mul_add_iff` :324、`sub_modulus_modEq_iff` :328、`sub_modulus_mul_modEq_iff` :332、`modEq_sub_modulus_iff` :336、`modEq_sub_modulus_mul_iff` :340、`modEq_add_fac_self` :369（`a + n * t ≡ a [ZMOD n]`——与「+2 的倍数不改模 2 类」同型，P1 周期步的现成同型件）、`add_modEq_left` :352、`add_modEq_right` :354。
- **杂项**：`modEq_one` :343、`modEq_sub` :346、`abs_modEq_two` :252、`modulus_modEq_zero` :256、`modEq_abs` :259、`modEq_natAbs` :261、`modEq_and_modEq_iff_modEq_lcm` :356、`modEq_and_modEq_iff_modEq_mul` :360、`gcd_a_modEq` :365、`mod_coprime` :371、`existsUnique_equiv` :379、`existsUnique_equiv_nat` :386、`ext_ediv_modEq` :397 等。

P1 实际依赖面（对照冒烟 r3 :18-39）：仅 `modEq_iff_dvd` + `ModEq.trans` + `ModEq.refl` 三条 + `ring`/`omega`/重写；其余上方在册件均为军政部可选余量。

## ③ Matrix.mulVec 线性族 API 面

文件全貌：`Mathlib/Data/Matrix/Mul.lean`；`namespace Matrix` :286 起；`variable {l m n o : Type*}` :60、`{R S : Type*} {α : Type v} {β : Type w}` :61。本轮实测（file:line 同文件）：

- **加法线性**：`mulVec_add` :792（`A *ᵥ (x + y) = A *ᵥ x + A *ᵥ y`）、`add_mulVec` :797（`(A + B) *ᵥ x = A *ᵥ x + B *ᵥ x`）——均在 section NonUnitalNonAssocSemiring（:687-876，`variable [NonUnitalNonAssocSemiring α]` :689）。
- **标量线性（双侧）**：`mulVec_smul` :812（`M *ᵥ (b • v) = b • M *ᵥ v`，typeclass `[DistribSMul R α] [SMulCommClass R α α]`，v 侧）、`smul_mulVec` :818（`(b • M) *ᵥ v = b • M *ᵥ v`，typeclass `[DistribSMul R α] [IsScalarTower R α α]`，M 侧）。
- **零/单位**：`zero_mulVec` :783（@[simp]）、`vecMul_zero` :788（@[simp]）、`one_mulVec` :1003（@[simp]，section NonAssocSemiring :956-1041，`variable [Fintype m] [DecidableEq m]` :1000，证明经 `diagonal_one`（`Mathlib/Data/Matrix/Diagonal.lean:223`）+ `mulVec_diagonal` :752）、`mulVec_one` :961。
- **复合**：`mulVec_mulVec` :889（@[simp]，section NonUnitalSemiring :878-954）、`mulVec_diagonal` :752。
- **减法/负（ℤ 侧）**：section NonUnitalNonAssocRing :1043 起——`neg_mulVec` :1058（`(-A) *ᵥ v = -(A *ᵥ v)`）、`mulVec_neg` :1062、`mulVec_sub` :1069（`A *ᵥ (x - y) = A *ᵥ x - A *ᵥ y`）、`sub_mulVec` :1074（`(A - B) *ᵥ x = A *ᵥ x - B *ᵥ x`）、`vecMul_sub` :1080。

P2 实际依赖面（对照冒烟 r3 :50-63）：`add_mulVec` + `sub_mulVec` + `smul_mulVec`（gate p2 CHECK OK）+ 跨文件 `mul_smul_comm`（§① #7）；`one_mulVec`/`mulVec_mulVec` 在册未用（rfl 收尾 / pow_add 路线）。P2 实例 `Matrix (Fin 8) (Fin 8) ℤ` 所需 typeclass（Fintype (Fin 8)、ℤ 的环结构、DistribSMul/IsScalarTower/SMulCommClass ℤ ℤ ℤ 经 Algebra ℤ 实例）全部满足——冒烟 r3 exit 0 为证（审题卡 :101）。

## ④ mathlib 缺口正面清单（pinned v4.34.0 本地 rg 实证）

1. **monomer / dimer**：`rg -in "monomer|dimer" verify-proj/.lake/packages/mathlib/Mathlib --glob '!*.olean'` → **0 文件（rg exit 1）**。审题卡 :74 C5 记录复现成立。
2. **domino**：同法 `rg -in "domino" …` → **0 文件（exit 1）**。棋盘铺法词汇全缺位。
3. **匹配 API 在册情况 = 仅 Prop 级谓词，无计数**：`SimpleGraph.Subgraph.IsMatching`（`Mathlib/Combinatorics/SimpleGraph/Matching.lean:67`，`def IsMatching (M : Subgraph G) : Prop := ∀ ⦃v⦄, v ∈ M.verts → ∃! w, M.Adj v w`）；`IsPerfectMatching`（同文件 :236，`def IsPerfectMatching (M : G.Subgraph) : Prop := M.IsMatching ∧ M.IsSpanning`）；推论仅奇偶卡（`IsMatching.even_card` :247、`IsPerfectMatching.even_card` :265）。全库引用 IsMatching 的文件仅 4 个（rg -l：Matching.lean、Tutte.lean、Hall.lean、UniversalVerts.lean）。**无「全部匹配的集合/类型」（无 Finset/type of matchings）、无匹配数计数函数**——Matching.lean 中 card 相关仅 even_card 与 :250 证明内部的 `M.coe.edgeFinset.card` 使用，非计数 API。⇒ 「P₃×Pₙ 图匹配数」这一底座对象在 mathlib 无直接物，P3 层（完整组合语义）须自建枚举，触审题卡 :66 C1 高危定位。
4. **网格图 P₃×Pₙ**：无此对象。`rg -i "grid graph|P₃|3xn" Mathlib/Combinatorics` 的 4 个文件命中经逐个核对全是 `hP₃` 类局部变量伪命中（如 `Regularity/Lemma.lean:104`），如实记。
5. **铺盖（tiling）**：`Mathlib/Combinatorics/Tiling/Tile.lean` 在册，但其范围是群作用点wise 铺盖的抽象概念（模块头 :13-22「Tiles for tilings … discrete context」），非棋盘 domino/monomer 铺法计数——不可复用为本题语义桥。
6. **LinearRecurrence 与本题 statement 形态的关系**：在册 = `Mathlib/Algebra/LinearRecurrence.lean`（243 行）。`structure LinearRecurrence (R) [CommSemiring R]` :53-58（字段 `order : ℕ`、`coeffs : Fin order → R`）；`def IsSolution (u : ℕ → R) := ∀ n, u (n + E.order) = ∑ i, E.coeffs i * u (n + i)` :70-71（前移形态）。**形态兼容**：P1 假设 `c (n+6) = 4c(n+5)+14c(n+4)−10c(n+2)+c n` 恰为 `IsSolution (⟨6, ![1, 0, -10, 0, 14, 4]⟩ : LinearRecurrence ℤ)`（Fin 6 上系数展开后零系数项 simp 掉即一致）。**但该模块没有任何模周期/同余内容**：`rg -i "periodic|ZMOD|ModEq|period"` 于该文件 → 0 命中（exit 1）；其 API 止于 solSpace/mkSol/唯一性/几何解-charPoly（模块头 :23-36）。⇒ ①「线性递推 ⇒ 模 p 周期与余数刻画」无现成引理，P1 左支+右支正是补这一步；②「矩阵被多项式零化 ⇒ mulVec 序列是该 LinearRecurrence 的解」的桥亦无现成件，P2 自证。两冻结 statement 与 LinearRecurrence 模块**不冲突、不被覆盖**，无需改 statement（此点供监察院对照 C5 非复述检查）。
7. **Cayley–Hamilton 层在册**（P2 路线上下文）：`Matrix.charpoly`（`Mathlib/LinearAlgebra/Matrix/Charpoly/Basic.lean:134`）、`aeval_self_charpoly`（同文件 :216，`aeval M M.charpoly = 0`）。P2 的 hT 直接假设零化、无需此层；但「某具体棋盘转移矩阵的 charpoly = 本六阶多项式」属实例化层，不在册——是 §⑤ 组合语义桥缺位的组成部分。
8. **C5 复述补充检查**：Int/ModEq.lean 全 406 行声明清单（§②）与 LinearRecurrence 模块均无 periodic 类条目；与审题卡 :74「mathlib 无 ModEq+periodic 内容」口径一致。

## ⑤ 论文层两点提示

1. **组合语义桥缺位（主张必须降级声明）**：kernel 的 P2 statement 中 `T` 只是「任意被 x⁶−4x⁵−14x⁴+10x²−1 零化的 8×8 整矩阵」（冻结 `formalized/edgemid-p2-statement.lean:16-22`）；「T = 某固定孔位 3×n 棋盘的转移矩阵」与「`(T^n).mulVec v i` = 该孔位缺陷匹配计数」两座桥**均不在 Lean**（`formalized/roundtrip.md` :75-79 具名）。支撑材料按 §④：匹配计数 API、格孔/铺法枚举在 mathlib 全缺位。⇒ 外交部/翻译部措辞只能写「**矩阵泛函层的统一递推定理**」，不得写成「证明了铺法计数满足递推」；冻结 P2 docstring 的「（含各固定孔位缺陷计数）」是动机层措辞、非 kernel 主张（roundtrip.md :81-83），冻结文件头注释 :10-11 已带降级声明。人类叙述层按转移矩阵法叙述（OEIS A033506 引 Lundow 1996/1998，审题卡 :36、:16）。
2. **最相邻文献划界（论文必须引用）**：任务卡 :34 指定文献线 = **arXiv:1901.07847**《State matrix recursion method and monomer-dimer problem》+ **Tzeng–Wu 2003**（J. Stat. Phys. 110）+ **Wu 2006**（PRE 74）。语义边界（`tasks/20260926-beian-extselect/recheck/03-exclusivity.md` :27-32）：该线做的是「删点图**完美匹配**（纯二聚体完全覆盖）」计数，且 1901.07847/Tzeng–Wu 限奇×奇方板（Tzeng–Wu Temperley 双射、位置无关性）；本题是「删点图**全部匹配**（单体-二聚体任意铺法）」且 3×n 全 n——对象不同、n 奇偶不限，**不占据**，但须显式划界。OEIS 侧：底座 A033506 在册（非新），W/N1/EB0/角孔四个缺陷序列四层检索零命中（recheck :9-22、:59）。证据等级注：Tzeng–Wu 2003 / Wu 2006 原文 PDF 未取，判定依据为 1901.07847 ar5iv 全文转述 + 摘要（recheck :29、:62）——论文引用时按此措辞强度。

## 检索动作台账（本轮）

- 本地 rg：`modEq_iff_dvd/ModEq.refl/ModEq.trans`、`mul_smul_comm`（Action/Defs + Algebra/Defs）、Matrix mulVec 族（add/sub/smul/one/mulVec_mulVec/neg/diagonal/zero/one）、`pow_add`、ModEq.lean 全文声明清单、`monomer|dimer`（exit 1）、`domino`（exit 1）、`grid graph|P₃|3xn`（伪命中核对）、Matching.lean `card|count|Fintype`、`IsMatching` 全库 -l、LinearRecurrence 全文结构 + `periodic|ZMOD|ModEq|period`（exit 1）、charpoly/aeval_self_charpoly、Tile.lean 模块头、Int.ModEq def/notation。含 `sed -n` 精读片段：ModEq.lean :28-33/:60-120，Mul.lean :780-800/:810-825/:884-895/:995-1010/:1064-1080，LinearRecurrence.lean :40-76，Tile.lean :6-22，Action/Defs.lean :340-360。
- Loogle 直连（经 127.0.0.1:4180 代理，--ssl-no-revoke）3 次成功：`Int.modEq_iff_dvd`（module Mathlib.Data.Int.ModEq，类型与本地一致）、`mul_smul_comm`（module Mathlib.Algebra.Group.Action.Defs，含 SMulCommClass docstring）、`pow_add`（module **Mathlib.Algebra.Group.Monoid**——定位修正）。
- LeanSearch 直连 2 次：均 HTTP 502（`error code: 502`），失败如实记，未再重试；其应覆盖项由本地 rg + Loogle 补齐。
- 交叉引用并亲读：审题卡 :79-95（预检清单）、:99-102（冒烟三轮）、`audit/gate-p{1,2}-welldef.txt`（CHECK 段）、`smoke-03/EdgemidSmoke03r3.lean`（两证明体 :18-39/:50-63）、roundtrip.md、recheck/03-exclusivity.md、任务卡 :30-34。
- 本轮消耗：llm-call 0；compile 0；diag 0（纯 rg/curl/文件读写）。
