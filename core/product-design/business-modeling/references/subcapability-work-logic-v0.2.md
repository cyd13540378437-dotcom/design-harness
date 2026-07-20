# Business Modeling Skill Cluster 子能力模块工作逻辑 v0.2

- **产品**：DesignHarnessAgent
- **能力集群**：业务模型能力集群（`product-business-modeling`）
- **版本**：v0.2
- **文档状态**：可并入正式 PRD / `CAPABILITY.md` 的完整设计稿
- **基线日期**：2026-07-17
- **主要语言**：简体中文；稳定 ID、枚举和文件名使用英文

> 本文定义业务模型能力集群的运行边界、14 个子能力模块的工作合同、人类决策控制层、被动触发接口、六种入口模式协作流程，以及任务级协议文件。除非后续正式 PRD 明确覆盖，本文中的 MUST / MUST NOT / SHOULD 具有规范性。

---

## 0. 一句话定义

业务模型能力集群负责把业务世界抽象成统一、稳定、可演进的产品语义模型，使商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 可以消费同一套业务语言。

它是 **Agent-neutral Core**，不是 Codex、Cursor 或 Claude 的专属 Skill；运行时 Agent 只是适配层，项目中的 `docs/product/business-modeling/` 才是长期业务模型知识资产。

---

## 1. v0.2 完成的增量

v0.2 在已冻结的业务模型架构上完成以下增量：

1. 将人类决策控制层（`Human Decision Control Plane`）正式嵌入全部 14 个子能力；
2. 将原“下游回填”升级为被动触发模式（`Passive Trigger Mode`）；
3. 将 `model-requests/` 正式升级为 `model-triggers/`；
4. 定义 `MT-xxx.md` 的创建、去重、分流、决策等待和关闭协议；
5. 定义 `MODEL_IMPACT_REPORT.md` 的结构、影响等级和使用边界；
6. 明确解析器、校验器、编译器只能提出候选或触发，不得越权改写核心语义；
7. 明确 14 个子能力的输入、处理、输出、写入权限、人类决策条件和触发行为；
8. 补全六种入口模式下的端到端模块协作流程；
9. 建立核心模型、任务级报告、决策记录与下游派生视图之间的权威边界；
10. 建立可直接转换为 `CAPABILITY.md`、模板和人工评测的验收合同。

---

## 2. 能力边界与硬原则

### 2.1 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

- **Core**：定义能力协议、入口模式、子能力、模板、校验规则和输出合同。
- **Adapters**：将 Core 适配到 Codex、Claude Code、Cursor 等运行时。
- **Project Knowledge Assets**：真实项目中的业务模型 source of truth。

Core 不得依赖某一运行时的私有会话格式、工具字段或特定 subagent 机制。

### 2.2 产品设计知识契约网络

商业分析、业务模型、产品表达、需求表达不是瀑布 Gate，而是通过知识契约协作的 API Mesh：

```text
上游决定 / 下游缺口 / 横向冲突
            ↓
        Model Trigger
            ↓
      业务模型影响分析
            ↓
  provisional / Human Decision
            ↓
      Source of Truth 更新
            ↓
       Downstream Views
```

任意能力集群可以先启动，但必须声明：

- 消费了什么；
- 哪些内容已确认；
- 哪些内容只是 provisional；
- 仍缺少什么；
- 哪些下游可能受影响；
- 哪些判断需要人类确认。

### 2.3 业务属性不是数据字段

业务模型核心资产只表达业务属性，不表达数据库字段、表字段、列类型、持久化策略或 API 参数。

合法业务属性示例：

```text
当前执行人
工单状态
期望完成时间
审批结果
执行证据
```

不得在核心业务模型中把它们写成：

```text
current_executor_id
work_order.status
expected_completed_at
approval_result_code
```

说明：`schema-view.json` 中的 `object_id`、`attribute_id` 等是**文档结构元数据键**，不属于产品数据字段。禁止的是把技术存储表达误当成业务语义。

只有 `downstream-views/database-view.md`、`backend-view.md` 等派生视图可以讨论“业务属性 → 可能的数据字段或接口映射”，并且必须标记为派生建议，而非业务事实。

### 2.4 `schema-view.json` 的严格边界

`schema-view.json` 只回答五个问题：

1. 有哪些业务对象；
2. 每个对象属于哪个业务领域；
3. 每个对象属于哪种对象分类；
4. 每个对象有哪些业务属性；
5. 每个业务属性有哪些示例内容。

它不得包含：

```text
对象关系、业务动作、状态流转、业务规则、权限策略、数据库字段、字段类型、持久化策略、后端接口、路线图、风险或下游影响。
```

### 2.5 证据先于确认

从项目代码、数据库、页面、接口或测试中解析出的内容，默认只能是 `draft` 或 `provisional`。实现现状可能过时、错误或只是技术折中，不能自动升级为业务事实。

### 2.6 派生视图不能反向成为权威源

`downstream-views/*` 是从核心模型编译出的消费视图。它们可以暴露模型缺口并创建触发，但不得自行修改业务字典、对象身份、关系、动作、状态、规则或权限。

### 2.7 高影响语义不可静默覆盖

- 新的、尚无 confirmed 前任的知识资产可以写为 `provisional`；
- 对既有 confirmed 语义的高影响修改，必须先写入任务级变更提案或影响报告；
- 在人类确认前，不得用 provisional 方案覆盖既有 confirmed source of truth；
- 被替代内容必须显式进入 `superseded` 或 `deprecated`，不得静默删除历史。

### 2.8 封存权属于人类

AI 可以判断任务达到关闭条件，可以提出 seal 建议，但不能自行把任务或重大决策标记为 `sealed`。sealed 内容只读；后续变化必须创建新的 Work Item、Successor 或明确的新决策记录。

---

## 3. 六段式能力集群架构

业务模型能力集群采用以下六段式架构：

```text
1. 统筹与调度类
2. 核心生产类
3. 演进、风险与交接类
4. 解析与校验类
5. 人类决策控制层
6. 被动触发接口
```

其中前四段由 14 个可调用子能力构成；后两段是横切控制机制，不作为普通生产子能力计数。

### 3.1 14 个子能力

| 序号 | 中文名称 | 英文 ID | 分类 |
|---|---|---|---|
| 1 | 业务模型总协调器 | `modeling-orchestrator` | 统筹与调度 |
| 2 | 模型更新分发器 | `model-update-router` | 统筹与调度 |
| 3 | 模型触发处理器 | `model-trigger-handler` | 统筹与调度 / 被动触发入口 |
| 4 | 业务字典构建器 | `business-dictionary-builder` | 核心生产 |
| 5 | 业务结构视图生成器 | `schema-view-structurer` | 核心生产 |
| 6 | 业务对象画像构建器 | `domain-object-profiler` | 核心生产 |
| 7 | 对象关系建模器 | `relationship-modeler` | 核心生产 |
| 8 | 业务动作建模器 | `action-command-modeler` | 核心生产 |
| 9 | 状态生命周期建模器 | `state-lifecycle-modeler` | 核心生产 |
| 10 | 规则权限建模器 | `rule-policy-modeler` | 核心生产 |
| 11 | 路线图与风险分析器 | `roadmap-risk-modeler` | 演进、风险与交接 |
| 12 | 下游视图编译器 | `downstream-view-compiler` | 演进、风险与交接 |
| 13 | 项目业务模型解析器 | `project-model-extractor` | 解析与校验 |
| 14 | 模型一致性检查器 | `model-consistency-validator` | 解析与校验 |

### 3.2 基础调用关系

```text
入口请求 / Model Trigger
          ↓
 modeling-orchestrator
          ↓
  model-update-router
          ↓
┌─────────────────────────────────────────┐
│ 字典 → 对象画像 → 关系 → 动作 → 状态 → 规则 │
│       ↘ schema-view                     │
└─────────────────────────────────────────┘
          ↓
 roadmap-risk-modeler
          ↓
 model-consistency-validator
          ↓
 downstream-view-compiler
```

项目解析器和触发处理器可以从侧面进入：

```text
project-model-extractor ──→ provisional candidates ──→ router
model-trigger-handler ────→ impact report / update plan ──→ router
validator ────────────────→ internal trigger / repair plan ──→ router
```

人类决策控制层在所有箭头上执行影响分级和写入阻断。

---

## 4. 共享运行合同

### 4.1 标准输入封装

运行时 Adapter SHOULD 将请求归一化为以下逻辑结构；实现形式可以是 YAML、JSON 或内存对象：

```yaml
request_id: REQ-xxx
capability_id: product-business-modeling
entry_mode: direct_modeling | passive_trigger | project_extraction | greenfield_modeling | consistency_validation | downstream_compilation
project_root: ""
work_item_id: ""
trigger_ids: []
requested_scope: []
requested_outputs: []
source_references: []
runtime_context:
  adapter: codex | claude-code | cursor | other
  conversation_ref: ""
```

### 4.2 标准输出封装

每次调用至少应返回：

```yaml
outcome: completed | awaiting_human | blocked | partial | no_change
work_item_id: BM-xxx
entry_mode: ""
artifacts_created: []
artifacts_updated: []
knowledge_status: draft | provisional | confirmed | superseded | deprecated | sealed
decisions_required: []
triggers_emitted: []
validation_summary:
  critical: 0
  warning: 0
  info: 0
next_action: ""
```

### 4.3 知识状态

v0.2 保留六个统一状态，但明确区分“内容成熟度”和“终态控制”：

| 状态 | 含义 | 可否由 AI 自动产生 |
|---|---|---|
| `draft` | 初始生成，尚未建议下游使用 | 可以 |
| `provisional` | 可临时消费，但含假设、缺口或待确认语义 | 可以 |
| `confirmed` | 已有明确权威依据，可作为稳定输入 | 仅低风险机械继承；高影响新语义必须有人类决定或明确 confirmed 上游决定 |
| `superseded` | 已被新版本替代，保留追溯 | 不能静默设置；需有替代依据 |
| `deprecated` | 历史保留，不建议继续使用 | 高影响时必须人类确认 |
| `sealed` | 任务或决策已封存，不得静默改写 | 不可以，必须由人类批准 |

普通“活体”业务模型资产通常使用前五种状态；`sealed` 主要用于 Work Item、重大决策快照或明确冻结的基线。Trigger 生命周期和 Decision 工作流可以使用各自的控制状态；这些控制状态不得被误当成业务知识成熟度。

### 4.4 决策影响等级

人类决策控制层使用四级影响模型：

| 等级 | 名称 | 典型内容 | 自动行为 |
|---|---|---|---|
| `D0` | 机械同步 | 格式修复、索引同步、从 confirmed 源重建 Markdown 视图 | 可自动更新 |
| `D1` | 可逆局部语义 | 新增示例、别名、局部说明、无 confirmed 前任的新 provisional 属性 | 可自动写 provisional，并记录假设 |
| `D2` | 核心产品语义 | 对象身份、对象边界、核心关系、动作、状态分支、规则或权限 | 可生成提案；升级 confirmed 或覆盖 confirmed 前必须人类确认 |
| `D3` | 治理与终态 | 合规、责任、计费、删除、审计、不可逆流程、重大重构、废弃、封存 | 必须明确人类决定；不得先行改写权威源 |

若无法可靠判断等级，按更高一级处理。

