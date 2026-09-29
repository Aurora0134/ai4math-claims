# 占位精简主张审计记录 claim-check.md — claims/pendant-ladder-interleave/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限），单轮针对本包；本文件由派发方（论文部工人）按裁决回交原文落盘并追加处置节。
> **状态：第一轮「1 条必修（F1）+ 3 条建议（O1–O3）」→ F1/O1/O3 已全部真修并复核转绿，O2 为流程提醒（打包纪律，已按之执行）。当前占位质检门三格：①②绿（审计复跑确认），③ = 发现已全部闭环且逐条附证据。**
> 审计自耗：llm-call 0 / Lean 编译 0；端点 kimi（会话内工人）。
> 裁决时快照：`claim.tex`（F1 修复前）经 `inspect-tex.py --verify` 追加一致记录；修复后 claim.tex/claim.pdf 已重编并同步入包（见第三节）。

## 一、六项核对（审计独立复算，未采信生成方自报件）

| # | 核对项 | 裁决 | 证据 |
|---|---|---|---|
| 1 | 四条 `% LEAN:` 锚点 → 声明名 / 分级 / 源任务 + 哈希 | PASS | 锚点恰 4 条（claim.tex:128/184/215/241），声明名/源目录/grade=完全证明 与 `tasks/20260927-mossad-pend/audit/final-01-pend.txt` 一致；审计自算 sha256：statement=`78bccc97…f922`、final=`be3f31cb…2540b`，与任务档案一致，包内 `zenodo/proofs/` 两件同哈希；113 / 259 行 |
| 2 | 措辞 ≤ 分级 且 ≤ C9 + 占位围栏 | PASS（F1 例外，见第二节） | 围栏随 abstract/Statement/Novelty 三处携带 A386889（Dresden & Demirkol 2025-09-04）；「new sequence」仅两处均为否定句；T3 订正后形态坐实且 Scope (b) 明令旧口径作废；组合桥在 `conjecture` 环境并带统一挂侧约定与交替分歧数据；「minimal」均带 L5 限定；C9 四态裁决照抄；无任何「已推送/已上传/镜像存在/时间戳已生效」越权表述 |
| 3 | 五处 lstlisting 逐字节 | PASS | 审计复跑 `inspect-tex.py --verify` → 5/5 PASS；另自写抽取器独立比对 S1=L27-68 / S2=L71-89 / S3=L92-106 / S4=L109-112 / 终稿 L1-259 → 5/5 BYTE-EXACT；公理块与 `final/axioms.out` 逐字一致；冻结件 5 处字面 sorry 全部在摘录区间外 |
| 4 | 预算与节点口径 | PASS | 短笺披露 llm 2/8、compile 20/24 = 源 `budget.log` 终态；本阶段 llm 0/4、LaTeX 4/6（终态 5/6，见第三节）、Lean 0，均在卡顶内 |
| 5 | 披露四要素 / 作者栏 / PII / 元数据 | PASS | 四要素 + CRediT 齐；作者栏占位符文本、AI 未进作者栏；zenodo.json 合法 JSON、creators 占位、无伪造 orcid 键；全文及包内 0 邮箱 0 真实人名；`<<`/TODO 残留 0 |
| 6 | c9-record.md 在包且逐字一致 | PASS | `build-c9-record.py --check` 复跑 → 4/4 PASS（757/363/10661/2448 字节与文末自检表一致）；审计自算源 chunk-F.md sha256=`2067ce90…61cf` 与头注一致；打包者注记头含 L27 交替挂法旧说证伪更正指针；记录正文 4 段逐字、结论未改写 |

## 二、第一轮发现与处置

| # | 级别 | 工序 | 发现（审计实测） | 处置 |
|---|---|---|---|---|
| **F1** | 必修 | 装配 | claim.tex:582-583 称公理侧车「the four lines above are its whole content」，实物 `zenodo/audit/audit-axioms-sidecar.log` = 3 行头注 + 4 行公理输出——「whole content」量化失实（README 已如实写明加头注重建，短笺与之自相矛盾；类先例 F3/R-2 证据件描述红线） | **已真修**：改为「the four lines above are that log's payload; the shipped copy adds a three-line provenance header, and the audit's re-run axioms-recheck.out is byte-identical to the task's own axiom printout」；重编一轮（LaTeX 5/6）exit 0、16 页、Missing 0、Overfull 0；lint PASS；listing 复验 5/5 逐字节；包内 claim/ 同步 |
| O1 | 建议 | 立项卡 | card.md 自承诺「终值编译后如实回填」页数，仍写「预计 ~10+ 页」 | **已真修**：card.md 页数口径行回填终值 **16 页**（显式豁免，与 README 互为出处） |
| O2 | 提醒 | 打包 | claim-check.md 拷入后必须重生成 FILE-MANIFEST + 重建 zip（先例 R-3 件数教训） | 派发方按此执行：本文件拷入 `zenodo/audit/` 后重跑 `sanitize-package.py`（manifest）与 `make-zip.py`（29 条目 = 清单 28 + 清单自身）并以 `--check-only` 复核 |
| O3 | 建议 | 措辞 | abstract 首句以组合定义引入 a(n)，conjecture 限定靠 Introduction/Conjecture/Scope 三层承载，abstract 内未随文；未构成越级，但摘要先行限定最稳 | **已采纳**：abstract 末加「The combinatorial identification of the sequences with matching counts is not kernel-proved and is stated as a conjecture.」（与先例同款式随文限定） |

