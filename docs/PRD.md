# Codex Design Harness — 产品需求文档

- **版本**：v0.1.0-alpha
- **文档状态**：可执行草案
- **目标仓库名**：`codex-design-harness`
- **产品显示名**：Design Engineering Harness
- **主要语言**：简体中文；配置字段、状态枚举和文件名使用英文
- **发布日期目标**：完成首个可手动复用、可真实试运行的 GitHub 仓库

---

## 1. 产品摘要

Codex Design Harness 是一套面向 Codex 的 **Human-in-the-loop 产品设计工作流**。

它把一次普通的 UI/UX 开发请求，组织为可恢复、可审计、有人类审批门槛的任务生命周期：

```text
识别当前工作任务
→ 理解业务与设计目标
→ 确认视觉方向
→ 输出静态原型
→ 确认关键 UX 决策
→ 生产实现
→ 浏览器与规范验收
→ 请求用户确认关闭
→ 封存任务状态
```

本产品不是新的 UI 组件库，也不是单纯的长 Prompt。它由以下核心构件组成：

```text
AGENTS.md 规则片段
        ↓
design-engineering Skill
        ↓
design_state_steward 自定义 Agent
        ↓
Work Item + STATE.md
        ↓
用户 Gate + 实现与验收
```

其中：

- **Codex 对话线程**是临时工作现场；
- **Work Item** 是可独立验收的产品或设计任务；
- **`STATE.md`** 是该 Work Item 的权威状态快照；
- **`design-engineering`** 负责编排设计流程；
- **`design_state_steward`** 负责状态解析、更新、关闭检查和封存；
- **用户**保留目标解释权、重大决策权、纠偏权和最终关闭权。

---

## 2. 背景与问题

使用 Codex 开发产品时，常见问题包括：

1. 新对话无法稳定恢复之前已经确认的设计方向和业务决定；
2. 对话线程被误当成任务边界，同一个任务可能产生多份互相冲突的记忆；
3. 相近的新需求可能被错误并入已完成任务，或反过来重复创建任务；
4. Codex 容易先完成高成本实现，再让用户被动“确认”；
5. 关键交互存在歧义时，Codex 可能自行决定并形成产品行为；
6. “代码完成”常被误认为“产品任务完成”；
7. 用户无法清楚知道一个任务当前位于哪个阶段、等待什么决定；
8. 已完成任务缺少封存语义，后续对话可能静默改写历史结论。

现有 Prompt、Skill 和 `AGENTS.md` 可以提供流程指令，但单独使用时仍缺少：

- 明确的任务身份；
- 跨线程状态恢复；
- 生命周期与 Gate；
- 已批准决定的持久记录；
- 完成后的只读封存；
- 新任务与前任任务的关系表达。

---

## 3. 产品愿景

让 Codex 从“接到需求就写代码的执行者”，升级为一个遵循产品开发协议的设计工程协作者：

> AI 负责理解、比较、生成、实现和验证；人负责目标、偏好、高影响决策与最终责任。

长期愿景是形成可安装的 Codex Plugin；但 v0.1 只验证工作流本体和状态模型。

---

## 4. v0.1 目标

### 4.1 核心目标

v0.1 必须实现：

