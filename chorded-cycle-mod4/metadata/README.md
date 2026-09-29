# Zenodo 存缴包 README — chorded-cycle-mod4（AI4Math claim-of-record artifact）

> AI 生成（2026-09-28）。本包为 SOP 08b 占位通道产物；上传/发布（外发）一律用户本人手动执行，见源仓 deliverable 目录的 `claims/chorded-cycle-mod4/UPLOAD.md`（不随包）。本通道不依赖 arXiv 账号与背书。

## 发布前必跑（只读）

```bash
python papers/chorded-cycle-mod4/audit/sanitize-package.py --check-only
# 三件：FILE-MANIFEST 与盘上一致 / 包内外承诺对账 / 无本机路径
```

## DOI

- **未预留**：Zenodo 草稿页 "Get a DOI now!" 由用户执行后产生；本包不含真实 DOI。
- 回填点：本文件 + `claims/chorded-cycle-mod4/card.md` + `run-state.md`；短笺 Data availability 段已按「DOI 于上传时预留」写法处理，未留 `<<占位>>` 字符串。
- **时间戳现状**：GitHub 公开镜像推送即构成本成果的公开优先权记录（推送实况与提交号见 `claims/chorded-cycle-mod4/card.md` 的「GitHub 快照」节与 `run-state.md`）；Zenodo 发布为第二重记录与可引用 DOI。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；三条 `% LEAN:` 锚点（cchordR2_mod_four / cchordR0_mod_four / cchordR1_even_iff，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0，`Missing character` 0，终轮 Overfull 5 处：16.33 / 27.09 / 54.08 / 55.45 / 69.62 pt，其中两处 55/69pt 由 64 位哈希与公理原文块引起，已分别用可断点与小一号等宽解决）。前导含渲染专用 XeTeX 补丁：`\lccode` 活动字符只补 xeCJK 标点表**之外**的 00AC/2212/2223，`00B7/2013/2014/230A/230B` 交 xeCJK+SimSun 路由（先设活动会加载期报错，2026-09-27 实测）；listing 源字节不动 |
| `claim/lstlean.tex` | listings 的 Lean 语法定义（单一事实源在 `harness/templates/paper/`，随包拷贝以自编译） |
| `proofs/01-cchord-mods.lean` | 冻结 statement（87 行，proof body 为 sorry 占位）sha256=`a69d00e537675c40bd13e82344004e7f1abd370dc3d9e543396fbf1818c3a03b` |
| `proofs/01-cchord-proved.lean` | 终稿三定理（262 行，0 sorry）sha256=`af39d35ea29c9a01369473140319f9c330d326601463839875d11b14bbba2237` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-01-cchord.txt` | 闸门三终态审计（四项核查全过；三定理=完全证明；强制披露限定语三条原文级） |
| `audit/welldef-verdict.md` + `audit/gate-c1.txt`/`gate-c2.txt`/`gate-c3.txt` + `audit/gate-recheck-frozen.txt` | 闸门二良定义与退化探针（主代理 gate ×3 + 宪兵复跑冻结件；8 探针×3 全 FAIL，宪兵补 `ring` 为第 9 条亦 FAIL → 非退化；R-C1 无 ZMod 4 decide 捷径裁决） |
| `audit/audit-axioms-sidecar.log` | `#print axioms` 原文三行（三定理各 `[propext, Classical.choice, Quot.sound]`，无 sorryAx）。脱敏：原始 sidecar 每行都回显本机绝对编译路径，故包内件只保留三行 `depends on axioms`（由 `audit/sanitize-package.py` 生成，短笺 Verification evidence 段的 verbatim 块即这三行） |
| `audit/audit-strict-compile.log` | 终稿 strict 编译输出（68 行 if_neg/if_pos deprecation 警告，无 error；该日志缺 `EXIT=` 行，EXIT=0 的载体是 `audit/final-01-cchord.txt` 的监察院两次复跑） |
| `audit/c9-record.md` | C9 独占性复审全量记录逐字全文（新颖性证据主体；源 `tasks/20260927-mossad-select/c9-recheck/chunk-G.md` 第 1-11 / 86-109 / 111-120 / 121-122 行四段，源文件 sha256=`364f5e6b1485d8fc51a488700d398d4e51477aba8cf9618c2308552db5f731e6`；仅加打包者出处注记头与文末哈希自检附录，正文未改写） |
| `audit/lint.txt` / `audit/compile.txt` | 本包 paper-lint（PASS, exit 0）与 paper-compile（exit 0）输出 |
| `audit/listing-verify.txt` | 短笺五处 lstlisting 与冻结产物逐字节核验记录（5/5 PASS） |
| `audit/inspect-tex.py` / `audit/build-c9-record.py` / `audit/sanitize-package.py` | 装配与自检脚本：listing 注入与逐字节核验、非 ASCII 出网检查、C9 记录四段构建与自检、包内日志脱敏与本地路径复扫、FILE-MANIFEST 生成 |
| `audit/claim-check.md` | 监察院精简主张审计六项核对裁决 + 第一轮 7 条必修（F1 脱敏 / F2 数字失真 / F3 指针悬空 / F4 枚举器措辞 / F5 缺本件 / F6 旧件 / F7 清单失真）逐条处置（占位质检门③） |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134，无 orcid 键；contributors 保留 AI 披露；related_identifiers.isIdenticalTo = GitHub 镜像仓） |
| `metadata/FILE-MANIFEST.txt` | 包内逐件 sha256 + 字节数清单（发布前复算即用此件） |
| `metadata/README.md` | 本文件 |

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0 便携版（本机），XeTeX 路径。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 01-cchord-proved.lean
# 期望：exit 0，仅 68 条 if_neg/if_pos deprecation 警告，无 error
```

公理复核（本仓纪律：sidecar 另起文件，用完即删，不进 final）：在本目录放一个只含下面四行的临时文件，`lake env lean` 它，然后删除：

```lean
import «01-cchord-proved»   -- 与本包 proofs/01-cchord-proved.lean 同名的模块
#print axioms cchordR2_mod_four
#print axioms cchordR0_mod_four
#print axioms cchordR1_even_iff
```

任务级全部过程档案（Phase 0 枚举/拟合脚本、roundtrip 留档、攻证轮次与诊断原文）留本仓 `tasks/20260927-mossad-cchord/`；C9 原始查询回包留 `tasks/20260927-mossad-select/`，均不入本包。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## 已知观感项与边界（如实记档，不影响质检门）

- **篇幅口径**：SOP 08b 职责节写「claim note，2–4 页」，本短笺编译为 **10 页**；**用户 2026-09-28 裁决＝追认超顶并转为显式豁免**，条款已落 `harness/departments/08b-claim.md`《已知边界》（唯一正确收缩方式＝把逐字 listing 移出正文、留包内 `proofs/`，禁止删证据或降口径），卡面追认节见 `claims/chorded-cycle-mod4/card.md`；超出部分全部是逐字 listing（三组冻结 statement 共 61 行 + C1 完整证明 25 行 + C3 装配段 11 行）与 C9 查新表，删它们会牺牲「冻结产物逐字快照」这条硬要求。与首批 `claims/cyl3-mod23`（同为 10 页）同口径，此处如实分列而不改文。
- `claim.pdf` 终轮 5 处 overfull hbox，实测 16.33 / 27.09 / 54.08 / 55.45 / **69.62 pt**，源于 listing 内长行（冻结件中文 docstring 不参与 listings 断行）；listing 源字节未动。（口径修正：先前版本写「7 处均 <20pt」，为生成方自报、审计实测证伪，已改为实测值并顺手做真修。）
- 唯一字形告警为 `TU/SimSun(0)/m/it`（中文注释被 listings 的 commentstyle 斜体化时缺 slanted 变体），纯观感。
- 短笺措辞上限：价值级只到 **new sequence / new recurrence**；组合语义桥只作 conjecture；负结果（统一 3 项递推不成立）只到计算层，不写成定理。
- 源任务目录的 `tasks/20260927-mossad-cchord/report.md`（源仓文件，不随包）文件头仍为「待闸门四人工签发」；本包由用户 2026-09-27 显式指令启动出包并当场行使签发权（占位通道启动权即用户指令），此口径已原文级写入短笺 Scope and limitations 第 (e) 条与源仓 deliverable 目录的 `card.md`（不随包）。
- OEIS 提交（路由表的社区层）属用户手动，且本仓提交侧通道未实测、账号实名与「署名用账号名」策略冲突未解 → 见 UPLOAD.md 第 3 步与 SOP 08b《已知边界》。
