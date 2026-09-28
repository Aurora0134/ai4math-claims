# Zenodo 存缴包 README — grid3n-diag-2notch（AI4Math claim-of-record artifact）

> AI 生成（2026-09-28）。本包为 SOP 08b 占位通道产物；上传/发布（外发）一律用户本人手动执行，见源仓 `claims/grid3n-diag-2notch/UPLOAD.md`（该件不随包，随清单留在源仓库）。本通道不依赖 arXiv 账号与背书。

## 发布前必跑（只读）

```bash
python scripts/sanitize-package.py claims/grid3n-diag-2notch
# 六门：清单一致 / 包内外承诺对账 / 自述范围（locativity+行尾声称）/ 无本机路径 /
#       结构后检（裸 CR/TAB、tex 括号）/ 覆盖面自述
```

## DOI

- **未预留**：Zenodo 草稿页 "Get a DOI now!" 由用户执行后产生；本包不含真实 DOI。
- 短笺 Data availability 段按「DOI 于上传时预留」写法处理，明写 unfilled field
  `RESERVED-DOI`，未留 `<<占位>>` 字符串，故无「替换」动作可做；回填点为本文件 +
  源仓 `claims/grid3n-diag-2notch/card.md` + `run-state.md`。
- **时间戳现状**：Zenodo 发布构成本成果的公开优先权记录（发布由用户按 UPLOAD.md
  手动执行）。脱敏 GitHub 快照仓为**第二重记录（已推送）**：用户 2026-09-28 指令「gh推送授权，全做」已推送至
  `https://github.com/Aurora0134/ai4math-claims` 的 `grid3n-diag-2notch/` 目录
  （宪条 6：推送经用户显式授权；只推本包 `zenodo/` 内容、禁推整仓）；commit 与
  时间戳见源仓 `claims/grid3n-diag-2notch/card.md`。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；四条 `% LEAN:` 锚点（adiag_interleave / adiag_mod2_period12 / onotch_mod2_period6 / enotch_mod2_period6，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0，14 页，`Missing character` 0，终轮 Overfull 0，未解引用 0）。前导含渲染专用 XeTeX 补丁：`\lccode` 活动字符只补 xeCJK 标点表之外的 21A6/27FA/2212，`00B7` 交 xeCJK+SimSun 路由（先设活动会加载期报错，2026-09-27 实测）；listing 源字节不动 |
