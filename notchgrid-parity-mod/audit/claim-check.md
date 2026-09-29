# 精简主张审计（SOP 08b 占位质检门·门③）：claims/notchgrid-parity-mod/

- 审计时间 2026-09-28；执行：监察院工人（dept-audit，只读，独立于占位线）；主代理落盘归档并同步 `zenodo/audit/`。
- 对照基准：`tasks/20260927-mossad-notch/{report.md, audit/final-01-notch.txt, formalized/01-notch-mods.lean, final/01-notch-proved.lean, attempts/final-axioms.out, phase0/compute.py, phase0/counts.txt}`、`tasks/20260927-mossad-select/c9-recheck/chunk-G.md`、`harness/selection-map/pools/mossad-50.md` Part A 02/03、`harness/departments/08b-claim.md`。
- 预算：llm-call 0、Lean kernel 编译 0、LaTeX 编译 0。
- 独立复审口径：占位线工人自报（7/7 listing、c9-record 7/7、六项自查全过、lint/6 轮编译全绿）**一律不作为证据**，本审计全部自行复算（宪条 1）。

## 总裁决

**门③（占位质检门③·精简主张审计）＝不通过：有发现 5 条（判据红 5，editorial 6 项观察）。包不得出仓。** 四项发现集中在 `claim.tex` 的三句事实性断言与披露节一个漏项，一条可用零成本打包修复（F4 选 (a)）；F1/F2/F3/F5 需改 tex → 须用户显式授权第 7 个 LaTeX 编译轮（宪条 5，本包 6/6 恰用满）。另需注意：**即使无发现，本包也不可能零编译轮出仓**（`UPLOAD.md` 第 1 步的 DOI 回填本身就要一轮），故追加授权是必然项，建议一次授权 2–3 轮（修发现 1＋DOI 回填 1＋复审 1）。

机器门禁复核：`paper-lint` 从仓库根复跑 **exit 0**；tectonic 六轮日志 exit 0、终轮 12 页、`Missing character` 0、Overfull 0、PDF 内 `??` 0（PyMuPDF 独立抽取证实）。门①②成立；门③因上述 5 条不成立。

## 六项判据逐条表

