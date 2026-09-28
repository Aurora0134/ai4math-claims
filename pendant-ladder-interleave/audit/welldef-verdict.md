# 闸门二裁决（宪兵 dept-welldef，agent-103，2026-09-27/28）— pend 线

## 总裁决

**通过**（良定义成立、非退化、口径合规、命题非假）：冻结件 `formalized/01-pend-statements.lean`（6 def + 4 theorem，T1 主攻 + T2/T3 伴随）准予进入军政部攻证段，statement 即日进入冻结状态（sha256 `78bccc97…f922`，快照 `formalized/01-pend-statements.statement.txt`）。

---

## 逐维度裁决

### a. 良定义 —【通过】

| 检查项 | 结果 | 证据 |
|---|---|---|
| 验身 | sha256 = `78bccc97afba79adea9658a2158d17b2ed247b584d9f28266e6fc7914ba9f922`，与派发值及 roundtrip.md 记录一致；113 行无误 | `sha256sum` 实测 |
| 快照一致 | `01-pend-statements.statement.txt` 与冻结件逐字节一致（diff: IDENTICAL，同 sha256） | diff 实测 |
| 基座↔冻结件逐字 | 程序化抽取冻结件 13 个 def/theorem 文本块，逐一为 4 个 gate 基座的 verbatim 子串：**13/13 VERBATIM OK**（t1: apend/opend/epend/T1；t2: apend/pat2/T2；t3o: opend/pat6/T3o；t3e: epend/pat3/T3e），无基座脱节 | python 块比对 |
| **全文复跑（独立裁决，不信自报）** | `lean-verify --allow-sorry` 冻结件全文：**exit=0，120s，0 error**，输出仅 4 行 `warning: declaration uses sorry`（行 67/88/105/111 = 四条 theorem 占位体）——WELLDEF OK 由宪兵复现 | compile-1 |
| 既有 gate 报告 | WELLDEF OK ×4（gate-{t1,t2,t3o,t3e}.txt），无 error 诊断 | 逐份复核 |
| #check 引理预检 | 全部 OK、无 NOTFOUND；**记账勘误（非阻塞）**：实际 CHECK 行 = 3+6+6+6 = **21/21 OK**，budget.log 与派发文写「15/15」系笔误，已请主代理订正注记 | grep 计数 |

### b. 退化检测 —【通过（非退化）】

- **探针池合计 33/33 FAIL**（无任何单 tactic 秒杀）：原 gate-batch 8 探针 ×4 定理 = 32 全 FAIL（nlinarith/norm_num/simp/ring_nf/positivity/omega/linarith/decide）。原探针清单缺 SOP 默认 9 探针中的 `ring`——恰是对 T1 最危险的 tactic；宪兵用第 2 次编译补测：gate-batch（t1 基座，probes=ring）→ WELLDEF OK / PROBE ring FAIL（compile-2，194s），缺口坐实闭合（报告 `audit/ringprobe/gate-t1-ring.txt`）。
- 逐定理评估（无 ≤3 步自动化捷径）：
  - **T1 `apend_interleave`（∀k:ℕ 交织恒等式）**：无穷域 decide 不可；omega 不识递归 def；ring/ring_nf 被原子 apend(2k)≠opend k 挡死（ring FAIL 已实证）。需强归纳 + 模式匹配 def 等式引理展开 + IH 改写 + ring 级闭合。**非退化**（诚实注记照录 claims.md §T1(d)：数学内容为递推奇偶分解，难度在形式化工程，非代数深度）。
  - **T2（mod 2 周期 12）/T3o（周期 6）/T3e（周期 3）**：结论含 ℤ 上递归 def 的 `Int.emod`，decide/norm_num/ring 类均不适用；∀n 归结必须归纳。mod 2 为素，合数模环化 decide 探针字面不适用。**非退化**。
- **pat2 通配分支专项（是否构成退化漏洞）**：前提 `(hr : n % 12 = r)` 结合 `Nat.mod_lt` 钉死 r<12；通配仅在 r=11 可达且 ↦1 恰为正确余数（数值核验吻合），r≥12 不可达。通配不降低 ∀n 全称难度，**不构成退化漏洞**。交叉一致：pat2 的 1 位集合 {0,3,5,8,9,11} = T3o/T3e 经 T1 交织之并（偶位 n≡0,8 ← pat6 的 {0,4}；奇位 n≡3,5,9,11 ← pat3 的 {1,2}），四定理互相咬合。

### c. 口径一致 —【通过】

