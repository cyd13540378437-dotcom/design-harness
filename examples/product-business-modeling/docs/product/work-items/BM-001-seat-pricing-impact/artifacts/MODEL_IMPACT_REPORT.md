---
schema_version: 1
report_type: model_impact_report
work_item: BM-001
trigger_id: MT-001
status: awaiting_human
created_at: "2026-07-17T00:00:00Z"
updated_at: "2026-07-22T00:00:00Z"
---

# Model Impact Report

## Trigger

`MT-001` — Pricing Model Changed to Seat-based.

## Change Summary

计费模型从按工作区变为按席位，需要显式表达席位资格、容量、占用、释放和审计责任。

## Affected Business Domains

- 组织与成员；
- 计费治理。

## Affected Objects

- Workspace、Member、Invitation、BillingAccount；
- Seat（provisional candidate）。

## Affected Relationships

- Workspace 由 BillingAccount 承担计费责任；
- Workspace 获得 Seat 容量；
- Member 占用 Seat；
- Invitation 可能预留 Seat。

## Affected Actions and States

- 调整席位容量、接受邀请、占用席位、释放席位；
- Seat available / reserved / occupied / released。

## Affected Rules and Permissions

- 成员建立前需要可用资格；
- 只有计费管理员可以调整容量；
- 移除成员保留历史责任。

## Safe Automatic Updates

- 可以将 Seat 候选术语和影响范围记录为 provisional；
- 可以编译带明确未决状态的用户总览。

## Human Decisions Required

| Decision ID | Question | Impact Level | Options | Recommended |
|---|---|---|---|---|
| BMD-001 | Seat 是否为独立业务对象？ | D2 | A: 独立对象；B: 容量属性 | A |

## Recommended Update Plan

用户确认后更新 Seat 状态，并重新执行一致性校验、总览编译和适用下游视图编译。

## Resolution Readiness

Not ready. Awaiting `BMD-001`.
