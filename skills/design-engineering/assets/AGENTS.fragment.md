# Design Engineering Harness

对新产品界面、重要功能页面、跨页面流程和显著 UI/UX 重构使用 `$design-engineering`。

在开始状态化设计工作前，必须显式调用 `design_state_steward`，将当前请求解析为：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

规则：

- 不要把 Codex Thread 当作 Work Item。
- 每个 Work Item 最多有一个权威 `STATE.md`。
- `WORK_ITEMS.md` 是索引；冲突时以 `STATE.md` 为准。
- 不要修改或恢复 `completed + sealed` 状态。
- 每个 Human Gate 前由 Steward 写入等待用户的检查点。
- 用户回复 Gate 后，先更新状态再继续。
- 完成封存必须经过 `completion-approval`，不得在没有用户明确批准时 seal。
- Steward 只管理状态，不实现产品代码，也不替用户批准。

