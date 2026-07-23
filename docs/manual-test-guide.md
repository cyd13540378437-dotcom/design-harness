# 手动测试指南

使用本指南验证 v0.1.3-alpha / lifecycle-memory increment 仓库，不需要安装任何运行时依赖。

## 1. 文件结构

确认文档要求的文件存在：

```text
README.md
README.zh-CN.md
CHANGELOG.md
LICENSE
AGENTS.md
CODEX_BUILD_BRIEF.color-card-registry.md
CODEX_PROMPT.color-card-knowledge-production.md
skills/design-engineering/SKILL.md
skills/design-engineering/agents/openai.yaml
skills/design-engineering/assets/STATE.template.md
skills/design-engineering/assets/WORK_ITEMS.template.md
skills/design-engineering/assets/PROJECT_MEMORY_README.template.md
skills/design-engineering/assets/PROJECT_MEMORY.template.md
skills/design-engineering/assets/OUTPUTS_README.template.md
skills/design-engineering/assets/OUTPUTS_INDEX.template.yml
skills/design-engineering/assets/ARTIFACTS_MANIFEST.template.yml
skills/design-engineering/assets/VISUAL_DESIGN.template.md
skills/design-engineering/assets/REFERENCE_SELECTION.template.md
skills/design-engineering/assets/REFERENCE_SELECTION.color-card-section.template.md
skills/design-engineering/assets/AGENTS.fragment.md
skills/design-engineering/assets/visual-reference-packs/reference-index.md
skills/design-engineering/references/visual-workflow.md
skills/design-engineering/references/reference-library-consumption.md
skills/design-engineering/references/color-card-consumption.md
skills/design-engineering/references/lifecycle-event-id.md
skills/design-engineering/references/project-memory-and-artifacts.md
skills/design-engineering/references/context-bound-final-review.md
skills/design-engineering/references/product-design-events.md
agents/design-state-steward.toml
adapters/claude/CLAUDE.fragment.md
adapters/claude/agents/design-state-steward.md
adapters/cursor/README.md
adapters/cursor/agents/design-state-steward.md
adapters/cursor/rules/design-engineering.mdc
scripts/install-agent-compat.sh
templates/project/docs/design/WORK_ITEMS.md
templates/project/docs/design/VISUAL_DESIGN.md
templates/project/docs/design/project-memory/README.md
templates/project/docs/design/project-memory/BUSINESS_CONTEXT.md
templates/project/docs/design/project-memory/PRODUCT_DESIGN.md
templates/project/docs/design/project-memory/UX_DESIGN.md
templates/project/docs/design/project-memory/VISUAL_DESIGN.md
templates/project/docs/design/project-memory/ENGINEERING_CONTEXT.md
templates/project/docs/design/project-memory/DECISIONS.md
templates/project/docs/design/outputs/README.md
templates/project/docs/design/outputs/index.yml
templates/project/docs/design/outputs/current/index.yml
templates/project/docs/design/outputs/current/.gitkeep
templates/project/docs/design/outputs/archive/.gitkeep
templates/project/docs/design/reference-images/.gitkeep
templates/project/docs/design/reference-library/README.md
templates/project/docs/design/reference-library/product-index.md
templates/project/docs/design/reference-library/product-index.yml
templates/project/docs/design/reference-library/pattern-index.md
templates/project/docs/design/reference-library/pattern-index.yml
templates/project/docs/design/reference-library/assets/color-cards/README.md
templates/project/docs/design/reference-library/assets/color-cards/color-card.schema.yml
templates/project/docs/design/reference-library/assets/color-cards/palette-index.md
templates/project/docs/design/reference-library/assets/color-cards/palette-index.yml
templates/project/docs/design/work-items/REFERENCE_SELECTION.template.md
examples/idea-storm-lab/docs/design/WORK_ITEMS.md
examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md
evals/scenarios/01-no-state-for-context-check.md
evals/scenarios/13-reference-selection-belongs-to-work-item.md
evals/scenarios/14-color-card-registry-integrity.md
evals/scenarios/15-color-card-ready-only-visual-gate.md
evals/scenarios/16-color-card-business-language-confirmation.md
evals/scenarios/17-typography-selection-baseline.md
evals/scenarios/18-lifecycle-event-id-create.md
evals/scenarios/19-legacy-de-id-resume.md
evals/scenarios/20-fast-profile-local-ux.md
evals/scenarios/21-context-bound-final-review.md
evals/scenarios/22-pd-event-project-memory.md
evals/scenarios/23-pd-to-ux-predecessor.md
evals/scenarios/24-outputs-archive-current-index.md
evals/scenarios/25-no-sealed-state-mutation-for-memory.md
examples/lifecycle-memory-lab/docs/design/WORK_ITEMS.md
docs/PRD.md
docs/PRD.reference-library-v0.1.1.md
docs/PRD.v0.1-to-v0.1.1-delta.md
docs/PRD.color-card-registry-v0.1.2.md
docs/PRD.v0.1.1-to-v0.1.2-color-card-registry-delta.md
docs/PRD.lifecycle-memory-v0.1.3.md
docs/product-summary.color-card-registry-version.md
docs/product-summary.lifecycle-memory-version.md
docs/architecture.md
docs/manual-test-guide.md
```

