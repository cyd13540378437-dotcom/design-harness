# 手动测试指南

使用本指南验证 v0.1.0-alpha 仓库，不需要安装任何运行时依赖。

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
skills/design-engineering/assets/AGENTS.fragment.md
agents/design-state-steward.toml
templates/project/docs/design/WORK_ITEMS.md
examples/idea-storm-lab/docs/design/WORK_ITEMS.md
evals/scenarios/01-no-state-for-context-check.md
docs/PRD.md
docs/architecture.md
docs/manual-test-guide.md
```

## 2. 手动安装冒烟测试

在一次性业务仓库中：

1. 将 `skills/design-engineering/` 复制到 `~/.agents/skills/design-engineering/`。
2. 将 `agents/design-state-steward.toml` 复制到 `.codex/agents/design-state-steward.toml`。
3. 将 `templates/project/AGENTS.fragment.md` 合并进业务项目的 `AGENTS.md`。
4. 将 `templates/project/docs/design/` 复制到 `docs/design/`。
5. 开启新的 Codex 会话。

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

然后打开两个状态文件。

检查：

- `DE-001` 包含 `status: "completed"` 和 `sealed: true`。
- `DE-001` 封存后没有被恢复。
- `DE-002` 包含 `predecessors: ["DE-001"]`。
- `DE-002` 正等待 `completion-approval`。

## 4. 评测场景

阅读 [evals/scenarios](../evals/scenarios/) 下的全部文件。每个场景都应使用“前提 / 当 / 则”的结构，并与 Skill 和 Steward 使用相同的状态决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

## 5. 完成定义自检

- 文档解释 Thread、Work Item、`STATE.md`、`WORK_ITEMS.md`、Gate 和 sealed 状态。
- Skill frontmatter 是有效 YAML。
- `openai.yaml` 只声明展示元数据和隐式调用策略。
- Steward TOML 包含 `name`、`description` 和 `developer_instructions`。
- 模板使用与 PRD 一致的 `status`、`phase` 和 `gate` 枚举。
- 示例和评测都与 `DE-001`、`DE-002` 的关系一致。
- 没有安装器、Plugin 包、Hook、CLI、`statectl`、云服务或外部运行时依赖。
