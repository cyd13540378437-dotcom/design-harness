# 架构说明

Codex Design Harness 是一层面向 Codex 设计工作的轻量协议。它刻意由文本文件组成，让用户可以手动安装、检查和调整。

```text
仓库规则
  AGENTS.md
        ↓
Skill
  skills/design-engineering/SKILL.md
        ↓
展示与调用元数据
  skills/design-engineering/agents/openai.yaml
        ↓
状态 Steward
  agents/design-state-steward.toml
        ↓
项目状态
  docs/design/WORK_ITEMS.md
  docs/design/work-items/<state-id-slug>/STATE.md
```

## 职责

`AGENTS.md` 给出项目级不变量：术语、枚举、sealed 状态规则和范围限制。

`design-engineering` 是流程编排器。它判断适用的设计模式，要求父级 Codex 会话调用 Steward，在 Human Gate 停止，并且只有在状态更新后才继续实现。

`design_state_steward` 是状态管理员。它解析 Work Item 绑定，创建或更新 `STATE.md`，更新 `WORK_ITEMS.md`，准备 Gate 检查点，记录用户批准，检查关闭准备情况，并且只在用户明确批准后封存。

`STATE.md` 是权威 Work Item 快照。它是有损压缩，只保留当前事实、已批准决定、待确认问题、证据和下一步行动，不保存完整对话。

`WORK_ITEMS.md` 是导航索引。它便于浏览项目状态，但不是权威来源。

## 状态流

```text
active
  ├─ paused ──→ active
  ├─ active + awaiting_user
  ├─ completion-review
  │    ├─ 继续 ──→ active
  │    ├─ 暂停 ──→ paused
  │    └─ 关闭 ──→ completed + sealed
  └─ 取消 ──→ cancelled + sealed
```

已完成并 sealed 的状态对后续实现不可变。新的相关工作应创建 successor。

## 为什么需要独立 Steward Agent

Steward 边界把实现和状态写入分开：

- 父级 Agent 负责产品工作和代码实现。
- Steward 负责写入状态、Gate、批准决定、证据和索引更新。
- 用户保留高影响决策和最终关闭权。

这种分工可以避免设计实现 Agent 静默改写历史，或自行批准自己的关闭。

## 安装形态

源仓库中的 Steward 位于 [agents/design-state-steward.toml](../agents/design-state-steward.toml)。用户将它复制到业务项目：

```text
.codex/agents/design-state-steward.toml
```

源仓库中的 Skill 位于 [skills/design-engineering](../skills/design-engineering/)。用户将它复制到：

```text
~/.agents/skills/design-engineering/
```

项目模板位于 [templates/project](../templates/project/)。

