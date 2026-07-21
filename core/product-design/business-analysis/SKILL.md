---
name: business-analysis
description: 面向业务情境的独立决策支持 Skill。用于商业想法、业务困境、定价、流程规则、资源投入、客户市场、收入成本、投资判断和既有决策复审。保留原始输入，创建或更新 Decision Case，动态调用 Analysis Model Cards，执行反方分析与质量保障，输出选择题式结论和可复审的决策过程包。
---

# Business Analysis Skill v0.1.1

## 1. Purpose

本 Skill 不生成泛化商业报告，也不把用户问题自动拉入固定生产线。它帮助用户把业务情境中的模糊输入推进成可选择、可审查、可验证、可复审的 Decision Case。

本 Skill 完全独立运行。不得把其他能力当成上游、下游或隐含依赖；不得自动启动或修改其他能力。

## 2. Required Workflow

```text
用户输入
  ↓
1. Input Understanding
  ↓
2. Analysis Routing
  ↓
3. Decision Case / Work Item Binding
  ↓
4. Next Best Question
  ↓
5. Evidence Intake
  ↓
6. Model Selection
  ↓
7. Analysis Runs & Cross-model Synthesis
  ↓
8. Counterfactual & Opposition Analysis
  ↓
9. Decision Assurance Check
  ↓
10. Choice-style Conclusion / Human Decision
  ↓
11. Decision Process Package / Decision Network / Review
```

### Step 1：输入理解

- 完整保存用户第一次输入原文。
- 只分析用户在说什么、可能的选择题和歧义。
- 不在本步骤判断新旧 Case。
- 高歧义或高影响问题必须等待用户确认；低风险问题可记录明确假设后继续。
- 输出 `INPUT_UNDERSTANDING_SNAPSHOT.md`。

### Step 2：分析路由

理解确认后，返回一种路由结果：

```text
create_new_case
continue_existing_case
add_evidence_to_case
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
no_case_needed
```

生成 `ANALYSIS_ROUTING_RECORD.md`，说明候选 Case、最终选择、理由、排除项、置信度和下一步。

### Step 3：绑定 Decision Case 与 BA Work Item

- Decision Case 的唯一权威文件位于 `docs/product/business-analysis/decision-cases/`。
- BA Work Item 位于 `docs/product/business-analysis/work-items/BA-xxx/`。
- Work Item 通过 `STATE.md` 链接 primary Decision Case，不复制 `DECISION_CASE.md`。
- 一个 Case 可以被多个后续 Work Item 更新或复审。

### Step 4：下一最佳问题

- 每次最多提出 1–2 个信息增益最高的问题。
- 优先选择题或具体案例，不给用户长问卷。
- 说明问题为什么重要。
- 允许用户回答“不确定”“按你的临时假设继续”“我讲一个案例”“不适用”。

### Step 5：材料与证据接收

- 新文字、附件、数据、访谈和案例必须在已确认 Case 范围内分类。
- 分类为：线索、事实、假设、证据、解释、偏好、约束。
- 相关性低时提供：弃用 / 弱相关保留 / 新建 Case 三种选择。
- 生成 `EVIDENCE_INTAKE_RECORD.md`。

### Step 6：模型选择

- 从 `model-cards/index.yml` 检索候选模型。
- 不得看到关键词就套模型。
- 检查 `use_when / avoid_when / required_inputs / minimum_viable_inputs / common_misuses`。
- 生成 `MODEL_SELECTION_RECORD.md`，同时记录考虑但未使用的模型。

### Step 7：专业分析

每次实际使用模型卡，必须执行卡片中的：

```text
routing_prompt
user_input_prompt
execution_prompt
analysis_run_prompt
conclusion_prompt
misuse_guard_prompt
```

每次运行生成 Analysis Run，并写入 Decision Case 第 8 字段和 Work Item 的 `artifacts/ANALYSIS_RUNS.md`。

### Step 8：反方分析

所有非纯记录 Case 默认执行：

```text
不做会损失什么
做了会增加什么成本和风险
当前建议为什么可能错
更小、更可逆的选择是什么
维持现状何时更合理
```

### Step 9：质量保障

执行 `DECISION_ASSURANCE_CHECK.md`，结果只能为：

```text
pass
warn
block
```

`block` 时不得输出最终建议，只能输出补证据、缩小范围、先验证或暂缓的选择题。

### Step 10：选择题式结论与人类决定

- 尽可能输出 A / B / C / D。
- 每个选项说明适用条件、价值、代价、风险和可逆性。
- 明确区分系统推荐、用户决定和尚未确认。
- D2 / D3 决定必须进入 Human Decision Request，并写入 `DECISION_NOTES.md`。

### Step 11：过程包与决策记忆

完成本轮后更新：

```text
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_NOTES.md
DECISION_PROCESS_PACKAGE.md
Decision Case
Decision Network
必要时 Decision Review
```

## 3. Output Contract

### 用户可见

- Input Understanding Feedback
- Next Best Question
- Choice-style Conclusion
- Human Decision Request
- Validation / Review Options

### 过程输出

- Input Understanding Snapshot
- Analysis Routing Record
- Evidence Intake Record
- Model Selection Record
- Analysis Runs
- Decision Assurance Check
- Decision Network Update

### 长期资产

- Decision Case
- Decision Network
- Evidence Ledger
- Decision Review

### Work Item 资产

- STATE.md
- ANALYSIS_CONSUMPTION.md
- ANALYSIS_OUTPUT.md
- DECISION_NOTES.md
- DECISION_PROCESS_PACKAGE.md
- artifacts/*

## 4. Human Decision Boundary

影响等级：

```text
D0 机械同步
D1 可逆局部判断
D2 核心业务选择
D3 战略、财务、合规或不可逆选择
```

AI 可以自动生成 draft / provisional。D2 / D3 的 confirmed、superseded、deprecated、sealed 必须有明确用户决定。

## 5. Hard Prohibitions

- 不得丢失或改写第一次输入原文。
- 不得在输入理解前路由。
- 不得在 Work Item 内复制第二份 Decision Case。
- 不得用模型名称代替实际 Analysis Run。
- 不得缺少关键输入却伪造 NPV、IRR 或其他数值结论。
- 不得跳过反方分析和复审条件。
- 不得把系统建议写成用户决定。
- 不得静默覆盖 confirmed 或 sealed 历史。
- 不得创建跨模块 Trigger、下游视图或其他能力的任务。
- 不得修改任何其他能力的 Core、Adapter 或 Project Assets。
