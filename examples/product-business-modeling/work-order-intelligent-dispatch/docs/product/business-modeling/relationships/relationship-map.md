# Core Relationship Map

> Relationship endpoints use stable object IDs. Context-dependent values remain on a relation, candidate, decision evidence or derived view—not on an unrelated intrinsic object.

## Relationship Catalog

| Relationship ID | Source Object ID | Relationship Label | Target Object ID | Meaning | Context-dependent Attributes | Status |
|---|---|---|---|---|---|---|
| `REL-001` | `work_order` | references | `maintainable_asset` | 工单说明本次服务的可维护对象。 | — | provisional |
| `REL-002` | `work_order` | occurs_at | `service_location` | 工单发生在一个服务位置。 | — | provisional |
| `REL-003` | `work_order` | is_clarified_into | `work_requirement` | 工单被整理为可调度要求。 | 要求来源与确认时间 | provisional |
| `REL-004` | `work_requirement` | requires | `capability` | 要求需要某些能力或资质。 | 最低等级、有效期要求 | provisional |
| `REL-005` | `service_resource` | has | `capability` | 资源具备可服务能力。 | 当前有效性、等级 | provisional |
| `REL-006` | `service_resource` | has | `resource_availability` | 资源在时段内具有可承诺容量。 | 可用窗口、已有承诺 | provisional |
| `REL-007` | `service_resource` | covers | `service_location` | 资源对某些区域负责或更适合服务。 | 覆盖优先级、通行条件 | provisional |
| `REL-008` | `dispatch_policy` | evaluates | `dispatch_candidate` | 策略过滤并排序候选方案。 | 策略版本、评估时点 | provisional |
| `REL-009` | `dispatch_candidate` | combines | `work_order` | 候选包含被调度工单。 | 候选开始窗口 | provisional |
| `REL-010` | `dispatch_candidate` | proposes | `service_resource` | 候选提出资源和开始窗口。 | 预计到达成本、匹配理由、风险 | provisional |
| `REL-011` | `dispatch_decision` | selects | `dispatch_candidate` | 决策选择一个候选方案。 | 选择理由、覆盖原因 | provisional |
| `REL-012` | `dispatch_decision` | creates | `assignment` | 已提交决策创建执行责任。 | 提交时间、责任版本 | provisional |
| `REL-013` | `assignment` | produces | `execution_record` | 责任执行产生事实记录。 | 实际开始、结果与异常 | provisional |
| `REL-014` | `dispatch_evaluation_snapshot` | captures | `dispatch_decision` | 快照保存决策现场和后续结果。 | 候选集、排序、执行反馈 | provisional |

## Context-dependent Values

`estimated_arrival_cost` 依赖候选资源、服务位置、评估时点、起点和通行条件，归属于 `dispatch_candidate` 的评估上下文；它不是 `service_location` 的固有属性。

## Human Decisions Required

- `BMD-002`：统一 `service_resource` 是否足以承载个人、班组、岗位与外包资源。
