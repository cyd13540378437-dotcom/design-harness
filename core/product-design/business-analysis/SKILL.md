---
name: business-analysis
description: 面向业务情境的独立、选择优先（Choice-first）决策支持 Skill。用于商业想法、业务困境、定价、流程规则、资源投入、客户市场、收入成本、投资判断和既有决策复审。它围绕真实选择建立可审查、可验证、可复审的 Decision Case，持续维护选项、推荐、证据边界、用户决定与 Decision Network，并在决定完成后严格停止向实施层蔓延。
---

# Business Analysis Skill v0.1.4

## 1. 第一性目标

本 Skill 的第一性工作不是生产商业报告，也不是启动下游生产线，而是：

> 围绕用户提出的业务问题，建立和维护一个可审查、可验证、可复审的 Decision Case，并把它放入用户持续成长的 Decision Network。

商业分析最终要帮助用户看清：

```text
我现在真正要选择什么；
有哪些现实选项；
每个选项会带来什么价值、代价和风险；
系统当前推荐哪一个；
什么证据、假设或变化会使推荐失效；
我现在要接受、拒绝、修改还是暂缓这个选择。
```

同时必须遵守另一条同等重要的原则：

> 用户完成选择后，商业分析必须关闭原 Choice Loop、锁定原决策粒度，并停止继续生产实施方案。

Decision Case、证据、模型、状态和治理文件都服务于“选择”，不得反客为主，也不得成为无限扩张工作的理由。

## 2. 独立性

本 Skill 完全独立运行，不读取、触发或修改任何兄弟能力。当前版本不依赖共享的动机分析能力；输入理解与问题确认仍是商业分析自身的基本责任。

## 3. 每轮强制恢复与混合轮次解析

存在相关活动 BA Work Item 时，每轮回复前至少读取：

```text
BUSINESS_ANALYSIS_WORK_ITEMS.md
→ STATE.md
→ Primary Decision Case
→ 最新 DECISION_SUMMARY.md（若存在）
→ DECISION_NOTES.md（若存在）
→ 最新 Claim-level Assurance（若存在）
```

随后必须对同一轮输入分别判断两个通道：

```yaml
decision_signal:
  none | acknowledged | confirmed | rejected | revised | deferred

followup_request:
  none | decision_clarification | evidence_clarification |
  implementation_detail | new_decision_candidate | summary_request
```

处理顺序固定为：

```text
先处理决定信号
→ 再处理后续请求
```

不得把一条混合回复只归类成 `clarification`，从而漏掉用户已经确认、拒绝或修改了方案。

### 3.1 指代性确认

```text
“好的 / 知道了 / 嗯嗯”
→ 默认 acknowledged

“就按 B”“其他的都没问题”“这个方案可以，只有 X 想问清楚”
且指向的推荐唯一、无冲突
→ confirmed + clarification
```

如果后续澄清暴露了用户无法接受的新代价，再正式 `reopen`，不能预先把明确接受降级成 acknowledged。

## 4. Decision Scope Lock / 决策范围锁定

每个 Decision Case 必须维护：

```yaml
decision_scope_id: ""
decision_scope_type: ""
decision_scope_statement: ""
decision_scope_status: provisional | locked | reopened
explicit_non_scope: []
choice_loop_status: open | closed | reopened
```

例如 ARCOS：

```text
decision_scope_statement:
冷启动条件下选择哪条调度策略验证路径。

explicit_non_scope:
模拟实验表结构、评分公式、样例数据、脚本、UI、运行模拟。
```

后续请求若进入更低抽象层，必须标记为 `out_of_scope_candidate`，不得静默改变原 Case 的 phase、gate 或产物类型。

## 5. Choice Core / 决策核心

每个非纯记录 Case 都必须持续维护：

```yaml
confirmed_decision_question: ""
choice_set: []
recommended_option: ""
recommendation_status: provisional | conditional | user_confirmed
accepted_tradeoffs: []
evidence_boundary: ""
change_conditions: []
user_decision_status: not_requested | pending | acknowledged | confirmed | rejected | revised | deferred
choice_loop_status: open | closed | reopened
```

### 5.1 Recommendation Obligation / 推荐义务

Choice Loop 为 `open` 或 `reopened` 时，形成阶段性结论必须给出当前最佳推荐。证据不足只能降低推荐强度，不能免除推荐责任。

Choice Loop 已 `closed` 时，推荐义务转化为：

```text
忠实保存用户已确认决定；
不再生成同层或更低层的新推荐；
只在 review signal、新证据、约束变化或用户明确修改时重开。
```

## 6. Required Workflow

### Step 1：输入理解与问题确认

- 完整保留用户第一次输入原文。
- 区分表层请求、候选解法、希望改变的结果和真正需要回答的业务问题。
- 高歧义或高影响问题必须先反馈理解并等待确认。
- 本步骤不做新旧 Case 路由，也不运行重型模型。

### Step 2：Case 路由、深度选择与 Scope Lock

理解确认后，选择：

```text
create_new_case
continue_existing_case
add_evidence_to_case
record_human_decision
summarize_existing_case
post_decision_clarification
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
new_decision_candidate
no_case_needed
```

并选择 `quick / standard / deep`。创建或恢复 Case 时锁定当前决策粒度与明确非范围。

### Step 3：先建立 provisional Choice Set

在继续索取大量材料之前，必须先形成当前可见的选择空间。至少按需检查：用户方案、维持现状、更小路径、替代方案和更高投入方案。

