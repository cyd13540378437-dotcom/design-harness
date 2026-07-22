# Business Rules

| Rule ID | Rule | Bound Object IDs | Bound Action / State IDs | Status |
|---|---|---|---|---|
| `rule_member_requires_available_seat` | 新成员形成有效参与资格前必须存在可用或属于该流程的预留席位 | `member`, `seat` | `act_occupy_seat`, `seat_available`, `seat_reserved` | provisional |
| `rule_history_survives_member_removal` | 移除成员不得删除历史席位占用和计费责任 | `member`, `seat`, `billing_account` | `act_release_seat`, `seat_released` | confirmed |
| `rule_invitation_reservation_pending` | 邀请是否立即预留席位尚未确认，不能作为 confirmed 执行规则 | `invitation`, `seat` | `seat_reserved` | provisional |
