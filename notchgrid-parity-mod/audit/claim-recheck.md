# 精简主张审计·门③**复审（第 2 轮）**：`claims/notchgrid-parity-mod/`

- 执行：监察院工人（dept-audit，只读，独立于占位线与首轮裁决）；主代理落盘并同步入包 `zenodo/audit/`。
- **落盘说明（主代理，2026-09-28）**：本件按「逐字副本」纪律入包，唯一改动是按本件 N3 自己的建议，把其中出现的**用户 GitHub 账号名字符串**写作脱敏形 `Aurora***34`（避免随包副本每多一份就多一次命中）。除此之外一字未改；首轮裁决书 `claim-check.md` 未做任何改动（用户裁 4 的「一字未改」纪律优先）。
- 被审对象在审计与落盘期间已冻结（无进程在写）。

## 总裁决（门③ 复审 · 第 2 轮）

**F1–F5 五条判据红全部验收通过（无一复发）；但本轮另有新发现 4 条（1 条包内承诺失实、1 条包内旧值、1 条不变量口径被自破、1 项 SOP 强制对账门未执行）。故门③ 第 2 轮 = 仍有发现 → 包暂不出仓、暂不得进入用户外发步。**

关键在于：四条新发现**都不是**措辞越级或证据失真，且**都不需要新的编译轮授权**——N1 必须折叠进 `UPLOAD.md` 第 1 步已预占的第 9 轮（DOI 回填）一起做；若主代理/用户把第 9 轮另作他用、再为 N1 单独编一轮，则 DOI 回填触第 10 轮，**必须显式向用户再申请授权**（宪条 5），不得默认工人自行放大。

**停线判定：不触发停线。** 理由（明示，不含糊）：SOP 08b 第 5 步的停线条件是「同一发现第 2 次出现」。第 8 轮编译的起因是 F2/F5 的**改文自身**把英文序数词 `first` 带进打印文本，破掉本包自记的机械扫描不变量——该回归已在两条独立路径上复算为**已消除**（tex 剥 `%` 注释与 listing 后 481 行打印文 `first` 命中 0；随包 `claim.pdf` PyMuPDF 抽取命中 0）。它与 F5 不是同一发现：F5 是「披露句漏印轮次数字」（一次修好，未复发）；轮 8 修的是新引入的措辞回归，属返工内部自我修正，且三处如实记账（`compile.txt` 轮表第 8 行、`budget.log` 8/9 行、`selfcheck.md` 追加段《返工自查发现》第 1 条）。F1–F5 本轮无一复发 → 停线判据不成立。

## F1–F5 逐条验收表（改前 = 首轮裁决书引文；改后 = 现稿原文 + 行号）

