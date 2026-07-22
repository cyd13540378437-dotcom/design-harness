# DesignHarnessAgent — Product Business Analysis Core PRD

- 版本：v0.1.2-alpha
- 状态：Codex 可执行规范
- Capability ID：`product-business-analysis`
- 产品名称：商业分析能力集群
- 架构：Agent-neutral standalone Core
- 本次主题：多轮决策连续性、商业问题连续性、统一结论与中文输出

## 1. 产品摘要

商业分析是一个面向大小业务情境的独立决策支持能力。它完整保留用户输入，持续恢复当前 Decision Case，挑战用户提出的解法前提，动态装配专业模型，执行反方分析和质量保障，并生成绑定 Case、证据边界和人类决定状态的中文结论。

它不是商业报告生成器，不是实施方案生成器，也不是其他能力的上游流水线。

## 2. v0.1.2 修正的问题

ARCOS 真实试运行暴露出：

1. 首轮创建 Case 正常，后续轮次未持续读取 `STATE.md` 与 Case，逐渐退化为普通咨询；
2. 输入理解阶段提前推荐“历史回放型模拟器”；
3. 用户带着“做模拟器”的解法进入，系统未先比较不做、更小验证和更重方案；
4. 专业分析和文件生产逐渐压过原始商业问题；
5. 最终结论滑向产品和实验规格，没有绑定 Case、Assurance 与用户确认状态；
6. 过程文件路径出现 `intake/` 和 Work Item 根目录漂移；
7. 人读输出需要明确中文版本合同。

## 3. Standalone Requirement

商业分析必须：

- 独立启动、独立结束；
- 拥有自己的 Decision Case、Work Item、Network、Evidence 与 Review；
- 不读取兄弟能力作为隐含权威；
- 不修改、触发或生成兄弟能力资产；
- 不创建共享 Work Item、Trigger 或 Downstream View。

## 4. Required Workflow

1. 新输入时完整保存第一次输入原文。
2. 只做输入理解与确认，不提前推荐解法。
3. 初次运行执行 Case 路由；多轮运行先恢复活动 BA Work Item。
4. 建立或恢复 Decision Anchor。
5. 选择 quick / standard / deep 分析深度。
6. 用户提出具体解法时执行 Solution Premise Challenge。
7. 只提出能造成 Decision Delta 的问题。
8. 接收、分类和筛选证据。
9. 选择模型，并记录预期 Decision Delta。
10. 执行 Analysis Runs，记录实际 Decision Delta 与相关性。
11. 剔除 `low_relevance / discarded` 结果。
12. 由统一决策综合器合并模型结果。
13. 执行反方分析。
14. 执行 Decision Assurance 和 Business Problem Continuity Check。
15. 生成一次中文、Case-bound 的阶段性结论。
16. 区分 acknowledged 与 confirmed，并更新 Case、State、Notes、Network 或 Review。

## 5. Follow-up Turn Continuity

存在相关 BA Work Item 时，每轮回复前最低读取：

```text
STATE.md
Primary Decision Case
最新 DECISION_ASSURANCE_CHECK.md
DECISION_NOTES.md（若存在）
最近 DECISION_SUMMARY.md 或 DECISION_PROCESS_PACKAGE.md（若存在）
```

Follow-up Turn Action：

```text
continue_current_case
add_evidence
check_understanding
record_user_decision
provide_case_bound_summary
reopen_or_review
candidate_new_case
no_case_needed
```

## 6. Decision Anchor

必须包含：

```text
原始商业问题
已确认商业问题
决策人
受影响业务参与者
期望业务结果
当前真实业务选项
当前阻塞决策的关键未知
证据边界
Assurance 状态
用户决定状态
```

## 7. Analysis Depth

### quick

低影响、一次性；不强制 Work Item。

### standard

需要多轮或持续记忆；创建 Work Item，只生成必要文件。

### deep

D2 / D3、重大投资、定价、市场、合规或需完整审计；生成完整过程包。

## 8. Solution Premise Challenge

用户提出模拟器、企业版、免费版等具体解法时，至少比较：

```text
维持现状 / 不做
更小、更低成本的验证路径
用户提出的解法
更高投入或更高保真的解法（若适用）
```

先形成商业选择，再讨论实施。

## 9. Model Card Contract

- Ready 模型卡：25 张；
- 每张卡具有 7 个非空 usage prompts；
- 新增 `decision_relevance_prompt`；
- `conclusion_prompt` 只供统一综合器内部使用；
- `user_input_prompt` 仅在答案会改变决定时调用；
- 每个 Analysis Run 必须记录 Decision Delta；
- 无 Decision Delta 的结果不得进入用户结论。

## 10. Output Contract

### 长期资产

```text
Decision Case
Decision Network
Evidence Ledger
Decision Review
```

### Work Item 根目录

```text
STATE.md
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_NOTES.md
DECISION_SUMMARY.md      # 按需
DECISION_PROCESS_PACKAGE.md          # deep / 复审 / 决定 / 审计时按需
```

### Work Item artifacts

```text
INPUT_UNDERSTANDING_SNAPSHOT.md
TURN_CONTINUITY_CHECK.md
ANALYSIS_ROUTING_RECORD.md
EVIDENCE_INTAKE_RECORD.md
MODEL_SELECTION_RECORD.md
ANALYSIS_RUNS.md
DECISION_ASSURANCE_CHECK.md
DECISION_SYNTHESIS.md
DECISION_NETWORK_UPDATE.md
```

`TURN_CONTINUITY_CHECK.md` 是条件性滚动检查点：每轮必须恢复状态，但只有 standard / deep、总结、决定、复审、范围变化或连续性风险时要求更新该文件；不得每轮创建新文件。

禁止：

```text
docs/product/business-analysis/intake/
Work Item 根目录中的过程文件
第二份 DECISION_CASE.md
```

## 11. Final Conclusion Contract

用户请求最终结论或本轮形成阶段性建议时，结论必须说明：

```text
当前商业问题
比较过的业务选择
当前推荐及理由
反方和不做后果
能证明什么 / 不能证明什么
证据边界
Assurance
结论状态
用户决定状态
验证与复审条件
来源 Case 与 Work Item
```

最后必须以用户业务选择收尾。

## 12. Chinese Output Contract

- 用户可见回复默认简体中文；
- 所有项目级人读 Markdown 输出必须有完整中文内容；
- 英文可用于稳定 ID、状态枚举、文件名、YAML key 和内部 Prompt；
- 用户要求英文时，可额外生成英文，但中文版本不能缺失。

## 13. Human Decision

D0–D3 分级不变。用户决定状态：

```text
not_requested
pending
acknowledged
confirmed
rejected
revised
```

D2 / D3 confirmed、superseded、deprecated、sealed 必须有明确用户决定。

## 14. Definition of Done

- Core / Adapter / Project Assets 三层完整；
- 模块独立；
- Follow-up Continuity 与 Decision Anchor 完整；
- quick / standard / deep 完整；
- 25 张 ready 模型卡通过 7-prompt 校验；
- Analysis Run 包含 Decision Delta；
- 单一统一结论出口；
- `DECISION_SUMMARY.md` 完整；
- 所有过程文件路径规范；
- 中文输出合同完整；
- ARCOS 回归示例完整；
- 原有评测全部保留并扩展为 34 个场景；
- 无跨模块 Trigger、Downstream View、共享 Work Item、CLI、Hook、Plugin、Installer 或外部依赖。