### 4.5 单一写入者原则

同一轮更新中，每个 source-of-truth 资产族只能有一个语义写入者。其他模块只能提交候选变更、诊断或触发。

- 解析器不直接写 confirmed 核心模型；
- 校验器不直接重写语义冲突；
- 编译器不反向修改核心模型；
- 触发处理器不替代建模模块生产语义；
- 更新分发器只规划和排序，不自行发明业务事实。

### 4.6 Work Item 解析与线程边界

业务模型能力继承 DesignHarnessAgent Core 的任务身份协议：Thread 是临时工作现场，Work Item 才是可独立验收的任务身份。跨运行时或跨对话继续同一目标时，不得仅因 Thread 改变而创建重复 BM Work Item。

任务解析只能返回：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

- `CREATE`：新的独立建模目标；
- `RESUME`：继续未封存的相关 BM Work Item；
- `SUCCESSOR`：与 sealed 历史相关，但应创建新任务；
- `NO_STATE`：只读解释、极小无状态检查或无需持久建模；
- `AMBIGUOUS`：存在多个合理候选，停止写入并请求用户绑定。

`completed + sealed` 的 Work Item 不得 RESUME，只能只读引用并创建 SUCCESSOR。`PRODUCT_WORK_ITEMS.md` 是导航索引；冲突时以各 Work Item 的 `STATE.md` 为准。

---

## 5. 人类决策控制层

### 5.1 职责

人类决策控制层负责：

1. 识别不可由 AI 自动确认的产品判断；
2. 对变更执行 `D0–D3` 影响分级；
3. 阻止 provisional 高影响方案覆盖 confirmed 语义；
4. 将多个相关问题压缩为可判断的决策包；
5. 记录用户选择、理由、影响和被否决方案；
6. 在决定后恢复相应模块；
7. 控制 confirmed、deprecated 和 sealed 的升级边界。

它不负责替用户做决定，也不应把所有不确定性都升级为询问。

### 5.2 必须进入人类决策的情况

以下任一条件成立时，MUST 进入人类决策：

- 业务对象身份、拆分、合并或边界存在互斥方案；
- 对象关系会改变责任、所有权、权限、流程或下游数据结构；
- 业务动作改变核心业务路径或产生不可逆后果；
- 状态生命周期存在多个合理分支、终态或重开策略；
- 规则涉及责任、权限、审计、隐私、合规、计费、删除或历史记录；
- confirmed 上游变化要求重构 confirmed 业务模型；
- provisional 判断已经被一个或多个下游正式依赖；
- 需要把 D2 / D3 内容从 draft 或 provisional 升级为 confirmed；
- 需要把重要资产标记为 deprecated、superseded 或 sealed；
- 两个 confirmed 来源发生语义冲突。

### 5.3 可自动推进的情况

以下内容通常可以自动执行：

- 从 confirmed 机器源重建人读视图；
- 修复断链、索引、排序、格式和重复展示；
- 为已确认对象补充不改变含义的示例；
- 新建没有 confirmed 前任、且不影响其他对象的 provisional 候选；
- 生成影响报告、校验报告和下游派生视图；
- 将明确的上游 confirmed 决定转写为候选模型更新，但若会改变 D2 / D3 语义，仍需人类确认业务模型重构方案。

### 5.4 决策执行流程

```text
模块检测到 D2 / D3 判断
        ↓
停止对 confirmed source of truth 的覆盖写入
        ↓
在 DECISION_NOTES.md 创建 Decision Request
        ↓
在 STATE.md 记录 awaiting human checkpoint
        ↓
向用户展示当前理解、影响、2–3 个方案和推荐
        ↓
用户确认 / 修改 / 延后 / 否决
        ↓
记录决定与理由
        ↓
model-update-router 重新生成更新计划
        ↓
对应语义模块写入 source of truth
        ↓
一致性校验与下游重编译
```

相关问题 SHOULD 合并成一个语义决策包，避免把用户淹没在逐字段询问中；但不能把相互独立、风险不同的问题强行捆绑。

### 5.5 Decision Request 模板

```markdown
## 需要你确认的产品判断

- Decision ID: BMD-xxx
- Impact Level: D2 | D3
- Affected Assets:
- Blocking Work Item:

### 当前理解

……

### 为什么重要

这个判断将影响：对象定义 / 关系 / 动作 / 状态 / 权限 / 数据库视图 / UX / QA。

### 方案 A：……

- 优点：
- 代价：
- 适用前提：

### 方案 B：……

- 优点：
- 代价：
- 适用前提：

### 推荐

推荐方案……，原因是……

### 需要确认

选 A / 选 B / 补充规则 / 暂缓决定
```

### 5.6 provisional 的下游消费规则

下游可以消费 provisional 模型，但必须：

- 保留来源链接；
- 复述关键假设；
- 标记可能失效的范围；
- 不把 provisional 重新包装成 confirmed；
- 若 provisional 已影响开发、权限或数据结构，必须创建或升级人类决策请求。

---

## 6. 被动触发接口

### 6.1 定义

被动触发接口使业务模型能力可以响应非用户主动建模请求，包括：

- 上游商业分析变化；
- 下游能力发现模型缺口；
- 横向能力之间的语义冲突；
- 项目解析或一致性校验发现的内部问题。

Model Trigger 是“需要业务模型响应的事件合同”，不是直接修改业务模型的命令。

### 6.2 Trigger 类型

```text
upstream_change         上游 confirmed / provisional 决定发生变化
downstream_gap          下游消费时发现业务模型缺失或不足
cross_cluster_conflict  两个能力集群对同一业务语义表达不一致
internal_discovery      项目解析或一致性校验发现候选、冲突或过期资产
```

### 6.3 Trigger 生命周期

```text
open
  ↓
triaged
  ↓
in_progress
  ├── awaiting_human ──→ in_progress
  ├── resolved
  ├── dismissed
  └── superseded
```

- `open`：已创建，尚未分类；
- `triaged`：已验证来源、去重、确定影响范围和响应方式；
- `in_progress`：已绑定 BM Work Item；
- `awaiting_human`：影响分析完成，但高影响判断等待用户；
- `resolved`：模型响应、校验、必要重编译和回写均完成；
- `dismissed`：证据不足、非业务模型问题或无需变化；
- `superseded`：被更新的 Trigger 取代。

关键 Trigger 的 dismissed / superseded 也必须保留理由，不得直接删除。

### 6.4 `MT-xxx.md` 规范模板

```markdown
---
schema_version: 1
trigger_id: MT-001
trigger_type: upstream_change
source_cluster: business-analysis
target_cluster: business-modeling
source_work_item: BA-002
source_asset: ""
source_decision_id: ""
source_decision_status: confirmed
target_work_item: ""
status: open
priority: medium
dedupe_key: "business-analysis:BA-002:pricing-model:v2:business-modeling"
parent_trigger: ""
created_at: YYYY-MM-DDTHH:mm:ssZ
updated_at: YYYY-MM-DDTHH:mm:ssZ
resolved_at: ""
---

# Model Trigger: Pricing Model Changed

## Trigger Summary

商业分析层确认计费方式从按 Workspace 计费调整为按 Seat 计费。

## Source Context

- Source Cluster:
- Source Work Item:
- Source Asset / Decision:
- Source Status:
- Source Version or Date:

## Source Decision or Evidence

记录可追溯的决定、证据和原文摘要，不复制整份上游文档。

## Observed Change, Gap, or Conflict

说明实际变化、缺口或冲突。

## Why It Matters

说明可能影响的业务领域、对象、属性、关系、动作、状态、规则、权限和下游视图。

## Requested Response

- impact_analysis
- model_update
- consistency_repair
- downstream_recompile
- human_decision

## Initial Scope Hint

- Potential Domains:
- Potential Objects:
- Potential Downstream Consumers:

## Human Decision Signals

- Potential Impact Level: D0 | D1 | D2 | D3
- Likely Human Decision Required: true | false | unknown
- Reason:

## Resolution

- Final Status:
- Resolved by BM Work Item:
- Impact Report:
- Decisions:
- Updated Source-of-Truth Assets:
- Recompiled Views:
- Follow-up Triggers:
- Resolution Summary:
```

### 6.5 Trigger 处理规则

1. **验证来源**：来源文件、Work Item、decision 或证据必须可追溯；
2. **去重**：相同 `dedupe_key` 的 open / triaged / in_progress Trigger 不重复创建；
3. **不自动信任**：上游 provisional 只能触发 provisional 影响分析；
4. **不自动覆盖**：Trigger 不能直接覆盖 confirmed 模型；
5. **单一主任务**：一个 Trigger 必须绑定零个或一个主 BM Work Item；多个相关 Trigger 可以合并进同一 Work Item；
6. **完整关闭**：只有影响分析、必要更新、校验、重编译和 Resolution 回写完成后，才可 `resolved`；
7. **继续传播**：若业务模型变化影响其他 Cluster，必须创建后续 Trigger，而不是在本 Trigger 中假装完成下游修改。

### 6.6 Trigger 优先级

| 优先级 | 判断 |
|---|---|
| `low` | 文档同步、非阻塞示例、可延后视图更新 |
| `medium` | 局部模型缺口或单一对象影响 |
| `high` | 跨对象、跨视图、已被下游依赖的语义变化 |
| `critical` | 合规、责任、权限、计费、删除、审计、生产阻塞或重大冲突 |

优先级不等于决策等级，但通常 `critical` Trigger 至少包含一个 D3 判断。

---

## 7. `MODEL_IMPACT_REPORT.md` 协议

### 7.1 目的

`MODEL_IMPACT_REPORT.md` 是被动触发和重大模型更新的主要影响分析产物。它用于回答：

- 发生了什么；
- 现有模型哪些部分可能受影响；
- 哪些可以安全自动更新；
- 哪些只能提出 provisional 方案；
- 哪些必须交由人类判断；
- 更新后需要重新校验和编译什么。

它是任务级分析报告，不是核心业务模型 source of truth。

### 7.2 推荐 frontmatter

```yaml
---
schema_version: 1
report_id: MIR-001
work_item_id: BM-001
trigger_ids:
  - MT-001
status: provisional
impact_scope: cross_cluster
highest_decision_level: D3
human_decision_required: true
model_baseline: "business-model-index revision or commit"
created_at: YYYY-MM-DDTHH:mm:ssZ
updated_at: YYYY-MM-DDTHH:mm:ssZ
---
```

`impact_scope` 建议枚举：

```text
none | local | cross_asset | cross_domain | cross_cluster | breaking
```

### 7.3 正文模板

```markdown
# Model Impact Report

## 1. Trigger

- Trigger IDs:
- Trigger Type:
- Source:
- Source Status:

## 2. Change Summary

## 3. Evidence and Assumptions

### Confirmed Evidence

### Provisional Evidence

### Open Assumptions

## 4. Affected Business Domains

## 5. Affected Objects

## 6. Affected Business Attributes

## 7. Affected Relationships

## 8. Affected Actions

## 9. Affected States

## 10. Affected Rules and Permissions

## 11. Affected Downstream Views

## 12. Safe Automatic Updates

仅列 D0 或满足自动 provisional 条件的 D1 更新。

## 13. Provisional Change Proposals

列出可写入候选区、但不能覆盖 confirmed 语义的方案。

## 14. Human Decisions Required

| Decision ID | Level | Question | Options | Recommendation | Blocking Assets |
|---|---|---|---|---|---|

## 15. Recommended Update Plan

| Order | Module | Asset | Operation | Allowed Before Decision | Validation |
|---|---|---|---|---|---|

## 16. Revalidation and Recompilation Plan

## 17. Follow-up Triggers

## 18. Resolution Readiness

- Core updates complete:
- Human decisions complete:
- Consistency validation complete:
- Downstream views recompiled:
- Trigger may resolve:
```

