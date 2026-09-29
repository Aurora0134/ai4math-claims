# claim-check.md — 精简主张审计（SOP 08b 工序 5）· tatami-mod8-defect

- 审计：监察院 dept-audit 工人（只读），2026-09-27；主代理落盘本文件。
- **verdict: PASS（六项全 PASS，占位质检门第三项通过）**；editorial 发现 3 条，均已在归档前修复（见下）。
- 质检门全貌：①paper-lint exit 0（`audit/lint.txt`）✓ ②paper-compile tectonic exit 0、`Missing character` = 0（`audit/compile.txt`）✓ ③本审计 PASS ✓。

## 逐项裁决（审计原文要点）

1. **锚点一致性 PASS**：3 条 `% LEAN:` 锚点（tatami_mod8_period4 / bcorner_odd / bcorner_eq，grade=完全证明）；声明名在终稿实存（grep 行 59/87/108）；sha256 独立复算与卡面一致（statement 59560f57…82b187f、final b0f4a692…4789a1）；对称差状态机独立复演 59/59 字符级全同。
2. **措辞双上限 PASS**：无强于完全证明/查无占位的表述；组合语义始终按降级层（OEIS/文献背书 + 计算猜想层）表述，与终审措辞硬约束逐条吻合。
3. **listing 逐字节 PASS**：4 段 lstlisting 与冻结 final 对应行段（12–54 / 56–84 / 86–104 / 106–110）逐字节一致；P3 仅 statement 摘录已如实标注。
4. **预算数字 PASS**：披露节数字与两本账（claims/.../budget.log、tasks/20260926-beian-select/budget.log）逐笔对上；节点 wire-id 一致。
5. **披露齐全 PASS**：四要素在文；作者栏 = 网名 Aurora0134（合规署名策略）；AI 非作者；无 PII、无占位符残留。
6. **C9 记录在包且逐字 PASS**：zenodo/audit/c9-record.md 两源段与源档案 byte-equal。

附项 PASS：proofs/ 三件套与源 cmp 全同；zenodo.json creators=Aurora0134、无 orcid 键、related_identifiers 指 GitHub 镜像；0 sorry/admit 终稿复扫零命中。

## editorial 发现与处置（均已修复）

| # | 发现 | 处置 |
|---|---|---|
| E1 | 「12 件原始证据」计数笔误（实 14 件），三处 | card.md / budget.log / c9-record.md 注记行已改 14 件 |
| E1b | 原始证据目录指针悬空（未入包） | `audit/c9-recheck/`（15 文件 = summary + 14 件原始证据）已拷入 zenodo/audit/，指针现成立 |
| E2 | Novelty 节残余缺口漏「教学文献层未系统扫」一条 | claim.tex 已补该条 |
| E3 | audit/.seg-tmp/ 前序临时残留 | 已清理 |

修复后复跑：lint exit 0、compile exit 0（0 缺字）、listing-verify 4/4 PASS。预算终账：llm-call 0/4、LaTeX 6/6（触顶未超，如实记）。

## 限定语（审计要求照录）

三定理分级 = 完全证明（严格限于递推定义版整数序列，不覆盖组合计数语义；非脚手架通过）；C9 = 查无占位（命题层；残余缺口：知网未查 / Semantic Scholar 未复测 / 教学文献层未系统扫）；DOI 为预留设计（外发时用户回填）；本审计为只读文本核验，kernel/编译裁决引用既有闸门与门禁机读证据，审计工人未重新编译、未动用预算。

## 补记（主代理，2026-09-27 审计后卫生处理）
审计归档后统一行尾体检：本包 claim.tex 经字节级核查本就无 CRLF（0 处），归一操作零改动；listing 复核仍 OVERALL PASS。纯卫生项，不影响任何裁决。

## 勘误追记（2026-09-29，用户指令「授权确认，继续项1,3」＝回补已公开件；仓库级五门存量红修复）

- **触发**：2026-09-29 `scripts/sanitize-package.py`（仓库级五门）对 batch1/2 四包首跑，本包 5 条存量红：claim.tex「see UPLOAD.md in this package」（承诺随包但树内没有）×1；`audit/final-01-audit.md` 两处把 CRLF 字面与 budget.log 写在同一 60 字符窗口，被门 6 读成「budget.log 含 CRLF/混合行尾」（实测包外 CR=0）×2；`audit/c9-recheck/control-a180970.json` TAB 120 处 ×1；`metadata/FILE-MANIFEST.txt` 缺失 ×1。
- **修法**（零证明层触碰：proofs/ 冻结件、listing 字节、公理打印、C9 记录、分级措辞全部未动）：①claim.tex 改 "in the source repository"（notchgrid/pendant 绿包同款句式）；②final-01-audit.md「CRLF 归一」改「行尾归一」、缺陷①标签改「行尾归一化」、盘上 CRLF 改「盘上的 CR 字节」（事实不变：\r 计数 0、归一操作与哈希口径原样在档）；③JSON 按 2 空格缩进重排，数据逐字节等价（`json.loads` 相等性已验；包内外无该件哈希记录）；④FILE-MANIFEST 由 `--write-manifest` 生成（README 包结构行同步补件）。
- **重编 2 轮**（措辞渲染验证 + 披露数字嵌入终编）：均 exit 0、9 页不变、Missing character 0、paper-lint PASS；PDF 文本 diff（vs 提交 `4cf73841` 的旧 PDF）仅 Data availability 句与披露节 LaTeX 轮次 6→8 两处。
- **披露节订正**：LaTeX 轮次 6→8（本批 2 次编译 + 补记 2026-09-27 审计后 E2 重建轮 1 次未入账，账本 ledger-reconciliation 行在案）；账本 budget-auth 行 + 卡面《预算顶》双写。
- **门复跑**：`python scripts/sanitize-package.py claims/tatami-mod8-defect --scanned logs/gate-lists/… --skipped logs/gate-lists/…` → exit 0，五门全绿（scanned 21 + declared 10 = 31 = 存缴树实测）。
- **外发**：随 batch1/2 errata 提交推送镜像仓（提交号/ls-remote 见 `claims/.mirror-errata-20260929.log`）；原 `c5865c0` 时间戳与版本链不动（SOP 08b「不撤包」）。