| `claim/lstlean.tex` | listings 的 Lean 语法定义（单一事实源在 `harness/templates/paper/`，随包拷贝以自编译；与论文包同字节） |
| `proofs/01-comb07-diagnotch-statements.lean` | 冻结 statement（143 行，proof body 为 sorry 占位）sha256=`16744fd37b7d8eb67965641f4e2b6dd8e7e3c2a994ea484766b6e3afb5861aca` |
| `proofs/01-comb07-diagnotch-proved.lean` | 终稿四定理（433 行，0 sorry）sha256=`51721e9e315db12a35ca62218d8d458f32443e97f666e4a2ab452d0056f7cb43` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-comb07-diagnotch.txt` | 监察院终审裁决书（闸门三四项核查全过；四定理=完全证明；限定语原文级）。**脱敏披露**：本件为源仓 `tasks/20260928-comb07-diagnotch/audit/` 原件的副本，其中 3 处本机绝对路径前缀（盘符+用户目录+仓库根）已相对化——两处改写为仓库相对路径、一处（`cd` 目标）改写为 `<repository root>`——其余逐字；源件未改，仍在源仓 |
| `audit/axioms-adiag_interleave.txt` / `axioms-adiag_mod2_period12.txt` / `axioms-onotch_mod2_period6.txt` / `axioms-enotch_mod2_period6.txt` | `#print axioms`  gate-batch 侧车原文四件（各两行：`WELLDEF OK` + `AXIOMS <decl> [...]`），与监察院独立抽查逐条一致；原件无本机路径，逐字拷入 |
| `audit/c9-record.md` | C9 独占性深度复审记录逐字全文（新颖性证据主体）：part 1 = 源仓 `tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-01.md` **整文件逐字**（源文件 sha256=`9d8f7e0c6698896a87f1f1c91eb7ba2337ed62a77160fc1d14fad4c3179772e3`）；part 2 = 同目录 `deep-recheck-shared.md` §8 三候选裁决汇总表逐字（源行段 131-137；源文件 sha256=`d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f`）。仅加打包者出处注记头与文末哈希自检附录，结论句零改写；原始查询回包与共享证据其余节留源仓，不随包 |
| `audit/compile.txt` | 本包 paper-compile 五轮关键行摘录（exit/页数/Missing/Overfull/未解引用） |
| `audit/lint.txt` | 本包 paper-lint 输出（PASS, exit 0） |
| `audit/listing-verify.txt` | 短笺 11 处 lstlisting 与冻结产物逐字节核验记录（11/11 PASS，脚本 `audit/inspect-tex.py`） |
| `audit/inspect-tex.py` / `audit/build-c9-record.py` / `audit/sanitize-package.py` | 装配与自检脚本：listing 注入与逐字节核验、非 ASCII 出网检查、C9 记录构建与自检、包体机械对账门（`sanitize-package.py` 为仓级共享工具的冻结副本，仅多一行出处注记） |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134，无 orcid 键；contributors 保留 AI 披露；related_identifiers 含 OEIS 参考项 + GitHub 镜像 isIdenticalTo（已推送） |
| `metadata/FILE-MANIFEST.txt` | 包内逐件 sha256 + 字节数清单（发布前复算即用此件） |
| `metadata/README.md` | 本文件 |

## 各声明实测公理集（`#print axioms` 原文，监察院独立抽查与 gate-batch 侧车双轨一致）

| 声明 | 实测公理集 | 分级 |
|---|---|---|
| `adiag_interleave` | `[propext, Classical.choice, Quot.sound]`（恰完整白名单） | 完全证明 |
| `adiag_mod2_period12` | `[propext, Quot.sound]` | 完全证明 |
| `onotch_mod2_period6` | `[propext, Quot.sound]` | 完全证明 |
| `enotch_mod2_period6` | `[propext, Quot.sound]` | 完全证明 |

