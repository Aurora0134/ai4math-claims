# claim-check.md — SOP 08b 工序 5 精简主张审计裁决书（claims/nfact-primorial-square）

> 裁决：dept-audit 只读工人（监察院），2026-10-06，kimi 端点，节点 anthropic/a6api-main/kimi-k3。
> 落盘：主代理按裁决回交原文要点落盘；裁决全程未改包内任何文件（复算脚本以补丁副本在 %TEMP% 运行）。

## 逐项核对（SOP 08b 工序 5 五项 + 批次特款）

1. **锚点 → 冻结快照 / 分级 / 审计证据：PASS**。全部 `% LEAN:` 锚点声明名真实存在于终件（rg 命中）；sha256 自算复核三件（statement.txt `0b13d08d…f8ea48`、statement.lean `63806420…451a8f`、终件 `276cb2e6…86070a`）与包内申报值逐字一致，`zenodo/proofs/` 副本同哈希；分级 = 完全证明（闸门三裁决书四项检查全 PASS、零 sorry、公理恰白名单）；审计证据随包（gate3 裁决书规范化副本 / welldef 裁决 / axioms.out 全白名单）。
2. **措辞 ≤ 分级 ∧ ≤ C9 裁决：PASS**。第二条缝明写 not claimed；#399 写明 DISPROVED 仅作同族邻接；2602.09687 限定「研究对象不含 n#」；失败集 {2,3,9,21} 带定义域口径 n ≥ 2；A055204 区分写明；novelty 节裁决与 C9 源记录一致；「zero hit is not novelty」自我限缩到位；引理 A 的 hn 未用、Berndt–Galway 不承重、无 OEIS 注册主张，逐条落实。
3. **lstlisting 逐字节：PASS**。重跑 `audit/verify-listings.py`（补丁副本）：lst:stmt（快照 fence 整段）、lst:chain、lst:tail、lst:main 四块全 MATCH byte-identical（各行段与字节数见随包 `audit/listing-verify.txt`），复算输出与该件逐字节相同。
4. **披露 / 署名 / PII：PASS**。作者栏 `Aurora0134` 两处一致（claim.tex `\author{}` 与 zenodo.json creators[0].name）；orcid 键不存在；披露四要素齐全；全树无本机用户名路径、无邮箱。
5. **c9-record.md 逐字一致：PASS**。重跑 `audit/build-c9-record.py`：Part 1 = 深挖草案卡行 113–138、Part 2 = 复核批报告行 61–68，两段与随包件逐字一致。
6. **批次特款（DOI 预留口径）：PASS**。全包无具体 DOI 号；README 为预留写法；无「已发布」既成事实表述。

## 观察项（不阻门；均已处置）

- **O1**：claim.tex 头注 `lst:tail` 行段 off-by-one（735-768 → 735-767）。**已修**（主代理，2026-10-06，注释级，不涉冻结产物与 listing 字节）。
- **O2**：`build-c9-record.py` 的 HDR 注记行与随包 c9-record.md 不同步。**已修**（重跑生成器，随包件 = 脚本输出，可逐字节复现）。

## 总判定

**AUDIT PASS（五项 + 特款零发现）**。分级裁定：短笺全部断言封顶于「完全证明（kernel 层，八条冻结 statement）+ 查无占位（强）」，措辞双上限无越级。

占位质检门状态：门① paper-lint exit 0；门② paper-compile（tectonic）exit 0；门③ 精简主张审计 = 本件 PASS；装配门 sanitize-package 全绿（gates 2,3,5,6,7 PASS，gate 4 按默认调用 SKIPPED）。
