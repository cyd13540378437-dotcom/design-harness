---
capability_id: product-business-modeling
display_name: 业务模型能力集群
version: v0.2.3
status: implementation-ready
language: zh-CN
agent_neutral: true
created_at: 2026-07-17
updated_at: 2026-07-22
---

# 业务模型能力集群（`product-business-modeling`）CAPABILITY v0.2.3

## 1. 一句话定义

业务模型能力集群负责把业务世界抽象成统一、稳定、可演进的产品语义模型，使商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 可以在同一套业务语言下协作。

它是 DesignHarnessAgent 的 **Agent-neutral Core**。运行时只负责调用与状态适配；项目里的 `docs/product/business-modeling/` 才是业务模型知识资产的长期 source of truth。

v0.2.3 增加一项重要用户体验合同：

> 业务负责人和产品负责人默认只阅读 `docs/product/BUSINESS_MODEL_OVERVIEW.md`；详细资产继续保留，用于维护、验证、审计和下游编译。

---

## 2. v0.2.3 解决的问题

真实 Greenfield 试运行证明核心建模质量已经可用，但暴露了以下协议漂移：

1. 模型文件很多，用户不知道先看什么；
2. Work Item 标准文件被自定义文件名替代或放错目录；
3. `STATE.md` 模板与 runtime steward 使用了不同字段；
4. `schema-view.json` 内容边界正确，但结构键不符合冻结协议；
5. `business-dictionary.yml` 和机器索引过薄，无法稳定引用；
6. Human Decision 只形成问题清单，没有完整决策压缩；
7. Action / State 缺少 stable ID 和跨文件引用；
8. 一个对象的推荐 / 决策状态被混入另一个对象的责任生命周期；
9. 上下文相关值被错误建模为单一对象固有属性；
10. 写完文件后没有强制追加 consistency validation 和总览编译。

v0.2.3 将这些问题从“建议”升级为 Core 的强制合同。

---

## 3. 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

### 3.1 Core

定义协议、入口模式、子能力、输出物、模板、评测和不可越界规则。

### 3.2 Runtime Adapters

将 Core 接入 Codex、Claude Code、Cursor 或其他 Agent。Adapter 可以改变调用形式，但不得改变 Core Schema、业务语义、文件协议、Human Decision Control Plane 或默认用户入口。

