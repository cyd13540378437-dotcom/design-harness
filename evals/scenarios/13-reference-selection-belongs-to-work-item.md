# 13 — Reference Selection Belongs to Work Item

## Given

- 目标项目存在 `docs/design/reference-library/`。
- 当前状态解析结果为 `CREATE DE-003`。

## When

- Agent 为 DE-003 选择本次任务参考。

## Then

- 创建 `docs/design/work-items/DE-003-*/REFERENCE_SELECTION.md`。
- `STATE.md` 只记录 Reference Selection 链接和摘要。
- 不得在 `reference-library/` 下创建 `reference-packs/` 或其他 Work Item 专属目录。
