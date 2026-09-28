# 精简主张审计·门③**第 4 轮**：`claims/notchgrid-parity-mod/`

- 执行：监察院工人（dept-audit，只读，独立于占位线与前三轮裁决）；裁决书正文交主代理落盘。
- 审计窗口：2026-09-28 12:49:46 起、13:02:47 止；窗口起点与收尾各跑一次 `find claims/notchgrid-parity-mod -type f -newermt <起点>`，两端均 **0 文件**——被审包全程未动。
- 口径声明：不采信任何工人/主代理自报；覆盖面算术、体量、listing、措辞、数字、公理、行尾、指称、自指数**全部本审计自算**（宪条 1）。共享门与 `FILE-MANIFEST.txt` 系主代理所写，故本审计另做独立实现：自抽 7 段 listing、自行全树字节/件数普查、自写行尾与控制字符普查、自写不随包指称扫描器（±180 字符上下文 + 逐文件豁免判定）、自算清单行内字节和。

## 一、总裁决（门③ 第 4 轮）

**六项判据整轮复跑全部通过、无一复发；但本轮报出 5 条新发现（G1–G5），其中 G1、G2、G5 三条触及随包文本或包外活账件的「如实自述」，按 SOP 08b 第 5 步字面「零发现方过」本轮不是零发现 → 裁决：打回（工序 4 级返工，全部 0 编译轮可修），修复并双门复跑绿后方可外发。**

- **能否出仓**：现状字节**不能**（非证据层缺陷，是记账层失实）：随包的 `metadata/README.md`、`metadata/zenodo.json`、`audit/compile.txt`、`audit/compile-log.txt` 四处仍在断言「编译顶 9、无剩余轮次、DOI 回填须用户另行授权」，而 `budget.log` 的 `budget-auth-3` 行已记用户把顶提到 **10**（专供回填、未动用）——公开文本对预算现状作了与账本相反的陈述，方向虽保守，仍属失实。G2/G5 同理（见下）。
- **是否触发停线**：实例级**不触发**——G1/G2 是新一轮（第 3 轮之后发生的授权变更与清单再生成）引起的**滞后**，非前三轮任何一条的复发；G5 是共享门规则 (c) 词表射程之外的新落点（来源标注句，非祈使句），与 F-a 同族但不同实例。**类型级读数依旧归用户**：「包体自我描述失实」一族已连续第 4 轮出现（F4 → N1 → F-a → 本轮 G1/G2/G5）；但本轮性质已变——共享门已建成且抓到 7 处、selftest 5/5 咬合属实，残留是**规则射程**问题而非**无人对账**问题，§八 给出可直接落地的射程扩展规格。本审计不代为关闭该读数。
- **剩余预算**：LaTeX **9/10 已用、剩 1 轮（第 10 轮 = 用户预留专供 DOI 回填，本轮明令禁止动用，实测亦未动用：无 `compile-run10.log`、账本无新编译行）**；llm-call **0/4**；Lean compile **0**。本轮 5 条发现**全部 0 编译轮**可修，无一条需改 `claim.tex`。

## 二、F-a～F-f 与共享门收官项验收表

