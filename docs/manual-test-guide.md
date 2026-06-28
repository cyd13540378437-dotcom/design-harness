# 手动测试指南

使用本指南验证 v0.1.0-alpha / visual-workflow revision 仓库，不需要安装任何运行时依赖。

## 1. 文件结构

确认文档要求的文件存在：

```text
README.md
README.zh-CN.md
CHANGELOG.md
LICENSE
AGENTS.md
skills/design-engineering/SKILL.md
skills/design-engineering/agents/openai.yaml
skills/design-engineering/assets/STATE.template.md
skills/design-engineering/assets/WORK_ITEMS.template.md
skills/design-engineering/assets/VISUAL_DESIGN.template.md
skills/design-engineering/assets/AGENTS.fragment.md
skills/design-engineering/assets/visual-reference-packs/reference-index.md
skills/design-engineering/references/visual-workflow.md
agents/design-state-steward.toml
templates/project/docs/design/WORK_ITEMS.md
templates/project/docs/design/VISUAL_DESIGN.md
templates/project/docs/design/reference-images/.gitkeep
examples/idea-storm-lab/docs/design/WORK_ITEMS.md
examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md
evals/scenarios/01-no-state-for-context-check.md
evals/scenarios/10-visual-design-document.md
docs/PRD.md
docs/architecture.md
docs/manual-test-guide.md
```

确认 `skills/design-engineering/assets/visual-reference-packs/` 下有 5 个参考包，每个包至少包含 2 张自制 SVG 和 `notes.md`。

## 2. 手动安装冒烟测试

在一次性业务仓库中：

1. 将 `skills/design-engineering/` 复制到 `~/.agents/skills/design-engineering/`。
2. 将 `agents/design-state-steward.toml` 复制到 `.codex/agents/design-state-steward.toml`。
3. 将 `templates/project/AGENTS.fragment.md` 合并进业务项目的 `AGENTS.md`。
4. 将 `templates/project/docs/design/` 复制到 `docs/design/`。
5. 如有参考图片，放入 `docs/design/reference-images/`。
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
- `DE-001` 展示 Visual Seed、参考解析、已确认配色、已确认设计禁区和视觉原型摘要。
- `DE-001` 封存后没有被恢复。
- `VISUAL_DESIGN.md` 包含已确认配色、设计禁区、组件语言和示例入口。
- `DE-002` 包含 `predecessors: ["DE-001"]`。
- `DE-002` 已读取并遵守 `VISUAL_DESIGN.md`。
- `DE-002` 正等待 `completion-approval`。

## 4. 评测场景

阅读 [evals/scenarios](../evals/scenarios/) 下的全部文件。应共有 10 个场景，每个场景都使用“前提 / 当 / 则”的结构，并与 Skill 和 Steward 使用相同的状态决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

新增视觉场景应覆盖：

- Visual Seed、参考图解析和配色确认。
- 配色确认必须至少有 3 套候选调色盘、同构 UI 样张和可读性/对比说明。
- 用户可以选择候选，也可以直接输入自定义颜色偏好；两种情况都必须记录到 `STATE.md`。
- 不要求产品人格表单。
- `VISUAL_DESIGN.md` 创建或更新。

## 5. 禁止项检查

允许这些词出现在“禁止事项”语境中，但不得作为正向用户流程要求或 Gate enum：

```text
产品人格
品牌气质
用户感受目标
palette-approval
anti-homogeneity
```

## 6. 完成定义自检

- 文档解释 Thread、Work Item、`STATE.md`、`WORK_ITEMS.md`、Gate、sealed 状态和 `VISUAL_DESIGN.md`。
- Skill frontmatter 是有效 YAML。
- `openai.yaml` 只声明展示元数据和隐式调用策略。
- Steward TOML 包含 `name`、`description` 和 `developer_instructions`。
- 模板使用与 PRD 一致的 `status`、`phase` 和 `gate` 枚举。
- 配色和设计禁区是视觉子步骤，不是新增 Gate。
- 不允许只给 1 套配色让用户确认。
- 不允许用户输入自定义颜色后只口头接受而不写入状态。
- 示例和评测都与 `DE-001`、`DE-002` 的关系一致。
- 没有安装器、Plugin 包、Hook、CLI、`statectl`、云服务或外部运行时依赖。
