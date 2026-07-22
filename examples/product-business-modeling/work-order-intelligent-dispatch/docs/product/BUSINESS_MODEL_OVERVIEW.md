---
schema_version: 1
view_type: business_model_overview
audience: product_owner
is_default_user_entry: true
is_source_of_truth: false
source_model_version: "v0.1-provisional"
source_model_status: provisional
validation_status: passed
generated_at: "2026-07-22T00:00:00Z"
generated_by: downstream-view-compiler
source_work_item: "BM-001"
source_assets:
  - docs/product/business-modeling/BUSINESS_MODEL_INDEX.yml
  - docs/product/business-modeling/business-dictionary.yml
  - docs/product/business-modeling/schema-view.json
  - docs/product/work-items/BM-001-work-order-intelligent-dispatch/DECISION_NOTES.md
  - docs/product/work-items/BM-001-work-order-intelligent-dispatch/artifacts/MODEL_CONSISTENCY_REPORT.md
---

# 设备设施工单智能调度业务模型总览

> **先看这里。** 这是当前模型面向用户的默认阅读入口。详细业务模型仍保存在 `business-modeling/` 下；本文件不会替代那些 source of truth。

## 一句话模型

产品围绕工单要求、可维护资产与位置上下文、资源能力与可用性生成可解释的派工候选，由策略排序并经人工确认形成派工决策，再生成可执行的 Assignment；执行结果和决策快照用于持续验证调度策略。

## 当前状态与下一步

| 项目 | 当前值 |
|---|---|
| 模型版本 | `v0.1-provisional` |
| 知识状态 | `provisional` |
| 一致性状态 | `passed`：结构合同通过，5 个 D2 决策仍待确认 |
| 当前 Work Item | `BM-001` |
| 当前需要用户处理 | 确认产品边界、资源身份、自动派单权限、目标优先级和最小可观测性 |

## 产品边界

### 包含

- 工程维修、保养、巡检后续处理和应急故障类工单；
- 工单要求、资源能力与可用性、候选生成、策略排序、人工确认、执行责任和反馈；
- 调度决策现场与执行结果的可回放证据。

### 不包含

- 数据库字段、API、ORM 或算法实现；
- 已证明有效的“最优策略”结论；
- UI 视觉设计；
- 未经确认的全自动派单责任。

## 核心业务闭环

```text
Work Order
→ Work Requirement
→ Service Resource + Capability + Resource Availability
→ Dispatch Candidate
→ Dispatch Decision
→ Assignment
→ Execution Record
→ Dispatch Evaluation Snapshot
```

关键区别：`Dispatch Decision` 表达“选择了什么以及为什么”；`Assignment` 只在决策提交后成立，表达“谁已经承担什么执行责任”。两者拥有独立生命周期。

## 核心业务对象

| Object ID | 业务名称 | 核心责任 | 状态 |
|---|---|---|---|
| `work_order` | 工单 | 承载服务需求、承诺和当前阶段 | provisional |
| `maintainable_asset` | 可维护资产 | 表达被服务的设备、系统或设施构件 | provisional |
| `service_location` | 服务位置 | 表达区域、责任和通行上下文 | provisional |
| `work_requirement` | 工单要求 | 把工单转成能力、资质、安全和时间约束 | provisional |
| `service_resource` | 服务资源 | 表达可承担责任的资源抽象 | provisional |
| `capability` | 能力 | 表达资源胜任某类服务的条件与等级 | provisional |
| `resource_availability` | 资源可用性 | 表达时段与可承诺容量 | provisional |
| `dispatch_policy` | 调度策略 | 表达硬约束、排序偏好和业务护栏 | provisional |
| `dispatch_candidate` | 派工候选 | 组合工单、资源、开始窗口和上下文评估 | provisional |
| `dispatch_decision` | 派工决策 | 表达推荐、确认、覆盖、提交和理由 | provisional |
| `assignment` | 派工责任 | 表达决策提交后形成的执行责任 | provisional |
| `execution_record` | 执行记录 | 记录实际开始、结果、异常和质量反馈 | provisional |
| `dispatch_evaluation_snapshot` | 调度评估快照 | 回放候选、排序、选择和执行结果 | provisional |

完整对象和业务属性见 [`schema-view.md`](./business-modeling/schema-view.md)。

## 关键业务规则、权限与不变量

- 硬性技能、资质、安全、可用性条件不满足时，不得进入可推荐候选；
- SLA 和安全是护栏，不只是低权重评分项；
- 人工覆盖必须记录业务原因；
- 已提交决策不得被直接改写，重派应形成新的决策与 Assignment；
- 系统第一阶段可以推荐，但不能自动提交派工决策；
- “预计到达成本”依赖资源起点、服务位置、时间窗口和通行条件，因此属于 `DispatchCandidate` 上下文，不是 `ServiceLocation` 固有属性；
- 决策快照必须保留候选、排序、最终选择和执行结果。

## 第一阶段产品与开发能力

1. 可调度工单池与要求确认；
2. 资源能力、覆盖区域和可用性；
3. 候选生成、硬约束排除原因与预计到达成本；
4. 推荐排序、人工确认和覆盖；
5. 独立的 Dispatch Decision / Assignment 生命周期；
6. 执行反馈、暂停、重派与关闭；
7. 调度评估快照与基础策略复盘。

## 已确认决定

- 当前模型必须保持 `provisional`，不得把冷启动策略效果写成已验证事实。