| ID | 要求（第 3 轮裁决书 + 派发指令） | 本审计实测 | 判定 |
|---|---|---|---|
| **F-a** | 四处裸 `audit/<file>` 指称未随包件补全路径+不随包明示 | `rework-evidence.txt:58/:83/:104`（兄弟论文包 paper.tex 三处，均带 "source repository, not shipped"）、`:291`（selfcheck.md 路径+明示）、`diff-conclusion.txt:20`（闸门三原件 "source task directory, not shipped with this deposit"）、`compile-log.txt` GATE 段（全路径 tasks/… + 首段 source-records 声明）逐条 grep 命中在位；`find zenodo` 对 `selfcheck.md`/`UPLOAD.md`/`budget.log`/`card.md` 命中 **0/0/0/0**，明示与实况相符 | **通过（验收）** |
| **F-b** | 覆盖面自述 1:1 + 算术入门 | 包内门 `--check-only` 实跑：打印 21 件逐件理由 + `coverage accounting: 15 scanned + 21 declared not scanned = 36 ; the deposit tree holds 36 files`，exit 0；本审计自行按共享门清单文件数行：扫描 **17** + 声明不扫描 **19** = **36** = 树实测 36，两门口径各自闭合（15+21 归包内门、17+19 归共享门，`card.md:131`/`UPLOAD.md:130` 把 15+21 记在包内门口径**正确**，README 未写死受扫数） | **通过** |
| **F-c** | `rework-evidence.txt` 「four additions (31→35, +1=36)」与 `claim.tex:490-491` 指针 | `:173-176` 现为 four additions、31→35、36 after；`:192` 指针 `claim.tex:490-491`；披露句实测确在 490-491（本审计逐行读 shipped tex） | **通过** |
| **F-d** | `compile-log.txt` 「quoted **OR TRANSLATED**」+ 点名逐字原字形串 | 首段在位，且明文点名 `完全证明` / `WELLDEF OK` 两串逐字保留 | **通过** |
| **F-e** | UPLOAD「五处」→ 穷举活载体清单 + 收敛硬规则 | `UPLOAD.md:42-60` 穷举 **14 处**活载体；`:62-69` 「改任一随包件 → 重跑三门 → 重生成清单 → 回写三处体量」硬规则在位；本审计按该清单逐处复算，发现第 1/5/7/8/9/12/13 号载体存在**新**的顶=9 滞后（→G1），说明清单本身合格、执行有缺项 | **通过（清单），执行缺口另立 G1** |
| **F-f** | 「任一项不红即停」→「不为绿即停」 | `UPLOAD.md:83-85` 现文为「任一项不为绿即停」且括注订正理由 | **通过** |
| 共享门 | `scripts/sanitize-package.py` 存在、5 道门、selftest 反证 | 源码通读；`--selftest` 实跑 **5/5 OK**（good/bad1/bad2/bad3/bad4），其中 bad2「指称不随包件未明示」正是 F-a 族的反例——规则真会咬属实；对包实跑 `--scanned logs/notchgrid-claim-scanned.txt --skipped logs/notchgrid-claim-skipped.txt`：gate4 覆盖 17+19=36 OK、gate2 承诺 0 违例、gate3 本机路径 0、gate5 结构绿、gate1 清单一致，**exit 0** | **通过（主代理自报数全部复算属实）** |
| 收官执行体偏离 | dept-paper 三度撞 150 轮上限、主代理承做登记 | `budget.log:60-63`（`main-agent-closeout`、`gate-hardening-closeout` 两行 + `budget-auth-3`）与 `card.md:200-205` 在位，如实记执行体 | **合规** |
| 根↔包同步 | 同名件 cmp 全同 | 本审计逐件 `cmp`：三份裁决书 + `sanitize-package.py` + tex/pdf/lstlean + 10 件 `.txt` 转写件全 **SAME**；root-only 仅 `sanitize-package.txt`、`selfcheck.md`（README:58-61 已声明不随包及理由）；`zenodo/claim/claim.tex` sha256 复算 = `1287ae80…c7d7dc`、pdf = `babece73…dcf7a8` = 卡面/清单/compile.txt 三处所记 | **通过** |

## 三、六项判据整轮复跑（全部自算）

