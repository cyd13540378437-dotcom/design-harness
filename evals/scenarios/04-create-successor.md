# 04. 创建 Successor

## 前提

- `DE-001` 是 `status: "completed"` 且 `sealed: true`。
- `DE-001` 覆盖了更宽泛的前端样式刷新。

## 当

用户说：

```text
统一内容模块问题长度换行。
```

## 则

- `design_state_steward` 返回 `SUCCESSOR`。
- 创建新的 `DE-002` Work Item。
- `DE-002` 写入 `predecessors: ["DE-001"]`。
- 不修改 `DE-001`。
- `WORK_ITEMS.md` 在 Active 中列出 `DE-002`，并保持 `DE-001` 位于 Completed。

