# claim-check.md — 精简主张审计（SOP 08b 工序 5）· cyl3-mod23

- 审计：监察院 dept-audit 工人（只读，未重新编译、未动用预算，全部核查独立重跑），2026-09-27；主代理落盘本文件。
- **verdict: PASS（零 blocking 发现，占位质检门第三项通过）**；editorial 发现 2 条（E2 已修复、E1 留档，见下）。
- 质检门全貌：①paper-lint exit 0（`audit/lint.txt`）✓ ②paper-compile tectonic exit 0、10 页、`Missing character` = 0（`audit/compile.txt`）✓ ③本审计 PASS ✓。

## 逐项裁决（审计原文要点）

1. **锚点一致性 PASS**：2 条 `% LEAN:` 锚点（cyl3_master@c​laim.tex:118 / cyl3_matrix_family@:135，grade=完全证明）；sha256 三 MATCH（p1=4740b9d5…e733bc、p2=8cac6fa4…c1d7fe、final=566e9e1d…c5ae8）；终审裁决「签发、四项核查全过」在案；0 sorry 全文扫零命中；公理 ⊆ 白名单。
2. **措辞双上限 PASS**：无强于完全证明/查无占位表述；三族孔位缺陷序列=递推恒按「OEIS/文献背书 + n≤14 计算猜想层」降级表述，未写成 kernel 已证计数本体；Novelty 节逐命题裁决与 c9-record 一致（A 查无占位·成立并加固 / P1 新序列级伴随观察 / P2 库引理级首个形式化 / P3 文献已占位非本笺贡献）；四处残余缺口与闸门四状态如实披露。
3. **listing 逐字节 PASS**：审计独立 cmp——行 130–132 == 04-statement-p1.lean[11–13]（182B IDENTICAL）、行 147–152 == 04-statement-p2.lean[13–18]（310B IDENTICAL）、行 166–234 == 04-proof-complete.lean 全文 69 行（4008B IDENTICAL）。
4. **预算数字 PASS**：披露节与两本账逐笔一致（源任务 llm 1/6、compile 12/24、diag 0/4、论文慢车道 latex 6/10；本阶段 llm 0/4、LaTeX 5/6）。
5. **披露齐全 PASS**：四要素在文；作者栏 = 网名 Aurora0134；AI 非作者两度声明；无 PII；无占位符残留。
6. **C9 记录在包且逐字 PASS**：zenodo/audit/c9-record.md 正文与源 recheck/04-cylinder-3holes-exclusivity.md 101 行 cmp IDENTICAL；头部出处注记与文末证据路径清单为封装方明示添加，正文零改写。

附项 PASS：zenodo.json（Aurora0134、无 orcid、isIdenticalTo→GitHub 镜像）；proofs/ 四件与源 cmp 全同；claim/ 三件 cmp 全同；bibliography 与 papers/cyl3-mod23/paper.tex 逐字节一致（复用已核验书目）。

## editorial 发现与处置

| # | 发现 | 处置 |
|---|---|---|
| E1 | 披露节「60 retrieval requests」为 curl 口径（记录另载 FetchURL×3，明记不计 curl） | 留档不改：包内 c9-record 逐字在案、口径无遮蔽；本包 LaTeX 预算余 1 轮，不为措辞润色消耗 |
| E2 | UPLOAD.md 指引与包内实况脱节（占位符已不存在、作者栏已填网名） | **已修复**（三处改写为实况指引，2026-09-27 主代理执行） |

## 限定语（审计要求照录）

两定理分级 = 完全证明；C9 = 查无占位（残余缺口：知网未测 / S2 429 一次 / zbMATH 3 条掩码 / 通用 web 层降级）；DOI 为预留设计（外发时用户回填）；组合语义（缺陷序列↔递推）为 OEIS/文献背书 + 计算猜想层，非 kernel 已证内容；源任务 report.md 文件头仍「待签发」，本包按用户 2026-09-27 指令启动（卡面在案）。

## 补记（主代理，2026-09-27 审计后卫生处理）
审计归档后，主代理对三包 claim.tex 做行尾归一（本文件对应包：补丁注释块等处原有 CRLF 471 处已剥除为 LF；listing 体本就 0 CR）。归一后 listing 逐字节复核 logs/claim-listing-verify.py 仍 OVERALL PASS；zenodo/claim/ 与快照树副本已同步。纯卫生项，不影响任何裁决。

## 勘误追记（2026-09-28，用户裁决「改模板＋回补首批公开包」）

- 本包 `claim/claim.tex` 的 \texttt{lean4} 条目原引 DOI 尾号 \texttt{_27}，经 Crossref **题名**实测为同卷另一篇「An Automated Approach to the Collatz Conjecture」pp. 468--484；正确尾号 \texttt{_37}（「The Lean 4 Theorem Prover and Programming Language」pp. 625--635，与条目已写的 LNCS 页码互证）。该错引来自 \texttt{harness/templates/claim/claim.tex} 预置书目（模板同源缺陷同日已修）。
- 修法＝只改 URL 尾号，**不改任何证明层内容**：三/两条定理的逐字 listing、公理打印、C9 记录、分级措辞全部不动；复编后页数 **10 页不变**（与本轮审计已核的页数口径一致，故先前逐页核验仍然有效），\texttt{paper-lint} PASS exit 0、缺字 0、无未解引用。
- 落点：`claims/cyl3-mod23/claim.tex` 与包内 `zenodo/claim/claim.tex` + `claim.pdf` 同批更新（同哈希），并以镜像仓追加提交回补公开件；原 `c5865c0` 时间戳与版本链不动（SOP 08b「不撤包、版本机制保留原时间戳」）。
- 〔源仓对齐注记（2026-09-29 主代理补录）〕本节为镜像仓公开件（提交 `8a01a5c`）既有勘误记录的逐字回填——源仓 deliverable 副本当日漏同步，本批补齐，两处文本现一致。

## 勘误追记二（2026-09-29，用户指令「授权确认，继续项1,3」＝回补已公开件；仓库级五门存量红修复）

- **触发**：2026-09-29 `scripts/sanitize-package.py` 对 batch1/2 四包首跑，本包 5 条存量红：claim.tex「see UPLOAD.md in this package」×1；`metadata/README.md` 裸指称源仓件未写明「源仓/不随包」×3（`claims/cyl3-mod23/UPLOAD.md`、`tasks/20260926-cyl3-pipeline/report.md`、`claims/cyl3-mod23/card.md`）；`metadata/FILE-MANIFEST.txt` 缺失 ×1。
- **修法**（零证明层触碰）：①claim.tex 改 "in the source repository"；②README 三处按 pendant 绿包同款补「源仓 deliverable 目录的…（不随包）」明示；③FILE-MANIFEST 生成 + README 内容表补对应行。
- **重编 2 轮**（措辞渲染验证 + 披露数字嵌入终编）：均 exit 0、10 页不变、Missing character 0、paper-lint PASS；PDF 文本 diff 仅 Data availability 句与披露节 LaTeX 轮次 5→8 两处。
- **披露节订正**：LaTeX 轮次 5→8（2026-09-28 DOI 勘误轮 +1 当时未同步披露节，本批一并订正；本批 2 次编译）；账本 budget-auth 行 + 卡面《预算顶》双写。
- **门复跑**：五门全绿 exit 0（scanned 11 + declared 8 = 19 = 存缴树实测）。
- **外发**：随 batch1/2 errata 提交推送镜像仓（提交号/ls-remote 见 `claims/.mirror-errata-20260929.log`）；原 `c5865c0` 版本链不动。