| # | 判据 | 复算方法与结果 | 结论 |
|---|---|---|---|
| 1 | 锚点回源 | 4 条 `% LEAN:` 实测在 `claim.tex:174/185/196/206`，名与 `grade=完全证明` 对 `tasks/20260927-mossad-notch/audit/final-01-notch.txt:7-10` 逐行吻合（`:12`「脚手架通过不适用」原文在位）。冻结件 sha256 `9a787b6b…426fb8`/69 行、终稿 `6f1a7440…9db4aa`/621 行，本审计 `sha256sum`/`wc -l` 直读复算一致；包内两件与源件 `cmp` 全同、`lean-toolchain` 与 `verify-proj/` 全同（`leanprover/lean4:v4.34.0`，sha `8733782d…c27632`）。对称差自算：两文件顶层声明各 6 条、名与类型逐字节同（a3/a3_odd_iff/a3_mod8_periodic/a4/a4_odd_iff/a4_mod4_eq2_iff），终稿无额外顶层声明 → 宪条 2 成立。公理：包内 `axioms.txt` 四行 = 源 `final-axioms.out` EXIT=0 前四行（顺序原样，含 EXIT=0 与转写说明头尾），仅 {propext, Classical.choice, Quot.sound}；终稿 `sorry|admit` **0**；`sorryAx` 在全部公理清单 **0**（仅扫描口径自述文本提及）；冻结件内 5 处 `sorry` = 4 占位 + 1 中文注释（line 18），属冻结件实况非包侧缺陷 | **通过** |
| 2 | 措辞双上限 | 上限 = 完全证明 ∧「查无占位 + 新序列/新递推」。PDF 全文本抽取（pymupdf 直读 12 页）：`first`/`First` **0**、`first formalization` 0、`proves that the number of matchings` 0、`new mathematics` **1 且在否定句**（"not a claim to new mathematics"）、`??` 0、`<<` 0、DOI 预留句 1 处在位、`sorry/admit` 5 处逐处读上下文全为否定式披露。围栏在位：A001353 五处 + Zucker/Castilleja 各 2 处（tex:407-412 + 书目）、4n−1 恒 0 只作退化注记（tex:413-415）、a4 九阶 as-found（tex:150-152 listing caption）、周期最小性明文「非 theorem 内容」（tex:233-235）。「组合语义桥未形式化」措辞核对：`zenodo.json` description 明写 **NOT formalized … reported at the computational-evidence layer**，与分级不越级 | **通过** |
| 3 | listing 逐字节 | 本审计自写行级解析器反抽 **7 段**，逐段与 `zenodo/proofs/01-notch-proved.lean` 对应行段做**字节比较：7/7 全同**，且起始行 = caption 声明行（24-31 / 151-163 / 34 / 166 / 122 / 281 / 123-144，四条目 caption 为单行式 "line 34" 等，逐条核对一致）；6 段同时在冻结件中逐字节命中（t3proof 本不应命中）；listing 体内 `sorry|admit` **0** | **通过** |
| 4 | 预算照抄 | 源账本 `llm 2/8`、`compile 17/24`（6+9+2）、tokens 1628/4000 与 1628/1889 → `claim.tex:484-491` 逐项吻合，节点 `anthropic/a6api-main/kimi-k3` ✓；本轨 llm 0/4、latex 9 of 9（tex 打印句为编译时实况）✓。**但活载体对「顶」的现状陈述滞后 → G1** | **通过（照抄属实），现状陈述另立 G1** |
| 5 | `\lean{}` 真实性 | 本审计自算 occurrences **13 / distinct 8**（Int.odd_iff×2、simp only [a3]×2、mod_cases×2、decide×3、Odd/have/interval_cases/simp only [a4] 各 1）；8 个标识符逐一在终稿（kernel 编译通过的实物）中出现（Odd 3、Int.odd_iff 5、decide 36、have 101、interval_cases 4、mod_cases 5、simp only 5），未解析 **0**——存在性由 kernel 已编译文件反证，非凭文本 | **通过** |
| 6 | 披露要素 + 包完整性 | `claim.tex:474-504` 四要素齐；作者/ORCID 占位（`zenodo.json` 字节级复核：`<作者全名，上传前填实>`/`<0000-0000-0000-0000，无则删此键>`，**无 PII、无乱码、文件为合法 UTF-8**）；contributors 列 AI 为 Other；全包 home 路径 0、盘符 0、用户名 0、邮箱 0（本审计独立扫 + 门 3 双路）；树内 `*.zip` 0 = 「单 zip 未打」属实；c9-record 145 行、7 区块对源行段（chunk-G 5-10/35-59/61-84/116-117/122 + 池卡 26-33/35-42）反查：7/7 逐字节命中且各仅 1 处、结论字样未改写 | **通过** |

