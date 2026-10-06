# paper-check.md — SOP 08 工序 6 主张审计裁决书（papers/nfact-primorial-square）

> 裁决：dept-audit 只读工人（监察院），2026-10-06，kimi 端点，节点 anthropic/a6api-main/kimi-k3。
> 落盘：主代理按裁决回交落盘；裁决全程未改包内任何文件（判据 = 审计独立重跑的机械输出，不采信装配轨自报）。
> 带全部数值的完整版存批次目录 `tasks/20261006-paper-nfact-primorial/audit/paper-audit-verdict-full.md`。

## 逐项裁定（工序 6 五项 + 批次特款两项）

1. **锚点 → 冻结快照 / 分级 / 审计证据：PASS**。全部 `% LEAN:` 锚点（paper.tex L231/237/243/249/255/265/266/267）声明名 = 冻结八条逐字一致，grade 全 = 完全证明，与闸门三裁决书「★ 分级结论：完全证明 ★」一致。冻结快照 sha256 自算 `0b13d08d…f8ea48`、终件 `276cb2e6…86070a`，与论文卡及正文 §Verification 逐字一致；审计证据（welldef / 终裁书）亲读确认并随包（规范化副本）。
2. **措辞强度 ≤ 分级 + 重点围栏：PASS**。全文无越级断言（we prove/we establish/novel/previously unknown 零命中；「first」均为序数语义或否定式）。围栏逐条落实：第二条缝不主张（L124 + Limitations(b)）；#399 标 DISPROVED 仅同族邻接（反例数值本审计复算吻合）；2602.09687 限「研究对象不含 n#」；失败集 {2,3,9,21} 带定义域 n ≥ 2；A055204 区分写明；Nagura 带「原文未取得」限定；Berndt–Galway 仅背景不承重。参考数值抽验（60²=3600、6!·6#=21600、3·409609−1=1228826、证书链计数）全部吻合。
3. **lstlisting 逐字节：PASS（双通道）**。重跑包内 `audit/verify-listings.py` 全 MATCH（lst:stmt / lst:chain / lst:tail / lst:main / lst:axioms 五块）；审计自算 diff 独立复核 lst:stmt / lst:chain / lst:tail 三块 diff 为空。zenodo 树副本 sha256 全对上源件（gate3 副本仅路径前缀规范化，已披露）。
4. **`\lean{}` 标识符实存：PASS**。自 paper.tex 抽取去重标识符逐个 `grep -qF` 终件，全部 IN（清单与 `audit/lean-idents.txt` 一致）。
5. **披露节 / 署名 / PII：PASS**。四要素齐全 + CRediT + Data availability；作者栏两处一致 = `Aurora0134`；zenodo.json 无 orcid 键；全包 PII 扫描零命中。
6. **批次特款 A（roundtrip 抽检，工序 3 口径）：一致 ×3**。①§Encoding decisions 的 iff/存在见证双形态散文 ↔ 冻结声明 L41–42/46–47 + 桥接引理，逐项对应；②§Background 的「2p ≤ n < 3p ⟹ ν_p(n!)=2（p²>n 消高次项）+ 引理 B 存在性」↔ 冻结引理 B + 终件组装段，ℕ 口径吻合；③引理 A 散文 ↔ `isSquare_iff_all_factorization_odd (hn : 1 ≤ n)`，hn 未用已在 Limitations(e) 如实披露（「判据成立」非「需要 n ≥ 1」）。三句全部语义一致。
7. **批次特款 B（DOI 口径）：PASS**。无 arXiv 编号占位（UPLOAD.md 仅一处否定性说明）；Data availability 引占位包概念 DOI `10.5281/zenodo.23177003`（paper.tex / bibitem / zenodo.json 三处一致）；zenodo.json 无 `<<>>` 占位；论文自身 DOI 为预留口径，无既成事实表述。

## 机器门禁复核

门① lint PASS；门② tectonic exit 0（`Missing character` / `Overfull \hbox` / `??` 三零）；机械对账门全绿（gate 4、1 按口径 SKIPPED，未虚报全绿）。0 sorry 独立重扫终件：sorry/admit/axiom/unsafe/opaque/native_decide/implemented_by 零命中；随包 `zenodo/audit/axioms.out` 八条全 = [propext, Classical.choice, Quot.sound]，无 sorryAx。

## 观察项（非发现，不阻签发）

1. zenodo.json 单 license 字段 = MIT；论文 CC BY 4.0 的 UI 多许可补加留作者（README 已披露）。
2. §sec:refuted（Bertrand 拼接路否证）以叙事 + 证据范围限定呈现、未占用 theorem 环境，Limitations(j) 已声明数值证据分层——口径合规，作者发布前知悉其为「方法级否证」而非定理。

## 必须披露的限定语（沿用，勿稀释）

第二条缝未主张 / Nagura 原文未取得 / Berndt–Galway 不承重 / C9 零命中 = 「所查渠道无占位记录」而非绝对新颖性 / 引理 A 的 hn 未用 / docstring 三处注释级追加 / 无 OEIS 注册主张 / 无「首个形式化」陈述 / arXiv 不在本批。

## 总判定

**AUDIT PASS（零发现）。** 成文质检门状态：门① paper-lint exit 0；门② paper-compile exit 0；门③ 主张审计 = 本件 PASS。
