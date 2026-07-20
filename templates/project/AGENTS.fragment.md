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
- 配色确认、字体字号确认和设计禁区确认使用 `visual-direction-approval`，正文分别写 `palette-selection`、`typography-selection` 与 `design-exclusions`。
- 每次 Gate 回复后，先更新状态再继续实现。
- 完成封存需要用户在 `completion-approval` 明确批准。
- Steward 只管理状态；实现留给父级 Agent。
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

## Color Card Registry Rules

When working on UI/UX Work Items with color direction decisions, use the project color-card registry if present:

```text
docs/design/reference-library/assets/color-cards/
```

### Registry Identity

A color card is not just an image. A valid color card is:

```text
palette-index.yml entry + image + palette + annotation
```

`palette-index.yml` is authoritative. `palette-index.md` is a human-readable view.

### Integrity Rules

Before using a color card:

1. Confirm the card appears in `palette-index.yml`.
2. Confirm `image`, `palette`, and `annotation` paths exist.
3. Confirm file stems match the card `id`.
4. Confirm palette and annotation IDs match the index ID.
5. Exclude `draft` and `deprecated` cards from user-facing approval candidates.
6. Use only `status: ready` and `gate_preview: true` cards in `visual-direction-approval`.
7. Do not use orphan assets under `images/`, `palettes/`, or `annotations/`.

### Browsing Experience

Keep the centralized asset directories:

```text
images/
palettes/
annotations/
```

Do not convert the registry to per-card folders. Image browsing experience is important during design review.

### User Confirmation

When asking the user to confirm color direction, show large color-card visuals and business semantics. Do not ask the user to approve raw HEX/RGB values or tiny color icons.

### Work Item Recording

Write actual color-card consumption into the Work Item's `REFERENCE_SELECTION.md`.

Keep `STATE.md` small: selected color-card ID, color direction summary, approved decision, and link to `REFERENCE_SELECTION.md` are enough.

### Steward Boundary

`design_state_steward` manages state only. It does not choose color cards, create color-card knowledge, or modify `reference-library` unless explicitly instructed for state-link recording.

有效状态解析决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

有效 Gate：

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```

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

---

# Product Business Modeling

Use DesignHarnessAgent `product-business-modeling` for product business semantics.

## Runtime Adapter Resolution

Before materializing runtime-specific files, resolve the current agent runtime. Select `codex`, `claude-code`, `cursor`, `generic-agent`, or explicit `multi-runtime`. If runtime signals conflict, stop and ask the user.

Default project templates must stay runtime-neutral. Runtime-specific files belong under `runtime-overlays/<runtime>/` until that profile is selected; do not install all overlays by default.

## Source of truth

- Business model source of truth lives in `docs/product/business-modeling/`.
- Work Item state lives in `docs/product/work-items/BM-xxx/STATE.md`.
- Passive triggers live in `docs/product/model-triggers/MT-xxx.md`.
- `PRODUCT_WORK_ITEMS.md` is a navigation index, not the authoritative state source.

## Required behavior

- Resolve the entry mode before modeling: `direct_modeling`, `passive_trigger`, `project_extraction`, `greenfield_modeling`, `consistency_validation`, or `downstream_compilation`.
- Keep business attributes separate from data fields.
- Keep `schema-view.json` limited to business objects, business domains, object categories, business attributes and example content.
- Treat project extraction output as draft/provisional until confirmed.
- Route D2/D3 decisions through human confirmation before writing or overriding confirmed semantics.
- Use `model-triggers/` for upstream changes, downstream gaps, cross-cluster conflicts and internal discoveries.
- Downstream views under `business-modeling/downstream-views/` are derived views and must not overwrite core model assets.
- Do not mark a business modeling Work Item or decision as sealed without explicit user approval.

## UX Business Model Context

Business Modeling Core exposes a lightweight UX context pack at:

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

If Design Engineering / UX work is running in the same repository, UX may read this pack at Work Item startup. Missing context must not block UX startup. UX must not confirm new business objects, actions, states, rules, permissions, responsibility, or audit semantics by itself.

When UX finds a missing business model concept, create or recommend a `downstream_gap` Model Trigger. When UX contradicts confirmed business model semantics, create or recommend a `cross_cluster_conflict` Model Trigger. Pure layout, visual style, reference selection, color cards, and local UI controls do not trigger Business Modeling.
