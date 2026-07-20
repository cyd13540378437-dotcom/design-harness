# DesignHarnessAgent — Product Business Modeling PRD v0.2.1 Complete

- **产品**：DesignHarnessAgent
- **能力集群**：业务模型能力集群（`product-business-modeling`）
- **版本**：v0.2.1
- **文档状态**：完整 Codex 开发 PRD / 可落仓 Core 规格
- **基线**：Business Modeling Core v0.2 reviewed + UX Business Model Context Pack v0.2.1
- **主要语言**：简体中文；稳定 ID、枚举和文件名使用英文

---

## 1. 产品摘要

Business Modeling Core 是 DesignHarnessAgent 产品设计知识系统中的业务模型能力集群。它负责把业务世界抽象为稳定、统一、可演进的产品语义模型，让商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 可以在同一套业务语言下协作。

它是 **Agent-neutral Core**，不是 Codex 专属 Skill。Codex、Claude Code、Cursor 只是运行时 Adapter；业务模型知识资产的长期 source of truth 位于目标项目的 `docs/product/business-modeling/`。

v0.2.1 是完整业务模型开发包：它包含 v0.2 的业务模型 Core、Human Decision Control Plane、Passive Trigger Interface、14 个子能力、六种入口模式、完整项目模板、示例、20 个评测，并合入 `UX Business Model Context Pack` 作为下游派生视图。

---

## 2. 背景与问题

产品设计进入实现前，常见问题包括：

1. 业务对象、页面、接口、数据库字段和用户文案混用；
2. 技术字段被误认为业务事实；
3. UI/UX 或需求文档自行补充业务规则，导致后端、数据库和 QA 冲突；
4. 上游商业分析变化后，下游没有统一影响分析；
5. 下游发现缺口时直接在本层乱补，而不是通过可审计触发机制回到业务模型；
6. AI 容易把 provisional 推断写成 confirmed 结论；
7. 已封存或已确认的语义被后续对话静默改写；
8. UX 设计需要业务语义输入，但全量读取业务模型会过重，完全不读取又会静默创造业务行为。

v0.2.1 用业务模型 source of truth、Model Trigger、Human Decision Control Plane、Downstream Views、UX Context Pack 解决这些问题。

---

## 3. v0.2.1 目标

本版本必须实现：

1. Agent-neutral 的业务模型 Core 规格；
2. Core / Adapter / Project Assets 三层架构；
3. 完整业务模型长期资产结构；
4. 完整 BM Work Item 任务级结构；
5. `schema-view.json` 极简结构视图；
6. 业务属性与数据字段严格分离；
7. 六种入口模式；
8. 14 个子能力模块；
9. Human Decision Control Plane；
10. Passive Trigger Interface；
11. `model-triggers/MT-xxx.md` 协议；
12. `MODEL_IMPACT_REPORT.md` 协议；
13. 下游视图编译机制；
14. 项目解析和一致性校验；
15. Codex / Claude Code / Cursor Adapter 规则片段；
16. 与既有 UX / Design Engineering Harness 的兼容性协议；
17. `ux-design-engineering-view.md` UX 影响派生视图；
18. `ux-business-model-context.md` 与 `.yml` UX 轻量业务上下文包；
19. 示例和 20 个人工评测场景；
20. 不新增 CLI、Hook、Plugin、安装器或外部运行时依赖。

---

## 4. 非目标

v0.2.1 不实现：

```text
CLI
Hook
Plugin
Marketplace
自动安装器
外部运行时依赖
自动数据库迁移
自动 API 生成
图形化控制台
云端同步
多用户并发锁
自动修改 UX / Design Engineering 状态文件
复杂文案别名系统
语义差异多级分层机制
```

本版本是协议完整、模板完整、评测完整、Agent-neutral 完整的文档型 Core 包。

---

## 5. 核心原则

### 5.1 产品设计知识契约网络

商业分析、业务模型、产品表达、需求表达不是瀑布 Gate，而是通过知识契约协作的 API Mesh。任意 Cluster 可以先启动，但必须声明消费来源、确认程度、假设、缺口、影响范围和人类决策要求。

### 5.2 业务属性不是数据字段

核心业务模型只表达业务属性。数据库字段、接口参数、持久化类型只能出现在下游派生视图中，并且必须标注为从业务语义编译出的实现建议。

### 5.3 `schema-view.json` 只表达结构浏览

`schema-view.json` 只表达：

```text
业务对象
业务领域
对象分类
业务属性
属性示例内容
```

它不得表达关系、动作、状态、规则、权限、数据库字段、接口、路线图、风险或下游影响。

### 5.4 Human Decision Control Plane 是横切机制

AI 可以自动生成 `draft` / `provisional`，但不能自动确认 D2 / D3 影响等级的业务语义，也不能自行 sealed。

### 5.5 Passive Trigger 是事件合同