确认 `skills/design-engineering/assets/visual-reference-packs/` 下有 5 个参考包，每个包至少包含 2 张自制 SVG 和 `notes.md`。

确认 `skills/design-engineering/assets/color-cards/` 包含内置 Color Card Registry：`palette-index.yml`、`palette-index.md`、`color-card.schema.yml`、集中式 `images/`、`palettes/`、`annotations/`，并且至少有 3 张 `status: ready` 且 `gate_preview: true` 的可用色卡。

确认 `templates/project/docs/design/reference-library/` 包含产品索引、模式索引、单产品条目、单模式条目、截图素材目录、schema 和 `assets/color-cards/` 注册表结构。`color-cards/` 必须包含 `palette-index.yml`、`palette-index.md`、`color-card.schema.yml`、集中式 `images/`、`palettes/`、`annotations/`。确认 `templates/project/docs/design/project-memory/` 与 `templates/project/docs/design/outputs/` 存在。不得存在 `templates/project/docs/design/reference-library/reference-packs/`、`color-cards/cards/`、`docs/design/product-work-items/` 或项目根目录 `outputs/` 模板。

## 2. 手动安装冒烟测试

优先使用兼容安装脚本测试：

```text
scripts/install-agent-compat.sh cursor /path/to/test-project
scripts/install-agent-compat.sh doctor /path/to/test-project
```

预期：

- `.cursor/design-harness/` 包含 Cursor adapter 和 vendored skill。
- `docs/design/` 包含 Work Items、`VISUAL_DESIGN.md`、Project Memory、Outputs、Reference Library 和 Color Card Registry。
- 若测试项目临时移除 `docs/design/reference-library/assets/color-cards/palette-index.yml` 且目标色卡目录为空或只含 `.gitkeep`，Design Engineering 会从 vendored skill 的 `assets/color-cards/` 安装项目级色卡库，并在 `REFERENCE_SELECTION.md` 记录来源为 `project-installed-from-skill-bundled`。
- 若测试项目的 `color-cards/` 目录已有非 `.gitkeep` 文件但缺少有效 `palette-index.yml`，Design Engineering 不得静默覆盖；本轮只能临时使用 `skill-bundled` 并提示需要明确批准修复。
- doctor 输出不报告缺失文件。

在一次性业务仓库中：

1. 将 `skills/design-engineering/` 复制到 `~/.agents/skills/design-engineering/`。
2. 将 `agents/design-state-steward.toml` 复制到 `.codex/agents/design-state-steward.toml`。
3. 将 `templates/project/AGENTS.fragment.md` 合并进业务项目的 `AGENTS.md`。
4. 将 `templates/project/docs/design/` 复制到 `docs/design/`。
5. 如有参考图片，放入 `docs/design/reference-images/`；长期可复用产品参考放入 `docs/design/reference-library/`，不要放入 Work Item 目录。
6. 开启新的 Codex 会话。

Prompt：

```text
使用 $design-engineering 检查项目上下文，不要修改文件。
```

预期：

- Steward 被显式调用。
- 决定为 `NO_STATE`。
- 不创建 `docs/design/work-items/<id>/STATE.md`。

## 3. 示例一致性

打开 [examples/idea-storm-lab/docs/design/WORK_ITEMS.md](../examples/idea-storm-lab/docs/design/WORK_ITEMS.md)。

检查：

- `DE-001` 位于 Completed。
- `DE-001` 链接到 `DE-001-optimize-frontend-style/STATE.md`。
- `DE-001` 列出 successor `DE-002`。
- `DE-002` 位于 Active。
- `DE-002` 链接到 `DE-002-content-module-line-wrap/STATE.md`。

然后打开两个状态文件和 [examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md](../examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md)。

检查：

- `DE-001` 包含 `status: "completed"` 和 `sealed: true`。
- `DE-001` 展示 Visual Seed、参考解析、已确认配色、已确认设计禁区和视觉原型摘要，且没有为适配新模板而改写 sealed 历史。新字体字号能力由新增评测场景覆盖，不要求改写 sealed 示例历史。
- `DE-002` 的 Work Item 目录中包含 `REFERENCE_SELECTION.md`，并且 `STATE.md` 只记录其链接和摘要。
- `DE-001` 封存后没有被恢复。
- `VISUAL_DESIGN.md` 包含已确认配色、设计禁区、组件语言和示例入口；新项目模板应额外包含可填写的字体字号规范字段。
- `DE-002` 包含 `predecessors: ["DE-001"]`。
- `DE-002` 已读取并遵守 `VISUAL_DESIGN.md`。
- `DE-002` 正等待 `completion-approval`。

