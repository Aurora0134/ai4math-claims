# Zenodo 存缴包 README — grid4n-col-2notch（AI4Math claim-of-record artifact）

> AI 生成（2026-09-28）。本包为 SOP 08b 占位通道产物；上传/发布（外发）一律用户本人手动执行，见 `claims/grid4n-col-2notch/UPLOAD.md`（在源仓，不随包）。本通道不依赖 arXiv 账号与背书。
> 成果：4×n 网格删右列上下两角点匹配计数序列（a(n) = 2, 15, 209, 2426, 29566, …）的交织恒等式与 parity/mod-4 律，三条定理均经 Lean 4 kernel 完全证明。

## 发布前必跑（只读）

```bash
python scripts/sanitize-package.py claims/grid4n-col-2notch
# 判据：清单一致 / 包内外承诺对账 / 无本机路径 / 结构后检（裸 CR、括号深度）
# 唯一写盘模式是 --write-manifest（重生成 metadata/FILE-MANIFEST.txt 的行集；
# 注意该模式只写字节数，重生成后需补回 sha256 列——本包随附的逐件 sha256
# 由装配会话现算，格式与门解析兼容）
```

## DOI

- **未预留**：Zenodo 草稿页 "Get a DOI now!" 由用户执行后产生；本包不含真实 DOI。短笺 Data availability 段写 `RESERVED-DOI`（unfilled field，明示未填）。
- 回填点：本文件 + `claims/grid4n-col-2notch/card.md`（在源仓，不随包）+ `run-state.md`（在源仓，不随包）。
- **GitHub 快照仓**：用户 2026-09-28 指令「gh推送授权，全做」授权并已执行——只推 `zenodo/` 内容至 `https://github.com/Aurora0134/ai4math-claims` 的 `grid4n-col-2notch/` 目录（commit 与时间戳见源仓 `claims/grid4n-col-2notch/card.md`；步骤见同目录 UPLOAD.md 第 4 步，在源仓，不随包）。
- **慢车道互链**：同一成果的论文包在 `papers/grid4n-col-2notch/`（源仓，不随包；26 页，成文质检门三项全过），两通道经 DOI 互链。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；三条 `% LEAN:` 锚点（atc_interleave / atc_mod2_period5 / atc_mod4_period10，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0；17 页，`Missing character` 0，终遍未解引用 0，Overfull \hbox 5 处最大 38.34pt；LaTeX 编译轮 4/6）。前导含渲染专用 XeTeX 补丁：`\lccode` 活动字符补模板集 + 00B2/00D7/21A6/2212/27FA，`00B7/2014/2026` 与 CJK/全宽标点交 xeCJK+SimSun 路由（先设活动会加载期报错，论文包同案实证）；listing 源字节不动 |
| `claim/lstlean.tex` | listings 的 Lean 语法定义（单一事实源在 `harness/templates/paper/lstlean.tex`，随包逐字拷贝以自编译） |
| `proofs/01-comb09-4ntwocorner-statements.lean` | 冻结 statement（5 def + 3 theorem，127 行，LF，proof body 为 sorry 占位）sha256=`4cb1083846bcc64e249717309e63d071d0ecf5bb03f23d85affeaab8152ce005` |
| `proofs/01-comb09-4ntwocorner-proved.lean` | 终稿（三定理 + 辅助引理 atc_sq，420 行，0 sorry，**CRLF** 行尾逐字节拷贝）sha256=`f1aa7099697fe5706bc5f4dd7124d06f4f92d6c2273b349b862c4b963806f53f` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-comb09-4ntwocorner.txt` | 监察院闸门三终态审计裁决书（四项核查全过；分级结论【完全证明】；对称差 8/8；sorry/admit 0；公理白名单子集） |
| `audit/axioms-atc_interleave.txt` / `axioms-atc_mod2_period5.txt` / `axioms-atc_mod4_period10.txt` | 主链 gate-batch 公理审计原文（每件两行：`WELLDEF OK` + `AXIOMS <decl> [...]`） |
| `audit/axioms-recheck.txt` | 监察院抽查复跑（合并终稿为 base 的 atc_interleave 公理复核，与主链产物逐字一致） |
| `audit/c9-record.md` | C9 独占性复审全量记录逐字全文（新颖性证据主体）：`deep-recheck-combm-03.md` 整文件（47 行，源 sha256=`2348cef83f13413902162c9565352e6e104a872bea25a934191c21f57365c253`）+ `deep-recheck-shared.md` §8 汇总表第 131–137 行（源 sha256=`d5270429e87d79dd8b53a4f68a42aa938ec38db59dacd5fab73addeaacf8166f`）；仅加打包者出处注记头与文末哈希自检附录，结论句未改写 |
| `audit/lint.txt` / `audit/compile.txt` | 本包 paper-lint（PASS, exit 0）与 paper-compile（exit 0）输出（compile.txt 含指标头 + 原始日志） |
| `audit/listing-verify.txt` | 短笺九处 lstlisting 与冻结产物逐字节核验记录（9/9 PASS；核验脚本 `claims/grid4n-col-2notch/audit/inspect-tex.py` 在源仓，不随包） |
| `audit/sanitize-package.py` | 清单对账门的随包冻结副本：运行时 `scripts/sanitize-package.py` 的逐字节拷贝（源 sha256=`8ee3b9ea7f950091a9e60119e7cb2256aa91d0d7379dcf05624b3001d90f609b`，与副本同值），供发布前复跑三门 |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134，无 orcid 键；contributors 保留 AI 披露；related_identifiers = OEIS A033507/A129113 两条 references） |
| `metadata/FILE-MANIFEST.txt` | 包内逐件 sha256 + 字节数清单（行集由 `sanitize-package.py --write-manifest` 生成、sha256 列由装配会话现算追加；发布前复算即用此件） |
| `metadata/README.md` | 本文件 |

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0 便携版（本机），XeTeX 路径。

## 各声明实测公理集（照抄审计产物）

| 声明 | 实测公理集（verbatim） |
|---|---|
| `atc_interleave` | `[propext, Classical.choice, Quot.sound]` |
| `atc_mod2_period5` | `[propext, Quot.sound]` |
| `atc_mod4_period10` | `[propext, Quot.sound]` |

白名单为 {propext, Quot.sound, Classical.choice}；sorryAx 零出现；终稿 0 sorry（含注释全文扫描）。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 01-comb09-4ntwocorner-proved.lean
# 期望：exit 0，零诊断（strict 模式；grep sorry/admit 0 处）
```

