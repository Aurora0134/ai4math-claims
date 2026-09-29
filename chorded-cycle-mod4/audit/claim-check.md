# 占位精简主张审计记录 claim-check.md — claims/chorded-cycle-mod4/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限），共两轮针对本包；本文件由主代理按工人回交原文落盘并追加处置节。
> **状态：第一轮 7 条必修 → 处置后第三轮闭环核验发现「处置自身有 4 处失实/漏修」→ 已全部真修（见第四节）。当前占位质检门三格全绿，且已随镜像追加提交回补公开件。**
> 审计自耗：两轮均 llm-call 0 / Lean 编译 0 / 写文件 0。端点 qoder。
> 第一轮裁决快照（当时）：`claim.tex` sha256=`621eb842…`（00:35:34）、`claim.pdf`=`cfd81071…`；该中间态实物已被后续修订覆盖，不可复算（第三节单列）。

## 一、第一轮 PASS 项（审计独立复算，未采信生成方自报件）

| 核对项 | 裁决 | 证据 |
|---|---|---|
| 三条 `% LEAN:` 锚点 → 声明名 / 分级 / 源任务 | PASS | `claim.tex:115/147/178`；分级唯一上限源 `audit/final-01-cchord.txt:9-13` |
| 冻结件与终稿 sha256 | PASS | 审计自算 statement `a69d00e5…c3a03b`、final `af39d35e…bba2237`；包内 `zenodo/proofs/` 与源同哈希；LF 无 CR；87 / 262 行 |
| 审计证据在包且与源字节一致 | PASS | `final-01-cchord.txt`、`welldef-verdict.md`、`gate-c{1,2,3}.txt`、`gate-recheck-frozen.txt` sha 全对上 |
| 五处 lstlisting 逐字节 | PASS | 审计自写抽取器独立比对 22-42 / 45-63 / 66-86 / 43-67 / 252-262 → 5/5 BYTE-EXACT（两版 tex 各复算一次）；caption 辅助行段（final 86-137 / 159-262 / 160-251）为真 |
| 公理原文块 | PASS | 三行与 `attempts/final-axioms.out:69-71` 逐字一致 |
| 措辞 ≤ 分级 且 ≤ C9 | PASS（除 F4） | 无 first/new-mathematics 拔高；四态裁决照抄；Conjecture 承载语义桥；C2 带 `j≥1` 与 j=0 真例外；0-based 三处一致（审计用种子映射实测无 off-by-one）；abstract 含 priority-claim 定性句 |
| 预算与节点口径 | PASS（除 F2 数字） | 源账本 1/8、15/24 照抄；本阶段 llm 0/4、LaTeX 轮在顶内、Lean 0；两层节点如实分列，无冒充固定节点 |
| 披露四要素 / 作者栏 / PII / 元数据 | PASS（除 F1） | 四要素 + CRediT 齐；作者栏仅账号名；zenodo.json 合法且键集与首批 cyl3 同构；PDF 内明文账号/邮箱 0 |
| c9-record.md 在包且逐字一致 | PASS（记录本体；第一轮为**三段**，终态为**四段**，见 O1） | 三段 `sed`-等价抽取全部 FOUND VERBATIM；源 sha256 `364f5e6b…f731e6`；附加物仅出处头与哈希附录 |
| 机器门禁 | PASS | `paper-lint` 复跑 PASS exit 0（两次）；`compile.txt` 末行 PDF 字节 = 现 `claim.pdf` = 包内件 → tex/pdf/包同一轮；缺字 0 |
| 书目 7 条 | PASS | 与 `papers/chorded-cycle-mod4/audit/bib-verify/` 回包一一对应；模板错引 `_27`（Collatz 论文）未沿用，改 `_37`；cite↔bibitem 7↔7 |
| 结构合规 | PASS | 四目录齐；`proofs/lean-toolchain = leanprover/lean4:v4.34.0` |
| 闸门四双口径 | 可接受，非否决 | 三条依据 + 两项持续条件（Scope (e) 不得删弱；`report.md` 补签发行须用户显式指令） |

## 二、第一轮发现与处置