附加复算（非判据）：本审计由两条 def 纯 stdlib 重迭代至 n≤401——T1（a3 奇 ⟺ n%6∈{2,3}）、T2（a4 奇 ⟺ n%5∈{0,2}）、T3（a3(n+12)≡a3(n) mod 8）、T4（a4≡2 mod 4 ⟺ n%10=6）全窗**无一反例**；四张余数表 `(0,0,1,1,0,0)` / `(2,2,3,7,2,6,0,0,7,7,0,0)` / `(1,0,1,0,0)` / `(3,0,3,0,0,1,2,3,0,0)` 与 tex:222-226 逐位相同；最小周期计算值 **6/5/12/10**；a3/a4 头部与 listing 初值逐位一致；F2 更正所引 `phase0/compute.py:84-85`（`range(1,9)`/`range(1,7)`）与 `counts.txt` 行数复算属实（仅回源核对，不据 `tasks/` 状态立发现）。网络外呼 **0**。

## 四、新增三面实测

1. **行尾与控制字符**：本审计对全包 65 件文本（含根件，排除两份 PDF）做字节级普查——**裸 CR 0、TAB 0、其余控制字符 0、所有文本件均以换行收尾**；CRLF 存在但成对：9 份归档 `compile-run{1..9}.log` 各 1 处（Fontconfig 诊断行内 `\r\n`，tectonic 原始输出，按纪律不回改、且被两面门声明排除在承诺扫描外，处置正当）；`audit/listing-ranges.txt`（根与包 cmp 全同、465 字节）整文件 **12/12 行全 CRLF**——该件是生成件非逐字证据，可规范化（→G4）。包内**无任何**「全 LF/行尾一致」类自述，门 5 只拦裸 CR 不拦成对 CRLF 属规格选择，无失实陈述。
2. **包体统计自指**：随包自指数 = `FILE-MANIFEST.txt` 头注（36 件 / 521741 字节含自身 / 35 行——本审计复算：树 36 件、521,741 字节、行 35、行内字节和 **517,841**，517,841+3,900=521,741 **闭合属实**）+ README《包体量》（36/521,741、分目录件数——属实）。**这类自指与盘上相符，暂不必拆到包外**；但 `card.md` 两处把**目录级字节拆分写成过时值**（292,033 / 18,753 / 517,220 / 521,120「与树实测闭合」——现值 292,608 / 18,799 / 517,841 / 521,741）→ G2。UPLOAD/README/budget.log 三处 521,741 现值一致；budget.log 内 521,120/478,593 等为 append-only 历史行且 `:63` 已声明取代关系，合规。
3. **指称不随包件必须带明示**：自写扫描器对随包文本扫 `tasks/|papers/|logs/|harness/|verify-proj/` 及裸件名（UPLOAD.md/card.md/budget.log/selfcheck.md/report.md/freeze.md/compute.py/counts.txt…）+ ±180 字符明示语境。祈使句式（see / recorded in / quoted from / 详见 / 记录在）残余违例 **0**（F-a 四处与收官 7 处补全逐条复核在位，见§二）；两份逐字裁决副本与 `c9-record.md`、`proofs/` 按纪律豁免且 README 已声明理由。但**来源标注句式**（"Source (verbatim): tasks/…" / "target: tasks/…" / "Lean file tasks/…" / "executor … via logs/…py" / "written by logs/…py inject"）在 6 件随包转写件（`axioms.txt`、`c9-verify.txt`、`lean-idents.txt`、`listing-verify.txt`、`statement-vs-frozen.txt`、`listing-ranges.txt`）中共 **8 处未带任何明示**（→G5）；缓解因素：短笺本体 `claim.tex:121-122` 与 Data availability `:466-472` 有全局声明「本短笺所引仓内路径 deposit 时不可公开取回、公开镜像恰为本包内容」，故读者不会被误导成包内可得——判**低-中级、非红**，但按本轮判据（指称必须带明示）应补。

