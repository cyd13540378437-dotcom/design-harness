# 状态解析

状态化设计工作开始前，`design_state_steward` 必须解析当前请求。

解析前读取：

- 项目 `AGENTS.md`
- `docs/design/WORK_ITEMS.md`
- 语义相关的 active、paused 和 sealed `STATE.md`
- `docs/design/VISUAL_DESIGN.md`，如果存在

## CREATE

当当前请求是新的独立 Work Item，并且有自己的目标、范围和验收标准时，使用 `CREATE`。

效果：

- 创建 `docs/design/work-items/<ID-slug>/STATE.md`
- 更新 `docs/design/WORK_ITEMS.md`
- 将当前工作流绑定到新状态

## RESUME

当请求明确属于现有未封存 Work Item 时，使用 `RESUME`。

允许恢复的来源状态：

- `active`
- `paused`
- 正等待用户 Gate 的 active 状态

不得对 `completed + sealed` 返回 `RESUME`。

## SUCCESSOR

当请求与 sealed Work Item 相关，但有独立验收标准或需要新实现时，使用 `SUCCESSOR`。

效果：

- 创建新的 Work Item
- 记录 sealed predecessors
- 保持 predecessors 只读
- 读取并继承适用的 `VISUAL_DESIGN.md`
- 更新索引关系

## NO_STATE

只读上下文检查、代码解释、临时研究、极小一次性安全调整或非 UI 工作，不需要持久设计工作流状态时，使用 `NO_STATE`。

## AMBIGUOUS

当多个候选都合理，或新旧任务边界不清时，使用 `AMBIGUOUS`。

效果：

- 不创建状态
- 不修改候选状态
- 列出候选项
- 给出推荐
- 请用户决定
