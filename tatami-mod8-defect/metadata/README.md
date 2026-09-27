# Zenodo 存缴包 README — tatami-mod8-defect

- **性质**：优先权存缴记录（claim of record），非完整论文。完整叙述性论文走 AI4Math SOP 08 慢车道，将回本引用本包 DOI。
- **DOI**：`<RESERVED-DOI>`（上传时按 UPLOAD.md 第 1 步预留并回填 claim.tex 后重编）。
- **镜像**：https://github.com/Aurora0134/ai4math-claims （同一内容快照）。

## 包结构

- `claim/`：占位短笺 `claim.tex` + `claim.pdf`（tectonic/XeTeX 编译，0 缺字）+ `lstlean.tex`
- `proofs/`：冻结 statement（`01-statement.lean`，sha256=`59560f5735f2c8b58a31d631a4ed28806ca23292d195fa098231fb04682b187f`）+ 最终证明（`01-proof-complete.lean`，207 行，sha256=`b0f4a692990680e67817e0975484718132a6c54b9a1664598e44d9d0534789a1`）+ `lean-toolchain`
- `audit/`：闸门二良定义输出、闸门三终审记录（`final-01-audit.md`）、公理打印、lint/compile/listing 核验输出、`c9-record.md`（C9 查新全量记录，与源档案逐字一致）
- `metadata/`：本文件 + `zenodo.json`

## 复现

环境：Lean v4.34.0 + mathlib4 v4.34.0（rev 5ed29652），工具链钉版见 `proofs/lean-toolchain`。

```
# 在含 mathlib v4.34.0cache 的 Lean 工程中：
lake env lean proofs/01-proof-complete.lean        # 终态严格编译，0 error 0 sorry
# 公理审计：在文件末段审计迹（audit/final-01-audit.md §3）含 #print axioms 输出，
# 三定理公理 ⊆ {propext, Quot.sound, Classical.choice}
```

## 许可

短笺文本 CC BY 4.0；Lean 源码 MIT。

## 披露

命题生成/形式化/证明搜索/文本草稿由 AI4Math 流水线（LLM）承担；Lean 4 kernel 终裁；作者本人（Aurora0134）终审并对全部内容负责。AI 不列为作者。
