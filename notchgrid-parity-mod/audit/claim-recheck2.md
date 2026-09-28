# 精简主张审计·门③**第 3 轮**：`claims/notchgrid-parity-mod/`

- 执行：监察院工人（dept-audit，只读，独立于占位线与在前两轮裁决）；主代理落盘并同步入包、随后重生成 `FILE-MANIFEST.txt` 与体量数字。
- 冻结核验：审计内 `sanitize-package.py --selftest` / `--check-only` 各两次之间，包树哈希/份数/字节三项复测同值 → 无漂移。
- 口径声明：本审计未采信任何工人自报；被审对象内容本体（tex/PDF/listing/锚点/c9/清单/三门）全部自行复算（宪条 1）。主代理事前实测摘要仅作线索列出，判定以本审计自算为准。

## 一、总裁决（门③ 第 3 轮）

**判据红 0 条；六项判据整轮复跑全部通过；机器三门复算全绿。但本轮报出 6 条发现（全部落在「记账 / 转写 / 指令文本」层，无一条触及证据层或措辞层，无一条需改 `claim.tex`）→ 按 SOP 08b 第 5 步字面「零发现方过」，本轮不是零发现；按出仓风险实质，本包已具备外发条件。**

- **能否出仓**：能。三门（清单一致性 / 承诺对账 / 无本机路径）复算均 exit 0；四项判据红（锚点回源、措辞双上限、listing 逐字节、预算照抄）无一失守；DOI 未回填是已披露的实况，不是缺陷。
- **是否触发停线**：按**实例级**读数（前两轮所用读数）**不触发**。但必须把话说透：`包内指称失实`这一**族**缺陷已连续三轮出现在三个不同落点（首轮 F4 → 第 2 轮 N1 → 本轮 F-a）；若用户采**类型级**读数，则本线应即刻停摆、先补对账工具的能力面，而不是逐包人工复审。该读数取舍归用户，本审计不代为关闭。
- **剩余预算**：LaTeX **9/9 用满，0 剩余**；llm-call **0/4**；Lean compile **0**。本轮 6 条发现**全部 0 编译轮**可修。

## 二、N1–N4 与 L1–L6 验收表

| ID | 要求 | 实测事实 | 判定 |
|---|---|---|---|
| **N1** | tex 改「in the source repository」、与 README 指称一致、不再与同文自相矛盾、对齐两先例 | `claim.tex:460` = `\texttt{UPLOAD.md} in the source repository)`；先例逐字同句式：`chorded-cycle-mod4/claim.tex:401`、`pendant-ladder-interleave/claim.tex:716`；`README:6/:89/:96`、`diff-conclusion.txt:64` 同一口径；同文 `:121-123`「仓内路径 deposit 时不可公开取回」与现句不再冲突；`find zenodo -type f` 对 `UPLOAD.md`/`budget.log`/`card.md` 命中 **0/0/0**（改后指称属实） | **通过（验收）** |
| **N2** | `compile.txt`（根+包）轮数 = 实测 9；Fontconfig 说明在位 | `:14` = "all nine rounds exit 0"、`:25` = "Consumed: 9 of 9"、轮表 9 行；`:15-22` Fontconfig 读数说明在位。逐件实测 9 份日志：各含 `error` 行**恰 1**、非-Fontconfig 命中 **0**、各有 "bytes written" → 说明句为真 | **通过** |
| **N3** | 口径改述落进 card/selfcheck **追加行**；裁决书本体一字未改；新写入文本不再出现账号名字面串 | 追加行在位：`card.md:167`、`selfcheck.md:237`；`cmp audit/claim-check.md zenodo/audit/claim-check.md` **全同**，且其正文仍自陈首轮实况「27 文件 / 341,133 字节」（未被回刷 → 本体未动的实证）。字面串实测：`zenodo/` 全包命中 **1**（`zenodo/audit/claim-check.md`），`claim-recheck.md` 内 **0** 字面 / **3** 处脱敏形 `Aurora***34`；PDF 文本抽取 0；`sanitize-package.py`/`FILE-MANIFEST.txt` 0。`card.md:167`/`selfcheck.md:237` 所写「随包合计 1 处」与实测**逐字吻合** | **通过** |
| **N4** | 三门执行 + 清单 1:1 + 盲区是否真补 | 见第五节 | **通过，但派生新落点 F-b** |
| **L1** | `compile.txt` 轮数旧值 | "seven" 全包 0 命中（含包内副本，cmp 全同） | **清零** |
| **L2** | `card.md` 门②行「七轮」 | `card.md:119` = 「共 9 轮 = 上限 9 轮恰满…**九轮原始日志全随包**（`compile-run{1..9}.log`）」；卡面「七轮」0 命中 | **清零** |
| **L3** | selfcheck 追加段 `7/9`、「7 行」 | 原句 `selfcheck.md:172` **原文保留**，`:233` 追加订正行给现行值（9 of 9 ↔ `budget.log` 9/9 行 ↔ 9 行轮表） | **合规（追加式）** |
| **L4** | selfcheck 403,315 / 183,951 | 原句 `:205` 原文保留，`:234` 追加订正行给 478,593 / 252,436 | **合规（追加式）** |
| **L5** | `run-state.md:452` | **本审未核**：派发纪律把 `run-state.md` 列为不碰项；该件不随包、不入判据，请主代理自行核销 | **移交（非包内）** |
| **L6** | `rework-evidence.txt` 残缺句 | `:10-11` 现为完整句 "Nothing below is quoted from the auditor's text without being recomputed first"；同段 `:3-5` 轮数已改 3（轮 7/8/9） | **清零** |
| — | 追加式纪律（回改即判红） | `budget.log` 历史行 13–43 全部原样（`latex 6/6`、`7/9`、`8/9`、403,685 订正行均在），新行 45–51 追加；`compile.txt:88-97` 保留被取代哈希对（轮 6/7/8）；`lint.txt:48-55` 保留 run 9 旧「shipped」表述并由 run 10 段就地宣告取代 → **无一处静默回改，证据失真不成立** | **通过** |