### 7.4 写入边界

影响报告可以包含 D2 / D3 方案，但这些方案不得因为“已经写进报告”就被视为 confirmed。报告中的 `Recommended Update Plan` 是执行计划，不是授权。


---

## 8. 14 个子能力模块工作合同

每个子能力都遵循同一合同：**职责 → 触发 → 输入 → 处理 → 输出与写入 → 人类决策 → 被动触发 → 禁止越界 → 完成条件**。

### 8.1 业务模型总协调器（`modeling-orchestrator`）

#### 职责

业务模型总协调器是能力集群的唯一顶层入口。它负责识别入口模式、绑定或创建 BM Work Item、装载当前基线、选择子能力、组织人类决策、控制执行顺序，并形成最终任务结果。

它是流程编排器，不是业务语义作者。

#### 触发场景

- 用户主动提出业务建模请求；
- 收到 `MT-xxx.md`；
- 用户要求从现有项目抽取业务模型；
- 用户提出模糊产品想法；
- 用户要求一致性检查；
- 用户要求生成某个下游视图；
- 当前任务需要从一种入口模式切换或组合另一种模式。

#### 必要输入

- 标准请求封装；
- 项目根目录和 `AGENTS.md` / Adapter 规则；
- `PRODUCT_WORK_ITEMS.md`；
- 相关 BM Work Item 的 `STATE.md`；
- `BUSINESS_MODEL_INDEX.yml`；
- 可选 Trigger、上游决定或下游消费请求。

#### 核心处理逻辑

1. 判断六种入口模式；
2. 解析当前请求是创建、恢复、继任、无状态还是歧义绑定；
3. 读取 `MODELING_CONSUMPTION.md` 或创建新的消费记录；
4. 建立本轮目标、范围、非范围、输入基线和预期输出；
5. 调用更新分发器生成模块计划；
6. 在每次 source-of-truth 写入前检查决策等级；
7. 遇到 D2 / D3 判断时，将任务置于 awaiting human；
8. 决策完成后恢复执行；
9. 调用一致性检查器；
10. 按需调用下游视图编译器；
11. 更新任务级输出和索引；
12. 提交关闭准备，但不自行 seal。

#### 输出与写入范围

- `work-items/BM-xxx/STATE.md` 的流程检查点；
- `MODELING_CONSUMPTION.md`；
- `MODELING_OUTPUT.md`；
- `DECISION_NOTES.md` 的索引或调用结果；
- `PRODUCT_WORK_ITEMS.md` 的导航更新；
- `BUSINESS_MODEL_INDEX.yml / .md` 的事务性索引更新；
- 标准输出封装。

协调器可更新索引和任务状态，但不得独立发明对象、关系、动作、状态、规则或权限定义。

#### 人类决策控制

- 识别是否存在 D2 / D3 判断；
- 将同一语义链上的问题合并为决策包；
- 确保用户决定先写入 `DECISION_NOTES.md`，再允许语义模块修改 confirmed 资产；
- 关闭、废弃和封存前请求明确批准。

#### 被动触发行为

- 接收 Trigger Handler 绑定的任务；
- 在任务结束时汇总需要传播给其他 Cluster 的后续 Trigger；
- 不直接管理 Trigger 生命周期细节。

#### 禁止越界

- 不代替建模模块生产业务语义；
- 不绕过 Human Decision Control Plane；
- 不把“无错误”当作“用户已批准”；
- 不在歧义任务绑定时静默选择 Work Item；
- 不让多个模块同时写同一 source-of-truth 文件。

#### 完成条件

- 入口模式和 Work Item 绑定明确；
- 计划中的模块已完成或明确阻塞；
- 所有高影响决定已记录或标记待决；
- 任务级输出完整；
- 一致性结果已记录；
- 必要的 Trigger 已回写或发出；
- 可以清楚说明下一步是继续、等待、暂停、关闭或创建 Successor。

---

### 8.2 模型更新分发器（`model-update-router`）

#### 职责

模型更新分发器把用户请求、解析候选、校验问题或影响报告转换为可执行的资产级更新计划，决定由哪些语义模块处理、按什么依赖顺序执行、哪些步骤被人类决策阻断。

它规划变更，不创造业务事实。

#### 触发场景

- 总协调器已确定入口模式；
- Trigger 已完成 triage；
- 影响报告需要转成更新步骤；
- 解析器产生候选模型；
- 校验器发现跨资产不一致；
- 用户决定已确认，需要恢复写入。

#### 必要输入

- 请求范围或 `MODEL_IMPACT_REPORT.md`；
- 当前 `BUSINESS_MODEL_INDEX.yml`；
- 受影响资产的状态和依赖；
- 已确认的 Decision Notes；
- 模块写入所有权表。

#### 核心处理逻辑

1. 将变化拆成术语、对象、结构、关系、动作、状态、规则、演进、视图等变更单元；
2. 标记每个单元的现状、目标状态、影响等级和写入者；
3. 识别 confirmed 资产是否会被覆盖；
4. 建立依赖顺序；
5. 区分：
   - 可立即执行的 D0；
   - 可 provisional 推进的 D1；
   - 仅可产生提案的 D2；
   - 必须完全等待决定的 D3；
6. 为每步指定校验和回滚依据；
7. 在人类决定后重新计算计划，而不是沿用可能失效的旧计划。

#### 默认依赖顺序

```text
1. 业务字典与对象身份
2. 业务对象画像
3. schema-view 结构同步
4. 对象关系
5. 业务动作
6. 状态生命周期
7. 业务规则与权限
8. 路线图与风险
9. 一致性校验
10. 下游视图编译
```

该顺序是默认拓扑，不是强制瀑布。局部、无依赖的变更可以跳过不相关模块。

#### 输出与写入范围

- `MODELING_OUTPUT.md` 中的 Update Plan；
- `MODEL_IMPACT_REPORT.md` 的 Recommended Update Plan；
- 模块调用清单和阻断条件；
- 不直接写核心语义资产。

#### 人类决策控制

- 为每个更新单元标记 D0–D3；
- confirmed → changed 的 D2 / D3 单元必须标记 `blocked_by_decision`；
- 用户决定改变方案后必须重新路由；
- 不得用“上游已 confirmed”自动消除业务模型中的多个合理重构方案。

#### 被动触发行为

- 为 Trigger 生成影响更新计划；
- 若发现影响范围超出业务模型或需要其他 Cluster 响应，建议 Follow-up Trigger；
- 若一个 Trigger 实际包含多个独立变化，可建议拆分子 Trigger。

#### 禁止越界

- 不自己定义对象、动作或规则；
- 不把计划状态当作资产状态；
- 不跳过 source-of-truth 所有者直接修改文件；
- 不在依赖不满足时强行编译 confirmed 下游视图。

#### 完成条件

每个变更单元都具备：写入者、目标资产、操作类型、影响等级、前置决定、验证方式和下游影响。

---

### 8.3 模型触发处理器（`model-trigger-handler`）

#### 职责

模型触发处理器是被动触发模式的正式入口，负责创建或接收 `MT-xxx.md`，验证来源、去重、分类、确定优先级、绑定 BM Work Item、跟踪 Resolution，并在必要时传播后续 Trigger。

#### 触发场景

- 商业分析产生新的角色、价值链、收入、流程或约束决定；
- 产品表达、需求表达、UX、前端、后端、数据库或 QA 发现业务模型缺口；
- 多个 Cluster 对同一语义表达冲突；
- 项目解析器或一致性检查器发现内部候选、错误或过期视图。

#### 必要输入

- Trigger 文件或结构化事件；
- 来源 Work Item / 决定 / 证据；
- 当前未关闭 Trigger 索引；
- 当前 BM Work Item 列表；
- 业务模型基线索引。

#### 核心处理逻辑

1. 验证 Trigger 必填字段和来源可追溯性；
2. 计算或核对 `dedupe_key`；
3. 查找相同语义的 open / triaged / in_progress Trigger；
4. 分类 `trigger_type`、priority 和潜在影响等级；
5. 判断：
   - 绑定已有 BM Work Item；
   - 新建 BM Work Item；
   - 合并到已有 Trigger；
   - dismissed；
6. 调用总协调器和更新分发器；
7. 确保生成 `MODEL_IMPACT_REPORT.md`；
8. 根据任务状态更新 Trigger 生命周期；
9. 完成后回写 Resolution；
10. 为受影响的其他 Cluster 创建 Follow-up Trigger。

#### 输出与写入范围

- `docs/product/model-triggers/MT-xxx.md`；
- Trigger 索引（若项目采用）；
- 与 `MODEL_IMPACT_REPORT.md`、BM Work Item 的双向链接；
- Follow-up Trigger。

它不写业务字典、对象、关系、动作、状态、规则或权限。

#### 人类决策控制

以下情况必须升级：

- 来源 decision 本身不是 confirmed，但请求修改 confirmed 模型；
- 两个 confirmed 来源冲突；
- dismiss high / critical Trigger；
- 多个 Trigger 合并后会掩盖独立责任或范围；
- Trigger 指向 D2 / D3 语义重构。

#### 被动触发行为

本模块本身就是被动触发接口的执行者。它必须保证 Trigger 有始有终，而不是只创建不关闭。

#### 禁止越界

- 不把 Trigger 当作批准；
- 不直接执行语义更新；
- 不删除已处理 Trigger；
- 不因为没有立刻变化就自动 dismissed；
- 不在 Resolution 未完成时标记 resolved。

#### 完成条件

Trigger 已验证、去重、分类、绑定任务，且最终具有可追溯 Resolution；若仍等待人类或下游，则状态必须准确反映。

---

### 8.4 业务字典构建器（`business-dictionary-builder`）

#### 职责

建立统一业务语言，维护业务对象、业务属性、角色、动作、状态、业务领域、对象分类、别名、禁用词和定义边界。

#### 触发场景

- 新建或调整业务对象 / 业务属性；
- 术语在多个文档中含义不一致；
- 上游角色或流程变化；
- 解析器发现候选术语；
- 校验器发现未定义引用或同义冲突；
- 下游要求稳定名称和定义。

#### 必要输入

- 明确用户描述或上游决定；
- 现有 `business-dictionary.yml / .md`；
- 对象画像、关系、动作、状态、规则中的引用；
- 来源证据和知识状态。

#### 核心处理逻辑

1. 判断条目类型：对象、属性、角色、动作、状态、领域、分类或其他术语；
2. 分配稳定 ID；
3. 写清中文名称、定义、存在目的、包含、排除、别名、反例和示例；
4. 标记业务领域和对象分类；
5. 记录来源、状态和相关资产；
6. 检查是否与现有条目重复、冲突、包含或应拆分；
7. 同步人读与机器读索引；
8. 向其他模块提交受影响引用。

