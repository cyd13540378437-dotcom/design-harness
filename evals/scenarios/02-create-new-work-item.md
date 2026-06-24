# 02. 创建新的 Work Item

## 前提

- `docs/design/WORK_ITEMS.md` 已存在。
- 没有现有 Work Item 覆盖用户请求的重要功能。

## 当

用户说：

```text
为 idea-storm-lab 设计一个新的灵感分组页面。
```

## 则

- `design_state_steward` 返回 `CREATE`。
- 创建新的 Work Item 目录，例如 `docs/design/work-items/DE-003-inspiration-groups/`。
- `STATE.md` 初始为 `status: "active"`、`phase: "discovery"`、`gate: "none"`、`sealed: false`。
- `WORK_ITEMS.md` 在 Active 中列出新的 Work Item。
- 父级 Agent 进入设计工作流，并在适用 Full Mode 时准备视觉方向 Gate。

