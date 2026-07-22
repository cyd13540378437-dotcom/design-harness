# Modeling Consumption

## Entry Mode

- `passive_trigger`

## Sources Consumed

- `MT-001-seat-pricing-model.md`；
- `BA-002` 已确认结论：按 Seat 计费；
- 当前工作区、成员、邀请与计费账户模型。

## Confirmed Inputs

- 计费依据已经从按工作区变为按席位。

## Provisional Inputs

- Seat 尚未作为 confirmed 独立对象；
- 邀请预占席位的规则未知。

## Missing Information

- 邀请是否在发送、接受或成员建立时占用席位；
- Seat 是否需要临时、访客或不可计费变体。

## Assumptions Used

- 为支持影响分析，先以独立 Seat 对象建立 provisional 候选模型；
- 不将候选模型用于 confirmed 工程约束。

## Consumption Boundary

本次不消费或生成数据库字段、API 参数或技术持久化方案。