## 已完成的协议性修正（不等于业务语义已 confirmed）

- 旧的复合对象 `Asset / Facility` 已收敛为 provisional `MaintainableAsset`，空间上下文由 `ServiceLocation` 表达；
- 到达成本已从位置固有属性迁移到 `DispatchCandidate` 上下文评估；
- Dispatch Decision 与 Assignment 生命周期已经分离。

## Provisional 假设

- 第一版聚焦设备设施工程类工单；
- `ServiceResource` 暂时覆盖个人、班组、值班岗位和外包资源；
- 第一版采用“系统建议 + 人工确认”；
- SLA / 安全优先，在护栏内优化利用率、到达成本和负载均衡；
- 决策快照进入第一期核心范围。

## 需要用户确认

> 下面五项可以直接在本文件中决定。完整审计记录仍保留在 `DECISION_NOTES.md`。

### BMD-001 — 第一版产品行业边界

- **当前理解**：第一版主要服务工程维修、保养、巡检后续处理和应急故障。
- **为什么重要**：边界会改变工单类型、资源能力、SLA、权限和策略复杂度。
- **方案 A：聚焦工程类工单**
  - 优点：对象和流程清晰，第一期可控。
  - 代价：保洁、安保、能耗和工程改造需要后续扩展。
- **方案 B：覆盖全部设施服务任务**
  - 优点：定位更广。
  - 代价：资源、规则和状态差异显著，第一期复杂度高。
- **推荐**：方案 A。
- **请回复**：`BMD-001 选 A / 选 B / 我补充一个边界`

### BMD-002 — Service Resource 是否保持统一抽象

- **当前理解**：资源可能是个人、班组、值班岗位或外包单位。
- **为什么重要**：这些类型的责任、接受动作、权限和容量模型并不完全相同。
- **方案 A：第一期统一 ServiceResource**
  - 优点：开发更快，可先支持多种资源。
  - 代价：需要额外约束个人责任与组织资源的差异。
- **方案 B：立即拆分 Person / Team / Shift Position / Vendor**
  - 优点：语义更精确。
  - 代价：第一期模型和实现复杂度明显增加。
- **推荐**：方案 A，并把拆分条件写入 Roadmap。
- **请回复**：`BMD-002 选 A / 选 B / 我补充一种资源边界`

### BMD-003 — 自动派单权限

- **当前理解**：系统可以推荐，但责任提交由调度员确认。
- **为什么重要**：自动提交涉及责任、审计、错误恢复和客户治理，是 D3 决策。
- **方案 A：建议 + 人工确认**
  - 优点：责任清楚、风险较低。
  - 代价：自动化程度有限。
- **方案 B：满足护栏后自动提交**
  - 优点：响应更快。
  - 代价：需要更强权限、审计、回滚与异常治理。
- **推荐**：第一期方案 A。
- **请回复**：`BMD-003 选 A / 选 B / 我补充自动化护栏`

### BMD-004 — 调度目标优先级

- **当前理解**：SLA、安全和紧急程度作为护栏；在护栏内优化能力匹配、预计到达成本、利用率和负载均衡。
- **为什么重要**：目标顺序决定候选过滤、排序解释和策略评估标准。
- **方案 A：SLA / 安全护栏 + 多目标优化**
  - 优点：更符合服务责任。
  - 代价：策略解释和评估更复杂。
- **方案 B：利用率 / 成本单目标优先**
  - 优点：容易实现与解释。
  - 代价：可能伤害 SLA、加班控制和应急缓冲。
- **推荐**：方案 A。
- **请回复**：`BMD-004 选 A / 选 B / 我补充目标顺序`

### BMD-005 — 最小调度可观测性是否进入第一期

- **当前理解**：没有候选、排序、选择、覆盖和执行结果，就无法验证智能调度是否有效。
- **为什么重要**：这些内容是未来策略评估、解释与人工覆盖学习的证据基础。
- **方案 A：第一期纳入完整决策快照**
  - 优点：从第一天积累可评估证据。
  - 代价：增加产品、存储和 QA 范围。
- **方案 B：先只保存最终派单**
  - 优点：实现较轻。
  - 代价：无法解释未选择候选，也无法可靠验证策略。
- **推荐**：方案 A。
- **请回复**：`BMD-005 选 A / 选 B / 我补充最小证据范围`

## 主要风险与一致性结果

- 一致性报告：[`MODEL_CONSISTENCY_REPORT.md`](./work-items/BM-001-work-order-intelligent-dispatch/artifacts/MODEL_CONSISTENCY_REPORT.md)
- Blocking issues：0
- Consistency warnings：0；Open Human Decisions：5；`ServiceResource` 未来可能需要拆分。
- 当前模型可以指导第一期需求和架构探索，但不能作为已确认的自动派单责任合同。

## 按需深入阅读

| 想了解什么 | 详细文件 |
|---|---|
| 模型资产导航 | [`BUSINESS_MODEL_INDEX.md`](./business-modeling/BUSINESS_MODEL_INDEX.md) |
| 业务术语与对象 | [`business-dictionary.md`](./business-modeling/business-dictionary.md) |
| 对象与业务属性 | [`schema-view.md`](./business-modeling/schema-view.md) |
| 动作与生命周期 | [`actions/`](./business-modeling/actions/) / [`states/`](./business-modeling/states/) |
| 开发视图 | [`software-development-view.md`](./business-modeling/downstream-views/software-development-view.md) |
