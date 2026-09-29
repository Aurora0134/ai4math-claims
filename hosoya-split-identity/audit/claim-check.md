# 监察院精简主张审计裁决 · claims/hosoya-split-identity（SOP 08b 工序 5；占位质检门③）

> 2026-09-29 监察院 dept-audit 工人回交，主代理转录落盘（内容逐条照回交原文）。
> 审计对象：`claims/hosoya-split-identity/` 包（claim.tex + zenodo/ 树）；源任务 =
> `tasks/20260929-l14c-graphside-pipeline/`（Phase 0 两受审定理）。

## 六项逐项判决

**1. %LEAN 锚点 + 冻结快照 + 分级证据 — PASS**
- `grep '^% LEAN: '` 恰得两条：claim.tex:160（hosoya_deleteEdge_split_pts grade=完全证明）、claim.tex:244（hosoya_prism_split_spoke grade=完全证明），与卡面定理清单一致。
- sha256 复算：源任务 `formalized/statement.lean` = `d186ff16…7ca39e`，与卡面给定值逐字符一致；包内 `zenodo/proofs/01-hosoya-split-statements.lean` 同哈希（cmp 逐字节一致）。终稿 `attempts/phase0/r2/split-identity.lean` = `d2efac51…6b016`，包内 `01-hosoya-split-proved.lean` 同哈希。
- 审计证据存在：`tasks/20260929-l14c-graphside-pipeline/audit/final-01-hosoya-split.txt` 三行式总裁决（98–104 行）明载两定理 = **完全证明**、全案最低级 = 完全证明（范围限两受审 theorem）、axioms 白名单子集、strict exit 0。

**2. 措辞强度 ≤ 监察院分级 且 ≤ C9 裁决 — PASS**
- 全文无「新数学」断言：仅出现否认句（:111 "never as new mathematics"、:136 "no claim of new mathematics"、:782 "not asserted as such"）。
- 两桥定理及装置零出现：`hosoya_prism_del_spoke / hosoya_prism_del_rim / aspoke / arim / prismDelRim` 在 claim.tex 中出现次数 = 0；正文提到母体桥定理处（:261–266、:829–834）均为「not results of this deposit / stated with sorry / proof phases in progress」的划界句。listing 摘录止于基座定义（45–62 行），冻结 statement 中三处 sorry 字样全部落在摘录外（listing-verify 记录在案）。
- "first formalisation" 三处均限定在 Lean/形式化生态层：abstract :110–111 "first Lean formalisation of a known classical tool"、intro :135（前句 :132–134 明示 "no Lean formalisation … in the public ecosystem"、"mathlib has no matching-count API"）、novelty :781 "first formalisation (Lean three-layer zero same-form)"，与 c9-record.md provenance 头注裁决原文（查无占位·可达通道口径 / 母题价值级 new sequence / 图侧桥 first-formalisation）逐义一致，无越级。

**3. lstlisting 逐字节比对 — PASS**
- `cmp` 判定：`zenodo/proofs/01-hosoya-split-proved.lean` vs `attempts/phase0/r2/split-identity.lean` **IDENTICAL（含 CRLF，双方均 CRLF）**；`01-hosoya-split-statements.lean` vs `formalized/statement.lean` **IDENTICAL**。
- `bash claims/hosoya-split-identity/audit/inspect-tex.py --verify claims/hosoya-split-identity/claim.tex`：三处 listing 全 PASS（statement 45–62 / general lemma 215–259 / 全文 1–429），exit 0。**注：审计触发了该命令，它按设计追加了审计记录到 `claims/hosoya-split-identity/audit/listing-verify.txt`**（brief 内唯一允许的写；文件中可见追加块，source sha256 双值与本次复核一致）。LF 归一在卡面、budget.log、listing-verify 头注三处均已披露，`proofs/` 内为逐字节 CRLF 原件。