`MT-xxx.md` 不是普通请求单，而是需要完成影响分析、模型响应、必要决策、校验、下游重编译和关闭回写的事件合同。

### 5.6 下游视图不能反向成为权威源

`downstream-views/*` 是派生视图，只为下游消费。若派生视图发现核心模型缺口，必须创建 Model Trigger，而不是直接补核心模型。

---

## 6. 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

### 6.1 Core

Core 定义能力本体、协议、模板、运行边界、入口模式、子能力、评测和不可越界规则。

### 6.2 Adapter

Adapter 负责把 Core 接入 Codex、Claude Code、Cursor 等运行时。Adapter 可以改变调用形式，但不得改变业务语义、文件协议和人类决策边界。

### 6.3 Project Assets

真实项目里的业务模型资产位于：

```text
docs/product/PRODUCT_WORK_ITEMS.md
docs/product/model-triggers/
docs/product/business-modeling/
docs/product/work-items/
```

`.codex/`、`.cursor/`、`CLAUDE.md` 等只是运行时入口，不是业务模型知识资产。

---

## 7. 项目资产结构

### 7.1 长期业务模型资产

```text
docs/product/business-modeling/
├── BUSINESS_MODEL_INDEX.md
├── BUSINESS_MODEL_INDEX.yml
├── business-dictionary.md
├── business-dictionary.yml
├── schema-view.json
├── schema-view.md
├── domain-objects/
├── relationships/
├── actions/
├── states/
├── rules/
├── roadmap/
├── risks/
└── downstream-views/
    ├── product-expression-view.md
    ├── requirements-view.md
    ├── database-view.md
    ├── backend-view.md
    ├── frontend-view.md
    ├── qa-view.md
    ├── ux-design-engineering-view.md
    ├── ux-business-model-context.md
    └── ux-business-model-context.yml
```

### 7.2 任务级输出

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

---

## 8. 六种入口模式

| 模式 | ID | 说明 |
|---|---|---|
| 用户主动建模 | `direct_modeling` | 用户明确要求新增、修改、补充业务模型。 |
| 被动触发 | `passive_trigger` | 上游变化、下游缺口或横向冲突触发模型响应。 |
| 当前项目解析 | `project_extraction` | 从现有项目提取候选业务模型和证据链。 |
| 从零建模 | `greenfield_modeling` | 从模糊想法建立 provisional 初始模型。 |
| 一致性校验 | `consistency_validation` | 检查模型内部和派生视图一致性。 |
| 下游视图编译 | `downstream_compilation` | 编译产品、需求、数据库、后端、前端、QA、UX 视图。 |

每次运行必须有一个 primary mode。多个模式可以组合，但必须保持 Work Item 边界清楚。

---

## 9. 14 个子能力

| # | 子能力 | ID | 分类 | 职责 |
|---|---|---|---|---|
| 1 | 业务模型总协调器 | `modeling-orchestrator` | 统筹与调度 | 判断入口模式、创建/恢复 Work Item、调用子能力、管理完成边界。 |
| 2 | 模型更新分发器 | `model-update-router` | 统筹与调度 | 将模型变化路由到正确 source of truth 和下游视图。 |
| 3 | 模型触发处理器 | `model-trigger-handler` | 统筹与调度 | 管理 `MT-xxx.md` 创建、去重、分流、状态和关闭。 |
| 4 | 业务字典构建器 | `business-dictionary-builder` | 核心生产 | 维护业务术语、业务属性、角色、动作、状态和分类语言。 |
| 5 | 业务结构视图生成器 | `schema-view-structurer` | 核心生产 | 生成 `schema-view.json/md`，并保护五项边界。 |
| 6 | 业务对象画像构建器 | `domain-object-profiler` | 核心生产 | 定义对象身份、边界、责任、生命周期和非目标。 |
| 7 | 对象关系建模器 | `relationship-modeler` | 核心生产 | 定义对象之间的业务语义关系。 |
| 8 | 业务动作建模器 | `action-command-modeler` | 核心生产 | 定义 actor、target、条件、业务效果和审计影响。 |
| 9 | 状态生命周期建模器 | `state-lifecycle-modeler` | 核心生产 | 定义对象状态、状态转换和触发动作。 |
| 10 | 规则权限建模器 | `rule-policy-modeler` | 核心生产 | 定义业务不变量、权限策略、责任和合规约束。 |
| 11 | 路线图与风险分析器 | `roadmap-risk-modeler` | 演进风险交接 | 识别 MVP 简化、未来演进、业务风险和模型风险。 |
| 12 | 下游视图编译器 | `downstream-view-compiler` | 演进风险交接 | 编译产品、需求、数据库、后端、前端、QA、UX 视图。 |
| 13 | 项目业务模型解析器 | `project-model-extractor` | 解析与校验 | 从现有项目提取候选业务模型和证据链。 |
| 14 | 模型一致性检查器 | `model-consistency-validator` | 解析与校验 | 校验模型一致性，发现冲突、缺口和过期视图。 |

