# State Lifecycle Model

## Object State Catalog

| Object ID | State ID | State Label | Meaning | Status |
|---|---|---|---|---|
| `seat` | `seat_available` | 可用 | 可以形成新的成员占用 | provisional |
| `seat` | `seat_reserved` | 预留 | 暂为加入过程保留；是否启用待确认 | provisional |
| `seat` | `seat_occupied` | 已占用 | 已与有效成员形成占用关系 | provisional |
| `seat` | `seat_released` | 已释放 | 历史占用结束，等待重新可用 | provisional |

## State Transitions

| Object ID | From State ID | Trigger Action ID | To State ID | Conditions | Status |
|---|---|---|---|---|---|
| `seat` | `seat_available` | `act_occupy_seat` | `seat_occupied` | 成员建立成功且席位仍可用 | provisional |
| `seat` | `seat_reserved` | `act_occupy_seat` | `seat_occupied` | 预留属于该加入过程 | provisional |
| `seat` | `seat_occupied` | `act_release_seat` | `seat_released` | 当前占用资格结束 | provisional |
| `seat` | `seat_released` | `act_adjust_seat_capacity` | `seat_available` | 该资格继续属于有效容量 | provisional |

## Lifecycle Boundary

本文件只描述 Seat 生命周期。Invitation 的等待 / 接受 / 失效状态不混入 Seat 生命周期；接受邀请只通过后续动作触发 Seat 占用。