## 五、体量 / 份数 / 轮次 / 清单互洽表（本审计实测值列）

| 项 | 实测 | 载体声称 | 判定 |
|---|---|---|---|
| 件数 | **36**（四子目录 27+3+3+3） | card/UPLOAD/README/清单头注/三门输出 | **一致** |
| 字节和 | **521,741**（audit 292,608 + claim 166,934 + proofs 43,400 + metadata 18,799；清单外和 517,841 + 自身 3,900） | 总额五处一致；**card.md:131/:188 目录拆分与「闭合」句为旧值** | **总额一致；拆分滞后 → G2** |
| `FILE-MANIFEST.txt` | 35 行、自身 3,900 B、行集与盘 1:1、逐件字节与实测全同（门 1 PASS + 本审计 awk 独立和） | 头注 36/521741 | **一致，0 缺 0 幻影 0 过期** |
| 裁决书份数 | 包内 **3 份**逐字副本（claim-check / recheck / recheck2），三件根↔包 cmp 全同 | README:56「三份」、UPLOAD:133、zenodo.json notes "all three"、compile-log "three gate-3 verdicts" | **1:1**（本件若入包须全包改「四份」，见§十一） |
| 编译轮 | 原始日志 **9 份**、无第 10 份；账本 compile 行 9/9 | tex「9 of 9」（编译时实况，冻结）✓；但 README:15「上限用满 9/9」、zenodo.json notes、compile.txt「no round remains」、compile-log「the last one available」、UPLOAD 三处均仍按**顶=9**说话 | **轮次一致；顶现状滞后 → G1** |
| shipped 对 | tex `1287ae80…` / pdf `babece73…`、128,188 B、12 页（pymupdf `page_count` 复算） | 卡面/清单/compile.txt/lint.txt run 10-11 | **一致** |
| 预算其余两栏 | llm-call **0/4**（账本无任何消耗行）；Lean compile **0** | 各处 | **一致** |
| 变化史 | 341,133 → 403,685 → 478,593 → 521,120 → 521,701(过程值) → 521,741 | budget.log:63 与 UPLOAD:93-94 留痕 | **append-only 合规** |

## 六、新发现清单（5 条，全部 0 编译轮）

