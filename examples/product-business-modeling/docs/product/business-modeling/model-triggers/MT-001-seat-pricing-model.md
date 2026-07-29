---
schema_version: 1
trigger_id: MT-001
trigger_type: upstream_change
source_cluster: business-analysis
target_cluster: business-modeling
source_work_item: BA-002
target_work_item: BM-001
status: awaiting_human
priority: high
impact_level: D2
dedupe_key: pricing-model-seat-change
created_at: "2026-07-17"
updated_at: "2026-07-22"
resolved_at: ""
---

# Model Trigger: Pricing Model Changed to Seat-based

## Trigger Summary

商业分析层确认计费方式从按 Workspace 计费调整为按 Seat 计费。

## Source Decision or Evidence

- Source Work Item: `BA-002`
- Confirmed Decision: 按 Seat 计费
- Decision Status: confirmed

## Observed Change, Gap, or Conflict

当前模型已有 Workspace、Member、Invitation 和 BillingAccount，但没有 Seat 的身份、占用规则或生命周期。

## Why It Matters

变化可能影响对象身份、成员与邀请关系、权限、审计和所有专业下游视图。

## Requested Response

执行业务模型影响分析，并提出需要人类确认的建模方案。

## Resolution

- Status: `awaiting_human`
- Resolved by BM Work Item: [`BM-001`](../work-items/BM-001-seat-pricing-impact/STATE.md)
- Impact Report: [`MODEL_IMPACT_REPORT.md`](../work-items/BM-001-seat-pricing-impact/artifacts/MODEL_IMPACT_REPORT.md)
- Human Decision Required: `BMD-001`
- Summary: 当前 provisional 模型推荐 Seat 作为独立业务对象。