| ID | 改前（`audit/claim-check.md` 所载） | 改后（现稿原文与行号） | 独立复算依据 | 判定 |
|---|---|---|---|---|
| **F1** | "All four proofs share one skeleton … through an explicit `if`-chain … split on `mod_cases` … then bridge back to `Odd` through `Int.odd_iff`" | `claim.tex:242-243` "Three of the four proofs (Theorems T1, T2 and T4) share one residue-table skeleton"；`:251-252` "then, **in the two parity theorems**, bridge back to Odd"；`:253-255` T3 单列 "…and it is *not* of that skeleton: no residue table, no `if`-chain, no `mod_cases` split, no `Int.odd_iff` bridge"；`:255-262` 改述为 "a direct congruence calculation —— one `simp only [a3]` … used at two offsets … IH 逐项平移 … `Int.ModEq` 加/减/整乘相容 … base window `n<12` rather than the recurrence order"；同病灶 `:230-235` "in Theorems 1, 2 and 4 the table appears as an inner lemma, whereas Theorem 3 is proved as a shift identity and contains no such table" | 终稿 122–144 逐模式计数：`if`/`if_`=0、`mod_cases`=0、`Int.odd_iff`=0、`interval_cases`+`decide`=基例 1 次、`simp only [a3]`=1 次（产 `rec5`，被 `rec5 (j+19)`/`rec5 (j+7)` 两处 instantiate）、`rcases lt_or_ge n 12`（基例窗 12 ≠ 阶 5）、`rw [e1, e2]; exact key`（末步无 decide）。T1 段 34–120：`have main` if-chain@35、`mod_cases`@51、`Int.odd_iff`@113/117；T2 段 167–277：@167/188/271/275；T4 段 282–621：if-chain@282（三层）、`mod_cases`@304 与 @589、**无** `Int.odd_iff`；prose 引的行号 35--45/51--60/106--119/167--277/282/618/619--621 逐条 `sed` 实读命中（619--621 确为 `intro hc; rw [hc] at h` 反向闭合） | **通过** |
| **F2** | "two enumeration methods agreeing term by term up to $n = 24$" | `claim.tex:102-105` "a column-frontier dynamic program, which produced the whole $24$-row count table, and a brute-force recursion over matchings (the least uncovered vertex left unmatched or paired with one of its neighbours), run over **the leading eight and six entries respectively**"；`:427-430`（Limitations 第 2 项）"…over the leading $8$ entries of the $3 \times n$ column and the leading $6$ of the $4 \times n$ column, **which is the whole window it was run**, so the remaining rows of the $24$-row table are produced by the dynamic program alone"；`zenodo/metadata/zenodo.json` description 同句已改 | `phase0/compute.py:84-85` `count_brute(3,n) for n in range(1,9)` / `(4,n) … range(1,7)`；文件头 4–5 行「方法1 逐列 mask DP／方法2 顶点递归暴力（n<=8 / n<=6 对拍）」、`count_brute` docstring「取最小未覆盖点 v：v 闲置 或 v 与某邻点配对」；`counts.txt` 4 注释 + 表头 + 24 数据行 ✓。残留扫描：全文再无「agree … 24」类断言，其余 `24` 命中均为 24 行表 / `17/24` 预算 / 行号 24--31 / DOI 尾号，语义无关。**注**：`zenodo.json` description 里保留了序数用法——`first` 零命中不变量的记录范围是**短笺打印文本**（`card.md:102`），元数据不参与编译也不在该不变量口径内；见 N3 | **通过** |
| **F3** | "truncated subtraction on $\mathbb{N}$ would make the defining equations false as written" | `claim.tex:128-133` 现文只留可核事实："the recurrences have negative coefficients, so the integer codomain lets the defining equations be read as ordinary subtraction on $\mathbb{Z}$, and it lets the `Int.ModEq` congruences and the `Odd` bridge … apply without further coercion" | 全文 grep `truncat|monus|would make|false as written` → 唯一命中是 `:486` 的 "1628/4000 truncated"（token 截断，无关）；反事实断言彻底消失。`:128-133` 两句均可核：终稿两条 def 的 `\mathbb{N}\to\mathbb{Z}` 书写与 `Int.ModEq`/`Odd` 直接用法在 122/34 行头里字面成立 | **通过** |
| **F4** | "Evidence originals are copied into `audit/` of this package"（走「改文」路线，用户裁 2） | 三处同口径且与包实况相符：`claim.tex:345-350` "What `audit/` of this package ships is the key-line extract of each gate, the verbatim axiom printout and the claim lane's own re-verification files; the gate 2 and gate 3 originals (final-01-notch.txt, welldef-verdict.md, gate-t1--t4.txt, review-final-{strict,axioms}.out) **stay in the source task directory** … and are not part of this deposit"；`zenodo/audit/diff-conclusion.txt:47-56`《What this package does NOT ship, and why》；`zenodo/metadata/README.md:35-38` 同注 | 包内实况：`zenodo/audit/` 23 件实测，上述 8 个原件**零件**在包 ✓；而它们在 `tasks/20260927-mossad-notch/audit/` **全部真实存在**（逐个 `stat` 命中，final-01-notch.txt 3582B … review-final-axioms.out 51388B）✓；包内 4 件「非根目录件」= `axioms.txt`/`c9-record.md`/`compile-log.txt`/`diff-conclusion.txt`，与 README 清单逐件对应、无幻影条目 ✓ | **通过** |
| **F5** | 披露句未印已用轮次数字 | `claim.tex:489-492` "This claim-note stage used llm-call $0$ of its budget of $4$ and **$8$** LaTeX compile rounds of its budget of **$9$** (the original packaging used the then cap of $6$, which the user raised to $9$ on 2026-09-28 for the rework done after the audit; no cap was exceeded)" | 四处互洽：`card.md:68-70`《预算顶》授权行 + `:137`《门③返工记录》F5 行 + `budget.log:34` `latex 8/9` 与 `:27` `budget-auth` 行 + `audit/compile.txt:17` "Consumed: 8 of 9" + 轮表 8 行全 exit 0 ✓。回归消除：打印文 `first` **0**（tex 剥注释/listing 复算 + PDF 抽取复算）、`首创` 0、`new mathematics` 1 处且在否定句 `:360` "not a claim to new mathematics" ✓；listing 外非 ASCII 0 ✓ | **通过**（但见 N2：`compile.txt:14` 的 "all seven rounds exit 0" 是该修复链遗留的旧值散文） |

