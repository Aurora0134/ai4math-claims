# 占位精简主张审计记录 claim-check.md — claims/chorded-cycle-mod4/

> SOP 08b 第 5 步（占位质检门③）。裁决方：监察院 dept-audit（只读，无写权限）；本文件由主代理按工人回交原文落盘并追加处置节。
> **状态：第一轮有发现 7 条（全部必修）→ 已逐条处置；处置后快照见文末「冻结快照」节，复审入口条件已满足。**
> 审计自耗：llm-call 0 / Lean 编译 0 / 写文件 0（只跑 paper-lint 与哈希复算等只读命令）。端点 qoder。
> 审计快照钉版（第一轮裁决只对该快照负责）：`claim.tex` sha256=`621eb842…`（00:35:34）、`claim.pdf` sha256=`cfd81071…`；主代理当时仍在写盘，处置后快照已重新冻结（见末节）。

## 一、第一轮 PASS 项（审计独立复算，未采信生成方自报件）

| 核对项 | 裁决 | 证据 |
|---|---|---|
| 三条 `% LEAN:` 锚点 → 声明名 / 分级 / 源任务 | PASS | `claim.tex:115/147/178`；分级唯一上限源 `audit/final-01-cchord.txt:9-13`（三定理完全证明、全案最低级完全证明、无脚手架） |
| 冻结件与终稿 sha256 | PASS | 审计自算 statement `a69d00e5…c3a03b`、final `af39d35e…bba2237`；包内 `zenodo/proofs/` 与源**同哈希**；LF 无 CR；87 / 262 行 |
| 审计证据在包且与源字节一致 | PASS | `final-01-cchord.txt`、`welldef-verdict.md`、`gate-c{1,2,3}.txt`、`gate-recheck-frozen.txt` 全部 sha 对上 |
| 五处 lstlisting 逐字节 | PASS | 审计自写抽取器（剥多行 caption）独立比对 22-42 / 45-63 / 66-86 / 43-67 / 252-262 → **5/5 BYTE-EXACT**（两版 tex 各复算一次）；caption 辅助行段（final 86-137 / 159-262 / 160-251）实测为真 |
| 公理原文块 | PASS | 三行与 `attempts/final-axioms.out:69-71` 逐字一致 |
| 措辞 ≤ 分级 且 ≤ C9 | PASS（除 F4） | 无 new-mathematics / first 拔高（唯一命中是否定句 `:318`）；四态裁决照抄；Conjecture 环境承载语义桥；C2 带 `j≥1` 且写明 `c_0(0)=4≡0`；0-based 换算三处一致（审计用 docstring 种子映射实测无 off-by-one）；负结果标「a computation, not a theorem」；abstract 含「This note is a priority claim of record, not a full paper.」 |
| 预算数字与节点口径 | PASS（除 F2） | 源账本 `1/8`、`15/24` 照抄；本阶段 llm 0/4、LaTeX 轮在 6 顶内、Lean 0；节点两层如实分列，**无冒充固定节点** |
| 披露四要素 / 作者栏 / PII / 元数据 | PASS（除 F1） | 四要素 + CRediT 齐；作者栏仅账号名 + 占位联系方式；zenodo.json 合法且键集与首批 cyl3 完全同构；PDF 内明文账号/邮箱 0 命中；无 harness 配置、无 relay 凭据 |
| c9-record.md 在包且逐字一致 | PASS | 三段 `sed`-等价抽取全部 FOUND VERBATIM；源 sha256 `364f5e6b…f731e6`；附加物仅出处头与哈希附录 |
| 机器门禁 | PASS | 审计复跑 `paper-lint` → PASS exit 0（两次，含新版）；`compile.txt` 末行 PDF 字节 = 现 `claim.pdf` = 包内件 → tex/pdf/包三者同一轮；`Missing character` 0；无 `!` 级错误 |
| 书目 7 条 | PASS | 与 `papers/chorded-cycle-mod4/audit/bib-verify/` 一一对应：`_37` = Lean 4 系统论文（pp. 625-635）、`cr_WRONG_27.json` 明确记为 Collatz 论文 → **模板错引未沿用**；`cite ↔ bibitem` 7↔7 零差 |
| 结构合规 | PASS | `claim/ proofs/ audit/ metadata/` 四目录齐；`proofs/lean-toolchain = leanprover/lean4:v4.34.0` |
| 闸门四双口径 | **可接受，非否决项** | 审计给出三条依据（SOP 08b 启动权=用户指令且本通道不设独立人工闸门；指令文本已三处落盘；首批三包同口径且已公开），并加两项持续条件：Scope (e) 句不得在后续修订中被删弱；`tasks/…/report.md` 若要补签发行须由用户显式指令驱动 |