## 三、六项判据整轮复跑（全部自算）

| # | 判据 | 复算 | 结论 |
|---|---|---|---|
| 1 | 锚点回源 | 4 条 `% LEAN:`（`claim.tex:174/185/196/206`）名与 `grade=完全证明` 对 `tasks/20260927-mossad-notch/audit/final-01-notch.txt:7-10` 逐行吻合，`:12`「脚手架通过不适用」原文在位。`sha256sum` 直读：冻结件 `9a787b6b…426fb8`/69 行、终稿 `6f1a7440…9db4aa`/621 行；包内 `.lean` 与源件 `cmp` 全同、`lean-toolchain` 与 `verify-proj/` 全同（`leanprover/lean4:v4.34.0`，sha `8733782d…c27632`）。**对称差自算**：两文件各 6 顶层 decl，名序全同（a3 / a3_odd_iff / a3_mod8_periodic / a4 / a4_odd_iff / a4_mod4_eq2_iff），6 条头行逐字节相同，终稿无额外顶层声明 → 宪条 2 成立。公理：包内 `axioms.txt` 四行 = 源 `final-axioms.out` EXIT=0 前四行，仅 {propext, Classical.choice, Quot.sound}，`sorryAx` 全包 **0**；终稿 `sorry`/`admit` **0**；`review-final-{strict,axioms}.out` 与 `attempts/final-*.out` `cmp` 全同 | **通过** |
| 2 | 措辞双上限 | 上限 = 完全证明 ∧「查无占位 + 新序列/新递推」。tex 剥注释+listing 后打印文：`first` **0**、`First` 0、`first formalization` 0、`proves that the number of matchings` 0、`new mathematics` **1 且在否定句**（`:360` "not a claim to new mathematics"）、listing 外非 ASCII **0**；PDF 抽取同判（`??` 0 / `<<` 0）。围栏在位：A001353 + Zucker/Castilleja 挂名（`:406-412` + 书目 `:537-544`）、4n−1 恒 0 只作退化注记（`:413-415`）、a4 九阶 as found（`:150-152`、`:438-442`）、最小周期归 computed（`:233-235`、`:443-446`）。`\cite` 4 键 = `\bibitem` 4 键，无孤儿键 | **通过** |
| 3 | listing 逐字节 | 自写解析器反抽 **7 段**：24-31 / 151-163 / 34 / 166 / 122 / 281 / 123-144 → **7/7 BYTE-EXACT** 且与 caption 声明行号一致；6 段为冻结件字面子串（第 7 段是证明体，本就不应在冻结件）；listing 体内 `sorry|admit` **0**；摘录块 caption 标 "verbatim excerpt, lines 123--144" 且指向包内全文 ✓ | **通过** |
| 4 | 预算照抄 | 源账本：`llm 2/8`、`compile 17/24`（6+9+2 分解在案）、tokens `in=1628 out=4000` / `in=1628 out=1889` → 与 `claim.tex:485-488` 逐项吻合，节点 `anthropic/a6api-main/kimi-k3` ✓。本包侧 `llm 0/4`、`latex 9/9` 与 `budget.log:47,48,51`、`card.md:69`、`compile.txt:25`、`README:15`、`UPLOAD:38`、`zenodo.json notes` 六处一致 | **通过** |
| 5 | 披露四要素 / AI 非作者 / 无 PII / 无裸 `<<` / DOI 预留 | `:474-504` 四要素齐；作者栏占位、`zenodo.json creators` 占位、`contributors` 列 AI 为 Other ✓；全包（除 PDF）邮箱式串 0、Windows home 路径 0、本机用户名 0、ORCID 仅 `0000-0000-0000-0000`；`<<` 在 tex/README/json/PDF **0**；DOI 一律 "to be reserved at upload"（PDF 实测） | **通过** |
| 6 | `c9-record.md` 逐字节 | 7 区块按声明行段反查源：chunk-G `5-10 / 35-59 / 61-84 / 116-117 / 122` + 池卡 `26-33 / 35-42` → **7/7 在源件中逐字节命中且各仅 1 处**，行数 6/25/24/2/1/8/8 全对；结论字样未改写（`查无占位` 11、`新序列/新递推` 6、A001353 已占位＋挂名、OpenAlex 429 10 处）；短笺通道表逐格与记录同值 | **通过** |

