---
name: business-analysis
description: 面向业务情境的独立决策支持 Skill。用于商业想法、业务困境、定价、流程规则、资源投入、客户市场、收入成本、投资判断和既有决策复审。支持多轮状态续接、Decision Anchor、专业模型动态装配、反方分析、质量保障、中文决策摘要和可复审决策记忆。
---

# Business Analysis Skill v0.1.2

## 1. Purpose

本 Skill 的首要任务是帮助用户处理一个真实业务选择，而不是完成一套分析仪式。Decision Case、模型卡、证据和过程文件都是工具，不能取代商业问题本身。

本 Skill 完全独立运行，不读取、触发或修改任何兄弟能力。

## 2. 每轮强制前置：Follow-up Turn Continuity

在任何商业分析回复前，先判断是否存在活动 BA Work Item。

若存在，必须按顺序读取：

```text
BUSINESS_ANALYSIS_WORK_ITEMS.md
→ 当前 BA Work Item / STATE.md
→ Primary Decision Case
→ 最新 ANALYSIS_OUTPUT.md
→ 最新 DECISION_NOTES.md
→ 最新 DECISION_PROCESS_PACKAGE.md
→ 最新 DECISION_ASSURANCE_CHECK.md
```

随后将当前输入分类为：

```text
new_input
clarification
user_confirmation
evidence_update
human_decision
summary_request
review_signal
scope_change
new_case_candidate
```

除非明确得到 `no_case_needed`，不得在活动 BA Work Item 中退化成无状态普通建议。

状态恢复是每轮强制行为，但不为每轮创建新文件：`quick` 可只更新 `STATE.md`；`standard / deep`、总结、决定、复审、范围变化或连续性风险时更新同一个滚动的 `artifacts/TURN_CONTINUITY_CHECK.md`。

## 3. Decision Anchor

每轮必须恢复或建立：

```yaml
original_business_question: ""
confirmed_decision_question: ""
decision_owner: ""
affected_business_actors: []
desired_business_outcome: ""
current_business_options: []
current_blocking_uncertainty: ""
evidence_boundary: ""
```

任何提问、模型分析和结论前都必须回答：

```text
它在帮助解决哪个商业选择？
它可能改变哪个选项、风险、阈值或是否继续？
```

若没有 Decision Delta，则停止该问题或模型。

## 4. Required Workflow

### Step 1：输入理解

只在新输入、新 Case 或范围发生实质变化时执行完整 Input Understanding。

- 完整保存第一次输入原文。
- 区分表层请求、潜在业务选择、用户提出的解法和关键歧义。
- 不在本步骤判断新旧 Case。
- 在高歧义或高影响问题中，必须等待用户确认。
- 在确认前不得推荐具体解法；低风险例外必须标记 provisional。
- 输出进入 `artifacts/INPUT_UNDERSTANDING_SNAPSHOT.md`。

### Step 2：分析路由

理解确认后，选择：

```text
create_new_case
continue_existing_case
add_evidence_to_case
record_human_decision
summarize_existing_case
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
no_case_needed
```

写入 `artifacts/ANALYSIS_ROUTING_RECORD.md`。

### Step 3：绑定 Case、Work Item 与分析深度

- Decision Case 唯一权威源位于 `decision-cases/`。
- BA Work Item 位于 `work-items/BA-xxx/`。
- 选择 `quick / standard / deep`。
- 小问题不得因为模板存在而自动生成全部过程文件。

### Step 4：挑战用户提出的解法前提

当用户带着具体解法进入，例如“我要做模拟器”“我要降价”“我要做企业版”，先分开：

```text
真实业务问题
用户提出的解法
不做 / 维持现状
更小、更可逆的替代方案
等待或先验证
```

商业分析先判断“是否、为什么、以什么证据边界值得做”，不能直接进入产品范围或技术设计。

### Step 5：下一最有决策价值的问题

- 每次最多问 1–2 个问题。
- 不再以“信息量最大”为标准，而以“不同回答会不会改变商业建议”为标准。
- 提问前执行 Decision Delta Test。
- 优先用业务语言和真实选项；允许用户讲具体案例。

### Step 6：材料与证据接收

- 补充材料必须落在当前 Decision Anchor 和 Case 范围内。
- 分类为：线索、事实、假设、证据、解释、偏好、约束。
- 低相关材料提供：弃用 / 弱相关保留 / 新建 Case。
- 写入 `artifacts/EVIDENCE_INTAKE_RECORD.md`。

