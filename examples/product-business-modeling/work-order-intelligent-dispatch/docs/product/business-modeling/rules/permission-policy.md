# Permission Policy

> Role, action and object references use stable IDs.

| Policy ID | Role ID | Action ID | Object ID | Condition | Result | Audit Requirement | Status |
|---|---|---|---|---|---|---|---|
| `PP-001` | `dispatcher` | `ACT-004` | `dispatch_decision` | 具备目标区域调度权限 | allow | 记录确认人、时间和候选 | provisional |
| `PP-002` | `dispatcher` | `ACT-005` | `dispatch_decision` | 具备覆盖权限并填写结构化原因 | allow | 记录覆盖前后候选、原因与时间 | provisional |
| `PP-003` | `service_resource_actor` | `ACT-009` | `assignment` | Assignment 分配给自身或所属班组 | allow | 记录接受主体和时间 | provisional |
| `PP-004` | `supervisor` | `ACT-016` | `work_order` | 执行结果和必要证据已确认 | allow | 记录关闭人、时间和证据摘要 | provisional |
| `PP-005` | `scheduling_system` | `ACT-007` | `dispatch_decision` | 第一阶段仍采用人工提交边界 | deny | 记录并阻止任何自动提交尝试 | provisional |

## Audit-sensitive Rules

覆盖推荐、提交决策、取消责任、关闭工单均为高审计动作。

## Human Decisions Required

- `BMD-003`：是否允许系统在满足护栏时自动提交派工决策。