| ID | 严重级 | 定位 | 问题（复算依据） | 改法 | 需改 tex？ | 需第 10 轮？ |
|---|---|---|---|---|---|---|
| **G1** | **中·出包前必须修** | 随包：`metadata/README.md:8-9/:15/:18-19`、`metadata/zenodo.json` notes、`audit/compile.txt` budget-cap 段、`audit/compile-log.txt` 末段；包外：`UPLOAD.md:23/:38-41/:71-73`、`card.md:71-77` 旧段与《遗留》2、`audit/lint.txt` run 11 括注（追加式订正） | `budget-auth-3` 已记用户把顶 9→10（专供回填、未动用），但上述载体仍断言「顶 9、无剩余轮、回填须用户再授权/尚未授权」——对预算**现状**作相反陈述；公开 README/json 尤甚 | 活载体改写为「顶 10（用户 2026-09-28 授权行 budget-auth-3），已用 9，预留第 10 轮专供 DOI 回填、未动用」；card 旧段按公开订正法加「已被本行下方授权行取代」括注，不回改 budget.log 历史行；`claim.tex` 两处旧句**不动**（card:70 已规划于第 10 轮同批改） | **否** | **否** |
| **G2** | 中 | `card.md:131`、`card.md:188` | 目录拆分 292,033/18,753 与行内和 517,220、521,120「与树实测闭合」均为第 3 轮时值；实测 292,608/18,799/517,841/521,741——同一行内 521,741 与「…=521,120 闭合」自相矛盾，即该卡自己的加法不再成立 | 两行按现值重写拆分（或删拆分只留总额+指向清单），并保留公开订正声明 | 否 | 否 |
| **G3** | 低 | `card.md:70` | 9→10 授权行引用「`budget.log` 的 `budget-auth-2` 行」，实为 `budget-auth-3`（:60）；`budget-auth-2`（:46）是「顶维持 9 + 第 9 轮分配」行且明写「本行不新增任何预算额度」——宪条 5 双写指针错引 | 指针改 `budget-auth-3` | 否 | 否 |
| **G4** | 低 | `audit/listing-ranges.txt`（根+包 cmp 全同，12/12 行 CRLF） | 生成件非逐字证据却是全 CRLF，与「文本件 LF」的包内惯例（budget.log:58 自述的口径针对其自身新行，未失实）不齐；9 份归档日志的 1 处成对 CRLF 属原始输出不回改，**不算缺陷** | 规范化为 LF（字节 −12）→ 触发清单重生成 + 三处体量回写链；或如实不改、在 README 行尾注一句——二选一，归主代理与用户裁 | 否 | 否 |
| **G5** | 低·中 | `axioms.txt:2/:4/:25`、`c9-verify.txt:6`、`lean-idents.txt:3/:22`、`statement-vs-frozen.txt:2/:11/:20`、`listing-verify.txt:3/:6/:16`、`listing-ranges.txt:2` | 「Source (verbatim) / target / executor via logs/… / written by logs/…」共 **8 处**指称不随包件未带明示；共享门规则 (c) 词表只覆盖祈使动词故 0 违例属**射程内正确、射程外漏**；短笺全局免责句（tex:121-122/466-472）构成缓解 | 逐处加 "(source task directory, not shipped)" / "(repository-internal helper script, not shipped)"，F-a 同款配方，0 编译轮；规则扩展见 §八-1 | 否 | 否 |

需改 `claim.tex` 的缺陷：**0 条**，故无需动用第 10 轮，也不得借本轮名义静默放大额度。

## 七、循环成本判断（给用户可照此执行的选项）

- **A（推荐）**：先做 0 编译轮清账批——G1 十处活载体 + G2 两行 + G3 指针 + G5 八处（可含 G4 的 LF 规范化，随批）→ 重跑包内门与共享门 + `paper-lint` → 重生成 `FILE-MANIFEST.txt` → 回写三处体量。**消耗：LaTeX 0 轮、llm 0 次**。完成即具备外发条件。
- **B**：DOI 回填 = 动用已预留的第 10 轮（消耗 **1** LaTeX 轮，此后 10/10 恰满、无剩余）：同批改 `claim.tex:490-491` 两处数字与「需另轮申请」半句 + 顶现状措辞，并连带执行 A 的全部同步链（UPLOAD 第 1 步 14 处载体穷举）。可在 A 之后独立择时执行。
- **C**：本审计意见书**不随包**（只落 `audit/claim-recheck3.md` 根件）：则 A 中省去「份数三份→四处」同步；但 README/UPLOAD 已建立的「历轮裁决书逐字全入包」惯例将成不实全称陈述，须在两处改为穷举式表述。**消耗：LaTeX 0 轮**。若改包内，则升为四份并同步 README:56-57、UPLOAD:133-136、zenodo.json notes、compile-log 末段四处活载体（仍 0 轮）。

## 八、门禁改进建议（harness/scripts 层，须用户批准，本处只出判据规格）

