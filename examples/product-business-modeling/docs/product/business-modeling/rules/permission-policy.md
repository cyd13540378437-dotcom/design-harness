# Permission Policy

| Permission ID | Role ID | Action ID | Conditions | Status |
|---|---|---|---|---|
| `permission_adjust_seat_capacity` | `billing_admin` | `act_adjust_seat_capacity` | 角色对目标计费账户承担治理责任 | provisional |
| `permission_accept_own_invitation` | `invited_person` | `act_accept_invitation` | 邀请对象与当前受邀者一致且邀请有效 | confirmed |

## Boundary

`system` 只能在已确认规则允许时执行 `act_occupy_seat` 与 `act_release_seat`；它不是绕过业务规则的管理员。
