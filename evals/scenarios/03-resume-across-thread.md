# 03. 跨 Thread 恢复

## 前提

- `DE-001` 存在于另一个 Codex Thread 中。
- `DE-001` 未封存，并正在等待 `prototype-approval`。
- `WORK_ITEMS.md` 在 Active 中列出 `DE-001`。

## 当

新的 Thread 启动，用户说：

```text
继续上次前端样式任务，我批准原型。
```

## 则

- `design_state_steward` 返回 `RESUME`。
- 不创建重复 Work Item。
- `DE-001/STATE.md` 记录 `prototype-approval` 决定。
- `awaiting_user` 变为 `false`。
- 父级 Agent 从下一个已批准阶段继续。

预期决定：

```yaml
decision: RESUME
current_state: "docs/design/work-items/DE-001-optimize-frontend-style/STATE.md"
new_state: ""
candidates:
  - "DE-001"
reason: "用户明确指向未封存的前端样式任务并批准当前 Gate。"
user_question: ""
recommended_action: "记录原型批准并进入 UX flow 或 implementation。"
```

