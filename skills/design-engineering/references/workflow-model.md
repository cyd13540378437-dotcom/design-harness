# 工作流模型

Design Engineering 工作流包含状态解析、视觉流程、实现验证和关闭封存。

## 0. 状态解析

读取项目规则、设计状态索引、相关 `STATE.md` 和已有 `VISUAL_DESIGN.md`，然后显式调用 `design_state_steward`。Steward 必须返回且只能返回一个决定：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

如果决定是 `AMBIGUOUS`，停止并请用户选择，不写入状态。

## 1. 业务理解与 Visual Seed

澄清：

- 目标用户
- 主要用户任务
- 成功标准
- 业务约束
- 技术约束
- 未解决问题
- 用户原始 Visual Seed

Visual Seed 可以为空，不应强制归纳为产品人格。

## 2. 参考图片与解析

优先使用用户上传图片和项目 `docs/design/reference-images/`。若没有，读取已有 `VISUAL_DESIGN.md` 或使用内置 `visual-reference-packs/`。

解析只描述可观察视觉特征，并区分可借鉴与不应复制。

## 3. 配色确认

完整视觉设计前必须确认配色。每次 `palette-selection` 至少输出 3 套候选调色盘；可以标注推荐方案，但不得只输出 1 套让用户确认。

候选配色必须放在同一个调色盘对比板中，用同一组 UI 样张展示按钮、卡片、标签、导航、文字和状态效果。每套配色都应包含三级用户可理解结构：

- 主色
- 次色
- 末级强调色

每套候选还应说明主要文字、按钮文字、次级文字、边框和标签的可读性/对比情况，以及该方案的适用场景和风险。

用户可以选择候选调色盘，也可以直接输入自己的颜色偏好。若用户直接输入颜色，父级 Agent 应基于该输入调整最终配色，并由 Steward 记录用户原文、候选对比摘要、最终配色规格、是否从候选派生以及选择理由。

配色确认使用：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文写：

```text
视觉子步骤：palette-selection
```

## 4. 设计禁区确认

配色确认后生成 4-8 条设计禁区，帮助避免模板化方向。设计禁区确认仍使用 `visual-direction-approval`。

正文写：

```text
视觉子步骤：design-exclusions
```

不得新增 `palette-approval`、`design-exclusion-approval` 或 `anti-homogeneity` Gate。

## 5. 视觉原型

优先顺序：

1. 现有 Storybook
2. 隔离预览路由
3. 独立 HTML/CSS 原型
4. 只有在无法运行 UI 时才使用静态图

原型用于验证结构、层级、密度、组件形态、已确认配色、已确认设计禁区和响应式表现。

方案数量规则：

- 视觉输入清晰：1 个主方案。
- 参考冲突或用户不确定：2 个方案。
- 无参考图且未选择参考包：2-3 个方向。
- 不得只通过改颜色或圆角制造伪方案。

## 6. UX 流程与关键交互

检查入口、完成路径、返回/取消、加载、空状态、错误、权限、首次使用、网络失败、长内容、键盘、移动端、破坏性操作和成功状态。

只有高影响且未解决的行为才进入 `interaction-decision` Gate。

## 7. 生产实现

按照已批准决定实现。复用本地组件和令牌。不要创建平行设计系统，也不要静默偏离已批准方向。

## 8. 审查与验证

优先使用真实浏览器在桌面和移动尺寸下检查。如果无法完成浏览器验证，将限制写入 `STATE.md`，不要声称视觉 QA 已通过。

## 9. 视觉基线更新

视觉 Work Item 完成前创建或更新 `docs/design/VISUAL_DESIGN.md`，除非 `STATE.md` 明确说明无需更新。该文件只记录已确认视觉结果，不记录未批准方案。

## 10. 完成确认

进入：

```yaml
phase: completion-review
gate: completion-approval
awaiting_user: true
```

展示已完成内容、验收标准结果、证据、`VISUAL_DESIGN.md` 更新状态、限制，以及关闭、继续、暂停或拆分 successor 的建议。