1. **规则 (c) 扩至来源标注句式**：DIRECTION_RX 增补 `(source|sources?|target|executor|via|written by|generated by)\b[:：]?` 与「出处/由…生成」类锚词；同一文件出现 ≥2 处仓内路径时可用「文件级图例行」（首行一条 "All tasks/…-style paths are repository-internal and not shipped"）折抵逐句明示，避免噪音。
2. **预算现状门**：对活载体扫描「cap|顶|budget of|Consumed」句，句中出现的具体顶值必须等于 `budget.log` 最后一条授权行的顶值；不等即 FAIL（本轮 G1 十处可全被此门机械抓住）。裁决书/账本历史行/编译当时日志列入豁免（沿用「声明不扫描 + 逐件理由 + 覆盖面算术」框架）。
3. **加法闭合门**：凡活载体同时写总额与目录/行内拆分，强制校验拆分和=总额、行内和+自身=总额（G2 属该类，清单头注已有此结构可抄）。
4. **行尾策略明文化**：SOP 08b/08 侧写死「生成件 LF、逐字与归档件原样」双线标准，门 5 对非归档件把「成对 CRLF」也计入告警（先 warn 后 red）。
5. **份数/清单类自指外移的权衡**（本轮实测随包自指全部与盘相符）：暂不强制拆到包外；若拆，规格为「随包 README 只写不变量（上限、约束），易变数只指向清单文件」——避免再造第二套需同步的数字。

## 九、报告签发必须披露的限定语（不得删）

沿用前三轮 L1–L10（语义桥未形式化、初值 8/6 项互证窗口、A001353 围栏、4n−1 退化注记、措辞双上限且明文否认新数学、AI 生成+钉版、数值窗口与周期最小性非 theorem、320 条 deprecation 不否决、roundtrip 同节点自裁由 kernel 对冲、骨架沿用先例不降级）**，另加本轮五条**：
① 编译现状：顶 **10**（`budget-auth-3`，专供 DOI 回填）、已用 9、第 10 轮未动用；随包四载体在 G1 修复前仍写顶 9（修复后此句改记「已订正」）。
② `claim.tex` 打印文披露句冻结于轮 9（"budget of 9 … requested separately"），属编译时实况，按卡面规划于第 10 轮同批更新——外发当日该句与预留授权现状有一拍滞后，须如实说明。
③ 数字层由本审计纯 stdlib 独立重推 n≤401：T1–T4 全窗真、余数表逐位复现、最小周期 6/5/12/10 为**计算事实**（非 theorem）。
④ 行尾实测：全包裸 CR=0、TAB=0；9 份归档日志各含 1 处原始 CRLF、`listing-ranges.txt` 整件 CRLF（G4），无任何包内文本声称「全 LF」。
⑤ 若本件入包，随包裁决书升至 **4 份**，「三份」四处活载体措辞须同步；各裁决书**本体**内的份数自述属当轮实况，逐字不改。

## 十、机械轨输出（本审计本人跑，全 exit 记录）

- `bash scripts/paper-lint.sh claims/notchgrid-parity-mod/claim.tex`（仓库根）→ **PASS exit 0**；审计收尾前 tex 哈希未变（`1287ae80…`，冻结核验 0 文件）。
- `python scripts/sanitize-package.py claims/notchgrid-parity-mod --scanned logs/notchgrid-claim-scanned.txt --skipped logs/notchgrid-claim-skipped.txt` → gate4 17+19=36 OK / gate2 0 违例 / gate3 PASS / gate5 PASS / gate1 PASS / **ALL GATES GREEN exit 0**（totals 打印 36 files / 521,741 bytes）。
- `python scripts/sanitize-package.py --selftest` → **5/5 OK exit 0**。
- `python claims/notchgrid-parity-mod/audit/sanitize-package.py --check-only` → 三门全绿 exit 0，覆盖面算术 `15 + 21 = 36`；其 `--selftest` → 5/5 OK exit 0（改前 N1 句仍 FAIL ⇒ 扩清单未钝化）。
- 独立复核命令组：`find -newermt`（两端 0）、`sha256sum`、`cmp`（22 对全 SAME）、`wc -l`、`sed -n`、内联 python（listing 反抽 7/7、对称差 6/6、c9 七区块、余数表/周期/T1–T4 窗验、`\lean{}` census 13/8/0、行尾普查、指称普查、清单字节和）。零编译（未跑 tectonic/Lean）、零模型调用、零外呼、被审包零写入。

