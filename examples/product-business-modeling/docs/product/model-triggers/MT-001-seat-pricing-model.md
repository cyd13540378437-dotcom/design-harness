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
created_at: 2026-07-17
updated_at: 2026-07-17
resolved_at: ""
---

# Model Trigger: Pricing Model Changed to Seat-based

## Trigger Summary

商业分析层确认计费方式从按 Workspace 计费调整为按 Seat 计费。

## Source Context

来源为 `BA-002` 的 confirmed 商业分析决定。

## Source Decision or Evidence

- Confirmed Decision: 按 Seat 计费
- Decision Status: confirmed

## Observed Change, Gap, or Conflict

当前业务模型只有 Workspace 与 Member，没有 Seat 的对象身份、占用规则、邀请关系或权限约束。

## Why It Matters

这个变化可能影响 Seat 是否成为独立业务对象、Member 与 Seat 的关系、Invitation 是否提前占用 Seat、权限规则、数据库视图、后端计费校验和 QA 验收。

## Requested Response

请业务模型能力执行影响分析，并提出需要人类确认的建模方案。

## Initial Scope Hint

- 可能涉及对象：Workspace, Member, Seat, Invitation, BillingAccount
- 可能涉及规则：席位占用、邀请占用、移除成员后的历史保留

## Human Decision Signals

Seat 是否为独立业务对象属于 D2 决策。

## Resolution

- Status: awaiting_human
- Resolved by BM Work Item: BM-001
- Impact Report: ../work-items/BM-001-seat-pricing-impact/artifacts/MODEL_IMPACT_REPORT.md
- Human Decision Required: yes
- Summary: awaiting decision BMD-001
- Follow-up Triggers:
