---
name: design-engineering
description: 对新产品界面、重要功能页面、跨页面用户流程和显著 UI/UX 改造执行人参与的设计工程工作流。负责识别或恢复 Work Item，经过视觉方向、原型、关键交互与完成确认 Gate，并在跨 Codex 对话中通过 STATE.md 恢复状态。
---

# Design Engineering

当用户请求涉及重要产品设计或 UI/UX 工程时使用本 Skill：新界面、重要功能页、跨页面流程、大范围视觉重构、视觉方向不明确，或需要用户批准的产品交互。

不要为了流程完整而创建无意义状态。只读检查、代码解释、临时研究和极小的安全非设计修改通常应解析为 `NO_STATE`。

## 核心规则

父级 Agent 在开始状态化设计工作前，必须显式调用 `design_state_steward`。父流程不得自行伪造或推断 Steward 的状态解析结果。

Steward 只负责状态。父级 Agent 继续负责产品推理、实现、验证和用户沟通。

## 模式

`full`：默认用于新页面、重要模块、跨页面流程、方向不明确或重要 UX 改动。执行所有适用 Gate。

`lightweight`：用于既有设计方向内的小范围 UI 修改。可以跳过视觉方向和原型 Gate，但状态化任务仍必须经过完成批准。

`delegated`：当用户明确要求 Codex 自行决定普通细节时使用。Codex 可以处理低影响视觉选择，但权限、删除、隐私、付费、不可逆行为、核心产品语义和最终封存仍必须询问用户。

## 必须执行的状态解析

状态化设计任务开始时：

1. 读取项目 `AGENTS.md`。
2. 读取现有 `docs/design/WORK_ITEMS.md`。
3. 读取语义相关的 active、paused 和 sealed `STATE.md`。
4. 显式调用 `design_state_steward`。
5. 只接受以下结果之一：

   ```text
   CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
   ```

6. 若结果为 `AMBIGUOUS`，请用户选择并停止。
7. 若结果为 `NO_STATE`，不创建设计状态，直接完成当前请求。

不得恢复 `completed + sealed` 状态。相关后续工作必须使用 `SUCCESSOR`。

## Gate 协议

每个 Gate 前，先让 `design_state_steward` 写入检查点：当前 phase、gate、`awaiting_user: true`、简洁上下文、可选方案和下一步行动。

用户回复 Gate 后，先让 `design_state_steward` 记录批准、拒绝、修改要求、暂停或 successor 指令，再继续工作。

如果 Steward 结果与用户当前明确回复冲突，以用户当前回复为准，并相应更新状态。

不得让多个 Agent 同时写同一个 `STATE.md`。

## Full 工作流

### 0. 状态解析

将当前请求解析为 `CREATE`、`RESUME`、`SUCCESSOR`、`NO_STATE` 或 `AMBIGUOUS`。

### 1. 业务理解与视觉方向

总结：

- 目标用户
- 核心任务
- 成功标准
- 业务约束
- 技术约束
- 未解决问题

Full Mode 下给出两到三个明显不同的视觉方向，并给出推荐。

Gate：`visual-direction-approval`

在用户明确选择、组合、拒绝或授权前停止。

### 2. 静态原型

优先使用现有 Storybook，其次是隔离预览路由，再其次是独立 HTML/CSS 原型；只有无法运行 UI 时才使用静态图。

展示原型入口或截图、需要检查的重点、尚未实现的内容和已知风险。

Gate：`prototype-approval`

在用户明确批准或要求修改前停止。

### 3. UX 流程与关键交互

检查入口与完成路径、返回与取消、加载、空状态、错误、权限、首次使用、网络失败、长内容、键盘、移动端、破坏性操作和成功反馈。

Gate：`interaction-decision`

只有未解决交互会显著改变产品行为时才使用此 Gate。

### 4. 生产实现

按照已批准状态和原型实现。复用本地组件和设计令牌。不要创建平行设计系统，也不要静默偏离已批准方向。

若出现新的高影响歧义，返回对应 Gate。

### 5. 审查与验证

优先使用真实浏览器在桌面和移动尺寸下验证。将证据记录到 `STATE.md`。如果无法完成真实浏览器验证，记录为 blocker 或剩余风险；不得声称视觉 QA 已通过。

第三方 UI 或浏览器 Skill 可作为可选增强；缺失时不得阻塞核心流程。

### 6. 完成确认

关闭前，先请 `design_state_steward` 检查 closure readiness。

若已准备好，进入：

```yaml
phase: completion-review
gate: completion-approval
awaiting_user: true
```

向用户展示：

- 已完成内容
- 验收标准结果
- 验证证据
- 剩余限制
- 建议关闭、继续、暂停或创建 successor

Gate：`completion-approval`

只有用户明确批准关闭后，`design_state_steward` 才能封存状态。

## 参考

- [workflow-model.md](references/workflow-model.md)
- [human-in-the-loop.md](references/human-in-the-loop.md)
- [state-lifecycle.md](references/state-lifecycle.md)
- [state-resolution.md](references/state-resolution.md)