附加复算（非判据）：由两条 def 作定义迭代至 n≤401 → 四张余数表与 `claim.tex:223-226` 逐位相同、T1–T4 全窗为真、最小周期 6/12/5/10；四条定理段内 tactic 指纹复算（T1 if=1/mod_cases=1/odd_iff=2、T3 **0/0/0**、T2 1/1/2、T4 3/2/0）→ F1 改后散文为真；F2 改后散文对 `phase0/compute.py:84-85`（`range(1,9)`/`range(1,7)`）与 `counts.txt`（24 数据行）为真；strict 日志 0 error、`if_neg` 236 + `if_pos` 84 = **320** ✓；`\lean{}` 13 处 / 8 distinct / 0 未解析 ✓。

## 四、体量 / 份数 / 轮次互洽实测表

| 项 | 实测 | 载体 | 判定 |
|---|---|---|---|
| 文件数 | **35** | `card.md:129`、`UPLOAD.md:54/:93`、`README:58`、`sanitize-package.txt:36/:92/:94`、`budget.log:51` | **一致** |
| 字节和 | **478,593** | 同上 | **一致**（478593/1024 = 467.4 ≈ "≈467 KB" ✓） |
| 分目录 | audit **26 / 252,436**、claim **3 / 166,934**、proofs **3 / 43,400**、metadata **3 / 15,823** | `card.md:129`、`card.md:165`、`README:59-60` | **逐字吻合** |
| `FILE-MANIFEST.txt` | 34 行、自身 3,803 B、行内字节和 474,790（+自身 = 478,593 ✓）；行集与盘上 1:1，缺 0 / 幻影 0 / 过期哈希 0 | README:58-60 | **一致** |
| 审计件份数措辞 | 包内裁决书 **2 份**（首轮 + 第 2 轮），`cmp` 与根件全同；`README:42-44`、`UPLOAD:94-95`、`zenodo.json notes`、`compile-log.txt` 末段均写「两份/逐字副本」 | — | **1:1**（本件入包后须同步为三份） |
| 编译轮数 | 原始日志 **9 份**（run1..9 全随包）；run9 = 128,188 B、12 页；shipped `claim.pdf` = **128,188 B**、`page_count` = **12** | `card.md:119`、`compile.txt:25/46`、`README:15`、`UPLOAD:23`、tex 披露句 | **一致** |
| shipped 哈希 | `claim.tex` `1287ae80…c7d7dc`、`claim.pdf` `babece73…dcf7a8`；根↔包 `cmp` 全同；与 `compile.txt:81-83`、`lint.txt` run 10 一致 | — | **一致** |
| 根 ↔ 包同步 | `audit/` 同名 22 件全 SAME；仅 `sanitize-package.txt`、`selfcheck.md` 未随包（README:47 + 卡面 E6 已披露理由） | — | **无失步件** |
| zip | 树内 `*.zip` 0，`card.md:129`「单 zip 未打」属实 | — | **一致** |