公理复核：在本目录放一个只含下面五行的临时文件，`lake env lean` 它，然后删除：

```lean
import «01-comb09-4ntwocorner-proved»   -- 与本包 proofs/ 下终稿同名的模块
#print axioms atc_interleave
#print axioms atc_mod2_period5
#print axioms atc_mod4_period10
```

任务级全部过程档案（Phase 0 枚举/拟合脚本、roundtrip 留档、攻证轮次与诊断原文、报告）留本仓 `tasks/20260928-comb09-4ntwocorner/`；C9 原始查询回包留 `tasks/20260928-comb0709-deeprecheck/`，均不入本包。

## 行尾披露（显著）

- 随包终稿 `proofs/01-comb09-4ntwocorner-proved.lean` 是源任务产物的**逐字节拷贝，保持 CRLF 行尾**（sha256 与源任务现算一致，见上表）。
- 冻结 statement `proofs/01-comb09-4ntwocorner-statements.lean` 是 **LF** 行尾的源产物逐字节拷贝。
- 短笺 `claim/claim.tex` 内九处 lstlisting 摘录（statement 五处 + 终稿四处）的**行尾归一化为 LF，不改其他字节**；逐字节核验记录在 `audit/listing-verify.txt`（9/9 PASS）。
- 短笺源码、`metadata/` 与 `audit/` 下随包文本件均为 LF；包内裸 CR 计数 0（`sanitize-package.py` 结构后检覆盖）。

## 源任务审计副本的相对化说明

- `audit/` 下五件源任务副本（`final-comb09-4ntwocorner.txt`、`axioms-atc_interleave.txt`、`axioms-atc_mod2_period5.txt`、`axioms-atc_mod4_period10.txt`、`axioms-recheck.txt`）为逐字节拷贝；拷贝前经本机绝对路径（用户主目录字样）与用户名字样复扫 **0 命中**——源件内路径本就是仓库相对路径，无需相对化。
- `audit/compile.txt` 为本包 tectonic 输出；同样复扫 0 命中（引擎唯一点名的绝对路径是系统字体 `C:/WINDOWS/fonts/simsun.ttc`，非用户主目录，原样保留）。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## 已知观感项与边界（如实记档，不影响质检门）