## 十一、主代理落盘后的必做记账（按序，全 0 编译轮）

1. 本件落 `audit/claim-recheck3.md`；用户若裁入包 → 逐字拷 `zenodo/audit/claim-recheck3.md`（`cmp` 全同、本体不改）并把「三份」四处同步为「四份」（只改活载体，不改任何裁决书本体）。
2. 按 §六 G1→G2→G3→G5（→G4 随裁）执行清账批；`budget.log` 追加一行记录本轮审计与清账（历史行不回改；本审计在 `budget.log` 的记账行须裸 CR=0/TAB=0）。
3. 收敛顺序执行 UPLOAD:62-69：重跑包内门 + 共享门 + `paper-lint`（第 12 跑）→ `--write-manifest` 重生成清单 → 实测回写三处体量（card《成包状态》/UPLOAD 第 2 步/README《包体量》）。
4. 落盘后 `run-state.md` 一行状态（L5 同款归主代理）。
5. 类型级读数决定权移交用户：连续四轮同族，是否要求第 5 轮复审或按 §八-2 先补预算现状门再放行。

## 十二、审计耗材记账

llm-call **0**（栏位 0/4 不动）；Lean kernel 编译 **0**；LaTeX 编译 **0**（第 10 轮预留**未动用**，实测无 run10 产物、无新编译账行）；被审包**零写入**（双向冻结核验 0/0）；唯一写出物为派发指令许可的门运行附属件（`logs/` 下覆盖面清单文件为既有输入件、`logs/sanitize-selftest/` 为共享门 selftest 自管的暂存目录，均在包外）。未碰 `tasks/`、`papers/`、`run-state.md`、`harness/`（除只读回源判据 6）、`verify-proj/` 构建三件套、`harness/config.json`；论文包第 4 轮状态未据以立任何发现。身份：监察院 dept-audit（qoder 端点投影），全部判定可复现。

**交接四件**：SOP = `harness/departments/08b-claim.md`；卡面 = `claims/notchgrid-parity-mod/card.md`（含 budget-auth-3 授权行）；预算读数 = LaTeX **9/10（第 10 轮预留未动，本轮禁动属实）**、llm-call **0/4**、Lean **0**；产物路径 = 本件 `claims/notchgrid-parity-mod/audit/claim-recheck3.md`（主代理落盘），可选随包副本 `claims/notchgrid-parity-mod/zenodo/audit/claim-recheck3.md`。

---

**本轮是否零发现**：**否**——判据红 0 条、六项判据整轮复跑全通过、三门与 selftest 复算全绿，但新报 5 条发现（G1–G5），全部落在记账/转写/指令层。

**最小修复清单（每条消耗编译轮数标注）**：
- G1 顶现状十处载体订正——**0 轮**
- G2 card 两处目录拆分重写——**0 轮**
- G3 card:70 授权行指针改 `budget-auth-3`——**0 轮**
- G5 八处来源标注补明示——**0 轮**
- G4 `listing-ranges.txt` LF 规范化（或 README 注记）——**0 轮**
- 清单重生成 + 三处体量回写 + lint 第 12 跑——**0 轮**
- 唯一可能的编译轮消耗仍是 DOI 回填本身（tex 两处数字 +「需另轮申请」半句）——**1 轮 = 第 10 轮（已授权预留），由用户择时启动，非本轮义务**。