## 五、sanitize 三门复算（含「裸文件名盲区」是否已补）

自行只读复跑（`--selftest`、`--check-only`，不写文件）：两次跑均 **exit 0**，两次跑之间包树未变。

1. **清单一致性**：独立重算 34 行 ↔ 34 件（自件除外）1:1、sha256+字节 0 过期、README 声明的 `35 / 478,593` = 实测 → **真**。
2. **无本机路径**：独立扫 35 件（PDF 除外）→ home 路径字面 0、盘符 `Users` 0、本机用户名 0、邮箱 0 → **真**。
3. **承诺对账（第 2 轮裁的盲区）**：规则 (b) 已实装并被 `--selftest` 反证——**改前那句 N1 原文必须 FAIL 且确实 FAIL**（命中 `UPLOAD.md`，locator `in this package`，解析落 repository）、改后句 PASS、`本包 + budget.log` 中文句 FAIL、`源仓 deliverable 目录 + 全路径` PASS → **5/5 OK，盲区在这两种句式上确已补住**。

但补得不完全，两处残留（→ F-a、F-b）：
- **覆盖面自述失真**：门 2 打印「scanned surfaces (15)」+「not scanned … (10)」= 25，而实档 35。差的 10 件 = `audit/compile-run1..9.log` + `audit/sanitize-package.py`，**既未扫也不在打印的「不扫」清单里**。按规则 (b) 手工对未扫件复算：`compile-run2..8.log`（7 件、每件 2 处排版回显）含第 9 轮已判失实的 `UPLOAD.md in this package`——即若纳入扫描，门 2 会报 14 次 FAIL。这些日志按纪律**不得回改**（改归档日志 = 伪造实物），所以问题不在日志，而在**门的覆盖面清单不完整**。
- **另一类指称句式不在规则射程**：包内证据件用裸 `audit/<file>` 指向**未随包**的文件（见 F-a），`resolves()` 认「工作仓里能找到」即放行，规则 (b) 又要求邻近包内容纳措辞，故全漏。

## 六、新发现清单（6 条）

