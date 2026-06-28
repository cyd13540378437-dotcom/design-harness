# 状态生命周期

## Status 值

```text
active
paused
completed
cancelled
```

## Phase 值

```text
intake
discovery
visual-direction
prototype
ux-flow
implementation
qa
completion-review
complete
```

## Gate 值

```text
none
work-item-binding
visual-direction-approval
prototype-approval
interaction-decision
completion-approval
```

不得新增 `palette-approval`、`design-exclusion-approval` 或 `anti-homogeneity`。`palette-selection` 和 `design-exclusions` 只能作为 `STATE.md` 正文中的视觉子步骤。

## 生命周期

```text
active
  ├── paused ──→ active
  ├── active + awaiting_user
  ├── completion-review
  │      ├── 用户要求继续 ──→ active
  │      ├── 用户要求暂停 ──→ paused
  │      └── 用户批准关闭 ──→ completed + sealed
  └── 用户取消 ──→ cancelled + sealed
```

## Sealed 状态

当状态为：

```yaml
status: completed
sealed: true
```

或：

```yaml
status: cancelled
sealed: true
```

该状态对后续实现只读。不要修改它的 status、phase、gate、验收标准或已批准决定。相关后续工作必须创建 successor，并在 `predecessors` 中列出 sealed 状态。

## 视觉基线

`VISUAL_DESIGN.md` 是项目级视觉基线，不是 Work Item 状态。视觉 Work Item 完成前应创建或更新它，除非状态中记录无需更新的理由。后续 Work Item 应读取它，但不得通过修改 sealed 前任来改变历史。