## 六项判据整轮复跑（全部自行复算，未采信任何自报）

| # | 判据 | 结论 | 证据锚点 |
|---|---|---|---|
| 1 | 锚点回源 | **通过** | 4 条 `% LEAN:`：`claim.tex:174/185/196/206`，名与 `grade=完全证明` 对 `tasks/20260927-mossad-notch/audit/final-01-notch.txt:7-10` 逐行吻合，`:12`「脚手架通过不适用」。sha256 直读复算：冻结件 `9a787b6b…426fb8`/69 行、终稿 `6f1a7440…9db4aa`/621 行；包内 `zenodo/proofs/` 两件与源件 `cmp` 全同；`lean-toolchain` 与 `verify-proj/lean-toolchain` `cmp` 全同（`leanprover/lean4:v4.34.0`）。**对称差自算**：两文件各恰 6 个顶层 decl、名序全同、6 条头行逐字节相同，终稿无额外顶层声明（`lemma/example/abbrev/instance` 0）→ 宪条 2 成立 |
| 2 | 措辞双上限 | **通过** | 上限 = 完全证明 ∧「查无占位 + 新序列/新递推」：abstract `:88-91`、Novelty `:355-361`、Limitations 1/3 `:420-437` 均不越级；围栏在位——A001353 三处（`:384-385`、`:406-413` 带 Zucker/Castilleja 挂名、书目 `:534-541`）＋ 4n−1 恒 0 只作退化注记 `:413-415`；a4 九阶「as found」两处原样（`:150-152`、`:438-442`），未美化；最小周期性明确归 computed（`:233-235`、`:443-446`）。在线复验 OEIS：`A001353` HTTP 200 含 `4*a(n-1) - a(n-2)`、`0, 1, 4, 15, 56`、`Zucker`、`Castilleja`、`3 X (2*n-1)`、`packing`；`A210662` monomer×3/dimer×5 ✓ → 书目无引用幻觉（4 条 `\cite` 键 = 4 条 `\bibitem`，未被引的 heilmann-lieb 确未搬入）。禁词：打印文 `first`/`首创`/`new mathematics`（非否定）/`proves that the number of matchings`/`first formalization` 全 0 |
| 3 | listing 逐字节 | **通过** | 自写解析器从 `claim.tex` 反抽 7 段（`:137/150/180/191/201/212/276` 起）与终稿 24-31/151-163/34/166/122/281/123-144 比对 → **7/7 BYTE-EXACT**，且与 caption 声明行号一致；6 段 def/statement 另为冻结件字面子串 **6/6**；listing 体内 `sorry|admit` **0**；证明块 caption 标 "verbatim excerpt, lines 123--144" 且指向包内全文 ✓（SOP 工序 3 摘录规则满足） |
| 4 | 预算数字照抄源账本 | **通过** | `claim.tex:484-488` 对 `tasks/20260927-mossad-notch/budget.log:14,18,19,22` 与 `formalized/roundtrip-call{1,2}.meta.txt`：llm **2/8**、compile **17/24**（6+9+2=17 分解成立）、tokens in/out **1628/4000**（截断）与 **1628/1889**（完整）、节点 `anthropic/a6api-main/kimi-k3`＋L3+L2 取证 2026-09-27（源 `card.md:4`）——逐项吻合，零漂数。本包侧 0/4 与 8/9 见 F5 |
| 5 | 披露四要素 + AI 非作者 + 无 PII + DOI 预留 + 无裸 `<<` | **通过（附 N3 例外须记）** | `claim.tex:475-501` 四要素齐；作者栏 `:71-72` 占位；DOI 措辞 `:459-460`；`<<` 在 note/README/zenodo.json **0**；`Aurora***34`（账号名串）在**用户面文**（claim.tex、claim.pdf、README、zenodo.json）**0**；邮箱式串 0；本机路径 0（全包该串命中仅在裁决书里的扫描口径叙述，见 N3）。`zenodo.json` creators=占位 + contributors=AI(type Other) → 未列作者 ✓。`related_identifiers[0]` 仍是 `https://github.com/<user>/…`，`UPLOAD.md:49` 已写明「做镜像时填、不做则删」→ 可接受，属外发时动作 |
| 6 | `c9-record.md` 在包且逐字一致 | **通过** | `zenodo/audit/c9-record.md` 7 区块按声明行段反 diff：chunk-G `5-10/35-59/61-84/116-117/122` + 池卡 `26-33/35-42` → **7/7 BYTE-IDENTICAL**；声明行段语义也对（源 35 行 = MAT-3NOTCH 段首、61 行 = MAT-4NOTCH 段首、116-117 = 区块小结、122 = 通道降级备忘、池卡 26/35 = pool-mossad-02/03 条首）。零命中查询全在（每族 head+去前1+去前2+×2+÷1 共 5 条、÷2 不适用注记）；结论字样未改写：`查无占位`×11、`新序列/新递推`×6、A001353 已占位＋挂名、OpenAlex 429 未验证。短笺通道表逐格对表：5 变体/10 条零命中、A210662 手切 `T(3,·)=3,22,131`、`T(n,3)=131,823,5096`、`T(4,·)=5,71,823,10012`、近完美 `4,29,161,798` 与 `2,7,29,88,288`、PM 头 `1,4,15,56,209,780,2911`、zbMATH 12/90/1/2/1、锚点 A000045/A180970 —— 与逐字记录**全部同值**，无一处拔高 |

