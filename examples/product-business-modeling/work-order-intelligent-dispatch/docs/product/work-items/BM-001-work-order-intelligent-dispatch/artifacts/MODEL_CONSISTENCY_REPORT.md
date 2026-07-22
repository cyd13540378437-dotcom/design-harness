---
schema_version: 1
report_type: model_consistency_report
work_item: BM-001
status: current
result: passed
created_at: "2026-07-22T00:00:00Z"
updated_at: "2026-07-22T00:00:00Z"
---

# Model Consistency Report

## Scope

BM-001 长期资产、标准 Work Item 文件、两个专业派生视图和唯一用户总览。

## Checks Performed

| Check ID | Contract | Result | Notes |
|---|---|---|---|
| C-01 | Canonical Work Item files and locations | pass | 四个根文件存在；无 legacy 平行输出 |
| C-02 | Frozen `STATE.md` frontmatter fields | pass | Runtime 信息仅位于 `extensions` |
| C-03 | Business dictionary structure and coverage | pass | 结构化领域、分类、对象、属性、动作、状态、角色和禁用词完整 |
| C-04 | `schema-view.json` exact shape and five-question boundary | pass | 仅含对象、领域、分类、属性和示例 |
| C-05 | Index registry completeness | pass | 当前资产、状态、总览和下游视图均登记 |
| C-06 | Object / domain / category / attribute referential integrity | pass | 13 个对象和 86 个属性跨 Dictionary / Schema 一致 |
| C-07 | Relationship endpoints exist | pass | 14 条关系端点均存在 |
| C-08 | Actions have stable ID, actor, target and effects | pass | 18 个动作引用均存在 |
| C-09 | State transitions reference existing action and states | pass | 22 个状态分属三个对象，转换引用有效 Action ID |
| C-10 | One lifecycle belongs to one business object | pass | Work Order、Dispatch Decision、Assignment 分离 |
| C-11 | Rules and permissions bind existing IDs | pass | 规则、角色、动作、对象和状态引用可解析 |
| C-12 | No data-field misuse in Core assets | pass | 核心资产使用业务语言，无数据库字段和技术类型 |
| C-13 | Context-dependent values are not intrinsic attributes | pass | 到达成本属于 Dispatch Candidate 上下文 |
| C-14 | Object identity is singular and unambiguous | pass | `Asset / Facility` 已改为单一 `MaintainableAsset`；资源类型仍以 BMD-002 管理 |
| C-15 | Downstream views are current and do not own Core truth | pass | 软件开发与 UX 视图为 provisional 派生内容 |
| C-16 | `BUSINESS_MODEL_OVERVIEW.md` is current and user-complete | pass | 五个 BMD 均含选项、取舍、推荐和回复格式 |

## Issues Found

| Issue ID | Severity | Check ID | Asset | Description | Recommended Owner | Trigger Needed |
|---|---|---|---|---|---|---|
| MC-001 | warning | C-16 | `DECISION_NOTES.md` | BMD-001 至 BMD-005 仍待用户确认 | Human Decision Control Plane | no |
| MC-002 | warning | C-14 | `service_resource` | 统一资源抽象未来可能需要拆分 | domain-object-profiler | after BMD-002 |

## Human Decisions Required

`BMD-001`–`BMD-005`。这些待决事项保持 provisional，不构成结构错误。

## Follow-up Triggers

用户确认后，再判断是否触发需求表达、系统设计或 UX Work Item。

## Result

- Overall: `passed`
- Blocking errors: 0
- Warnings: 2（覆盖 5 个待确认判断与 1 个演进风险）
- Overview may be described as confirmed complete: `no`; it是当前、完整的 provisional 总览。
