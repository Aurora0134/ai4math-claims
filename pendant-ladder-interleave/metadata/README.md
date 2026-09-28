# Zenodo 存缴包 README — pendant-ladder-interleave（AI4Math claim-of-record artifact）

> AI 生成（2026-09-28）。本包为 SOP 08b 占位通道产物；上传/发布/推送（外发）一律用户本人手动执行，见 `claims/pendant-ladder-interleave/UPLOAD.md`。本通道不依赖 arXiv 账号与背书。**外发实况（2026-09-28 errata）**：GitHub 公开镜像推送已按用户指令完成（追加到既有镜像仓，提交号见 `claims/pendant-ladder-interleave/card.md` 的「GitHub 快照」节）；Zenodo 上传与 DOI 预留仍待用户手动。

## 发布前必跑（只读）

```bash
python claims/pendant-ladder-interleave/audit/sanitize-package.py --check-only
# 三件：FILE-MANIFEST 与盘上一致 / 包内外承诺对账 / 无本机路径
```

## DOI

- **未预留**：Zenodo 草稿页 "Get a DOI now!" 由用户执行后产生；本包不含真实 DOI。
- 回填点：本文件 + `claims/pendant-ladder-interleave/card.md` + `run-state.md`；短笺 Data availability 段已按「DOI 于上传时预留」写法处理，未留占位串。
- **时间戳现状**（2026-09-28 errata）：GitHub 公开镜像推送即构成本成果的公开优先权记录（2026-09-28 用户显式指令「推送」后执行，推送实况与提交号见 `claims/pendant-ladder-interleave/card.md` 的「GitHub 快照」节与 `run-state.md`）；Zenodo 发布为第二重记录与可引用 DOI，仍待用户手动。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；四条 `% LEAN:` 锚点（apend_interleave / apend_mod2_period12 / opend_mod2_period6 / epend_mod2_period3，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0，`Missing character` 0，Overfull 0，16 页）。前导含渲染专用 XeTeX 补丁：`\lccode` 活动字符只补 xeCJK 标点表之外的码位（本包集合 2115/2124/2190/2192/2194/21A6/2200/2203/2212/2227/2261/2264/2265/27E8/27E9/27FA），00B7/2014/CJK 与全角标点交 xeCJK+SimSun 路由；listing 源字节不动 |
| `claim/lstlean.tex` | listings 的 Lean 语法定义（单一事实源在 `harness/templates/paper/`，随包拷贝以自编译） |
| `proofs/01-pend-statements.lean` | 冻结 statement（113 行，proof body 为 sorry 占位）sha256=`78bccc97afba79adea9658a2158d17b2ed247b584d9f28266e6fc7914ba9f922` |
| `proofs/01-pend-proved.lean` | 终稿四定理（259 行，0 sorry）sha256=`be3f31cb365aa7b805dce0d29e562b5dfdb12617007f888e67564dacfd22540b` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-01-pend.txt` | 闸门三终态审计（8 项核查全过；四定理=完全证明；强制披露限定语 L1–L10 + 补充 2 条原文级） |
| `audit/welldef-verdict.md` + `audit/gate-t1.txt`/`gate-t2.txt`/`gate-t3o.txt`/`gate-t3e.txt` + `audit/gate-t1-ring.txt` | 闸门二良定义与退化探针（主代理 gate ×4 + 宪兵复跑冻结件 + ring 补探针；33/33 探针 FAIL → 非退化） |
| `audit/statement-diff.out` | 终稿 ↔ 冻结件对称差记录（10 块程序化抽取 ALL_IDENTICAL） |
| `audit/axioms-recheck.out` | 监察院公理独立复跑输出（与 `final/axioms.out` 逐字节一致） |
| `audit/audit-axioms-sidecar.log` | `#print axioms` 原文四行（四定理各 `[propext, Quot.sound]`，无 sorryAx）——即任务 `final/axioms.out` 全部内容（原件已无本机路径，由 `audit/sanitize-package.py` 加头注重建） |
| `audit/audit-strict-compile.log` | 终稿 strict 编译输出记录：原运行 stdout 为空（0 error 0 warning，零字节文件）；EXIT=0 的载体是 `audit/final-01-pend.txt` 第 4–5 项的监察院两次复跑（70.0s / 41.3s） |
| `audit/c9-record.md` | C9 独占性复审全量记录逐字抽取（新颖性证据主体；源 `tasks/20260927-mossad-select/c9-recheck/chunk-F.md`（sha256=`2067ce90a6d9305c9c5acfa08bd598b5aaeedf7c97e0e4835e410f3fe6aa61cf`）第 1-6 / 8-13 / 17-94 / 213-225 行四段：块头纪律 + 锚点自证 + MAT-PEND 全节 + 区块小结/统计/灰区提示；另加打包者出处注记头（含 L27 交替挂法旧说已被 Phase 0 证伪的更正版指针）与文末哈希自检附录，记录正文未改写）。自检：`python claims/pendant-ladder-interleave/audit/build-c9-record.py --check` → 4/4 逐字 PASS |
| `audit/lint.txt` / `audit/compile.txt` | 本包 paper-lint（PASS, exit 0）与 paper-compile（exit 0）输出 |
| `audit/listing-verify.txt` | 短笺五处 lstlisting 与冻结产物逐字节核验记录（5/5 PASS；终稿全文 259 行算一处） |
| `audit/inspect-tex.py` / `audit/build-c9-record.py` / `audit/sanitize-package.py` / `audit/make-zip.py` | 装配与自检脚本：listing 注入与逐字节核验、非 ASCII 出网检查、C9 记录四段构建与自检、包脱敏与承诺对账与 FILE-MANIFEST 生成、zip 构建与断言 |
| `audit/claim-check.md` | 监察院精简主张审计六项核对裁决（占位质检门③；裁决回交后拷入，发布前提） |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134、无 orcid 键，2026-09-28 errata 按用户既定署名策略填实；contributors 保留 AI 披露；related_identifiers.references = OEIS A386889、isIdenticalTo = GitHub 镜像仓，同 errata 追加） |
| `metadata/FILE-MANIFEST.txt` | 包内逐件 sha256 + 字节数清单（发布前复算即用此件） |
| `metadata/README.md` | 本文件 |

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0 便携版（本机），XeTeX 路径。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 01-pend-proved.lean
# 期望：exit 0，stdout 为空（0 error 0 warning）
```

公理复核（本仓纪律：sidecar 另起文件，用完即删，不进 final）：在本目录放一个只含下面五行的临时文件，`lake env lean` 它，然后删除：

```lean
import «01-pend-proved»   -- 与本包 proofs/01-pend-proved.lean 同名的模块
#print axioms apend_interleave
#print axioms apend_mod2_period12
#print axioms opend_mod2_period6
#print axioms epend_mod2_period3
```

任务级全部过程档案（Phase 0 枚举/拟合脚本、roundtrip 留档、攻证轮次与诊断原文）留本仓 `tasks/20260927-mossad-pend/`；C9 原始查询回包留 `tasks/20260927-mossad-select/`，均不入本包。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## 已知观感项与边界（如实记档，不影响质检门）

- **篇幅口径（显式豁免）**：SOP 08b 职责节写「claim note，2–4 页」，本短笺编译为 **16 页**；超出部分全部是逐字 listing（冻结 statement 四段共 80 行 + 终稿全文 259 行）与 C9 查新表，删它们会牺牲「冻结产物逐字快照」这条硬要求。豁免依据 = SOP 08b《已知边界》页数条款（2026-09-28 用户裁决「追认超顶，转显式豁免」）；本行与 `claims/pendant-ladder-interleave/card.md` 的同款行互为出处。
- 唯一字形告警为 `TU/SimSun(0)/m/it`（中文注释被 listings 的 commentstyle 斜体化时缺 slanted 变体），纯观感；`Missing character` 0、Overfull 0。
- 短笺措辞上限：价值级只到 **new sequence / new recurrence（含占位警示）**；组合语义桥只作 conjecture；奇数子列提及必带 A386889 挂名围栏；交替挂法旧说已证伪并锁定统一挂侧约定。
- `tasks/20260927-mossad-pend/report.md` 文件头仍为「待闸门四人工签发」；本包由用户 2026-09-28 显式指令启动出包并当场行使签发权（占位通道启动权即用户指令），此口径已原文级写入短笺 Scope and limitations 第 (f) 条与本目录 `card.md`。
- OEIS 提交（路由表的社区层）属用户手动，且本仓提交侧通道未实测 → 见 UPLOAD.md 第 3 步与 SOP 08b《已知边界》。