1. 一个可被 Codex 识别和调用的 `design-engineering` Skill；
2. 一个项目级 `design_state_steward` 自定义 Agent；
3. 每个独立 Work Item 拥有一个权威 `STATE.md`；
4. 在任务开始时解析 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`；
5. 在视觉方向、静态原型、关键交互和任务关闭处提供 Human Gate；
6. 支持不同 Codex 对话继续同一个 Work Item；
7. 支持同一项目中多个 Work Item 并行存在；
8. `completed + sealed` 的状态不可恢复执行，只能只读引用；
9. 用户明确批准后才可关闭并封存任务；
10. 提供完整 README、模板、真实示例和人工评测场景。

### 4.2 成功标准

一个没有参与本产品设计的人应能够：

- 阅读中文 README 理解核心概念；
- 在 10 分钟内手动把 Skill 和 Agent 复制到 Codex 环境；
- 在任意 Git 项目中初始化状态目录；
- 通过示例理解什么时候创建、恢复、继任或不创建状态；
- 用两个不同 Codex 对话继续同一个任务；
- 验证封存任务不会被重新激活；
- 不需要阅读本 PRD 也能正确使用仓库。

---

## 5. v0.1 非目标

以下内容明确不属于 v0.1：

- 自动安装器；
- Codex Plugin 和 Marketplace 发布；
- CLI；
- Hook；
- `statectl.py` 或确定性状态机脚本；
- 云端数据库或同步服务；
- 多用户并发锁；
- GitHub Issues、Linear、Jira 集成；
- 自动读取或索引全部 Codex 对话；
- 完整项目管理系统；
- 自研 UI 组件库；
- 打包或复制第三方 Skill；
- 版本级聚合状态机。

v0.1 可以在 `STATE.md` 中记录 `release` 字段，但不为每个 Release 创建独立状态树。

---

## 6. 目标用户

### 6.1 主要用户

- 使用 Codex 独立开发产品的创作者；
- 同时承担产品、UX、UI 和前端工作的个人开发者；
- 希望不同 Codex 对话共享可靠任务记忆的用户；
- 希望 AI 在关键节点主动请求确认，而不是擅自做产品决定的用户。

### 6.2 次要用户

- 使用 Codex 的小型产品团队；
- 希望将设计流程沉淀为仓库规则的团队；
- 希望研究 Agent 工作流、状态管理和 Human-in-the-loop 的开发者。

---

## 7. 核心概念

### 7.1 Thread

Codex 的一次对话或工作线程，是临时交互现场，不是任务身份。

一个 Thread 可以：

- 继续一个已有 Work Item；
- 创建一个新 Work Item；
- 在用户确认后切换到另一个 Work Item；
- 只做探索而不创建状态。

同一个 Work Item 可以跨越多个 Thread。

### 7.2 Work Item

Work Item 是具有以下特征的独立工作流实例：

- 独立业务目标；
- 清晰范围；
- 可验证的验收标准；
- 一个或多个设计 Gate；
- 明确结束条件；
- 可独立关闭和封存。

Work Item 不等于版本，也不等于对话。

### 7.3 `STATE.md`

`STATE.md` 是某个 Work Item 的：

```text
当前状态快照
+ 当前 Gate
+ 已批准决定摘要
+ 待确认问题
+ 重要假设
+ 验收标准
+ 验证证据
+ 下一步行动
+ 相关任务链接
```

它是 **有损上下文压缩文件**，不是完整聊天记录，也不是无限追加的日志。

它类似“游戏存档”，而不是“游戏录像”。

### 7.4 `WORK_ITEMS.md`

`WORK_ITEMS.md` 是项目中的导航索引和缓存，不是最终权威来源。

若索引与各 Work Item 的 `STATE.md` 冲突：

> `STATE.md` 为准，`design_state_steward` 应修复索引。

### 7.5 Gate

Gate 是工作流必须等待人类决定的阶段边界。

v0.1 支持：

- `work-item-binding`：仅在任务归属不明确时；
- `visual-direction-approval`；
- `prototype-approval`；
- `interaction-decision`；
- `completion-approval`。

### 7.6 Sealed State

当 Work Item 完成并由用户批准关闭后：

```yaml
status: completed
sealed: true
```

该状态：

- 不得恢复为 active；
- 不得继续追加新的实现阶段；
- 不得静默改写已批准决定；
- 可以只读检索和引用；
- 可以成为新 Work Item 的 predecessor。

任何后续工作必须创建 `SUCCESSOR`。

---

## 8. 产品原则

### 8.1 状态属于任务，不属于对话

不得因为开启了新 Thread 就创建新 `STATE.md`。

### 8.2 人参与，但不被琐碎问题淹没

只在高影响、互斥、难以撤销或定义产品语义的问题上询问用户。

### 8.3 AI 必须先做决策压缩

提问前应：

- 给出当前理解；
- 解释为什么重要；
- 提供 2–3 个可行选项；
- 说明影响；
- 给出推荐方案。

### 8.4 高成本实现之前确认

视觉方向和核心页面结构应在生产实现前确认。

### 8.5 状态可审计、可恢复、最小化

状态文件只保存恢复工作所需的最小权威上下文。

### 8.6 关闭权属于用户

Codex 可以判断“达到关闭条件”，但不能单方面宣布 Work Item 已封存。

### 8.7 历史不可被静默重写

已封存 Work Item 的后续变化必须通过 Successor 表达。

---

## 9. 工作模式

### 9.1 Full Mode

适用于：

- 新产品；
- 新页面或重要模块；
- 跨页面流程；
- 大规模 UI/UX 重构；
- 未明确视觉方向；
- 存在显著产品交互歧义。

默认执行所有适用 Gate。

### 9.2 Lightweight Mode

适用于：

- 小型组件修改；
- 已有设计系统内的局部功能；
- 明确参考页面下的轻量改造；
- 不改变信息架构的 UI 修复。

可以跳过视觉方向和原型 Gate，但有状态的任务仍必须经过完成 Gate。

### 9.3 Delegated Mode

当用户明确说“你自己决定”“直接完成”“普通问题不用问我”时启用。

可以自动通过普通视觉与原型决策，但以下问题仍必须确认：

- 权限；
- 数据删除或覆盖；
- 隐私；
- 付费或额度；
- 不可逆操作；
- 会改变产品核心语义的互斥流程。

v0.1 中，**任务封存仍必须在展示完成证据后获得明确用户批准**。

---

## 10. Work Item 解析协议

`design_state_steward` 在状态解析阶段只能返回以下五种结果。

### 10.1 `CREATE`

当前需求是新的独立 Work Item。

触发条件包括：

- 新目标拥有独立验收标准；
- 新目标不属于任何活动 Work Item 的既定范围；
- 与已有任务相关，但不依赖它继续处于活动状态；
- 用户明确要求作为新任务处理。

行为：

- 创建新目录和 `STATE.md`；
- 分配唯一 ID；
- 更新 `WORK_ITEMS.md`；
- 将其绑定为当前工作流。

### 10.2 `RESUME`

当前请求明确属于一个未封存 Work Item。

可恢复状态：

- `active`；
- `paused`；
- 等待用户的 active 状态。

不得对 `completed + sealed` 返回 `RESUME`。

### 10.3 `SUCCESSOR`

当前请求与一个或多个封存任务相关，但应创建新的工作流实例。

行为：

- 创建新 Work Item；
- 在新状态中记录 `predecessors`；
- 旧状态保持只读；
- 更新索引中的关系。

### 10.4 `NO_STATE`

当前请求不需要持久工作流状态。

常见情况：

- 只读检查项目上下文；
- 解释代码；
- 临时研究；
- 极小且一次性的无风险调整；
- 不涉及 UI/UX 工作流的任务。

不得为了“流程完整”而创建无价值状态。

### 10.5 `AMBIGUOUS`

存在多个合理状态或无法确定新旧任务边界。

行为：

- 不创建状态；
- 不修改候选状态；
- 向用户列出候选项；
- 给出推荐；
- 停止并等待用户选择。

---

## 11. 任务切换协议

当一个 Thread 已绑定活动 Work Item，用户又提出明显不同的新需求时，系统不得静默放弃当前任务。

必须判断并提供以下选项中的适用项：

1. 将新需求作为当前 Work Item 的剩余范围；
2. 暂停当前 Work Item，并创建新 Work Item；
3. 当前 Work Item 已达到验收条件，先进入完成确认；
4. 把剩余事项拆为 Successor；
5. 用户明确指定其他处理方式。

未达到完成条件时，不得仅为了切换任务而将当前 Work Item 标记为 completed。

---

## 12. 设计工程工作流

### 阶段 0：状态解析

1. 读取项目 `AGENTS.md`；
2. 读取 `docs/design/WORK_ITEMS.md`；
3. 读取语义相关的活动或封存状态；
4. 显式调用 `design_state_steward`；
5. 获得五类结果之一；
6. 若为 `AMBIGUOUS`，请求用户决定并停止。

### 阶段 1：业务理解与视觉方向

形成：

- 目标用户；
- 核心任务；
- 成功标准；
- 业务约束；
- 技术约束；
- 未解决问题。

Full Mode 下提出 2–3 个明显不同但均合理的视觉方向，并给出推荐。

#### Gate：`visual-direction-approval`

获得用户明确选择前：

- 不得开始生产实现；
- 不得将推荐方案视为批准；
- 必须先更新 `STATE.md` 为等待用户状态。

### 阶段 2：静态原型

优先方式：

1. 现有 Storybook；
2. 隔离的预览路由；
3. 独立 HTML/CSS 原型；
4. 无法运行页面时才使用静态图。

原型用于验证：

- 页面结构；
- 信息层级；
- 内容密度；
- 核心组件；
- 视觉气质；
- 关键响应式表现。

#### Gate：`prototype-approval`

展示入口或截图、待检查重点、未实现内容和风险，然后停止等待。

### 阶段 3：UX 流程与关键交互

至少考虑：

- 入口与完成路径；
- 返回与取消；
- 加载、空、错误、权限不足；
- 首次使用；
- 网络失败；
- 长内容和极端数据；
- 键盘操作；
- 移动端；
- 破坏性操作；
- 成功后的反馈。

#### Gate：`interaction-decision`

只有会显著改变产品行为的问题才中断用户。

### 阶段 4：生产实现

以批准后的状态和原型为准：

- 复用现有组件和设计令牌；
- 不创建平行设计系统；
- 不静默偏离批准方向；
- 实现完整状态；
- 处理响应式与无障碍；
- 新的高影响歧义必须重新进入 Gate。

若检测到 `ui-design` Skill，可作为增强能力使用；没有时不得阻塞核心流程。

### 阶段 5：审查与验证

优先使用真实浏览器验证：

- 桌面端建议 `1440 × 900`；
- 移动端建议 `390 × 844`；
- 重要项目可增加 `768 × 1024`。

验证内容：

- 信息层级；
- 对齐和间距；
- 字体与可读性；
- 溢出和长文本；
- 响应式重排；
- 焦点和键盘；
- 各类交互状态；
- 与已批准原型的一致性。

Playwright 是优先工具，但 v0.1 不强制依赖特定浏览器工具。无法完成真实浏览器验证时，应在状态中记录 blocker，不得伪称已完成视觉验收。

若检测到 `web-design-guidelines` Skill，可作为增强审查能力使用；没有时不得阻塞核心流程。

### 阶段 6：完成确认

当实现与验证满足验收标准后：

```yaml
phase: completion-review
gate: completion-approval
awaiting_user: true
```

Codex 必须展示：

- 已完成内容；
- 验收标准逐项结果；
- 浏览器或其他验证证据；
- 仍存在的限制；
- 建议关闭、继续、暂停或拆分 Successor。

#### Gate：`completion-approval`

用户可回复：

- `关闭`；
- `继续调整……`；
- `暂停`；
- `关闭当前任务，并把……创建为后继任务`。

只有明确批准关闭后才可封存。

---

## 13. 状态生命周期

```text
active
  ├── paused ──→ active
  ├── active + awaiting_user
  ├── completion-review
  │      ├── 用户要求继续 ──→ active
  │      ├── 用户要求暂停 ──→ paused
  │      └── 用户批准关闭 ──→ completed + sealed
  └── 用户取消 ──→ cancelled + sealed