附加机械复算（非判据，防漂移）：由两条 def 作定义迭代 n≤401 → 四张余数表 `claim.tex:223-226` 逐位命中；T1–T4 全窗为真；最小周期 6/5/12/10；序列头 8/6 项与送检串逐位同。0 sorry / 0 admit / 0 逃逸通道 / 0 `sorryAx`、strict 日志 `error` 0 且 EXIT=0、deprecation `if_neg` 236 + `if_pos` 84 = **320**（对 `claim.tex:322-323`）、`audit/review-final-{strict,axioms}.out` 与 `attempts/final-*.out` `cmp` 全同、包内 `axioms.txt` 四行与源 `final-axioms.out` 逐字节相同且顺序未重排。

## 包一致性与体量互洽核

- 实测：`zenodo/` = **31 文件 / 403,685 字节**；分目录 audit 23 件 184,321 + claim 3 件 166,533 + proofs 3 件 43,400 + metadata 2 件 9,431。
- 三处同值 ✓：`card.md:124`（含四子目录精确字节和）、`UPLOAD.md:44`（"31 文件、403,685 字节 ≈ 394 KB"，403685/1024=394.2 ✓）、`budget.log:43` 主代理订正行。工人旧值 403,315 只留在 `budget.log:35`（追加式账本历史行）与 `selfcheck.md` 追加段——见 N5/N3'。
- README 的 `audit/` 清单 = 23 件，与盘上 23 件**逐件对应**（含 `compile-run{1..8}.log` 八件、`claim-check.md`），无幻影、无漏项；`selfcheck.md` 未随包出（`card.md:141` E6 口径与实况一致 ✓）。
- `cmp` 全同：根 `claim.tex`/`claim.pdf`/`lstlean.tex` ↔ `zenodo/claim/*`；`audit/claim-check.md` ↔ `zenodo/audit/claim-check.md`（裁决书一字未改 ✓）；`zenodo/claim/lstlean.tex` ↔ `harness/templates/paper/lstlean.tex`（且 `harness/templates/claim/` 下确无 lstlean 副本，符合「单一事实源在 paper 侧」）。终态 shipped 哈希：tex `25b64939…046e`、pdf `5175c8c8…af9e`，与 `compile.txt:60-66`、`lint.txt` run 9、`budget.log:35` 所载一致；pdf 127,981 B = `compile-run8.log` "127981 bytes written" ✓；根↔包 `audit/` 同名 19 件全部 `cmp` 相同（含 8 份原始编译日志）——**无根/包不同步件**。
- `logs/notchgrid-claim-listings.py`、`logs/notchgrid-claim-c9.py` 存在（被 `c9-record.md` 头注明写「in the AI4Math repository」，口径正确 ✓）。