| # | 判据 | 结论 | 证据锚点（文件:行） |
|---|---|---|---|
| 1 | 锚点回源 | **通过** | 4 条 `% LEAN:`：`claim.tex:172/183/194/204`，名=`a3_odd_iff/a4_odd_iff/a3_mod8_periodic/a4_mod4_eq2_iff`，grade 全 `完全证明`；对 `tasks/20260927-mossad-notch/audit/final-01-notch.txt:7-10` 分级表逐行吻合，`:12` 原文「脚手架通过不适用」。冻结件 sha256 `9a787b6b…426fb8`/69 行、终稿 `6f1a7440…9db4aa`/621 行（`sha256sum`+`wc -l` 复算）；包内 `zenodo/proofs/` 两件与源件 `cmp` 全同；顶层 decl 恰 6 个（终稿 24/34/122/151/166/281 行 = 冻结件 26/36/40/48/63/68 行，名序全同）→ 宪条 2 成立。审计证据在位＝闸门二/三关键行摘录＋逐字公理打印，**非原件**（见 F4） |
| 2 | 措辞双上限（≤ 分级 且 ≤ C9） | **有发现 4 条（F1/F2/F3/F4）** | 通过项：kernel 层四条定理散文与 Lean 语句逐项吻合（`claim.tex:173-213`）；novelty 节照抄四态与价值级（`:337-345`，四态译名对 SOP 01:141）；A001353 围栏三处带 Zucker/Castilleja 挂名（`:366-367, 389-395`，OEIS 页面实测含该挂名）；4×n PM 恒 0 只作退化注记（`:395-397`）；a4 九阶「as found」（`:148-150, 417-421`）；最小周期归计算证据（`:229-231, 422-427`）；OpenAlex 429/网页层降级如实保留（`:374-376, 413-416`）；打印文本 `first`／`首创`／`新数学`／`proves that the number of matchings` 零命中（PDF 文本抽取实测；`new mathematics` 唯一命中在否定句 `:342`）。失败项见发现清单 |
| 3 | listing 逐字节 | **通过** | 我自己重抽（未复用 `listing-verify.txt`）：7 段 lstlisting 体块在 `final/01-notch-proved.lean` 的 24-31/151-163/34/166/122/281/123-144 行**逐字节命中且与 caption 声明行号一致 → 7/7 BYTE-EXACT**；6 段 statement/def 另在冻结件逐字命中（26/48/36/63/40/68 行起）→ 6/7（第 7 段是证明体，本就不该在冻结件，正确）；证明块 caption 明写 `verbatim excerpt, lines 123--144` 且「complete source … in `proofs/01-notch-proved.lean`」（`claim.tex:260-262, 235-238`），SOP 工序 3 摘录规则满足；listing 体内 `sorry/admit/sorryAx` 零命中；`audit/listing-ranges.txt:6-12` 与 tex 实交 7 段一致，`lst:t1main` 删除事由在注记行 `:3-5` 写明 |
| 4 | 预算漂数 | **有发现 1 条（F5）** | 源账本逐项吻合：`llm 2/8`、`compile 17/24`（6＋9＋2＝17，`tasks/…/budget.log:14,18,19,22`）、tokens `in=1628/out=4000` 截断与 `1628/1889` 完整（`formalized/roundtrip-call{1,2}.meta.txt` 原文）、节点 `anthropic/a6api-main/kimi-k3`、L3＋L2 交叉核对取证 2026-09-27（源 `card.md:4`）→ `claim.tex:461-470` 全部照抄无误。本包 6 轮逐行在账（`claims/…/budget.log:13-18`，1/6…6/6），**无 7/6 行、无静默放大、未超限**；Overfull/Underfull 与页数（14→11→12→12→12→12）逐轮核对，`compile.txt:8-10` 的去重计数口径成立。缺项＝tex 未印本包 LaTeX 轮次用量数字 |
| 5 | 披露与 PII | **通过（附观察）** | 四要素齐：环节枚举 `claim.tex:457-461`、模型-节点-预算表 `:461-473`、终裁声明原文 `:477-480`、作者负责 `:480-481`＋`:483-489`（AI 不列作者）；作者 `\author{Author Name\thanks{…placeholder…}}`（`:71-72`），`zenodo.json creators.name/orcid` 为 `<…>` 占位；全包 grep `Aurora0134` **0 命中**、无邮箱/ORCID 实号/本机用户名（唯一 `@` 在 `:220` tabular 列分隔）；DOI 一律「to be reserved at upload」（`:442-443`，渲染文本实测 1 处）；`<<` 零残留；非 ASCII 仅出现在 LaTeX 注释（`:8, 38-42`）、`% LEAN:` 锚点行（`:172/183/194/204`）与 listing 体内（Lean 原文），正文渲染体无原始非 ASCII（lint 第 4 判据同判）；模板 XeTeX 渲染补丁 17 条 `lccode`＋2 处 `\ifdefined` 与 `harness/templates/claim/claim.tex` 仅首行注释改写、守卫与映射全保留 |
| 6 | c9-record 在包且逐字一致 | **通过** | `zenodo/audit/c9-record.md` 7 区块按声明行段反向 diff：chunk-G `5-10/35-59/61-84/116-117/122`＋池卡 `26-33/35-42` → **7/7 与源件逐字节相同**（行数 6/25/24/2/1/8/8 全对）；零命中查询（OEIS 各 5 变体＋÷2 不适用、关键词、A210662 切列、派生近完美、zbMATH 五组、MSE、arXiv、库层、Lean 生态层）全在；结论字样未改写：`查无占位`（B2 行 70/B3 行 100/B4/B6/B7）、`新序列/新递推`、A001353 已占位＋挂名、OpenAlex 429 未验证。短笺通道表（`claim.tex:350-386`）与 c9-record 无矛盾（Lean 生态层「zero hits」与源裁决行同判，细部限流注记随原文在包） |

## 追加三项（主代理指定）

### A. 路由与收入门槛复核：成立，不拆笺

门槛四条：#1 用户 2026-09-27「走完论文部和快速占位流程」指令＝当场行使签发权（`report.md:3` 头至今仍为「待闸门四人工签发」，与先例 `claims/tatami-mod8-defect/card.md:4` 同口径，`card.md:15` 如实记，未回改源件）——**满足但请用户把签发戳落到 report.md 文件头**，否则该门槛长期只靠指令记录；#2 分级四条全完全证明 ✓；#3 C9 主命题各＝查无占位 ✓；#4 用户指令 ✓。

