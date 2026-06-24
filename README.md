# Codex Design Harness

Codex Design Harness 是一套给 Codex 使用的人参与设计工程协议。它把重要 UI/UX 工作组织成可恢复、可审计、需要用户明确批准 Gate 的 Work Item，并在完成后写入 sealed 状态。

v0.1.0-alpha 刻意保持手动和文档型：不包含安装器、CLI、Hook、Plugin 打包、云服务或运行时依赖。本仓库提供 Skill、Steward Agent、模板、示例和人工评测场景，方便在真实项目中试运行。

## 核心模型

```text
项目 AGENTS.md
        ↓
design-engineering Skill
        ↓
design_state_steward Agent
        ↓
Work Item STATE.md
        ↓
Human Gate、实现、QA、封存
```

- Thread 是临时 Codex 对话，不是任务身份。
- Work Item 是可独立验收的产品或设计任务。
- `STATE.md` 是单个 Work Item 的权威状态快照。
- `WORK_ITEMS.md` 是导航索引；若与 `STATE.md` 冲突，以 `STATE.md` 为准。
- Gate 是 Codex 必须等待用户决定的阶段边界。
- `completed + sealed` 是只读历史记录；后续相关工作必须创建 Successor。

完整中文指南见 [README.zh-CN.md](README.zh-CN.md)，系统结构见 [docs/architecture.md](docs/architecture.md)。

## 状态解析

`design_state_steward` 在绑定任务时只能返回五种决定：

- `CREATE`：创建新的独立 Work Item。
- `RESUME`：继续未封存的 active 或 paused Work Item。
- `SUCCESSOR`：创建新的 Work Item，并引用已封存前任。
- `NO_STATE`：只读或极小一次性工作，不持久化状态。
- `AMBIGUOUS`：停止并请用户在候选项中选择。

## 工作流

`design-engineering` 负责编排设计流程。它必须在状态化设计任务开始前、每个 Gate 检查点前、Gate 回复后、任务切换前、关闭检查前和封存前显式调用 `design_state_steward`。

Full Mode 使用这些 Gate：

1. `visual-direction-approval`
2. `prototype-approval`
3. `interaction-decision`，仅用于高影响 UX 分歧
4. `completion-approval`

Lightweight Mode 可为小范围修改跳过视觉方向和原型 Gate。Delegated Mode 可让 Codex 自行处理普通细节，但封存仍需要用户明确批准。

## 手动安装

1. 将 [skills/design-engineering](skills/design-engineering/) 复制到：

   ```text
   ~/.agents/skills/design-engineering/
   ```

2. 将 [agents/design-state-steward.toml](agents/design-state-steward.toml) 复制到目标项目：

   ```text
   .codex/agents/design-state-steward.toml
   ```

3. 将 [templates/project/AGENTS.fragment.md](templates/project/AGENTS.fragment.md) 合并进目标项目根目录 `AGENTS.md`。不要直接覆盖已有文件。

4. 将 [templates/project/docs/design](templates/project/docs/design/) 复制到目标项目。

5. 开启新的 Codex 会话并运行：

   ```text
   使用 $design-engineering 检查项目上下文，不要修改文件。
   ```

   预期结果：返回 `NO_STATE`，且不创建 Work Item 目录。

## 示例

[examples/idea-storm-lab](examples/idea-storm-lab/) 展示 PRD 要求的三个请求：

- “检查项目上下文”返回 `NO_STATE`。
- “优化前端样式”创建并封存 `DE-001`。
- “统一内容模块问题长度换行”创建 successor `DE-002`，并引用已封存的 `DE-001`。

## 评测

人工“前提 / 当 / 则”场景位于 [evals/scenarios](evals/scenarios/)。它们覆盖上下文检查、创建、跨 Thread 恢复、创建 Successor、并行 Work Items、模糊绑定以及关闭封存。

## 当前限制

- 没有安装器、Plugin、Marketplace 包、Hook、CLI、`statectl`、云服务或外部运行时依赖。
- 没有确定性 Schema 校验器或自动索引生成器。
- 没有多用户写锁。
- 浏览器 QA 是推荐流程，v0.1 不绑定特定工具。

## 许可证

MIT。见 [LICENSE](LICENSE)。