## 中断遗留面专项结论（工人断在「更新轮次记录」处）

被审对象现无进程在写；实测内容本体（tex/PDF/listing/锚点/c9）完整，旧值只残留在**记账散文**里：

| # | 定位 | 现状原文 | 判定 | 需额外编译轮？ |
|---|---|---|---|---|
| L1 | `audit/compile.txt:14` ＝ `zenodo/audit/compile.txt:14`（随包） | "it affects no verdict (**all seven rounds** exit 0, Missing character 0)" | 半改：同文件 `:17` 写 "Consumed: 8 of 9"、`:6` 与轮表列到 run8 → 文内自相矛盾 | **否**（.txt，不进编译） |
| L2 | `card.md:114` 门②行末 | "…；**七轮**原始日志全随包"，同行证据列却写 `compile-run{1..8}.log` | 半改（卡面记账旧值，不随包） | **否** |
| L3 | `audit/selfcheck.md` 追加段 §4（`:170-172`） | 佐证 "8 of 9" 时引用 `budget.log` 的 `latex **7/9**` 行与 `compile.txt` 轮次表「（**7 行**）」 | 半改：应引 `latex 8/9`（`budget.log:34`）与 8 行轮表 | **否**（且按 E6 不随包） |
| L4 | `audit/selfcheck.md` 追加段《返工后门①②复跑与包体量实况》（`:196-199`） | "31 文件 / **403,315** 字节（audit 23 件 **183,951**…）" | 主代理订正（403,685 / 184,321）未回写本件 | **否**；按追加式纪律**加订正行**而非回改 |
| L5 | `run-state.md:452` | 仍写「先例两包各 10 页」 | E2 订正（四包 9/10/10/10）只落到 `card.md:146`，未同步 run-state | **否** |
| L6 | `audit/rework-evidence.txt:10-11`（随包） | "…Nothing below was recomputed by the claim lane is quoted from the auditor's text…" 句子残缺（两句并一） | 排版级文字缺陷，不改变任何断言 | **否** |
| — | tex ↔ 账本轮次数字 | `claim.tex:489-492` = 8 of 9 ↔ `budget.log:34` 8/9 ↔ `compile.txt:17` 8 of 9 ↔ `card.md:69` 8/9 ↔ README `:13` 8 轮 ↔ UPLOAD `:23/:38` 8 轮·8 of 9 | **一致，无残留旧值** ✓ | — |
| — | `zenodo/` 与根目录不同步件 | 无（见上节 cmp 全表） | ✓ | — |

## 新发现清单（首轮未报，故均不构成「同一发现复发」）