```

### 13.1 状态字段

`status`：

- `active`
- `paused`
- `completed`
- `cancelled`

`phase`：

- `intake`
- `discovery`
- `visual-direction`
- `prototype`
- `ux-flow`
- `implementation`
- `qa`
- `completion-review`
- `complete`

`gate`：

- `none`
- `work-item-binding`
- `visual-direction-approval`
- `prototype-approval`
- `interaction-decision`
- `completion-approval`

### 13.2 封存规则

当 `sealed: true`：

- 禁止变更 status、phase、gate、验收标准和批准决定；
- 只允许只读引用；
- 后续实现必须创建 Successor；
- v0.1 不提供 unseal 功能。

---

## 14. `STATE.md` Schema

模板必须至少包含：

```yaml
---
schema_version: 1
state_id: "DE-001"
title: "优化前端样式"
slug: "optimize-frontend-style"
scope_type: "work-item"
release: ""

status: "active"
phase: "discovery"
gate: "none"
awaiting_user: false
sealed: false

mode: "full"
predecessors: []
related_items: []
approved_gates: []

created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""
---
```

正文必须包含：

```markdown
# Work Item State

## 任务摘要
## 范围
### 包含
### 不包含
## 验收标准
## 当前检查点
## 已批准决定
## 待确认问题
## 工作假设
## 产物与链接
## 验证证据
## 下一步行动
## 关键状态变更摘要
```

### 14.1 压缩规则

- 不复制完整对话；
- 不记录每个微小操作；
- 使用当前事实替换已失效的中间描述；
- 保留会影响后续工作的批准决定；
- 保留未解决问题与 blocker；
- 保留简短的关键状态变更摘要；
- 详细历史由 Git 和原对话承担。

建议单个 `STATE.md` 保持在约 200 行以内；超过时应压缩，而非无限追加。

---

## 15. 项目目录结构

目标 GitHub 仓库：

```text
codex-design-harness/
├── README.md
├── README.zh-CN.md
├── CHANGELOG.md
├── LICENSE
├── AGENTS.md
│
├── skills/
│   └── design-engineering/
│       ├── SKILL.md
│       ├── agents/
│       │   └── openai.yaml
│       ├── assets/
│       │   ├── STATE.template.md
│       │   ├── WORK_ITEMS.template.md
│       │   └── AGENTS.fragment.md
│       └── references/
│           ├── workflow-model.md
│           ├── human-in-the-loop.md
│           ├── state-lifecycle.md
│           └── state-resolution.md
│
├── agents/
│   └── design-state-steward.toml
│
├── templates/
│   └── project/
│       ├── AGENTS.fragment.md
│       └── docs/
│           └── design/
│               ├── WORK_ITEMS.md
│               └── work-items/
│                   └── .gitkeep
│
├── examples/
│   └── idea-storm-lab/
│       ├── README.md
│       └── docs/
│           └── design/
│               ├── WORK_ITEMS.md
│               └── work-items/
│                   ├── DE-001-optimize-frontend-style/
│                   │   └── STATE.md
│                   └── DE-002-content-module-line-wrap/
│                       └── STATE.md
│
├── evals/
│   └── scenarios/
│       ├── 01-no-state-for-context-check.md
│       ├── 02-create-new-work-item.md
│       ├── 03-resume-across-thread.md
│       ├── 04-create-successor.md
│       ├── 05-parallel-work-items.md
│       ├── 06-ambiguous-binding.md
│       └── 07-close-and-seal.md
│
└── docs/
    ├── PRD.md
    ├── architecture.md
    └── manual-test-guide.md
