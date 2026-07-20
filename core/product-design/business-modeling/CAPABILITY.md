---
capability_id: product-business-modeling
display_name: 业务模型能力集群
version: v0.2.2-runtime-aware
status: implementation-ready
language: zh-CN
agent_neutral: true
created_at: 2026-07-17
---

# 业务模型能力集群（`product-business-modeling`）CAPABILITY

## 1. 一句话定义

业务模型能力集群负责把业务世界抽象成统一、稳定、可演进的产品语义模型，使商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 可以在同一套业务语言下协作。

它是 DesignHarnessAgent 的 **Agent-neutral Core**，不是 Codex、Cursor、Claude 或任一运行时的专属 Skill。运行时只负责适配；项目里的 `docs/product/business-modeling/` 才是业务模型知识资产的长期 source of truth。

---

## 2. 能力边界

### 2.1 它负责什么

本能力集群负责生产和维护：

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
下游业务模型视图
模型触发响应与影响分析
UX 业务模型上下文包
```

### 2.2 它不负责什么

本能力不是数据库建模器、PRD 生成器、页面流程设计器或代码生成器。

它不得把以下内容写入核心业务模型 source of truth：

```text
数据库字段
表字段
column
后端接口参数
持久化类型
ORM 结构
具体页面布局
实现代码
测试代码
```

这些内容只能出现在 `downstream-views/*` 派生视图中，并且必须标注为从业务语义编译出的实现建议，而非业务事实本身。

---

## 3. 四层架构

```text
DesignHarnessAgent Core
        ↓
Shared Agent Skill Facade
        ↓
Runtime-specific Adapters
        ↓
Project Knowledge Assets
```

### 3.1 Core

Core 定义协议、入口模式、子能力、输出物、模板、评测和不可越界规则。

### 3.2 Shared Agent Skill Facade

Shared Facade 定义可移植的 Agent 工作流入口，标准位置是 `adapters/shared/agent-skill-facade/product-business-modeling/`。它不得重新定义 Core 语义，也不得携带具体运行时专属语法，除非明确标注为 runtime-specific。

### 3.3 Runtime-specific Adapters

Adapters 负责把 shared facade 接入不同 Agent 运行时，例如 Codex、Claude Code、Cursor。Adapter 可以改变调用形式，但不得改变业务语义、文件协议和 Human Decision Control Plane。安装到目标项目前必须先执行 Runtime Adapter Resolution。

### 3.4 Project Knowledge Assets

真实项目中的业务模型知识资产，标准位置为：

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

---

## 4. 硬原则

### 4.1 业务属性不是数据字段

业务模型阶段只有业务属性，没有数据字段。

合法表达：

```text
当前执行人
工单状态
审批意见
执行证据
业务角色
```

非法核心模型表达：

```text
current_executor_id
work_order.status
approval_comment
role_id
```

下游数据库视图可以给出“业务属性 → 可能字段映射”，但该映射不是业务事实。

### 4.2 `schema-view.json` 只回答五个问题

`schema-view.json` 只允许表达：

```text
1. 有哪些业务对象
2. 每个对象属于哪个业务领域
3. 每个对象属于哪种对象分类
4. 每个对象有哪些业务属性
5. 每个业务属性有哪些示例内容
```

它不得包含关系、动作、状态、规则、权限、数据库字段、接口、路线图、风险或下游影响。

### 4.3 证据先于确认

从现有代码、数据库、接口、页面或测试中解析出的业务知识，默认只能是 `draft` 或 `provisional`。实现现状不能自动升级为 confirmed 业务事实。

### 4.4 派生视图不能反向成为权威源

`downstream-views/*` 可以暴露缺口并创建 Model Trigger，但不能直接改写业务字典、对象画像、关系、动作、状态、规则或权限。

### 4.5 高影响语义不可静默覆盖

新的 provisional 资产可以建立；但未确认方案不得静默覆盖既有 confirmed 业务语义。

### 4.6 封存权属于人类

AI 可以建议关闭或封存，但不能自行 `sealed`。sealed 内容只读；后续变化必须通过新 Work Item、Successor 或明确的新决策记录表达。

---

## 5. 知识状态

业务模型知识资产统一使用以下状态：

```text
draft         刚生成，不建议下游正式使用
provisional   可临时消费，但带假设或缺口
confirmed     已确认，可作为稳定输入
superseded    被新版本替代
deprecated    历史保留，不推荐继续使用
sealed        任务或决策已封存，不得静默改写
```

AI 可以自动生成 `draft` 与 `provisional`。高影响语义从 `draft/provisional` 升级到 `confirmed` 前，必须经过 Human Decision Control Plane。

---

## 6. 决策影响等级

```text
D0 = 机械同步，可自动执行
D1 = 可逆局部语义，可自动 provisional
D2 = 核心产品语义，确认或覆盖 confirmed 前必须由人决定
D3 = 治理与终态，必须明确人类决定
```

典型 D2 / D3 场景：

```text
业务对象身份存在互斥判断
对象关系会影响权限、流程或数据库
业务动作会改变核心流程
状态流转存在多个合理方案
规则涉及责任、权限、审计或合规
上游商业分析变化导致模型重构
provisional 判断已经被下游依赖
将 draft/provisional 升级为 confirmed
关闭、封存或废弃重要模型资产
```

---

## 7. 六种入口模式

### 7.1 用户主动建模（`direct_modeling`）

用户明确要求新增对象、补充属性、梳理关系、整理业务字典或建立某部分业务模型。

最小必调模块：

```text
modeling-orchestrator
model-update-router
相关核心生产模块
model-consistency-validator
```

### 7.2 被动触发（`passive_trigger`）

来自上游商业分析变化、下游缺口或横向冲突的触发。

最小必调模块：

```text
model-trigger-handler
modeling-orchestrator
model-update-router
相关核心生产模块
model-consistency-validator
downstream-view-compiler
```

必须生成 `MODEL_IMPACT_REPORT.md`。

### 7.3 当前项目解析（`project_extraction`）

从已有项目、文档、接口、测试、数据库 schema 或 UI 中反推业务模型。

解析结果默认是候选，不得自动 confirmed。必须生成 `SOURCE_EVIDENCE.md` 与 `MODEL_EXTRACTION_REPORT.md`。

### 7.4 从零建模（`greenfield_modeling`）

用户只有模糊想法或早期产品方向时，建立 provisional 初始业务模型。

### 7.5 一致性校验（`consistency_validation`）

检查业务字典、schema-view、对象画像、关系、动作、状态、规则、权限和下游视图之间是否一致。

必须生成 `MODEL_CONSISTENCY_REPORT.md`。

### 7.6 下游视图编译（`downstream_compilation`）

将核心业务模型编译给产品表达、需求表达、数据库、后端、前端、QA 和 UX / Design Engineering。UX 侧至少应获得 `ux-business-model-context.*` 与必要时的 `ux-design-engineering-view.md`。

编译器不得直接修改核心模型；发现缺口时应创建 Model Trigger。

---

## 8. 14 个子能力

| 序号 | 子能力 | 英文 ID | 职责摘要 |
|---|---|---|---|
| 1 | 业务模型总协调器 | `modeling-orchestrator` | 判定入口模式、绑定 Work Item、编排模块、检查决策边界。 |
| 2 | 模型更新分发器 | `model-update-router` | 将变更计划路由给单一写入者模块，避免越权写入。 |
| 3 | 模型触发处理器 | `model-trigger-handler` | 创建、去重、分流、推进和关闭 `MT-xxx.md`。 |
| 4 | 业务字典构建器 | `business-dictionary-builder` | 维护术语、业务属性、动作、状态、角色、领域和分类。 |
| 5 | 业务结构视图生成器 | `schema-view-structurer` | 生成严格边界内的 `schema-view.json` 与 `schema-view.md`。 |
| 6 | 业务对象画像构建器 | `domain-object-profiler` | 维护对象身份、边界、责任、生命周期和属性解释。 |
| 7 | 对象关系建模器 | `relationship-modeler` | 定义业务对象之间的语义关系。 |
| 8 | 业务动作建模器 | `action-command-modeler` | 定义谁能对谁做什么，以及动作前置条件与效果。 |
| 9 | 状态生命周期建模器 | `state-lifecycle-modeler` | 定义对象状态、状态转换和触发动作。 |
| 10 | 规则权限建模器 | `rule-policy-modeler` | 定义业务不变量、约束、权限与审计相关规则。 |
| 11 | 路线图与风险分析器 | `roadmap-risk-modeler` | 识别 MVP 简化、未来演进、业务风险和模型风险。 |
| 12 | 下游视图编译器 | `downstream-view-compiler` | 编译 database/backend/frontend/QA/product/requirements 等派生视图。 |
| 13 | 项目业务模型解析器 | `project-model-extractor` | 从现有项目提取候选业务模型和证据链。 |
| 14 | 模型一致性检查器 | `model-consistency-validator` | 校验模型一致性、发现冲突、生成修复建议或触发。 |

---

## 9. Source of Truth 写入所有权

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
| 下游视图 | `downstream-views/*`，包括 `ux-business-model-context.*` 与 `ux-design-engineering-view.md` | `downstream-view-compiler` |
| Model Trigger | `model-triggers/MT-xxx.md` | `model-trigger-handler` |
| 任务级状态 | `work-items/BM-xxx/STATE.md` | `modeling-orchestrator` / Adapter state wrapper |
| 高影响决策 | `work-items/BM-xxx/DECISION_NOTES.md` | Human Decision Control Plane |

其他模块可以提供候选、报告和建议，但不得跨所有权直接写入。

---

## 10. 被动触发接口

### 10.1 Trigger 类型

```text
upstream_change          上游商业分析变化
downstream_gap           下游缺口或实现视图缺失
cross_cluster_conflict   横向能力集群冲突
internal_discovery       解析或校验时发现的内部缺口
```

### 10.2 Trigger 生命周期

```text
open → triaged → in_progress → awaiting_human → resolved | dismissed | superseded
```

### 10.3 处理规则

- 每个 Trigger 必须有稳定 `trigger_id` 和 `dedupe_key`。
- 被动触发必须生成或关联一个 BM Work Item。
- 高影响变更必须生成 `MODEL_IMPACT_REPORT.md`。
- Trigger 只有在影响分析、模型响应、必要决策、校验、下游重编译和回写完成后才能 `resolved`。

---

## 11. 人类决策控制层

Human Decision Control Plane 是横切机制，不是普通子能力。它负责在所有模块写入或升级知识状态前判断是否需要人类确认。

### 11.1 决策请求格式

```markdown
## 需要你确认的产品判断

### 当前理解

我目前理解为：……

### 为什么重要

这个判断会影响：业务对象定义、对象关系、状态流转、权限规则、数据库视图、UX 表达和 QA 验收。

### 可选方案

#### 方案 A：……

优点：……
代价：……

#### 方案 B：……

优点：……
代价：……

### 推荐

推荐方案 B。原因：……

### 需要确认

请确认：选 A / 选 B / 我补充一个规则
```

### 11.2 决策记录

所有 D2 / D3 决策必须写入 `DECISION_NOTES.md`，建议使用稳定 ID：

```text
BMD-001
BMD-002
...
```

---

## 12. 任务级文件

每个业务模型 Work Item 推荐结构：

```text
docs/product/work-items/BM-xxx-<slug>/
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

### 12.1 `STATE.md`

记录当前任务身份、入口模式、状态、阶段、决策等待、关联 Trigger、产物链接和下一步。

### 12.2 `MODELING_CONSUMPTION.md`

记录本次建模消费了哪些 confirmed / provisional 来源、假设、缺口和明确非范围。

### 12.3 `MODELING_OUTPUT.md`

记录本次建模创建或更新了哪些资产、哪些只是 provisional、哪些被 superseded/deprecated、哪些 Trigger 已关闭或继续派发。

### 12.4 `DECISION_NOTES.md`

记录高影响决策、备选方案、推荐理由、人类决定、影响和后续更新。

### 12.5 `SOURCE_EVIDENCE.md`

记录项目解析、上游文档、下游缺口或用户说明的证据来源。

---

## 13. 项目资产结构

```text
product-repository/
├── AGENTS.md
├── docs/
│   └── product/
│       ├── PRODUCT_WORK_ITEMS.md
│       ├── model-triggers/
│       ├── business-modeling/
│       │   ├── BUSINESS_MODEL_INDEX.md
│       │   ├── BUSINESS_MODEL_INDEX.yml
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
├── .codex/
├── .cursor/
└── CLAUDE.md
```

---

## 14. Adapter 合同

Adapter 可以改变提示词格式、工具调用方式或本地规则文件位置，但必须遵守：

1. 不改变 Core 的入口模式、状态枚举和文件协议；
2. 不把运行时会话当作 Work Item 身份；
3. 不绕过 Human Decision Control Plane；
4. 不把下游视图当成核心模型 source of truth；
5. 不把数据库字段写回核心业务模型；
6. 不自动 sealed；
7. 不在 AMBIGUOUS 时自行选择。

---

## 14A. 与 UX / Design Engineering Harness 的兼容性

Business Modeling Core 可能影响 UX，但不得接管已经完成的 Design Engineering Harness。

如果目标项目中存在 `docs/design/`，业务模型能力必须把它视为另一个能力集群的资产：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

业务模型变化对 UX 的影响必须通过以下方式表达：

```text
MODEL_IMPACT_REPORT.md
docs/product/business-modeling/downstream-views/ux-design-engineering-view.md
Follow-up Trigger 或 Design Engineering Successor 建议
```

业务模型能力不得直接修改 sealed 的 DE Work Item，不得把 `REFERENCE_SELECTION.md` 或 Reference Library 当作业务模型资产，也不得因业务对象变化而静默修改 Color Card Registry。详细规则见 `protocols/ux-design-engineering-compatibility.md`。

---

## 14B. UX 业务模型上下文包

Business Modeling Core 必须支持面向 UX / Design Engineering 的轻量下游上下文包：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

它与 `ux-design-engineering-view.md` 的区别是：

```text
ux-business-model-context.* = UX 启动和设计过程中的轻量业务语义输入
ux-design-engineering-view.md = 某次业务模型变化后对 UX 的影响分析和后续建议
```

Context Pack 是派生视图，不是 source of truth。UX 启动时如果该包存在应读取；如果缺失或不完整，不阻断 UX 启动。UX 侧只提示两类候选信号：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

UX 不负责 confirmed 业务模型。涉及业务对象、动作、状态、规则、权限、责任、审计或核心流程的缺口 / 冲突，应通过 `docs/product/model-triggers/MT-xxx.md` 反馈给 Business Modeling Core。

未解决的高影响缺口或 confirmed 业务冲突，不得被 UX sealed 为 confirmed 产品行为。

详细规则见 `protocols/ux-business-model-context-pack.md`。

---

## 15. 人工评测合同

本能力集群至少必须通过以下 20 个场景：

```text
01 新增低影响业务属性
02 核心对象身份歧义
03 上游计费模式变化
04 下游字段不能反推为核心属性
05 横向“提交 / 完成”冲突
06 项目解析不得自动 confirmed
07 schema-view 边界
08 动作缺少 actor
09 状态转换缺少动作
10 下游编译发现模型缺口
11 provisional 不能伪装 confirmed
12 sealed 历史不可改写
13 Trigger 去重
14 confirmed 冲突必须人类处理
15 Context Pack 是派生视图
16 Context Pack 不包含数据字段
17 UX 缺口候选创建 downstream_gap
18 UX 冲突候选创建 cross_cluster_conflict
19 Context Pack 缺失不阻断 UX 启动
20 sealed UX Work Item 不被 Context Pack 静默改写
```

---

## 16. Definition of Done

### 架构与边界

- [ ] Core / Adapter / Project Assets 分层明确；
- [ ] 能力是 Agent-neutral，不依赖 Codex 私有机制；
- [ ] 核心模型不出现数据库字段语义；
- [ ] `schema-view.json` 严格保持五项边界。

### 协议与模板

- [ ] `MT-xxx.md`、`MODEL_IMPACT_REPORT.md`、`DECISION_NOTES.md` 模板齐全；
- [ ] 任务级文件齐全；
- [ ] Source of Truth 写入所有权明确；
- [ ] 下游视图是派生视图，不是权威源；
- [ ] `ux-design-engineering-view.md` 说明业务模型对 UX 的影响但不写入 `docs/design/`；
- [ ] `ux-business-model-context.md/yml` 作为 UX 轻量上下文包存在，并明确不是 source of truth。

### Human Decision Control Plane

- [ ] D0-D3 分级可执行；
- [ ] D2 / D3 不会被自动 confirmed；
- [ ] AI 不会自动 sealed；
- [ ] confirmed 被覆盖前必须有明确人类决策。

### Passive Trigger Interface

- [ ] `model-triggers/` 取代 `model-requests/`；
- [ ] Trigger 类型、生命周期、去重和关闭规则明确；
- [ ] 被动触发会生成影响分析；
- [ ] 影响分析会驱动模型更新、校验、重编译和回写。

### 评测

- [ ] 20 个评测场景均可人工执行；
- [ ] 每个场景包含 Given / When / Then；
- [ ] 评测覆盖边界、决策、触发、下游编译、UX 兼容性与 sealed 行为。


---

## 17. UX Business Model Context Pack

Business Modeling Core 必须提供面向 UX / Design Engineering 的轻量业务模型上下文包：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

该包是 `downstream-view-compiler` 生成的派生视图，不是 source of truth。它用于让 UX 在 Work Item 启动、关键交互设计和完成封存前低成本读取业务语义。

该包只暴露 UX 必要的内容：

```text
业务对象摘要
UX 相关业务动作
UX 相关状态
UX 相关规则与权限
影响 UX 的 open Model Trigger
UX 何时应创建 downstream_gap 或 cross_cluster_conflict
UX 何时不应创建 Model Trigger
```

UX 侧只负责提示两类候选问题：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

本能力不引入复杂语义差异分层；纯视觉、布局、Reference Library、Color Card、局部 UI 控制和不改变业务结果理解的文案调整，不触发业务模型。

`ux-business-model-context.*` 与 `ux-design-engineering-view.md` 的区别：

```text
ux-business-model-context.* = UX 启动与设计过程中的轻量语义输入
ux-design-engineering-view.md = 业务模型变化后对 UX 的影响分析视图
```

未解决的高影响业务模型缺口或 confirmed 冲突不得被 UX sealed 为 confirmed 产品行为。

---

## 18. Agent Runtime Adapter Resolution

Business Modeling remains an Agent-neutral Core, but every runtime must have a callable adapter. A package is not implementation-ready if it has Core documents but no runnable agent entry for the user’s current tool.

Required pattern:

```text
Product Business Modeling Core
        ↓
Shared Agent Skill Facade
        ↓
Runtime-specific Adapter
        ↓
Project Knowledge Assets
```

Runtime resolution is defined in:

```text
core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md
adapters/adapter-registry.yml
```

Supported profiles:

```text
codex
claude-code
cursor
generic-agent
multi-runtime
```

Hard rules:

- Core defines capability semantics.
- Shared Facade defines portable workflow language.
- Runtime adapters map the facade into the current tool.
- Project knowledge assets remain under `docs/product/**`.
- Ambiguous runtime detection requires user confirmation or explicit multi-runtime installation.
- Runtime adapters must not redefine business model semantics.
- No CLI, Hook, Plugin, Installer, or external runtime dependency is introduced in v0.2.2.