## 4. 评测场景

阅读 [evals/scenarios](../evals/scenarios/) 下的全部文件。应共有 25 个场景，每个场景都使用“前提 / 当 / 则”的结构，并与 Skill 和 Steward 使用相同的状态决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

新增视觉场景应覆盖：

- Visual Seed、参考图解析和配色确认。
- 配色确认必须至少有 3 套候选调色盘、同构 UI 样张和可读性/对比说明。
- 用户可以选择候选，也可以直接输入自定义颜色偏好；两种情况都必须记录到 `STATE.md`。
- 字体字号确认必须记录 `typography-selection`，包含字体族、fallback、字号阶梯、行高、字重、用途映射、响应式调整和可读性/授权风险。
- 不要求产品人格表单。
- `VISUAL_DESIGN.md` 创建或更新。

Reference Library 场景应覆盖：

- Web 工作台任务优先使用 `web-app` / `responsive-web` 参考，原生 mobile app 只能作为抽象模式补充。
- Mobile App 任务优先使用 `mobile-app` 参考，Web 表格、侧栏和多列 dashboard 不得直接落地布局。
- Work Item 级参考选择写入 `docs/design/work-items/<id>-<slug>/REFERENCE_SELECTION.md`，不写入 `reference-library/reference-packs/`。
- 用户看到的是业务语义方向，不是产品名选择题。


Color Card Registry 场景应覆盖：

- `images/`、`palettes/`、`annotations/` 中不得存在 orphan 正式资产。
- 只有 `status: ready` 且 `gate_preview: true` 的色卡可进入 `visual-direction-approval`。
- `draft` 与 `deprecated` 不得作为默认用户确认候选。
- 配色确认必须展示大图色卡和业务语义，不得只展示 HEX/RGB 或小 icon。
- Work Item 级色卡采用结果写入 `REFERENCE_SELECTION.md`，`STATE.md` 只写摘要和链接。

Lifecycle Memory 场景应覆盖：

- 新 Work Item 使用 Lifecycle Event ID，legacy `DE-xxx` 不重命名。
- Fast Profile 使用 `mode: lightweight` + `execution_profile: fast`。
- `STATE.md` 记录 Design Contract、Review Lens、outputs 和 Project Memory 更新计划。
- `review.md` 是基于上下文的 final review，不是通用审美 checklist。
- `domain: PD` 产品设计事件可产出 PRD、pricing model、decision map。
- 后续 UX 事件通过 `predecessors` 只读继承 sealed PD 事件。
- `outputs/archive/<event_id>/` 与 `outputs/current/` 边界清楚。
- 不为补 Project Memory 或 `event_id` 修改 sealed 状态。

## 5. 禁止项检查

允许这些词出现在“禁止事项”语境中，但不得作为正向用户流程要求或 Gate enum：

```text
产品人格
品牌气质
用户感受目标
palette-approval
typography-approval
anti-homogeneity
reference-library/reference-packs
color-cards/cards/<id>
docs/design/product-work-items
root outputs/
```

## 6. 完成定义自检

- 文档解释 Thread、Work Item、`STATE.md`、`WORK_ITEMS.md`、Gate、sealed 状态和 `VISUAL_DESIGN.md`。
- Skill frontmatter 是有效 YAML。
- `openai.yaml` 只声明展示元数据和隐式调用策略。
- Steward TOML 包含 `name`、`description` 和 `developer_instructions`。
- 模板使用与 PRD 一致的 `status`、`phase` 和 `gate` 枚举。
- Surface Target 使用 `web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface`，不新增 Gate。
- `STATE.md` 只记录 Reference Selection 摘要和链接，完整分析在 `REFERENCE_SELECTION.md`。
- 色卡目录已升级为 Color Card Registry：包含 `palette-index.yml`，但未预填具体 ready 色卡。
- 配色、字体字号和设计禁区是视觉子步骤，不是新增 Gate。
- 不允许只给 1 套配色让用户确认。
- 不允许用户输入自定义颜色后只口头接受而不写入状态。
- 不允许只写 `font-family` 而不记录字号阶梯、行高、fallback、用途映射和可读性风险。
- Cursor 安装后必须能通过 `scripts/install-agent-compat.sh doctor <project>` 看见 `.cursor/design-harness` 和 `docs/design` 两套位置的状态。
- 示例和评测都与 `DE-001`、`DE-002` 的关系一致。
- Lifecycle Memory 示例包含 UX event、PD event、PD -> UX predecessor、outputs archive/current、Project Memory 和 `review.md`。
- 新增评测 18-25 覆盖 lifecycle id、legacy resume、fast profile、final review、PD、PD to UX、outputs 和 sealed 不可变更。
- 没有安装器、Plugin 包、Hook、CLI、`statectl`、云服务、自动 OCR、自动截图下载或外部运行时依赖。