#### 输出与写入范围

- `business-dictionary.yml`：机器可读 source of truth；
- `business-dictionary.md`：人读视图；
- `BUSINESS_MODEL_INDEX` 中的条目状态。

#### 人类决策控制

以下通常为 D2 / D3：

- 新增、合并、拆分或重命名核心业务对象；
- 改变对象“是什么 / 不是什么”；
- 改变角色身份、责任或法律含义；
- 将 confirmed 术语 deprecated；
- 术语变化会导致下游数据迁移、权限变化或流程重构。

不改变语义的别名、示例和文字澄清通常为 D0 / D1。

#### 被动触发行为

- 接收上游角色、客户、流程或计费术语变化；
- 术语变化影响对象画像、schema、关系、动作、状态、规则时，向更新分发器提交影响；
- 发现下游用技术字段名代替业务术语时，发出 `cross_cluster_conflict` 或 `internal_discovery`。

#### 禁止越界

- 不把数据库列名注册为核心业务属性；
- 不在字典中承担详细关系、动作、状态机或权限模型；
- 不用页面文案的偶然用词自动替换 confirmed 术语；
- 不删除历史条目以掩盖重命名。

#### 完成条件

条目 ID 唯一、定义无循环、别名可追溯、引用有效、状态明确，并与 schema-view 和对象画像不存在未解释冲突。

---

### 8.5 业务结构视图生成器（`schema-view-structurer`）

#### 职责

从业务字典和对象画像生成极简业务属性结构视图，提供机器可读 `schema-view.json` 和人读 `schema-view.md`。

#### 触发场景

- 新增、删除或调整业务对象；
- 调整对象业务领域、对象分类或业务属性；
- 用户明确要求 schema-view；
- 字典或对象画像更新后需要同步；
- 校验器发现结构视图过期。

#### 必要输入

- `business-dictionary.yml`；
- `domain-objects/<id>.md`；
- 已确认或 provisional 的对象、领域、分类、属性和示例内容；
- 当前 schema-view。

#### 核心处理逻辑

1. 枚举允许进入视图的业务对象；
2. 为每个对象读取业务领域和对象分类；
3. 列出业务属性及示例内容；
4. 继承源知识状态；
5. 拒绝关系、动作、状态流转、规则、权限和技术字段；
6. 生成 JSON；
7. 从 JSON 生成 Markdown 人读视图；
8. 校验 JSON 与 Markdown 一致。

#### 输出与写入范围

- `schema-view.json`：对象结构 source of truth；
- `schema-view.md`：从 JSON 派生的人读视图。

#### 人类决策控制

本模块通常不创造 D2 / D3 语义。若生成过程中发现：

- 对象是否存在尚未决定；
- 属性应属于对象还是独立对象存在分歧；
- 领域或分类有互斥方案；

必须停止自行判断，提交给字典构建器、对象画像构建器和人类决策控制层。

#### 被动触发行为

- confirmed 字典变化后可自动 D0 重建；
- 发现引用缺失、技术字段污染或内容超出五项边界时，发出 `internal_discovery`；
- 结构更新可触发相关下游视图重编译。

#### 禁止越界

- 不把关系、动作、状态、规则或权限塞进 JSON；
- 不加入数据类型、required、nullable、column、foreign key 或 API 字段；
- 不因为方便数据库设计而改变对象或属性语义；
- 不独立确认缺失业务事实。

#### 完成条件

JSON 语法有效，仅包含允许字段；对象、领域、分类、属性和示例均可追溯；Markdown 与 JSON 同步；无技术字段污染。

---

### 8.6 业务对象画像构建器（`domain-object-profiler`）

#### 职责

为每个核心业务对象建立深度画像，解释对象身份、边界、存在目的、业务责任、业务属性、生命周期概览、关联对象和未来演进。

#### 触发场景

- 新建业务对象；
- 对象边界不清；
- 一个属性可能应升级为独立对象；
- 多个对象责任重叠；
- 上游业务流程或角色变化；
- 下游需要理解对象而不是字段集合。

#### 必要输入

- 业务字典条目；
- 用户或上游业务描述；
- 现有关系、动作、状态、规则；
- 解析证据；
- 相关决策记录。

#### 核心处理逻辑

1. 定义“它是什么”和“它不是什么”；
2. 说明存在目的和业务责任；
3. 确定业务领域和对象分类；
4. 列出业务属性及其含义；
5. 记录生命周期概览，并链接详细状态模型；
6. 记录主要关系概览，并链接关系 source of truth；
7. 标记当前 MVP 简化、未来演进和拆分风险；
8. 明确 provisional 假设和证据。

#### 输出与写入范围

- `domain-objects/<object-id>.md`；
- 必要时建议字典、schema、关系、动作、状态和规则更新，但不越权写其他资产。

#### 人类决策控制

以下必须升级：

- 对象与属性之间的身份选择；
- 对象合并、拆分或边界重构；
- 谁承担核心业务责任；
- 是否保留独立历史、审计或生命周期；
- 对象是否可删除、归档、复用或跨租户存在。

#### 被动触发行为

- 上游角色、流程、计费或合规变化可触发画像重评；
- 下游发现对象不足以表达独立责任时触发；
- 画像变化必须向字典、schema、关系、动作、状态、规则和下游视图传播影响。

#### 禁止越界

- 不把对象描述成数据库表；
- 不列技术字段或 ORM 类型；
- 不在画像中建立完整状态机或权限矩阵；
- 不把现有代码类名自动当成业务对象身份。

#### 完成条件

对象身份、边界、责任和属性可理解；与字典一致；详细关系、动作、状态和规则有明确链接；高影响假设已确认或标为 provisional。

---

### 8.7 对象关系建模器（`relationship-modeler`）

#### 职责

表达业务对象之间稳定、可解释的语义连接，回答“谁与谁以什么业务含义相关、关系在何时成立、承担什么责任”。

#### 触发场景

- 新增对象；
- 需要梳理人员与工单、成员与席位、审批与提交等关系；
- 对象关系被写死为技术字段；
- 下游需要明确业务归属或参与方式；
- 关系变化影响动作、状态、规则或权限。

#### 必要输入

- 对象画像和字典；
- 已确认业务流程和角色；
- 相关动作、状态、规则；
- 当前关系图；
- 决策记录。

#### 核心处理逻辑

1. 确定 source object 和 target object；
2. 给出关系名称、方向和业务语义；
3. 说明关系何时建立、何时终止、是否保留历史；
4. 仅在它是业务事实时表达业务多重性，而不是数据库基数；
5. 区分当前关系、历史关系、责任关系、参与关系和引用关系；
6. 记录关系所依赖或影响的动作、状态和规则；
7. 识别关系是否应升级为独立业务对象，例如 Assignment、Membership、Approval。

#### 输出与写入范围

建议 source of truth：

- `relationships/relationship-map.yml`；
- `relationships/relationship-map.md`；
- 必要时 `relationships/<relationship-id>.md`。

#### 人类决策控制

以下通常为 D2 / D3：

- 所有权、责任、归属、审批链或历史保留关系；
- 一对一、一对多或多方参与是业务规则而非技术实现时；
- 关系是否需要独立对象；
- 关系变化影响权限、计费、删除或审计；
- confirmed 关系的重构。

#### 被动触发行为

- 从上游流程、角色或计费变化接收 Trigger；
- 关系变化向动作、状态、规则、风险和下游视图发送影响；
- 若下游仅有 `_id` 字段但业务关系未定义，创建 `downstream_gap`。

#### 禁止越界

- 不用 foreign key、join table、ORM association 代替业务关系；
- 不在关系图中定义完整动作或状态机；
- 不因为数据库是一对多就断言业务永远是一对多；
- 不把“当前执行人”自动固定为对象属性而忽略 Assignment 的可能性。

#### 完成条件

每个关系有稳定 ID、两端对象、业务含义、成立与终止条件、历史边界、状态和来源；相关对象均存在；高影响关系已确认或保持提案状态。

---

### 8.8 业务动作建模器（`action-command-modeler`）

#### 职责

定义“谁在什么条件下可以对什么业务对象做什么，以及动作产生什么业务效果”，形成与 UI 按钮、API endpoint 和数据库命令解耦的业务动作目录。

#### 触发场景

- 新增或调整业务流程；
- 需要明确提交、完成、审批、取消、转派等动作；
- 页面文案与业务动作语义冲突；
- 状态流转缺少触发动作；
- 权限模型需要动作清单。

#### 必要输入

- 角色和对象字典；
- 对象关系；
- 业务流程；
- 状态模型；
- 规则与权限；
- 失败和异常场景证据。

#### 核心处理逻辑

1. 定义动作 ID、名称和业务意图；
2. 指定 actor、target 和可选受影响对象；
3. 定义前置业务条件；
4. 定义成功后的业务效果；
5. 指向状态转换，但不复制状态机权威定义；
6. 说明可逆性、失败结果、幂等业务语义和必要证据；
7. 区分命令、查询、系统事件和人工决定；
8. 检查动作名称是否被 UI 文案误用。

#### 输出与写入范围

建议 source of truth：

- `actions/action-command-catalog.yml`；
- `actions/action-command-catalog.md`；
- 必要时 `actions/<action-id>.md`。

#### 人类决策控制

以下必须升级：

- 动作改变核心业务路径；
- 动作不可逆、破坏性、付费、删除或涉及责任转移；
- “提交”是否等于“完成”等核心语义；
- 谁有权发起动作；
- 动作是否需要审批、证据或审计；
- confirmed 动作被拆分、合并或废弃。

#### 被动触发行为

- 接收业务流程、关系和下游交互冲突 Trigger；
- 动作变化向状态、规则、权限、产品表达、需求表达和 QA 传播；
- 发现 UI / API 存在未建模动作时创建 `downstream_gap` 或 `internal_discovery`。

#### 禁止越界

- 不用按钮、路由、HTTP method 或 endpoint 代替业务动作；
- 不在本模块决定最终权限；
- 不把技术副作用写成业务效果；
- 不创建没有 actor、target 或 effect 的动作。

#### 完成条件

每个动作有 actor、target、意图、前置条件、业务效果、失败语义、可逆性和状态/规则引用；没有悬空角色或对象。

---

### 8.9 状态生命周期建模器（`state-lifecycle-modeler`）

#### 职责

定义业务对象在生命周期中的业务事实状态，以及哪些业务动作在什么条件下使状态发生变化。

#### 触发场景

- 新增流程承载对象；
- 需要梳理待接单、执行中、待审批、已关闭等状态；
- 状态定义被 UI 状态或数据库 enum 污染；
- 动作缺少合法转换；
- 多个下游对终态、取消、重开理解不同。

#### 必要输入

- 对象画像；
- 动作目录；
- 业务规则；
- 角色和权限；
- 流程证据；
- 当前状态模型。

#### 核心处理逻辑

1. 定义状态 ID、业务含义和适用对象；
2. 标记初始、进行中、等待、异常和终止状态；
3. 为每个转换绑定触发动作；
4. 定义 guard、前置条件和业务效果；
5. 说明是否可逆、可重开、可取消或只读；
6. 区分“业务状态”“显示状态”“派生标签”和“技术处理状态”；
7. 检查孤立状态和无入口 / 无出口状态；
8. 记录历史状态是否影响审计和权限。