```

目标业务项目初始化后的结构：

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

---

## 16. `design-engineering` Skill 要求

### 16.1 元数据

`SKILL.md` frontmatter：

```yaml
---
name: design-engineering
description: 对新产品界面、重要功能页面、跨页面用户流程和显著 UI/UX 改造执行人参与的设计工程工作流。负责识别或恢复 Work Item，经过视觉方向、原型、关键交互与完成确认 Gate，并在跨 Codex 对话中通过 STATE.md 恢复状态。适用于有人参与的 UX 探索、原型、实现、状态恢复和完成批准。
---
```

### 16.2 必须行为

Skill 必须明确要求父 Agent：

1. 开始状态化设计任务时显式 spawn `design_state_steward`；
2. 不自行伪造状态解析结果；
3. 每个 Gate 之前先让 Steward 写入检查点；
4. 用户回复 Gate 后先更新状态再继续；
5. 任务切换前执行状态解析；
6. 关闭前执行 closure readiness 检查；
7. 用户批准后才执行 seal；
8. Steward 结果与用户当前回复冲突时，以用户当前回复为准并更新状态；
9. 不让多个 Agent 同时写同一个状态文件；
10. 没有状态价值的小任务使用 `NO_STATE`。

### 16.3 `openai.yaml`

必须创建：

```yaml
interface:
  display_name: "Design Engineering"
  short_description: "交互式 UX 探索、任务状态恢复、原型确认、实现与视觉验收"
  default_prompt: "使用 $design-engineering 推进当前产品设计任务。先解析或恢复 Work Item，再按适用的 Human Gate 完成设计、实现、验证和关闭确认。"

