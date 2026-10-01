# 精简主张审计（SOP 08b 工序 5；占位质检门第③项）

> 裁决方：监察院（dept-audit 派发，只读）。本件为**机械复核 + 逐项核读**的落盘记录。
> 范围：`claims/mossad42-{01-half3,02-mod3x3,03-half4,04-mod3x4}` 四包。
> 日期：2026-09-30。执行：主代理（机械项由脚本断言；措辞项逐条对读）。

## 判据（SOP 08b 工序 5 六项，逐项）

| # | 判据 | 结果 |
|---|---|---|
| 1 | 每条 `% LEAN:` 锚点 → 源任务冻结快照 sha256 一致、分级=完全证明、审计证据存在 | **过 ×4**（见 §一） |
| 2 | 短笺措辞强度 ≤ 监察院分级 **且** ≤ C9 裁决（全文断言逐条对；novelty 节裁决照抄核查） | **过 ×4**（见 §二） |
| 3 | lstlisting 与冻结产物逐字节比对 | **过 ×4**（见 §三） |
| 4 | 预算表数字照抄 budget.log | **过 ×4**（见 §四） |
| 5 | 披露四要素齐全、AI 未进作者栏、作者栏 = 账号名 `Aurora0134`、无 PII | **过 ×4**（见 §五） |
| 6 | c9-record.md 在包且与源查询记录逐字一致 | **过 ×4**（见 §六） |

**零发现方过占位质检门。**

---

## 一、锚点与冻结快照（判据 1）

四个 claim.tex 的 `% LEAN:` 锚点行数 = 14（T1×4、T2×3、T3×5、T4×2），与源任务 14 条定理一一对应。
锚点格式 `% LEAN: tasks/20260930-mossad42-quad :: <decl>  grade=完全证明`；
`paper-lint.sh` 判据 7 逐条核验（任务目录存在、声明名非空、分级 = 完全证明）：四包 exit 0。

冻结快照 sha256（与 `tasks/20260930-mossad42-quad/audit/freeze.txt` 及卡面三方同值）：

| 轨 | 冻结 statement | sha256（前 16） |
|---|---|---|
| T1 | `formalized/01-half3-statements.lean`（62 行） | `21ec4bd99fba4c9e` |
| T2 | `formalized/02-mod3x3-statements.lean`（86 行） | `da4eae94971f8a5e` |
| T3 | `formalized/03-half4-statements.lean`（104 行） | `b142670a02c923ff` |
| T4 | `formalized/04-mod3x4-statements.lean`（106 行） | `b39708311b6fabd6` |

分级：四包 14 条定理全部 = **完全证明**（源 `audit/final-audit.md` 闸门三裁决；`audit/final-tX.txt`
严格编译 exit=0、0 sorry/admit、公理 ⊆ {propext, Quot.sound, Classical.choice}、无 sorryAx）。
审计证据在包内 `audit/`（final-tX.txt / statement-diff.md / freeze.txt / final-verify.txt / listing-verify.txt）。

## 二、措辞强度（判据 2）

逐条对读四份 claim.tex 的全部强度类断言：

- **分级措辞**：四包一律写 "the grading of all theorems is *complete proof*"，
  与监察院分级同值，**未见越级**（无 "proved new mathematics" / "first proof" / "new discovery"）。
- **禁用短语核验**（机械）：四包对 `new discovery` / `first proof` / `first to prove` /
  `novel discovery` 的命中数均为 **0**。
- **novelty 节裁决照抄**：四包均写 verdict = *no occupying record found*，
  并照抄两条诚实边界（OpenAlex 通道不可用 + 零命中 ≠ 新颖），与 C9 裁决一致，
  未把「零命中」升格为「新颖」。
- **组合语义桥**：四包均明写为 **conjecture**、不在 theorem 层，
  并以 "structural theorems about a sequence / recursion" 表述，**未**写成「证明了铺砖计数满足…」。
- **T2 专属**：命题表述为 "counted by the number of horizontal dominoes, modulo 3"，
  **未**缩写为 "tilings mod 3"（题库入库条件①）。
