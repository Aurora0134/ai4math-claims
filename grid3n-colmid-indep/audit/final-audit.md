# 终审记录 · tasks/20260930-comb12-grid-indep（comb-12 主定理 c_z_rec）

- 终审员：独立终审 agent（本会话）；日期 2026-09-30。
- 受审件：`attempts/final-c_z_rec.lean`（主定理终稿，脚本严格模式编译 exit=0，见「编译闸门」节）。
- 参照件：`formalized/interface.lean`（接口冻结件）、`formalized/statement.lean`（冻结 statement 原文）、`attempts/frag-bridge.lean`、`attempts/frag-transfer.lean`。
- 结论：**四项检查全部通过，证明闭环成立（宪条 1/2/3/4 口径）。**

---

## 1. 命题逐字比对 —— PASS（二进制逐字节，非肉眼）

**检查 1a：final 开头冻结段 vs interface.lean 全文**

命令（Python 二进制模式，避免 shell 文本模式吞 CR 导致假阳性——本机 `sed`/`grep` 实测会归一 CRLF，故所有比对均以 bytes 进行）：

```
python -c "
iface = open('formalized/interface.lean','rb').read()
final = open('attempts/final-c_z_rec.lean','rb').read()
print(final[:len(iface)] == iface)"
```

输出：

```
interface bytes: 8042  sha256: 66c96c3e4051ce2be5bd2c09383913f71678e3133b0e67cff4fdc73dbed3d6e9
final head-8042 bytes == interface bytes: True
final head sha256: 66c96c3e4051ce2be5bd2c09383913f71678e3133b0e67cff4fdc73dbed3d6e9
```

final-c_z_rec.lean 前 8042 字节与 interface.lean **逐字节一致**（含行尾），即接口纪律要求的「①冻结 statement 的声明段 + ②攻证接口 + ③转移矩阵证书 + 名册核验/攻证须知」整件原样进入终稿；冻结 statement（interface.lean 第 18–40 行，`instance`×2 + `indepCountHoles` / `holes` / `z` 三 def）未被改动一个字节。

**检查 1b：c_z_rec 陈述 vs statement.lean**

```
python -c "
final = open('attempts/final-c_z_rec.lean','rb').read(); stmt = open('formalized/statement.lean','rb').read()
print(final.split(b'\n')[1086] == stmt.split(b'\n')[47])"
```

输出：`statement lines byte-equal: True`；两侧 sha256 均为 `17b7408f9a0bd0a80f2bf20519eb6757b13add7cfd82fa98ed3442f341bd3c8c`。

逐字内容：

```
theorem c_z_rec : ∀ n : ℕ, 6 ≤ n → z n + 15 * z (n - 4) = 12 * z (n - 2) + 2 * z (n - 6) := by
```

statement.lean 第 49 行的 `sorry` 占位（该文件本只产 statement）在终稿中由真实证明体替换；终稿中 `c_z_rec` 仅出现两次——第 1087 行陈述、第 1188 行 `#print axioms c_z_rec`，无第二条同名/改参数陈述偷渡。

## 2. 禁用词全文件扫描 —— PASS

命令（Python 二进制扫描 `native_decide` / `Lean.ofReduceBool` / `admit` / `sorry` 四个字面词，逐行定位）：

```
python -c "
for path in ['attempts/final-c_z_rec.lean','attempts/frag-bridge.lean','attempts/frag-transfer.lean']:
    data = open(path,'rb').read()
    for tok in [b'native_decide', b'Lean.ofReduceBool', b'admit', b'sorry']:
        ...逐 token 报命中行号..."
```

输出：

```
==== attempts/final-c_z_rec.lean (54264 bytes)
  native_decide        hits at lines: [171]
  Lean.ofReduceBool    hits at lines: [171]
  admit                hits at lines: NONE
  sorry                hits at lines: NONE
==== attempts/frag-bridge.lean (13131 bytes)   四词全 NONE
==== attempts/frag-transfer.lean (21213 bytes) 四词全 NONE
```

唯一命中在 final 第 171 行，位于第 164–177 行的 `/-! … -/`「攻证须知」docstring 内，原文是「**禁止用 `native_decide`**：它引入 `Lean.ofReduceBool`，不在公理白名单……入库即拒收（宪条 3）」——是**警告文字本身**，不是 tactic 使用。该 docstring 随接口冻结件整段进入终稿（检查 1a 已证逐字节一致），budget.log 亦预先标注此情（「仅注释层，编译与公理不受影响……权威判据 = #print axioms」）。代码层 0 sorry / 0 admit / 0 native_decide。

## 3. 桥梁与转移引理非空转抽查 —— PASS

**br_z_eq_validCount（final-c_z_rec.lean:471-485）**：不是 trivial 绕话。证明把 `z n`/`validCount n` 经 `br_z_eq_card_S1`/`br_validCount_eq_card_S2` 展开为两侧 filter 的 card 后，`refine Finset.card_bij (fun s _ => fun j => colSlice n j s) ?_ ?_ ?_` 建立**独立集 ↔ 合法剖面函数的真实双射**，三个 obligation 分别由：

- 映入：`br_ValidProf_of_mem_S1`（:395-419）——真正消费「与 holes 不交 + IsIndepSet」两条假设（奇列走 `br_Qprof_of_not_mem_one` + 缺陷集成员性；偶列走 `br_Pprof_of_indep` + 竖直邻接否定；跨列走 `Disjoint` + 水平邻接）；
- 单射：`br_reconstruct_colSlice`（:370-381，`Finset.ext` 逐点证 round-trip）；
- 满射：`br_mem_S1_of_ValidProf` + `br_colSlice_reconstruct`（:422-464 / :384-388）。