| ID | 严重级 | 定位 | 原文（截） | 问题（复算依据） | 工序 | 改法 | 需改 tex？ | 需第 10 轮？ | 停线 |
|---|---|---|---|---|---|---|---|---|---|
| **F-a** | **中·出包前应修**（N1 同族的**其他落点**） | `zenodo/audit/rework-evidence.txt:117`；`zenodo/audit/diff-conclusion.txt:20`；次级：`rework-evidence.txt:59`、`compile-log.txt:8` | "(see the command output recorded in **audit/selfcheck.md**, rework section)" / "This is quoted from **audit/final-01-notch.txt** item 1." | 公共读者在存缴树内找不到被指称件：`find zenodo` 对 `selfcheck.md`、`final-01-notch.txt` 命中 **0**（二者按 E6/用户裁 2 故意不随包，README:49-52 亦如此声明）。`selfcheck.md` 那句还是命令式「see … recorded in」，指读一个包内不存在的路径。工具全漏（原因见第五节） | 工序 4（转写件） | 给未随包指称一律加全路径 + 「in the source repository」；并建议把该句式并入工具规则（否则下一个包还会犯） | **否** | **否** | 实例级：否；**类型级：这是该族第三次出现，读数归用户** |
| **F-b** | **中·门的自我描述失实**（N4 同族新落点，非 N4 重现） | `audit/sanitize-package.py`（根+包 cmp 同）`gate_promises()` 面集；`zenodo/metadata/README.md:45-48`、`UPLOAD.md:49-52` 引用其「三项全绿」处 | 打印 "scanned surfaces (15)" + 10 条 skip | 15+10=25 ≠ 35：9 份 `compile-run*.log` 与工具自身既未扫也未列入「不扫」清单；其中 7 份含被裁失实的 `in this package` 回显（实测各 2 处）。读者据该清单会误以为全部随包文本已受检 | 工序 4（工具 + 记账件） | (i) 把 10 件写进打印的 skip 清单并注明理由（归档排版回显 / 工具源，含「按纪律不回改」）；(ii) 在 `audit/compile.txt` 读数说明段与 README `audit/` 清单项各加一行：「run1–8 的原始日志逐字回显第 9 轮之前的 Data availability 句，其失实即本轮 N1，日志保留原样不改」 | **否** | **否** | 否 |
| **F-c** | 低 | `zenodo/audit/rework-evidence.txt:165-166`；`:181` | "(31 files then, before **the two additions** of this session)" / "claim.tex:**489**" | 31 + 2 ≠ 35：本次实际 +4 件（复审书副本、`compile-run9.log`、`sanitize-package.py`、`FILE-MANIFEST.txt`）；披露句实际在 `claim.tex:490-491`（`card.md:155` 写的 490-496 才对）→ 转写件内两处可核数字/指针不洽 | 工序 4（转写件） | "two additions" → "the four additions of this session (31 → 35)"；`claim.tex:489` → `claim.tex:490-491` | **否** | **否** | 否 |
| **F-d** | 低 | `zenodo/audit/compile-log.txt:2` | "Every line is **quoted** from a source-task gate file named in brackets" | 源件为中文，包内为**英文转写**（例：`welldef-verdict.md:5`「良定义：【通过】（kernel 硬裁决）」→ "verdict: WELL-DEFINED PASS (kernel hard adjudication)"）。逐字回源在中文条目上不可能 | 工序 4 | 改为 "quoted **or translated** from …（Chinese sources are rendered; the verbatim strings are kept in their original characters: `完全证明`, `WELLDEF OK`）" | **否** | **否** | 否 |
| **F-e** | 低 | `UPLOAD.md:42-44` | "把披露句数字与 budget.log、card.md《预算顶》、README、zenodo.json notes 一并改成实况，**五处**数字必须互洽" | 轮次数字的 live 载体 ≥9 处：另有 `UPLOAD.md:23/:38` 自身、`zenodo/audit/compile.txt:25`+轮表、`zenodo/audit/rework-evidence.txt:3-5`、`zenodo/audit/lint.txt`（跑号）、`FILE-MANIFEST.txt`+三处包体量。照 5 处执行必留旧值 → 正是本通道头号失效模式 | 工序 4（指令件） | 改写为穷举清单，并写明「改任一随包件 → 必重跑 `--check-only` 并重新生成 `FILE-MANIFEST.txt` + 重算三处体量」 | **否** | **否** | 否 |
| **F-f** | 低 | `UPLOAD.md:51` | "三项…**必须全绿（exit 0）；任一项**不红**即停，不得强行出包" | 语义与同句前半互斥（应为「不绿即停」）；这是给用户的外发指令，写反等于把硬门松成软门 | 工序 4（指令件，不随包） | 「任一项不为绿即停」 | **否** | **否** | 否 |

**非发现、须如实记录以免下轮误判为掩盖**：`card.md:142`《门③返工记录》F5 行仍引披露句的轮 8 版本（"$8$ … budget of $9$"）——同卡 `:155`（N1 行）已记「8 → 9」、`:69/:119` 已记 9/9，属历史记录而非失真，**不判红**；若愿加「（已被轮 9 取代）」括注，同样 0 编译轮。

## 七、机械轨输出（本审计本人跑）

- `bash scripts/paper-lint.sh claims/notchgrid-parity-mod/claim.tex`（仓库根）→ `PASS: paper-lint 全绿`，**exit 0**；审计结束前复跑第二次仍 exit 0（树未动）。
- 门②**只读**复核（未跑 tectonic）：`compile-run9.log` → Missing character 0、distinct Overfull 0、Underfull 4、"128188 bytes written"、`[1]…[12]`；`claim.pdf` 实测 **128,188 B**、`page_count` **12**、`??` 0、`<<` 0、`first` 0、`new mathematics` 1（否定句）、`sorry` 4 / `admit` 1 逐处读上下文全在否定式披露句、账号名字面串 0。9 份日志逐件：`error` 行各 1 且全部 = Fontconfig 行、非-Fontconfig 0。
- `sanitize-package.py --selftest` / `--check-only` 各两次，全 **exit 0**（不写文件）。
- 网络：**本轮 0 次外呼**（书目在线复验属源任务与论文包留档，按引用一致性判据核，不重复发包）。