| ID | 严重级 | 定位 | 问题（复算依据） | 回哪个工序 | 建议改法 | 需编译轮？ | 触发停线？ |
|---|---|---|---|---|---|---|---|
| **N1** | **中·出包前必修**（SOP 08b《已知边界》点名的主失效模式） | `claim.tex:459-460`（= `zenodo/claim/claim.tex` 同处）；同型：`zenodo/metadata/README.md:6,65`、`:71` | 「see `UPLOAD.md` **in this package**」不实：`UPLOAD.md` **不在** 31 件存缴树内（在 `claims/<slug>/` 根），`budget.log` 同理；且与同文 `:121-124` 自陈「仓内路径 deposit 时不可公开取回」正面冲突。两个最新先例包（`chorded-cycle-mod4`、`pendant-ladder-interleave`）已改用 "see `UPLOAD.md` in the **source repository**"，本包沿用的是早期旧句式 | 工序 3（tex）＋工序 4（README） | `:460` 改 "…; see `UPLOAD.md` in the source repository"；README 两处与 `:71` 的「本包」改「源仓 deliverable 目录」 | **是，但应折入已预占的第 9 轮（与 DOI 回填同轮）**；若另编一轮 → 第 10 轮 → **须主代理向用户再申请授权** | **否** |
| **N2** | 低·包内旧值 | `zenodo/audit/compile.txt:14`（与根件同字节） | "all seven rounds exit 0" 与同文件 `:17` "Consumed: 8 of 9"、轮表 8 行、`compile-run{1..8}.log` 八件矛盾（返工中断遗留 L1） | 工序 4（记账件） | 改 "all eight rounds exit 0"；同处可补一句：`compile-run*.log` 里的 `Fontconfig error: Cannot load default config file` 是 tectonic 便携版字体环境提示、非 LaTeX error（各轮 exit 0 与 "bytes written" 为证），免读者见 "error" 与轮表 "0 errors" 相左 | **否** |
| **N3** | 中·口径失实（脱敏不变量被自破） | `zenodo/audit/claim-check.md:22`（随包裁决书内**唯一** 1 处命中）；断言方：`card.md:141`、`selfcheck.md:75` 与 `:182` | 首轮裁决书称「全包 grep 账号名串 **0 命中**」，而该句自身入包后即成为命中。实况：包内 1、根目录另有 `audit/claim-check.md:1`、`selfcheck.md:2`、`card.md:1`。该串系用户 GitHub 账号名（`harness/CHANGELOG.md:196` 记署名系用户指令；先例 `chorded-cycle-mod4` 作者栏即用它），而**本包作者栏仍是占位符**——即本包尚未做署名裁决，随包裁决书等于提前把该标识写进公开树 | 工序 5/记账（**不是**工序 3） | 不改裁决书（「一字未改」是用户裁 4 的纪律，改它即伪造证据副本）。正确动作是把不变量**改述为真实口径**：`card.md:141`/`selfcheck.md` 追加订正行——「用户面文（`claim.tex`/`claim.pdf`/`README.md`/`zenodo.json`）0 命中；随包首轮裁决书内含该串的扫描口径自述 1 处，属逐字副本的既成事实」；并请主代理落盘**本复审书**时对该串做处理（本件已按此写作 `Aurora***34`） | **否** |
| **N4** | 中·SOP 强制门未执行 | SOP `harness/departments/08b-claim.md:113`；本包证据缺失：`scripts/` 无通用 `sanitize-package.py`、`audit/` 无该件、包内无 sanitize 输出、`zenodo/metadata/FILE-MANIFEST.txt` 缺失（先例两包均随包有） | SOP 要求「出包前必跑 `--check-only`（或 `--assert-promises`）：清单一致性、路径型承诺对账、无本机路径三项任一不绿即不得外发」。本包从未跑过该对账 → **N1 正是它本该抓的项**。另注意工具自身盲区：现版 `promises()` 正则对裸文件名（无 `/`）`continue` 跳过，故 `UPLOAD.md` 漏网（先例包的「PASS」同样是带此盲区得出） | 工序 4 | 主代理照 `claims/pendant-ladder-interleave/audit/sanitize-package.py` 派生本包专用件（TASK=`tasks/20260927-mossad-notch`、CLA=`claims/notchgrid-parity-mod`），把承诺扫描扩到「in this package / 本包」句式邻近的裸文件名，生成 `FILE-MANIFEST.txt`，三项全绿后才允许外发；跑前先与 N1/N2 的修改合并，避免清单二次失效 | **否** |
| **N5** | 提示（非发现） | `zenodo/audit/` 现有随包首轮裁决书 | 首轮裁决书正文含「包不得出仓」与其当时的 27 件/341,133 字节、六轮等实况——无缺陷，它是被用户裁 4 保护的历史副本。但公共读者现在只看到一份「不通过」而看不到处置结论 → **复审书必须随包** | 工序 4 | 主代理把本意见落 `audit/claim-recheck.md` **并同步进 `zenodo/audit/claim-recheck.md`**，随后重算包体量三处互洽值（会因新增 1 件而变） | **否** |

