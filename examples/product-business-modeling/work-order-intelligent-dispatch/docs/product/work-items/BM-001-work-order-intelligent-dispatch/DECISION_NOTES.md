---
schema_version: 1
document_type: business_modeling_decisions
work_item: BM-001
updated_at: "2026-07-22T00:00:00Z"
---

# Business Modeling Decision Notes

> Full audit record. The user-facing compression of every pending decision is also present in `../../BUSINESS_MODEL_OVERVIEW.md`.

## BMD-001 — 第一版产品行业边界

- **Status**: `pending`
- **Impact level**: `D2`
- **Affected assets**: work order types, Maintainable Asset, Service Resource, rules and downstream views
- **Related triggers**: none

### 当前理解

第一版主要服务设备设施工程维修、保养、巡检后续处理和应急故障。

### 为什么这个问题重要

边界决定工单类型、资源能力、SLA、权限和策略是否需要覆盖保洁、安保、能耗与工程改造。

### 可选方案

#### 方案 A：聚焦工程类工单

- 优点：对象与流程清晰，第一期可控。
- 代价：其他设施服务需要后续扩展。

#### 方案 B：覆盖全部设施服务任务

- 优点：产品定位更广。
- 代价：资源、规则和状态差异显著，第一期复杂度高。

### Agent 推荐

方案 A。

### 需要用户确认

请回复：`BMD-001 选 A / 选 B / 我补充一个边界`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Consequences

确认后决定对象和规则是否可升级为 confirmed。

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`

## BMD-002 — Service Resource 是否保持统一抽象

- **Status**: `pending`
- **Impact level**: `D2`
- **Affected assets**: service_resource, assignment, permissions and downstream views
- **Related triggers**: none

### 当前理解

资源可能是个人、班组、值班岗位或外包单位。

### 为什么这个问题重要

不同资源类型的责任、接受动作、权限和容量模型不同。

### 可选方案

#### 方案 A：第一期统一 ServiceResource

- 优点：开发快，可支持多种资源。
- 代价：需要额外约束责任人与组织资源的差异。

#### 方案 B：立即拆分 Person / Team / Shift Position / Vendor

- 优点：语义精确。
- 代价：第一期模型和实现复杂度明显增加。

### Agent 推荐

方案 A，同时把拆分列入 Roadmap。

### 需要用户确认

请回复：`BMD-002 选 A / 选 B / 我补充一种资源边界`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Consequences

影响 Assignment、权限与前后端对象边界。

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`

## BMD-003 — 自动派单权限

- **Status**: `pending`
- **Impact level**: `D3`
- **Affected assets**: dispatch_decision, ACT-007, permission policy and audit rules
- **Related triggers**: none

### 当前理解

系统可生成推荐，但责任提交应由调度员确认。

### 为什么这个问题重要

自动提交涉及责任、审计、错误恢复和客户治理。

### 可选方案

#### 方案 A：建议 + 人工确认

- 优点：责任清晰、风险较低。
- 代价：自动化程度有限。

#### 方案 B：满足护栏后自动提交

- 优点：响应更快。
- 代价：需要更强权限、审计、回滚和异常治理。

### Agent 推荐

第一期方案 A。

### 需要用户确认

请回复：`BMD-003 选 A / 选 B / 我补充自动化护栏`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Consequences

决定 `PP-005` 是否继续禁止系统执行 `ACT-007`。

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`

## BMD-004 — 调度目标优先级

- **Status**: `pending`
- **Impact level**: `D2`
- **Affected assets**: dispatch_policy, business rules, evaluation snapshot and QA view
- **Related triggers**: none

### 当前理解

SLA、安全和紧急程度是护栏，在护栏内优化能力匹配、预计到达成本、利用率和负载均衡。

### 为什么这个问题重要

目标顺序决定候选过滤、排序解释和评估指标。

### 可选方案

#### 方案 A：SLA / 安全护栏 + 多目标优化

- 优点：更符合服务责任。
- 代价：策略解释和评估更复杂。

#### 方案 B：利用率 / 成本单目标优先

- 优点：容易实现与解释。
- 代价：可能伤害 SLA、加班和应急缓冲。

### Agent 推荐

方案 A。

### 需要用户确认

请回复：`BMD-004 选 A / 选 B / 我补充目标顺序`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Consequences

决定策略与 QA 的正式验收标准。

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`

## BMD-005 — 最小调度可观测性是否进入第一期

- **Status**: `pending`
- **Impact level**: `D2`
- **Affected assets**: dispatch_evaluation_snapshot, first-delivery scope and QA view
- **Related triggers**: none

### 当前理解

没有候选、排序、选择、覆盖和执行结果，就无法验证智能调度是否有效。

### 为什么这个问题重要

这是未来策略评估和人工覆盖学习的证据基础。

### 可选方案

#### 方案 A：第一期纳入完整决策快照

- 优点：从第一天积累可评估证据。
- 代价：增加存储、产品和 QA 范围。

#### 方案 B：先只保存最终派单

- 优点：实现更轻。
- 代价：无法解释未选择候选，也无法可靠验证策略。

### Agent 推荐

方案 A。

### 需要用户确认

请回复：`BMD-005 选 A / 选 B / 我补充最小证据范围`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Consequences

决定第一期是否具备可回放和策略评估闭环。

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`
