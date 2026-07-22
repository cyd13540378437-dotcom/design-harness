# Action Command Catalog

| Action ID | Action Label | Actor Role IDs | Target Object ID | Preconditions | Business Effects | Creates / Changes Responsibility | Audit Significance | Status |
|---|---|---|---|---|---|---|---|---|
| `act_adjust_seat_capacity` | 调整席位容量 | `billing_admin` | `billing_account` | 操作者承担该账户的计费治理责任 | 增加或减少可用席位资格 | 改变账户承担的容量责任 | high | provisional |
| `act_accept_invitation` | 接受邀请 | `invited_person` | `invitation` | 邀请有效且受邀者匹配 | 邀请进入已接受，触发成员建立流程 | 形成加入意图的完成事实 | medium | confirmed |
| `act_occupy_seat` | 占用席位 | `system` | `seat` | 成员建立成功且有可用席位 | 席位进入已占用并关联成员 | 建立成员的席位占用责任 | high | provisional |
| `act_release_seat` | 释放席位 | `system` | `seat` | 成员不再拥有占用资格 | 结束当前占用并保留历史 | 解除当前责任但不删除历史 | high | provisional |

## Human Decisions Required

- `BMD-001` 决定 Seat 是否保留为独立动作目标。
