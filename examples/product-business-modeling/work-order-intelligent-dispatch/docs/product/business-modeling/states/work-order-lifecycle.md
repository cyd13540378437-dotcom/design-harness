# Work Order State Lifecycle

> Lifecycle owner object: `work_order`. State and action references use stable IDs.

## Object State Catalog

| Object ID | State ID | State Label | Meaning | Status |
|---|---|---|---|---|
| `work_order` | `work_order.created` | 已创建 | 工单已形成，但要求尚未确认。 | provisional |
| `work_order` | `work_order.ready_for_dispatch` | 可调度 | 要求已足以生成候选。 | provisional |
| `work_order` | `work_order.dispatching` | 调度中 | 正在生成、比较或确认候选。 | provisional |
| `work_order` | `work_order.assigned` | 已形成责任 | 已提交决策并创建 Assignment。 | provisional |
| `work_order` | `work_order.in_progress` | 执行中 | 资源已开始履责。 | provisional |
| `work_order` | `work_order.awaiting_close` | 待关闭 | 执行完成，等待结果确认。 | provisional |
| `work_order` | `work_order.closed` | 已关闭 | 服务结果已确认。 | provisional |
| `work_order` | `work_order.cancelled` | 已取消 | 服务需求被终止。 | provisional |

## State Transitions

| Object ID | From State ID | Trigger Action ID | To State ID | Conditions | Status |
|---|---|---|---|---|---|
| `work_order` | `work_order.created` | `ACT-001` | `work_order.ready_for_dispatch` | 工单信息已足以形成要求 | provisional |
| `work_order` | `work_order.ready_for_dispatch` | `ACT-002` | `work_order.dispatching` | 开始生成候选 | provisional |
| `work_order` | `work_order.dispatching` | `ACT-007` | `work_order.assigned` | 已提交决策并创建责任 | provisional |
| `work_order` | `work_order.assigned` | `ACT-010` | `work_order.in_progress` | 资源开始执行 | provisional |
| `work_order` | `work_order.in_progress` | `ACT-013` | `work_order.awaiting_close` | 执行完成并提交结果 | provisional |
| `work_order` | `work_order.awaiting_close` | `ACT-016` | `work_order.closed` | 主管确认结果 | provisional |
| `work_order` | `work_order.dispatching` | `ACT-017` | `work_order.cancelled` | 业务取消 | provisional |
| `work_order` | `work_order.assigned` | `ACT-014` | `work_order.dispatching` | 执行责任无法继续，需要重派 | provisional |
| `work_order` | `work_order.in_progress` | `ACT-014` | `work_order.dispatching` | 执行中断并需要重派 | provisional |

## Cross-object Materialization

`ACT-007` 在 `dispatch_decision` 上提交选择并创建 `assignment.created`；Work Order 仅进入 `assigned`，不吸收 Assignment 的内部状态。