- **T3 专属**：「无常系数递推」写作 "none found at order ≤ 60"，**未**写成 "does not exist"；
  且明写本短笺**不主张**递推或闭式。A220379/A292752 标注为短窗巧合、**未**引用为相关文献。
- **T4 专属**：明写**不套用** 3×n 下标约定（无交替零项）。六轮攻证史含两次假引理事件如实记录。
- **T1 专属**：两条定义展开引理**如实标注**「内容低、非主结果」，未与两条主结果平铺。
- **m 维变体**：四包均写明与对方互为 m 维变体、**不互相充当新颖性证据**。
- **矩/期望**：四包均写明不主张矩类新颖性，并引出 Fibonacci Quarterly 2019 DOI。

## 三、listing 逐字节（判据 3）

各包 `audit/inspect-tex.py --verify` 机械断言（四包均 RESULT: PASS）：

| 包 | statement 块 | proof 块 | proof 块 sorry/admit |
|---|---|---|---|
| T1 | 30 行按序子序列；明示省略 4 行占位 proof body | 77 行按序子序列 | 0 / 0 |
| T2 | 46 行按序子序列；明示省略 3 行 | 104 行按序子序列 | 0 / 0 |
| T3 | 70 行按序子序列；明示省略 5 行 | 98 行按序子序列 | 0 / 0 |
| T4 | 79 行按序子序列；明示省略 2 行 | 145 行按序子序列（**连续块，源行 100–244**） | 0 / 0 |

**唯一省略规则的合规性裁定**：冻结 statement 的 proof body 是形式化部的 `sorry` 占位，
而 `paper-lint.sh` 判据 3 禁止 listing 内出现 sorry。四包处置 = **逐条删去占位 proof body 行、
其余逐字保留**（含 doc-comment 内部注释段），并在 listing 后写明删了哪几行、为什么；
实现与断言在 `inspect-tex.py`（`ELIDED_STMT` 白名单 + 按序子序列判定）。
**裁定：合规** —— 既不削弱 lint，也不手改冻结快照，且「包体自我描述与实物相符」。
先例一致性：`claims/chorded-cycle-mod4`、`notchgrid-parity-mod`、`tatami-mod8-defect`
等既有包同采「列 def + 签名、不带 body」写法，公开面无 sorry。

另：`audit/statement-vs-frozen` 口径的**未经省略**对称差结论由源任务 `audit/statement-diff.md`
承载（宪条 2 口径），该件已随包，结论 = 14 条定理 + 全部 def **逐字节一致**。

## 四、预算数字（判据 4）

四包披露节数字照抄源任务 `budget.log`（append-only 41 行）与卡面：

- 采样：T1=2、T2=1、T3=1、T4=6，合计 **10 / 32**。
- llm-call：**6 / 16**（四轨 roundtrip：T1/T2/T3 各 1、T4 2）。
- Lean 正式编译：T1=5、T2=4、T3=6、T4=4，合计 **19 / 48**。
- LaTeX：源任务 0；本占位阶段 **4**（四包各 1 次 paper-compile，见 `claim-gate` 行）。
- 占位阶段 llm-call = **0**（短笺为模板化装配 + 主代理直编）。
- 调试类目单列不占正式顶（源任务 26 次 + T4 取证探针 10 次）。

## 五、披露与署名（判据 5）

- 四要素齐全（AI 环节枚举 / 模型-节点-预算表 / 终裁声明 / 作者负责声明）：**过 ×4**。
- AI **未**进作者栏；`zenodo.json` 的 `contributors` 记 "AI4Math pipeline (LLM-generated content, human-audited)"。
- 作者栏 = 账号名 `Aurora0134`（三处一致：`\author{}`、`creators[0].name`、镜像仓提交身份口径）。
  `paper-lint.sh` 判据 5a/5b 机器核验：四包 exit 0。
- 无 PII：ORCID 键整键删除、无邮箱实值、无本机用户名（脱敏见 §七）。
- 无 `<<` 占位残留；DOI 用设计内字样 `RESERVED-DOI`（lint 判据 5 核验：四包 exit 0）。

## 六、C9 记录（判据 6）