全链只有 `br_z_eq_card_S1`/`br_validCount_eq_card_S2` 两处 `rfl`，且那是 br_S1/br_S2 两个辅助 def 与 z/validCount 的定义性展开，非目标本身被 rfl 掉。

**tr_ 主引理**：

- `tr_fillEnd_step`（:668-744）：双步递推。主情形用 `Finset.card_bij` 把 (m+2) 列填法与 `(allowed m).biUnion (fun q => … ∧ Disjoint q p)` 的纤维并建立双射（映入/单射/满射三 obligation 均由 `tr_validProf_init`/`tr_validProf_snoc`/`Fin.snoc` 系列实核），再 `Finset.card_biUnion` + 纤维两两不交收口；权重 `if Disjoint q p then 1 else 0` 即转移矩阵元的原型。
- `tr_fillEnd_pair`（:855-918）：对 k 联合归纳证 `tr_fillEnd (2k+1) (P5 i) = (Tmat^k *ᵥ ones5) i` 与 `tr_fillEnd (2k+2) (Q4 j) = (Bmat *ᵥ (Tmat^k *ᵥ ones5)) j`，归纳步实调 `Matrix.mulVec_mulVec`（:898）、`tr_Amat_eq_Bmat`（:901）、`Finset.sum_image tr_Q4_injOn`（:904）等矩阵/枚举机制——确为矩阵递推，非空转。
- 主定理 `c_z_rec`（:1087-1186）三处分支分别消费：桥梁 `br_z_eq_validCount`（:1097/1101/1105/1109、:1135/1140/1145/1150、:1167/1171/1175/1179）、转移 `tr_validCount_even`/`tr_validCount_odd`/`tr_validCount_zero`、递推 `asm_u_rec_sum`/`asm_w_rec_sum`（:1152/1181）；唯一边界 n=6 由 ℤ 矩阵恒等式的 `decide`（:1111-1115）闭。链路完整，无一段被 trivial 化。

**片段与终稿一致性**（附加核查，防「审片段、过终稿」两回事）：

- frag-bridge.lean 与 final 第 178–485 行 `diff` 逐字节相同（LF，无 CR）。
- frag-transfer.lean 与 final 第 486–952 行 `diff --strip-trailing-cr` 相同；plain `diff` 全行不符经 `cmp`/`od` 定位为 fragment 侧 CRLF、终稿侧 LF 的行尾差异（frag-transfer 全文 CRLF，final 该段 LF），**内容零差异**。冻结前缀（前 8042 字节）行尾亦逐字节一致（检查 1a 为二进制比对，不受此影响）。

## 4. 公理集合核对 —— PASS

脚本捕获的 `#print axioms c_z_rec` 输出（终稿第 1188 行即该命令；输出由任务方随 ask 提供，本会话未自行运行 Lean）：

```
'c_z_rec' depends on axioms: [propext, Classical.choice, Quot.sound]
```

- 集合 = {propext, Quot.sound, Classical.choice}，**恰好等于白名单**，⊆ 成立。
- 无 `sorryAx`、无 `Lean.ofReduceBool`（native_decide 公理）出现。

## 编译闸门（非本终审员执行）

按分工，编译闸门由脚本运行，本会话未执行 `scripts/lean-verify`，亦未编译任何 .lean。ask 材料载明脚本已以严格模式编译 final-c_z_rec.lean 且 exit=0。佐证与限度：

- budget.log 留档：interface.lean 严格模式定稿验证 1 次（cumulative compile = 1/36）；bridge.lean 主代理独立严格复验 exit 0、0 error、0 sorry（cumulative = 2/36）；并载明宪条 2 核查「bridge.lean 与 transfer.lean 均以 formalized/interface.lean 逐字节开头」。
- final-c_z_rec.lean 本身的严格编译笔尚未 append 进 budget.log（该文件注明「运行中各 agent-run / compile 笔由工作流结束后按运行实况 append-only 回写」，工作流仍在飞）。
- 本会话尝试用 GetWorkflowRun 调取运行记录佐证，返回 `workflow_introspection_unavailable`（本会话无工作流内省能力）——exit=0 一事以 ask 材料为准，未获独立第二信源。

## 发现的问题（findings）

1. （提示级，不影响结论）final-c_z_rec.lean 行尾不统一：第 486–952 行（转移段）为 LF 而 frag-transfer.lean 为 CRLF；其余为 LF。内容经 CR 归一后逐字节一致，编译与公理不受影响。建议后续收尾时统一行尾，避免对称差比对工具因行尾误报。
2. （提示级）budget.log 尚未回写 final-c_z_rec.lean 的正式编译笔；按该文件自述的收口机制属预期（工作流结束后 append-only 回写），终审不阻塞，但收口时须补记以保持「预算状态以落盘文件为唯一事实源」。
3. 无阻断性问题：未发现 statement 篡改、sorry/admit/native_decide 使用、公理越白名单、空转引理任何一项。

## 裁决

**PASS。** 冻结 statement 在终稿中逐字节在位（final 前 8042 字节 = interface.lean；c_z_rec 陈述行 = statement.lean 第 48 行，均为二进制比对）；全文件无 sorry/admit/native_decide 代码层使用（唯一命中为接口冻结件自带警告注释）；br_z_eq_validCount 以 Finset.card_bij 建立真实双射、tr_ 主引理以 card_bij/card_biUnion/矩阵 mulVec 归纳实核，均非空转；`#print axioms c_z_rec` = [propext, Classical.choice, Quot.sound] ⊆ 白名单且无 sorryAx。按宪条 3/4，本证明达「完全证明」级（0 sorry、白名单公理），证明闭环成立，可放行进入监察院分级与外交部签发环节。编译 exit=0 以脚本闸门材料为准（本终审员未复跑，见上节限度）。