Human Decision Control Plane 与 Passive Trigger Interface 是横切机制，不计入普通子能力。

---

## 10. Source of Truth 写入所有权

| 知识类型 | Source of Truth | 单一写入者 |
|---|---|---|
| 业务术语、业务属性、动作、状态、角色、分类 | `business-dictionary.*` | `business-dictionary-builder` |
| 结构浏览视图 | `schema-view.json`, `schema-view.md` | `schema-view-structurer` |
| 对象深度画像 | `domain-objects/<id>.md` | `domain-object-profiler` |
| 对象关系 | `relationships/relationship-map.md` | `relationship-modeler` |
| 业务动作 | `actions/action-command-catalog.md` | `action-command-modeler` |
| 状态生命周期 | `states/state-lifecycle-model.md` | `state-lifecycle-modeler` |
| 业务规则与权限策略 | `rules/*` | `rule-policy-modeler` |
| Roadmap 与风险 | `roadmap/*`, `risks/*` | `roadmap-risk-modeler` |
| 下游视图 | `downstream-views/*` | `downstream-view-compiler` |
| Model Trigger | `model-triggers/MT-xxx.md` | `model-trigger-handler` |
| BM 任务状态 | `work-items/BM-xxx/STATE.md` | `modeling-orchestrator` / Adapter state wrapper |
| 高影响决策 | `work-items/BM-xxx/DECISION_NOTES.md` | Human Decision Control Plane |

其他模块可以提供候选、报告和建议，但不得跨所有权直接写入。

---

## 11. Human Decision Control Plane

影响等级：

```text
D0 = 机械同步，可自动执行
D1 = 可逆局部语义，可自动 provisional
D2 = 核心产品语义，确认或覆盖 confirmed 前必须由人决定
D3 = 治理与终态，必须明确人类决定
```

必须进入人类决策的情况：

```text
对象身份存在互斥判断
对象关系影响权限、流程或数据库
业务动作改变核心流程
状态流转有多个合理方案
规则涉及责任、权限、审计或合规
上游变化导致模型重构
provisional 已被下游依赖
升级到 confirmed
关闭、封存或废弃重要模型资产
```

D2 / D3 决策必须写入 `DECISION_NOTES.md`，建议使用稳定 ID，例如 `BMD-001`。

---

## 12. Passive Trigger Interface

Trigger 类型：

```text
upstream_change
下游缺口：downstream_gap
横向冲突：cross_cluster_conflict
内部发现：internal_discovery
```

实际枚举值必须使用英文：

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

每个 Trigger 必须包含稳定 `trigger_id`、`dedupe_key`、来源、目标、优先级、影响范围、Work Item 绑定、Resolution 记录和必要的 Follow-up Trigger。

---

## 13. `MODEL_IMPACT_REPORT.md`

`MODEL_IMPACT_REPORT.md` 是影响分析和更新计划，不是业务决定，也不是修改 confirmed 模型的授权。

报告必须覆盖：

```text
Trigger
Change Summary
Evidence and Assumptions
Affected Business Domains
Affected Objects
Affected Business Attributes
Affected Relationships
Affected Actions
Affected States
Affected Rules and Permissions
Affected Downstream Views
Safe Automatic Updates
Provisional Change Proposals
Human Decisions Required
Recommended Update Plan
Revalidation and Recompilation Plan
Follow-up Triggers
Resolution Readiness
```

---

## 14. 下游视图编译

下游视图至少包括：

```text
product-expression-view.md
requirements-view.md
database-view.md
backend-view.md
frontend-view.md
qa-view.md
ux-design-engineering-view.md
ux-business-model-context.md
ux-business-model-context.yml
```

下游视图可以把业务属性转译为实现建议，但必须标明派生性质。发现核心模型缺口时创建 Model Trigger，不得直接补核心模型。

---

## 15. UX Business Model Context Pack

v0.2.1 新增 `ux-business-model-context.md` 与 `ux-business-model-context.yml`，作为 Business Modeling Core 给 UX / Design Engineering 的轻量业务模型上下文包。

### 15.1 定位

```text
ux-business-model-context.*
= UX 启动和设计过程中轻量读取的稳定业务语义输入

ux-design-engineering-view.md
= 业务模型变化后，对 UX 的影响分析与后续建议
```

两者都是 downstream view，不是 source of truth。

### 15.2 内容

Context Pack 至少包含：

```text
Consumption Policy
Generated From
Business Objects for UX
UX-Relevant Actions
UX-Relevant States
UX-Relevant Rules and Permissions
Open Model Triggers Affecting UX
When UX Should Create a Model Trigger
When UX Should Not Create a Model Trigger
Open Gaps
```