#### 输出与写入范围

建议 source of truth：

- `states/state-lifecycle-model.yml`；
- `states/state-lifecycle-model.md`；
- 必要时 `states/<object-id>-lifecycle.md`。

#### 人类决策控制

以下通常为 D2 / D3：

- 多个合理生命周期方案；
- 终态是否可重开；
- 提交、完成、批准、关闭是否为不同状态；
- 取消、失败、过期、撤回等异常分支；
- 状态变化影响权限、责任、计费、审计或数据保留；
- confirmed 状态被删除或合并。

#### 被动触发行为

- 接收动作、规则、流程和 QA 场景的变化；
- 状态变化向规则、权限、产品表达、需求表达、后端、前端和 QA 传播；
- 发现状态转换没有动作或动作没有状态效果时创建 internal Trigger。

#### 禁止越界

- 不用数据库 enum 直接定义业务生命周期；
- 不把加载中、hover、网络重试等 UI / 技术状态写入核心状态模型；
- 不创建没有触发动作的业务转换；
- 不把规则全部嵌入状态图而失去独立权威源。

#### 完成条件

状态含义清楚；所有业务转换有动作；所有引用对象和动作存在；异常路径被考虑；高影响终态和重开策略已确认或标记待决。

---

### 8.10 规则权限建模器（`rule-policy-modeler`）

#### 职责

定义业务不变量、业务约束、例外条件和权限策略，回答“什么必须成立、什么不得发生、谁在什么条件下可以执行什么动作”。

#### 触发场景

- 新增审批、责任、删除、计费、隐私或审计规则；
- 动作需要权限；
- 状态转换需要 guard；
- 下游实现发现规则缺失或互相矛盾；
- 上游合规或业务约束变化。

#### 必要输入

- 对象、关系、动作和状态；
- 角色字典；
- 上游业务约束；
- 合规、计费、审计或组织规则；
- 当前规则与权限文件。

#### 核心处理逻辑

1. 为规则分配 ID、名称、范围和类型；
2. 定义适用对象、动作、状态或关系；
3. 写明条件、结论、禁止项、例外和冲突优先级；
4. 对权限定义 subject / role、action、target、condition、deny / allow 和责任边界；
5. 区分业务规则、权限策略、实现校验和数据库约束；
6. 检查循环规则、无主体规则、冲突规则和无法验证规则；
7. 标记审计证据、责任承担者和风险。

#### 输出与写入范围

建议 source of truth：

- `rules/business-rules.yml / .md`；
- `rules/permission-policy.yml / .md`。

#### 人类决策控制

以下均为 D2 或 D3：

- 权限、责任、审计、合规、隐私、删除和计费；
- deny / allow 冲突优先级；
- 谁可以审批谁、谁承担失败责任；
- 历史记录能否修改或删除；
- 例外流程；
- confirmed 规则或权限的废弃。

#### 被动触发行为

- 上游约束和合规变化直接触发影响分析；
- 下游授权、测试或数据库约束发现缺口时接收 Trigger；
- 规则变化向动作、状态、风险、需求表达、后端和 QA 传播。

#### 禁止越界

- 不把框架角色、ACL 表、JWT claim 或中间件代码当成业务权限源；
- 不直接设计数据库 constraint 或鉴权实现；
- 不自动接受高风险例外；
- 不生成无法绑定对象、动作、状态或关系的孤立规则。

#### 完成条件

规则可追溯、可解释、可验证；权限有主体、动作、对象和条件；冲突优先级清晰；所有 D2 / D3 判断有决定记录。

---

### 8.11 路线图与风险分析器（`roadmap-risk-modeler`）

#### 职责

说明业务模型的能力演进顺序、对象演进方向、MVP 简化、未来重构风险、业务运行风险和模型结构风险。

#### 触发场景

- 初始模型成形；
- 用户要求 Roadmap；
- 发现当前设计能支撑 MVP 但可能限制未来；
- confirmed 变化造成跨域影响；
- 一致性校验发现结构性风险；
- 下游准备长期实现方案。

#### 必要输入

- 全部核心模型；
- 产品阶段和业务目标；
- 已知约束；
- Impact Report；
- 决策记录；
- 下游依赖情况。

#### 核心处理逻辑

1. 识别当前必须具备的核心对象和能力；
2. 区分“现在必须做”“可以 provisional 预留”“现在做会过度设计”；
3. 建立业务能力演进顺序，而非虚构日期；
4. 识别对象未来可能拆分、扩展或独立化的信号；
5. 记录业务风险和模型风险；
6. 为风险给出触发条件、影响、缓解建议和人类决策阈值；
7. 关联后续 Work Item 和 Trigger。

#### 输出与写入范围

- `roadmap/object-evolution-roadmap.md`；
- `roadmap/capability-roadmap.md`；
- `risks/business-risk-register.md`；
- `risks/model-risk-register.md`。

#### 人类决策控制

以下必须升级：

- 选择互斥的能力演进路径；
- 接受 high / critical 风险；
- 为短期速度牺牲审计、权限或数据独立性；
- 确定对象未来拆分或废弃；
- 将 provisional 风险接受写成 confirmed 决策。

#### 被动触发行为

- 风险条件实际发生时创建 Trigger；
- confirmed 模型变化后重新评估受影响风险；
- 路线图中到达某能力前置条件时，可以创建建议 Trigger，但不得假装用户已启动该工作。

#### 禁止越界

- 不把 Roadmap 简化成无依据日期表；
- 不用“未来可能”阻塞所有当前决策；
- 不把风险建议当作 confirmed 产品战略；
- 不替代需求表达做开发切片。

#### 完成条件

Roadmap 按业务能力演进组织；风险有来源、触发信号、影响和缓解；高风险接受有用户决定；当前 MVP 与未来演进边界清晰。

---

### 8.12 下游视图编译器（`downstream-view-compiler`）

#### 职责

把同一套业务模型编译为适合不同消费者的派生视图，同时保持来源、状态、假设和缺口可追溯。

#### 支持的目标视图

```text
product-expression-view.md
requirements-view.md
database-view.md
backend-view.md
frontend-view.md
qa-view.md
ux-design-engineering-view.md
```

#### 触发场景

- 用户主动要求某个下游视图；
- 核心模型更新后需要重编译；
- Trigger Resolution 要求通知下游；
- 下游视图被校验为 stale；
- 产品表达、需求表达或工程团队准备消费模型。

#### 必要输入

- `BUSINESS_MODEL_INDEX.yml`；
- 相关核心模型资产；
- 目标消费者和编译范围；
- 输入状态、版本和决策记录；
- 现有下游视图。

#### 核心处理逻辑

1. 确认目标视图和消费目的；
2. 读取所需核心模型和状态；
3. 仅做面向消费者的重组、映射和解释；
4. 标记 source asset、baseline、confirmed / provisional 输入和缺口；
5. 继承最低权威状态：任何关键输入为 provisional，则视图不得宣称 confirmed；
6. 数据库视图只提供“可能映射”；
7. 发现核心语义缺失时生成 Trigger，而不是自行补齐；
8. 编译后执行目标视图校验。

#### 输出与写入范围

只写 `business-modeling/downstream-views/*`，不写核心模型；若目标项目存在 Design Engineering Harness，也不得直接写 `docs/design/*`，只能生成 `ux-design-engineering-view.md` 和后续 Trigger / Successor 建议。

#### 人类决策控制

编译本身通常为 D0 / D1。以下情况必须停止并升级：

- 一个业务属性有多个会改变业务含义的映射方案；
- 下游要求把关系或对象压扁为字段且会造成不可逆约束；
- provisional 语义已被要求作为正式工程合同；
- 编译暴露新的权限、责任、计费或删除判断。

#### 被动触发行为

- 发现核心缺口创建 `downstream_gap`；
- 核心模型变化后可接收 recompile Trigger；
- 编译完成后可向目标 Cluster 发出其协议可识别的 `upstream_change` Follow-up Trigger，由对方决定是否响应；本能力不新增未定义的 Trigger 类型。

#### 禁止越界

- 不反向修改核心模型；
- 不把技术实现映射写成业务事实；
- 不让数据库视图成为对象、属性或关系的权威源；
- 不隐藏 provisional 输入；
- 不在缺失语义时自行猜测并输出 confirmed 视图。

#### 完成条件

视图目标明确、来源可追溯、状态继承正确、缺口显式、没有越权语义，并通过对应消费者的结构校验。

---

### 8.13 项目业务模型解析器（`project-model-extractor`）

#### 职责

从已有项目文档和实现中恢复业务模型候选，并建立“来源证据 → 候选语义 → 置信度 → 冲突”的证据链。

#### 可读取来源

```text
README、PRD、已有 docs、数据库 schema、API routes、类型定义、页面组件、测试用例、路由结构、命名约定、表单、错误文案和运行行为。
```

#### 触发场景

- 当前项目没有系统业务模型；
- 用户要求从项目反推模型；
- 需要检查文档与实现偏差；
- 下游代码中出现未建模对象、动作、状态或规则；
- 迁移旧项目到 DesignHarnessAgent。

#### 必要输入

- 项目文件范围；
- 当前模型基线（如有）；
- 排除目录和技术约束；
- 用户指定的重点领域；
- 证据记录模板。

#### 核心处理逻辑

1. 建立源清单和证据定位；
2. 识别候选对象、属性、角色、关系、动作、状态和规则；
3. 将技术表达翻译为可能的业务语义，例如把 `_id` 识别为关系线索而非业务属性；
4. 为每个候选记录证据、反证、置信度和替代解释；
5. 识别同名异义、异名同义和实现折中；
6. 输出候选模型和冲突；
7. 将候选交给更新分发器和相应语义模块；
8. 默认保持 draft / provisional。

#### 证据等级建议

证据强度必须结合权威性、状态和新旧程度判断，不能机械排序。一般可参考：

- 明确的人类 confirmed 决定；
- 当前有效的业务规则或验收测试；
- 运行行为和接口合同；
- 数据结构与类型；
- 页面、文案和命名；
- 仅靠文件名或变量名的弱推断。

两个 confirmed 来源冲突时，解析器不得自行选择。

#### 输出与写入范围

- `artifacts/MODEL_EXTRACTION_REPORT.md`；
- `artifacts/SOURCE_EVIDENCE.md`；
- `MODELING_CONSUMPTION.md` 的来源清单；
- provisional 变更提案；
- internal Trigger。

解析器不得直接把候选写为 confirmed 核心模型。

#### 人类决策控制

以下必须升级：

- 对象身份只能由实现命名推断；
- 数据结构和用户文案表达冲突；
- 现有实现可能违反业务意图；
- 关系、动作、状态、规则存在多个解释；
- 推断会影响权限、计费、删除、审计或责任。

#### 被动触发行为

- 发现未建模语义、冲突或过期资产时创建 `internal_discovery`；
- 若发现的是其他 Cluster 的知识缺口，可创建定向 Follow-up Trigger；
- 不直接把所有发现都变成高优先级 Trigger，应先聚类和去重。

#### 禁止越界

- 不把数据库 schema 直接复制成业务模型；
- 不把代码现状自动视为正确业务规则；
- 不无证据地补齐对象和流程；
- 不修改 confirmed 核心模型；
- 不把完整代码复制到证据文件。