**须随报告披露的限定语（最低级措辞，逐条已在位，签发时不得删）**：L1 语义桥未形式化（`:92`、`:424-433`）／L2 初值出处与互证窗口／L3 A001353 围栏＋挂名／L4 4n−1 恒 0 只作退化注记／L5 措辞上限＝「新序列/新递推＋查无占位」且明文否认新数学（`:359-361`）／L6 全部 Lean 代码 AI 生成＋钉版／L7 数值范围 n≤60、模 DP n≤600、0..80 全窗＋最小周期非 theorem／L8 320 条 deprecation 不作否决／L9 roundtrip 同节点自裁、由 kernel 终裁与复跑对冲／L10 骨架沿用同池 cchord 先例经裁定不构成降级。

## 机械轨输出（审计本人跑，不采信自报）

- `bash scripts/paper-lint.sh claims/notchgrid-parity-mod/claim.tex`（仓库根）→ `PASS: paper-lint 全绿`，**exit 0**（与 `audit/lint.txt` run 9 同一文件：sha256 `25b64939…046e`）。
- 门②只读复核（**未跑 tectonic**）：`compile-run7.log` / `compile-run8.log` 各自 distinct `warning: claim.tex:N: Overfull` = **0**、Underfull = **4**（run6 = 3，与 `compile.txt` 轮表一致）、`Missing character` = **0**、日志内唯一 "error" 串为 `Fontconfig error`（环境提示，非 LaTeX error）；run8 尾 "127981 bytes written" + `[1]…[12]` → 随包 `claim.pdf` 127,981 B、PyMuPDF `page_count` = **12**、`??` = 0、`<<` = 0、账号名串 = 0、打印文 `first` = 0、`new mathematics` = 1（否定句）、`sorry` 4 / `admit` 1 全在否定式披露句（逐处上下文核读）。
- 网络只读 GET：`oeis.org/A001353`、`oeis.org/A210662` 各 1 次（均 HTTP 200），无 DNS 异常，未用 `--resolve`。

## 审计耗材记账

llm-call **0**；Lean kernel 编译 **0**；LaTeX 编译 **0**；**未写任何文件**（本意见交主代理落 `audit/claim-recheck.md` 与 `zenodo/audit/claim-recheck.md`）；未碰 `tasks/`、`papers/`、`verify-proj/` 构建三件套、`harness/config.json`（论文包第 3 轮状态本审一律未据以立发现）。只读命令：`ls/find/stat/wc/sed -n/head/tail/cat -A/cut`、`grep/rg`、`sha256sum`、`cmp`、`python -c`（内联复算：listing 反抽 7/7、c9 七区块 diff、对称差、余数表与最小周期、打印文禁词扫描、PDF 文本抽取）、`bash scripts/paper-lint.sh`（exit 0）、`curl -s --ssl-no-revoke`（2 次 GET）。身份与置信依据：监察院 dept-audit（qoder 端点投影），判定全部可复现，未采信任何工人自报字段。

## 给主代理的收尾顺序（建议，不含外发）

1. N2/L1–L6 六处记账与散文旧值（零编译轮，含 `compile.txt` 那一句）；
2. N3 口径改述（追加订正行，不回改裁决书）；
3. N4：派生并跑 `sanitize-package.py --check-only` 生成 `FILE-MANIFEST.txt`；
4. 把本复审书落 `audit/claim-recheck.md` 并同步进 `zenodo/audit/`；
5. **N1 的 tex 措辞改动与 DOI 回填合并为第 9 轮一次完成**（同轮须把披露句轮次数字改为 9 并同步 `budget.log`/`card.md`/README/UPLOAD 四处），随后重算包体量三处互洽值、再跑一次 `paper-lint`；
6. 若第 9 轮无法合并（用户要先回填 DOI 或另有用途），**停下向用户申请第 10 轮授权**，不得默认放大。