## 二、第一轮发现与处置（逐条钉回 SOP 08b 工序号）

| # | 工序 | 发现（审计实测） | 处置（2026-09-28 已落盘） |
|---|---|---|---|
| **F1 脱敏红线** | 4 | 包内 4 个文件含本机绝对路径（Windows 账号名）共 **138 处**：两个日志（各 68 处）+ 两个装配脚本；首批公开镜像同位置 **0 命中**（cyl3 只发 3 行公理打印、未发 strict 日志与脚本） | 新工具 `audit/sanitize-package.py`：公理 sidecar 只留三行 `depends on axioms`（435 B）；strict 日志仓库前缀整串替换为 `<repo>/`（并在文件头写明「该轮未 echo EXIT，EXIT=0 的载体是 final-01-cchord.txt 第 3 项复跑」）；脚本内 ROOT 改环境取值；工具自身不再含字面本地路径。复扫结果：**两包 0 命中**（PASS: no machine-local user path） |
| **F2 账实不符** | 4/6 | README 两处与 budget.log 两行写「Overfull 7 处均 <20pt」= 假（实测 38.34/54.08/55.45/115.78×3/137.06 pt） | ① 文内真修：64 位 sha256 拆两段加断点、公理原文块由 `verbatim` 改 `lstlisting[footnotesize,frame=none]`（源码仍逐字、仅渲染）；② 文档口径改实测值：复编后 **5 处 overfull，最大 69.62pt**（16.33 / 27.09 / 54.08 / 55.45 / 69.62），账本同步行；短笺新增一句说明 strict 日志的脱敏与 68 警告数 |
| **F3 指针悬空** | 3 | 短笺称包内有 `final-axioms.log`，实为 `audit-axioms-sidecar.log` | 短笺改真实文件名，并写明「上面三行即其全部内容」；另补 `audit-strict-compile.log` 的真实名字与脱敏说明 |
| **F4 措辞一致性** | 3 | Scope (a) 写「enumeration to n=150 by three independently written programs」且缺「枚举器本身未证」限定——实据：M1 产 n≤150，M2 只对到 n≤16，M3 到 n≤36 → 短笺比同成果论文**更硬** | Scope (a) 重写为分窗表述（主程序 3≤n≤150；暴力件交叉核验 3≤n≤16；第二布局 3≤n≤36；外部种子仅 3≤n≤15）+ 补「the enumerators themselves are not verified」+ 脚本留仓路径；`zenodo.json` description 同步改（原句 "three independent enumerators to n=150" 已换成分窗口径） |
| **F5 包缺 claim-check.md** | 4/5 | `zenodo/audit/` 无本件，而短笺承诺其在包 | 本文件即该件；已拷入 `zenodo/audit/claim-check.md` 并重生成 FILE-MANIFEST |
| **F6 包内旧件** | 4 | 包内 `listing-verify.txt` 是 00:28 旧轮，与账本「已同步」不符 | 重拷（现包内件 = 终轮 `--verify` 输出，5/5 PASS）；账本同步行订正 |
| **F7 外发清单失真** | 4 | `UPLOAD.md` 第 1 步让用户「替换 `<<RESERVED-DOI>>`」，但短笺无此占位符（卡面明确不留），照单执行会扑空 | 第 1 步按首批口径改写：预留 DOI 后**插入** Data availability 段与 `metadata/README.md` 回填点，并说明包内无占位符；源头模板 `harness/templates/claim/UPLOAD.md:15` 同病，**回改属 harness 侧、待用户裁决** |
| O1 C9 记录尾注 | 4 | 源 `chunk-G.md:121-122`「通道降级备忘」点名 MAT-CCHORD 要求 OpenAlex 恢复后回扫，三段抽取未含 | 抽取增为四段（1-11 / 86-109 / 111-120 / **121-122**），provenance 头同步；行数口径修正（源 122 行，原头写 123）；自检 4/4 PASS |
| O2 run-state 无本包行 | 4 | 工序 4 要求记一行 | 已并入本轮 run-state 置顶条目（与论文线同段） |
| O3 未预打包 zip | 4 | 通道既有统一偏差（首批按目录树推送，UPLOAD 允许「单 zip 或分文件」） | 本包产出 `zenodo-package.zip`（论文包同做），UPLOAD.md 第 2 步注明两种皆可 |
| O4 roundtrip 同节点自裁未披露 | 3 | 论文侧有该告警、短笺无 | 审计链条目补一句：roundtrip 与形式化同节点，独立性风险由 kernel 终裁与人工复核缓解而非消除 |
| O5 页数 10 页 vs SOP「2–4 页」 | — | 超出部分全为逐字 listing 与 C9 表；首批 `claims/cyl3-mod23` 同 10 页 | **不自行裁短**（裁之即牺牲「冻结产物逐字快照」硬要求）；README 与卡面已如实分列为口径偏离，是否追认超顶交用户 |
| O6 C4 零出现 | — | 不构成「已完成」暗示，卡面红线 6 满足 | 不改（论文侧 F10 已主动披露） |