## 八、DOI 回填能否与 tex 修合并为同一轮

**能，且必须合并。** 要点：
1. 本轮 6 条发现**无一条需改 `claim.tex`** → 本包在 9/9 状态下**不需要第 10 轮就能签发外发**。
2. 若用户为 DOI 授权第 10 轮，则该轮可同载任何后续 tex 修，但有四个硬前置：①授权须把**顶从 9 提到 10**（宪条 5，卡面 + `budget.log` 双写授权行，不得由工人放大）；②tex 内两处数字必须在同一次编辑里写成终值——披露句 "$10$ LaTeX compile rounds of its budget of $10$"，且第 9 轮那句「the DOI backfill, which needs one further round, is to be requested separately」要同步改掉，否则回填完成后打印文即成旧值；③按 F-e 的 ≥9 处载体全量互洽；④改后重跑 `paper-lint`（第 11 跑）+ `sanitize --check-only` + 重新生成 `FILE-MANIFEST.txt` + 重算三处包体量。
3. 建议顺序：**先** 0 编译轮把 F-a~F-f 与「本意见书入包」一并做完并重算清单（本件随包必然使树变 36 件，同一次同步里顺带修 F-a/F-b/F-c/F-d，零额外风险），**再**由用户决定是否授权第 10 轮做 DOI 回填。

## 九、报告签发必须披露的限定语（不得删）

L1 语义桥（=缺角网格全匹配数）未形式化，散文本包述为 conjecture／L2 初值出处与 8/6 项互证窗口（24 行表其余行仅由 DP 产出）／L3 A001353 围栏 + Zucker·Castilleja 挂名／L4 4n−1 恒 0 只作退化注记／L5 措辞上限 = 完全证明 ∧「查无占位 + 新序列/新递推」且明文否认新数学／L6 全部 Lean 代码 AI 生成、钉版 v4.34.0 + mathlib rev 5ed29652／L7 数值窗口 n≤60 重代、模 DP n≤600、0..80 全窗、周期最小性非 theorem／L8 320 条 deprecation 不作否决／L9 roundtrip 同节点自裁、由 kernel 终裁与复跑对冲；起草端点选择键 `auto` 已披露／L10 骨架沿用同池先例经裁定不构成降级。**另须追加本轮两条**：①LaTeX 编译轮 **9/9 恰满、剩余 0**，DOI 未回填（外发后该句将滞后，属已披露取舍，非占位残留）；②随包公开**两份**监察院裁决书逐字副本（首轮「不通过」、第 2 轮「验收通过 + 新发现」），处置结论见第 3 份（本件）；`sanitize-package.txt`、`selfcheck.md`、`card.md`、`UPLOAD.md` 按设计不随包。

## 十、审计耗材记账

llm-call **0**；Lean kernel 编译 **0**；LaTeX 编译 **0**（未跑 tectonic，未改任何文件）；**未写任何文件**（本意见交主代理落 `audit/claim-recheck2.md` 并同步 `zenodo/audit/claim-recheck2.md`，随后重生成 `zenodo/metadata/FILE-MANIFEST.txt` 与三处体量数字）。未碰 `tasks/`、`run-state.md`、`harness/`、`verify-proj/` 构建三件套、`harness/config.json`（`tasks/` 与 `harness/selection-map/` 仅只读回源，SOP 判据 1/4/6 必需）；**论文包 `papers/notchgrid-parity-mod/` 第 4 轮状态一律未据以立发现**。只读命令：`ls/find/stat/wc/head/tail/sed -n/grep`、`sha256sum`、`cmp`、`file`、`python -`（stdin 内联，无临时文件：listing 反抽 7/7、对称差 6/6、c9 七区块、余数表与最小周期、tactic 指纹、打印文禁词、PDF 抽取、PII/本机路径扫描、三门覆盖面差集、规则 (b) 对未扫件的复算）、`python claims/notchgrid-parity-mod/audit/sanitize-package.py --selftest/--check-only`、`bash scripts/paper-lint.sh`。身份与置信依据：监察院 dept-audit（qoder 端点投影），全部判定可复现。
