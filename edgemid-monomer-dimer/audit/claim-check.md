# claim-check.md — 精简主张审计（SOP 08b 工序 5）· edgemid-monomer-dimer

- 审计：监察院 dept-audit 工人（只读，未重新编译、未动用预算，全部核查独立重跑），2026-09-27；主代理落盘本文件。
- **verdict: PASS（六项全过，占位质检门第三项通过）**；editorial 发现 2 条（F1 已修复、F2 留档）；**强制限定语 1 条（LaTeX 7/6 超顶 +1），见末节**。
- 质检门全貌：①paper-lint exit 0（`audit/lint.txt`）✓ ②paper-compile tectonic exit 0、10 页、缺字 0、TeX 错误 0（`audit/compile.txt`）✓ ③本审计 PASS ✓。

## 逐项裁决（审计原文要点）

1. **锚点一致性 PASS**：2 条 `% LEAN:` 锚点（edgemid_master@:133 / edgemid_matrix_family@:144，grade=完全证明）；sha256 审计亲手复算三 MATCH（p1=f964ce71…27b27c56、p2=cf9e379a…99b6d5、final=1124e6a5…72c1d）；对称差亲手复跑 diff 双空；终审 verdict=pass、分级完全证明在档；0 sorry 亲手复证；公理 ⊆ 白名单与短笺 verbatim 块逐字一致。
2. **措辞双上限 PASS**：无越级词；语义桥降级照抄源口径（W/N1/EB0 递推属数值窗口证据 + OEIS/文献背书、kernel 未证计数本体，明示「the kernel proved no counting ontology」）；Novelty 节裁决与 C9 记录一致且自带「search evidence, not a claim to new mathematics」封顶；残余缺口三条（CNKI 未测 / S2 429×2 / Tzeng–Wu、Wu 原文未取）如实照抄；书目 11 键与占位卡锁定清单完全重合（复用已核验书目）。
3. **listing 逐字节 PASS**：审计独立抽取 lstlisting 体（claim.tex:176–241，66 行）与冻结 final 全文 diff 空、双侧均 2861B。
4. **预算数字 PASS**（含强制限定语，见末节）：披露节与两本账逐字对上（源任务 llm 0/6、compile 9/24、diag 0/4、节点 grok-4.7 快照一致；本阶段 llm-call 0/4）。
5. **披露齐全 PASS**：四要素全在；作者栏 = Aurora0134；AI 非作者双声明；无 PII；`<<` 残留零命中；DOI/ORCID 为外发时填实的设计内表述。
6. **C9 记录在包且逐字 PASS**：c9-record.md 与源 03-exclusivity.md 比对=两处纯增量（头部 3 行出处注记 + 文末 45 行证据路径清单），源文 67 行逐字未改。

附项 PASS：zenodo.json（Aurora0134、无 orcid、isIdenticalTo→GitHub 镜像）；proofs/ 四件与源 cmp 全同；claim/ 三件 cmp 全同；lstlean.tex == 模板逐字节一致（单一事实源合规）。

## editorial 发现与处置

| # | 发现 | 处置 |
|---|---|---|
| F1 | audit/listing-verify.txt 旁注「claim.tex CR count 0」口径不准（前部补丁注释块曾有 CRLF 37 处；listing 体 0 CR、独立 diff 复证成立） | **已修复**：旁注改为「listing 体 CR=0；前部注释块 CRLF 已归一」，claim.tex 已 LF 归一后 listing 复核仍 PASS（主代理 2026-09-27） |
| F2 | 引言句未内嵌各族递推起效下界（论文道有限定句） | 留档不改：与已三管齐绿的论文道引言同构、Scope 节整体降级封顶，审计明示不加亦可签发 |

## 限定语（必须披露，不属 PASS/FAIL 红线）

本包 LaTeX 质检门编译 **7 轮 / 顶 6 轮（+1 超顶）**：第 7 轮系 296s 断联后用户续跑指令明确授权的收官轮（按「修到缺字/错误双零、终编披露轮数取真实终值」执行），终轮 exit 0、缺字 0、TeX 错误 0，短笺披露节已嵌入真实终值 7。另有诊断性 tectonic 调用 5 次（probe×4 + tatami 对照重编×1）按双口径单列记账、未计入门禁轮数。工人自报『请主代理裁定追认或记降级』——本裁决书将 +1 如实记录，**超顶追认或降级记档的最终裁定权在用户**，已同步 run-state.md 待裁。