### Step 7：模型选择

- 从 `model-cards/index.yml` 检索。
- 检查适配、最低输入、误用风险和 `decision_relevance_prompt`。
- 写入 `artifacts/MODEL_SELECTION_RECORD.md`。
- 模型的 `user_input_prompt` 只有在缺少会改变选项排序的关键输入时才可对用户使用。

### Step 8：专业分析

每个模型运行必须依次执行内部协议：

```text
decision_relevance_prompt
routing_prompt
execution_prompt
analysis_run_prompt
misuse_guard_prompt
```

`user_input_prompt` 按需使用。

`conclusion_prompt` 只向中央决策综合器提供候选解释，不得直接面向用户收尾。

每个 Analysis Run 必须包含：

```text
decision_relevance
decision_delta
inputs_used
analysis_output
implications
limitations
confidence
```

### Step 9：反方分析

所有非纯记录 Case 默认分析：

```text
不做会损失什么
做了会增加什么成本和风险
当前建议为什么可能错
是否有更小、更可逆的选择
维持现状何时更合理
```

### Step 10：Decision Assurance

结果只能是：

```text
pass
warn
block
```

新增强制检查：

```text
是否仍在回答确认过的商业问题
是否错误接受了用户提出的解法
每个模型是否产生 Decision Delta
是否无提示滑入产品或技术设计
最终结论是否绑定 Case、状态和证据边界
中文输出是否完整
```

### Step 11：中央决策综合

只有 `decision-synthesizer` 可以生成用户结论。

- 综合真实业务选项，而不是机械输出通用 A/B/C/D。
- 只有当当前问题确实是“下一步如何降低不确定性”时，才把试点、补证据或暂缓作为主选项。
- 明确“能证明什么 / 不能证明什么”。
- 生成 `artifacts/DECISION_SYNTHESIS.md`。

### Step 12：中文 Decision Summary 与人类决定

生成 `DECISION_SUMMARY.md`，必须包含：

```text
Primary Decision Case ID 和路径
Work Item ID
Decision Assurance 状态
当前结论状态
用户决定状态
确认过的商业问题
选项、推荐与主要代价
证据边界
能证明什么 / 不能证明什么
下一次决策点和复审条件
```

D2 / D3 决定必须进入 `DECISION_NOTES.md`，没有明确用户确认时必须写“尚未确认”。

### Step 13：状态与决策记忆

更新：

```text
STATE.md
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_NOTES.md（如适用）
DECISION_PROCESS_PACKAGE.md（按深度）
Decision Case
Decision Network（如适用）
Decision Review（如适用）
```

## 5. Analysis Depth

### `quick`

适用于低影响、可逆、局部问题。最低输出：

```text
更新 Decision Case
更新 STATE.md
一个轻量分析摘要或明确说明无需模型
DECISION_SUMMARY.md
```

### `standard`

默认模式。生成必要的消费、输出、模型和质量文件，但不强制创建无价值 artifacts。

### `deep`

适用于高影响、不可逆、证据复杂或用户明确要求深度审计的决策。生成完整过程包和全部必要 artifacts。

## 6. Chinese Output Contract

- 用户可见回复必须使用简体中文，除非用户明确要求其他语言。
- 所有项目 Markdown 输出必须有中文内容；英文运行时版本不能替代中文版本。
- 文件名、ID、枚举和机器字段可以使用英文。
- `DECISION_SUMMARY.md` 永远是中文主输出。

## 7. Hard Prohibitions

- 不得在理解确认前提前推荐高影响解法。
- 不得在活动 BA Work Item 后续轮次中无状态回答。
- 不得把用户提出的解法直接当成已确认问题。
- 不得提出不会改变业务选择的问题。
- 不得运行没有 Decision Relevance 的模型。
- 不得让多个模型分别向用户输出最终结论。
- 不得把产品范围、数据结构、UI 或技术方案当成商业分析结论主体。
- 不得把系统建议写成用户决定。
- 不得把 provisional 写成 confirmed。
- 不得在 Work Item 根目录放置过程 artifacts。
- 不得创建 `docs/product/business-analysis/intake/`。
- 不得跨模块读写、触发或编译资产。