路由按 SOP 08b 路由表：价值级「新序列/新递推」→ 即时层 Zenodo＋脱敏 GitHub 快照、社区层 OEIS 两条目、compfiles 不适用（题源非竞赛）、叙述性走 SOP 08 慢车道 ✓ 与 `card.md:50-58`/`UPLOAD.md:8-11` 一致。

「多成果各自一笺」口径判断：本包源＝**单一已签发任务、单一 report.md、单一 69 行冻结件（a3/a4 两条 def 与四条 theorem 同文件）、单一 621 行终稿、单一裁决书、相邻两段 C9 区块**，成果粒度＝签发粒度＝一笺；pool-mossad-02/03 是**选题条目**粒度而非成果粒度，且 OEIS 侧已按序列拆成两条目，优先权覆盖不受影响。**判：可接受，不拆。** 若用户仍要拆：笺 A＝T1+T3（池 02，listing 24-31/34/122＋T1 或 T3 证明摘录，c9 区块 B2+B6），笺 B＝T2+T4（池 03，listing 151-163/166/281＋T4 摘录，c9 区块 B3+B7），两包均须整拷同一 69 行冻结件与 621 行终稿（证据重复）、各自 6 轮编译顶（合计 12 轮）与两份 zenodo 元数据；pools 状态戳两处仍都要打。

### B. 页数偏差＝editorial，不是判据红，也不是出包阻碍

SOP 08b 的 2–4 页写在「职责」行（`08b-claim.md:5`），既不在工序 5 六项判据、也不在失败模式表；且四个先例包实交 9/10/10/10 页（PyMuPDF 逐包实测），SOP 参数与工序 3 的必备节内容（statement 快照＋证明 listing＋逐字公理块＋通道表＋四要素披露）在本仓形态下互相矛盾。**判定：不改就不过门③的是 F1–F5，与页数无关；页数按已披露偏差由用户裁可（审计建议接受，并建议把 SOP 08b 目标改为「正文（不含 listing 与证据表）2–4 页 / 整包 ≤ 10 页」——harness 改动需用户裁定，审计不代改）。**

不删证据前提下的最小可压方案（预计 12→8–9 页，全部为版式/散文，不动任何 listing、通道表行、公理块、披露节）：①`geometry` 边距收紧到 0.85in；②在 `claim.tex` 内以 `\lstset{basicstyle=\footnotesize\ttfamily}` 覆写（**不改 `lstlean.tex`**，保持与模板 `cmp` 一致）；③四张余数表并为一个 `\scriptsize` 表；④C9 通道表 `\scriptsize`；⑤压缩 Introduction 第三段（论文车道说明）与 Provenance 段的散文。**2–4 页在保留全部证据的条件下不可达**，若用户要求达标即等于删证据，本通道禁止。任何上述改动都需用户重新授权编译轮。

### C. 未实测项清单核对：UPLOAD.md 到位 2/3

①OEIS 提交侧本机未实测 ✓ 写到位（`UPLOAD.md:50-52`，含「首次启用前由用户先走一次提交流程并回报实况」）；②GitHub 脱敏快照只推 `zenodo/` 内容、禁推整仓 ✓ 三处写到位（`:18-20`、`:69-70`、红线 `:88`）；③**arXiv/pdflatex 路径未实机验证 ✗ UPLOAD.md 缺**（只在 `zenodo/metadata/README.md:51-53`、`card.md:127`、`audit/selfcheck.md:110`）→ 建议补一行（`UPLOAD.md` 不参与编译，零成本）。

用户手动外发顺序建议：**0** 授权追加 LaTeX 预算（2–3 轮）→ 回工序 3 修 F1/F2/F3/F5、工序 4 修 F4 → 复跑 `paper-lint`＋`paper-compile` → 门③复审一次（同一发现第 2 次出现即停线）；**1** Zenodo 预留 DOI → 回填 `claim.tex` Data availability 与 `zenodo.json` → 同轮重编；**2** Zenodo 上传发布，记 Concept/Version DOI；**3** OEIS 两条目首次提交实测并回报（含围栏注释：全匹配主口径＋A001353 归属＋4×n 恒 0）；**4** GitHub 脱敏快照（仅 `zenodo/`）；**5** 回填 DOI/A 编号到 `card.md`、`run-state.md`、`pools` 的 02/03 两条状态戳、论文包 Data availability。

## 发现清单（逐条钉回工序）

