# 05. 并行 Work Items

## 前提

- `DE-002` 处于 active，并等待 `completion-approval`。
- 用户开始另一项具有独立验收标准的重要产品功能。

## 当

用户说：

```text
另外设计一个灵感标签管理面板。
```

## 则

- `design_state_steward` 返回 `CREATE`。
- 创建新的 `DE-003` Work Item。
- `DE-002` 保持 active 且不被修改。
- `WORK_ITEMS.md` 在 Active 中同时列出 `DE-002` 和 `DE-003`。
- 父级 Agent 继续前必须明确当前 Thread 绑定到哪个 Work Item。