#### 完成条件

来源范围可追溯；候选有证据、置信度和状态；冲突明确；没有候选被静默升级为 confirmed；后续更新计划可执行。

---

### 8.14 模型一致性检查器（`model-consistency-validator`）

#### 职责

检查业务模型内部、任务资产与下游视图之间的一致性，发现结构错误、引用缺失、语义冲突、越界内容和过期视图。

#### 触发场景

- 任一核心资产更新后；
- 被动触发即将 Resolution；
- 用户主动要求校验；
- 下游编译前后；
- 项目解析候选准备进入核心模型；
- 任务准备关闭。

#### 必要输入

- `BUSINESS_MODEL_INDEX.yml`；
- 全部或指定范围的核心模型；
- 任务级 Decision / Impact / Extraction 报告；
- 下游视图；
- 校验规则。

#### 核心校验合同

至少检查：

1. 业务字典与 `schema-view.json` 是否一致；
2. 每个 schema 对象是否有字典条目和对象画像；
3. 关系引用的对象是否存在；
4. 每个动作是否有 actor、target、preconditions 和 effects；
5. 每个业务状态转换是否有触发动作；
6. 每条规则是否绑定对象、关系、动作或状态；
7. 权限是否有主体、动作、目标和条件；
8. 核心资产是否误用数据字段、技术类型或 API 语义；
9. derived view 是否引用过期 baseline；
10. provisional 内容是否被下游标成 confirmed；
11. superseded / deprecated 内容是否仍被默认引用；
12. Decision Notes、Trigger 和 Impact Report 的链接是否闭合；
13. sealed 内容是否被修改；
14. 同一 ID 是否唯一、状态是否有效。

#### 严重级别

```text
critical  会导致错误业务语义、越权、历史改写或无法安全下游消费
warning   存在缺口、歧义、过期或 provisional 依赖
info      格式、可读性或非阻塞改进
```

#### 输出与写入范围

- `artifacts/MODEL_CONSISTENCY_REPORT.md`；
- D0 机械修复建议；
- internal Trigger；
- 关闭准备结果。

校验器不得直接重写 D1–D3 业务语义。

#### 人类决策控制

以下必须升级：

- 两个 confirmed source of truth 冲突；
- 修复需要改变对象、关系、动作、状态、规则或权限；
- provisional 已被 confirmed 下游依赖；
- 需要废弃 confirmed 资产；
- 发现 sealed 历史被修改。

#### 被动触发行为

- 对语义问题创建 `internal_discovery`；
- 对其他 Cluster 的错误消费创建 `cross_cluster_conflict`；
- 对 stale 下游视图创建 recompile 请求；
- 相同问题应使用 dedupe_key 聚合。

#### 禁止越界

- 不把“最容易修”的一方自动当作错误方；
- 不直接修改 confirmed 语义；
- 不把 warning 隐藏为通过；
- 不因格式正确就宣称模型语义正确；
- 不在 critical 未解决时宣称任务可关闭。

#### 完成条件

报告包含范围、基线、问题、严重级别、证据、建议所有者和下一步；critical 为零或有明确人类接受记录；Trigger 和修复任务可追溯。

---

## 9. Source of Truth 写入所有权

| 资产 | 主写入者 | 其他模块允许行为 | 权威说明 |
|---|---|---|---|
| `BUSINESS_MODEL_INDEX.yml / .md` | 总协调器 | 各模块提交更新摘要；校验器检查 | 导航与状态索引，不替代具体资产 |
| `business-dictionary.yml / .md` | 业务字典构建器 | 其他模块提交候选术语 | 术语、领域、分类、角色等权威源 |
| `schema-view.json / .md` | 业务结构视图生成器 | 字典 / 画像提供输入 | JSON 为结构视图权威源，Markdown 派生 |
| `domain-objects/*` | 业务对象画像构建器 | 关系 / 动作 / 状态模块提供链接 | 对象身份、边界、责任的权威源 |
| `relationships/*` | 对象关系建模器 | 其他模块只引用或提案 | 关系语义权威源 |
| `actions/*` | 业务动作建模器 | 状态 / 规则模块引用 | 动作语义权威源 |
| `states/*` | 状态生命周期建模器 | 动作 / 规则模块引用 | 业务状态和转换权威源 |
| `rules/business-rules*` | 规则权限建模器 | 其他模块提交约束候选 | 业务规则权威源 |
| `rules/permission-policy*` | 规则权限建模器 | 动作 / 状态模块引用 | 权限策略权威源 |
| `roadmap/*`、`risks/*` | 路线图与风险分析器 | 各模块提交风险信号 | 演进和风险权威源 |
| `downstream-views/*` | 下游视图编译器 | 下游消费者只读或创建 Trigger | 派生视图，不是核心权威源 |
| `model-triggers/MT-xxx.md` | 模型触发处理器 | 来源 Cluster 创建初稿；业务模型回写 Resolution | 触发事件权威记录 |
| `STATE.md` | 总协调器通过状态管理协议 | 子能力提交 checkpoint | 任务权威状态快照 |
| `MODELING_CONSUMPTION.md` | 总协调器 | 解析器补充来源 | 本任务输入、基线、假设和缺口 |
| `MODELING_OUTPUT.md` | 总协调器 | 路由器和子能力提交输出摘要 | 本任务产出、变更和未决事项 |
| `DECISION_NOTES.md` | 人类决策控制层通过总协调器 | 子能力创建请求草案 | 高影响产品判断权威记录 |
| `MODEL_EXTRACTION_REPORT.md` | 项目业务模型解析器 | 其他模块只读 | 解析证据和候选，不是核心权威源 |
| `MODEL_CONSISTENCY_REPORT.md` | 模型一致性检查器 | 其他模块响应 | 校验结果，不是核心权威源 |
| `MODEL_IMPACT_REPORT.md` | 触发处理器协调、更新分发器供稿、总协调器落盘 | 语义模块提供影响 | 影响分析与计划，不是授权或核心权威源 |

---

## 10. 状态继承与版本传播规则

1. **派生状态不高于输入状态**：关键输入包含 provisional，则派生视图最多为 provisional；
2. **confirmed 不因重排而降级**：D0 机械重建可继承 confirmed；
3. **confirmed 变化产生 stale 信号**：核心源更新后，未重编译视图必须标记 stale 或创建 Trigger；
4. **不覆盖历史**：重大变更要保留旧 ID、替代关系和 Decision；
5. **新资产与改旧资产不同**：新 provisional 资产可以进入 source-of-truth 目录；对已有 confirmed 资产的高影响修改在确认前只进入提案区；
6. **两个 confirmed 冲突时不自动择一**：创建 Decision Request；
7. **上游 confirmed 不等于模型方案唯一**：上游决定是约束，业务模型仍可能有多个合理结构；
8. **sealed 不参与静默迁移**：只能只读引用并创建 Successor 或新版本。


---

## 11. 六种入口模式的模块协作流程

### 11.1 入口模式判定原则

每次顶层请求只能记录一个 `primary entry mode`，但可以调用其他模式的局部能力。例如：项目解析模式可以在末尾调用一致性校验和下游编译；被动触发模式可以调用项目解析补证据。

建议判定顺序：

1. 明确提供或引用 `MT-xxx.md` → 被动触发；
2. 明确要求从现有项目反推 / 解析 → 当前项目解析；
3. 明确要求检查、审计、找冲突 → 一致性校验；
4. 明确要求生成数据库、后端、前端、QA 等消费视图 → 下游视图编译；
5. 只有模糊想法、尚无稳定对象和流程 → 从零建模；
6. 其他明确建模请求 → 用户主动建模。

当两个模式都合理且会改变 Work Item 范围时，总协调器必须记录推荐并请求用户绑定；不得静默切换。

---

### 11.2 用户主动建模模式（`direct_modeling`）

#### 适用条件

用户明确提出可定位的建模任务，例如：

```text
新增一个业务对象；
补充“当前执行人”业务属性；
梳理人员与工单关系；
定义提交和完成的区别；
补充审批状态和权限规则。
```

#### 主流程

```text
用户请求
  ↓
modeling-orchestrator：绑定 / 创建 BM Work Item
  ↓
读取当前基线与 MODELING_CONSUMPTION
  ↓
model-update-router：拆分受影响资产和 D0–D3
  ↓
调用相关语义模块
  ↓
Human Decision Control Plane（按需）
  ↓
写入 source of truth
  ↓
model-consistency-validator
  ↓
按需 downstream-view-compiler
  ↓
MODELING_OUTPUT + 状态检查点
```

#### 最小必调模块

- `modeling-orchestrator`；
- `model-update-router`；
- 至少一个语义生产模块；
- `model-consistency-validator`。

#### 必要产物

- `STATE.md`；
- `MODELING_CONSUMPTION.md`；
- `MODELING_OUTPUT.md`；
- 若有 D2 / D3：`DECISION_NOTES.md`；
- 受影响的核心模型资产；
- `MODEL_CONSISTENCY_REPORT.md` 或其任务级摘要。

#### 人类决策点

- 新的核心对象默认至少为 D2；
- 单纯增加示例或明确别名可 D0 / D1；
- 对 confirmed 资产的核心语义修改必须确认；
- 用户可以允许 provisional 推进，但不能被解释为 confirmed。

#### 完成条件

请求范围已反映在核心模型或明确处于待决状态；无未解释 critical 一致性问题；下游影响已说明。

---

### 11.3 被动触发模式（`passive_trigger`）

#### 适用条件

收到上游变化、下游缺口、横向冲突或内部发现所生成的 Model Trigger。

#### 主流程

```text
收到 MT-xxx.md
  ↓
model-trigger-handler：验证来源 / 去重 / triage
  ↓
modeling-orchestrator：绑定或创建 BM Work Item
  ↓
model-update-router：初步 blast radius
  ↓
生成 MODEL_IMPACT_REPORT.md
  ↓
执行 D0 安全同步 + D1 provisional 候选
  ↓
Human Decision Control Plane 处理 D2 / D3
  ↓
相关语义模块更新 source of truth
  ↓
model-consistency-validator
  ↓
downstream-view-compiler 重编译受影响视图
  ↓
model-trigger-handler 回写 Resolution
  ↓
发出 Follow-up Triggers
```

#### 最小必调模块

- `model-trigger-handler`；
- `modeling-orchestrator`；
- `model-update-router`；
- 相关语义模块；
- `model-consistency-validator`；
- 受影响时调用 `downstream-view-compiler`。

#### 必要产物

- 更新后的 `MT-xxx.md`；
- `MODEL_IMPACT_REPORT.md`；
- BM Work Item 四个主文件；
- 决策记录（如有）；
- 核心模型更新；
- 重编译视图和 Follow-up Trigger（如有）。

#### Human-in-the-loop 特别规则

- 被动触发可以自动发现和分析，不可自动确认高影响重构；
- 上游 confirmed 决定是事实约束，但不代表业务模型结构方案已自动批准；
- 若用户暂缓 D2 / D3 决策，Trigger 进入 `awaiting_human`，不得 resolved；
- safe automatic updates 必须与 blocked semantic updates 分开记录。

#### 完成条件

Trigger 的影响已闭环：更新、校验、重编译、Resolution 和后续传播均可追溯。仅“生成报告”不等于 resolved。

---

