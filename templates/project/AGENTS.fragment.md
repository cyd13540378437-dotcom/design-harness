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
- `docs/design/VISUAL_DESIGN.md` 是项目视觉基线；后续 Work Item 必须先读取它。
- 不要恢复或修改 `completed + sealed` Work Item。
- 封存后的相关工作必须创建 Successor。
- 每个 Gate 前，由 Steward 写入等待用户的检查点。
- 配色确认和设计禁区确认使用 `visual-direction-approval`，正文分别写 `palette-selection` 与 `design-exclusions`。
- 每次 Gate 回复后，先更新状态再继续实现。
- 完成封存需要用户在 `completion-approval` 明确批准。
- Steward 只管理状态；实现留给父级 Agent。
- 不要求用户填写产品人格、品牌气质矩阵或用户感受目标表单。
- 不新增 `palette-approval`、`design-exclusion-approval` 或 `anti-homogeneity` Gate。

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

有效状态解析决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

有效 Gate：

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```