- 四包 `zenodo/audit/c9-record.md` 与源 `tasks/20260930-mossad42-quad/claims/c9/c9-record.md`
  **逐字节同值**（由 `build_c9_record.py` 机械分发，非手抄）。
- 内容 = 11 个来源件逐字拼接（选题批 summary + lane-c 文献台账 + pools/mossad-42.md +
  本批 lit-probe/verdict + 6 份 OEIS 记录），逐节标注源路径，**未改写任何结论**。
- 包含零命中全量（六变体 × 四轨、闭式 5 条互异查询串、文献四通道 35 条查询）。

## 七、额外机械核验（本批自加，非 SOP 必需）

- `sanitize-package.py` 五门（清单一致性 / 承诺对账 / **无本机路径** / 无裸 CR·TAB / 自我描述）
  全 PASS ×4；zip 条目集 = 存缴树 ×4。
- 打包前发现并修正一处**公开面泄漏**：出包 `audit/final-t1.txt` 曾含本机绝对路径 ⇒
  只对出包副本剥离前缀（源文件不动），规则写入 `build_packages.py`。

## 裁定

**占位质检门第③项（精简主张审计）：零发现，四包全部通过。**
与门①（paper-lint exit 0 ×4）、门②（paper-compile exit 0 ×4）合并 ⇒ **四包均满足占位质检门三项全绿**。

> 外发动作（Zenodo Publish / GitHub 推送 / OEIS 提交）一律用户本人执行（宪条 6）；
> 本阶段零外发（未建草稿、未预留 DOI、未推送任何远端）。

## 八、返工后复核（2026-09-30 用户指令触发）

用户 2026-09-30 指令「先提交所有改动（包括之前的），然后把这批成果走一下占位通道」
触发对本节的复核。**原三项判据的结论不变**（判据 1/2/4/5/6 所依据的正文文本、
锚点、冻结 sha256、C9 记录、署名与披露均未改动），但复核发现**两处装配面缺陷**，
已在对应工序修复并重新装配；本节记录复核口径与结论：

1. **出包副本与 zip 曾停留在旧版 claim.tex**（T2/T3/T4）：装配时点 19:04:08 之后
   T4 显示式改写（19:04:19）、T3 行号口径订正（19:07:35）、T2 行号口径订正（19:08:03）
   未回灌 `zenodo/claim/`。T2 旧副本写「statement 38--86」、T3 写「32--104」，
   与冻结件实际行段（86 行的第 86 行 = `sorry` 占位；104 行的第 104 行 = 同上）
   **不符**——属判据 3 所辖的「包体自我描述与实物相符」失效。修复 = 重跑
   `build_packages.py` 重装全树；现 `claim.tex` / `claim.pdf` 与出包副本**同哈希**。
2. **listing 渲染面缺字形（静默丢字）**：判据 3 只比对 `.tex` 源码字节，**查不出**
   PDF 渲染层丢字。复核以编译日志 `Missing character` 为准：T1 2 处、T3 4 处、
   T4 6 处码点缺失（T2 0 处）。修复 = 按 `scan_listing_unicode.py` 的盘点补齐
   `claim.tex` 的逐码点补映射清单；四包重编后 `Missing character` 计数**全部为 0**。

**判据 3 的复核口径补强**（不改变原判据，只补机器可查的渲染面断言）：
lstlisting 逐字节比对仍由 `inspect-tex.py --verify` 承载（重装时现场重跑，四包
RESULT: PASS）；**新增**两条——① `scan_listing_unicode.py` 无 `MISSING`；
② 编译日志 `Missing character` = 0。二者均为机器判据，可复算。

**其余判据复核结论**：判据 1（锚点 14 条 / 冻结 sha256）未变；判据 2（措辞）未变；
判据 4（预算）——占位阶段 LaTeX 轮次由 4 增至 8（四包各重编 1 次），仍在 SOP 08b 顶
（≤10）内，账本已 append；判据 5（署名/披露）未变；判据 6（c9-record 逐字）未变。

**裁定：返工后仍为零发现；四包通过占位质检门第③项。**