- **篇幅口径（显式豁免）**：SOP 08b 职责节写「claim note，2–4 页」，本短笺编译为 **17 页**；**用户 2026-09-28 裁决＝追认超顶并转为显式豁免**，条款已落 `harness/departments/08b-claim.md`《已知边界》（唯一正确收缩方式＝把逐字 listing 移出正文、留包内 `proofs/`，禁止删证据或降口径）。超出部分全部是逐字冻结快照（statement 五处 + atc_sq 引理全 + T1 完整证明 + T2/T3 归纳步摘录，共 234 行 listing）、C9 查新表与两条逐字裁决/围栏块；卡面（`claims/grid4n-col-2notch/card.md`「页数口径」节）已按实测补记一行：17 页、超出构成（九处逐字 listing 共 234 行 + C9 查新表 + 两条逐字裁决/围栏块）与豁免出处，与本文件一致。
- 编译指标（第 4 轮实测，LaTeX 编译轮 4/6；指标与第 3 轮逐项一致——镜像推送轮为纯散文层改动不动版面）：`Missing character` 0、终遍未解引用 0、Overfull \hbox 5 处（31.59 / 8.03 / 38.34 / 9.11 / 38.22 pt，最大 38.34pt；其中 31.59/8.03pt 为两处 aligned 展示式残余，与论文包同显示式同值）、Underfull 19 处观感项；pymupdf 全页右缘扫描最大 522.65pt < 612pt 页宽、0 块越页。逐轮指标与原始日志在 `audit/compile.txt`（第 1 轮「Overfull 0」为打包方测量错误所致的假记录，已按工序五审计 F1-b 订正为实测 9 处最大 199.66pt，原记录不修饰、以订正行留档）。
- 唯一字形环境项：tectonic 访问系统字体 `C:/WINDOWS/fonts/simsun.ttc` 时引擎自带的「absolute path」提示（跨环境可复现性提示，非本包路径泄漏）。
- **措辞上限**：价值级只到 **new sequence**；九阶递推与 OEIS A033507 同谱（挂名递推，同谱姊妹序列）、PM 子列 = OEIS A129113 已占位——两条占位围栏逐字照抄进短笺 Novelty evidence 节，禁对递推本身与 PM 子列作新颖性主张；组合语义桥（序列 = 挖角网格匹配数）只作猜想；最小阶/最小周期/特征多项式/母函数为计算事实。
- `tasks/20260928-comb09-4ntwocorner/report.md`（源仓件，不随包）文件头仍为「待闸门四人工签发」；本包由用户 2026-09-28 指令启动出包并当场行使签发权（占位通道启动权即用户指令），此口径已写入短笺 Scope and limitations 第 (e) 条与本目录 `card.md`（在源仓，不随包）。
- OEIS 提交（路由表的社区层）属用户手动，且本仓提交侧通道未实测、账号实名与「署名用账号名」策略冲突未解 → 见 UPLOAD.md 第 3 步（在源仓，不随包）与 SOP 08b《已知边界》。
- 节点快照：任务侧记账节点 `anthropic/a6api-main/kimi-k3`（同日持久记录另有 `stepfun/step-5-preview`，论文线两次闭环节复审实测后者；漂移已在任务卡/论文卡/短笺 AI 披露节如实披露）。本包 llm-call 实耗 0，LaTeX 编译 1/6，装配由本会话派发执行（1 采样）。

## AI 披露（四要素压缩版）

(a) AI 承担环节：选题与 C9 独占性复审、形式化（5 def + 3 theorem）、roundtrip 语义校验、引理名 kernel 批量预检、证明搜索与证明脚本撰写、错误分类与修复、终稿组装、审计复跑、散文证明翻译、本短笺装配（含逐字 listing）。
(b) 模型-节点-预算：任务阶段全部采样跑在单节点 wire-id `anthropic/a6api-main/kimi-k3`，未跨节点；实耗 **9/20 采样（agent-run）、1/6 llm-call、25/32 Lean 编译**（照抄源任务 `budget.log` 各行实计，在源仓，不随包）。本短笺消耗 0 次流水线 LLM 调用；LaTeX 编译 1/6 记本通道账本（`claims/grid4n-col-2notch/budget.log`，在源仓，不随包）。
(c) 终裁声明：所有报告陈述与证明均由 Lean 4 kernel 检验：每个证明编译 0 sorry，公理审计仅含 {propext, Quot.sound, Classical.choice} 或其子集。
(d) AI 系统不列为作者；人类作者终审全部证据并对内容负责。
