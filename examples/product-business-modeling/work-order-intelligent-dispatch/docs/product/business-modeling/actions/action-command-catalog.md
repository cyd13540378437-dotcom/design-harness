# Action Command Catalog

> IDs are stable references. Actor role IDs and target object IDs exist in `business-dictionary.yml`.

| Action ID | Action Label | Actor Role IDs | Target Object ID | Preconditions | Business Effects | Creates / Changes Responsibility | Audit Significance | Status |
|---|---|---|---|---|---|---|---|---|
| `ACT-001` | 确认工单要求 | `dispatcher` | `work_requirement` | 工单事实可被业务判断 | 形成可调度要求 | 不创建执行责任 | 记录确认人和要求版本 | provisional |
| `ACT-002` | 生成派工候选 | `scheduling_system` | `dispatch_candidate` | 工单要求已就绪 | 形成满足硬约束的候选集合 | 不创建责任 | 记录排除原因与策略版本 | provisional |
| `ACT-003` | 推荐派工候选 | `scheduling_system` | `dispatch_decision` | 存在可推荐候选 | 创建 `dispatch_decision.recommended` | 创建决策对象，不创建 Assignment | 记录排序与推荐理由 | provisional |
| `ACT-004` | 确认派工决策 | `dispatcher` | `dispatch_decision` | 决策处于 recommended | 进入 confirmed | 确认选择，尚未形成 Assignment | 记录确认人和时间 | provisional |
| `ACT-005` | 覆盖派工决策 | `dispatcher` | `dispatch_decision` | 存在推荐且有覆盖权限 | 进入 overridden 并记录原因 | 改变选择，尚未形成 Assignment | 高；必须保留覆盖前后方案 | provisional |
| `ACT-006` | 拒绝派工建议 | `dispatcher` | `dispatch_decision` | 决策尚未 committed | 进入 rejected 并返回调度 | 不形成责任 | 记录拒绝原因 | provisional |
| `ACT-007` | 提交派工决策 | `dispatcher` | `dispatch_decision` | 决策已 confirmed 或 overridden | 决策进入 committed | 创建 `assignment.created` 执行责任 | 高；记录责任形成依据 | provisional |
| `ACT-008` | 通知派工责任 | `scheduling_system` | `assignment` | Assignment 已创建 | 进入 notified | 通知既有责任 | 记录通知渠道与时间 | provisional |
| `ACT-009` | 接受派工责任 | `service_resource_actor` | `assignment` | 责任已通知且属于该资源 | 进入 accepted | 接受执行责任 | 记录接受主体与时间 | provisional |
| `ACT-010` | 开始执行 | `service_resource_actor` | `assignment` | 责任已接受且作业条件满足 | Assignment active；工单 in_progress | 激活执行责任 | 记录实际开始 | provisional |
| `ACT-011` | 暂停执行 | `service_resource_actor` | `assignment` | 责任 active | 进入 paused 并记录原因 | 暂停但不解除责任 | 记录暂停原因 | provisional |
| `ACT-012` | 恢复执行 | `service_resource_actor` | `assignment` | 责任 paused 且阻碍消除 | 返回 active | 恢复既有责任 | 记录恢复依据 | provisional |
| `ACT-013` | 完成执行 | `service_resource_actor` | `assignment` | 工作已完成并有结果 | Assignment finished；工单 awaiting_close | 完成执行责任 | 记录结果和证据 | provisional |
| `ACT-014` | 请求重派 | `service_resource_actor` | `assignment` | 当前责任无法继续 | 进入 reassignment_requested；工单返回调度 | 触发新决策，不直接改写旧责任 | 高；记录原因和剩余工作 | provisional |
| `ACT-015` | 取消派工责任 | `dispatcher` | `assignment` | 责任未 finished | 进入 cancelled | 终止当前责任 | 高；记录取消原因 | provisional |
| `ACT-016` | 关闭工单 | `supervisor` | `work_order` | 执行结果和必要证据已确认 | 工单进入 closed | 关闭业务流程 | 高；记录关闭人和证据 | provisional |
| `ACT-017` | 取消工单 | `dispatcher` | `work_order` | 工单未 closed | 工单进入 cancelled | 终止服务需求 | 高；记录取消原因 | provisional |
| `ACT-018` | 取消派工决策 | `dispatcher` | `dispatch_decision` | 决策未 committed | 决策进入 cancelled | 不创建 Assignment | 记录取消原因 | provisional |

## Missing Actor / Target / Effect Issues

None in the current provisional catalog.

## Human Decisions Required

- `BMD-003`：系统是否只能 recommend，还是可在护栏内自动 commit。