**4. 预算数字照抄 — PASS**
- claim.tex :869–876 与源任务 budget.log 收口行（18:16，第 25 行）逐项对照：wire-id `anthropic/stepfun/step-5-preview` ✓、agent-run **2/6**（r1 exit 3 不计，r1b + r2 = 2）✓、compile 正式 **3/36** ✓、llm-call **8/8 = 4 成功 roundtrip + 4 失败** ✓（budget.log :12 llm-call 累计 4/8、llm-call-fail 4）。本包 llm **0/4** 与 `claims/hosoya-split-identity/budget.log` 终态行一致。
- 观察一笔（非违规，不需返工）：claim.tex 披露节未携带打包会话自己的 LaTeX 轮数（包 ledger 实况 latex 7/10，claims/hosoya-split-identity/budget.log）。SOP 08b 披露四要素的预算表是「照抄**源任务** budget.log」，本包 LaTeX 顶的记账义务在 claims 侧 ledger 已尽，短笺内不载不构成违规，仅记录在案。

**5. 披露四要素 + 作者栏 + PII — PASS**
- 四要素齐全（claim.tex :862–880）：(a) AI 环节枚举、(b) 模型-节点-预算（wire-id + 数字照抄台账）、(c) kernel 终裁声明（0 sorry + axioms 白名单）、(d) "The AI system is not an author; the human author … is responsible for all content"。
- `\author{Aurora0134}`（:84，`thanks` 用 "placeholder --- to be filled in by the author" 合规措辞）；zenodo.json `creators[0].name = "Aurora0134"`、creators 无 ORCID 键（整键未出现）、AI 以 contributors "Other" 角色（非作者栏）披露——合署名条款三处口径。
- PII 扫描：全 shipped 树（zenodo/ + UPLOAD.md）无邮箱、无真实姓名、无可识别本机用户标识、无本机路径（sanitize 三门其一亦 PASS）；c9-record.md 内零命中。

**6. c9-record.md 在包且逐字一致 — PASS**
- `python claims/hosoya-split-identity/audit/build-c9-record.py --check`：**7/7 段 PASS，exit 0**（三源：L14C dossier 192 行 ×3 段 + 图侧增量 177 行 ×3 段 + confirm 47 行 ×1 段全部逐字在位）。只读执行，未触发写。

## 发现与处置（闭环记录）

- **F-1（须修，占位质检门阻断级）**：短笺与包 README 承诺随包携带的 5 件审计证据不在包内。claim.tex：762–765 明文 "Audit chain (originals in this deposit under audit/)：final adjudication final-01-hosoya-split.txt … statement-diff.out …"，:12 另承诺 audit/listing-verify.txt；README.md Contents 表五件同列。zenodo/audit/ 实际只有 7 件。sanitize promise 门因「解析到工作仓路径即放行」的宽口径未拦住。
  **处置（2026-09-29 主代理，本落盘同批）**：五件已拷入 `zenodo/audit/`（final-01-hosoya-split.txt 随包副本按脱敏规则把本机绝对路径前缀替换为 `<repo>/`（1 处替换、加 shipped-copy 注记头，工作仓原件保持原样；先例 pendant sidecar 同款处理）；statement-diff.out / listing-verify.txt / lint.txt / compile.txt 原样随包）→ sanitize 重跑 PASS（manifest 重写 21 件）。
- **F-2（须修，上载前必修，轻微）**：UPLOAD.md 未与 2026-09-29 署名条款及「无占位 DOI」现实同步（:20 替换 `<<RESERVED-DOI>>` 句、:26「包内一律是占位符」、:50「作者栏已填实」旧口径）。
  **处置（2026-09-29 主代理）**：三处按署名条款改「核对与包内一致（Aurora0134）」与「包内无 `<...>` 占位串」口径；DOI 回填点改为 card.md / metadata/README.md / run-state.md 三处（短笺无需重编）。
- **待决事项闭合**：`zenodo/audit/claim-check.md` = 本裁决书落盘件（本件即）；落盘后重跑 sanitize --check-only 与 make-zip。

## 总裁决

- 项1 PASS / 项2 PASS / 项3 PASS / 项4 PASS / 项5 PASS / 项6 PASS
- **overall = FINDINGS**（F-1、F-2 两条，均已按上处置修复；按 SOP 08b 失败处理规则，同一发现第 2 次出现才停线——本批属首轮发现即修）
- 修复后重审义务：主代理在claim-check.md 落盘同批重跑 sanitize --check-only（预期三门全绿）+ make-zip.py；如重审再现同型发现即停线报告用户。

## 附录：审计写操作披露

本审计仅触发一次允许写——inspect-tex.py --verify 向 claims/hosoya-split-identity/audit/listing-verify.txt 追加复核记录块；其余全部只读。