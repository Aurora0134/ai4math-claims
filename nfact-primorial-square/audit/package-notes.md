# 包体自我描述：包内有什么、特意不放什么

> 本文件是本包的**自我描述件**，先于出包写成（不是事后追记）。
> 依据 = SOP 08b《已知边界》末条：「包体自我描述的失实是本通道的主要失效模式」。

## 一、本包是什么

x² = n!·n# 完全解集定理（源任务 `tasks/20261006-nfact-primorial-square/`，完全证明，闸门三 PASS）
的优先权存缴记录：占位短笺（LaTeX 源 + PDF）、Lean 4 证明源（statement 源 + 冻结快照 + 终件全文 +
工具链钉）、审计证据（终裁书规范化副本 / 良定义机出件 / 公理打印实录 / 对称差与 listing 核验记录 /
编译与静态门输出）与 C9 查新全量记录（逐字拼接件）。

## 二、包结构（生成块：逐件字节数按实测渲染，路径相对 `zenodo/`）

<!-- FACTS-BEGIN inv scope=deposit -->
@row      935  audit/axioms.out
@row     2076  audit/bib-verify.md
@row     6263  audit/c9-record.md
@row     3089  audit/claim-check.md
@row    19202  audit/compile-run.log
@row     6329  audit/faithful.md
@row    17566  audit/gate3-final-adjudication.txt
@row       66  audit/lint.txt
@row      358  audit/listing-verify.txt
@row     5870  audit/package-notes.md
@row      180  audit/welldef-nfact-primorial-square.txt
@row   224738  claim/claim.pdf
@row    56913  claim/claim.tex
@row     7569  claim/lstlean.tex
@row      951  metadata/FILE-MANIFEST.txt
@row     8354  metadata/README.md
@row     2335  metadata/zenodo.json
@row    62242  proofs/final-nfact-primorial-square.lean
@row       25  proofs/lean-toolchain
@row     4522  proofs/nfact-primorial-square.lean
@row     4747  proofs/nfact-primorial-square.statement.txt
<!-- FACTS-END -->

## 三、**特意不放**的项（每一行都是**不在本包**的件；它们都在源仓任务目录里）

| 项（**不在本包**） | 位置 | 为什么不放 |
|---|---|---|
| 原始检索回包（JSON / XML / HTML 页面快照） | 源任务与深挖批、复核批的查新目录（源仓，不随包） | 体量大且多为第三方页面快照；C9 的结论与查询串已逐字入 `c9-record.md`。 |
| 生态镜像（formal-conjectures tarball 与解压体） | 深挖批任务目录（批末已按磁盘生命周期①删除） | 命中结论已在 C9 记录层入库，镜像本体不留。 |
| 中间轮产物（各 mission 的证明件、prompt 原文、诊断与交接报告） | 源任务目录的 `attempts/` 与 tower 留痕（源仓，不随包） | 过程档案属源任务；路线证伪事实已在短笺 Proof 节如实叙述，未隐藏。 |
| 证明链的组件层文件（引理 A / 见证层 / 引理 B 链与尾的分件） | 源任务 `attempts/` 各子目录（源仓，不随包） | 终件是自包含单文件（仅 import Mathlib），组件分件的全部承重内容已并入终件。 |
| 构建三件套（lakefile / manifest 等） | — | 本包只带 `proofs/lean-toolchain`（版本钉），不含任何构建脚本（宪条 6）。 |
| 闸门三的探针件与临时 scratch | 源任务 `tmp-probe/` 流程（用后已删） | 探针 = 终件逐字拷贝 + 尾部探针行；终件本体随包，探针构造法在终裁书《复现命令清单》逐字在案。 |
| 打包轨公理探针的完整编译日志 | 源仓 `tmp-probe/claim-nfact/`（不随包） | 其承重输出（八条 depends-on-axioms 行）逐字入 `audit/axioms.out`；日志其余为数学内容无关的提示文本。 |
| 交付目录根的装配工作件（build / verify 脚本与骨架） | 交付目录 `audit/`（源仓，不随存缴树） | 装配轨工具件；其核验输出（listing-verify / lint / compile 记录）已随包。 |

## 四、包内副本的**机械处理**（逐条披露，裁决内容一字未改）

为过机械对账门的「无本机路径」门，入包副本做了下列**可复算文本规范化**：

| 处理 | 涉及件 | 内容 |
|---|---|---|
| 本机路径前缀剥离 | `audit/gate3-final-adjudication.txt` | 文本里出现的本机绝对路径前缀剥为 `<AI4MATH-REPO-ROOT>`（共三处，全部在该件的《复现命令清单》脚本段）。**裁决正文一字未改**；源件全部行尾本即 LF，无需行尾处理。 |

**原始件一字未动**：源文件仍留在源任务目录保持原样，本包内的只是入包副本。
其余入包件（`welldef-nfact-primorial-square.txt`、`faithful.md`（roundtrip 忠实性记录，源任务冻结件）、
`c9-record.md`、`axioms.out`、`listing-verify.txt`、`lint.txt`、`compile-run.log`、`proofs/` 全部四件、
`claim/` 全部三件）均为**逐字节拷贝**，无任何规范化处理。

## 五、页数与渲染

- 编译页数见 `zenodo/metadata/README.md` 的「包体自述生成块」（生成块，按随包 PDF 实测；本件不复写
  该数字）。该页数超出 SOP 08b 职责节「claim note，2–4 页」口径；豁免依据：超出部分全部是逐字冻结
  快照 / 终件 listing 摘录与 C9 查新表（禁止为凑页数删证据或降口径）。
- 渲染：编译日志 `Missing character` 计数为零；`Overfull \hbox` 计数为零。

## 六、外发边界

本包是 **upload-ready 包**：占位质检门前两项（`paper-lint` 全绿 / `tectonic` 硬编译 exit 0）与
仓库级机械对账门（第四门按默认调用 SKIPPED，见 `metadata/README.md`）均已执行；质检门③精简主张
审计由监察院执行，裁决书本体（`audit/claim-check.md`）于裁决后补入存缴树——在裁决前的修订中该件
not shipped，裁决后即随包（是否已在树内以「包结构」生成块清单为准）。
本批外发授权 = 批次卡 `tasks/20261006-paper-nfact-primorial/card.md` 覆盖事件 O-1（Zenodo publish +
GitHub 推送由主代理直接执行，仅本篇）；该授权不改变本包的证据义务。
