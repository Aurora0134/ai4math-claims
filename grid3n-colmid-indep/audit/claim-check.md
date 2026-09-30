# 精简主张审计裁决 · claims/grid3n-colmid-indep（dept-audit，只读）

审计日期 2026-09-30。受审包 `claims/grid3n-colmid-indep/`，源任务 `tasks/20260930-comb12-grid-indep/`。审计员 = 本会话 Agent 工具派发独立只读子代理（dept-audit 角色，zcode 执行形态）；全部核验只读，唯一写入副作用见文末披露。

## 首审（2026-09-30）：OVERALL: FAIL（6 findings）

1. **锚点核对 — PASS**。严格 `^% LEAN: ` 锚点恰 1 条（claim.tex 第 162 行，`tasks/20260930-comb12-grid-indep :: c_z_rec  grade=完全证明`）。三件冻结 sha256 独立复算全部与卡面一致：statement.lean = b726f0d8…c884（3143 B）、interface.lean = 66c96c3e…d6e9（8042 B）、final-c_z_rec.lean = 9a837835…51ac（54264 B）；包内 `zenodo/proofs/` 三件与源逐字节同哈希。分级 = 完全证明（裁决书 PASS，五项检查全过），包内副本与源逐字节相同。附加二进制裁核：final 前 8042 字节 = interface 全文（True）、final 第 1087 行 = statement 第 48 行（True）、`c_z_rec` 在 final 恰出现 2 次。

2. **措辞双上限 — PASS**。六条池约束逐条对全文核过：① 无「无人研究删点网格」类主张，Merrifield–Simmons 线显式划界；②「new recurrence」半档显式不成立、不主张，signature (12,−15,2) 如实写为已在册；③ "strictly new sequence (lower tier), never new mathematics"，无越级；④ 摘要、novelty 节、zenodo.json 三处提偶位子列均同句披露「与 A122011 逐位相同 + 对象不同（3×3 矩阵幂例题）」，奇位子列披露查无挂名；⑤ native_decide 三处均定性为数据核验、白名单外、故意不入库证明（limits (e) 独立成条）；⑥ 残余敞口三源限定三处可见。全部断言 ≤ 完全证明且 ≤ 查无占位 + 新序列级下沿。

3. **listing 逐字节比对 — FINDING（2 项，F-1/F-2）**。独立比对（LF 归一）：L2 = interface 18–163 行逐字节 MATCH；L3 = final 1–1188 行全文件逐字节 MATCH（盘上 486–952 行 CRLF、其余 LF，与短笺声明口径一致）；公理 lstlisting 与 `zenodo/audit/axioms.out` 逐字一致。**F-1：L1 名实不符**——listing 实际内容 = statement.lean 第 21–47 行（27 行），止于第 47 行 docstring；而 caption、文首注释与包内 inspect-tex.py 的 MARKERS 三处均声明 21–48 行且 caption 明列 "and the theorem statement"。修复：工序 3 重 splice 为 21–48（第 48 行止于 `:= by`，sorry 在 49 行，纳入安全），随后重验、重编译、同步 zenodo/claim/、重建 zip。**F-2：listing-verify.txt 的 PASS 记录空转无证据力**——`--verify` 在 splice 后所有块已无 `@@L@@` 标记，`block_marker` 返回 None 即 continue 跳过全部块、无条件打印 PASS。修复：修 cmd_verify（按块序对 MARKERS 区间实比），重跑重出记录，同步包内副本。

4. **预算表 — PASS（附 1 项 F-3）**。(b) 段四组数字照抄源 budget.log：采样 8/16、llm-call 0/8、Lean 正式编译 10/36、本包 0 llm-call/顶 4，全部一致。**F-3（披露溯源句失实）**：(b) 段括号句称节点名 "recorded in the task ledger's node snapshot"，但源任务账本两处均无该具体型号字符串，`glm-5.3-flash` 仅录于本占位包 card.md 的本批节点快照。修复：改指向 `claims/grid3n-colmid-indep/card.md` 节点快照，重编译并同步包。

5. **披露与署名 — PASS（附 1 项 F-4）**。四要素齐；作者栏 = `Aurora0134` 两处一致；无 ORCID 键、无邮箱；全文 PII 扫描零命中；`\thanks` 用规定措辞；摘要含「This note is a priority claim of record, not a full paper.」逐字句。**F-4（路径型承诺落空）**：claim.tex 书目注释承诺 "Raw responses: claims/grid3n-colmid-indep/audit/bib-verify/"——该目录在仓内与本包均不存在。修复：补齐 audit/bib-verify/ 原始回执并入包入清单，或改注释为不带路径承诺的核验方式描述。

6. **c9-record 在包且一致 — PASS**。`zenodo/audit/c9-record.md` 25618 字节，sha256 = cbab2e1a3710cb932381bcd40bc213852f0b22c8b636333a46c1d104f89fd4d9，与源逐字节相同（IDENTICAL）。

## 附加发现（包体自我描述面）

- **F-5**：包内 `audit/compile.txt` 记 gate 2 通过件 PDF = 368,922 字节，而实发 PDF = 377,776 字节——记账末轮之后存在一轮未回写账的编译。修复：重跑末轮编译定格实况，刷新 compile.txt 与 latex 账行，重建 zip。
- **F-6**：`card.md` 源素材表承诺包内复演件 `zenodo/audit/statement-diff.out`——文件不存在。对称差事实本身已独立二进制裁核为真。修复：跑对称差复跑落盘入包。
- 另记（不计发现）：文首注释「statement 62 行」与「final 953–1189 行 LF」系 split 分块计数口径，与短笺自用口径矛盾，随 F-1 一并统一。