### 11.4 当前项目解析模式（`project_extraction`）

#### 适用条件

用户希望从已有代码、文档、数据结构、页面或测试中恢复业务模型。

#### 主流程

```text
用户指定项目 / 范围
  ↓
modeling-orchestrator：创建解析 Work Item
  ↓
project-model-extractor：盘点来源与证据
  ↓
SOURCE_EVIDENCE + MODEL_EXTRACTION_REPORT
  ↓
model-update-router：按术语 / 对象 / 关系 / 动作 / 状态 / 规则分发
  ↓
语义模块生成 draft / provisional 候选
  ↓
model-consistency-validator：候选内部与现有模型对比
  ↓
Human Decision Control Plane：处理冲突和高影响推断
  ↓
确认后写核心模型；未确认内容保留 provisional
  ↓
按需编译下游视图
```

#### 最小必调模块

- `modeling-orchestrator`；
- `project-model-extractor`；
- `model-update-router`；
- 至少 `business-dictionary-builder` 和 `domain-object-profiler`；
- 其他语义模块按证据调用；
- `model-consistency-validator`。

#### 必要产物

- `SOURCE_EVIDENCE.md`；
- `MODEL_EXTRACTION_REPORT.md`；
- `MODELING_CONSUMPTION.md` 中的范围和排除项；
- draft / provisional 模型候选；
- 冲突和 Decision Requests。

#### Human-in-the-loop 特别规则

- 代码、数据库或 UI 现状不能自动成为 confirmed；
- 只有明确 confirmed 决定的机械转写可继承 confirmed；
- 数据结构暗示 Assignment、Approval 等独立对象时，只能提出候选；
- 冲突证据应展示不同解释和推荐，而不是让用户逐文件判断。

#### 完成条件

解析范围和证据覆盖清楚；每个候选有来源、置信度和状态；关键冲突已确认或显式待决；没有技术字段被直接当成业务属性。

---

### 11.5 从零建模模式（`greenfield_modeling`）

#### 适用条件

用户只有模糊产品想法，尚无稳定业务对象、动作、状态和规则。

#### 主流程

```text
模糊产品想法
  ↓
modeling-orchestrator：建立目标 / 用户 / 成功机制 / 约束假设
  ↓
business-dictionary-builder：候选领域、角色、对象、术语
  ↓
domain-object-profiler：核心对象画像
  ↓
schema-view-structurer：初始结构视图
  ↓
relationship-modeler
  ↓
action-command-modeler
  ↓
state-lifecycle-modeler
  ↓
rule-policy-modeler
  ↓
roadmap-risk-modeler
  ↓
model-consistency-validator
  ↓
分批 Human Decisions
  ↓
形成 provisional baseline / confirmed decisions
```

#### 默认策略

- 第一轮优先形成可讨论的 provisional 世界模型，不追求一次 confirmed 全部细节；
- 先确认对象身份、核心流程和高风险规则，再补充次要属性和例外；
- 不应因为未来可能性而过度设计；
- 不应为了“完整”虚构计费、权限、合规或异常流程。

#### 最小必调模块

除触发处理器、项目解析器和下游编译器外，其他核心模块通常都适用；但应按实际范围裁剪。

#### 必要产物

- 初始业务字典；
- 核心对象画像；
- schema-view；
- 核心关系、动作、状态和规则候选；
- Roadmap / Risk；
- Decision Notes；
- consistency report。

#### Human-in-the-loop 特别规则

- 对象身份、核心动作、状态分支和权限方案要分批确认；
- 不应把所有问题一次性抛给用户；
- 用户明确“先按推荐 provisional 推进”只授权 provisional，不授权 confirmed；
- 完成第一版 baseline 或封存 Work Item 仍需明确批准。

#### 完成条件

已经形成可被下游理解的最小闭环：对象、关系、动作、状态和关键规则相互一致；未决内容明确；Roadmap 说明哪些能力暂不建模。

---

### 11.6 一致性校验模式（`consistency_validation`）

#### 适用条件

用户或其他模块要求检查业务模型是否自洽、是否污染技术字段、是否与下游视图或决策记录一致。

#### 主流程

```text
指定校验范围
  ↓
modeling-orchestrator：锁定 baseline
  ↓
model-consistency-validator：运行结构与语义检查
  ↓
MODEL_CONSISTENCY_REPORT
  ↓
分类 D0 自动修复 / D1 provisional 修复 / D2-D3 决策问题
  ↓
model-update-router：生成 repair plan
  ↓
语义所有者执行修复
  ↓
Human Decision Control Plane（按需）
  ↓
重新校验
  ↓
按需创建 Trigger / 重编译视图
```

#### 最小必调模块

- `modeling-orchestrator`；
- `model-consistency-validator`；
- 有问题时调用 `model-update-router` 和相应语义模块。

#### 必要产物

- `MODEL_CONSISTENCY_REPORT.md`；
- 修复计划；
- 自动修复清单；
- Decision Requests 或 Trigger；
- 二次校验结果。

#### Human-in-the-loop 特别规则

校验器只能证明“不一致”或“违反合同”，不能在两个合理业务方案中自动决定哪一个正确。两个 confirmed 资产冲突必须由人处理。

#### 完成条件

critical 为零，或存在明确的用户风险接受 / 待决阻断记录；所有自动修复可追溯；没有校验器越权改写语义。

---

### 11.7 下游视图编译模式（`downstream_compilation`）

#### 适用条件

用户或下游 Cluster 请求数据库、后端、前端、QA、产品表达或需求表达视图。

#### 主流程

```text
指定 target view 和消费目的
  ↓
modeling-orchestrator：确认范围和 baseline
  ↓
model-consistency-validator：检查关键输入可消费性
  ↓
downstream-view-compiler：编译视图
  ↓
发现缺口？
  ├─ 否 → 校验视图并交付
  └─ 是 → 创建 downstream_gap Trigger
             ↓
          可输出 partial / provisional view + blockers
```

#### 最小必调模块

- `modeling-orchestrator`；
- `model-consistency-validator`；
- `downstream-view-compiler`；
- 若有缺口则 `model-trigger-handler`。

#### 必要产物

- 目标 `downstream-views/*`；
- 来源、baseline、输入状态和假设；
- 编译验证摘要；
- 缺口 Trigger（如有）。

#### Human-in-the-loop 特别规则

- 仅重排 confirmed 语义通常无需确认；
- 任何需要选择对象压扁方式、责任归属、权限、计费、删除或不可逆映射的情况必须升级；
- 缺口存在时不得由编译器自行补模型。

#### 完成条件

视图可追溯、状态正确、消费边界清楚；若只能 partial，则 blockers 和 Trigger 已创建，不能伪称完整 confirmed 交付。

---

### 11.8 模式组合与中途切换

常见组合：

```text
project_extraction → consistency_validation
passive_trigger → project_extraction（补证据）
passive_trigger → downstream_compilation
Greenfield → downstream_compilation
consistency_validation → passive_trigger（向其他 Cluster 传播冲突）
```

切换规则：

1. primary mode 保持不变，支持操作写入 `MODELING_OUTPUT.md`；
2. 若支持操作扩大成独立目标和验收范围，应创建 Successor Work Item；
3. 当前 Work Item 未完成时，不得为了切换而错误标记 completed；
4. 新模式若引入新的 D2 / D3 判断，必须重新进入人类决策控制层；
5. 不得因为调用下游编译器就把派生视图变成核心模型的一部分。

---

## 12. 任务级文件工作逻辑

### 12.1 推荐结构

```text
docs/product/work-items/BM-xxx/
├── STATE.md
├── MODELING_CONSUMPTION.md
├── MODELING_OUTPUT.md
├── DECISION_NOTES.md
└── artifacts/
    ├── MODEL_EXTRACTION_REPORT.md
    ├── MODEL_CONSISTENCY_REPORT.md
    ├── MODEL_IMPACT_REPORT.md
    └── SOURCE_EVIDENCE.md
```

并非每个 Work Item 都必须产生四份 artifact；但四个主文件 SHOULD 始终存在。

### 12.2 `STATE.md`

只保存恢复当前任务所需的最小权威上下文：

- 当前入口模式；
- 当前 phase / checkpoint；
- 范围和验收标准；
- 当前模型 baseline；
- 已批准决定摘要；
- 待确认 Decision IDs；
- 相关 Trigger；
- 关键产物链接；
- blocker；
- 下一步。

不得复制完整业务模型、完整报告或完整对话。

### 12.3 `MODELING_CONSUMPTION.md`

回答“本任务消费了什么”：

```markdown
# Modeling Consumption

## Entry Mode
## Requested Scope
## Model Baseline
## Consumed Confirmed Sources
## Consumed Provisional Sources
## Source Evidence
## Assumptions
## Missing Inputs
## Related Triggers
## Explicit Non-scope
```

### 12.4 `MODELING_OUTPUT.md`

回答“本任务生产和改变了什么”：

```markdown
# Modeling Output

## Outcome Summary
## Assets Created
## Assets Updated
## Provisional Proposals
## Superseded / Deprecated Assets
## Update Plan and Execution Result
## Validation Result
## Downstream Views Recompiled
## Decisions Applied
## Unresolved Decisions
## Triggers Resolved
## Follow-up Triggers
## Recommended Next Work Item
```

### 12.5 `DECISION_NOTES.md`

建议每个决定使用稳定 ID：`BMD-001`、`BMD-002`。

```markdown
# Business Modeling Decision Notes

## BMD-001 — Seat 是否为独立业务对象

- Status: proposed | confirmed | rejected | deferred | superseded
- Impact Level: D2 | D3
- Requested At:
- Confirmed At:
- Related Trigger:
- Affected Assets:

### Context
### Options Considered
### Recommendation
### Human Decision
### Decision Rationale
### Consequences
### Rejected Alternatives
### Follow-up Updates
```

`DECISION_NOTES.md` 是高影响业务判断的权威任务记录。核心资产应链接对应 Decision ID，而不是复制完整讨论。

### 12.6 `SOURCE_EVIDENCE.md`

只在项目解析或需要证据链的任务中生成，记录：

- 来源路径或引用；
- 证据摘要；
- 证据时间 / 版本；
- 支持的候选语义；
- 反证；
- 置信度；
- 是否来自 confirmed 决定。

不得复制大量源代码或完整文档。

---

## 13. 模式与模块调用矩阵

| 入口模式 | 必调模块 | 常用模块 | 条件模块 |
|---|---|---|---|
| 用户主动建模 | 总协调器、更新分发器、相关语义模块、一致性检查器 | 路线图风险 | 下游编译器、触发处理器 |
| 被动触发 | 触发处理器、总协调器、更新分发器、一致性检查器 | 相关语义模块、下游编译器 | 项目解析器、路线图风险 |
| 当前项目解析 | 总协调器、项目解析器、更新分发器、一致性检查器 | 字典、对象画像、其他语义模块 | 下游编译器、触发处理器 |
| 从零建模 | 总协调器、更新分发器、字典、对象画像、schema、关系、动作、状态、规则、一致性检查器 | 路线图风险 | 下游编译器 |
| 一致性校验 | 总协调器、一致性检查器 | 更新分发器、相关语义模块 | 触发处理器、下游编译器 |
| 下游视图编译 | 总协调器、一致性检查器、下游编译器 | 触发处理器 | 相关语义模块（通过新任务或触发） |

