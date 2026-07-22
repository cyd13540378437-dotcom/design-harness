---
schema_version: 3
language: zh-CN
case_id: BA-DC-001
title: 未激活邀请是否占用付费 Seat
status: confirmed
decision_scope_id: seat-invitation-billing-policy
decision_scope_type: local_business_rule_choice
decision_scope_status: locked
choice_loop_status: closed
overall_assurance: pass
recommended_option_id: C
recommendation_status: user_confirmed
user_decision_status: confirmed
created_at: "2026-07-21"
updated_at: "2026-07-22"
owner: product-owner
---

# 决策案例：未激活邀请是否占用付费 Seat

# A. Decision Core / 决策核心

## A0. Decision Scope Lock

- 本 Case 解决：未激活邀请何时产生付费 Seat，以及如何控制滥用。
- 明确不包含：具体上限值、数据库字段、UI 和实现规则。
- Scope status：`locked`

## A1. 当前决策问题

> 未激活邀请何时产生付费 Seat，以及如何控制无限邀请风险？

## A2. Choice Set

| ID | 选项 | 状态 | 主要价值 | 主要代价 / 风险 |
|---|---|---|---|---|
| A | 发出邀请即计费 | rejected | 规则保守 | 客户为未使用成员付费 |
| B | 接受后计费且不设上限 | eliminated | 计费公平 | 可能大量待接受邀请 |
| C | 接受后计费并设上限 | selected | 公平、可控、可逆 | 需后续校准上限 |
| D | 发出后短期预留 | deferred | 折中容量与公平 | 解释更复杂 |

## A3. 当前推荐

- 推荐：C（user_confirmed）
- 证据边界：暂无真实邀请行为数据。
- 改变条件：预购容量、滥用显著增加或客户要求容量锁定。

## A4. 用户决定与 Choice Loop

- 用户决定：confirmed
- Choice Loop：closed
- 已确认：未激活邀请不占用付费 Seat，同时设置待接受邀请数量上限。

## A5. Claim-level Assurance

- 政策方向：supported
- 精确上限值：blocked

# B. Decision Basis / 决策依据

## B0. 原始输入

> 未激活邀请要不要占用付费 Seat？我不希望客户觉得为还没使用产品的人付费，但也担心无限邀请会造成滥用。

## B1–B9 摘要

当前按 Seat 计费；未激活邀请尚未产生实际使用。C 在公平性、滥用控制和可逆性之间最平衡。

# C. Decision Memory / 决策记忆

## C1. 复审

观察滥用、账单争议和超限事件；触发条件出现时正式重开。

## C2. Choice Delta

2026-07-21：C 被确认，Choice Loop 关闭。
