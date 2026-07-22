---
schema_version: 1
document_type: business_modeling_decisions
work_item: BM-001
updated_at: "2026-07-22T00:00:00Z"
---

# Business Modeling Decision Notes

## BMD-001 — Seat 是否为独立业务对象

- **Status**: `pending`
- **Impact level**: `D2`
- **Affected assets**: business dictionary, object profiles, relationships, actions, states, rules, permissions and downstream views
- **Related triggers**: `MT-001`

### 当前理解

按席位计费后，席位需要被调整、预留、占用、释放和审计；当前 provisional 模型将 Seat 视为独立业务对象。

### 为什么这个问题重要

它决定 Seat 是否拥有自己的身份与生命周期，并影响成员、邀请、计费责任、权限、产品流程和 QA 验收。

### 可选方案

#### 方案 A：Seat 作为独立业务对象

- 优点：清楚表达资格、状态、责任、预留、占用和历史；未来演进更稳定。
- 代价：一期模型和产品能力稍复杂，需要维护 Seat 与 Member / Invitation 的关系。

#### 方案 B：Seat 只作为成员数量属性

- 优点：一期简单，适合只有容量上限与当前人数的极简业务。
- 代价：邀请预占、释放、非成员资格和审计难以表达，未来可能结构性重构。

### Agent 推荐

推荐方案 A。按席位计费已经赋予 Seat 独立业务责任和状态变化。

### 需要用户确认

请回复：`选 A / 选 B / 我补充一个规则`

### Human Decision

- Decision: pending
- Decided by:
- Decided at:

### Decision Rationale

Pending.

### Consequences

选择 A 后，Seat 从 provisional 升级为 confirmed，并继续确认 Invitation 的预留规则；选择 B 时，需移除独立生命周期并明确容量属性的边界。

### Rejected Alternatives

Pending.

### Follow-up Updates

Pending human decision.

### Overview Compilation

- Included in `docs/product/BUSINESS_MODEL_OVERVIEW.md`: `yes`