## 三、冻结快照与门禁复跑（处置后）

- 编译：`bash scripts/paper-compile.sh claims/chorded-cycle-mod4/claim.tex` → **exit 0**，10 页，`Missing character` 0，终轮 Overfull **5 处：16.33 / 27.09 / 54.08 / 55.45 / 69.62 pt**（无 error、无未解引用）；LaTeX 编译轮 **4/6**（00:27 / 00:35 / 00:55 / 01:07 四轮，如实计数，不再自报「一轮」）。
- 静态门：`bash scripts/paper-lint.sh claims/chorded-cycle-mod4/claim.tex` → **PASS exit 0**。
- listing：`audit/inspect-tex.py --verify` → **5/5 BYTE-EXACT**（源件哈希见 `audit/listing-verify.txt` 头两行）。
- C9：`audit/build-c9-record.py --check` → **4/4 逐字 PASS**（源 sha256 `364f5e6b…f731e6`）。
- 脱敏：`audit/sanitize-package.py --check-only` → **PASS: no machine-local user path in any package file**；包内文件全清单与逐件 sha256 见 `zenodo/metadata/FILE-MANIFEST.txt`（23 件）。
- 分级上限（不得再越）：三定理 **完全证明**；价值级 **new sequence / new recurrence**；语义桥 = conjecture；负结果 = computation（136/139，12≤n≤150）；novelty = 负检索证据（OpenAlex 429 未验证、通用网页层无读数、未检中文库）。
- 外发状态：Zenodo DOI **未预留**（用户动作）；GitHub 镜像推送见 `card.md`「GitHub 快照」节与 `run-state.md`。

## 四、占位质检门三格结论

| 门 | 结果 |
|---|---|
| ① paper-lint | PASS exit 0 |
| ② paper-compile（tectonic） | PASS exit 0（10 页，缺字 0） |
| ③ 精简主张审计 | 第一轮 7 条必修 → **已逐条闭环**（F1 脱敏复扫 0 命中、F2 数字改实测并真修排版、F3–F5 指针与缺件补齐、F6 重拷、F7 清单改写、O1 C9 补段）；本包不主张「零发现」，处置记录全量在此，**复审由用户指定的第三轮工人核验** |

> 主代理注：SOP 08b 规定「同一发现第 2 次出现即停线报告用户」。本包第一轮发现中的 F1（脱敏）与 F2（数字失真）为**首次**出现，已在出包内闭环；论文包另有同类二次出现，已按 SOP 08 停线条款上报用户。