## 三、追加结构核查（审计复跑 + 处置后状态）

- 静态门①：审计复跑 `bash scripts/paper-lint.sh claims/pendant-ladder-interleave/claim.tex` → PASS exit 0；修复轮后再次 PASS（`audit/lint.txt`）。
- 编译门②：`audit/compile.txt` 末轮 exit 0、**16 页**、`Missing character` 0、`Overfull` 0、无未解引用；tex/pdf/包同一轮（修复后轮次字节数与包内 cmp 一致）。LaTeX 编译轮终态 5/6。
- 包体：四目录齐；`zenodo/claim` 三件；`zenodo/proofs` 三件（含 lean-toolchain = `leanprover/lean4:v4.34.0`）；zip = 29 条目（28 件 + manifest 自身）。
- 脱敏复扫：`sanitize-package.py` 无本机路径 PASS；审计另扫 zip 全文账号片段 0 命中。
- 承诺对账：拷入本件前 sanitize 唯一未命中 = README 的 `audit/claim-check.md` 行（预期态）；本件拷入 + manifest 重生成后 `--check-only` 三格全绿（见元数据复核行）。
- 参考文献六条 ↔ `audit/bib-verify/` 回包一一对应；lean4 尾号 **_37**（题名/页码 625-635 核到 Crossref 回包；模板旧 `_27` 缺陷未沿用）。
- 闸门四双口径（report.md 文件头「待签发」vs 用户指令当场行使）写入短笺 Scope (f) 与 card.md，如实分列，判可接受非否决（先例同口径）。

## 四、审计声明的「核不动 / 未核」

1. 审计未重跑 tectonic / 未编 .lean：「完全证明」锚定源任务闸门二/三档案（包内副本与源逐字节一致已核）；tex/pdf/包同步性以字节数与 cmp 间接裁定。
2. OpenAlex 429 与通用网页层历史读数不可复现（C9 记录与短笺均写「未验证」，审计核到记录文本）。
3. OEIS 关键词「无关噪声」判读属 C9 工人判读；短笺查新表各行数字与 chunk-F 正文逐格对读一致。
4. claim.pdf 字形渲染未逐页目检，仅核日志指标（16 页 / Missing 0 / Overfull 0）。

## 五、终态

- 门① paper-lint PASS exit 0（裁决轮 + 修复轮各复跑一次）。
- 门② paper-compile exit 0，16 页，Missing 0，Overfull 0，LaTeX 轮 5/6。
- 门③：F1（必修）真修并复核；O1/O3 采纳；O2 流程执行。**零未闭环发现。**
- 分级上限：完全证明×4；价值级 new sequence / new recurrence（附占位警示）；组合桥 conjecture；交替挂法旧说已证伪；T3 订正后形态；最小周期 L5 口径；novelty = 负检索证据 + A386889 占位围栏（OpenAlex 429 未验证、通用网页层无读数、未检中文库）。
- 外发状态：**仅出包**——GitHub 推送未授权未做（无 isIdenticalTo、无镜像承诺）、Zenodo 未上传（DOI 未预留）、OEIS 未提交（提交侧未实测 + A386889 侧禁重复登记围栏见 UPLOAD.md 第 3 步）。本包暂不持有公开时间戳。

## 六、errata（2026-09-29，用户指令「确认，两部分一并做」）

- 发现：本包 PDF 标题页作者栏为占位符（[author name placeholder] 形态），而包内 metadata/zenodo.json creators 已于 2026-09-28 推送前 errata 填为 Aurora0134——包内两处署名口径不一致，且 PDF 已随 batch 3 公开推送（提交 eb9b15e），占位署名进入公开时间戳。根因：署名策略（用户 2026-09-27 指令＝账号名 Aurora0134）未写入 SOP/模板/门判据，装配批次间漂移；机制层收敛另行落盘。
- 处置：claim.tex 作者栏按 batch 1/2/4 同款三行格式填 Aurora0134（其余字节不动，五处 listing 复验 5/5 PASS）；重编译第 6 轮 exit 0（16 页、Missing 0、Overfull 0，LaTeX 轮 6/6 顶内）；audit/compile.txt、lint.txt、listing-verify.txt 刷新并同步包内副本；FILE-MANIFEST 重生成（28 件）、zip 重打（29 条目）、sanitize --check-only 三格全绿。镜像仓追加 errata commit（提交号见 card.md「GitHub 快照」节补记）。
- 附注一：本文件「五、终态·外发状态」行写于推送前，已被 2026-09-28 batch 3 实际推送超越（实况见 card.md），历史留痕不回改。
- 附注二：audit/inspect-tex.py 的记录头日期为脚本内写死值；本次复验实际执行于 2026-09-29，listing-verify.txt 第 41 行记录头已人工订正为 2026-09-29（工具本体未改）。
