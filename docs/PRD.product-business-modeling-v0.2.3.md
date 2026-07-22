# DesignHarnessAgent — Product Business Modeling PRD v0.2.3

- **能力**：`product-business-modeling`
- **版本**：v0.2.3
- **状态**：implementation-ready
- **基线**：v0.2.2 runtime-aware
- **日期**：2026-07-22

## 1. 产品摘要

v0.2.3 在 Agent-neutral Core、Runtime Adapter Resolution、Human Decision Control Plane、Passive Trigger 和 UX Context Pack 基础上，增加一个统一用户消费层，并把真实 Greenfield 实验暴露的协议漂移变成强制校验。

```text
Core Source of Truth
→ Consistency Validation
→ BUSINESS_MODEL_OVERVIEW.md
→ Professional Downstream Views
```

用户默认只看总览；模型维护者和 Agent 继续使用详细文件。

## 2. 问题

当前业务模型运行可以产出较完整的对象、关系、动作、状态、规则和下游视图，但存在：

- 文件分散且缺少唯一入口；
- 标准 Work Item 文件被自定义文件替代；
- Runtime State 字段与 Core 不一致；
- Schema 结构近似但不规范；
- Dictionary / Index 机器结构不足；
- 决策请求缺少选项与推荐；
- Action / State 缺少 stable references；
- 不同对象生命周期混用；
- 上下文值误放；
- 写入后没有强制一致性收口。

## 3. 目标

1. 用户只需阅读一份总览；
2. 详细文件不合并、不删除，继续按原定义维护；
3. Core、Adapters、Stewards 和模板使用相同协议；
4. 所有写入型建模任务形成“写入 → 校验 → 总览 → 下游”闭环；
5. 示例和评测可证明这些合同。

## 4. 非目标

不新增 CLI、Hook、Plugin、Installer、脚本依赖、数据库迁移、API 生成、云端服务、图形控制台、多用户并发锁或自动代码生成。

## 5. 默认用户总览

路径：

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

属性：

```yaml
view_type: business_model_overview
audience: product_owner
is_default_user_entry: true
is_source_of_truth: false
```

必含：一句话模型、当前状态、边界、核心对象、端到端流程、规则与权限、一期能力、confirmed/provisional/decision、风险、最近更新。

待确认 D2 / D3 决策必须在总览中提供完整压缩，使用户无需打开 `DECISION_NOTES.md` 即可回复。

## 6. Canonical Work Item

```text
STATE.md
MODELING_CONSUMPTION.md
MODELING_OUTPUT.md
DECISION_NOTES.md
artifacts/SOURCE_EVIDENCE.md
artifacts/MODEL_EXTRACTION_REPORT.md
artifacts/MODEL_CONSISTENCY_REPORT.md
artifacts/MODEL_IMPACT_REPORT.md
```

附加产物不得替代以上文件。

## 7. Frozen State Schema

固定字段：

```text
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

Runtime Adapter 不得使用替代字段作为权威 Schema。

## 8. 结构化模型协议

### Dictionary

完整注册领域、分类、对象、属性、动作、状态、角色和禁用术语。

### Schema View

唯一结构，且只含对象、领域、分类、属性和示例内容。

### Index

登记模型中的领域、对象、关系、动作、状态、规则、权限、下游视图和 open triggers，并声明默认用户视图。

### Stable References

Action 有 actor / target / effects；Transition 引用 Action ID；Rule / Permission 绑定已存在 ID。

## 9. 语义边界

- 一个 object ID 只代表一个身份；
- 一个 lifecycle 只属于一个 object；
- 跨对象创建显式表达；
- 上下文相关值不得成为单一对象固有属性；
- 业务属性不等于数据字段。

## 10. Human Decision

- 使用 `BMD-xxx`；
- 先给理解、重要性、方案、代价、推荐，再询问；
- 完整记录进入 `DECISION_NOTES.md`；
- 用户可决策版本进入总览；
- D2 / D3 未确认前不得覆盖 confirmed。

## 11. 强制完成流程

```text
Bind Work Item
→ Consumption
→ Reports / Proposal
→ Human Decision
→ Core Write
→ Consistency Report
→ Business Model Overview
→ Other Downstream Views
→ Modeling Output
→ State Update
→ User receives overview
```

## 12. Runtime Adapter

Codex、Claude Code、Cursor、Generic 和 Multi-runtime Adapter 都必须遵守相同文件、State、校验和用户交付合同。

## 13. Definition of Done

- [ ] 总览存在且是唯一默认用户入口；
- [ ] 用户仅读总览可理解模型和作出待确认决定；
- [ ] 详细资产继续保留；
- [ ] Canonical Work Item 文件完整；
- [ ] State Schema 跨运行时一致；
- [ ] Dictionary / Index / Schema 一致；
- [ ] Action / State / Rule 引用完整；
- [ ] 生命周期不跨对象混用；
- [ ] 上下文属性和对象身份检查有效；
- [ ] Core 写入后强制校验和总览编译；
- [ ] 用户交付只突出总览；
- [ ] 旧版本评测继续通过；
- [ ] 无新增非目标能力。
