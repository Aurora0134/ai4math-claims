# Zenodo 存缴包 README — cyl3-mod23（AI4Math pipeline claim-of-record artifact）

> AI 生成（2026-09-27）。本包为 SOP 08b 占位通道产物；上传（外发）一律用户本人手动执行，见 `claims/cyl3-mod23/UPLOAD.md`。本通道不依赖 arXiv 账号与背书。

## DOI

- 预留占位：上传时在 Zenodo 草稿页点 "Get a DOI now!" 生成；本包未含真实 DOI。
- 回填点：`claim/claim.tex` 的 Data availability 段与 `claims/cyl3-mod23/card.md`（回填后重编 PDF 属外发前用户动作）。

## 内容

| 路径 | 内容 |
|---|---|
| `claim/claim.tex` | 占位短笺 LaTeX 源（英语）；两条 `% LEAN:` 锚点（cyl3_master / cyl3_matrix_family，grade=完全证明） |
| `claim/claim.pdf` | 短笺编译产物（tectonic 0.17.0 / XeTeX 本机编译，exit 0，10 页，缺字告警 0，error 0）。listing 源码字节与冻结产物逐字节一致（3/3 脚本核验，见 `audit/listing-verify.txt`）；前导含渲染专用 XeTeX 补丁（照抄 claims/tatami-mod8-defect 定式块 + 本源文件字符集扩展 6 枚数学符号；00B7/2014/2026 属 xeCJK 标点表、走 SimSun 路由） |
| `proofs/04-proof-complete.lean` | 终稿两定理（69 行），sha256=`566e9e1d7053602eda7853943f582e3d3726009c32f9dc4b6ce3ca8ee19c5ae8` |
| `proofs/04-statement-p1.lean` | 冻结 P1 statement（proof body = sorry 占位），sha256=`4740b9d53e97360c49d0eefe97a7abc470134acf8e61273963d7a55de8e733bc` |
| `proofs/04-statement-p2.lean` | 冻结 P2 statement（sorry 占位），sha256=`8cac6fa4ec068dc913ff90769bda34333bddd9d22c7463d2cecab0e3edc1d7fe` |
| `proofs/lean-toolchain` | `leanprover/lean4:v4.34.0` |
| `audit/final-04-audit.md` | 闸门三终态审计（四项核查全过；分级=完全证明×2） |
| `audit/welldef-04-statement-p1.txt` / `audit/welldef-04-statement-p2.txt` | 闸门二良定义 + 退化探针记录（各 7 探针全 FAIL = 非退化） |
| `audit/audit-axioms-sidecar.log` | `#print axioms` 原文输出（两定理均 = [propext, Classical.choice, Quot.sound]，无 sorryAx） |
| `audit/c9-record.md` | C9 独占性复审逐字全文（新颖性证据主体；源 `tasks/20260926-beian-select/recheck/04-cylinder-3holes-exclusivity.md`，正文 sha256=`59b469f8b63d99c7e91362300b064ee30052d91108099cf33dcb36daff7806c7`；仅加头部出处注记与文末原始证据文件路径附录，原始证据目录留仓不入包） |
| `audit/lint.txt` | 本包 paper-lint 输出（PASS, exit 0） |
| `audit/compile.txt` | 本包 paper-compile（终轮）控制台输出（exit 0） |
| `audit/listing-verify.txt` | claim.tex 三处 lstlisting 与冻结产物逐字节核验记录（3/3 PASS） |
| `metadata/zenodo.json` | Zenodo 元数据（creators=Aurora0134，无 ORCID 键——上传时用户在 UI 补；related_identifiers.isIdenticalTo = GitHub 镜像仓） |
| `metadata/README.md` | 本文件 |

## 版本钉

- Lean v4.34.0（`leanprover/lean4:v4.34.0`）；mathlib4 v4.34.0（rev `5ed29652`）。
- 短笺编译：tectonic 0.17.0（本机便携版），XeTeX 路径。

## 复现

```bash
# 在含 mathlib4 v4.34.0 的 Lean 工程内（本仓 verify-proj 即钉版环境）：
lake env lean 04-proof-complete.lean
# 期望：exit 0，诊断为空（strict 模式）
```

复跑公理审计：sidecar 方式另起文件 `import` 后 `#print axioms cyl3_master` / `#print axioms cyl3_matrix_family`（本仓纪律：sidecar 用完即删，不进 final 文件）。

任务级全部过程档案见本仓 `tasks/20260926-cyl3-pipeline/`；C9 原始证据（OEIS/arXiv/OpenAlex/zbMATH 查询回包、独立重算脚本）留仓 `tasks/20260926-beian-select/recheck/04-cylinder-3holes/`。

## 许可

- 短笺（`claim/`）：CC BY 4.0（Zenodo UI 端请在 Licenses 处双许可登记，见 UPLOAD.md 第 2 步）。
- 代码与审计件（`proofs/`、`audit/`）：MIT。

## 已知观感项（如实记档，不影响质检门）

- `claim.pdf` 有 15 处 overfull hbox：全部来自 listing 内长行（冻结文件的中文 docstring 长行在 xeCJK 路由下不参与 listings 断行）与长 sha256 串；listing 源字节未动，属纯排版观感项。
- `tasks/20260926-cyl3-pipeline/report.md` 文件头仍为「待闸门四人工签发」；本包由用户 2026-09-27 显式指令启动出包（占位通道启动权即用户指令），此口径已如实记入短笺 Scope and limitations 节与 `claims/cyl3-mod23/card.md`。