sorryAx 零出现；全案最低级 = 完全证明，无脚手架。

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0 便携版（本机），XeTeX 路径。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 01-comb07-diagnotch-proved.lean
# 期望：exit 0、无输出（严格模式；实测 37.0s）
```

公理复核（本仓纪律：sidecar 另起文件，用完即删，不进 final）：在本目录放一个只含下面五行的临时文件，`lake env lean` 它，然后删除：

```lean
import «01-comb07-diagnotch-proved»   -- 与本包 proofs/01-comb07-diagnotch-proved.lean 同名的模块
#print axioms adiag_interleave
#print axioms adiag_mod2_period12
#print axioms onotch_mod2_period6
#print axioms enotch_mod2_period6
```

任务级全部过程档案（Phase 0 枚举/拟合脚本、roundtrip 留档、攻证轮次与诊断原文）留源仓 `tasks/20260928-comb07-diagnotch/`；C9 原始查询回包与共享证据记录留 `tasks/20260928-comb0709-deeprecheck/`，均不随包。

## 行尾说明（line endings）

本包除 `claim.pdf`（二进制）外的全部文本件——含 `proofs/` 两件 Lean 源与 toolchain 钉版件、`claim/` 两件文本件（另 `claim.pdf` 为二进制）、`audit/` 十二件、`metadata/` 三件——均为 LF 行尾、无 TAB、无裸 CR（逐件实测，2026-09-28；文本件合计 20 件，加 `claim.pdf` 共 21 件）。Lean 冻结源本身即 LF，listing 直接逐字摘录，无归一化处理。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## AI 披露（四要素压缩版）

(a) AI 承担环节：候选筛查与三轮 C9 独占性复审、phase 0 数值复算与主张定稿、四命题形式化与 roundtrip 语义裁判、证明搜索与证明脚本撰写、散文翻译、本短笺装配（含逐字 listing）。(b) 模型-节点-预算：任务级采样全部在单一节点 wire-id `anthropic/a6api-main/kimi-k3`（无跨节点切换；漂移如实披露：2026-09-28 有一次审计派发〔F1 闭环节复审〕的 model-detect 读数为 `anthropic/stepfun/step-5-preview`，账本记账节点仍为 `anthropic/a6api-main/kimi-k3`，漂移披露而非以替换掩饰），实耗 11/20 agent-run 派发、1/6 llm-call（roundtrip 裁判；同节点两次网络失败重试不计），数字照抄源任务账本；本占位线实耗 1 派发、0 llm-call、LaTeX 5/6 轮；装配会话端点 zcode 的 model-detect 读数（2026-09-28）为 `stepfun/step-5-preview`，如实披露不替换。(c) 终裁声明：全部命题与证明经 Lean 4 kernel 编译裁决，0 sorry，公理限白名单。(d) AI 不列为作者；人类作者终审并对全部内容负责。

## 已知观感项与边界（如实记档，不影响质检门）

- **篇幅口径**：SOP 08b 职责节写「claim note，2–4 页」，本短笺编译为 **14 页**；**用户 2026-09-28 裁决＝追认超顶并转为显式豁免**，条款已落 `harness/departments/08b-claim.md`《已知边界》（唯一正确收缩方式＝把逐字 listing 移出正文、留包内 `proofs/`，禁止删证据或降口径），卡面追认节见源仓 `claims/grid3n-diag-2notch/card.md`；超出部分全部是逐字 listing（statement 侧 7 块 + 终稿侧 4 块，共 11 处）与 C9 查新表，删它们会牺牲「冻结产物逐字快照」这条硬要求。与首批 `claims/chorded-cycle-mod4`（10 页）同口径，此处如实分列而不改文。
- 第 1 轮编译 3 处 Overfull（146.06 / 121.36 / 21.06 pt，长路径串不可断行所致），第 2 轮改 `\path{}` 后归零；sha256 串用可断点写法。终轮 0 Missing character、0 未解引用；Underfull 9 处（badness 最高 10000）纯观感。
- 唯一字形告警为 `TU/SimSun(0)/m/it`（中文注释被 listings 的 commentstyle 斜体化时缺 slanted 变体），纯观感。
- 短笺措辞上限：价值级只到 **new sequence / new recurrence**（「新递推」仅指七阶递推与母族 A033506 不同谱、机器双向核验互不满足这一含义）；PM 偶 n 子列 = OEIS A061278 已挂名占位，禁作新颖性主张；组合语义桥只作 conjecture；mod-4/mod-3 周期与任意模存在性如实列「未证出/未立项」。
- 源任务 report.md（裁决书与过程档案在源仓 `tasks/20260928-comb07-diagnotch/`，不随包）文件头仍为「待闸门四人工签发」；本占位包由用户 2026-09-28 指令启动出包并当场行使签发权（占位通道启动权即用户指令），此口径已原文级写入短笺 Scope and limitations 第 (e) 条与源仓 card.md，不回改 tasks/ 产物。
- OEIS 提交（路由表的社区层）属用户手动，且本仓提交侧通道未实测、账号实名与「署名用账号名」策略冲突未解 → 见 UPLOAD.md 第 3 步与 SOP 08b《已知边界》。
- 脱敏 GitHub 快照仓：用户 2026-09-28 指令「gh推送授权，全做」授权并已执行——只推 `zenodo/` 内容至 `https://github.com/Aurora0134/ai4math-claims` 的 `grid3n-diag-2notch/` 目录；commit 与时间戳见源仓 `claims/grid3n-diag-2notch/card.md》。
