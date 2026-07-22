# Dispatch Decision State Lifecycle

> Lifecycle owner object: `dispatch_decision`. Recommendation and confirmation states belong here, not in Assignment.

## Object State Catalog

| Object ID | State ID | State Label | Meaning | Status |
|---|---|---|---|---|
| `dispatch_decision` | `dispatch_decision.recommended` | 已推荐 | 系统已形成推荐选择。 | provisional |
| `dispatch_decision` | `dispatch_decision.confirmed` | 已确认 | 调度员接受推荐。 | provisional |
| `dispatch_decision` | `dispatch_decision.overridden` | 已覆盖 | 调度员选择其他候选并说明原因。 | provisional |
| `dispatch_decision` | `dispatch_decision.rejected` | 已拒绝 | 当前建议被拒绝。 | provisional |
| `dispatch_decision` | `dispatch_decision.committed` | 已提交 | 选择已提交并形成 Assignment。 | provisional |
| `dispatch_decision` | `dispatch_decision.cancelled` | 已取消 | 未提交的决策被取消。 | provisional |

## State Transitions

| Object ID | From State ID | Trigger Action ID | To State ID | Conditions | Status |
|---|---|---|---|---|---|
| `dispatch_decision` | `dispatch_decision.recommended` | `ACT-004` | `dispatch_decision.confirmed` | 调度员接受推荐 | provisional |
| `dispatch_decision` | `dispatch_decision.recommended` | `ACT-005` | `dispatch_decision.overridden` | 选择其他候选并记录原因 | provisional |
| `dispatch_decision` | `dispatch_decision.recommended` | `ACT-006` | `dispatch_decision.rejected` | 拒绝当前建议 | provisional |
| `dispatch_decision` | `dispatch_decision.confirmed` | `ACT-007` | `dispatch_decision.committed` | 提交决策 | provisional |
| `dispatch_decision` | `dispatch_decision.overridden` | `ACT-007` | `dispatch_decision.committed` | 提交覆盖后的决策 | provisional |
| `dispatch_decision` | `dispatch_decision.recommended` | `ACT-018` | `dispatch_decision.cancelled` | 取消未提交决策 | provisional |
| `dispatch_decision` | `dispatch_decision.confirmed` | `ACT-018` | `dispatch_decision.cancelled` | 取消未提交决策 | provisional |

## Cross-object Materialization

| Source Object ID | Trigger Action ID | Created Object ID | Initial State ID | Meaning |
|---|---|---|---|---|
| `dispatch_decision` | `ACT-007` | `assignment` | `assignment.created` | 提交决策后才形成独立执行责任。 |
