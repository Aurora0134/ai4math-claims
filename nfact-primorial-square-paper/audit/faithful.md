<!-- AI 生成（dept-formalize 工人，2026-10-06，kimi 端点 anthropic/a6api-main/kimi-k3；宪条 6 标注） -->
# Roundtrip 忠实性记录：nfact-primorial-square

- statement 文件：`formalized/nfact-primorial-square.lean`（8 条 statement，proof body 全 `:= by sorry`）
- 裁判 prompt 原文：`formalized/roundtrip-prompt.md`；裁判回执原样落盘：`formalized/roundtrip-reply.md`
- 编译良定义（kernel）：`scripts/lean-verify --allow-sorry` **EXIT=0**（0 error；8 条 sorry 警告为占位，符合预期）。**编译通过 ≠ 忠实**，忠实性以本文件 roundtrip 记录为准。

## 一、statement 清单与回译原文（生成方自译）

编号与 `.lean` 文件对应：

| # | Lean 声明名 | 回译 NL′ |
|---|---|---|
| S1 | `isSquare_factorial_mul_primorial_iff (n : ℕ) : IsSquare (n ! * primorial n) ↔ n ≤ 5` | 对任意自然数 n，「n!·n# 是完全平方数」当且仅当「n ≤ 5」。 |
| S2 | `exists_sq_factorial_mul_primorial_iff (n : ℕ) : (∃ x : ℕ, x ^ 2 = n ! * primorial n) ↔ n ∈ ({0,1,2,3,4,5} : Finset ℕ)` | 对任意自然数 n，「存在自然数 x 使 x² = n!·n#」当且仅当「n ∈ {0,1,2,3,4,5}」。 |
| S3 | `isSquare_iff_all_factorization_odd (n : ℕ) (hn : 1 ≤ n) : IsSquare (n ! * primorial n) ↔ ∀ p : ℕ, p.Prime → p ≤ n → Odd ((n !).factorization p)` | 对任意自然数 n ≥ 1，「n!·n# 是完全平方数」当且仅当「对每个满足 p ≤ n 的素数 p，ν_p(n!) 为奇数」。 |
| S4 | `exists_prime_between_div_three_and_div_two (n : ℕ) (hn : 22 ≤ n) : ∃ p : ℕ, p.Prime ∧ n / 3 < p ∧ p ≤ n / 2` | 对任意整数 n ≥ 22，存在素数 p 使 ⌊n/3⌋ < p ≤ ⌊n/2⌋。 |
| S5 | `witnesses_zero_to_five : 1^2 = 0!*primorial 0 ∧ … ∧ 60^2 = 5!*primorial 5` | 六个等式 1²=0!·0#、1²=1!·1#、2²=2!·2#、6²=3!·3#、12²=4!·4#、60²=5!·5# 同时成立（n=0..5 的见证 x=1,1,2,6,12,60）。 |
| S6 | `primorial_factorization_eq_one {p n} (hp : p.Prime) (hpn : p ≤ n) : (primorial n).factorization p = 1` | 对素数 p ≤ n，ν_p(n#) = 1。 |
| S7 | `primorial_factorization_eq_zero {p n} (hp : p.Prime) (hpn : ¬ p ≤ n) : (primorial n).factorization p = 0` | 对素数 p > n，ν_p(n#) = 0。 |
| S8 | `factorization_factorial_mul_primorial {p n} (hp : p.Prime) (hpn : p ≤ n) : (n ! * primorial n).factorization p = (n !).factorization p + 1` | 对素数 p ≤ n，ν_p(n!·n#) = ν_p(n!) + 1。 |

## 二、形态取舍理由（任务书 §2.1 义务：两形态都给 + 等价性点明）

1. **主定理为何两形态并列**：任务卡 §一.2 指定 iff 形态 `IsSquare (n ! * primorial n) ↔ n ≤ 5`（S1）；NL 原文措辞「丢番图方程 x² = n!·n# 的解恰为 n ∈ {0,…,5}」更贴近存在形态（S2）。二者并列交付，互不替代。
2. **ℕ 上 `n ≤ 5 ⟺ n ∈ {0,1,2,3,4,5}`**：本任务 ℕ 含 0（mathlib 惯例），故 `n ≤ 5` 与 `n ∈ {0,1,2,3,4,5}` 逐点等价——S1 与 S2 的右端语义相同。
3. **`IsSquare a ⟺ ∃ x, x² = a`**：mathlib `IsSquare a := ∃ r, a = r * r`（Mathlib/Algebra/Group/Even.lean:57），经 `isSquare_iff_exists_sq`（同文件 :130）得 `∃ r, a = r ^ 2`；等式方向 `a = r^2` 与 S2 的 `x^2 = a` 由等式对称性等价——S1 与 S2 的左端语义相同。
4. **「对应 x = 1,1,2,6,12,60」的落点**：由见证层 S5 承载（固定 n 时 x² = m 在 ℕ 上至多一解，逐点见证即完整表达对应关系；裁判回执覆盖性判定同此）。
5. **引理 B 的整除区间解读**：Lean 中 `n / 3`、`n / 2` 为自然数整除。对整数 p 恒有「n/3 < p（实数解读）⟺ ⌊n/3⌋ < p」与「p ≤ n/2（实数解读）⟺ p ≤ ⌊n/2⌋」，故 S4 与 NL 引理 B 的素数存在性语义一致（该等价性已写入 S4 的 docstring 并作为裁判背景约定）。
6. **辅助 statement（S6–S8）**：NL 原文未逐字给出，为任务书 §2.5 允许的路线辅助件（形态复用 C8 冒烟件已 0 sorry 编译的 `D2Smoke` 三件），支撑引理 A 的证明路线，不改变主命题/引理 A/引理 B 的语义。

## 三、裁判调用与判定（roundtrip）

- **裁判渠道**：端点原生只读裁判子代理（kimi 端点当前会话节点 `anthropic/a6api-main/kimi-k3`，explore 只读型，隔离上下文、裁决回交）——同节点自裁，独立性风险按宪条 7 由 kernel 终裁 + 人工抽检对冲。
- **机制漂移留痕（如实记录）**：任务书 §4.4 原指定 `python scripts/llm-call.py anthropic/a6api-main/kimi-k3`；三次同参调用均 HTTP 502（上游故障，stderr 落 `roundtrip-reply.err`：「the upstream provider returned status 502」；调用时刻约 2026-10-06 01:47–01:52 +0800）。随后核到 AGENTS.md 宪条 7 已于 2026-10-06 修订：`scripts/llm-call.py`、`scripts/attempt.sh`、`harness/config.json` 别名表同日退役删除，判断类调用新形态 = 端点原生只读裁判子代理或主代理会话内裁定。遂按现行宪条 7 改派裁判子代理；节点不变（子代理继承端点默认模型 = 当前会话节点），满足「禁跨节点」。
- **判定结果**：逐条 S1–S8 全「一致」；覆盖性判定主命题 / 引理 A / 引理 B 全「覆盖」；**总判定：一致**。回执全文见 `roundtrip-reply.md`。
- **不一致处修改理由**：无（裁判未发现任何不一致，statement 未因 roundtrip 改动）。

## 四、任务卡 §一.4 引用措辞义务核对（对本文档生效部分）

1. 2606.23485 §5.3.1 与 2610.01899 的必引义务：本文档非相关工作节，不涉及；下游论文/占位包生效。
2. erdosproblems #399 不作开放锚点：本文档未引用 #399 ✓。
3. 「2602.09687 研究对象不含 n#」限定措辞：本文档未引用该文 ✓。
4. 区间素数引理失败集 `{2,3,9,21}` 定义域口径 **n ≥ 2**（n=0,1 亦失败、为空区间）：本文档未列失败集；在此按义务注明口径，供下游引用时遵守 ✓。
5. A055204（squarefree part of n!）区分义务（最小 a vs 特定取值 a = n#）：本文档未引用 A055204；在此按义务声明：本命题问 `a = n#` 这一特定取值使 `n!·a` 为平方的完全解集，**不是** A055204 的最小补因子问题的实例 ✓。
