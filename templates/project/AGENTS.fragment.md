# Design Engineering Harness

对新产品界面、重要功能页面、跨页面流程和显著 UI/UX 重构使用 `$design-engineering`。

在开始状态化设计工作前，必须显式调用 `design_state_steward`，将当前请求解析为：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

项目规则：

- Codex Thread 不是 Work Item。
- 每个独立 Work Item 最多有一个权威 `STATE.md`。
- `docs/design/WORK_ITEMS.md` 是索引；`STATE.md` 是权威来源。
- 不要恢复或修改 `completed + sealed` Work Item。
- 封存后的相关工作必须创建 Successor。
- 每个 Gate 前，由 Steward 写入等待用户的检查点。
- 每次 Gate 回复后，先更新状态再继续实现。
- 完成封存需要用户在 `completion-approval` 明确批准。
- Steward 只管理状态；实现留给父级 Agent。

有效状态解析决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

有效 Gate：

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```

