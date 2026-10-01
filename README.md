# ai4math-claims — 优先权存缴快照仓（claims of record）

> 由 AI4Math 高度自动化数学科研流水线产出（LLM 生成 + Lean 4 kernel 编译终裁）。
> 本仓是各占位成果的**公开时间戳镜像**：每个子目录对应一份 Zenodo 存缴包的同内容快照（isIdenticalTo）。
> 正式叙述性论文（如出）走 arXiv 慢车道，并引用对应 Zenodo DOI 转正。

## 存缴清单

| 子目录 | 成果 | 内容 | 核验强度 | Zenodo DOI |
|---|---|---|---|---|
| `tatami-mod8-defect/` | 递推定义 tatami 计数序列的 mod-8 周期 4 定理 + 两条伴随恒等式（`tatami_mod8_period4`、`bcorner_odd`、`bcorner_eq`） | 占位短笺（`claim/`）+ 冻结 statement 与 0-sorry 证明（`proofs/`）+ 闸门与查新证据（`audit/`）+ 元数据（`metadata/`），另含 `metadata/FILE-MANIFEST.txt`（逐件 sha256 + 字节数清单，2026-09-29 勘误轮补齐） | Lean 4 kernel 全编译，公理 ⊆ {propext, Quot.sound, Classical.choice}；冻结 sha256 在包内 | 10.5281/zenodo.23047537 |
| `cyl3-mod23/` | 圆柱三孔递推族双定理（`cyl3_master`、`cyl3_matrix_family`） | 同上结构，另含 `metadata/FILE-MANIFEST.txt`（逐件 sha256 + 字节数清单，2026-09-29 勘误轮补齐） | 同上 | 10.5281/zenodo.23047512 |
| `edgemid-monomer-dimer/` | 边中点单体-二聚体递推双定理（`edgemid_master`、`edgemid_matrix_family`） | 同上结构，另含 `metadata/FILE-MANIFEST.txt`（逐件 sha256 + 字节数清单，2026-09-29 勘误轮补齐） | 同上 | 10.5281/zenodo.23047516 |
| `chorded-cycle-mod4/` | 圈 C_n 加全部 ⌊n/3⌋ 弦的匹配数按 n mod 3 三子族递推的模性质三定理（`cchordR2_mod_four`、`cchordR0_mod_four`、`cchordR1_even_iff`；语义桥属猜想层，未进 kernel） | 同上结构，另含 `metadata/FILE-MANIFEST.txt`（逐件 sha256 清单）与包内工具脚本 | 同上；查新证据 = C9 记录四段逐字抽取（含零命中查询与通道降级备忘） | 10.5281/zenodo.23047506 |
| `pendant-ladder-interleave/` | 阶梯图 pendant 匹配计数序列：八阶递推 = 奇偶两条同系数四阶子列的交织 + 三条伴随同余律（`apend_interleave`、`apend_mod2_period12`、`opend_mod2_period6`、`epend_mod2_period3`；语义桥属猜想层，未进 kernel） | 同上结构，另含 `metadata/FILE-MANIFEST.txt`（逐件 sha256 清单）与包内工具脚本 | 同上；查新证据 = C9 记录逐字抽取（含零命中查询） | 10.5281/zenodo.23047527 |
| `notchgrid-parity-mod/` | 3×n 缺口棋盘（挖除格）骨牌铺法计数的 a3/a4 两条递推序列：奇偶判定 + 模周期四定理（`a3_odd_iff`、`a4_odd_iff`、`a3_mod8_periodic`、`a4_mod4_eq2_iff`） | 同上结构，另含逐件 sha256 清单、四轮门③裁决书逐字副本与包内工具脚本 | 同上；C9 记录 7 区块逐字（含零命中查询） | 10.5281/zenodo.23047521 |
| `grid3n-diag-2notch/` | 3×n 棋盘挖右上+左下两格的骨牌铺法计数序列（七阶递推）：递推 = 奇偶两条同系数七阶子列的交织 + mod-2 周期 12 + 奇/偶子列 mod-2 周期 6（`adiag_interleave`、`adiag_mod2_period12`、`onotch_mod2_period6`、`enotch_mod2_period6`；语义桥属猜想层，未进 kernel） | 同上结构，另含逐件 sha256 清单与包内工具脚本 | 同上；C9 记录整文件逐字（OEIS 50+ 查询串零命中、四通道文献零同形、Oh 2019 全文通读、库层 total=0） | 10.5281/zenodo.23047626 |
| `grid3n-sidemid-notch/` | 3×n 棋盘挖最右列中格的骨牌铺法计数序列（六阶递推）：递推 = 奇偶两条同系数六阶子列的交织 + 奇 ⟺ n≡1 mod 3 + mod-4 周期 12（`asid_interleave`、`asid_mod2_period3`、`asid_mod4_period12`；语义桥属猜想层，未进 kernel） | 同上结构，另含逐件 sha256 清单与包内工具脚本 | 同上；C9 记录整文件逐字（含零命中查询；递推与 A033506 同谱、非新——围栏在短笺 novelty 节逐字） | 10.5281/zenodo.23047628 |
| `grid4n-col-2notch/` | 4×n 网格点阵挖最右列两角点的匹配计数序列（九阶递推）：递推 = 两条同签名九阶子列的交织（p(x)p(−x) 面）+ 奇 ⟺ n≡2,3 mod 5 + mod-4 周期 10（`atc_interleave`、`atc_mod2_period5`、`atc_mod4_period10`；语义桥属猜想层，未进 kernel） | 同上结构，另含逐件 sha256 清单与包内工具脚本 | 同上；C9 记录整文件逐字（含零命中查询；递推与 A033507 同谱、PM 子列 A129113 已挂名——两条围栏逐字在短笺） | 10.5281/zenodo.23047630 |
| `hosoya-prism-defect/` | n-棱柱图删一条横档/一条周长边的匹配数闭式双定理：等于两个已冻结的四阶递推序列 aspoke/arim（`hosoya_prism_del_spoke`、`hosoya_prism_del_rim`，n ≥ 3，通用 n；完整 Lean 证明随包 1857 行） | 同上结构（短笺 53 页含逐字冻结快照），另含逐件 sha256 清单与包内工具脚本 | Lean 4 kernel 全编译（通用 n 定理，非数值锚），公理 ⊆ {propext, Quot.sound, Classical.choice}；冻结 sha256 在包内；查新证据 = C9 记录三源逐字拼接（序列侧 41 条 + 图侧增量 31 条 + 复核确认，含零命中查询与 OEIS (2,4,0,−1) 签名页穷举） | 10.5281/zenodo.23080411 |
| `mossad42-01-half3/` | 3×n 圆柱面恰半覆盖计数：非零 ⟺ 8∣n + 闭式比 `b1_ratio`（`a1_ne_zero_iff`、`b1_ratio`） | 同上结构 | 同上；查新证据 = C9 记录逐字（四通道文献层含 OpenAlex 缺项显式声明） | 10.5281/zenodo.23078797 |
| `mossad42-02-mod3x3/` | 3×n 圆柱面 mod-3 计数序列：b2 mod 8 恒 1 + 交织桥 + 奇位零（`b2_mod8`、`a2_interleave`、`a2_even_zero`） | 同上结构 | 同上 | 10.5281/zenodo.23078801 |
| `mossad42-03-half4/` | 4×n 圆柱面恰半覆盖计数：五条互相咬合结构定理（`D4_pc_even`、`D4_h_even`、`a3_odd_eq_zero`、`a3_even_ne_zero`、`a3_ne_zero_iff`） | 同上结构 | 同上 | 10.5281/zenodo.23078807 |
| `mossad42-04-mod3x4/` | 4×n 圆柱面 mod-3 计数序列：mod-2 周期 15 + mod-3 周期 30（`a4_mod2_period15`、`a4_mod3_period30`） | 同上结构 | 同上 | 10.5281/zenodo.23078815 |
| `holestrip-tour/` | 洞条棋盘 Hamilton 路径/回路存在性双 iff 判据（`exists_hamiltonian_path_iff`、`exists_hamiltonian_cycle_iff`，通用 n 完全证明） | 同上结构（证明件 130KB 全文随包） | 同上；C9 记录整文件逐字 | 10.5281/zenodo.23078819 |
| `grid3n-colmid-indep/` | 三行网格条挖隔列中格独立集计数序列（六阶递推）：图-剖面桥双射 + 转移矩阵打包 + 证书多项式代数归约三路机器证明（`c_z_rec`；偶位子列与 A122011 逐项重合、签名 (12,−15,2) 已在册——两条围栏逐字在短笺） | 同上结构，另含逐件 sha256 清单 | 同上；C9 记录逐字（32 条联网零命中 + 阳性对照） | 10.5281/zenodo.23080740 |
| `hosoya-split-identity/` | 删边匹配分割恒等式（一般图装置）+ 棱柱实例（`hosoya_prism_split_spoke`，通用 n 完全证明；pool-comb-13 图侧升级的 Phase 0 库补全件） | 同上结构 | 同上；C9 记录逐字 | 10.5281/zenodo.23041704 |
| `ladder-pend3-interleave/` | 阶梯图 pendant 匹配计数序列 ap3：三受审定理（交织结构 `ap3_interleave` + mod-2 周期 15 + mod-4 周期 30；语义桥属猜想层，未进 kernel） | 同上结构 | 同上；C9 记录逐字（含零命中查询） | 10.5281/zenodo.23080747 |

## 工具链钉版

Lean v4.34.0 + mathlib4 v4.34.0（rev 5ed29652）；各包 `proofs/lean-toolchain` 为准。

## 披露

命题生成/形式化/证明搜索/文本草稿由 AI（LLM）流水线承担；全部命题与证明经 Lean 4 kernel 编译核验（0 sorry）；查新记录（C9 纪律，全量查询串）随包在 `audit/c9-record.md`。作者本人终审并对全部内容负责；AI 不列为作者。短笺 CC BY 4.0，代码 MIT。
