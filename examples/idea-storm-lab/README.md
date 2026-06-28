# idea-storm-lab 示例

本示例展示 Codex Design Harness v0.1.0-alpha / visual-workflow revision 要求的三个请求序列。

## 请求 1：检查项目上下文

用户请求：

```text
检查项目上下文，不要修改文件。
```

预期 Steward 决定：

```yaml
decision: NO_STATE
current_state: ""
new_state: ""
candidates: []
reason: "只读项目上下文检查，没有独立验收任务。"
user_question: ""
recommended_action: "直接向用户汇报项目结构和风险，不创建 Work Item。"
```

不创建任何 Work Item 目录。

## 请求 2：优化前端样式

用户请求：

```text
优化前端样式。
```

预期 Steward 决定：

```yaml
decision: CREATE
current_state: ""
new_state: "examples/idea-storm-lab/docs/design/work-items/DE-001-optimize-frontend-style/STATE.md"
candidates: []
reason: "这是具有独立目标、视觉流程、原型、实现和验收标准的 UI/UX 任务。"
user_question: ""
recommended_action: "创建 DE-001 并进入 Full Mode。"
```

`DE-001` 示例状态已经关闭并封存，便于阅读完整生命周期。它展示：

- Visual Seed。
- 使用内置参考包而不是第三方截图。
- 参考解析。
- `palette-selection` 配色确认。
- `design-exclusions` 设计禁区确认。
- 视觉原型确认。
- 实现、QA 和 `VISUAL_DESIGN.md` 更新。
- completion approval 后写入 `completed + sealed`。

## 请求 3：统一内容模块问题长度换行

用户请求：

```text
统一内容模块问题长度换行。
```

预期 Steward 决定：

```yaml
decision: SUCCESSOR
current_state: "examples/idea-storm-lab/docs/design/work-items/DE-001-optimize-frontend-style/STATE.md"
new_state: "examples/idea-storm-lab/docs/design/work-items/DE-002-content-module-line-wrap/STATE.md"
candidates:
  - "DE-001"
reason: "新请求与已封存的前端样式优化相关，但有独立验收标准，不能修改 sealed 的 DE-001。"
user_question: ""
recommended_action: "创建 DE-002，记录 predecessor: DE-001，并读取 VISUAL_DESIGN.md。"
```

`DE-002` 保持 active，并停在 `completion-approval`，用于展示“实现可完成，但最终关闭仍属于用户”的状态。它读取并遵守 `VISUAL_DESIGN.md`，只处理长文本换行，不重新激活 sealed 的 `DE-001`。