### 15.3 UX 触发规则

UX 只提示两类候选：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

映射为：

```text
business_model_gap_candidate      → trigger_type: downstream_gap
business_model_conflict_candidate → trigger_type: cross_cluster_conflict
```

本版本不引入复杂文案别名系统或语义差异多级分层。

### 15.4 启动与封存边界

Context Pack 存在时，UX / Design Engineering 可以轻量读取；缺失时不阻断 UX 启动。

但未解决的高影响业务模型缺口或 confirmed 冲突，不得被 UX sealed 为 confirmed 产品行为。

---

## 16. 与既有 UX / Design Engineering Harness 的兼容性

如果目标项目已存在 `docs/design/`、`REFERENCE_SELECTION.md`、Reference Library 或 Color Card Registry，Business Modeling Core 不得删除、迁移、重命名或静默修改这些资产。

业务模型变化对 UX 的影响只能通过以下资产表达：

```text
MODEL_IMPACT_REPORT.md
downstream-views/ux-design-engineering-view.md
downstream-views/ux-business-model-context.md/yml
Follow-up Trigger 或 Design Engineering Successor 建议
```

不得直接写入：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

---

## 17. Adapter 要求

v0.2.1 提供 Codex、Claude Code、Cursor 三类 Adapter 规则片段。Adapter 必须：

1. 读取项目 `docs/product/` 资产；
2. 识别六种入口模式；
3. 使用 Core 模板写入任务级文件；
4. 不绕过 Human Decision Control Plane；
5. 不将运行时线程等同于 Work Item；
6. 不把数据库字段写回核心模型；
7. 不直接修改既有 UX / Design Engineering 资产。

---

## 18. 人工评测

评测必须覆盖 20 个场景：

1. 新增低影响业务属性；
2. 核心对象身份歧义；
3. 上游计费模式变化；
4. 下游字段不能反推核心属性；
5. 提交 / 完成横向冲突；
6. 项目解析不得自动 confirmed；
7. `schema-view.json` 边界；
8. 动作缺少 actor；
9. 状态转换缺少动作；
10. 下游编译发现核心缺口；
11. provisional 不得伪装 confirmed；
12. sealed 历史不可改写；
13. Trigger 去重；
14. confirmed 冲突必须人类决策；
15. UX Context Pack 是派生视图；
16. UX Context Pack 不包含数据字段；
17. UX 缺口候选创建 downstream_gap；
18. UX 冲突候选创建 cross_cluster_conflict；
19. Context Pack 缺失不阻断 UX 启动；
20. sealed UX Work Item 不被 Context Pack 静默改写。

---

## 19. 实施里程碑

### Milestone 1：Core 骨架

创建 `README`、`AGENTS.md`、`CHANGELOG`、`CAPABILITY.md`、`capability.manifest.yml` 和顶层文档。

### Milestone 2：协议与模板

创建 `protocols/`、`references/`、`assets/` 下的完整协议和模板。

### Milestone 3：项目模板

创建 `templates/project/docs/product/`，覆盖长期业务模型资产、任务级模板、Model Trigger 模板和 downstream views。

### Milestone 4：Adapters

创建 Codex、Claude Code、Cursor 适配片段，保证运行时包装不改变 Core 语义。

### Milestone 5：示例与评测

创建端到端示例和 20 个 Given / When / Then 人工评测。

### Milestone 6：自检

检查 JSON / YAML 解析、路径一致性、Source of Truth 写入权、UX 兼容边界、非目标约束和评测覆盖。

---

## 20. Definition of Done

- [ ] Core / Adapter / Project Assets 分层清楚；
- [ ] 业务模型资产位于 `docs/product/business-modeling/`；
- [ ] 业务模型只使用业务属性，不使用数据字段；
- [ ] `schema-view.json` 保持五项边界；
- [ ] 六种入口模式完整；
- [ ] 14 个子能力工作合同完整；
- [ ] Human Decision Control Plane 完整；
- [ ] Passive Trigger Interface 完整；
- [ ] `model-triggers/MT-xxx.md` 协议完整；
- [ ] `MODEL_IMPACT_REPORT.md` 协议完整；
- [ ] Downstream views 包含 UX Design Engineering 视图和 UX Context Pack；
- [ ] UX Context Pack 是派生视图，不是 source of truth；
- [ ] 既有 UX / Design Engineering 资产只读保护；
- [ ] Codex / Claude Code / Cursor Adapter 片段存在；
- [ ] 项目模板可直接复制到真实仓库；
- [ ] 示例可说明被动触发与影响分析；
- [ ] 20 个评测场景存在；
- [ ] 无 CLI / Hook / Plugin / Installer / 外部依赖；
- [ ] 没有 `model-requests/`；
- [ ] 没有自动数据库迁移或 API 生成。
