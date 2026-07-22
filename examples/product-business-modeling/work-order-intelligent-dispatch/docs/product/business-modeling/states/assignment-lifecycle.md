# Assignment State Lifecycle

> Lifecycle owner object: `assignment`. It begins only after `ACT-007` creates responsibility.

## Object State Catalog

| Object ID | State ID | State Label | Meaning | Status |
|---|---|---|---|---|
| `assignment` | `assignment.created` | 已创建 | 已形成执行责任。 | provisional |
| `assignment` | `assignment.notified` | 已通知 | 责任已通知目标资源。 | provisional |
| `assignment` | `assignment.accepted` | 已接受 | 资源接受责任。 | provisional |
| `assignment` | `assignment.active` | 执行中 | 责任正在履行。 | provisional |
| `assignment` | `assignment.paused` | 已暂停 | 责任暂时受阻。 | provisional |
| `assignment` | `assignment.reassignment_requested` | 已请求重派 | 当前责任无法继续，需要新决策。 | provisional |
| `assignment` | `assignment.finished` | 已完成 | 执行责任已完成。 | provisional |
| `assignment` | `assignment.cancelled` | 已取消 | 当前责任已终止。 | provisional |

## State Transitions

| Object ID | From State ID | Trigger Action ID | To State ID | Conditions | Status |
|---|---|---|---|---|---|
| `assignment` | `assignment.created` | `ACT-008` | `assignment.notified` | 系统通知责任 | provisional |
| `assignment` | `assignment.notified` | `ACT-009` | `assignment.accepted` | 资源接受责任 | provisional |
| `assignment` | `assignment.accepted` | `ACT-010` | `assignment.active` | 开始执行 | provisional |
| `assignment` | `assignment.active` | `ACT-011` | `assignment.paused` | 执行受阻 | provisional |
| `assignment` | `assignment.paused` | `ACT-012` | `assignment.active` | 阻碍解除 | provisional |
| `assignment` | `assignment.active` | `ACT-013` | `assignment.finished` | 执行完成 | provisional |
| `assignment` | `assignment.active` | `ACT-014` | `assignment.reassignment_requested` | 无法继续执行 | provisional |
| `assignment` | `assignment.paused` | `ACT-014` | `assignment.reassignment_requested` | 暂停后请求重派 | provisional |
| `assignment` | `assignment.created` | `ACT-015` | `assignment.cancelled` | 责任取消 | provisional |
| `assignment` | `assignment.notified` | `ACT-015` | `assignment.cancelled` | 责任取消 | provisional |
| `assignment` | `assignment.accepted` | `ACT-015` | `assignment.cancelled` | 责任取消 | provisional |

## Cross-object Lifecycle Boundary

`recommended / confirmed / overridden / rejected / committed` 属于 `dispatch_decision`。Assignment 不得在责任创建前拥有这些状态。
