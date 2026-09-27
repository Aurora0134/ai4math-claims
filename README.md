# ai4math-claims — 优先权存缴快照仓（claims of record）

> 由 AI4Math 高度自动化数学科研流水线产出（LLM 生成 + Lean 4 kernel 编译终裁）。
> 本仓是各占位成果的**公开时间戳镜像**：每个子目录对应一份 Zenodo 存缴包的同内容快照（isIdenticalTo）。
> 正式叙述性论文（如出）走 arXiv 慢车道，并引用对应 Zenodo DOI 转正。

## 存缴清单

| 子目录 | 成果 | 内容 | 核验强度 | Zenodo DOI |
|---|---|---|---|---|
| `tatami-mod8-defect/` | 递推定义 tatami 计数序列的 mod-8 周期 4 定理 + 两条伴随恒等式（`tatami_mod8_period4`、`bcorner_odd`、`bcorner_eq`） | 占位短笺（`claim/`）+ 冻结 statement 与 0-sorry 证明（`proofs/`）+ 闸门与查新证据（`audit/`）+ 元数据（`metadata/`） | Lean 4 kernel 全编译，公理 ⊆ {propext, Quot.sound, Classical.choice}；冻结 sha256 在包内 | 上传后回填 |
| `cyl3-mod23/` | 圆柱三孔递推族双定理（`cyl3_master`、`cyl3_matrix_family`） | 同上结构 | 同上 | 上传后回填 |
| `edgemid-monomer-dimer/` | 边中点单体-二聚体递推双定理（`edgemid_master`、`edgemid_matrix_family`） | 同上结构 | 同上 | 上传后回填 |

## 工具链钉版

Lean v4.34.0 + mathlib4 v4.34.0（rev 5ed29652）；各包 `proofs/lean-toolchain` 为准。

## 披露

命题生成/形式化/证明搜索/文本草稿由 AI（LLM）流水线承担；全部命题与证明经 Lean 4 kernel 编译核验（0 sorry）；查新记录（C9 纪律，全量查询串）随包在 `audit/c9-record.md`。作者本人终审并对全部内容负责；AI 不列为作者。短笺 CC BY 4.0，代码 MIT。