终审结论：签发（PASS）。分级裁定：完全证明（两定理各自），措辞未越级；新颖性措辞未越 C9「查无占位」。

## 勘误追记（2026-09-28，用户裁决「改模板＋回补首批公开包」）

- 本包 `claim/claim.tex` 的 \texttt{lean4} 条目原引 DOI 尾号 \texttt{_27}，经 Crossref **题名**实测为同卷另一篇「An Automated Approach to the Collatz Conjecture」pp. 468--484；正确尾号 \texttt{_37}（「The Lean 4 Theorem Prover and Programming Language」pp. 625--635，与条目已写的 LNCS 页码互证）。该错引来自 \texttt{harness/templates/claim/claim.tex} 预置书目（模板同源缺陷同日已修）。
- 修法＝只改 URL 尾号，**不改任何证明层内容**：三/两条定理的逐字 listing、公理打印、C9 记录、分级措辞全部不动；复编后页数 **10 页不变**（与本轮审计已核的页数口径一致，故先前逐页核验仍然有效），\texttt{paper-lint} PASS exit 0、缺字 0、无未解引用。
- 落点：`claims/edgemid-monomer-dimer/claim.tex` 与包内 `zenodo/claim/claim.tex` + `claim.pdf` 同批更新（同哈希），并以镜像仓追加提交回补公开件；原 `c5865c0` 时间戳与版本链不动（SOP 08b「不撤包、版本机制保留原时间戳」）。
- 〔源仓对齐注记（2026-09-29 主代理补录）〕本节为镜像仓公开件（提交 `8a01a5c`）既有勘误记录的逐字回填——源仓 deliverable 副本当日漏同步，本批补齐，两处文本现一致。

## 勘误追记二（2026-09-29，用户指令「授权确认，继续项1,3」＝回补已公开件；仓库级五门存量红修复）

- **触发**：2026-09-29 `scripts/sanitize-package.py` 对 batch1/2 四包首跑，本包 7 条存量红：claim.tex「see UPLOAD.md in this package」×1；`metadata/README.md` DOI 段裸指称 `../../UPLOAD.md` ×1；`audit/final-audit.md` 裸指称源仓件（`audit/welldef-verdict.md`、`report.md`）×2；`audit/final-audit.md` 与 `audit/listing-verify.txt` 行尾声称措辞（CRLF 字面与具名文件同窗口，实测存缴侧 CR=0）×2；`metadata/FILE-MANIFEST.txt` 缺失 ×1。
- **修法**（零证明层触碰）：①claim.tex 改 "in the source repository"（同行重排保证门按行判读成立）；②README 补「in the source repository … not shipped with this deposit」；③final-audit.md 两处补「源仓文件，不随包」明示（含具名问题节首处 report.md）；④行尾措辞订正为「无 CR（回车符零个）」/「行尾已归一为 LF（无 CR）」——与 papers 侧同件（`papers/edgemid-monomer-dimer/zenodo/audit/final-audit.md:14`）2026-09-29 已落地的修法逐字同款；⑤FILE-MANIFEST 生成 + README metadata 行补清单件。
- **重编 2 轮**（措辞渲染验证 + 披露数字嵌入终编）：均 exit 0、10 页不变、Missing character 0、paper-lint PASS；PDF 文本 diff 仅 Data availability 句与披露节 LaTeX 轮次 7→10 两处。
- **披露节订正**：LaTeX 轮次 7→10（2026-09-28 DOI 勘误轮 +1 当时未同步披露节，本批一并订正；本批 2 次编译）；账本 budget-auth 行 + 卡面《预算顶》双写。
- **门复跑**：五门全绿 exit 0（scanned 14 + declared 8 = 22 = 存缴树实测）。
- **外发**：随 batch1/2 errata 提交推送镜像仓（提交号/ls-remote 见 `claims/.mirror-errata-20260929.log`）；原 `c5865c0` 版本链不动。
