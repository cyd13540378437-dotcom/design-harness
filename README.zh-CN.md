# Codex Design Harness

Codex Design Harness 是一套给 Codex 使用的 Human-in-the-loop 设计工程协议：它把重要 UI/UX 工作组织成可恢复、可审计、可由用户批准关闭的 Work Item。

它不是组件库、CLI 或自动化平台。v0.1.0-alpha 交付的是一组可手动复制的 Skill、Agent、模板、示例和评测场景，用来验证真实项目中的任务状态管理闭环。

## 它解决的问题

普通 Codex 对话很容易把“线程”误当作“任务”：换一个 Thread 后，设计方向、批准决定和验收证据可能丢失；任务完成后，后续需求也可能静默改写历史。Design Harness 把状态绑定到 Work Item，而不是绑定到 Thread。

核心约定：

- Thread 是一次 Codex 对话，是临时工作现场。
- Work Item 是可独立验收的产品或设计任务。
- `STATE.md` 是 Work Item 的权威状态快照。
- `WORK_ITEMS.md` 只是索引，冲突时以 `STATE.md` 为准。
- Gate 是必须等用户决定的阶段边界。
- `completed + sealed` 的状态只能只读引用，后续工作必须创建 Successor。

## 架构

```text
AGENTS.md 项目规则
        ↓
design-engineering Skill
        ↓
design_state_steward Agent
        ↓
docs/design/work-items/<ID-slug>/STATE.md
        ↓
用户 Gate、实现、验证、封存
```

更多结构说明见 [docs/architecture.md](docs/architecture.md)。

## 五种状态解析结果

`design_state_steward` 在状态解析阶段只能返回：

- `CREATE`：创建新的独立 Work Item。
- `RESUME`：恢复一个未封存 Work Item。
- `SUCCESSOR`：引用已封存前任，并创建新的后继 Work Item。
- `NO_STATE`：当前请求不值得持久化状态，例如只读上下文检查。
- `AMBIGUOUS`：存在多个合理候选，必须停下请用户选择。

## Human-in-the-loop 工作流

`design-engineering` 负责流程编排，`design_state_steward` 负责状态读写。典型 Full Mode 流程：

1. 解析 Work Item 归属。
2. 理解业务目标和约束。
3. 在 `visual-direction-approval` Gate 前写入等待状态。
4. 获得用户批准后再进入静态原型。
5. 在 `prototype-approval` Gate 前写入检查点并等待。
6. 处理高影响 UX 交互问题，必要时进入 `interaction-decision` Gate。
7. 按已批准方向生产实现。
8. 用浏览器或可替代证据完成 QA。
9. 在 `completion-approval` Gate 展示证据，等待用户明确关闭。
10. 用户批准后，Steward 才能写入 `status: completed` 与 `sealed: true`。

Lightweight Mode 可跳过视觉方向和原型 Gate；Delegated Mode 可让 Codex 自动处理普通设计细节。但任务封存仍必须由用户明确批准。

## 手动安装

v0.1 只提供手动方式，不包含安装器。

1. 将 [skills/design-engineering](skills/design-engineering/) 复制到用户级 Skill 目录：

   ```text
   ~/.agents/skills/design-engineering/
   ```

   Windows PowerShell 通常对应：

   ```text
   $HOME\.agents\skills\design-engineering\
   ```

2. 将 [agents/design-state-steward.toml](agents/design-state-steward.toml) 复制到目标项目：

   ```text
   .codex/agents/design-state-steward.toml
   ```

3. 将 [templates/project/AGENTS.fragment.md](templates/project/AGENTS.fragment.md) 合并进目标项目根目录的 `AGENTS.md`。不要覆盖用户已有内容。

4. 将 [templates/project/docs/design](templates/project/docs/design/) 复制到目标项目的 `docs/design/`。

5. 开启新的 Codex 会话，用只读 Prompt 验证：

   ```text
   使用 $design-engineering 检查项目上下文，不要修改文件。
   ```

   预期结果是 Steward 返回 `NO_STATE`，且不创建 Work Item。

## 项目初始化后的结构

```text
product-repository/
├── AGENTS.md
├── .codex/
│   └── agents/
│       └── design-state-steward.toml
└── docs/
    └── design/
        ├── WORK_ITEMS.md
        └── work-items/
            └── DE-001-example/
                └── STATE.md
```

## 完整示例

[examples/idea-storm-lab](examples/idea-storm-lab/) 展示三个连续请求：

1. “检查项目上下文”返回 `NO_STATE`。
2. “优化前端样式”创建 `DE-001`，完成视觉方向、原型、实现、QA 和用户关闭批准，最终 `completed + sealed`。
3. “统一内容模块问题长度换行”与 `DE-001` 相关，但因为前任已封存，所以创建 `DE-002` successor，并停在 `completion-approval`。

## 跨 Thread 恢复

新 Thread 不等于新任务。Codex 应读取 `docs/design/WORK_ITEMS.md` 和语义相关的 `STATE.md`，再显式调用 `design_state_steward`。如果用户说“继续上次前端样式任务，我批准原型”，且 `DE-001` 未封存，Steward 应返回 `RESUME` 并记录 Gate 批准。

## 并行任务

同一项目可以同时存在多个 active Work Item。`WORK_ITEMS.md` 同时列出它们，但每个 Work Item 仍只能有一个权威 `STATE.md`。当用户请求含糊，例如“继续之前的界面改动”，且有多个合理候选时，必须返回 `AMBIGUOUS`，不写状态，等待用户选择。

## 封存后的后续需求

封存状态：

```yaml
status: completed
sealed: true
```

不得恢复为 active，也不得继续追加实现阶段。新的相关需求应创建 `SUCCESSOR`，并在新状态的 `predecessors` 中引用旧 Work Item。

## 当前限制

- 没有自动安装器、CLI、Hook、Codex Plugin 或 Marketplace 分发。
- 没有 `statectl`、Schema 校验脚本或自动索引生成器。
- 没有并发写锁；写入前需要重新读取索引和状态。
- 不自动读取全部历史对话。
- 浏览器验证是推荐流程，不绑定特定工具。

## v0.1 路线图

本仓库的 v0.1.0-alpha 范围是文档型、可手动复用、可真实试运行的协议闭环。后续版本计划见 [CHANGELOG.md](CHANGELOG.md) 和 [docs/PRD.md](docs/PRD.md) 的路线图。

## 官方 Codex 机制参考

- [Agent Skills](https://developers.openai.com/codex/skills)
- [Subagents](https://developers.openai.com/codex/subagents)
- [AGENTS.md](https://developers.openai.com/codex/guides/agents-md)

