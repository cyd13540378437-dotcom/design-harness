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

## Lifecycle Memory and Outputs

新建 v0.1.3 Work Item 时，优先使用 Lifecycle Event ID：

```text
yyyy-mm-dd-hhmm-UX-001
yyyy-mm-dd-hhmm-PD-001
```

旧 `DE-xxx` Work Item 仍然合法，不能自动重命名；`completed + sealed` 状态不能为了补 `event_id` 或 Project Memory 字段而被修改。

`docs/design/project-memory/` 是跨 Work Item 的长期项目记忆。它只保存业务、产品、UX、视觉、工程和决策的压缩基线，不保存完整聊天记录、完整参考分析或完整色卡知识。

`docs/design/outputs/` 是交付物系统：

- `outputs/archive/<event_id>/` 保存 sealed 事件的交付快照。
- `outputs/current/` 只保存用户确认或项目采纳的当前入口。
- `outputs/index.yml` 记录 current 与 archive 的来源、状态和 source `STATE.md`。

Work Item 内的 `artifacts/` 是任务工作现场；`outputs/archive/` 是封存快照；`reference-library/` 仍然是长期参考资料层，不能放 Work Item 专属选择。

## Design Contract, Review Lens, and Fast Profile

`STATE.md` 应记录 Design Contract：

- 必须保持什么。
- 必须改变什么。
- 明确不做什么。
- 约束来自哪里。

`STATE.md` 还应记录 Review Lens：最终审查基于哪些业务目标、用户目标、范围边界和已批准决定。

Fast Profile 是 lightweight 的加速形态：

```yaml
mode: "lightweight"
execution_profile: "fast"
```

它只能用于已有项目中边界明确的局部任务。它可以跳过不适用的视觉方向或原型 Gate，但不能跳过状态判断、证据记录、Design Contract、Review Lens 或 `completion-approval`。

## Context-bound Final Review

进入 `completion-review` 前，必须生成 `review.md` 或记录等价审查摘要。审查必须基于当前 `STATE.md`、Design Contract、Review Lens、已批准决定、Reference Selection、Approved Color Direction、Project Memory 和实际验证证据。

不得做脱离上下文的通用审美审计，不得未验证却声称浏览器验收完成，不得推翻 sealed predecessor。

## Product Design Events

会员体系、定价模型、功能边界、权限与套餐、产品策略、对象模型、PRD 或 decision map 使用 `domain: PD`。PD 事件仍然使用 Work Item、`STATE.md`、artifacts、outputs archive、Project Memory 更新建议和 `completion-approval`。

后续 UX 事件可以通过 `predecessors` 只读继承 sealed PD 事件的套餐名称、功能边界、目标转化、合规文案约束和核心升级路径，但不能修改 sealed PD 状态。
