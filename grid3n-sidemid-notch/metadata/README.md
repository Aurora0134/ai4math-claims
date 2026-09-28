# Zenodo 存缴包 README — grid3n-sidemid-notch（AI4Math claim-of-record artifact）

> AI 生成（2026-09-28）。本包为 SOP 08b 占位通道产物；上传/发布（外发）一律用户本人手动执行，步骤清单在源仓 `claims/grid3n-sidemid-notch/UPLOAD.md`（deliverable 目录件，不随包）。本通道不依赖 arXiv 账号与背书。

## 发布前必跑（只读）

```bash
python scripts/sanitize-package.py claims/grid3n-sidemid-notch
# 判据：清单一致 / 包内外承诺对账 / 无本机路径 / 结构后检 / 自述范围，任一不绿不得外发
```

## DOI

- **未预留**：Zenodo 草稿页 "Get a DOI now!" 由用户执行后产生；本包不含真实 DOI。短笺 Data availability 段的该字段当前为未填字段，写作 `RESERVED-DOI`（明写 unfilled field）。
- 回填点：本文件、短笺 `claim/claim.tex` 的 Data availability 段（替换后重编 PDF，包内 `claim/claim.pdf` 同步更新）、以及源仓 `claims/grid3n-sidemid-notch/card.md` 与 `run-state.md`（均在源仓，不随包）。
- **时间戳现状**：截至本包装配日（2026-09-28），Zenodo 上传未执行（留用户手动）；GitHub 公开快照仓已按用户 2026-09-28 指令「gh推送授权，全做」推送至 `https://github.com/Aurora0134/ai4math-claims` 的 `grid3n-sidemid-notch/` 目录（commit 与时间戳见源仓 card.md），**本包公开时间戳自该推送生效**；Zenodo 占位生效以用户实际上传为准。用户 2026-09-28 指令「预算放开，做完剩下的工作并走完快速占位通道……」已行使本通道启动权与闸门四签发权（见短笺 Scope and limitations 第 (d) 条）。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；三条 `% LEAN:` 锚点（asid_interleave / asid_mod2_period3 / asid_mod4_period12，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0，15 页，`Missing character` 0，Overfull 0，无未解引用；五轮编译全绿，明细见 `audit/compile.txt`）。前导含渲染专用 XeTeX 补丁：`\lccode` 活动字符只补 xeCJK 标点表**之外**的码位（本案 2115/2124/2190/2192/21A6/2200/2203/2208/2212/2227/2261/2265/27E8/27E9/27FA 加模板块的 2022/2194/2228/2264/22A2），00B7/2014/3002 与全角标点交 xeCJK+SimSun 路由；listing 源字节不动 |
| `claim/lstlean.tex` | listings 的 Lean 语法定义（单一事实源在 `harness/templates/paper/`，随包拷贝以自编译；与论文包同源逐字节一致） |
| `proofs/01-comb08-sidemid-statements.lean` | 冻结 statement（109 行，proof body 为 sorry 占位）sha256=`5fe889d5ed92711a86f23d9827800dd7d2c677a440664f0d81dbdb5e9eb39e67` |
| `proofs/01-comb08-sidemid-proved.lean` | 终稿三定理（238 行，0 sorry）sha256=`19b5c3908592a529491e0b5b40b6b26166019d92820447b41a70ada510a20821` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-comb08-sidemid.txt` | 闸门三终态审计裁决书（四项核查全 PASS；三定理 = 完全证明；statement 头部对称差 8/8 逐字一致） |
| `audit/axioms-asid_interleave.txt` / `axioms-asid_mod2_period3.txt` / `axioms-asid_mod4_period12.txt` | 三条主定理的公理探针输出原文（各两行：`WELLDEF OK` + `AXIOMS … [propext, Quot.sound]`） |
| `audit/c9-record.md` | C9 独占性复审全量记录逐字拷贝（新颖性证据主体）：`tasks/20260928-comb0709-deeprecheck/recheck/deep-recheck-combm-02.md` 整文件 46 行逐字（sha256 `79e7ee63f706d09c5fdcc5b4628a57f979869954865704a26cd34388e258df98`）+ 同目录 `deep-recheck-shared.md` §8 三候选裁决汇总表（第 131–137 行）逐字；仅加打包者出处注记头与文末哈希自检附录，正文未改写 |
| `audit/compile.txt` / `audit/lint.txt` | 本包 paper-compile（exit 0，五轮）与 paper-lint（PASS, exit 0）记录 |
| `audit/listing-verify.txt` | 短笺八处 lstlisting 与冻结产物逐字节核验记录（8/8 PASS；脚本 `audit/inspect-tex.py`） |
| `audit/inspect-tex.py` / `audit/build-c9-record.py` / `audit/build-manifest.py` / `audit/sanitize-package.py`(+`.txt`) | 装配与自检脚本：listing 注入与逐字节核验、非 ASCII 出网检查、C9 记录构建与自检、清单生成、包对账门（`sanitize-package.py` 为运行时 `scripts/sanitize-package.py` 的冻结副本，来源见 `audit/sanitize-package.txt`） |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134，无 orcid 键，上传时由用户填实；contributors 保留 AI 披露；related_identifiers 列 OEIS + GitHub 镜像 isIdenticalTo（已推送） |
| `metadata/FILE-MANIFEST.txt` | 包内逐件 sha256 + 字节数清单（发布前复算即用此件） |
| `metadata/README.md` | 本文件 |

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0 便携版（本机），XeTeX 路径。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 01-comb08-sidemid-proved.lean
# 期望：exit 0，无诊断输出
```