policy:
  allow_implicit_invocation: true
```

v0.1 不声明 MCP 依赖。

---

## 17. `design_state_steward` Agent 要求

### 17.1 文件位置

仓库源文件：

```text
agents/design-state-steward.toml
```

用户手动使用时复制到项目：

```text
.codex/agents/design-state-steward.toml
```

### 17.2 Agent Schema

必须定义：

```toml
name = "design_state_steward"
description = "..."
developer_instructions = """..."""
```

不在 v0.1 中固定 model，让它继承父会话配置。

### 17.3 职责边界

Agent 只负责：

- 解析当前请求应绑定哪个 Work Item；
- 返回五种解析结果之一；
- 创建或更新 `STATE.md`；
- 更新 `WORK_ITEMS.md`；
- 在 Gate 前写入等待状态；
- 在用户回复后记录批准决定；
- 检查 closure readiness；
- 在用户批准后封存状态；
- 发现索引与状态冲突时，以状态为准修复索引。

Agent 不得：

- 实现业务代码；
- 设计页面；
- 代替用户通过 Gate；
- 修改 sealed 状态；
- 将完整聊天内容写入状态；
- 在 `AMBIGUOUS` 时自行选择；
- 同时管理多个不相关 Work Item 的内容更新。

### 17.4 返回格式

状态解析时返回：

```yaml
decision: CREATE | RESUME | SUCCESSOR | NO_STATE | AMBIGUOUS
current_state: ""
new_state: ""
candidates: []
reason: ""
user_question: ""
recommended_action: ""
```

关闭检查时返回：

```yaml
ready_to_close: true | false
state_id: "DE-001"
criteria:
  - item: ""
    result: pass | fail | unknown