| ID | 严重级 | 定位 | 原文引用（截） | 问题（复算依据） | 回哪个工序 | 建议改法 | 需额外授权编译轮？ |
|---|---|---|---|---|---|---|---|
| **F1** | 判据红 | `claim.tex:238-247`（Proof 节，紧接 `lst:t3proof`） | "All four proofs share one skeleton: establish an inner statement … through an explicit `if`-chain over $n\bmod P$; … split on `mod_cases` $j\bmod P$ …; then bridge back to `Odd` through `Int.odd_iff`" | 对 T3 不成立：`have main` if-chain 只在 35/167/282（T1/T2/T4），`mod_cases` 只在 51/188/304/589；T3 证明体 123-144 内 `if`/`mod_cases`/`Int.odd_iff` **0 命中**，且递推展开两次（`e1`/`e2`＝132-137）并以 `exact key`（144）收口、末步无 `decide`。本包把 T3 全文印在同一段落上方，读者一眼可见矛盾 | 工序 3 | 改为「三条（T1/T2/T4）共用余类表骨架；T3 为合同演算直证：两次 `simp only [a3]` 展开＋`ih` 逐项平移＋`Int.ModEq` 线性组合收口」 | 是 |
| **F2** | 判据红 | `claim.tex:409-411`（Limitations 第 2 项）；另 `:101-105` 未加限定；同一句已复制进 `zenodo/metadata/zenodo.json` description | "two enumeration methods agreeing term by term up to $n = 24$" | 与源记录不符：`phase0/compute.py:84-85` 暴力枚举只跑 n=1..8（a3）/1..6（a4），`phase0/counts.txt` 24 行（n=1..24＝本包 0-idx 的 0..23）其余来自 mask DP。先例论文包自己写的才是实况（`papers/notchgrid-parity-mod/paper.tex:655-658`「the latter up to n=8 … and n=6」；`:196-198`）。同时「up to n=24」在 0-based 口径下也超出表宽一项 | 工序 3 | 改为「两种方法在前 8 项（a3）/前 6 项（a4）逐位对拍一致；24 行表的其余行由 DP 单独产出（n=1..24，即本包 0-idx 的 0..23）」；同步改 `zenodo.json` description（不需编译） | 是（tex）／否（json） |
| **F3** | 判据红 | `claim.tex:128-131`（Statement 节） | "the recurrences have negative coefficients, and truncated subtraction on $\mathbb{N}$ would make the defining equations false as written" | 反事实不成立：对两条递推按 ℕ-截断减法、左折叠与「先加后减」两种结合顺序分别迭代到 n≤300，**与 ℤ 语义逐位相同（0 处分歧）**——首两项的正项量级远大于后续减项。该句自论文包继承（`paper.tex:321-324`） | 工序 3 | 去掉反事实断言，改为「取 ℕ→ℤ 使递推按整数减法书写，并让 `Int.ModEq`/`Odd` 桥接直接可用；截断减法在本窗内数值相同，把减法语义交给读者判断是不对的」 | 是；**同时须回改论文包同句（门③另一役，超出本包范围）** |
| **F4** | 判据红 | `claim.tex:329-332`（Verification evidence·Audit chain 末句） | "Evidence originals are copied into `audit/` of this package" | 与包内实况矛盾：`zenodo/audit/` 19 件全为占位轨自验件或关键行摘录（`compile-log.txt:1-2` 自陈「Every line is quoted from a source-task gate file … nothing here was recomputed by the claim lane」；`diff-conclusion.txt` 末节「What this package does NOT ship」）；闸门二/三原件（`final-01-notch.txt`、`welldef-verdict.md`、`gate-t{1..4}.txt`、`review-final-{strict,axioms}.out`）**不在包内** | 工序 4（首选）或工序 3 | 选 (a) 零成本：把上述原件拷入 `zenodo/audit/` 并更新 `metadata/README.md` 文件清单与 `UPLOAD.md` 的 27 文件/341,133 字节口径（该句随即为真，tex 不动）；或选 (b) 改文为「关键行摘录＋逐字公理打印随包，原件留在源任务目录（不可公开取回）」。**注意 (a) 会把内部中文审计文本与 relay 节点别名 `anthropic/a6api-main/kimi-k3` 一并入公开包（该别名短笺按 SOP 照抄已公开披露），此取舍归用户定** | 选 (a) 否；选 (b) 是 |
| **F5** | 判据红（漏项，非漂数） | `claim.tex:471-473`；对照 `claims/…/budget.log:18,25` | "This claim-note stage used llm-call $0$ of its budget of $4$ and LaTeX compile rounds of its budget of $6$ as recorded in …" | 已用轮次的数字缺失：PDF 文本抽取实测无「6/6」字样（`zenodo.json` notes 里反倒写全「6 LaTeX compile rounds of its budget of 6」）；`audit/selfcheck.md:64,72` 声称短笺已披露 6/6，与渲染文本不符。本包实际恰用满 6/6，恰是最该在文内可见的一次 | 工序 3 | 补一个数字：「used llm-call 0 of its budget of 4 and **6** LaTeX compile rounds of its budget of 6（cap reached, none over）」 | 是 |

**editorial 观察（不构成门③阻碍，不判红）**

- E1 页数 12 vs 2–4：见追加项 B（判 editorial，先例实测 9/10/10/10）。
- E2 `card.md:125`「先例两包各 10 页」不准（tatami＝9 页，先例共 4 包）——内部记录小误，改卡不编译。
- E3 `claim.tex:119-124, 450-453` 指向私有仓路径（`papers/…`、`phase0/`），建议加一句「deposit 时不可公开取回，公开镜像恰为本包内容」。
- E4 `UPLOAD.md` 缺 pdflatex/arXiv 未实机验证项（见追加项 C）。
- E5 公开文内披露 relay 渠道别名 `anthropic/a6api-main/kimi-k3` 属 SOP「照抄」强制，仅提示用户知悉。
- E6 `audit/selfcheck.md` 未随 `zenodo/audit/` 出包（SOP 未强制，仅备查）。

## 独立复算证据块

- **哈希/行数**：冻结件 `9a787b6be05dc345343edf675d107801e674e3abae095356ace390fac8426fb8`（69 行）、终稿 `6f1a7440f5830633e9309ab5629e16308928bb6421f64f4d4b1988b8929db4aa`（621 行）、`lean-toolchain` `8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632`（内容 `leanprover/lean4:v4.34.0`）；包内两件 `.lean` 与源件 `cmp` 全同；`zenodo/claim/claim.tex` 与工作件 `cmp` 全同；`zenodo/claim/lstlean.tex` 与 `harness/templates/paper/lstlean.tex` `cmp` 全同。
- **公理白名单**：`attempts/final-axioms.out` 末四行（EXIT=0 前）＝`propext, Classical.choice, Quot.sound` ×4，顺序与 `claim.tex:315-318` verbatim 块逐字一致、未重排；`audit/review-final-{strict,axioms}.out` 与 `attempts/final-*.out` `cmp` 全同（宪兵/监察院复跑对得上）；**全文无 `sorryAx`**。
- **0 sorry / 逃逸通道**：终稿 `sorry` 命中 0、`admit` 0、`set_option|axiom|unsafe|implemented_by|extern|macro_rules|elab|native_decide|decide!` 命中 0；strict 日志 `error` 0、EXIT=0、`if_neg` 236＋`if_pos` 84＝320（与 `claim.tex:305-307` 一致）。
- **listing 反抽**：**7/7 BYTE-EXACT 且与 caption/`listing-ranges.txt` 行号一致**（24-31/151-163/34/166/122/281/123-144）；**6/7** 在冻结件逐字命中；listing 体内 `sorry/admit` 0；渲染 PDF 中 `sorry` 4 次/`admit` 1 次**全在否定式披露句**（上下文逐条核读）。
- **c9 逐字 diff**：**7/7 区块与源行段 BYTE-IDENTICAL**（6/25/24/2/1/8/8 行）。
- **数值复算**：由两条 def 作定义迭代至 n=401——`a3 mod 2`＝(0,0,1,1,0,0)、`a3 mod 8`＝(2,2,3,7,2,6,0,0,7,7,0,0)、`a4 mod 2`＝(1,0,1,0,0)、`a4 mod 4`＝(3,0,3,0,0,1,2,3,0,0) 与 `claim.tex:221-224` 全同；T1–T4 全窗口为真；周期 6/5/12/10 成立且**无更小周期**（n≤400）；序列头部 8/6 项与 `c9-record` 送检串逐位同。**截断减法对照测**：两种结合顺序下 ℕ-monus 与 ℤ 语义在 n≤300 **零分歧**（F3 依据）。
- **门①②复跑**：`bash scripts/paper-lint.sh claims/notchgrid-parity-mod/claim.tex`（仓库根）→ **PASS exit 0**；六轮 tectonic 日志 exit 0、页数 14/11/12/12/12/12、`Missing character` 各 0、Overfull 8/9/2/0/0/0（去重口径）、`claim.pdf` PyMuPDF **12 页**、`??` 0、`<<` 0、`first`（打印文本）0。
- **书目在线复验（本审计自跑）**：`10.1007/978-3-030-79876-5_37` Crossref → "The Lean 4 Theorem Prover and Programming Language", LNCS, 2021, de Moura/Ullrich, pp. 625-635 ✓；`10.1145/3372885.3373824` → "The lean mathematical library", CPP'20, pp. 367-381, 2020 ✓；`oeis.org/A001353` HTTP 200，含 `4*a(n-1) - a(n-2)`、`0, 1, 4, 15, 56`、`Zucker`×2、`Castilleja`、`3 X (2*n-1)`、`packing a` ✓；`A210662` monomer/dimer/triangle ✓。`\cite` 4 键 ⊆ `\bibitem` 4 键，未被引的 `heilmann-lieb` 确未搬入。
- **包体量**：`zenodo/` **27 文件 / 341,133 字节**（audit 126,726 / claim 162,597 / proofs 43,400 / metadata 8,410）——与 `card.md:120`、`UPLOAD.md:36` 精确一致；`audit/` 与 `zenodo/audit/` 同名 15 件 `cmp` 全同。