| # | 工序 | 发现（审计实测） | 处置 |
|---|---|---|---|
| **F1 脱敏红线** | 4 | 包内 4 件含本机绝对路径共 138 处（两日志各 68 + 两装配脚本）；首批公开包同位置 0 命中 | `audit/sanitize-package.py`：公理件只留三行 `depends on axioms`（435 B）、strict 件前缀 `<repo>/` 化并在头里写明「该轮未 echo EXIT，EXIT=0 载体为 `final-01-cchord.txt` 第 3 项复跑」、脚本 ROOT 改环境取值。第三轮复扫：账号名片段 **0 命中**；「盘符+用户目录」形态剩 1 处 = 工具自身的通用正则字面量（无账号、无识别力）→ 已把工具内的判据改为通用 `[A-Za-z]:[/\\]+Users[/\\]+…` 形态并去掉字面账号 |
| **F2 账实不符** | 4/6 | README 两处 + 账本两行写「Overfull 7 处均 <20pt」= 假（当时实测 38.34/54.08/55.45/115.78×3/137.06 pt） | ① 真修：64 位 sha256 拆两段加可断点；公理原文块由 `verbatim` 改 `lstlisting[footnotesize,frame=none]`（源码仍逐字，仅渲染）；② 全部口径改实测：终轮 **5 处 overfull = 16.33 / 27.09 / 54.08 / 55.45 / 69.62 pt**，页数 10，四轮 exit 0 如实计数 |
| **F3 指针悬空** | 3 | 短笺称包内有 `final-axioms.log`，实为 `audit-axioms-sidecar.log` | 短笺改真实名并写明「上面三行即其全部内容」；补 `audit-strict-compile.log` 真名与脱敏说明 |
| **F4 措辞一致性** | 3 | Scope (a) 写「three programs to n=150」且缺「枚举器未证」，比同成果论文更硬（实据：主程序 n≤150、暴力件仅到 n≤16、第二布局到 n≤36） | 短笺 Scope (a) 改分窗四口径 + 补 `the enumerators themselves are not verified` + 脚本留仓路径。**第一轮声称「zenodo.json 同步改」为不实**（第三轮核验：同包件仍逐字保留原句）→ 本轮已真改，见第四节 R-1 |
| **F5 包缺本件** | 4/5 | `zenodo/audit/` 无 `claim-check.md`，而短笺承诺其在包 | 本文件已拷入 `zenodo/audit/claim-check.md`，FILE-MANIFEST 重生成 |
| **F6 包内旧件** | 4 | 包内 `listing-verify.txt` 为旧轮 | 重拷终轮件；第三轮另以自写抽取器复算 5/5 逐字节，不受该件影响 |
| **F7 清单失真** | 4 | `UPLOAD.md` 第 1 步要求替换并不存在的 `<<RESERVED-DOI>>` | 改为「插入预留 DOI；本包未留占位串故无替换动作」；`UPLOAD.md:55` 同口径；模板同源缺陷待用户裁决 |
| O1 C9 尾注 | 4 | 源 `chunk-G.md:121-122`（通道降级备忘，点名本候选）未入包 | 抽取增为**四段**（1-11 / 86-109 / 111-120 / 121-122），provenance 头同步写「four contiguous line ranges」；行数口径修正（源 **122** 行，原头写 123）；`build-c9-record.py --check` → 4/4 逐字 PASS。包内 README/UPLOAD 的「三段」旧述已改「四段」 |
| O2 run-state | 4 | 缺本包状态行 | 已并入 `run-state.md` 置顶 2026-09-28 节 |
| O3 未预打包 | 4 | 无 zip（首批按目录树推送） | 已产出 `zenodo-package.zip`（25 条目，与 FILE-MANIFEST 同集合，`audit/make-zip.py` 断言） |
| O4 roundtrip 告警 | 3 | 短笺未披露同节点自裁 | 已补入审计链条目 |
| O5 页数 | — | 10 页 vs SOP 08b「2–4 页」 | **未自行裁短**；card / README / 账本三处如实分列为口径偏离，追认与否交用户（第三轮工人意见：认可「逐字 listing 优先」，但须转为显式豁免而非既成事实；若不追认，正确做法是把逐字 listing 移出正文、留 `proofs/` 并在 caption 保留行段，正文回到 2–4 页） |
| O6 C4 | — | 短笺零出现，不构成暗示 | 不改 |

## 三、第一轮工人声明的「核不动 / 未核」

1. OpenAlex 与通用网页层历史读数不可复现（已在正文写成披露，不改判）。
2. OEIS 关键词 10 条命中「非本族」属 C9 工人判读，工人只核到记录文本。
3. 镜像推送当时未发生 → 现已完成（见第五节），该项已可核。
4. Zenodo DOI / OEIS A 编号未产生（用户动作）；`metadata/README.md`、`zenodo.json` 中英混排属首批同口径。
5. 工人未重跑 tectonic / 未编 .lean / 未调 relay。

## 四、第三轮闭环核验与再处置（2026-09-28）

工人针对「已冻结快照 + 已推送镜像」复算，裁定「门①②绿、门③不绿」，并列出四处处置侧失实/漏修：