- 组合对象词扫描（`图|梯子|匹配|悬挂|叶|graph|ladder|match|pendant|leaf` 大小写覆盖）：**0 命中**（与 roundtrip.md 自报独立复核一致）。
- 占位围栏已进文件头：L12–15 纯序列口径 + 0↔1-based 映射写死；**L17–20【占位围栏】**opend=A386889（已占位、核到 k=15）、新颖性限「完整 order-8 递推 + 偶数子列（epend 侧）」、禁「新序列」泛写；L44 opend docstring 再次标注占位。
- T3 取**订正后**形态（pat6: 1⟺k≡0,4 mod 6；pat3: 0⟺k≡0 mod 3），与 claims.md「主代理复核订正」节一致；旧口径（k≡1,5 / k≡1）未残留。

### d. 假命题排除 —【通过】（python 独立复算，0 compile）

按冻结 def 逐字镜像复算（lru_cache 递归）：
- **初值/递推 ↔ counts.txt 逐位一致**：apend(0..29)==a(1..30) 全 30 位 PASS；opend(0..14)==奇位行、epend(0..14)==偶位行 PASS。
- **T1/T2/T3 有限窗口全真**：T1 k=0..14（覆盖 apend n≤29）PASS；T2 n=0..29 PASS；T3o k=0..14 PASS；T3e k=0..14 PASS。
- **最小周期**（窗口测定）：apend%2 最小周期 **12**（P∈{1,2,3,4,6} 全部证伪、P=12 成立）；opend%2=**6**；epend%2=**3**——与 fit.md §5 首回初态测定及 GF(2) 因式分解 `x⁸+16x⁶+25x⁴+10x²+1 ≡ (x²+x+1)⁴ | x¹²−1` 的代数互证一致。
- 反证意义：若 T3 仍为订正前形态，本核验将 FAIL——订正必要且已正确落入冻结件。

---

## 宪兵耗材

llm 0；compile 2（审计隔离）：

| # | 命令 | 结果 | 计时/退出码 |
|---|---|---|---|
| 1 | `source scripts/lake-env.sh && bash scripts/lean-verify --allow-sorry tasks/20260927-mossad-pend/formalized/01-pend-statements.lean` | WELLDEF OK（0 error，4 sorry warning） | 120s / exit 0 |
| 2 | `bash scripts/gate-batch.sh --base tasks/20260927-mossad-pend/audit/gate-t1.lean --probes "ring" --out tasks/20260927-mossad-pend/audit/ringprobe/gate-t1-ring.txt` | WELLDEF OK / PROBE ring FAIL | 194s / exit 0 |

---

## 移交军政部提示

1. **证明骨架建议关键词**（仅供参考方向，**不构成引理名背书；每个引理名/签名使用前 kernel `#check` 义务在攻证侧**，宪条·失败处理第 1 条）：
   - **T1**：`Nat.strong_induction_on` 对 k 强归纳、两联言同证；k≥4 时把 `2*k` 改写为 `(2*k-8)+8` 形态展开 apend 一步，IH 改写为 opend/epend 四项右端，`ring`/`linarith` 闭合；k∈{0..3} 共 8 个数值基例 `norm_num`/`decide` + def 等式引理；指标工程 `omega`；注意模式匹配 def 的等式引理（equation compiler 生成）展开方式与 ℕ→ℤ 提升。
   - **T2**：强归纳 n（n≥8 步），系数 mod 2 化为 `a(n) ≡ a(n−4) + a(n−8)`；留数侧用 `interval_cases` r∈{0..11} + `Nat.mod_eq_of_lt`/`Nat.mod_lt`（r<12 由 hr 推出，通配分支因此无害）；ℤ 奇偶搬运链 Int.add_emod/Int.sub_emod/Int.mul_emod/Int.neg_emod/Int.emod_nonneg（gate 已 #check 存（非背书））。备选形态：先证 12 周期不变式再列 12 留数表。
   - **T3o/T3e**：同型；k≥4 时 `o(k) ≡ o(k−2) + o(k−4) (mod 2)`（e 同式），留数表 6 项 / 3 项。
2. **「终稿全文（含注释）不得出现字面 `sorry`」提醒适用于终稿新文件**：冻结件含 5 处字面 sorry（4 处 proof body 占位 L69/90/107/113 + **文件头注释 L22 反引号内 1 处**）。终稿若以本文件为底衍生，L22 注释行必须改写或删除，否则监察院 grep 兜底会误伤。
3. T2 statement 保持现状即可（r 由 hr 钉在 <12，无需加强）；若证明侧嫌通配碍事，可在 proof 内先导 r<12，statement 文本**严禁改动**（宪条 2）。