blockers: []
recommended_action: ""
```

---

## 18. `WORK_ITEMS.md` 要求

模板应包含：

```markdown
# Design Work Items

> 本文件是导航索引。每个 Work Item 的 STATE.md 才是权威来源。

## Active

| ID | 标题 | 版本 | 阶段 | Gate | 状态文件 |
|---|---|---|---|---|---|

## Paused

| ID | 标题 | 版本 | 阶段 | 原因 | 状态文件 |
|---|---|---|---|---|---|

## Completed

| ID | 标题 | 版本 | 完成时间 | 后继 | 状态文件 |
|---|---|---|---|---|---|

## Cancelled

| ID | 标题 | 取消时间 | 状态文件 |
|---|---|---|---|
```

索引更新规则：

- 每次创建、暂停、恢复、完成、取消后更新；
- 更新前重新读取文件，尽量减少覆盖；
- 状态文件优先于索引；
- v0.1 不解决真正并发写锁。

---

## 19. 示例：idea-storm-lab

示例必须体现三个用户请求：

### 请求 1：检查项目上下文

预期：

```text
NO_STATE
```

理由：只读探索，没有独立验收任务。

### 请求 2：优化前端样式

预期：

```text
CREATE DE-001
```

示例状态应展示：

- 完整设计模式；
- 视觉方向获得批准；
- 原型获得批准；
- 实现和 QA 完成；
- 用户批准关闭；
- `status: completed`；
- `sealed: true`。

### 请求 3：统一内容模块问题长度换行

预期：

```text
SUCCESSOR DE-002
predecessor: DE-001
```

理由：它与前端样式优化相关，但 DE-001 已经封存，且新需求有独立验收标准。

DE-002 示例可以处于：

```yaml
status: active
phase: completion-review
gate: completion-approval
awaiting_user: true
sealed: false
```

以展示等待用户关闭的状态。

---

## 20. 人工评测场景

每个评测文件使用“前提 / 当 / 则”格式。

### 20.1 上下文检查

- 前提：项目没有活动状态；
- 当：用户要求“检查项目上下文，不要修改文件”；
- 则：返回 `NO_STATE`，不创建目录。

### 20.2 Create

- 前提：没有相关 Work Item；
- 当：用户要求设计一个新的重要功能；
- 则：创建状态，进入适用阶段。

### 20.3 Resume Across Thread

- 前提：已有等待原型批准的 DE-001；
- 当：新 Thread 中用户说“继续上次前端样式任务，我批准原型”；
- 则：恢复 DE-001，记录批准，不创建新状态。

### 20.4 Successor

- 前提：DE-001 已 completed + sealed；
- 当：用户提出相关但独立的新优化；
- 则：创建 DE-002，引用 DE-001，不修改 DE-001。

### 20.5 Parallel Work Items

- 前提：DE-002 active；
- 当：用户开启另一项独立产品功能；
- 则：创建 DE-003；索引同时显示 DE-002 和 DE-003 active。

### 20.6 Ambiguous Binding

- 前提：存在两个语义相近的 active Work Item；
- 当：用户只说“继续之前的界面改动”；
- 则：返回 `AMBIGUOUS`，列出候选，不写状态。

### 20.7 Close and Seal

- 前提：实现和 QA 已完成；
- 当：Codex 进入 completion review，但用户尚未批准；
- 则：不得 completed。
- 当：用户明确回复“关闭”；
- 则：completed + sealed，索引移动到 Completed。

---

## 21. README 要求

`README.zh-CN.md` 必须包含：

1. 产品一句话介绍；
2. 它解决的问题；
3. 架构图；
4. Thread / Work Item / STATE / Gate 的区别；
5. 五种状态解析结果；
6. Human-in-the-loop 工作流；
7. 手动安装步骤；
8. 项目初始化步骤；
9. 一个从 CREATE 到 seal 的完整示例；
10. 如何跨 Thread 恢复；
11. 如何处理并行任务；
12. 如何处理封存任务的后续需求；
13. 当前限制；
14. v0.1 路线图；
15. 官方 Codex 机制参考。

`README.md` 提供英文版核心说明，可以略短，但不得只放一句跳转链接。

---

## 22. 手动安装说明

v0.1 只提供手动方式。

README 应指导用户：

1. 将：

```text
skills/design-engineering/
```

复制到：

```text
~/.agents/skills/design-engineering/
```

2. 将：

```text
agents/design-state-steward.toml
```

复制到目标项目：

```text
.codex/agents/design-state-steward.toml
```

3. 将 `templates/project/AGENTS.fragment.md` 合并进项目根目录 `AGENTS.md`，不得要求覆盖用户已有内容；

4. 将项目模板中的 `docs/design/` 复制到目标项目；

5. 开启新的 Codex 会话验证 Skill、Agent 和项目指令；

6. 提供只读验证 Prompt。

---

## 23. 平台约束

实现时必须遵守当前 Codex 官方机制：

- Skill 是包含必需 `SKILL.md`、可选 `scripts/`、`references/`、`assets/` 和 `agents/openai.yaml` 的目录；
- 用户级 Skill 路径为 `$HOME/.agents/skills`，项目级 Skill 路径为项目中的 `.agents/skills`；
- `agents/openai.yaml` 用于展示、调用策略和工具依赖，不是自定义 subagent 文件；
- 自定义 Agent 使用独立 TOML，位于 `~/.codex/agents/` 或项目 `.codex/agents/`；
- 自定义 Agent 必须定义 `name`、`description` 和 `developer_instructions`；
- Codex 只有在父流程显式要求时才会 spawn subagent，因此 `SKILL.md` 必须明确写出调用步骤；
- `AGENTS.md` 在每次 Codex run 开始时按全局和项目层级加载；
- 项目模板不应覆盖用户已有 `AGENTS.md`。

官方参考：

- Agent Skills: https://developers.openai.com/codex/skills
- Subagents: https://developers.openai.com/codex/subagents
- AGENTS.md: https://developers.openai.com/codex/guides/agents-md

---

## 24. 实现约束

Codex 创建仓库时必须遵守：

1. 不实现 v0.1 非目标；
2. 不添加 npm、Python 或其他运行时依赖；
3. 不创建空洞的大量占位文档；
4. 所有示例必须内部一致；
5. YAML、TOML 和 Markdown 必须语法正确；
6. 中文文档自然清楚，不机械翻译；
7. 英文标识符保持稳定一致；
8. 不虚构 Codex 不支持的配置字段；
9. 第三方 Skill 仅写为可选增强，不复制其内容；
10. 不把 `STATE.md` 写成完整聊天日志；
11. 不允许 sealed 状态在示例中被重新激活；
12. 所有 Gate 示例都必须先写状态，再停止等待用户；
13. `WORK_ITEMS.md` 明确标注为索引而非权威来源；
14. 仓库自身的 `AGENTS.md` 要求后续修改保持 PRD、Skill、Agent、模板和示例一致。

---

## 25. 交付物

v0.1 交付必须包含：

- 完整仓库结构；
- 中英文 README；
- `design-engineering/SKILL.md`；
- `design-engineering/agents/openai.yaml`；
- 四份核心 reference 文档；
- `STATE.template.md`；
- `WORK_ITEMS.template.md`；
- 项目 `AGENTS.fragment.md`；
- `design-state-steward.toml`；
- idea-storm-lab 完整示例；
- 七个人工评测场景；
- 架构说明；
- 手动测试指南；
- MIT 许可证；
- `CHANGELOG.md`；
- 仓库自身 `AGENTS.md`。

---

## 26. Definition of Done

只有全部满足才能认为 v0.1 完成：

### 文档

- [ ] 新用户能独立理解核心概念；
- [ ] 中英文 README 与实际文件结构一致；
- [ ] 所有相对链接有效；
- [ ] 没有把 Thread 与 Work Item 混同；
- [ ] 明确解释 sealed 状态只读但可引用。

### Skill

- [ ] `SKILL.md` frontmatter 有效；
- [ ] 能区分 full / lightweight / delegated；
- [ ] 明确要求显式调用 Steward；
- [ ] 各 Gate 有停止条件；
- [ ] 关闭前必须展示证据并等待用户。

### Agent

- [ ] TOML 包含全部必需字段；
- [ ] 职责窄且不实现业务代码；
- [ ] 只返回五种状态解析结果；
- [ ] 不修改 sealed 状态；
- [ ] `AMBIGUOUS` 时不写文件；
- [ ] closure readiness 与 seal 分为两个步骤。

### 状态模型

- [ ] 模板包含 schema version；
- [ ] 状态、阶段和 Gate 枚举一致；
- [ ] 当前事实、批准决定、待确认项和证据齐全；
- [ ] 示例状态与索引一致；
- [ ] successor 关系明确。

### 示例与评测

- [ ] “检查项目上下文”不创建状态；
- [ ] “优化前端样式”创建并封存 DE-001；
- [ ] “统一内容模块问题长度换行”创建 DE-002 successor；
- [ ] 跨 Thread 恢复场景不创建重复状态；
- [ ] 并行任务场景保留多个 active Work Item；
- [ ] ambiguous 场景停止等待用户；
- [ ] completion 场景没有用户批准时不会封存。

### 范围控制

- [ ] 没有安装器；
- [ ] 没有 Plugin；
- [ ] 没有 Hook；
- [ ] 没有 CLI；
- [ ] 没有状态管理脚本；
- [ ] 没有外部运行时依赖。

---

## 27. 实施顺序

建议 Codex 按以下顺序实施：

### Milestone 1：骨架与术语

- 建立目录；
- 写仓库 `AGENTS.md`；
- 写中英文 README 骨架；
- 写 architecture 和术语。

### Milestone 2：核心状态模型

- 完成 `STATE.template.md`；
- 完成 `WORK_ITEMS.template.md`；
- 完成 state lifecycle 和 resolution 文档。

### Milestone 3：Skill 与 Agent

- 完成 `SKILL.md`；
- 完成 `openai.yaml`；
- 完成 `design-state-steward.toml`；
- 交叉检查职责与枚举一致性。

### Milestone 4：示例与评测

- 完成 idea-storm-lab 示例；
- 完成七个“前提 / 当 / 则”场景；
- 验证索引、状态和 successor 关系。

### Milestone 5：使用与验收

- 完成手动安装说明；
- 完成手动测试指南；
- 检查 Markdown 链接、YAML、TOML；
- 对照 Definition of Done 自检；
- 输出最终实现摘要和已知限制。

---

## 28. 后续路线图（不在 v0.1 实现）

### v0.2

- 确定性 `statectl`；
- Schema 校验；
- 自动生成索引；
- 状态迁移；
- 更可靠的并发冲突检测。

### v0.3

- 安装与初始化命令；
- `doctor` 检查；
- 受管 `AGENTS.md` 区块；
- 自动升级与卸载。

### v0.4

- Codex Plugin；
- Marketplace 分发；
- 可选 Hook；
- 可选 Playwright MCP 依赖。

### Future

- Release 级编排；
- GitHub Issue 映射；
- 多人审批；
- 可视化 Work Item 面板；
- 任务与对话的自动关联；
- 设计决策知识图谱。

---

## 29. 最终产品定义

Codex Design Harness v0.1 不是一个自动化平台，而是一份能够在真实项目中运行的、可版本控制的产品开发协议：

```text
Thread 是工作现场
Work Item 是任务身份
STATE.md 是权威状态快照
Gate 是人的控制点
Skill 是流程编排器
Steward 是状态管理员
用户拥有最终关闭权
```

它的第一版价值，不在于拥有最多功能，而在于证明以下闭环真实成立：

```text
创建或恢复正确任务
→ 跨对话保持一致
→ 在高成本实现前获得批准
→ 记录关键产品决定
→ 用证据请求完成确认
→ 封存历史
→ 用 Successor 开启下一次迭代
```