| # | 工人实测 | 本轮再处置 |
|---|---|---|
| **R-1** | `zenodo/metadata/zenodo.json` description 仍逐字含「supported by three independent enumerators to n=150」，且无「枚举器未证」——F4 只修了正文，元数据未修；该件**已公开** | 已改为四口径分窗句 + 「the enumerators themselves are not verified」；随追加提交回补公开件 |
| **R-2** | 包内 `metadata/README.md:25` 与 `UPLOAD.md:54` 仍写 C9「三段」（README 为已公开件，且同文 `:28` 又说脚本是「四段构建」，自相矛盾） | 两处均改「第 1-11 / 86-109 / 111-120 / 121-122 行四段」并附自检命令；README 补「发布前必跑（只读）」段 |
| **R-3** | 件数三个版本并存：`claim-check.md:50`「23 件」、`budget.log:15`「23 件」、`UPLOAD.md:51/56`「20 文件」，实况 manifest 24 条 / 盘上 25 件 | 本文件与 `budget.log`、`UPLOAD.md` 统一为「25 件（清单列 24 + 清单自身）」；本文件即修订版 |
| **R-4** | 末轮时刻自报 01:07，但实物时间链为 `claim.tex 01:00:13 → claim.pdf/claim.log/compile.txt 01:00:48`，01:07 后无 tex/pdf/log 写盘 | 账本改记四轮真实时刻（00:27 / 00:35 / 00:55 / 01:00），不再写 01:07；轮数 4 与「全部 exit 0」保留（工人亦无法反证轮数） |
| **R-5** | 「`--check-only` 只读」不成立：旧版在该路径上仍会写 FILE-MANIFEST | 工具已重构：`--check-only` 完全不写盘，改为「重算清单并与盘上现有件比对」；新增 `--assert-promises` 承诺对账门 |
| **R-6** | 本文件曾写「工具自身不再含字面本地路径 / 两包 0 命中」——实际工具内含「盘符 + 用户目录」形态字面量（通用正则，无账号），且旧判据只看账号名 | 该行已按上方 F1 处置栏改写；工具判据扩展为「账号名片段 **或** `[A-Za-z]:[/\\]+Users[/\\]+…` 形态」，工具自身不再含字面账号 |

同时并入的论文侧联动修订（同一成果两条通道不得口径不一）：论文 §1 / 分级表 / §8 / `zenodo.json` 的「three independent enumerators up to n=150」全部改为与短笺一致的分窗四口径。

## 五、冻结快照、门禁与外发状态（终态）

- 静态门①：`bash scripts/paper-lint.sh claims/chorded-cycle-mod4/claim.tex` → PASS exit 0。
- 编译门②：`bash scripts/paper-compile.sh claims/chorded-cycle-mod4/claim.tex` → exit 0；**10 页**；缺字 0；无未解引用；终轮 overfull 5 处（16.33 / 27.09 / 54.08 / 55.45 / 69.62 pt）；LaTeX 轮 4/6。
- 审计门③：第一轮 7 条必修 + 第三轮 R-1..R-6 → **全部真修**；修后复跑承诺对账（`sanitize-package.py --check-only`）：FILE-MANIFEST 与盘上一致、路径型承诺全部命中、无本机路径 → PASS。本文件不写「零发现」，写「发现已全部闭环且逐条附证据」。
- listing：`inspect-tex.py --verify` → 5/5 逐字节（第三轮工人另以自写抽取器独立复算，同结论）。
- C9：`build-c9-record.py --check` → 4/4 逐字。
- 分级上限：完全证明 ×3；价值级 new sequence / new recurrence；语义桥 conjecture；负结果 computation（136/139，12≤n≤150）；novelty = 负检索证据（OpenAlex 429 未验证、通用网页层无读数、未检中文库）。
- **公开件回补**：镜像仓 `ai4math-claims` 追加提交见 `card.md`「GitHub 快照」节（首个提交 `cf666c1` 已把 R-1/R-2 的失实件公开；本轮以同仓追加提交更正，原时间戳与版本链不动，符合 SOP 08b「不撤包、版本机制保留原时间戳」）。
- Zenodo：DOI 仍未预留（用户动作）；OEIS 提交挂起（提交侧未实测 + 实名与账号名署名策略冲突）。

## 勘误追记（2026-09-29，用户指令「授权确认，继续项1,3」＝回补已公开件；仓库级五门存量红修复）

- **触发**：2026-09-29 `scripts/sanitize-package.py`（仓库级五门，替代本包自带的包内门口径）对 batch1/2 四包首跑，本包 2 条存量红：`metadata/README.md` 头部引用行裸指称 `claims/chorded-cycle-mod4/UPLOAD.md` ×1；「已知观感项」节裸指称 `tasks/20260927-mossad-cchord/report.md` 与「与本目录 `card.md`」×1（同行两个 token，均未写明「源仓/不随包」）。
- **修法**（零证明层触碰：proofs/ 冻结件、listing 字节、公理打印、C9 四段记录、分级措辞全部未动；本包无 claim.tex 改动、零编译轮）：README 两处按 pendant/notchgrid 绿包同款补「源仓 deliverable 目录的…（不随包）」明示；`metadata/FILE-MANIFEST.txt` 重生成（README 字节数变化）；`zenodo-package.zip` 重建（25 条目＝清单同集合）。
- **门复跑**：`python scripts/sanitize-package.py claims/chorded-cycle-mod4 --scanned logs/gate-lists/chorded-cycle-mod4-scanned.txt --skipped logs/gate-lists/chorded-cycle-mod4-skipped.txt` → exit 0，五门全绿（scanned 17 + declared 8 = 25 = 存缴树实测）。
- **件数口径**：仍为 25 件（清单 24 + 清单自身），与本文件「五、终态」及 `UPLOAD.md`、`card.md` 既有口径一致，无需改数。
- **外发**：随 batch1/2 errata 提交推送镜像仓（提交号/ls-remote 见 `claims/.mirror-errata-20260929.log`）；原 `cf666c1` / `25edf6e` 版本链不动。
