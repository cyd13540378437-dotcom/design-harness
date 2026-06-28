# 08 Visual Seed, Reference, and Palette

## 前提

- 项目没有相关 active Work Item。
- 用户要优化一个重要页面视觉。
- 用户提供一句粗略视觉方向和两张参考图片，或把参考图片放入 `docs/design/reference-images/`。

## 当

用户请求：

```text
这个页面想要更像创作者工具，干净但不要普通后台。我放了两张参考图，帮我优化前端视觉。
```

Codex 使用 `$design-engineering` 并进入 Full Mode。

## 则

- Steward 返回 `CREATE`，创建新的 Work Item。
- Codex 记录用户原始 Visual Seed。
- Codex 不要求用户填写产品人格、品牌气质矩阵或用户感受目标表单。
- Codex 解析参考图中的可观察视觉特征，并区分可借鉴与不应复制。
- Codex 输出至少 3 套候选调色盘，可以标注推荐方案，但不得只给 1 套。
- Codex 用同一个调色盘对比板展示候选方案，每套都包含同构小型 UI 样张。
- 每套候选说明主要文字、按钮文字、次级文字、边框和标签的可读性/对比情况。
- 在配色确认前，Steward 写入：

  ```yaml
  phase: visual-direction
  gate: visual-direction-approval
  awaiting_user: true
  ```

- `STATE.md` 正文写明：

  ```text
  视觉子步骤：palette-selection
  ```

- 用户可以选择 A/B/C，也可以直接输入自己的颜色偏好。
- 用户确认配色或输入自定义颜色后，Steward 记录用户原始颜色输入、已确认配色、候选对比摘要、最终配色来源和选择理由，Codex 才能继续设计禁区和视觉原型。