---

## 14. 跨模块一致性不变量

以下不变量在所有入口模式下都必须成立：

1. 每个对象 ID 唯一，并在业务字典中有定义；
2. 每个 schema 对象必须有业务领域、对象分类和对象画像；
3. schema-view 只含五类允许信息；
4. 核心业务模型不包含产品数据字段和技术类型；
5. 每个关系两端对象存在；
6. 每个动作有 actor、target、preconditions 和 effects；
7. 每个状态转换由业务动作触发；
8. 每条规则和权限策略可绑定到对象、关系、动作或状态；
9. 对象画像中的关系、生命周期和规则仅作摘要并链接各自权威源；
10. 高影响 provisional 方案不得覆盖 confirmed 资产；
11. 下游派生视图不得高于源模型状态；
12. 解析候选不得自动 confirmed；
13. 校验器、编译器和触发处理器不得越权写核心语义；
14. Trigger 必须可追溯到来源，并有完整 Resolution；
15. Decision 必须可追溯到受影响资产；
16. deprecated / superseded 资产不得被默认当作当前模型；
17. sealed 内容不得静默改写；
18. 任何 critical 问题都必须阻止“完整完成”声明；
19. `BUSINESS_MODEL_INDEX` 与实际资产路径和状态一致；
20. 核心模型更新后，受影响的下游视图必须重编译或明确标记 stale。

---

## 15. Adapter 实现合同

Codex、Claude Code、Cursor 等 Adapter 可以采用不同工具和配置，但都必须实现相同行为：

- 读取同一套 Core 协议；
- 将请求归一化为六种入口模式；
- 在项目中读写相同的 Agent-neutral Knowledge Assets；
- 不把会话内记忆当作 source of truth；
- 不绕过 `STATE.md`、Decision Notes、Trigger 和 Impact Report；
- 不因运行时支持 subagent 就增加额外语义权威源；
- 所有运行时专属文件只放在 Adapter 层；
- Adapter 不得修改核心枚举和写入所有权。

Adapter 可以优化并发读取，但第一版没有多写入者并发锁。发生潜在并发时，必须选择单一写入者并重新读取目标文件后再写。

---

## 16. 人工评测场景 v0.2

### 16.1 新增低影响业务属性

**Given**：`WorkOrder` 已 confirmed，用户明确补充“期望完成时间”为业务属性，且不改变关系、动作、状态或规则。  
**When**：用户主动建模。  
**Then**：可生成 D1 provisional 更新；同步字典、对象画像和 schema-view；不得写成 `expected_completed_at`；完成一致性检查。

### 16.2 核心对象身份歧义

**Given**：邀请是否属于 `Member` 的属性，还是独立 `Invitation` 对象存在两个合理方案。  
**When**：从零建模或项目解析。  
**Then**：不得自动 confirmed；创建 BMD Decision Request，给出方案、影响和推荐；confirmed 源保持不变。

### 16.3 上游计费模式变化

**Given**：商业分析 confirmed 从按 Workspace 计费改为按 Seat 计费。  
**When**：创建 `upstream_change` Trigger。  
**Then**：生成 `MODEL_IMPACT_REPORT.md`；分析 Seat、Member、Invitation、权限、数据库视图和 QA 影响；高影响对象重构等待人类；Trigger 未完成前不得 resolved。

### 16.4 下游字段不能反推为核心属性

**Given**：数据库视图存在 `current_executor_id`，核心业务模型只有“当前执行人”概念且多人协作未来不确定。  
**When**：下游请求回填。  
**Then**：不得把 `_id` 写入核心模型；应评估“当前执行人”属性与 Assignment 独立对象方案，并按 D2 处理。

### 16.5 横向“提交 / 完成”冲突

**Given**：产品表达把“提交”写成“完成”，业务动作目录认为两者不同。  
**When**：创建 `cross_cluster_conflict` Trigger。  
**Then**：业务动作模型保持权威；影响报告说明状态和 UX 影响；需要时人类确认；向产品表达发出后续 Trigger。

### 16.6 项目解析不得自动 confirmed

**Given**：代码中有 `Approval` 表和 `approval_status` enum，但没有产品决定记录。  
**When**：项目解析。  
**Then**：解析器生成 Approval 候选、证据和置信度；不得直接 confirmed；由对象画像、关系、动作和状态模块进一步建模。

### 16.7 schema-view 边界

**Given**：有人要求把关系、动作、状态和数据库类型都放入 `schema-view.json`。  
**When**：结构视图生成。  
**Then**：拒绝越界，只保留对象、领域、分类、属性和示例；其他内容链接到对应 source of truth。

### 16.8 动作缺少 actor

**Given**：动作目录出现“关闭工单”，但没有 actor。  
**When**：一致性校验。  
**Then**：产生 critical 或 warning（按影响）问题；校验器不得猜测 actor；路由到动作建模器并可能请求人类决定。

### 16.9 状态转换缺少动作

**Given**：`待审批 → 已关闭` 没有触发动作。  
**When**：一致性校验。  
**Then**：报告不合法转换；不得由状态模块凭空补动作；路由到动作和状态模块协同处理。

### 16.10 下游编译发现模型缺口

**Given**：QA 视图需要“审批人不能审批自己的提交”，但核心规则不存在。  
**When**：下游视图编译。  
**Then**：编译器不自行添加规则；创建 `downstream_gap` Trigger；输出 partial / provisional QA 视图并标记 blocker。

### 16.11 provisional 不能伪装 confirmed

**Given**：某对象关系仍 provisional，但 backend-view 请求正式实现合同。  
**When**：编译后端视图。  
**Then**：视图最多 provisional；必须复述假设和风险；若已经进入实现，升级 Human Decision Request。

### 16.12 sealed 历史不可改写

**Given**：BM-001 已 sealed，用户提出相关但独立的新模型重构。  
**When**：继续任务。  
**Then**：只读引用 BM-001，创建 Successor；不得修改旧 STATE、Decision 或 sealed 基线。

### 16.13 Trigger 去重

**Given**：数据库和后端分别报告同一个“Assignment 缺失”问题，dedupe key 相同。  
**When**：触发处理器 triage。  
**Then**：合并或互链到同一主 Trigger / BM Work Item，不重复创建冲突更新。

### 16.14 confirmed 冲突必须人类处理

**Given**：商业分析 confirmed “审批由直属主管执行”，业务模型 confirmed “审批由独立审计员执行”。  
**When**：一致性校验或 Trigger 处理。  
**Then**：不得自动择一；创建 D3 决策，阻止相关 confirmed 更新和下游正式编译。

---

## 17. v0.2 Definition of Done

### 架构与边界

- [x] 业务模型保持 Agent-neutral；
- [x] Core / Adapter / Project Assets 三层边界明确；
- [x] 六段式能力集群架构明确；
- [x] 14 个子能力均有完整工作合同；
- [x] 业务属性与数据字段边界明确；
- [x] `schema-view.json` 五项边界明确。

### Human Decision Control Plane

- [x] D0–D3 影响分级明确；
- [x] 自动 draft / provisional 与 confirmed 的边界明确；
- [x] 高影响修改不得覆盖 confirmed 语义；
- [x] Decision Request 和 `DECISION_NOTES.md` 协议明确；
- [x] deprecated、superseded、sealed 的人类控制明确；
- [x] provisional 下游消费规则明确。

### Passive Trigger Interface

- [x] `model-requests` 升级为 `model-triggers`；
- [x] Trigger 类型、生命周期、优先级和去重规则明确；
- [x] `MT-xxx.md` 完整模板明确；
- [x] `MODEL_IMPACT_REPORT.md` 完整模板明确；
- [x] Trigger 与 BM Work Item、Decision、下游 Follow-up 的闭环明确；
- [x] 被动发现不得自动确认高影响重构。

### 模块协作

- [x] 六种入口模式完整；
- [x] 每种入口的必调模块、产物、人类决策点和完成条件明确；
- [x] 模式组合与中途切换规则明确；
- [x] source-of-truth 写入所有权明确；
- [x] 解析器、校验器、编译器和触发处理器的越权限制明确；
- [x] 状态继承与 stale 传播规则明确。

### 评测与实施准备

- [x] v0.2 核心人工评测场景覆盖；
- [x] 文档可直接拆分为 `CAPABILITY.md`、protocols、assets 和 evals；
- [x] 不依赖 CLI、Hook、Plugin、Marketplace 或外部运行时；
- [x] 不实现自动数据库迁移、自动 API 生成或云端控制台。

---

## 18. 建议落盘映射

将本文转入正式仓库时，建议拆分为：

```text
core/product-design/business-modeling/
├── CAPABILITY.md
├── capability.manifest.yml
├── protocols/
│   ├── entry-modes.md
│   ├── human-decision-control-plane.md
│   ├── passive-trigger-interface.md
│   ├── model-trigger.schema.md
│   ├── model-impact-report.md
│   ├── source-of-truth-ownership.md
│   └── status-and-propagation.md
├── references/
│   ├── business-attribute-vs-data-field.md
│   ├── schema-view-boundary.md
│   └── subcapability-work-contracts.md
├── assets/
│   ├── STATE.template.md
│   ├── MODELING_CONSUMPTION.template.md
│   ├── MODELING_OUTPUT.template.md
│   ├── DECISION_NOTES.template.md
│   ├── MODEL_TRIGGER.template.md
│   ├── MODEL_IMPACT_REPORT.template.md
│   ├── MODEL_EXTRACTION_REPORT.template.md
│   ├── MODEL_CONSISTENCY_REPORT.template.md
│   └── SOURCE_EVIDENCE.template.md
└── evals/
    └── scenarios/
```

`CAPABILITY.md` 应保留：定位、硬原则、六种入口、14 个模块摘要、Human Decision Control Plane、Passive Trigger Interface、运行合同和禁止行为；长模板与详细评测可以拆到 `protocols/`、`assets/` 和 `evals/`。

---

## 19. v0.2 最终冻结结论

```text
1. Business Modeling 是 Agent-neutral Core。
2. 14 个子能力前四类负责生产、编排、风险、解析和校验。
3. Human Decision Control Plane 与 Passive Trigger Interface 是横切机制。
4. AI 可以自动产生 draft / provisional；高影响 confirmed、deprecated 和 sealed 必须有人类边界。
5. 新 provisional 资产可以建立，但不得静默覆盖既有 confirmed 语义。
6. model-triggers/MT-xxx.md 是上游变化、下游缺口、横向冲突和内部发现的统一入口。
7. MODEL_IMPACT_REPORT.md 是被动触发后的影响分析与更新计划，不是授权。
8. 解析器、校验器、编译器和触发处理器不能越权修改核心语义。
9. schema-view.json 永远只表达对象、领域、分类、业务属性和示例内容。
10. 核心业务模型只使用业务属性；技术字段只能出现在下游派生视图。
11. 六种入口模式可以组合，但必须有一个 primary mode，并保持 Work Item 边界。
12. 每次模型变更都必须可追溯到来源、Decision、Trigger、Work Item 和下游影响。
```

至此，Business Modeling Skill Cluster 子能力模块工作逻辑 v0.2 完成，可进入正式 PRD / `CAPABILITY.md` 编制与仓库实现阶段。