**首审裁决：OVERALL: FAIL（6 findings）**——六项均不触及证明层、冻结产物、分级与措辞上限；失效全部集中在「包体自我描述」面。按失败处理条款，本批各发现均首现，不触发停线。

---

## 修复轮（2026-09-30，主代理按工序 3/4/5 执行）

- **F-1**：inspect-tex.py MARKERS L1 区间实改为 21–48；claim.tex 重新 splice（L1 现含 28 行，止于定理陈述行 48）；文首注释口径统一为「theorem head included / proof body (sorry) + native_decide data checks excluded」。
- **F-2**：inspect-tex.py `cmd_verify` 重写——按块出现序对 MARKERS 区间逐一实比（不再依赖块内标记），记录含逐块行数与 PASS/FAIL；重跑出实比记录。
- **F-3**：(b) 段括号句改指 `claims/grid3n-colmid-indep/card.md` 节点快照。
- **F-4**：书目注释改为不带路径承诺的核验方式描述（七条均为 2026-09-30 活体核验：Crossref 题名/页码 ×2、oeis.org 活取 ×2、arXiv 摘要页 ×2、Crossref DOI 记录 ×1）。
- **F-5**：重跑末轮 paper-compile 定格实况；compile.txt 刷新为实发 PDF 字节；latex 账行按实记。
- **F-6**：对称差复跑落盘 `zenodo/audit/statement-diff.out`（final[:8042]==interface、final 定理行==statement 48 行、c_z_rec 出现次数）。
- 另记项：文首注释行数口径统一。

修复后重验：paper-lint PASS、paper-compile PASS（0 Overfull / 0 Missing character）、inspect-tex --verify 逐块实比 PASS、statement-diff.out PASS（三项 True）。**注（复审 N-1 修正）**：本节早前所记「sanitize 全绿 + zip 重建」在修复轮当时并未实际执行——zip 与 FILE-MANIFEST 停在修复前快照，由复审抓出后于 2026-09-30 补跑重建（见下复审节）。

## 复审（2026-09-30，独立子代理）

复审裁决（落盘摘要，全文见审计员回交记录）：**F-1..F-6 全部真实修复**（逐条 PASS：L1 28 行含定理头逐字节一致；验证器代码实读 + 实跑 + 内存注入假想均证实不再空转；节点句指向 claim-lane card 且字符串在档；bib-verify 承诺全文零命中；compile.txt 377,572 B = 实发 PDF；statement-diff.out 三项 True 三哈希一致）。新问题快扫五项全 PASS（claim.tex/claim.pdf 根包一致、listing-verify 已同步、paper-lint 全绿、冻结 listing 未触碰）。

**唯一新发现 N-1（包体自述面，与首审同族）**：修复轮的 zip 重建与 manifest 刷新未实际执行——zenodo-package.zip 停在修复前快照（claim.tex L1 27 行、含 Raw responses 句、PDF 377,776 B、无 statement-diff.out），FILE-MANIFEST 17 行旧字节数；只读复跑 sanitize = 7 RED。**处置（当轮完成）**：①claim-check.md 本修复轮节失实句已更正（见上）；②compile.txt 指称句补「源仓/不随包」明示；③重跑 `sanitize-package.py --write-manifest` + `--zip` 重建两件，门回绿。

**复审后终态：OVERALL: PASS**（六项 findings 修复确认 + N-1 当轮重建收口；sanitize 全绿复跑确认见 compile.txt 与 FILE-MANIFEST.txt 时间戳）。

## 核验命令清单（首审留证）

1. `find claims/grid3n-colmid-indep -type f`（包体 30 件清点）
2. `grep -n "LEAN:" claim.tex`；`grep -nE "^% LEAN: "`（严格口径恰 1）；比对 `scripts/paper-lint.sh` 第 114–118 行锚点判定式
3. python sha256 复算：源三冻结件 + 包内 proofs/ 三件（六值全对）
4. `python claims/grid3n-colmid-indep/audit/inspect-tex.py --verify claim.tex`（exit 0）
5. python 自写独立比对：四 lstlisting 块提取 vs stmt/iface/final（LF 归一）；`final[:8042]==iface`；final 第 1087 行 vs stmt 第 48 行；`c_z_rec` 出现次数；行尾分段扫描（CRLF=486–952）
6. python 二进制比对 `zenodo/audit/c9-record.md` vs 源 dossier.md（IDENTICAL）+ 双 sha256
7. `cat` 源任务与占位包两份 budget.log 全文；逐数字对 (b) 段与 zenodo.json description 预算句
8. 通读 final-audit.md、pools/comb.md pool-comb-12 六条措辞约束、两份 card.md、zenodo.json、README、FILE-MANIFEST、gate 双清单、compile.txt、claim.log 尾部
9. 措辞与 PII grep：越级主张模式 + `orcid|email` 正则（全零命中）
10. 副本一致性：根 claim.tex == zenodo/claim/claim.tex；两份 lstlean.tex == 模板；包内 final-audit.md == 源
11. `find` 全仓 bib-verify 与 statement-diff* 存在性核查
12. python zip 核验：18 条目与树一致；MANIFEST 逐行对盘；PDF sha/尺寸三处核对（→ F-5）

## 写入披露（首审只读审计的唯一副作用）

第 4 步按审计指令运行的 `inspect-tex.py --verify` 按其设计向 `audit/listing-verify.txt` 追加了一条 PASS 记录（根副本现 3 条，包内副本为打包时快照 2 条——该差异本身即 F-2 空转问题的旁证）。除此之外未写改任何文件；未跑 `scripts/lean-verify`。