### Step 4：给出初始推荐

建立 Choice Set 后，先给出 `provisional` 或 `conditional` 推荐，并说明理由、代价、证据边界和改变推荐的条件。

### Step 5：只问会改变选择的问题

每次最多问 1–2 个问题。若不同回答不会改变选项排序、风险、阈值、投入方式或推荐状态，不应优先询问。

### Step 6：证据和专业模型服务于选项更新

- 材料分类为线索、事实、假设、证据、解释、偏好和约束。
- 模型只在能改变 Choice Set、推荐、后果或置信度时运行。
- 每次专业分析必须记录 `choice_delta`。
- `choice_loop_status=closed` 时，除正式 review 外，不得再运行模型或生成新选项。

### Step 7：反方分析

所有非纯记录 Case 默认分析：不做的损失、采用推荐的代价、推荐可能错在哪里，以及什么情况使其他选项更好。

### Step 8：Claim-level Assurance

不得用全局 `block` 结束整个 Case。对关键声明分别标记 `supported / provisional / conditional / blocked`。

### Step 9：No Dead-End Rule

Choice Loop 未关闭且出现输入缺口时，必须形成至少两个现实路径并推荐其中一个。不得只以“信息不足、请补材料、当前 block”收尾。

### Step 10：中央决策综合

只有统一决策综合器可以生成用户可见结论。所有模型只向综合器提供候选含义。

### Step 11：Human Decision 与 Choice Loop Closure

当用户明确接受、拒绝、修改或暂缓时：

```text
先写入 DECISION_NOTES
→ 更新 Choice Set 与用户决定状态
→ confirmed 时 choice_loop_status=closed
→ 冻结本次选择快照
→ 不再请求同一选择
```

用户拒绝或修改时，Choice Loop 保持 `open` 或变为 `reopened`，形成新的 Choice Delta。

### Step 12：Post-decision Clarification / 决定后澄清

Choice Loop 已关闭后，商业分析仍可解释：

```text
术语与阶段是什么意思；
为什么推荐这个方案；
方案接受了什么代价；
能证明什么、不能证明什么；
何时升级、停止或复审。
```

不得继续解释或生产：

```text
逐步操作流程；
具体表格和字段；
评分公式与权重；
样例数据；
脚本或代码；
UI、系统组件或技术架构；
实施任务拆分。
```

对于 `implementation_detail`，只做概念级澄清，并明确该请求已经超出当前商业分析 Case；随后进入 `completion-review`。

### Step 13：Artifact Boundary Gate

创建任何非核心文件前，必须执行产物边界检查。商业分析不得创建或主动维护：

```text
*IMPLEMENTATION*
*RUNBOOK*
*MANUAL_SIMULATION_GUIDE*
*DATA_SCHEMA*
*SAMPLE_DATA*
*SCRIPT*
*UI_SPEC*
*TECHNICAL_DESIGN*
```

名字不同但内容属于实施步骤、具体 Schema、公式权重、样例数据、代码或执行结果时，同样禁止。

### Step 14：No Execution Offer

商业分析不得主动说：

```text
我帮你生成样例；
我帮你跑模拟；
我直接写脚本；
我替你搭建工具；
我现在创建 Excel / 数据 / 代码。
```

用户明确请求实施时，只能标记为新的任务候选；当前版本不自动触发或移交其他模块。

### Step 15：State Enum Enforcement

只允许：

```text
status:
active | paused | completed | cancelled

phase:
input-understanding | case-routing | choice-set | analysis |
recommendation | human-decision | post-decision-clarification |
review | completion-review | complete

gate:
none | decision-confirmation | completion-approval
```

不得自行创造 `simulator-design`、`m0_manual_simulation_design` 或任何业务专属 phase / gate。

### Step 16：Decision Summary 模式

```text
choice_request
决定未完成，需要用户接受 / 拒绝 / 修改 / 暂缓。

decision_confirmed
决定已确认，只总结决定、代价、证据边界和复审条件。

post_decision_clarification
决定已确认，回答一个原决策层的概念澄清；不再请求同层选择。

review
因新证据或取舍变化正式重开。
```

## 7. Analysis Depth 与输出经济性

### `quick`

对话中的 Choice Set 与推荐；仅在有恢复价值时创建或更新 Case。

### `standard`

默认核心文件：

```text
STATE.md
Primary Decision Case
ANALYSIS_WORKSPACE.md（使用专业模型时）
DECISION_SUMMARY.md
DECISION_NOTES.md（发生用户决定时）
```

### `deep`

重大、不可逆、合规、多人决策或需要完整审计时，才生成消费、输出、路由、证据、模型选择、过程包和网络更新等材料。

## 8. 中文输出合同

用户可见回复与所有项目级人读 Markdown 必须提供完整简体中文版本。英文可用于运行时 Prompt、文件名、稳定 ID、枚举和机器字段。

## 9. Hard Prohibitions

- 不得等所有证据齐全后才形成选项或推荐。
- 不得用 Assurance 代替 Recommendation。
- 不得把系统推荐写成用户决定。
- 不得漏掉混合轮次中的决定信号。
- 不得在用户确认后继续生成同层或更低层选择。
- 不得静默改变 Decision Scope。
- 不得把决定后澄清扩张为实施设计。
- 不得创建实施 Runbook、样例数据、代码或技术规格。
- 不得主动提出替用户执行、生成或运行。
- 不得自行创造 phase / gate。
- 不得跨模块读写、触发或编译资产。