公理复核（本仓纪律：sidecar 另起文件，用完即删，不进 final）：在本目录放一个只含下面四行的临时文件，`lake env lean` 它，然后删除：

```lean
import «01-comb08-sidemid-proved»   -- 与本包 proofs/01-comb08-sidemid-proved.lean 同名的模块
#print axioms asid_interleave
#print axioms asid_mod2_period3
#print axioms asid_mod4_period12
```

期望三条均恰 `[propext, Quot.sound]`（辅助引理 asid_evenlag12 同；定义展开 asid_shift 为 `[propext]`；sorryAx 与 Classical.choice 零出现）。终态审计独立抽查记录见 `audit/final-comb08-sidemid.txt` §四。

任务级全部过程档案（Phase 0 枚举/拟合脚本、roundtrip 留档、攻证轮次与诊断原文）留本仓 `tasks/20260928-comb08-sidemid/`；C9 原始查询回包留 `tasks/20260928-comb0709-deeprecheck/recheck/`（均在源仓，不随包）。

## 本地路径相对化披露

四件源任务审计副本（`audit/final-comb08-sidemid.txt`、`audit/axioms-asid_*.txt`）入包前已按「盘符 + 用户目录」型绝对路径模式与本机用户名逐件扫描：**零命中**，故无需相对化、原样入包。`audit/c9-record.md` 为逐字证据记录，其中出现的 `127.0.0.1:4180` 是本机本地代理回环地址（检索通道留痕，非用户标识），按「逐字不可改」纪律保留。全包本机路径复扫由 `sanitize-package.py` 门三执行（ALL GATES GREEN）。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## 已知观感项与边界（如实记档，不影响质检门）

- **篇幅口径**：SOP 08b 职责节写「claim note，2–4 页」，本短笺编译为 **15 页**；**用户 2026-09-28 裁决＝追认超顶并转为显式豁免**，条款已落 `harness/departments/08b-claim.md`《已知边界》（唯一正确收缩方式＝把逐字 listing 移出正文、留包内 `proofs/`，禁止删证据或降口径），卡面追认节见源仓 `claims/grid3n-sidemid-notch/card.md`（不随包）；超出部分全部是逐字 listing（statement 四组 + 终稿四组，共 8 块）与 C9 裁决逐字引文块，删它们会牺牲「冻结产物逐字快照」这条硬要求。
- **闸门四双口径**：源任务 `tasks/20260928-comb08-sidemid/report.md`（源仓件，不随包）文件头仍为「待闸门四人工签发」；本包由用户 2026-09-28 显式指令启动出包并当场行使签发权（占位通道启动权即用户指令），此口径已原文级写入短笺 Scope and limitations 第 (d) 条，源仓 tasks/ 产物未回改。
- **价值级围栏**（照抄源候选卡 §0 与 C9 记录）：价值级仅「新序列」——六阶递推与 A033506（无缺陷 3×n 全匹配）同特征多项式（签名 (4,14,0,−10,0,1) 逐字相同），禁止对递推阶与系数作新颖性主张；PM≡0 为奇偶+洞色双重否决的真空命题，不构成占位亦不作价值主体。短笺正文两段逐字引文块（lst:fence / lst:c9verdict）即该围栏与 C9 裁决的原文。
- **OEIS 提交**（路由表的社区层）属用户手动，且本仓提交侧通道未实测、账号实名与「署名用账号名」策略冲突未解 → 见源仓 UPLOAD.md 第 3 步与 SOP 08b《已知边界》。
- **GitHub 快照仓**：用户 2026-09-28 指令「gh推送授权，全做」授权并已执行；只推 `zenodo/` 内容（commit 与时间戳见源仓 card.md）。