### 3.3 Project Knowledge Assets

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
docs/product/PRODUCT_WORK_ITEMS.md
```

`.codex/`、`.agents/`、`.claude/`、`.cursor/`、`AGENTS.md` 和 `CLAUDE.md` 是运行时入口，不是业务模型知识资产。

---

## 4. 用户阅读体验

### 4.1 唯一默认入口

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

它必须让用户仅阅读这一份文件就能理解：

```text
产品或业务模型是什么
当前边界是什么
核心对象和流程是什么
关键规则与权限是什么
当前版本应开发什么
哪些已经确认
哪些只是 provisional
现在需要用户确认什么
主要风险和最近更新是什么
```

### 4.2 其他文件继续保留

底层文件按原定义继续存在：

- 详细 Source of Truth 用于维护；
- Work Item 文件用于恢复、证据、审计和变更记录；
- 下游视图用于专业角色消费；
- Model Trigger 用于跨 Cluster 变化响应。

总览不会把这些文件合并成一个巨型 source of truth。

### 4.3 总览是编译视图

```text
is_default_user_entry: true
is_source_of_truth: false
writer: downstream-view-compiler
```

若总览与详细模型冲突，以详细模型为准，并立即重新编译总览。

---

## 5. 能力边界

### 5.1 负责生产和维护

```text
业务对象画像
业务字典
业务语义结构视图
对象关系
业务动作
状态生命周期
业务规则
权限策略
业务能力路线图
业务风险与模型风险
用户业务模型总览
下游业务模型视图
模型触发响应与影响分析
UX 业务模型上下文包
```

### 5.2 不负责

```text
数据库建模本体
数据库迁移
API 生成
页面流程或视觉设计
生产代码
测试代码
CLI / Hook / Plugin / Installer
云端同步与多用户锁
```

技术字段、接口和实现结构只能出现在下游视图，并标明为派生建议。

---

## 6. 硬原则

### 6.1 业务属性不是数据字段

合法：当前执行人、工单状态、审批意见、执行证据、业务角色。

非法核心表达：`current_executor_id`、`work_order.status`、`approval_comment`、`role_id`。

### 6.2 属性必须属于对象自身

若一个值依赖另一个对象、时间、起点与终点、策略版本、候选方案或评估上下文，它通常不是单一对象固有属性。

例如“到达成本”应属于资源与位置关系、候选评估或派生计算，而不是位置对象本身。

### 6.3 `schema-view.json` 只有唯一结构

它只回答五个问题：对象、领域、分类、业务属性和示例内容。

允许键固定为：

```text
schema_version
view_type
objects
object_id
object_name
object_label
business_domain: {id, label}
object_category: {id, label}
business_attributes: [{attribute_id, attribute_label, example_content}]
```

不得用其他键创建平行结构，也不得包含关系、动作、状态、规则、权限、技术字段、风险或下游影响。

### 6.4 对象身份必须单一明确

一个 `object_id` 只能代表一个业务身份。`Asset / Facility` 这类斜杠合并名称需要明确 umbrella concept，或进入 D2 对象身份决策。

### 6.5 Action / State 使用稳定引用

- Action 必须有 stable ID、actor role IDs、target object ID、preconditions 和 business effects；
- State transition 必须引用现有 state ID 与 action ID；
- Rule / Permission 必须绑定现有对象、动作或状态 ID。

### 6.6 一个生命周期只属于一个对象

推荐、决策、责任、Assignment 等不同业务对象必须拥有各自生命周期。

若一个 Action 从对象 A 创建对象 B，使用 Cross-object Materialization 表达，不得把 A 的状态塞进 B 的生命周期。

### 6.7 证据先于确认

从代码、数据库、接口、页面或测试中解析出的业务知识默认只能是 `draft` / `provisional`。

### 6.8 派生视图不能反向成为权威源

包括 `BUSINESS_MODEL_OVERVIEW.md` 在内的所有派生视图只能暴露缺口并创建 Trigger，不能直接改写 Core 语义。

### 6.9 高影响语义不可静默覆盖

未确认方案不得覆盖 confirmed 语义。被替代内容显式进入 `superseded` / `deprecated`。

### 6.10 封存权属于人类

AI 可以建议关闭，但不能自行 `sealed`。sealed 内容只读。

---

## 7. 知识状态与影响等级

### 7.1 知识状态

```text
draft
provisional
confirmed
superseded
deprecated
sealed
```

### 7.2 决策影响等级

```text
D0 = 机械同步，可自动执行
D1 = 可逆局部语义，可自动 provisional
D2 = 核心产品语义，确认或覆盖 confirmed 前必须由人决定
D3 = 治理与终态，必须明确人类决定
```

D2 / D3 包括对象身份、核心关系、业务动作、状态方案、责任、权限、审计、合规、计费、模型重构、confirmed 升级和 seal。

---

## 8. 六种入口模式

| 模式 | ID | 最小要求 |
|---|---|---|
| 用户主动建模 | `direct_modeling` | 相关 modeler → validator → overview compiler |
| 被动触发 | `passive_trigger` | Impact Report → model update → validator → overview → downstream → trigger resolution |
| 当前项目解析 | `project_extraction` | Evidence + Extraction Report；结果 provisional |
| 从零建模 | `greenfield_modeling` | provisional Core + decisions + validator + overview |
| 一致性校验 | `consistency_validation` | Consistency Report；必要时更新 overview |
| 下游视图编译 | `downstream_compilation` | overview + requested professional views |

所有修改 Core 的模式必须追加：

```text
consistency_validation
→ BUSINESS_MODEL_OVERVIEW.md compilation
→ required downstream compilation
```

---

## 9. 14 个子能力

| # | 子能力 | ID | 职责 |
|---|---|---|---|
| 1 | 业务模型总协调器 | `modeling-orchestrator` | 入口模式、Work Item、完成边界和交付体验。 |
| 2 | 模型更新分发器 | `model-update-router` | 将变更路由给单一写入者。 |
| 3 | 模型触发处理器 | `model-trigger-handler` | 创建、去重、推进和关闭 Trigger。 |
| 4 | 业务字典构建器 | `business-dictionary-builder` | 维护结构化术语、对象、属性、动作、状态、角色、领域和分类。 |
| 5 | 业务结构视图生成器 | `schema-view-structurer` | 生成唯一结构的 `schema-view.*`。 |
| 6 | 业务对象画像构建器 | `domain-object-profiler` | 对象身份、边界、责任和演进。 |
| 7 | 对象关系建模器 | `relationship-modeler` | 关系与上下文属性归属。 |
| 8 | 业务动作建模器 | `action-command-modeler` | actor、target、conditions、effects 和审计意义。 |
| 9 | 状态生命周期建模器 | `state-lifecycle-modeler` | 单对象生命周期、action 引用和跨对象创建。 |
| 10 | 规则权限建模器 | `rule-policy-modeler` | 规则、权限、责任与审计。 |
| 11 | 路线图与风险分析器 | `roadmap-risk-modeler` | MVP 简化、未来演进和风险。 |
| 12 | 下游视图编译器 | `downstream-view-compiler` | 编译用户总览与专业下游视图。 |
| 13 | 项目业务模型解析器 | `project-model-extractor` | 从项目证据提取候选模型。 |
| 14 | 模型一致性检查器 | `model-consistency-validator` | 执行完整合同校验并生成报告。 |

Human Decision Control Plane 与 Passive Trigger Interface 是横切机制。

---

## 10. Source of Truth 写入所有权

| 知识类型 | 文件 | 单一写入者 |
|---|---|---|
| 业务语言注册表 | `business-dictionary.*` | `business-dictionary-builder` |
| 结构浏览视图 | `schema-view.json/md` | `schema-view-structurer` |
| 对象画像 | `domain-objects/*` | `domain-object-profiler` |
| 关系 | `relationships/*` | `relationship-modeler` |
| 动作 | `actions/*` | `action-command-modeler` |
| 状态生命周期 | `states/*` | `state-lifecycle-modeler` |
| 规则与权限 | `rules/*` | `rule-policy-modeler` |
| Roadmap 与风险 | `roadmap/*`, `risks/*` | `roadmap-risk-modeler` |
| 用户总览 | `docs/product/BUSINESS_MODEL_OVERVIEW.md` | `downstream-view-compiler` |
| 专业下游视图 | `downstream-views/*` | `downstream-view-compiler` |
| Trigger | `model-triggers/MT-xxx.md` | `model-trigger-handler` |
| 任务状态 | `work-items/BM-xxx/STATE.md` | orchestrator / runtime state wrapper |
| D2 / D3 决策 | `DECISION_NOTES.md` | Human Decision Control Plane |

总览与下游视图都是派生视图，不是核心 source of truth。

---

## 11. 项目资产结构

```text
product-repository/
├── docs/
│   └── product/
│       ├── BUSINESS_MODEL_OVERVIEW.md      # 用户唯一默认入口
│       ├── PRODUCT_WORK_ITEMS.md
│       ├── model-triggers/
│       ├── business-modeling/
│       │   ├── BUSINESS_MODEL_INDEX.md     # 维护者导航
│       │   ├── BUSINESS_MODEL_INDEX.yml    # 机器索引
│       │   ├── business-dictionary.md
│       │   ├── business-dictionary.yml
│       │   ├── schema-view.json
│       │   ├── schema-view.md
│       │   ├── domain-objects/
│       │   ├── relationships/
│       │   ├── actions/
│       │   ├── states/
│       │   ├── rules/
│       │   ├── roadmap/
│       │   ├── risks/
│       │   └── downstream-views/
│       └── work-items/
│           └── BM-001-example/
│               ├── STATE.md
│               ├── MODELING_CONSUMPTION.md
│               ├── MODELING_OUTPUT.md
│               ├── DECISION_NOTES.md
│               └── artifacts/
│                   ├── SOURCE_EVIDENCE.md
│                   ├── MODEL_EXTRACTION_REPORT.md
│                   ├── MODEL_CONSISTENCY_REPORT.md
│                   └── MODEL_IMPACT_REPORT.md
└── runtime-specific adapter files
```

---

## 12. Canonical Work Item 合同

根目录四个文件和 `artifacts/` 四个标准报告使用固定名称和位置。

`PROPOSED_MODEL.md`、`EVIDENCE_AND_ASSUMPTIONS.md` 是 legacy aliases：新运行不得生成；读取旧项目时只能作为迁移输入，不能替代 canonical 文件。

### 12.1 `STATE.md` 冻结字段

```yaml
schema_version
state_id
title
slug
capability_id
entry_mode
binding_decision
status
phase
knowledge_status
awaiting_human
sealed
related_triggers
predecessors
created_at
updated_at
completed_at
extensions
```

Runtime Adapter 不得使用 `primary_entry_mode`、`awaiting_user`、`gate` 或自定义 authority 字段替代这些字段；运行时信息只能进入 `extensions` 或正文。

### 12.2 Phase 枚举

```text
intake
evidence
modeling
awaiting_decision
validation
compilation
completion_review
complete
```

---

## 13. 结构化模型合同

### 13.1 Business Dictionary

`business-dictionary.yml` 必须完整注册：

```text
business_domains
object_categories
business_objects
business_attributes
actions
states
roles
terms_not_to_use
```

每个引用使用 stable ID；Markdown 与 YAML 保持一致。

### 13.2 Business Model Index

`BUSINESS_MODEL_INDEX.yml` 必须登记存在的领域、对象、关系、动作、状态、规则、权限、下游视图和 open triggers，并声明默认用户视图。

### 13.3 Schema View

严格遵守五项边界和唯一键结构；所有 ID 必须可解析到业务字典。

### 13.4 Action / State / Rule

- Action actor / target / effects 缺失为 error；
- Transition action 或 state 引用缺失为 error；
- 生命周期跨对象混用为 error；
- Rule / Permission 绑定不存在 ID 为 error。

---

## 14. Human Decision Control Plane

所有 D2 / D3 判断使用 `BMD-xxx`。

在询问用户前必须给出：

```text
当前理解
为什么重要
2–3 个可行方案
各自优点与代价
Agent 推荐
用户可直接回复的选项
```

完整记录写入 `DECISION_NOTES.md`；用户可直接决策的压缩版本同步进入 `BUSINESS_MODEL_OVERVIEW.md`。

等待期间：

```yaml
phase: awaiting_decision
awaiting_human: true
```

---

## 15. 被动触发接口

Trigger 类型：

```text
upstream_change
downstream_gap
cross_cluster_conflict
internal_discovery
```

生命周期：

```text
open → triaged → in_progress → awaiting_human → resolved | dismissed | superseded
```

Trigger 只有在影响分析、模型响应、必要决策、一致性校验、总览编译、必要下游重编译和回写完成后才能 resolved。

---

## 16. 强制完成流水线

```text
绑定或创建 Work Item
→ 写 MODELING_CONSUMPTION.md
→ 写任务报告与候选
→ 解决或标记 Human Decisions
→ 更新正确的 source of truth
→ 执行 MODEL_CONSISTENCY_REPORT.md
→ 编译 BUSINESS_MODEL_OVERVIEW.md
→ 编译其他必要下游视图
→ 更新 MODELING_OUTPUT.md
→ 更新 STATE.md
→ 向用户只突出总览
```

若 consistency report 有 error，Work Item 不得被描述为完成；总览必须显示 `validation_status: issues_found`。

---

## 17. UX / Design Engineering 兼容性

Business Modeling 可以编译：

```text
ux-business-model-context.md
ux-business-model-context.yml
ux-design-engineering-view.md
```

但不得直接修改：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

UX 发现业务模型缺口时创建 `downstream_gap`，发现 confirmed 冲突时创建 `cross_cluster_conflict`。

---

## 18. Runtime Adapter 合同

支持：Codex、Claude Code、Cursor、Generic Agent 和 Multi-runtime。

Adapter 必须：

1. 读取 Core 合同；
2. 采用 canonical Work Item 文件；
3. 使用冻结 State Schema；
4. 在 Core 写入后强制校验与总览编译；
5. 向用户只突出总览；
6. 不重定义业务模型 source of truth。

---

## 19. 人工评测合同

v0.2.3 保留全部既有场景，并新增覆盖：

```text
唯一用户入口
总览派生边界与新鲜度
Canonical Work Item 文件
State Schema 一致性
Dictionary / Index / Schema 归一化
BMD 决策压缩
Action / State 稳定引用
跨对象生命周期边界
上下文属性归属
对象身份歧义
写入后强制校验与总览编译
最终用户交付只突出总览
```

所有场景使用 Given / When / Then。

---

## 20. Definition of Done

### 用户体验

- [ ] `BUSINESS_MODEL_OVERVIEW.md` 存在且为唯一默认用户入口；
- [ ] 用户不打开其他文件也能理解模型并处理待确认决策；
- [ ] 技术文件继续保留，不被粗暴合并。

### 协议

- [ ] Canonical Work Item 文件完整且位置固定；
- [ ] State 模板、Steward 和所有 Adapter 使用同一字段；
- [ ] `schema-view.json` 使用唯一结构；
- [ ] Dictionary / Index / Schema 引用一致；
- [ ] Action / State / Rule 使用 stable ID；
- [ ] 生命周期不跨对象混用；
- [ ] 上下文相关值不伪装成固有属性。

### Human Decision

- [ ] D2 / D3 使用 `BMD-xxx`；
- [ ] 用户请求前完成决策压缩；
- [ ] 总览包含足以直接决策的内容；
- [ ] AI 不自动 confirmed 或 sealed。

### 完成流水线

- [ ] 每次 Core 写入后执行 consistency validation；
- [ ] 总览反映最新校验、状态和决策；
- [ ] 需要的专业下游视图完成重编译；
- [ ] 最终回复默认只突出总览。

### 范围

- [ ] 无 CLI、Hook、Plugin、Installer 或外部运行时依赖；
- [ ] Agent-neutral Core 与 runtime adapters 边界保持不变。
