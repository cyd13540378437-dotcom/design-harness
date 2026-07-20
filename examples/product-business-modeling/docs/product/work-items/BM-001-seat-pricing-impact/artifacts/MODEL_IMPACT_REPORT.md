---
schema_version: 1
report_type: model_impact_report
work_item: BM-001
trigger_id: MT-001
status: awaiting_human
created_at: 2026-07-17
updated_at: 2026-07-17
---

# Model Impact Report

## 1. Trigger

`MT-001` — Pricing Model Changed to Seat-based.

## 2. Change Summary

计费模型从 Workspace-based 变为 Seat-based，要求业务模型表达席位、成员、邀请和计费约束之间的关系。

## 3. Evidence and Assumptions

### Confirmed Evidence

- BA-002 confirmed：按 Seat 计费。

### Provisional Evidence

- 当前模型中 Member 属于 Workspace，但未表达 Seat。

### Open Assumptions

- Invitation 是否占用 Seat 尚未确认。

## 4. Affected Business Domains

- 组织与成员
- 计费与权限

## 5. Affected Objects

- Workspace
- Member
- Invitation
- BillingAccount
- Seat（候选）

## 6. Affected Business Attributes

- 席位占用状态
- 当前成员
- 邀请占用
- 计费资格

## 7. Affected Relationships

- Workspace 拥有 Seat
- Member 占用 Seat
- Invitation 可能预占 Seat

## 8. Affected Actions

- 邀请成员
- 接受邀请
- 移除成员
- 调整席位数量

## 9. Affected States

- Seat: available / reserved / occupied / released（候选）

## 10. Affected Rules and Permissions

- 无可用 Seat 时不能新增成员；
- Billing Admin 可以调整 Seat 数量；
- 移除成员不得删除历史计费记录。

## 11. Affected Downstream Views

- database-view.md
- backend-view.md
- qa-view.md

## 12. Safe Automatic Updates

- 可新增 provisional 术语候选：Seat。

## 13. Provisional Change Proposals

- 将 Seat 建模为独立业务对象。

## 14. Human Decisions Required

| Decision ID | Question | Impact Level | Options | Recommended |
|---|---|---|---|---|
| BMD-001 | Seat 是否为独立业务对象？ | D2 | A: 独立对象；B: Member 的业务属性 | A |

## 15. Recommended Update Plan

用户确认后，更新字典、对象画像、关系、规则和下游视图。

## 16. Revalidation and Recompilation Plan

更新后运行一致性校验，并重编译 database/backend/QA 视图。

## 17. Follow-up Triggers

如 Invitation 是否预占 Seat 无法决定，创建新的 `internal_discovery` Trigger。

## 18. Resolution Readiness

Not ready. Awaiting BMD-001.
