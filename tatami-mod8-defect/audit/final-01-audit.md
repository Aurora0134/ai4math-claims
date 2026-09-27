# 闸门三·终态审计裁决存档（监察院 dept-audit，2026-09-26）

**总裁决：通过**（2 项簿记缺陷已按要整改，见末节整改记录）

## 对象
- 终稿：final/01-proof-complete.lean（整改后 sha256 = `b0f4a692990680e67817e0975484718132a6c54b9a1664598e44d9d0534789a1`，纯 LF）
- 基准：formalized/01-statement.lean（sha256 复跑 `59560f57…82b187f` 一致；statement 段级 `c2d28a0e…0842` 一致），基准未被事后改动。

## 逐项证据（监察院独立复跑）
1. **statement 对称差 = 零（内容级）**：两文件同法剥 proof body（自研状态机：遇 `:= by` 尾行进入丢弃态，至列 0 `/--|theorem|def` 止），剥后各 59 行，行数账目闭环（64−3sorry−2空行 = 59；198−137−2 = 59），59/59 行内容字符级全同。唯一字节差异 = CRLF（见缺陷①，已整改）。
2. **终态编译**：`bash scripts/lean-verify final/01-proof-complete.lean` strict → exit 0，诊断为空（实测 42.6s）。
3. **公理审计**（sidecar 合并 1 轮，用完已删）：`tatami_mod8_period4` = [propext, Classical.choice, Quot.sound]（恰白名单）；`bcorner_odd` = [propext, Quot.sound]（⊂）；`bcorner_eq` = [propext, Quot.sound]（⊂）；无 sorryAx。
4. **sorry/admit 文本扫描**：字节级全文（含注释）命中 0（第二道独立扫描）。
5. **过程一致性**：attempts/ 三件 proof body 与终稿三件全比（非抽查）逐字一致（P1 24 行 / P2 16 行 / P3 97 行，CRLF 归一后 byte-identical）；budget.log 账目与产物存在性相符。

## 分级（宪条 4）
三定理 tatami_mod8_period4 / bcorner_odd / bcorner_eq 均为**完全证明**（0 sorry、公理白名单内、statement 未动、strict exit 0）。任务级：**完全证明（三定理）**，严格限定为「递推定义版整数序列上的命题」，不覆盖任何组合计数含义。

## 措辞硬约束（外交部/论文部越级即违宪条 4）
1. 只能写「对递推定义版序列 a180970/bcorner 成立」；禁止写成「已证明 tatami 铺法计数的性质」。
2. bcorner = 角孔 tatami 计数的组合含义属**计算猜想层**（本机精确枚举探针 n≤20 + 转移矩阵一般理论），单列猜想不得并入已证结论；a180970 = A180970 = tatami 计数仅靠 OEIS 记录 + Erickson–Ruskey 文献背书，未形式化。
3. bcorner 基点 b(1)..b(9) 是机器枚举的**定义输入**，其与现实角孔序列的等同性属上条猜想层；b(0):=0 为约定值，任何定理不依赖它。
4. P1 按 n%4 四分支 (4,2,4,6) 书写；pat8 通配分支 `| _ => 6` 在 r≥4 时于假设 n%4=r 下不可达，勿引用该分支语义。
5. 报告须披露缺陷整改结果（LF 归一化 + 哈希口径），标注「AI 生成，kernel 验证」。

## 缺陷整改记录（主代理执行，2026-09-26）
- 缺陷①（CRLF）：已归一化为 LF（\r 计数 0）。**整改后 sha256 = b0f4a692…4789a1，恰与 budget.log 原记一致**——原哈希是对 LF 内容计算的正确值，盘上 CRLF 系 Windows 文本模式写入假影；矛盾消除，引用哈希不变。
- 缺陷②（sidecar 残留）：final/_axioms-sidecar.lean 已删除。
- 整改后严格复编：PASS（exit 0，诊断空）。
- 消耗：监察院编译 2 轮（≤3）；llm-call 0。
