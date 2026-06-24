# 07. 关闭并封存

## 前提

- `DE-002` 实现和 QA 已完成。
- `DE-002` 当前状态为：

```yaml
status: "active"
phase: "completion-review"
gate: "completion-approval"
awaiting_user: true
sealed: false
```

## 当

父级 Agent 展示完成证据，但用户尚未批准关闭。

## 则

- `DE-002` 不得变为 `completed`。
- `sealed` 必须保持 `false`。
- 下一步仍是等待用户批准。

## 当

用户明确说：

```text
关闭。
```

## 则

- `design_state_steward` 记录批准。
- `DE-002/STATE.md` 变为：

```yaml
status: "completed"
phase: "complete"
gate: "none"
awaiting_user: false
sealed: true
```

- 写入 `completed_at`。
- `WORK_ITEMS.md` 将 `DE-002` 从 Active 移到 Completed。
- 后续相关工作必须是 `SUCCESSOR`，不能是 `RESUME`。

