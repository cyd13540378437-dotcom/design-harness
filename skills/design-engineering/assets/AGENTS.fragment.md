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
- `VISUAL_DESIGN.md` 是项目视觉基线，不替代 `STATE.md`。
- 后续 Work Item 必须读取已有 `VISUAL_DESIGN.md`。
- 不要修改或恢复 `completed + sealed` 状态。
- 每个 Human Gate 前由 Steward 写入等待用户的检查点。
- 配色确认、字体字号确认和设计禁区确认使用 `visual-direction-approval`，正文分别写 `palette-selection`、`typography-selection` 与 `design-exclusions`。
- 用户回复 Gate 后，先更新状态再继续。
- 完成封存必须经过 `completion-approval`，不得在没有用户明确批准时 seal。
- Steward 只管理状态，不实现产品代码，也不替用户批准。
- 不要求用户填写产品人格、品牌气质矩阵或用户感受目标表单。
- 不新增 `palette-approval`、`typography-approval`、`design-exclusion-approval` 或 `anti-homogeneity` Gate。

## Design Reference Library

如果 UI/UX 任务中存在 `docs/design/reference-library/`，提出视觉方向前必须先明确目标终端：

```text
web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface
```

按同终端、同页面类型、同任务类型、相近内容密度和交互复杂度、相近用户成熟度、相邻行业、视觉标签的顺序筛选参考。

参考资源是 Agent 的判断证据，不是用户必须掌握的专业词汇。不要让用户在命名产品之间做选择，除非用户已经这样表达需求；应把参考转译为“效率工作台”“引导式助手”“内容探索”“快速记录”等业务语义和取舍。

每个状态化 Work Item 的实际参考消费结果写入：

```text
docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md
```

`STATE.md` 只记录目标终端、Reference Selection 链接、采用原则摘要、用户批准方向和关键排除项。不要在 `reference-library/` 下创建 Work Item 专属 `reference-packs/` 或其他任务目录。

不要复制第三方品牌资产、图标、插画、截图、专有文案或完整页面布局。跨终端参考只能用于抽象模式，不能直接复制为布局、导航、手势、密度或视觉比例。
