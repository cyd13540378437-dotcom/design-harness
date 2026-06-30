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
项目视觉参考库
  docs/design/reference-library/
        ↓
项目状态
  docs/design/WORK_ITEMS.md
  docs/design/work-items/<state-id-slug>/STATE.md
  docs/design/work-items/<state-id-slug>/REFERENCE_SELECTION.md
        ↓
项目视觉基线
  docs/design/VISUAL_DESIGN.md
```

## 职责

`AGENTS.md` 给出项目级不变量：术语、枚举、sealed 状态规则、视觉子检查点和范围限制。

`design-engineering` 是流程编排器。它判断适用的设计模式，要求父级 Codex 会话调用 Steward，在 Human Gate 停止，并且只有在状态更新后才继续实现。它负责 Visual Seed、Surface Resolution、参考库检索、参考图解析、配色样张、设计禁区、视觉原型、实现和验证。

`design_state_steward` 是状态管理员。它解析 Work Item 绑定，创建或更新 `STATE.md`，更新 `WORK_ITEMS.md`，准备 Gate 和视觉子检查点，记录用户批准，检查关闭准备情况，并且只在用户明确批准后封存。它可以记录目标终端、Reference Selection 链接和摘要，但不负责挑选参考或设计页面。

`STATE.md` 是权威 Work Item 快照。它是有损压缩，只保留当前事实、已批准决定、视觉上下文、待确认问题、证据和下一步行动，不保存完整对话。

`reference-library/` 是项目级长期视觉参考资料层。它保存产品参考、设计模式、截图目录、色卡预留区和 schema，不保存某个 Work Item 的专属选择。

`REFERENCE_SELECTION.md` 是 Work Item 级消费结果。它记录本任务如何筛选、采用和排除参考；`STATE.md` 只链接它并保留摘要。

`WORK_ITEMS.md` 是导航索引。它便于浏览项目状态，但不是权威来源。

`VISUAL_DESIGN.md` 是项目级视觉基线。它只记录已确认视觉结果，不替代 `STATE.md`，后续 Work Item 必须先读取它。

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

## 视觉子检查点

配色确认和设计禁区确认都属于：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

它们在 `STATE.md` 正文中分别记录为：

```text
palette-selection
design-exclusions
```

它们不是新的 Gate enum。

## Reference Library 流

视觉方向前先做 Surface Resolution：

```yaml
primary_surface: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
secondary_surfaces: []
explicitly_out_of_scope: []
evidence: []
open_questions: []
```

若项目存在 `docs/design/reference-library/`，父级 Agent 按同终端、同页面类型、同任务类型、相近密度和复杂度等条件筛选参考，并把本任务选择写入 `docs/design/work-items/<state-id-slug>/REFERENCE_SELECTION.md`。

用户看到的方向应是业务语义和取舍，例如“效率工作台”“引导式助手”“内容探索”，而不是必须理解具体产品名。跨终端参考只能用于抽象模式，不能直接复制布局、导航、手势、密度或视觉比例。

## 为什么需要独立 Steward Agent

Steward 边界把实现和状态写入分开：

- 父级 Agent 负责产品工作、视觉分析和代码实现。
- Steward 负责写入状态、Gate、批准决定、证据、视觉基线更新状态和索引。
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
