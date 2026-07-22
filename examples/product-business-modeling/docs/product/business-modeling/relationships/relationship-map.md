# Relationship Map

| Relationship ID | Source Object ID | Relationship Label | Target Object ID | Meaning | Context-dependent Attributes | Status |
|---|---|---|---|---|---|---|
| `rel_workspace_billing_account` | `workspace` | 由…承担计费责任 | `billing_account` | 一个工作区由一个计费账户承担席位容量责任 | 当前套餐上下文 | confirmed |
| `rel_workspace_seat` | `workspace` | 拥有可用资格 | `seat` | 工作区的计费账户为其提供席位容量 | 容量生效期间 | provisional |
| `rel_member_seat` | `member` | 占用 | `seat` | 有效成员与一个席位形成占用责任 | 占用起止时间 | provisional |
| `rel_invitation_seat` | `invitation` | 可能预留 | `seat` | 邀请是否提前保留席位尚待决策 | 邀请有效期 | provisional |

## Context-dependent Values

“某邀请是否占用某席位”属于关系与流程上下文，不是 Invitation 或 Seat 单独固有的无条件事实。