## 审计耗材记账

llm-call **0**；Lean kernel 编译 **0**；LaTeX 编译 **0**（未跑 tectonic，未改 tex）；未写任何文件（本意见由主代理落盘）、未碰 `tasks/`、`papers/`、`verify-proj/` 构建三件套、`harness/config.json`。只读命令清单：`endpoint-detect.sh`、`ls/find/cat/head/tail/sed -n/wc/cut/paste`、`sha256sum`、`cmp`、`diff`、`grep`、`python -`（stdin 内联复算：listing 反抽、c9 区块 diff、余数表与周期性、monus 对照、PDF 文本抽取）、`bash scripts/paper-lint.sh`（静态，exit 0）、`curl --ssl-no-revoke`（6 次只读 GET：Crossref×2、OEIS×4，无任何上传/发帖）。

**主代理收尾指令（审计原述）**：本文件同步一份到 `zenodo/audit/claim-check.md`；`card.md`《成包状态》门③行与 `run-state.md` 的「成包待审计」状态改为「门③ 有发现 5 条（判据红），未通过，包不出仓；等待用户授权追加 LaTeX 轮次」；`F4` 若选 (a) 拷原件入包，须同步 `zenodo/metadata/README.md` 清单与 `UPLOAD.md` 的文件数/字节数。**不得把 F1–F5 中任何一条按 editorial 记账。**

---

## errata（2026-09-29，非门③裁决——署名 errata 记录，主代理落盘）

本节为 2026-09-29 署名 errata 的记录，不属于上述任何一轮门③裁决，裁决书本体（上文全部内容）一字未改。

- 触发：本包 PDF 标题页作者栏与 `metadata/zenodo.json` creators 均为占位符，而同期其余七包已按用户 2026-09-27 署名策略（＝账号名 `Aurora0134`）填实；本包随 batch 4（提交 `2fc1948`）公开，占位署名进入公开时间戳。根因：该策略未写入 SOP/模板/门判据（门③判据「无 PII」与「署账号名」方向相反，占位作者恒过门），批次间漂移。
- 授权：用户 2026-09-29 指令「确认，两部分一并做」批准 errata 方案全文（含第 10 轮改作 errata 轮、顶 10→11、第 11 轮预授权 DOI 回填；`budget-auth-4` 双写在案）。
- 处置摘要：作者栏按七包同款三行填 `Aurora0134`；披露句轮次实况同批改口；`zenodo.json` creators 填实 + orcid 占位键删除 + notes 改口；listing 七段复验 7/7 ALL BYTE-EXACT；lint 第 13 跑 PASS；编译第 10 轮 exit 0（12 页 / Missing 0 / Overfull 0 / `??` 0 / 128,545 字节）；manifest 重生成、zip 重打、两道 sanitize 门复跑全绿。逐项实况见 `card.md`《署名 errata》节、`audit/compile.txt` 轮次表第 10 行、`audit/lint.txt` run 13 块。
- 门③各轮裁决（含本文件正文与 `claim-recheck*.md` 三份）对当轮实况的记载一律按 append-only 历史留痕，不因本 errata 回改。
